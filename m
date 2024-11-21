Return-Path: <linux-kernel+bounces-417398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0A9D5387
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E603FB2143B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593201C4A0B;
	Thu, 21 Nov 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bF+M0USy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D89B67F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218224; cv=none; b=tR35Vc9LN+QktNiX+ThgMCtIu2OoBYH5uGtiiqHEg7n+Gdh0E8smfr2IP9MYu8WuXWjYfnGmD8eZj552Jc7ssKRl0mEPKfu7TLlS9bcRUlKxd6l/xjKGTVQnxQQyFqlQ6EYhmy/rpYI2qKs8SoUxzCJMax4CiuHbbdQReS4j9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218224; c=relaxed/simple;
	bh=3pVNURDtgONJDsWe1bAQPEb4yOftfgN0do1o24L3dLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mrw0J0+/+bKialhSAZi4Xla+b7lkVcO+0POHnBeSv2TCejODNjMrLnYeJ2rHW6EQTtUHGd4UmroZTW+KfXLoAn7uiF3SeFxrmCVRhlD3nH6EqNzBUoH6nz9KU6UqNxKR2HbVJyTS8j763yNYNqLUruaq8lIO7weWXru9tgjLWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=bF+M0USy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so11689935e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1732218221; x=1732823021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb6cktfDOPOMZA+/MMxug0SV35vQrXOUr8jfou5LGgc=;
        b=bF+M0USycPCv3ltBNcy3/FjfTv3LVkzt56aSnB+STVn6PuP5l+qPR9c/YlSTh/aqWm
         LqaTGYwcJ0Rz9Gn1kkcZfvNWZYfLSyTKyzSwn7cmKE4FmDTvzHZrEFiUSLn58af3MbjL
         GDmJ3tfWVlrTLOQZi/TxBfZFSr7cY1TkQ3aIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218221; x=1732823021;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb6cktfDOPOMZA+/MMxug0SV35vQrXOUr8jfou5LGgc=;
        b=oyzrZAy3/TODtBqpHUcC7TZj0Xr58RcYD5YdDg7PejXv6PSi5ZpfhW1JPhwlHiVY9e
         1TFrzfM5BmQ9+GXGtEneLK5eJyS1tpJOsueYhOGsGFW5oJMl7HPkmCfuoP1xdnutFPBm
         tggm0afNFysUyatI6WEFiXONxf6/IFEM5a8boVeDZ7P5sbXLQzj//7Ke6kZ8wOq83Vw2
         paZWQAMC6It7cgYGig9f7FmM6oGbBhQ1xfX8KXBLDT0lmzfJwwTqlj3X5jl8HnssLPLP
         Gr93EGu/Vr5srxZa2BmTx/5xpJD2IMgNQkOsObCX3nUrOUdjc5iQhyw3baxRJQBkHw0Y
         P5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH5KG8mWkHLlSZ8oGQ6iBCHXpY44UsFj7ltMp8nVxUxB328wSir83qt1oIVwtJkSsivBFO06yb8lY5gY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyexv0HbFZfU70rAvD+z7Ng/jWXSpJRCBt1VciiSgT5uLPBgSl+
	4J1+zQsUS1xlBcgpczY6EVvg9WRc33D7k8EazqkF1+6yn6K65sHK6O3KOBu3yy0=
X-Gm-Gg: ASbGncuFu/lk17d3UKSt8wq/UPL1SYVJVWgO8weVZ4A09kPuosSErRsHVNqcWiqvQyj
	EofCnPQuHe/ZlPGOWUJxlSEOTvXt/pNd++HhSpiXFHd12RO1luju64amMkUzv9rXCNcWEBm1eNt
	J2lv21aeSGs8lFABqc3SS2h1VDf4OQpaJ3feUmiBLgRwJmE3dda96uIfZu9+HMqhCv/DsNYM29J
	vqbViVRRehJP8otEUCeeuy3ii5XjMc1LwomX2XMaRt+Uzv7gaPf2aZ94CQjbHMhcOD54HvM/Mhu
	zCGOTZC+Ok5oRA==
X-Google-Smtp-Source: AGHT+IHcci7X1xqJIP7ghbLb3Ni8LRODJRzAIOIeiNtALvIdrx4QnjEwSvhG9z0qRu9p2gb64K4KvA==
X-Received: by 2002:a05:600c:1ca2:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-433ce4101a1mr636725e9.2.1732218220717;
        Thu, 21 Nov 2024 11:43:40 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab1fsm64747755e9.29.2024.11.21.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 11:43:39 -0800 (PST)
