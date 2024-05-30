Return-Path: <linux-kernel+bounces-195323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FE8D4B13
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384201C21377
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847217D359;
	Thu, 30 May 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izLM4MDr"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142417C7A3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070091; cv=none; b=nkU5fvmFm1n9AS0BGK0onfyPXwyM9Kx+Kn5MyDVn3YxLKCIQsJ790u1EwRIYCF3Lzdv4JBz7wzpkb+49/n+N7Ns/liAtaJvj5Ucxf7XZpuHK14gRgpeILaGqk+M7sJmuNjzehxALz+bSC5NnPTKM1o9H19xfJI+KYx4upDEaDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070091; c=relaxed/simple;
	bh=I8lM/d0xuu/SsQb7qufJ428dGZRSCPLdGjHg2ycnbxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9tnPImPBOJxRyGTE+Z3Gr3ZWCMl72+Zq4FWwvJa7Uci2lDkWIR7NXNV5AOvpPzAtNEJjUI7mb3zXrK8PO5neNfmd0KEHg5xfYlgd2gz4exvQhBhmYexewzU+tF30H/YJtxxKMPsGxMcAyq2lzC3JXPT37WgyMGSg6sVfQ8+TbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izLM4MDr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so516361a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070088; x=1717674888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9rKDBmL9soASvcn3puSMSoNCTN/9xOU0/NVh1/cveA=;
        b=izLM4MDro0niGuJ5Yt3CRNy5zKD7lMcjWLdPeyN0gmoVwn+hcEv8pZvxE3ToVT5UPf
         GmPI/Ggk6ViTCO0i4sBJiwtnyd45jc341XeNBfJGXcEQXcpuCdr3ItVCqif9uXWzd+gH
         jHmsA0nbppkR44H6LP6wfrI1VmTFdYCh0/PTEONHHSKsL+G18FtChRKQiH57Uw0s8dP+
         /Xi2hOrZznOC7uSHIKj1L+GIAedj8ezLuHq3qmwSceLqaitBy2gVImiB2kDUlCm8b3wN
         M5cOWoi6ccztlRjvhPNkTOy2INun3RVeDNZwyu3nobjrFHIU8YXgLxn70nbRIxYGs6qb
         UZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070088; x=1717674888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9rKDBmL9soASvcn3puSMSoNCTN/9xOU0/NVh1/cveA=;
        b=lr8b8o2ojnGLDFO9Mjib+CiKL9O+3FfBwk90T2p2oiY/WxqZWH/t0oUuI9XrS9CYfP
         Vk+ArzzelJkQXys9iFBKGv0YCjV1U39TGYKgUFiE09fskmprbMJUKU5S94X3WiStJd7/
         wVzWH4tnbChS0g884O+cumH0BlvXCV9Z8noTPGMY9YzyURUoh43jAomCwyhfsOllqLfx
         pHOM47BV4EECes2L+P2jIEOHig9/gzaZ9AINM/KuznyVjTb90R8dR1RZqVohkR0AVFe/
         eib+9SmZad8VDVOoeYdhbDEoi9NuQdYX8EAmVrP8xJYSdU743lQL1O3aRv47O41IQmsw
         CtCg==
X-Forwarded-Encrypted: i=1; AJvYcCWjpG4k8/Ye0rr0pdajMdSEFs+BeBw47Gx8ULbVm8y7+MTNhcT7sdNsYAg5BLbbH7VxsIFjwOe8YZk3G6f8VjfT6MYegPdmzvQDbDI+
X-Gm-Message-State: AOJu0YzgnULYKz7frENjAL7fxLWwVwNmN39sOsGId5FoHeVa5gE6fk+E
	NKuQgYI0eqw3UWlHUiPfTlAoiyEfQ1PTEfXf68HyGuMEJ1GhewUz
X-Google-Smtp-Source: AGHT+IHcrkRsHVuOzDKSWtKoLJ2lTeSArPw9M/N0SicJ+VQ9WKMaL79ZGbhBaK1qM+IkwbeVnJAhzg==
X-Received: by 2002:a50:9e05:0:b0:57a:1d5a:9cfa with SMTP id 4fb4d7f45d1cf-57a1d5a9f0bmr849627a12.38.1717070087662;
        Thu, 30 May 2024 04:54:47 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578f47126f0sm7346919a12.91.2024.05.30.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:54:47 -0700 (PDT)
Date: Thu, 30 May 2024 13:54:43 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix fully ordered LR/SC xchg[8|16]()
 implementations
Message-ID: <ZlhpA9NsgI0z6t/E@andrea>
References: <20240530075424.380557-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530075424.380557-1-alexghiti@rivosinc.com>

> -#define _arch_xchg(ptr, new, sfx, prepend, append)			\
> +#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend, append)		\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __new = (new);				\
> @@ -55,15 +55,15 @@
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
>  	case 2:								\
> -		__arch_xchg_masked(prepend, append,			\
> +		__arch_xchg_masked(sc_sfx, prepend, append,		\
>  				   __ret, __ptr, __new);		\
>  		break;							\
>  	case 4:								\
> -		__arch_xchg(".w" sfx, prepend, append,			\
> +		__arch_xchg(".w" swap_sfx, prepend, append,		\
>  			      __ret, __ptr, __new);			\
>  		break;							\
>  	case 8:								\
> -		__arch_xchg(".d" sfx, prepend, append,			\
> +		__arch_xchg(".d" swap_sfx, prepend, append,		\
>  			      __ret, __ptr, __new);			\
>  		break;							\
>  	default:							\
> @@ -73,16 +73,16 @@
>  })
>  
>  #define arch_xchg_relaxed(ptr, x)					\
> -	_arch_xchg(ptr, x, "", "", "")
> +	_arch_xchg(ptr, x, "", "", "", "")
>  
>  #define arch_xchg_acquire(ptr, x)					\
> -	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> +	_arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
>  
>  #define arch_xchg_release(ptr, x)					\
> -	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> +	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
>  
>  #define arch_xchg(ptr, x)						\
> -	_arch_xchg(ptr, x, ".aqrl", "", "")
> +	_arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")

This does indeed fix the fully-ordered variant of xchg8/16().  But this
also changes the fully-ordered xchg32() to

  amoswap.w.aqrl  a4,a5,(s1)
  fence   rw,rw

(and similarly for xchg64()); we should be able to restore the original
mapping with the diff below on top of this patch.

  Andrea

P.S. Perhaps expand the width of the macros to avoid newlines (I didn't
do it keep the diff smaller).

P.S. With Zabha, we'd probably like to pass swap_sfx and swap_append as
well to __arch_xchg_masked().


diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index e1e564f5dc7ba..88c8bb7ec1c34 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -46,7 +46,8 @@
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend, append)		\
+#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
+		   sc_append, swap_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -55,15 +56,15 @@
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
 	case 2:								\
-		__arch_xchg_masked(sc_sfx, prepend, append,		\
+		__arch_xchg_masked(sc_sfx, prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" swap_sfx, prepend, append,		\
+		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
 			      __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" swap_sfx, prepend, append,		\
+		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
 			      __ret, __ptr, __new);			\
 		break;							\
 	default:							\
@@ -73,16 +74,16 @@
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "", "")
+	_arch_xchg(ptr, x, "", "", "", "", "")
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
+	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")
+	_arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n", "")
 
 #define xchg32(ptr, x)							\
 ({									\


