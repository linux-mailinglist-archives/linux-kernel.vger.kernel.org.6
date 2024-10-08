Return-Path: <linux-kernel+bounces-354804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3D9942CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EFF2820BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9231E1032;
	Tue,  8 Oct 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSJpxKSy"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE112C484
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376324; cv=none; b=LwV+3p0r5AjWYgOPcT9afPhwppXr9odX3yaENLeZg93DvkIxWm6MfEikUZZuAg1MMQCZQfits37Dhr75QTeHiv/APRI4DfCNiVaqkq9prgya0dNwz0oC07rBF0dfJkxSGp0X20pahvTT0ACgsgDjynV4/3sPV4a3Uz1kEEael+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376324; c=relaxed/simple;
	bh=Z75Sn9GTcfm0xV4hLIAiqsia//gfc5SQstwS3gjzZIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBSXyIPl++iD0jLVUfkf2DWc9QjkCUSrSCygEtAi+l38rFc3YAB6kmM8TAbEiglMjNOKflqJJJ7ztx+yUJjhfG/wFpKf85PTBoiI/iRXRR/PUgWEmJKXA6I6AA5u2TlDX5fiG3+qFcO8Y3cOQu7dBm16HYVzsUd1ZFi70S0Ec0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSJpxKSy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so6681983e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728376320; x=1728981120; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu+DR2ol7NHxdHwZDLwzTYqI016h/oGfPfj/9x7pI30=;
        b=fSJpxKSy/D5WolJwqduy3V+5rrCpXVUXGB8UX1HsdXKRVflCJMpPemXg61GQVnkFFA
         jAKoRT+NwIt7e6XAY1Qo5T/j6MFQESzv5Yfw/RSVl5Wwf6EUWhfacXE3jMj6ctsGnPcG
         p91nvgc/rPrTI7rmPlgN16yjf8x556rnzecWEJG4hxZYHwI1NrQxh5XJ2MvoMJVjtvJO
         +nfUEwzwNLlj9TIw+Wn2LCLeQG3qy5exh5aYG75S0rmEBDtJvX3iEVGr4HtYovtkc6RO
         pYmIrYxMLGVvrAcWjTCJm2edkFwcolOMhl+SoFcVhlNYcM5YnDs5SIgLwtpa0qzVx+Ky
         +/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376320; x=1728981120;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu+DR2ol7NHxdHwZDLwzTYqI016h/oGfPfj/9x7pI30=;
        b=AMRy31zYIHEvTv4mWeOXWrTIyApeKewArsjADZkaQmZJaUXw5rb6bUmUnZ2Ius1ft7
         yBX5xMAIFGvBmxUzhItVEq0ntXAil7p5V6aejdpl56Ga5U/uby2GkjQLcXZzaFGj1h6Y
         UiOIEWZCEFVIdkkRuPOsFNv0vwYFeKljOYZuEuQ+HRXHRlwhaVK7Dof2EA7/vnGu83xG
         rnQCQPZIoG6e6h0e8WMoCq+kgRBN2JDQCsLqfLI0fw6JWr81Lf3g5S3QReKjEcPyH3US
         0Rdy3pTWhL3RyWDdgph6D6U3Mwgva8KhDKIpNTY5WiP5iWIfaRbEk1g1/kAu0kSa1885
         UHCg==
X-Forwarded-Encrypted: i=1; AJvYcCXbdidhpqvY4pEkUih9llrbpjEZb6frR2SkeNXJixTmwWMyyOeHkyJIxPjIUgFKXrUGINWyWK4oQQLYQqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziAF+qBzx86Kq4ke8gusPVSamrdX8axkq+fvNFCrLQa3r72o9E
	NEWfP41HYRDkpMqB+YfoCgIrI6quEFjgKaRJ/4PuMeIn502ZAgS3/YZDjo+cig==
X-Google-Smtp-Source: AGHT+IHRPjdEucYpIL19B14B0iOgGVC/Si4jbJW6VKT4Gyy1C4mm+LnefOrrfcRw+0WtP/7jvOcAtw==
X-Received: by 2002:a05:6512:104b:b0:536:a5ee:ac01 with SMTP id 2adb3069b0e04-539ab86288amr6724752e87.4.1728376319850;
        Tue, 08 Oct 2024 01:31:59 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:c862:2d9d:4fdd:3ea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm118748205e9.44.2024.10.08.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:31:59 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:31:53 +0200
