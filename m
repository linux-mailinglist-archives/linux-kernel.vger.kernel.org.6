Return-Path: <linux-kernel+bounces-193676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900008D3063
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4154D28B96C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1F16A376;
	Wed, 29 May 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gDwXsuX/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FE16A367
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969779; cv=none; b=iJg0YLF+Z958nFnKS6zgmQbttppgZu/faceUySIgC4l0Kp963rDZEQzlN4XeVI5gDpqwUtwBPlmVaaK4qyxFi0FvUVKENU38aSqkVs32vmBGj6OObFaYNvYCzl0/8fMORaIHhJ6Z+KSSsCnseP5nvReU/dAVT7EybMUmQ61ldy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969779; c=relaxed/simple;
	bh=5f0sXd+T/HauA5lUyggecHmBZ/E4crjpkNtqLO7tEHk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhrTliJ4xjWzVGlJHAyFehpBtJ/Sst6qT0cHInrHYLX48Hzl6/ihTdxPA5GAcRSPOVxsa25cOBvAg1U3hk5/BaEf6vk0QDaX3bsvqV+TsLFdxWPg9LpEkrRskJf5bD7Dq6S3eCQrPvDI5XAsMNXK8Hms3faEsOEwXOxzSNIW39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gDwXsuX/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354de3c5c61so1451606f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716969774; x=1717574574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXNn4brV8l1cKgDS0zwRf7wcdauWIB3ooZqqAlvwD7I=;
        b=gDwXsuX/PyKlVkBICqnR90xJmvpvI47KTdIfz2kokh7+lUuDukACKzIOUbKSu/HcpQ
         LzjJp3Be8G/DWTXsFbL0UnYgaO7fUPVvFlwIcRKAyr3cHKEGR0yt3HlAzpFCtXg6+NP8
         ZG1bUh5vc6SfE2iTf+MrL5dEv6WXb64c5SVWE3Qw/szifZvxoDDduhkZn3YREOwmRNh7
         khzhF2/kV5yP+CtbanHz/L03peASA8FWcncAP64yM7eNXs+y1XZdX7w1GgFubE0Ug3VS
         t3nN4+Hz1rUx7dk5e+w+4aaingpwYhHPgvm2dXbYOhGULOtirX4UKnyFOTWaF6z0Ub8z
         5J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969774; x=1717574574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXNn4brV8l1cKgDS0zwRf7wcdauWIB3ooZqqAlvwD7I=;
        b=W1Hy2AAY9enfcyRAhhXX12+y6ufuzZZxsAIte+wq9xPFRrLqXrxhSpfjN+Yn7TL0i4
         d7ADS+tbI9co7KVnPUcN0h8cdGLoGg7QMNHXCs69f8kdVH+ZCwjNHBnPMIByjpP0cYIM
         /OEoVGaesWpwSsqIUszzjWfy+px9Y0VXp0uwS2j/LsWFa4w98ddhuJFtTi0jlzkkpYRp
         rN5nsNDPv5+wMxBU3JhALk+tnJpFAypMDpasW8It3/jZv3MR5TXS6W5Qi1ZtqhemlVXj
         VzpBsPsKgTYRsNuhESVLUIMLlHDIfsKNvWDituvylWHfSJ71Iu//mIlofqeipNaDiuCX
         G7hA==
X-Forwarded-Encrypted: i=1; AJvYcCX14lREHk2lYPulEo6nxbNtmZs6Axla2B2aj443+bwMyCw/e0EpKFkOjxosJBZXtnYVUAkGdaiJgztHn2zZGWF71KV3awQQgTJLUKbr
X-Gm-Message-State: AOJu0Yxj84MlLPFGbSy8/vqYxErLPa0icso/9PHqSoa3kgUnCUsxGGrd
	g3Vivsa0xIKcPJMOGKXYmC8TAh1JHryzZP/p8ixGbjPfkyMMsZehINHpkzSyQDU=
X-Google-Smtp-Source: AGHT+IGHtnpYsPo68r8KO+o5cak6O4GpcpzRjyYOkzKRLlpb/rBAfxulIRtpV3zXqfuo4S13urHc6g==
X-Received: by 2002:a5d:6042:0:b0:354:f371:de64 with SMTP id ffacd0b85a97d-35526c5a10emr10971727f8f.31.1716969774592;
        Wed, 29 May 2024 01:02:54 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c93c6sm14009154f8f.85.2024.05.29.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:02:54 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 10:02:52 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 08/16] powerpc/8xx: Rework support for 8M pages
 using contiguous PTE entries
Message-ID: <ZlbhLJF5w59BQIoK@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <c592d725af6c1a3b81090fd8b25676612430b24d.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c592d725af6c1a3b81090fd8b25676612430b24d.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:06PM +0200, Christophe Leroy wrote:
> In order to fit better with standard Linux page tables layout, add
> support for 8M pages using contiguous PTE entries in a standard
> page table. Page tables will then be populated with 1024 similar
> entries and two PMD entries will point to that page table.
> 
> The PMD entries also get a flag to tell it is addressing an 8M page,
> this is required for the HW tablewalk assistance.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
..  
> +#define __HAVE_ARCH_HUGE_PTEP_GET
> +static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> +{
> +	if (ptep_is_8m_pmdp(mm, addr, ptep))
> +		ptep = pte_offset_kernel((pmd_t *)ptep, 0);

Yes, you are right that this should have had the addr aligned down.

I can speak for others, but for me it is more clear to think of it this way:

1) check if ptep points to the first PMD entry for address
2) if it does, we know that the PMD describes a 8MB hugepage
3) return the PMD

That is why I thought that directly calling pmd_page_vaddr() gave a more clear
overview.

Now, feel free to ignore this if you think this is not clear or adds confusion,
I just wanted to give my insight reflecting on what I considered more
logical.


-- 
Oscar Salvador
SUSE Labs

