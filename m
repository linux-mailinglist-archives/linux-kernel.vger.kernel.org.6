Return-Path: <linux-kernel+bounces-235687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F091D862
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE217B20916
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA05811A;
	Mon,  1 Jul 2024 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzK1/tut"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F310A0E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817064; cv=none; b=Llhj1z/PMie6JjycdbTLa8l7KZo9/KPo8YZ5sz0XGHHsrBw51KaQ4CVmaaeMU7tIEUUTJOa9B9QKr6Lm3Mej7ThLTaWUiMthbJkVsf3UM/7q1PngI6RebCi7MLDmDJTWlw+e+hbMtTcOy2wUDPeKq/gG0oEtokln9xz8bd5rtEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817064; c=relaxed/simple;
	bh=8DfI1H8UonA6NomhsPjUPjeq10/x6VChoMolak6uzSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU+c3fySIkKFBb9AgMuRTBml6k9dQ+OE6BM9OTv+/m4xZNNwYIYRJnBECAdgtbvxDKcF/4o3QbsVGxhBFLbFjVMVml+8i3a2PQHR8CmOGm8AxZ5I2KmXBiOmCvAiD3Yrwy+BLTGQ08+hJPRi7ql1E5lMwOXpGVYYFJkXWTcRZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzK1/tut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719817059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IpTSHvGGLKrRIbXymuTxT7TJOOuk+NtEfOPydwUddDU=;
	b=OzK1/tutq4Bxy53Z8xF2Jvci19E7RMlvom83Oj92CI/oW4FQyOASb3OZJKSGDTNqlUG77m
	eMs7uyDF9+RovL1v0YQ1iVGiOibfGwZd7zqn9YLbb5VbX83X5TXw8xG0C3MVVCfNa4RHLi
	5qGYgDWyn1FK2bvuDB6fsYUXSfPeuL8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-voQJEwLsM_-GYDxXX9_L4A-1; Mon, 01 Jul 2024 02:57:36 -0400
X-MC-Unique: voQJEwLsM_-GYDxXX9_L4A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec584f36bfso24293121fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 23:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817054; x=1720421854;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IpTSHvGGLKrRIbXymuTxT7TJOOuk+NtEfOPydwUddDU=;
        b=ezwIj9xZtFA31OCjLnp3AMPb8b4jov5vHhKenW4eyoWzd4MksrbvpmIQh6EWF/boAl
         bV+rn4Advcx11oSk7xF2pS9WuRWG7Ehv9uq16aA65wVdrUiBTIQxNCPNNgVLO2tvuMch
         e1JJJZz47u/xJwx7iULAp5lM0jSpJ+A0wo6Et5Lc/9NvExxauhb0kPapFghdlka7n26L
         HiFi1+cWoUNl1r4+8n1VLVzzJjT6Gs+mhT5bijCrUKIftN8KKSHWvQj2yxeTbDxQCptc
         VJTdQjjZPRr0jKwf/p8QYep7MZnjP3pJYKXRjqONhtCEPSZ9yBid8vWZohS5iDyGXSyZ
         Zskw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGA3NXIOjBgBgMh5OcT4iyLsE0nthDK/cczhLDOujLntkNd+JYijmWWrnoPslyP4sZ5S9Re44QxS2R+EQyi0NhcF7x5BIV0YXzph9
X-Gm-Message-State: AOJu0YzbqR0Gs6slH8EC/g16tywjSvJrStKQAikRt2rWbcOOFITQhAqc
	kZCRihjISeSiFJyj0k/uBibSaIbOoHJmSZGE7m7Qywk8heUrni3BxnVnIAh5yriKqfMjBUgm3sj
	gIGjYjdXvteMeUEdVpaPvmA3kIQd5nE4pX4s+NimwCJalHp/KEhDiU8GZmdsbDA==
X-Received: by 2002:a2e:9556:0:b0:2ec:58e8:d7a2 with SMTP id 38308e7fff4ca-2ee5e359092mr25084501fa.16.1719817053956;
        Sun, 30 Jun 2024 23:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/HNWdb4R7HyFPm87+8vcgtMUhbGbar8AL+VQEjwkzMxx2hDvAu8eV7BURsrmPE30qqdiZcw==
X-Received: by 2002:a2e:9556:0:b0:2ec:58e8:d7a2 with SMTP id 38308e7fff4ca-2ee5e359092mr25084441fa.16.1719817053536;
        Sun, 30 Jun 2024 23:57:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:2200:7ed7:c239:d423:3b31? (p200300cbc72e22007ed7c239d4233b31.dip0.t-ipconnect.de. [2003:cb:c72e:2200:7ed7:c239:d423:3b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1345sm9105356f8f.54.2024.06.30.23.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 23:57:33 -0700 (PDT)
Message-ID: <1bf214bb-86a7-4f73-a839-39a4b37bc04a@redhat.com>
Date: Mon, 1 Jul 2024 08:57:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240628104926.34209-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.06.24 12:49, Bang Li wrote:
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
>   fs/proc/task_mmu.c      | 10 +++++++---
>   include/linux/huge_mm.h | 11 +++++++++++
>   mm/shmem.c              |  9 +--------
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 93fb2c61b154..09b5db356886 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>   {
>   	struct vm_area_struct *vma = v;
>   	struct mem_size_stats mss = {};
> +	bool thp_eligible;
>   
>   	smap_gather_stats(vma, &mss, 0);
>   
> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>   
>   	__show_smap(m, &mss, false);
>   
> -	seq_printf(m, "THPeligible:    %8u\n",
> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> +	thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
> +						TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
> +	if (vma_is_anon_shmem(vma))
> +		thp_eligible = !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +							vma, vma->vm_pgoff, thp_eligible);

I would have thought the correct fix is to return the correct result 
from thp_vma_allowable_orders().

-- 
Cheers,

David / dhildenb