From: Marco Elver <elver@google.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, bpf@vger.kernel.org,
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH v2 1/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
Message-ID: <ZwTt-Sq5bsovQI5X@elver.google.com>
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
 <20241005164813.2475778-1-snovitoll@gmail.com>
 <20241005164813.2475778-2-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005164813.2475778-2-snovitoll@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Sat, Oct 05, 2024 at 09:48PM +0500, Sabyrzhan Tasbolatov wrote:
> Instrument copy_from_kernel_nofault() with KMSAN for uninitialized kernel
> memory check and copy_to_kernel_nofault() with KASAN, KCSAN to detect
> the memory corruption.
> 
> syzbot reported that bpf_probe_read_kernel() kernel helper triggered
> KASAN report via kasan_check_range() which is not the expected behaviour
> as copy_from_kernel_nofault() is meant to be a non-faulting helper.
> 
> Solution is, suggested by Marco Elver, to replace KASAN, KCSAN check in
> copy_from_kernel_nofault() with KMSAN detection of copying uninitilaized
> kernel memory. In copy_to_kernel_nofault() we can retain
> instrument_write() for the memory corruption instrumentation but before
> pagefault_disable().

I don't understand why it has to be before the whole copy i.e. before
pagefault_disable()?

I think my suggestion was to only check the memory where no fault
occurred. See below.

> diff --git a/mm/maccess.c b/mm/maccess.c
> index 518a25667323..a91a39a56cfd 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
>  
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
>  	while (len >= sizeof(type)) {					\
> -		__get_kernel_nofault(dst, src, type, err_label);		\
> +		__get_kernel_nofault(dst, src, type, err_label);	\
>  		dst += sizeof(type);					\
>  		src += sizeof(type);					\
>  		len -= sizeof(type);					\
> @@ -31,6 +31,8 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!copy_from_kernel_nofault_allowed(src, size))
>  		return -ERANGE;
>  
> +	/* Make sure uninitialized kernel memory isn't copied. */
> +	kmsan_check_memory(src, size);
>  	pagefault_disable();
>  	if (!(align & 7))
>  		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
> @@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>  
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
>  	while (len >= sizeof(type)) {					\
> -		__put_kernel_nofault(dst, src, type, err_label);		\
> +		__put_kernel_nofault(dst, src, type, err_label);	\
>  		dst += sizeof(type);					\
>  		src += sizeof(type);					\
>  		len -= sizeof(type);					\
> @@ -62,6 +64,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
>  		align = (unsigned long)dst | (unsigned long)src;
>  
> +	instrument_write(dst, size);
>  	pagefault_disable();

So this will check the whole range before the access. But if the copy
aborts because of a fault, then we may still end up with false
positives.

Why not something like the below - normally we check the accesses
before, but these are debug kernels anyway, so I see no harm in making
an exception in this case and checking the memory if there was no fault
i.e. it didn't jump to err_label yet. It's also slower because of
repeated calls, but these helpers aren't frequently used.

The alternative is to do the sanitizer check after the entire copy if we
know there was no fault at all. But that may still hide real bugs if
e.g. it starts copying some partial memory and then accesses an
unfaulted page.


diff --git a/mm/maccess.c b/mm/maccess.c
index a91a39a56cfd..3ca55ec63a6a 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -13,9 +13,14 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 	return true;
 }
 
+/*
+ * The below only uses kmsan_check_memory() to ensure uninitialized kernel
+ * memory isn't leaked.
+ */
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
 		__get_kernel_nofault(dst, src, type, err_label);	\
+		kmsan_check_memory(src, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -31,8 +36,6 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
-	/* Make sure uninitialized kernel memory isn't copied. */
-	kmsan_check_memory(src, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
@@ -52,6 +55,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
 		__put_kernel_nofault(dst, src, type, err_label);	\
+		instrument_write(dst, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -64,7 +68,6 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	instrument_write(dst, size);
 	pagefault_disable();
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);

