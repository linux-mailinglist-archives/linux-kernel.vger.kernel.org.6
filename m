Return-Path: <linux-kernel+bounces-217597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52990B1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F364294A99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E681B012B;
	Mon, 17 Jun 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XD3TGtUq"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6D19B3D0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631829; cv=none; b=MItR8lQRAdo9K528K61jbCxgYN4xe0MijPcd01ExPC//+6sr5ndTKRFqQH7MP8+raPVN8u5DQ1XVEL9Dq+I1uL4H3wO8yXMH5KhupgO9mriMTIUu8NyYqK1h7z3l2kBQbxQAZxeyBvyqEl4/BccMMH/ONmnN9hLeB7cuQpTEMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631829; c=relaxed/simple;
	bh=g2+vx2tkomM5KV01/sRMWBdQvKX1Pl22D91eUMwYl7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsiJhWR9ycWwsvbJ5YTjFy51uK9x2hAWu5qkroTOTL8AWkrjGGggvk23CGma5PpIl3XeJqxlVt1O0aZBd8f6NL1k5TOa0pQsMkU/o0gkAo6nG6VxTpO2JwvCUpSIi88154qftFccR7SwPys0qhfoKvrOn5tuC2J7e7lIhmWYPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XD3TGtUq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eb7bf1357cso175752739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718631827; x=1719236627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGKpj5AvHTsEbrLmF9bNmz/D9P/h+ZMX1niQukt3LXM=;
        b=XD3TGtUq4sF/bt3MW82nKGXR0x7mehLAU0DORNW6nLY89FRzPmV64usRNHxMcLUwUK
         uTov8Xn/w0yccWTDxr2mVeYtOEORcurYPDkxmmZyKdvPp0XFtwMYBCcOqw4FcrEzElzF
         GYLP+4f1cGIhj+VoI+/jSJksOZqqlLbSjbO17Fm+Lb58nPZu4nnE1I3E2lhb0uBkQHVg
         WI8uYnGwgOmwfqCFzhbnG8OmOS84eQPmp+r2VWhZPLgZzrcNy0TuaEml/7j6O3/ZHdlz
         97dtwwu5aAVrcUyOraBnX4kLrgXxt8f60YI9tNIbO1oV+EwGFcSv5OpeKAzQSj6EtagI
         Ycmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631827; x=1719236627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGKpj5AvHTsEbrLmF9bNmz/D9P/h+ZMX1niQukt3LXM=;
        b=m6/8HB3U17Yja22zH+CrnkjguYg9uRo4Bjw5s9PpVJVQVGquhS3SEox8YRkw2POMY9
         kX0L3+gmXw3E42OLozM0iomIi7yqivOEtIyNQN7ete3qmxlQxdRqkOPSbNG+ZF2+8+Uo
         G+vNouFZOJdN4IT1jZ8lkK10Zzu9vTC7SI3tUThQgm30kTpcNEogGbSj4V/CLnYBoHvl
         8wNwxzxpHd8hVeWSS5cjaiOCET3YynvJP6DE81L1ASrKIH9YWvKmGpuXaptVIhNXQWr4
         RQ6kPlVE7y+jYgTobJRZAWH379fHiAcG7+ltqCYQP40k5sTLN9NtyNgWqq96LlsxSaVn
         UidA==
X-Forwarded-Encrypted: i=1; AJvYcCUHqyCgVletFh0BU+OC+7zfIar72ggJdaC3QIfTTwcHyUTYQz7f+BqcD89NArvQIo4iz941NyRtu8h2DASPWoVHzFZJJqNNWuLvQOBz
X-Gm-Message-State: AOJu0Yyk5YFrZuFbgqwj9ZLCYvD+Nmx2eXPfeTSCiElcotmeCa89xPDL
	Th4aI4D7LFC7OcUT2ZRK7y9msCFcU58MqyKGNRsPGhjoBAVQZqwucMq/oKpgBDDg2XSFajkf7iU
	V1jSP7KjnTcdxaFFs/l4Uq5Y6txqa7eygX//0Tw==
X-Google-Smtp-Source: AGHT+IG/B3WypjhzIUOJZbLMxyurBmwQdjlcHydZzcumzgrC9Dze6gAT7/km/QnYVaq8ae6CKJ08zdbpc3jZxjOCGIk=
X-Received: by 2002:a05:6602:1503:b0:7eb:78b4:faee with SMTP id
 ca18e2360f4ac-7ebeb4909cbmr1147213239f.3.1718631826563; Mon, 17 Jun 2024
 06:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
In-Reply-To: <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 21:43:35 +0800
Message-ID: <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:17=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 6/14/24 10:21 PM, Zong Li wrote:
> > Add iotlb_sync_map operation for flush IOTLB. Software must
> > flush the IOTLB after each page table.
> >
> > Signed-off-by: Zong Li<zong.li@sifive.com>
> > ---
> >   drivers/iommu/riscv/Makefile |  1 +
> >   drivers/iommu/riscv/iommu.c  | 11 +++++++++++
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefil=
e
> > index d36625a1fd08..f02ce6ebfbd0 100644
> > --- a/drivers/iommu/riscv/Makefile
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o iommu-pmu.o
> >   obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> > +obj-$(CONFIG_SIFIVE_IOMMU) +=3D iommu-sifive.o
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 9aeb4b20c145..df7aeb2571ae 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1115,6 +1115,16 @@ static void riscv_iommu_iotlb_sync(struct iommu_=
domain *iommu_domain,
> >       riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
> >   }
> >
> > +static int riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domai=
n,
> > +                                   unsigned long iova, size_t size)
> > +{
> > +     struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> > +
> > +     riscv_iommu_iotlb_inval(domain, iova, iova + size - 1);
>
> Does the RISC-V IOMMU architecture always cache the non-present or
> erroneous translation entries? If so, can you please provide more
> context in the commit message?
>
> If not, why do you want to flush the cache when building a new
> translation?
>

It seems to me that we can indeed remove this operation, because it
may be too aggressive given the following situation.

I added it for updating the MSI mapping when we change the irq
affinity of a pass-through device to another vCPU. The RISC-V IOMMU
spec allows MSI translation to go through the MSI flat table, MRIF, or
the normal page table. In the case of the normal page table, the MSI
mapping is created in the second-stage page table, mapping the GPA of
the guest's supervisor interrupt file to the HPA of host's guest
interrupt file. This MSI mapping needs to be updated when the HPA of
host's guest interrupt file is changed.

I think we can invalidate the cache after updating the MSI mapping,
rather than adding the iotlb_sync_map() operation for every mapping
created. Does it also make sense to you? If so, I will remove it in
the next version. Thanks.

> Best regards,
> baolu

