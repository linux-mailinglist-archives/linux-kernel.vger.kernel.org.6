Return-Path: <linux-kernel+bounces-192791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B288D221F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CDB1F236B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0959173346;
	Tue, 28 May 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfURAcwJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3932C60
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915691; cv=none; b=Qd8Wt0fCrsyCKDXbBBJalZblcedM9u1Aw33Lu6SMdzdEfFB+xlpWgr31OCFqNtS4UNmdReFIfN7lOKSuCi/kKDFJn7wRiX03gQpVHSPLDf/Mle2ys0O7TQ0aswL2U2jVOUg5CY8Ve+97xtZrV9c4ocBn+eeDPDMF16rVfbCKloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915691; c=relaxed/simple;
	bh=NeMZADy/w2RQ5L4VFpy2syV2KRgNCTx8vg2cWM+vr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6aDNFdcVuu30Oxd7s1pa7ATfDP7h/rX1vUxZbEbkSJOBFOEbdlwK3eLlTS7zExG/pRpbqwJn3V56aTypKGBJrop8HAAJg8MRzWk0465ns2H3sOGPkPyW/lkgwGWQA0KvXYpEYBvtB9OGqosXNDULY1hdL5uVbzUtazj7O+dEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfURAcwJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5785199f7d1so496035a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716915688; x=1717520488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Kwp0ELgxMwtCubVN5m3j9ZXGTcZalcurbZoa6Jlk0=;
        b=ZfURAcwJgOjYAyvsv+P9FXbWe55ybojWj1DIuyeELF0pQ0+ck//pipJh+Mq3U0sieJ
         lTf0LVn12/yAsQ8FJhlOZ1sM+rxhYO83kxsNANvyavcjvTBL0wTPNHnG2CdFAfOKEkL/
         nUapGlqnz5LjFmouwF+6xS9YUqeDK0Eqv4SkFDHyHinBEpt9TymV6omjU4o1clIWsXrk
         N82DEFN11Z1JYw6o5linUk0ZCvIZke8YzhsWLlHsrFYKPWZuSBvp8hm7OBgYaoXbmAiS
         Mz0yYXiIrhz9XSUuPSUgobcmfFbXFqKd7Ih+8varU89Za9a9ZEIpfWsPZ6JAYNNLcR/z
         VE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716915688; x=1717520488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6Kwp0ELgxMwtCubVN5m3j9ZXGTcZalcurbZoa6Jlk0=;
        b=t3I12CpFfcu4Ny0uO+yT/d9f6GqcU10WWWB47WBtzHjQzUy7ILTwVHXu4vka2r38PN
         LA47pG4IMvF5awb7C4HAfba/SDbEbmOhM14ITMEKwFjKRAwalfHySES7vpEYV9D63M2t
         ZRZQ+9gpAid1/KsB2FrZbQUVqY7WT9Q3exBnK9thb/HN+Y8IGiTwlKH3jOHLRAjhUr3W
         6mUplhJg7t6ds14eHgewnO7cOZ7iAIFPVzMPphCxd5BVa1000cI0pnaCgAJIbAzO4pL4
         lZADEARE9s59/oyPcUrFEl6QONILHHXZndjTUlMRtCBwJtCTBPG8thzMExLs7gR7itcm
         9uGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSGxo5QxiNw7AbKqpkARBtz3uucQ9YT96KydcUdcMSdTk5L+r8Ts0ASdxHEy1JBdWdF0UkKpVW0BHN/k01A9p096BBEOPgfNbJzwKt
X-Gm-Message-State: AOJu0YzSp2B8y1hTTikfJTL3ExAyudcRH0YYKWcZchByqROHtd+YJAfY
	ezVCaRKXNlDnzaGJb61gHORdAkukBq9IUW+k+7EQaKp3oVMOnvsp
X-Google-Smtp-Source: AGHT+IF7GpIVareNwPPWMc2UKlty9KlkOpf/TVkilHV0EQ2nM4N4DlisT6h/VIrh6+8sRZ9ou4BLDA==
X-Received: by 2002:a50:c309:0:b0:578:6c08:88fb with SMTP id 4fb4d7f45d1cf-5786c088c0bmr6799260a12.12.1716915687602;
        Tue, 28 May 2024 10:01:27 -0700 (PDT)
Received: from rex (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579cd4c85c7sm3793847a12.20.2024.05.28.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:01:27 -0700 (PDT)
Date: Tue, 28 May 2024 19:01:25 +0200
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kmsan: do not wipe out origin when doing partial
 unpoisoning
Message-ID: <ZlYN5Wh4zDgRIrAx@rex>
References: <20240528104807.738758-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528104807.738758-1-glider@google.com>

On Tue, May 28, 2024 at 12:48:06PM +0200, Alexander Potapenko wrote:
> As noticed by Brian, KMSAN should not be zeroing the origin when
> unpoisoning parts of a four-byte uninitialized value, e.g.:
> 
>     char a[4];
>     kmsan_unpoison_memory(a, 1);
> 
> This led to false negatives, as certain poisoned values could receive zero
> origins, preventing those values from being reported.
> 
> To fix the problem, check that kmsan_internal_set_shadow_origin() writes
> zero origins only to slots which have zero shadow.
> 
> Reported-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Link: https://lore.kernel.org/lkml/20240524232804.1984355-1-bjohannesmeyer@gmail.com/T/
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kmsan/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index cf2d70e9c9a5f..95f859e38c533 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -196,8 +196,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
>  				      u32 origin, bool checked)
>  {
>  	u64 address = (u64)addr;
> -	void *shadow_start;
> -	u32 *origin_start;
> +	u32 *shadow_start, *origin_start;
>  	size_t pad = 0;
>  
>  	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
> @@ -225,8 +224,16 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
>  	origin_start =
>  		(u32 *)kmsan_get_metadata((void *)address, KMSAN_META_ORIGIN);
>  
> -	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++)
> -		origin_start[i] = origin;
> +	/*
> +	 * If the new origin is non-zero, assume that the shadow byte is also non-zero,
> +	 * and unconditionally overwrite the old origin slot.
> +	 * If the new origin is zero, overwrite the old origin slot iff the
> +	 * corresponding shadow slot is zero.
> +	 */
> +	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
> +		if (origin || !shadow_start[i])
> +			origin_start[i] = origin;
> +	}
>  }
>  
>  struct page *kmsan_vmalloc_to_page_or_null(void *vaddr)
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

Tested-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>

