Return-Path: <linux-kernel+bounces-259362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 854789394CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0D2B2137A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354336130;
	Mon, 22 Jul 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItdKMoff"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DB1C6A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721680567; cv=none; b=Hl/tFizthvWHKn+BChhxnWbFvAEdWlgjsoJQx6z/ww1cidTDWHyxJP8xQ+FJqL30ax4gmbk/YF+obwIHd7yHzh5nVv3oEFTuMZjhF4CwgaNKK/HyZzKZ2it/ZbllhsvXGF/7ut193E2d5fB+kuxC1lEcdyw2Vu62GHiim+ycqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721680567; c=relaxed/simple;
	bh=t+gGesO4JFMI51/BQ12FSv7JhNpLcty89I3kk+D35bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTtCYJX4Lj+gjnFD9ZK01CoiKZv1WszB9J1Z6+nRlXjeg2ZfXku5DBX7lHpOwTGluqlmnEqLQabNyam3nzuWtVkuiqQtM0IXJOAKMAxQeIO3fZmnn4DXlaVlfPFlewm9ynErpoYIU+tCxexybVlzEOYajPrdHSVyZ3i3c3ns7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItdKMoff; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so1004a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721680564; x=1722285364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wA86CUyO9g/UBTDzj6a6yBQ8gAzp68p6n3zkRO96JMs=;
        b=ItdKMoffs/zjtEgUGXal62kEkzjFBfEKlAxyTjA9gSrb/YApepLQZ7hAB/iOQcHylA
         UmAo+386JIbAX1+FoXKPiUjSb7teojLP6NIFtxtKoYmf1+EDmEM3YGO8bkLHAnc512/3
         lGjNQEFQ/mNNc+K6aoZlffxt8luIzVS+Z5AsXn2L2d+XHQvoJKc/jxiPb/JLGnUE4gX4
         6V7A6j8sBe1YAp6YvOUuU0CcdZTcDn5hp648BEah48b1drnTTf0i50WaHmrg1sVW18oc
         1W43w6ESnDRtvE77JMr42loKMV0PJF7vmGqBkA26Q76bwuXD1xwypcZbYiYLBwVOiOnq
         ECDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721680564; x=1722285364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA86CUyO9g/UBTDzj6a6yBQ8gAzp68p6n3zkRO96JMs=;
        b=HtEJSqYbknJ8rjvbchSQ1MIRadQZfVxkc9J1SuwzIKvMPIcQFJITGr0zBn6u9D8SsL
         //slIjuhYrDHXaU7fFifwsxovLl1xbPUpmMU4xcFuaQL2801uGlRimcvP9GxfFXs5Mmh
         D/5Wq0HzeagT2rUwmnA3j04oJTH2ocByuGz691DFoDoFv1cZtgWf4FR+3NXUlCqJYNs+
         1UYZ/JtHCDp9iSno0QCPHTlDT+TyeZoX3ovtVUnzv22ITLukYuWur2U9Gl5Y9gIP7MMU
         QbWcUnh5g52BdqGd2aUc/GxOCaIHP5Hsi3v0jmtswXhP++MSM0A9+Itc7PsBLz1Fmc9x
         jMlw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRThNRx5uiWdePpzEMoX0O4lpLhfYZyQSW73ycTOuYk2tX+x9UXe3+Bc33ouSVR/5nRczPYZMdFo20IcQxOXnQ3wdhGu9JnwJRPs/
X-Gm-Message-State: AOJu0YyrjOTZtHD8pTFTgjqZP3DpsTU8hP60ul3i0F08+5/93Sa88VNI
	8uGTfwotJW+uBPsOqWln5mX7oCZinGofHaVKj/Up3B53uR/sNXCBBJ6fz19idtOgCKfvl/BGI44
	GdaO5aGIWVpKSb0o9Aqf1iR0/kM8+95miZnsm
X-Google-Smtp-Source: AGHT+IEL8yHKgDnW66DeLnvb3sin3vG4Bx0NbeMag3+McuwPl/EBlyfvIoepc6XD1POPz+xZeXKEE7gjSZBeTn1mYUQ=
X-Received: by 2002:a05:6402:40c1:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5a4a8333773mr317602a12.1.1721680563688; Mon, 22 Jul 2024
 13:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722202502.70301-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240722202502.70301-1-andrey.konovalov@linux.dev>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 22 Jul 2024 22:35:52 +0200
