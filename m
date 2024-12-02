Return-Path: <linux-kernel+bounces-427488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3C9E0205
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168981687D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DE20101A;
	Mon,  2 Dec 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8DW5bN6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A213200B99
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141545; cv=none; b=RFzCYuetIYs0jmL3hUqnOXfYJz+HF8gFmTpzhxZ3m13XJ2A7lkr7qc2Xc9QmZqhGzGC7PdfTAH7hdAHIyuWBCs2rIZP0+Mfj8HcQDykYtmwrCO4g36Itf77rRtZADE7ltdUMGOyirgigVSAgdVSYW/VWWqfuSrwxOMmwR4nsNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141545; c=relaxed/simple;
	bh=BAsvATPPwiRNshFbfMSazAQL2k/Uitt2kSkENPu+FCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhaafNwYUdGwm5ibic9pfBKQgNbUhnShjGA0IHopijpN7cU2VqthF0BtDjO0n6fhFlCdemhl4cXzxLxEfk3Rmf9bYwOPNpYEvft+fDBNBhFRGnHTC2/rJsYTV1n/ohB33Sk/MmIAbdEjXBxzTGjl4gwRUWgkHwdBCZpfGSP2xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8DW5bN6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349ea54db7so217455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733141542; x=1733746342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3OJxeC05OEpKJXaqS/T7FWlvK5y/yJmdvmfj+hUxqc=;
        b=n8DW5bN6NqMlVhO8zbtbxw3QOdpWQncLcUK+ehN1kn4nAWXS75oNyklVfHqpZ5rOKR
         xef+FTZogYJibSY43vPE1jpmdck9nLHNMyrhTtxr+V0QawnGrZUqVZAycvUEMsNy/vz/
         FgN/hu2gDkG7IUA7iPrMjXG94GQszV+t3tMXC/lzv7Fj7ub4DEmqbrlivsUb+DEUof1b
         aHVEr+DJ95MxOU3rbUju2zO57auYPU2Q8Md8bFK9etCq1UQj8ALXbigPshjEtgZzckXH
         HFJmPdf7Uv4lOo9n9fWTNILc/FIHB9N7zLv7eq/UL9H0o9AS0Oa32I8rf5W9D7nXa5rQ
         iLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141542; x=1733746342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3OJxeC05OEpKJXaqS/T7FWlvK5y/yJmdvmfj+hUxqc=;
        b=d9kxwMRo4rJMUL9nLUfwjkbpU927rwmDyo8Agds1BkEaC/cPdaK9Xzb+ICVNMVutoy
         caHy0N2vmUoMqlByoREJXl7r0df+nQX44dHSrmrbzdHI54YlGn5dWae1NSPtPafT8Kyw
         DZ8DldjVolX7rwFty23/bftDuAk0XjQpW3lr8Kj9giJicZtQvyyfWIBci7MHUerT1VZ3
         sZfvCQWYY0HSTdATouq15b7KZsiW6NlY92YuLzRJZuzup57mhuGcz4HPLumEpvyvqvqH
         N0tRVPS5j8DRiOnk3yR9arvgvNxVO8juSbUYnfX/rEcPj2DQZ21jBgIvZbXopN2PM+SP
         VylQ==
X-Gm-Message-State: AOJu0YwlVK2qxFYC8SRiBRADT7Uwj9oo8N/I5uNO6wTnqz1WektiNiov
	uneNMJGJ8bxcD0vOiAcQjm2ft+0yzIGERyscZ+p+4bH7c+YK2/b72h1lnQYMkA==
X-Gm-Gg: ASbGncsJOuvc6Gt6YkVVVrYoSxCV6s9AoAJdBHFEQ+vhgG3lD1w8fQCPK2qUYlCZ7YN
	wBNkNTZVBahQUPeNmk+9BSDd3HbII/mQEqKgpEaOb67HrAbswtWk9u+CWjoUWXUSjo0/s58wQ1I
	YstWhrpfmGoUjcGKVB8SRP3u7I7QubjYfFqkP6WxFQtoBUqIcrur5JxfzUlCY2B8hQnPIRftFUb
	ndnpla2dpBq5HBhc3UDAS8XjOe8Vp/zfOUouah5/FUuO5VYhnGUADWnr8DZplzgyp03Yu67be3s
	YKUoWniIaF1p
