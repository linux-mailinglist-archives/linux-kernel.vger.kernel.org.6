Return-Path: <linux-kernel+bounces-223396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CF91124E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A6E286C37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E852F71;
	Thu, 20 Jun 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC2IKVd3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596371B3727
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912309; cv=none; b=hrbIIcedOsOM9BvACGnh7hHyTCOWMYPXEVVx6ZkNiOHGR8KV2v5fyBzOeoTVk9OdK31tq8CRnMecM/PyE7aHF9CfqxPwAozB8QnQxe36Ddji59ZVJlWjsaAJ4PmmeLqJxT4TYGxgMlHynlOIvfZD98Asr+OPyrLh2v61wJ4/bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912309; c=relaxed/simple;
	bh=/w4tOXVlhAF3eaJUntEUKEFIPfbSjkSnBUDJMCXbGlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrUN3miKPvGGJpJFas1hP/OHrDKz/rDD6nSrvw25BvJAxagSb+xNcAjcb4W8y2VJgLydV+rAt7mgINJrdahKUToP9nQexfrsT9iGlYoz/fFnpZCcmuQUfnMtkAdky+eao+w8Md/iZh+swwnfQu+liq9cUFOVjomHTiCf7hFOZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC2IKVd3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718912306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yulzMQq1lZ5m4LlymPpkGq4mPTsA6DoLYfWOW3AvV8k=;
	b=gC2IKVd3DSFTX4SQAXo2hHV6yrASfAl1tUz1jlb2eWxp2tCNdJYoH0C4A4+yy+PCGhDqDL
	8deKKN+Vf6BrnaG7BzmiWnKvs+l4zEF+kRu3lT6YHCuDwvzhWmv8KNk7iBjzCrlXO4XFYv
	CsipsF6LCqLqF0IklJkHGl3SIQucm54=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-HrXS8GoPMjaqQjHf4UeD-Q-1; Thu, 20 Jun 2024 15:38:24 -0400
X-MC-Unique: HrXS8GoPMjaqQjHf4UeD-Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36536118656so443266f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912303; x=1719517103;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yulzMQq1lZ5m4LlymPpkGq4mPTsA6DoLYfWOW3AvV8k=;
        b=stwNPSyXA6iFqmrLG/ILyS2AxymNg6tyoVzHgZQKMs4QSfPsYT2EdA0gTOwghIPntO
         iHHSoMFj9rdj+EOr2OrPY6q+ysRKct1LuBcDw7hw7tD3EAS71Hira8TTMQocDxNDEHTl
         pTQ0FuFSURixu0aPV+jEvgYuVqsp3B+k63Gn6Ylt2WKuPkfWiDMaJ1++PcW4b5ZmaTLV
         PU0BkQnYHfgsF/t64gFFotiSm9aNPCxgZS0xbIu2WZPDC29dZQrEErGxWeAcPd43A/8A
         Us0FAKdQc5H6gtO5UZiOfJIewRWZCLSJAkx1JHLDZthpgGckK9VTG3I/cBZTvX5xHS8/
         /w7A==
X-Forwarded-Encrypted: i=1; AJvYcCXR9ufFduXkXpVvkQ0dvUzYUcIs1yrwkHnqciGJdz5x19/c0RwDx/7xYV6fTm1pXLRJ1Ld9vwlGP177S2E4akFqrYrVI+9n1f3yXc3x
X-Gm-Message-State: AOJu0YwSfaraVmb0Lu/7JGR1ekQLBHQMCloueBxqaC9IRdSQyJ/ajR6v
	IobWKhxMVvcUU0xAmtLdz5mU1Qw4qsVLufTSLTwDuW1xbaqyuhK1C5A15OY9x4JsF9K1U+IAHRo
	RjRJhtr1cbRkhBOY948JZP8u3afPR4dt6VFxa/H2rJWqooy+bOHmtXd749hj//g==
X-Received: by 2002:a05:6000:d88:b0:360:79a2:af1 with SMTP id ffacd0b85a97d-363175b83abmr4779336f8f.25.1718912303680;
        Thu, 20 Jun 2024 12:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq2lFU7gEnrSryIJeHRcJMEWNbQLOju8ydZA8LFbhDlTy47dnkho8Dbc3uZjqCn50RbS9/Sw==
