Return-Path: <linux-kernel+bounces-173224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE238BFD42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C62B2220E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A24205F;
	Wed,  8 May 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfTLJnhR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142682BAED
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171794; cv=none; b=OypN1y/EjNWHNsgUujKm2meJ5bfQEor4FoRdWvrmpwzKjb03sx/mVoAq34AQeZPbq11m7yoPu99EiYSMvBlypFENTF+9Kbg+IerksPWRVxiIGCSn3IJhfiVh8gbfUP3YTxwAb/jjiHp0/RHCeaOjZnsWBx3bRHGyaOhe1uKgBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171794; c=relaxed/simple;
	bh=zEVFKWDPHzfLIFVkJEJ8ZLtpn/VR/O8aUK7otcMIHFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IK87wxw6oxehCK4UAMoYsiqx4qoB2PPCG5ztHm2EkNMK9o9gNa1kKI8siJyEoP0rpUE4LVqWA+drn2tL3A2JEC3xlN7/KnF+4XLOljFDP/cnY7FC6zQTnyh9aVq9eUW5NZUacfD5TpkYKwyPubsSfuS57eG5n0dKtgoAFZ6Mn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfTLJnhR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715171792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3wIGCAuvGoVgqUnF0xWUTMxWftdy/m+pm98lbPtEOlY=;
	b=QfTLJnhRkuOiRsjoFL6JLYYR5pMiepg5KyQONIyCUlR0kdNhTqHThOd5sKpjugoFzWu8AR
	3XOVc7jfyec9r+nvhL5nPBCOZ9DNVIsjF+l3h85TSnFN9DH8REU9o4yOkYr8S98TDtq16g
	ZNnrheAn/tMJlxNBw4SLnR0kv8t5dtw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-upP-Y6SYMHepL2xc5VdPnw-1; Wed, 08 May 2024 08:36:30 -0400
X-MC-Unique: upP-Y6SYMHepL2xc5VdPnw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51f0d924685so4184887e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 05:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171789; x=1715776589;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wIGCAuvGoVgqUnF0xWUTMxWftdy/m+pm98lbPtEOlY=;
        b=niSLw7i7CUv9cZ72gnPYwrw9JjRJBoEwOqQejdpbPKBmOF1drfiXQR6LW3UX2feiBm
         kWy9wuUtgP6G3PRZd/6jtVJki/t3vQlY8XfMsvBnn4ta2htcY9XJd+5SwJCLS+8eAtgU
         QZi8ajclwne/jsldYVYKFn1diJ2MkRHxHuql8eDmkJZlB30lm8ecqy55SOj2YgnEoCEA
         +bWWuI+ZkTkc+kSel/gGgNjMHQcZoJom/P+oFBJDxG7fuj3dGHH7n52ZpvNO6sX7H2i6
         5P5NLGQqZ9qLQwQQquvjyuBWv+Gu+fJCOUz1s59Zd0iimxlJhkrxK+zkfIHFaelIcTyd
         WSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXMdVRsFv/WyxgdKW3pldp+XoVzBvx68Z4FoN8ptaCzKemUv0josdo1sVY9sUPePpY9HI9a34CFdtKzAEwlIfM3jpD+j2MZiUWG/XK3
X-Gm-Message-State: AOJu0YwHG63R78EoX9orteOCgON4K2Lj2ohf92l2HM9K9VidPdEOsJRn
	ma/fmEpOkO/tWs771o7VpzG6TgZ2JgukdIxmAwGIOEdsS/dUpw/gd4gnrzxxC9eYR5PEMfHLWB5
	Gz52tsM3S88Y5IpkV/k8v0lH3PYQozIPbi9GBlC0w5gqk4m2Y3NBNVbsCSOJnMw==
X-Received: by 2002:a05:6512:488d:b0:51f:4165:930b with SMTP id 2adb3069b0e04-5217cd4963emr1967255e87.49.1715171789119;
        Wed, 08 May 2024 05:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh7nUXUIv4iydkg+G1xAux2BK2Fcpwq2ECewoj0hQObAbrC9xEzI1gba5MlDIvvQM4FnyIvA==
X-Received: by 2002:a05:6512:488d:b0:51f:4165:930b with SMTP id 2adb3069b0e04-5217cd4963emr1967230e87.49.1715171788617;
        Wed, 08 May 2024 05:36:28 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id d34-20020a0565123d2200b0051ef1d658bcsm2530237lfv.51.2024.05.08.05.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 05:36:28 -0700 (PDT)
Message-ID: <7cac6762-4486-4c42-885d-dd5715eb6ba4@redhat.com>
Date: Wed, 8 May 2024 14:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/ksm: fix ksm_zero_pages accounting
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
 <20240508-b4-ksm-counters-v1-2-e2a9b13f70c5@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240508-b4-ksm-counters-v1-2-e2a9b13f70c5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 11:55, Chengming Zhou wrote:
> We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
> but ksm_zero_pages-- is done from page tables side, which can't protected
> by the ksmd mutex.
> 
> So we can read very exceptional value of ksm_zero_pages in rare cases,
> such as -1, which is very confusing to users.
> 
> Fix it by changing to use atomic_long_t, and the same case with the
> mm->ksm_zero_pages.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>   fs/proc/base.c           |  2 +-
>   include/linux/ksm.h      | 22 +++++++++++++++++++---
>   include/linux/mm_types.h |  2 +-
>   mm/ksm.c                 | 11 +++++------
>   4 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 18550c071d71..72a1acd03675 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>   	mm = get_task_mm(task);
>   	if (mm) {
>   		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
> -		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
> +		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>   		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>   		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>   		mmput(mm);
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 52c63a9c5a9c..bfc2cf756b0d 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -33,16 +33,32 @@ void __ksm_exit(struct mm_struct *mm);
>    */
>   #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>   
> -extern unsigned long ksm_zero_pages;
> +extern atomic_long_t ksm_zero_pages;
> +
> +static inline void ksm_map_zero_page(struct mm_struct *mm)
> +{
> +	atomic_long_inc(&ksm_zero_pages);
> +	atomic_long_inc(&mm->ksm_zero_pages);
> +}
>   
>   static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
>   {
>   	if (is_ksm_zero_pte(pte)) {
> -		ksm_zero_pages--;
> -		mm->ksm_zero_pages--;
> +		atomic_long_dec(&ksm_zero_pages);
> +		atomic_long_dec(&mm->ksm_zero_pages);
>   	}
>   }
>   
> +static inline long get_ksm_zero_pages(void)
> +{
> +	return atomic_long_read(&ksm_zero_pages);
> +}

I suggest inlining that one. The naming of the function also is a bit 
inconsistent staring at the others.

> +
> +static inline long mm_ksm_zero_pages(struct mm_struct *mm)
> +{
> +	return atomic_long_read(&mm->ksm_zero_pages);
> +}
> +

Apart from that LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