X-Google-Smtp-Source: AGHT+IFWgNWQtw5nySaRT0MW3AbORF9BjBCT5+v/BU5F99S0LZr6LNKr+wPuDHwta/Ys4y0RVWD2ww==
X-Received: by 2002:a05:600c:2253:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-434b0577f32mr4477205e9.4.1733141542168;
        Mon, 02 Dec 2024 04:12:22 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385deeb6acdsm9806424f8f.81.2024.12.02.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:12:21 -0800 (PST)
Date: Mon, 2 Dec 2024 12:12:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
Message-ID: <Z02kIaxP96am-P2f@google.com>
References: <20241024162516.2005652-1-smostafa@google.com>
 <20241024162516.2005652-2-smostafa@google.com>
 <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>

Hi Daniel,

On Sat, Nov 30, 2024 at 08:20:10PM -0800, Daniel Mentz wrote:
> On Thu, Oct 24, 2024 at 9:26 AM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > When calculating the max number of entries in a table, Where
> > RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
> > an index spanning more than one concatenated table (for ex for 4K
> > page size > 512).
> > But then, max_entries is calculated as follows:
> > max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
> >
> > This leads to a negative index in the page table, where for:
> > - map: do nothing (no OOB) as fortunately all comparisons are signed,
> >   but it would return a negative mapped value.
> >
> > - unmap: it would leak any child tables as it skips the loop over
> >   “__arm_lpae_free_pgtable”
> >
> > This bug only happens when map/unmap is requested with a page size
> > equals to the first level of the concatenated table (for 40 bits input
> > and 4K granule would be 1GB) and can be triggered from userspace with
> > VFIO, by choosing a VM IPA in a concatenated table > 0 and using
> > huge pages to mmap with the first level size.
> >
> > For example, I was able to reproduce it with the following command
> > with mainline linux and mainline kvmtool:
> >
> > ./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --force-pci -c \
> > `nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hugepages
> >
> > Where huge pages with 1GB would be used and using IPA in the second table
> > (512GB for 40 bits SMMU and 4K granule).
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 0e67f1721a3d..3ecbc024e440 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
> >         return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
> >  }
> >
> > +/*
> > + * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
> > + * concatenated PGD concatenated, get the max entries of a that table.
> 
> I believe the macro that returns an index is called ARM_LPAE_LVL_IDX
> not ARM_LPAE_PGD_IDX.
> 

Yes, the comment is not quite accurate, although ARM_LPAE_PGD_IDX()
calls ARM_LPAE_PGD_IDX() which is the problem.

Thanks,
Mostafa

> > + */
> > +static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
> > +{
> > +       int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
> > +
> > +       return ptes_per_table - (i & (ptes_per_table - 1));
> > +}
> > +
> >  static bool selftest_running = false;
> >
> >  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> > @@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> >
> >         /* If we can install a leaf entry at this level, then do so */
> >         if (size == block_size) {
> > -               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
> > +               max_entries = arm_lpae_max_entries(map_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >                 ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
> >                 if (!ret)
> > @@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
> >
> >         if (size == split_sz) {
> >                 unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> > -               max_entries = ptes_per_table - unmap_idx_start;
> > +               max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >         }
> >
> > @@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> >
> >         /* If the size matches this level, we're in the right place */
> >         if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> > -               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> > +               max_entries = arm_lpae_max_entries(unmap_idx_start, data);
> >                 num_entries = min_t(int, pgcount, max_entries);
> >
> >                 /* Find and handle non-leaf entries */
> > --
> > 2.47.0.105.g07ac214952-goog
> >
> >