Message-ID: <029284c6-f103-46e0-9acd-9e9e816e7ffb@citrix.com>
Date: Thu, 21 Nov 2024 19:43:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/ia32: Leave NULL selector values 0~3 as is
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 brgerst@gmail.com, ebiederm@xmission.com
References: <20241121175446.3481862-1-xin@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241121175446.3481862-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2024 5:54 pm, Xin Li (Intel) wrote:
> The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
> and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
> GDT, selector values 0~3 all point to the NULL descriptor, thus values
> 0, 1, 2 and 3 are all valid NULL selector values.
>
> When a NULL selector value is to be loaded into a segment register,
> reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
> DS segment registers if any of them is found to have any nonzero NULL
> selector value.  The two operations offset each other to actually effect
> a nop.
>
> Besides, zeroing of RPL in NULL selector values is an information leak
> in pre-FRED systems as userspace can spot any interrupt/exception by
> loading a nonzero NULL selector, and waiting for it to drop to zero.
> But there is nothing software can do to prevent it before FRED.
>
> ERETU, the only legit instruction to return to userspace from kernel
> under FRED, by design does NOT zero any segment register to avoid this
> problem behavior.
>
> As such, leave NULL selector values 0~3 as is.
>
> Do the same on 32-bit kernel as well.
>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

As far as fixing up RPL goes, I think the patch is fine, and probably
wants to be taken in roughly this form (new minor points below).

However, the pre-existing code is doing something entirely bizarre,
which warrants further investigation, and maybe fixes.

> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index ef654530bf5a..23879f14aa51 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -33,6 +33,29 @@
>  #include <asm/smap.h>
>  #include <asm/gsseg.h>
>  
> +/*
> + * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
> + * and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
> + * GDT, selector values 0~3 all point to the NULL descriptor, thus values
> + * 0, 1, 2 and 3 are all valid NULL selector values.
> + *
> + * However IRET zeros ES, FS, GS, and DS segment registers if any of them
> + * is found to have any nonzero NULL selector value, which can be used by
> + * userspace in pre-FRED systems to spot any interrupt/exception by loading
> + * a nonzero NULL selector and waiting for it to drop to zero.

I know I wrote "drop to zero", but in hindsight, I think "become zero"
would be better.

>   Before FRED
> + * there is nothing we can do to prevent such an information leak.
> + *
> + * ERETU, the only legit instruction to return to userspace from kernel
> + * under FRED, by design does NOT zero any segment register to avoid this
> + * problem behavior.
> + *
> + * As such, leave NULL selector values 0~3 as is.
> + */
> +static inline u16 usrseg(u16 sel)

I would suggest naming this fixup_rpl() which is a bit clearer as to its
intent.

However, I would also recommend u32 (or at least, unsigned int).

It's absolutely marginal, but you do get better code generation by
avoiding u16 specifically where possible.

https://godbolt.org/z/MnnvW461f

> +{
> +	return sel <= 3 ? sel : sel | 3;
> +}
> +
>  #ifdef CONFIG_IA32_EMULATION
>  #include <asm/unistd_32_ia32.h>
>  
> @@ -41,17 +64,17 @@ static inline void reload_segments(struct sigcontext_32 *sc)
>  	unsigned int cur;
>  
>  	savesegment(gs, cur);
> -	if ((sc->gs | 0x03) != cur)
> -		load_gs_index(sc->gs | 0x03);
> +	if (usrseg(sc->gs) != cur)
> +		load_gs_index(usrseg(sc->gs));
>  	savesegment(fs, cur);
> -	if ((sc->fs | 0x03) != cur)
> -		loadsegment(fs, sc->fs | 0x03);
> +	if (usrseg(sc->fs) != cur)
> +		loadsegment(fs, usrseg(sc->fs));
>  	savesegment(ds, cur);
> -	if ((sc->ds | 0x03) != cur)
> -		loadsegment(ds, sc->ds | 0x03);
> +	if (usrseg(sc->ds) != cur)
> +		loadsegment(ds, usrseg(sc->ds));
>  	savesegment(es, cur);
> -	if ((sc->es | 0x03) != cur)
> -		loadsegment(es, sc->es | 0x03);
> +	if (usrseg(sc->es) != cur)
> +		loadsegment(es, usrseg(sc->es));
>  }
>  
>  #define sigset32_t			compat_sigset_t
> @@ -113,10 +136,10 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
>  	 */
>  	reload_segments(&sc);

This is the singular caller of reload_segments(), and the comment out of
context does not match the implementation.

It probably wants inlining just so all the segment juggling is in one place.

>  #else
> -	loadsegment(gs, sc.gs);
> -	regs->fs = sc.fs;
> -	regs->es = sc.es;
> -	regs->ds = sc.ds;
> +	loadsegment(gs, usrseg(sc.gs));
> +	regs->fs = usrseg(sc.fs);
> +	regs->es = usrseg(sc.es);
> +	regs->ds = usrseg(sc.ds);
>  #endif

Why is GS handled specially?

Both, 1) Why is regs->gs the only value that doesn't an RPL-adjusted
value, and 2) why do we need to reload it here?  We need to keep it as
the per_cpu pointer anyway, and we're going to reload on exit-to-user,
aren't we?

Also, why do we have such wildly-different behaviours depending on
IA32_EMULATION or not?

~Andrew

