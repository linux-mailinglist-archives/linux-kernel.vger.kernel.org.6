Return-Path: <linux-kernel+bounces-549081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F0A54CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F094F17509F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAA14F9C4;
	Thu,  6 Mar 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYMiic+x"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2914EC7E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269982; cv=none; b=e2zgUimM7quk2WrTAwqW99/v8c/Ums1IsGe0ODcLJRaDoe84lMR2asDevsGsSu1rIQQumJGEDCFlVO3BVg2BjuK7PZMlq26DVWYVxatOQ4maF6E0cLkd/KQoKXLkuZkMkEj2nEHQHYDxwImo6wW9zyDjrpVSWEhhQe9cOT5je2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269982; c=relaxed/simple;
	bh=fJ3JMRmMLxdUgb+fMz5KSefNbQ+us26eCtHGqQ1uUBs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdJ4ecgpJo8ND7bZO6Ytnj53IekUO/dSu5HDZCrzU3RvaDcmh7OyKufWmIAIG93DmfWP9m1lZ2O6EZAKcJgfEIJ9yWqPVRZm74eZzr4qFxm/NodJY8XEzkLk1nCgyM/ZRdHLLk379diTEkfPmVm1OQDw+SI1C3z1sKiBbvl82bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYMiic+x; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so737584e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269979; x=1741874779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjOu9pJBQoqmr0DjbFobF0iHjAynNdClTtCuCIosMZo=;
        b=IYMiic+xilQWvAvR/m4ogl4pEXpDh4u+lFc23GA0JjyJOgjZXb9mN6aEblmTSm68rA
         SJOb8bEDkJMvn42uDIQk1Gbk6vs+/IXEc/ZU7dtnTr+50du1yX+3bshTbfpYkpYXwJir
         0T2X7ErULe4yAJSW2ygomXOu7OSlq/t0yGvAavOmIuTyW7YEBEg0vGNI7OM5BhB+GZXB
         PAov656pWYMkQWQRe30WGPcxTiRaOzq6pzWjLjY08RQExDHoSmbT1PYDSGGLIQr1VCw7
         IHMaoCgoIgzQEUfQAyxCP1/49IX4w5ceqdnsUitvVoR/9jTdPLEW4wm+VO0sNYCZnF3L
         hy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269979; x=1741874779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjOu9pJBQoqmr0DjbFobF0iHjAynNdClTtCuCIosMZo=;
        b=G1kGVx1C5BdXfUjGTo5juAkbE4hkd4fuDaBHiEnC0YWGYp7lGCcOylMz27r7s/Iljp
         BmAJv0gCrBREm4ehbTCmoJoKN0HQEQQECPqAP8yvaRuse+rVOx5yMytKNJRzmVTewofn
         PZGDvQIi0GOVcxN7CdLhRoNCrQabyEEGI2csbg+ZNXFweqePKcxUN/Fe5iapTn6/Ig8V
         ZBgJa0BsgGm4r3MN44EfkPgNF6to4XZWIiXy2qD2t1CjIlZOdjrc+VwYbcLXBRpizMxG
         O83sFyutb2TxK2WDTmXMDm0NreMZ6F6kKQE6MIQQ3ToeFOhlU8LxQW+Iv9Jf91WwuRnh
         5W1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ/NAqyDGFiqyayhEALxU/DK6BkeFLWxTUIIXjIAl/SGA67PQVZxWnc5IsYe0GX5PAQ9OQmJOGg6tACA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCDRVKEf04kZPv46pEdcu5zvMhoguq7NwUdEO2+IodO2SyZ8e
	SbmNHtSuzc8qbXmJguINIr0Qt99QuWq4vlVCLpW7sYlSwwn3h+50wcZEeA==
X-Gm-Gg: ASbGncs+W5igy69itfzD3YQJHelgoOAx2KBkBoij0ExA0fZsOEZ33BLexhXw8qaRYBD
	5qItR87g0hdJjU69lsFU/ImiNCFlTTRWH65jL6TGZhgKwScXG+ILBDRRQkeNiG/Ncr+f/Vb8fkK
	S4fT6IHbZrz2PGh8he/RRrrHSu1U7L3ApOfYLmoyxvmUbxyF0UmOA2AQRPKJx26G5YTVmPEJV/t
	/Qa4317MQ6orybewJGWJsPZDss+0nK9Q6IES7wdvHCucEWz7gIlUUpNF1jjiT67R21nqVdfDm8+
	36X58VPNYSNn2Ock9q2DDwFoBKFxBiUWFVtHNKAmF1FGJ5A0uPJD+b5x9TeIt24Uvhs=