X-Received: by 2002:a05:6000:d88:b0:360:79a2:af1 with SMTP id ffacd0b85a97d-363175b83abmr4779329f8f.25.1718912303266;
        Thu, 20 Jun 2024 12:38:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362cd0d79fdsm6690117f8f.77.2024.06.20.12.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:38:22 -0700 (PDT)
Message-ID: <254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>
Date: Thu, 20 Jun 2024 21:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
To: Sung-hun Kim <sfoon.kim@samsung.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
 <20240620043914.249768-1-sfoon.kim@samsung.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240620043914.249768-1-sfoon.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 06:39, Sung-hun Kim wrote:
> The current version of KSM does not take into account the number of
> used ksm_mm_slot. Therefore, when users want to obtain profits of
> KSM, KSM omits the memory used for allocating ksm_mm_slots.
> 
> This patch introduces a new variable to keep track of the number of
> allocated ksm_mm_slots. By doing so, KSM will be able to provide a
> more accurate number of the gains made.

If you take a look at the calculation explained in 
Documentation/admin-guide/mm/ksm.rst, we only care about rmap_items, 
which can grow rather substantially in size.

We also don't consider other metadata, such as the size of the stable 
nodes etc. So why should the ksm_mm_slots matter that much that we 
should track them and account them?

Any real life examples where this is relevant / a problem.

> 
> Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
> ---
> Changelog in V2:
> - Add an MMF_VM_MERGEABLE flag check in ksm_process_profit for
> untracked processes
> ---
>   mm/ksm.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 34c4820e0d3d..c8ced991ccda 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -267,6 +267,9 @@ static unsigned long ksm_pages_unshared;
>   /* The number of rmap_items in use: to calculate pages_volatile */
>   static unsigned long ksm_rmap_items;
>   
> +/* The number of ksm_mm_slot in use */
> +static atomic_long_t ksm_mm_slots = ATOMIC_LONG_INIT(0);
> +
>   /* The number of stable_node chains */
>   static unsigned long ksm_stable_node_chains;
>   
> @@ -1245,6 +1248,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>   			spin_unlock(&ksm_mmlist_lock);
>   
>   			mm_slot_free(mm_slot_cache, mm_slot);
> +			atomic_long_dec(&ksm_mm_slots);
>   			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>   			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>   			mmdrop(mm);
> @@ -2717,6 +2721,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   		spin_unlock(&ksm_mmlist_lock);
>   
>   		mm_slot_free(mm_slot_cache, mm_slot);
> +		atomic_long_dec(&ksm_mm_slots);
>   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>   		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>   		mmap_read_unlock(mm);
> @@ -3000,6 +3005,7 @@ int __ksm_enter(struct mm_struct *mm)
>   		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
>   	spin_unlock(&ksm_mmlist_lock);
>   
> +	atomic_long_inc(&ksm_mm_slots);
>   	set_bit(MMF_VM_MERGEABLE, &mm->flags);
>   	mmgrab(mm);
>   
> @@ -3042,6 +3048,7 @@ void __ksm_exit(struct mm_struct *mm)
>   
>   	if (easy_to_free) {
>   		mm_slot_free(mm_slot_cache, mm_slot);
> +		atomic_long_dec(&ksm_mm_slots);
>   		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
>   		mmdrop(mm);
> @@ -3374,7 +3381,8 @@ static void wait_while_offlining(void)
>   long ksm_process_profit(struct mm_struct *mm)
>   {
>   	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
> -		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
> +		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> +		(test_bit(MMF_VM_MERGEABLE, &mm->flags) ? sizeof(struct ksm_mm_slot) : 0);
>   }
>   #endif /* CONFIG_PROC_FS */
>   
> @@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
>   	long general_profit;
>   
>   	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
> -				ksm_rmap_items * sizeof(struct ksm_rmap_item);
> +				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> +				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
>   
>   	return sysfs_emit(buf, "%ld\n", general_profit);
>   }

-- 
Cheers,

David / dhildenb


