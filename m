Return-Path: <linux-kernel+bounces-301746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD895F500
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB91BB22392
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9DC18D624;
	Mon, 26 Aug 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENhEXh2l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC58186E48
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686024; cv=none; b=GLB7z7IMqRNvqGRZDqXGP5ODz5FU8FIrC4bc25RUe8eYkJ4+uAzxO5AuIY9/l0YEof+5haQvjbpYqR3DAgq1GIBOG2x5IQ3izc3OJfSz3fDSLZh3o+q7dokEvERF87OWDTygH2yysnC3xBkkuwwKFmlXd3dHgvgN5crM/LMmNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686024; c=relaxed/simple;
	bh=BY5EnaLeKtQaFbdeSi/Bp7BaHYcnoEijVuDGYKcDIhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgfTkkHK+czaODK23rSZYwcNS9p93Eq9ihZUtB732oBPL7uxUBMk6UG/sMQ2Pw9yYluywghBcFvmNl82Tx/po+DZkGhQCJbgn7o4hyCptvD3bCLfRYlIPjH4WQy3c0IQpjSllTQQ6Q8KOBpXFKEj56rzDvi7v9vDGzEJTn/oi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENhEXh2l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724686022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hR+Akr9YWsoJTBZs851mAQJ1H/l3mr5q9WxzD4AcF4s=;
	b=ENhEXh2lbMcFICmSkLLxxOKOOy8mv5e8HI8JBivZU6NI1JjT2HEODCo9Nca4YzdCDIVx5w
	U9jBG19gkK8oAxI+OOhgGxnyg74oCDepocLSLrvopN8KhhmRJjXdVwr68+11butP93PHIx
	VFYwnRQbLGVmO8TOQYSw6r4KlDaesBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-0KofDcARPzG7LrGomGVASw-1; Mon, 26 Aug 2024 11:27:01 -0400
X-MC-Unique: 0KofDcARPzG7LrGomGVASw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280f233115so41855025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686019; x=1725290819;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hR+Akr9YWsoJTBZs851mAQJ1H/l3mr5q9WxzD4AcF4s=;
        b=FZCa9GcOvrteobbegwb7Y79HJ9mouuXfAUqevm6hoA6vrTkYpT7Er8aDP0IaSGXGCM
         bC2/BjwDU8/EfejTU6LRzapGrFaJv1Dv5IzUDJO7SEei8H3zRAR0SHPnV9fJn330XKYz
         08NAB/VSQ38DScAw++TKN4GqOoFiMfc+pruapfV9tysQRzz5Q4hNrAbdl67FiqLfnCrF
         d+W2+2//jHfiJjBzbuImqkovnPxwQxymGHZQtK7fvbKoho8L+FjIaiS5spb8xAWchQmD
         XV2wqYad2z0ZfA2LBrJooZ5mGOREcDNBekX3cRD5gDb/jRLpJ7GjbleOmZ1OWyNyC2eP
         3Asg==
X-Gm-Message-State: AOJu0YxN037v7m6e0bFVQJTW1/bawAuWgr4JCOPhiDHWIzPf0n4UlwDi
	UYMMgX3ALgSYYQZCjF0ePrb2mpt0vgSdrAad2mU7qr4nlppXqV6wCJ4nwRkvx9zgN+23TnYno7I
	dTUcO4Xb9ixGlZNlTiZlSOredvuesTJjSHZrfF90mc+derCK1+ADJYjn192RCWg==
X-Received: by 2002:a05:600c:a01:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42acd57b683mr71398295e9.17.1724686018763;
        Mon, 26 Aug 2024 08:26:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL26zEvaE9x4Y8E/1fGQyz00aSNDZBMSxihsSd1bwRQ2Nt/7nonJyiEDJ8zLCLCIUUJU6hNA==
X-Received: by 2002:a05:600c:a01:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42acd57b683mr71397925e9.17.1724686017969;
        Mon, 26 Aug 2024 08:26:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1900:16b0:8dc:77e:31af? (p200300cbc737190016b008dc077e31af.dip0.t-ipconnect.de. [2003:cb:c737:1900:16b0:8dc:77e:31af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac624bb23sm156716575e9.32.2024.08.26.08.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 08:26:57 -0700 (PDT)
Message-ID: <77f3f5ce-dd12-4ca2-90cd-0f2226fe26ba@redhat.com>
Date: Mon, 26 Aug 2024 17:26:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm: adjust_pte() use pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <7915acf5887e7bf0c5cc71ff30ad2fe8447d005d.1724310149.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7915acf5887e7bf0c5cc71ff30ad2fe8447d005d.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 09:13, Qi Zheng wrote:
> In do_adjust_pte(), we may modify the pte entry. At this time, the write
> lock of mmap_lock is not held, and the pte_same() check is not performed
> after the PTL held. The corresponding pmd entry may have been modified
> concurrently. Therefore, in order to ensure the stability if pmd entry,
> use pte_offset_map_rw_nolock() to replace pte_offset_map_nolock(), and do
> pmd_same() check after holding the PTL.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/arm/mm/fault-armv.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index 831793cd6ff94..de6c7d8a2ddfc 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -94,6 +94,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   	pud_t *pud;
>   	pmd_t *pmd;
>   	pte_t *pte;
> +	pmd_t pmdval;
>   	int ret;
>   
>   	pgd = pgd_offset(vma->vm_mm, address);
> @@ -112,16 +113,22 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
>   	if (pmd_none_or_clear_bad(pmd))
>   		return 0;
>   
> +again:
>   	/*
>   	 * This is called while another page table is mapped, so we
>   	 * must use the nested version.  This also means we need to
>   	 * open-code the spin-locking.
>   	 */
> -	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
> +	pte = pte_offset_map_rw_nolock(vma->vm_mm, pmd, address, &pmdval, &ptl);
>   	if (!pte)
>   		return 0;
>   
>   	do_pte_lock(ptl);
> +	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> +		do_pte_unlock(ptl);
> +		pte_unmap(pte);
> +		goto again;
> +	}
>   
>   	ret = do_adjust_pte(vma, address, pfn, pte);
>   

Looks correct to me, but I wonder why the missing pmd_same check is not 
an issue so far ... any experts? THP on __LINUX_ARM_ARCH__ < 6 is not 
really used/possible?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