X-Google-Smtp-Source: AGHT+IHHVLXdst00gmesr3Hvy0rJTfIZKopEN1MEoKgO30uOIMCKMIfH16pDR2jSB3ZXUFL7oD6adQ==
X-Received: by 2002:a05:6512:2829:b0:549:74a7:12ce with SMTP id 2adb3069b0e04-54984bd24fbmr1117746e87.14.1741269978188;
        Thu, 06 Mar 2025 06:06:18 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46dfesm186431e87.37.2025.03.06.06.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:06:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 6 Mar 2025 15:06:15 +0100
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Refactoring function
 __vmalloc_node_range_noprof
Message-ID: <Z8mr12PilC00Wcvg@pc636>
References: <20250306072131.800499-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306072131.800499-1-liuye@kylinos.cn>

On Thu, Mar 06, 2025 at 03:21:31PM +0800, Liu Ye wrote:
> According to the code logic, the first parameter of the sub-function
> __get_vm_area_node should be size instead of real_size.
> 
> Then in the function __get_vm_area_node, the size will be aligned,
> so the redundant alignment operation is deleted.
> 
> The use of the real_size variable causes code redundancy,
> so it is removed to simplify the code.
> 
> The real prefix is generally used to indicate the adjusted value of a
> parameter, but according to the code logic, it should indicate the
> original value, so it is recommended to rename it to original_align.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  mm/vmalloc.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dc658d4af181..a8488452b70b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3770,8 +3770,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	struct vm_struct *area;
>  	void *ret;
>  	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
> -	unsigned long real_size = size;
> -	unsigned long real_align = align;
> +	unsigned long original_align = align;
>  	unsigned int shift = PAGE_SHIFT;
>  
>  	if (WARN_ON_ONCE(!size))
> @@ -3780,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	if ((size >> PAGE_SHIFT) > totalram_pages()) {
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, exceeds total pages",
> -			real_size);
> +			size);
>  		return NULL;
>  	}
>  
> @@ -3797,19 +3796,18 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		else
>  			shift = arch_vmap_pte_supported_shift(size);
>  
> -		align = max(real_align, 1UL << shift);
> -		size = ALIGN(real_size, 1UL << shift);
> +		align = max(original_align, 1UL << shift);
>  	}
>  
>  again:
> -	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> +	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
>  				  VM_UNINITIALIZED | vm_flags, start, end, node,
>  				  gfp_mask, caller);
>  	if (!area) {
>  		bool nofail = gfp_mask & __GFP_NOFAIL;
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, vm_struct allocation failed%s",
> -			real_size, (nofail) ? ". Retrying." : "");
> +			size, (nofail) ? ". Retrying." : "");
>  		if (nofail) {
>  			schedule_timeout_uninterruptible(1);
>  			goto again;
> @@ -3861,7 +3859,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	    (gfp_mask & __GFP_SKIP_ZERO))
>  		kasan_flags |= KASAN_VMALLOC_INIT;
>  	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
> -	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
> +	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
>  
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> @@ -3870,17 +3868,15 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	 */
>  	clear_vm_uninitialized_flag(area);
>  
> -	size = PAGE_ALIGN(size);
>  	if (!(vm_flags & VM_DEFER_KMEMLEAK))
> -		kmemleak_vmalloc(area, size, gfp_mask);
> +		kmemleak_vmalloc(area, PAGE_ALIGN(size), gfp_mask);
>  
>  	return area->addr;
>  
>  fail:
>  	if (shift > PAGE_SHIFT) {
>  		shift = PAGE_SHIFT;
> -		align = real_align;
> -		size = real_size;
> +		align = original_align;
>  		goto again;
>  	}
>  
> -- 
> 2.25.1
> 
This one looks good to me:

Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

