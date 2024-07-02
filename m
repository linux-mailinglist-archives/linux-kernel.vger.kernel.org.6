Return-Path: <linux-kernel+bounces-237292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827CC91EECB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E789BB21B07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5855C1A;
	Tue,  2 Jul 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rhqNNg0I"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24806747F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900847; cv=none; b=Qb2IjwXe1QxV9Rf1C8eTEpak6uKEX9OPi/5bZjtv6DtJGv1Jz7hGxgvitV8RV/pjqpM9iJqnu7WKuixtK2hehNHhPFvKJnQTMRbhPWbZ8/IEpd/PH+uN5qo0/OTv3r9PM9i3P4/qPSKdVsYEMxK83cCmI0ktQTNRelmEWXA/RRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900847; c=relaxed/simple;
	bh=cuq57puEZlPVYH0zxLtbdFgQQUF/SdQZusuVvv78jy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6hUrGVfFBB7zJyJW4rJQZ62OvtwIktC3U3b7bwZFnBjwJotBjtImLeHs/ih13vayXZqscqUq4Do6D7xB4j0wwTuHTZsax6J6uicKONiOgfWbG+nLXK8todBgmG1bLZSqPL2wMMLqo3Uvq62ucuvHhdBA9z9DfBk9R9paR0c6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rhqNNg0I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719900843; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=erDT9J5j1rBE4ZxSrWgpupITXKbScrM2e64G+CfHvXQ=;
	b=rhqNNg0I/qjp4O0FlMjOEeDfM8rowrw6mXvNOeIC/Qc7tcYbbl7Xvmp6ON7vBwPQ/ql4EOiKrS6ufVeZzOREcadAcB4KMEH4u+rj030jQW3Oj9BZahbSsAisCcfVc4aB9h2iSIFeZyUzi31lDV0iUSqVMoEC8V6alvFam/9vK7A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W9hWdSb_1719900840;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9hWdSb_1719900840)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 14:14:01 +0800
Message-ID: <6f383c8c-b125-4374-bf21-67b6cc3edcbe@linux.alibaba.com>
Date: Tue, 2 Jul 2024 14:14:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
To: Bang Li <libang.li@antgroup.com>, ughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 ioworker0@gmail.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240702023401.41553-1-libang.li@antgroup.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240702023401.41553-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/2 10:34, Bang Li wrote:
> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
> anonymous shmem"), we can configure different policies through
> the multi-size THP sysfs interface for anonymous shmem. But
> currently "THPeligible" indicates only whether the mapping is
> eligible for allocating THP-pages as well as the THP is PMD
> mappable or not for anonymous shmem, we need to support semantics
> for mTHP with anonymous shmem similar to those for mTHP with
> anonymous memory.
> 
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
> Changes since v1 [1]:
>   - Put anonymous shmem mthp related logic into
>     thp_vma_allowable_orders() (per David)
> 
> [1] https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
> ---
>   include/linux/huge_mm.h | 11 +++++++++++
>   mm/huge_memory.c        | 13 +++++++++----
>   mm/shmem.c              |  9 +--------
>   3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 212cca384d7e..f87136f38aa1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>   }
>   
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge);
> +
>   struct thpsize {
>   	struct kobject kobj;
>   	struct list_head node;
> @@ -460,6 +464,13 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	return 0;
>   }
>   
> +static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}

This function should be placed in the ‘shmem_fs.h’ header file, just 
like shmem_is_huge().