Message-ID: <CACT4Y+Zb5ffw0MiYMNqT6YUSdJ7X6xDxJND0ZZPQ7SZmoGybXA@mail.gmail.com>
Subject: Re: [PATCH] x86, kcov: ignore stack trace coverage
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 22:25, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> When a multitude of kernel debugging options are enabled, they often
> collect and save the current stack trace. The coverage produced by the
> related routines is not relevant for the KCOV's intended use case
> (guiding the fuzzing process).
>
> Thus, disable instrumentation of the x86 stack trace collection code.
>
> KCOV instrumentaion of the generic kernel/stacktrace.c was already
> disabled in commit 43e76af85fa7 ("kcov: ignore fault-inject and
> stacktrace"). This patch is an x86-specific addition.
>
> In addition to freeing up the KCOV buffer capacity for holding more
> relevant coverage, this patch also speeds up the kernel boot time with
> the config from the syzbot USB fuzzing instance by ~25%.
>
> Fixes: 43e76af85fa7 ("kcov: ignore fault-inject and stacktrace")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> ---
>
> I'm not sure whether it makes sense to backport this patch to stable
> kernels, but I do think that it makes sense to take it into mainline
> as a fix: currently, the USB fuzzing instance is choking on the amount
> of coverage produced by KCOV and thus doesn't perform well.
>
> For reference, without this patch, for the following program:
>
> r0 = syz_usb_connect_ath9k(0x3, 0x5a, &(0x7f0000000080)={{0x12, 0x1,
> 0x200, 0xff, 0xff, 0xff, 0x40, 0xcf3, 0x9271, 0x108, 0x1, 0x2, 0x3, 0x1,
> [{{0x9, 0x2, 0x48, 0x1, 0x1, 0x0, 0x80, 0xfa, {{0x9, 0x4, 0x0, 0x0, 0x6,
> 0xff, 0x0, 0x0, 0x0, "", {{0x9, 0x5, 0x1, 0x2, 0x200, 0x0, 0x0, 0x0, ""},
> {0x9, 0x5, 0x82, 0x2, 0x200, 0x0, 0x0, 0x0, ""}, {0x9, 0x5, 0x83, 0x3,
> 0x40, 0x1, 0x0, 0x0, ""}, {0x9, 0x5, 0x4, 0x3, 0x40, 0x1, 0x0, 0x0, ""},
> {0x9, 0x5, 0x5, 0x2, 0x200, 0x0, 0x0, 0x0, ""}, {0x9, 0x5, 0x6, 0x2,
> 0x200, 0x0, 0x0, 0x0, ""}}}}}}]}}, 0x0)
>
> KCOV produces ~500k coverage entries.
>
> Here are the top ones sorted by the number of occurrences:
>
>   23027 /home/user/src/arch/x86/kernel/unwind_orc.c:99
>   17335 /home/user/src/arch/x86/kernel/unwind_orc.c:100
>   16460 /home/user/src/arch/x86/include/asm/stacktrace.h:60 (discriminator 3)
>   16460 /home/user/src/arch/x86/include/asm/stacktrace.h:60
>   16191 /home/user/src/security/tomoyo/domain.c:183 (discriminator 1)
>   16128 /home/user/src/security/tomoyo/domain.c:184 (discriminator 8)
>   11384 /home/user/src/arch/x86/kernel/unwind_orc.c:109
>   11155 /home/user/src/arch/x86/include/asm/stacktrace.h:59
>   10997 /home/user/src/arch/x86/kernel/unwind_orc.c:665
>   10768 /home/user/src/include/asm-generic/rwonce.h:67
>    9994 /home/user/src/arch/x86/kernel/unwind_orc.c:390
>    9994 /home/user/src/arch/x86/kernel/unwind_orc.c:389
>   ...
>
> With this patch, the number of entries drops to ~140k.
>
> (For reference, here are the top entries with this patch applied:
>
>   16191 /home/user/src/security/tomoyo/domain.c:183 (discriminator 1)
>   16128 /home/user/src/security/tomoyo/domain.c:184 (discriminator 8)
>    3528 /home/user/src/security/tomoyo/domain.c:173 (discriminator 2)
>    3528 /home/user/src/security/tomoyo/domain.c:173
>    3528 /home/user/src/security/tomoyo/domain.c:171 (discriminator 5)
>    2877 /home/user/src/lib/vsprintf.c:646
>    2672 /home/user/src/lib/vsprintf.c:651
>    2672 /home/user/src/lib/vsprintf.c:649
>    2230 /home/user/src/lib/vsprintf.c:2559
>    ...
>
> I'm not sure why tomoyo produces such a large number of entries, but
> that will require a separate fix anyway if it's unintended.)
> ---
>  arch/x86/kernel/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 20a0dd51700a..241e21723fa5 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -40,6 +40,14 @@ KMSAN_SANITIZE_sev.o                                 := n
>  KCOV_INSTRUMENT_head$(BITS).o                          := n
>  KCOV_INSTRUMENT_sev.o                                  := n
>
> +# These produce large amounts of uninteresting coverage.
> +KCOV_INSTRUMENT_dumpstack.o                            := n
> +KCOV_INSTRUMENT_dumpstack_$(BITS).o                    := n
> +KCOV_INSTRUMENT_stacktrace.o                           := n
> +KCOV_INSTRUMENT_unwind_orc.o                           := n
> +KCOV_INSTRUMENT_unwind_frame.o                         := n
> +KCOV_INSTRUMENT_unwind_guess.o                         := n

I've sent something similar recently, I think it should be in tip/x86 queue now:
https://lore.kernel.org/all/eaf54b8634970b73552dcd38bf9be6ef55238c10.1718092070.git.dvyukov@google.com/



>  CFLAGS_irq.o := -I $(src)/../include/asm/trace
>
>  obj-y                  += head_$(BITS).o
> --
> 2.25.1
>

