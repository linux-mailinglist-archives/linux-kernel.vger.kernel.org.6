Return-Path: <linux-kernel+bounces-262756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081093CC3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A641C20DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAFEDB;
	Fri, 26 Jul 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NvxppWpK"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB8EC5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956183; cv=none; b=fy+DfNwoF2vs4RDYOVgyn2dZisrMP8Ed5HAdJwmNzau2RD1YBfiB99B8L2RUJV5xArRR2vphnDdrdf3+2QO+78R6NaWQ/R2lEWEcdPLapHLv1QEwp2ICLPKhMSEXFo/Ani8TtNY2VI+oVQvcXTMVIcRdk/0BKLHudNV+u2X1pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956183; c=relaxed/simple;
	bh=gPb4nXPn4GDaoQDH/AKGM2mVA8zbCIOwljJRm13/gF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1lPkwy3zg/9DI+e3Gfo0GJpcfHzWrFtDT1MlRg4SzmYC0SO+DYMGgnM3PyENZ3HdmOvuIIGQYdbRFE9XDysnIFFvyIeg47pCDTGDD6tyXfCLKRuDSLO/l6d395xrr28dmWE5/Cj6I9Vxr2tIe63HQ3f7et1EsBIIUaNUTsJnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NvxppWpK; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721956171; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PsON5V5U5DNnoUnPVjiIOxDNIXZW2cw+8PLE2L1M6Yc=;
	b=NvxppWpKEv4KNGellhWvtD9YukHvvg2uu0MgOfHEj5OtVeibfsBf/+tkgOxjkkqXvKVbYpwSLqbZCd1BZuTalWoU1UZJR+vZxdjlaFP+i42zQiG1lOXSxxNWY6Nt7egfQ8r7de334CPEDnqNk0ktuIKJouAlWhMXbg6ml4wfiSQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBJoD9L_1721956170;
Received: from 30.97.56.64(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBJoD9L_1721956170)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 09:09:31 +0800
Message-ID: <3bd0c129-fdca-4f30-b5a6-c0b8d997d3e6@linux.alibaba.com>
Date: Fri, 26 Jul 2024 09:09:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <16dad33282617ecb90a3f466b35273b10be68d21.1720755678.git.baolin.wang@linux.alibaba.com>
 <b670b981-bc79-4c8c-8b69-4879300066d4@arm.com>
 <f206ad30-a007-499e-941c-1c4abc0c5eb3@linux.alibaba.com>
 <1e635cfd-d461-4e56-95b8-c6ea512f64ca@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1e635cfd-d461-4e56-95b8-c6ea512f64ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/25 21:09, David Hildenbrand wrote:
>>>>    /*
>>>> @@ -1625,27 +1632,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, 
>>>> gfp_t limit_gfp)
>>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>    unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>                    struct vm_area_struct *vma, pgoff_t index,
>>>> -                bool global_huge)
>>>> +                bool shmem_huge_force)
>>>>    {
>>>>        unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>>>        unsigned long within_size_orders = 
>>>> READ_ONCE(huge_shmem_orders_within_size);
>>>> -    unsigned long vm_flags = vma->vm_flags;
>>>> +    unsigned long vm_flags = vma ? vma->vm_flags : 0;
>>>> +    struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
>>>
>>> nit: rather than deriving the fault_mm here, I wonder if its cleaner 
>>> to just
>>> pass vma to shmem_huge_global_enabled()? shmem_huge_global_enabled() 
>>> is just
>>> using it as a guard to access vm_flags, which you can just as easily 
>>> do by
>>> testing the vma for non-NULL. And you can access mm flags with 
>>> vma->vm_mm->flags
>>> after testing the vma too.
>>
>> Make sense to me, and will do in next version.
> 
> Feel free to add my
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks David.

Andrew has already queued my v3 patchset into the mm-unstable branch.

Andrew, please help to add David's acked tag for v3 series. Thanks.

