Return-Path: <linux-kernel+bounces-542547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43600A4CAFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD487A8531
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E21F4C83;
	Mon,  3 Mar 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apzwFqlm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A984A3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026650; cv=none; b=WjpPiYVqVVn7Yuh82z/CGGRrq228BhmlNVxgeyfDmtNXvVYqEmLRhz6M4cAYF4QDhsqVBu5cJIH25aS8c/fjAFXtBO0uGcSbpyD44nudjVRn+hsDSHqEBeb0Esi94NrqxkA5G8bFLCd1G+jDlRs5Lhctb03CtisiQxX+zec6ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026650; c=relaxed/simple;
	bh=w1AwGc2CdmVgtBjFBQwDHJrpxA7X1qM0BdRReldzBSE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq1oYFXz9QaG+buESfTxgWtgzH3S9aui3USKwQXgPM8qVUiCi5zdhsOHoDeR6za7hqcHRUcpBezg4mE3gK89kIri+mgyHpElDmuPwAkpBBSO9R4cMckjUywlIZG+cfdKj77PjT0S1e++cEHJn2JnWGHqtGgrLik8du96olYaSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apzwFqlm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so24334041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741026646; x=1741631446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDT/FI9HyG67R1pizfIc2St2pqXpHBG0RFQRvwWXMEE=;
        b=apzwFqlmpxw2iGAk3sGvf+wE0rfQtJSsIu/Eeyq9t8cVOlAV9t682drnT5kkPGjZVz
         pgFPYprmOMRaEBJUhVfjhGIc87aePqOa2c1OdHi/GTvQQpfpxx9l8G+kkORLNoSKphrR
         xGsxHyqvWa1VSG9203AaCGUrPItvfOsjmE+tnZFzJ3x20FUTJNU8o2AK1uK9GmXTqJl7
         nQCa21NfL1PQ1JvOXZltw3x7NpYZQyaNeIs2dICpJvHLE//2m9kS3WKn4Xz9XTAZTzvf
         ZDcOGLSHdALrA36ekFx74oIhEtdo5X22wov8j0vLOtjAJ0IlmLCZy9+zqtrPyM24W2gF
         87Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026646; x=1741631446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDT/FI9HyG67R1pizfIc2St2pqXpHBG0RFQRvwWXMEE=;
        b=aE2j2FpRfuyM2ShgweUlj5J59YwkfBlAXDsC460xLL6Kh6ZUdE/ptGbMbLGcfD7yKj
         aFp0djVo2aRZj28NNbl4HG/RKAxYvl3ZOqHUuWQEXYppjoFFJJhYs4qjkPvZtNjkahgo
         xfLTd59FJcQ/NW30UXZ9IG3WrZbDFYO4+x9LP+GoZ3SoJri/OQTb/pPyUzB/z/pssMdN
         /7cwJfmnOXE57Yq0OigPX13rryoS16LDVkLPjnj/kGt1uTGIA773xp1DepqNQbg6sQ+i
         +69deqerXUEeJgEOHdgyeylRfFTf+e4d6EVF2MyNqcBht+AR6/+uHbbjHfDFdVstAgzJ
         prQw==
X-Forwarded-Encrypted: i=1; AJvYcCWWc5POBOQ2hRrugxzOfjLl32F5zG9mWM04a3sZgLjabuEFvHjvvg+o+F+e0HNSx6i4g4M+3tGb8wmyaWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WXFSM5Ll3O1vJQhP6oGVs6bI0tARGwtNkHygDNspk45uuIl9
	jYCky+U1ymKe3pPWxkw4caswurzUoppDN+Cnqcnm/haZtXioAzpB
X-Gm-Gg: ASbGncvJWos82YiOZXo9UM9qQFQFNXlbyVF4mpj3aW+5BzNTBdGK2iJ3fF2HAy9oYNW
	I+PIKULj/Xv8OWXPTIt+lBBDkOcZkDfbc95xqMQDOUYtO9TTcH3DAIvR60Afesc6a9lgf58KPfN
	IrBT6MB+zzo1ECB2HHm17ukRb0CwXsF1gt9UbX0jT5Z511N0m+WCvCBXyFdwK7qb2zkJetV5FE5
	SxQMZCnVQv+hcH7iml0tt8OMmD83U9ATgtSt+oCnv5fSIOvXIReKb2bZLP1teLlTUKH7K9jkH59
	UXRWiznoXfo=
X-Google-Smtp-Source: AGHT+IHNJ6M+a6taADL1+o1egBEFbGVb+GeAIKsRYROrzEot5rwJRNJap7Ha4uaDJSAQ0yBH3zWdbA==
X-Received: by 2002:a05:6512:3d0e:b0:545:8a1:536e with SMTP id 2adb3069b0e04-5494c129f17mr4958302e87.6.1741026646003;
        Mon, 03 Mar 2025 10:30:46 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54963962fe4sm507952e87.240.2025.03.03.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:30:45 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 3 Mar 2025 19:30:43 +0100
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/vmalloc: Remove unnecessary size ALIGN in
 __vmalloc_node_range_noprof
Message-ID: <Z8X1U-3f35-JZTUr@pc636>
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <20250303094410.437985-2-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303094410.437985-2-liuye@kylinos.cn>

On Mon, Mar 03, 2025 at 05:44:07PM +0800, Liu Ye wrote:
> The same operation already exists in the function __get_vm_area_node,
> so delete the duplicate operation to simplify the code.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  mm/vmalloc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dc658d4af181..20d9b9de84b1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3798,7 +3798,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  			shift = arch_vmap_pte_supported_shift(size);
>  
>  		align = max(real_align, 1UL << shift);
> -		size = ALIGN(real_size, 1UL << shift);
>  	}
>  
>  again:
> -- 
> 2.25.1
> 
There is a mess with:

 unsigned long real_size = size;
 unsigned long real_align = align;

"real_size" and "real_align". Those are useless. What is about:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5c88d0e90c20..a381ffee1595 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3771,8 +3771,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	struct vm_struct *area;
 	void *ret;
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
-	unsigned long real_size = size;
-	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
 
 	if (WARN_ON_ONCE(!size))
@@ -3781,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	if ((size >> PAGE_SHIFT) > totalram_pages()) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, exceeds total pages",
-			real_size);
+			size);
 		return NULL;
 	}
 
@@ -3798,19 +3796,18 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		else
 			shift = arch_vmap_pte_supported_shift(size);
 
-		align = max(real_align, 1UL << shift);
-		size = ALIGN(real_size, 1UL << shift);
+		align = max(align, 1UL << shift);
 	}
 
 again:
-	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
+	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
 	if (!area) {
 		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed%s",
-			real_size, (nofail) ? ". Retrying." : "");
+			size, (nofail) ? ". Retrying." : "");
 		if (nofail) {
 			schedule_timeout_uninterruptible(1);
 			goto again;
@@ -3860,7 +3857,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
-	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
+	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -3878,8 +3875,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 fail:
 	if (shift > PAGE_SHIFT) {
 		shift = PAGE_SHIFT;
-		align = real_align;
-		size = real_size;
 		goto again;
 	}
 
?

--
Uladzislau Rezki

