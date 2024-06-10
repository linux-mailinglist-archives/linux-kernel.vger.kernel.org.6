Return-Path: <linux-kernel+bounces-208707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA00902859
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815F01F21982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307E14D2AB;
	Mon, 10 Jun 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bOb58nJJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6B152DE7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042826; cv=none; b=YX6Z+f+o6479e8ADMESIXDDGSow6xGAhAgLv9LgjH+PUtQqcgAVxhTlh65nrVgleq7wFmsQzLP0/Iq3qc9IEdhZ88LoU40i1jieB27mL/CCyFTft4aAFJ5BclMLYPdKuIXisbF5gdKbUyLj+Rc3tWr1xUzpyS6QxBPxzmEHDDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042826; c=relaxed/simple;
	bh=IEMruENEL3ierTK2Q7GOjtcBtiocQYEg6s5U0b0zRD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxX27Ki90BHUoFym3ys3wTXUckjI4EzgS+yqYs2YqJXxyVZ9071UsXvyXUh6OtUEs8X27q0g3gqG2m9KtUJoI0Ya4DBMMat1F0rTW1v8HqbHGHV8qrt5YWStWmt23ZFk4aB/i00et7uMFwY9O9VimSjg9FEiEUZ3axn9klfLhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bOb58nJJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso24276566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718042822; x=1718647622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYkLMdQHI9XJCb3iOQ1AqKkfh0e7ysMUAFGnmxGuJNM=;
        b=bOb58nJJhzfM9JkysFi7LP/OeEECDtiwHtxOh51dUyiTT0jM3V6/cAj0o+ttk0LmSL
         HB9KSE7sLoUT2X9LDIECfSctrB1qK3fyiYGggXKWVBWycyslKuSE+fg+9L4hwC5Dqaj/
         JOn/NwEaxua+mwHD8y9vBl/4GgGOIX7m2r8sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042822; x=1718647622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYkLMdQHI9XJCb3iOQ1AqKkfh0e7ysMUAFGnmxGuJNM=;
        b=tc1kWPslN4h0wG2oag5rVadC6HYxvl4tEPwTVEq+f8NqXdkTUvDNj0KOcfrcZPXRmg
         RauVrD+Qc1OHLHTydmk2Kw9HqVtjyvk0fjv9gvTJ3gurNn/LoWEpDCCp7GjZ624aFRO0
         APE2Fl3yaPm+NtzlaP0DoMX/KvSqcgC/ZyF9hO1Fo2dhfzn2eQZq87sC+/QkN1m0hL0j
         Lz1IPHg2oUhOOLGoFaFVdQTVCnHKKPzgZ1NMT7fnbutpVwL/oZMGrFGNDPi8Gea1Xjv3
         5j+5PLLOqkQo79ljjtBApVD18+j3cwSkqSyi1SwHpWKJJL8TGxpI2/0IJNnIvLj7picH
         CYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWkZjVwFX65dnD6FHWwFOIEtJ0uZ3RaY52kcMBbrwsRmbHt9lkSA/XeCUJhieySQlb04kcfjdSybLI81uqKA5mT/E9OP63RKy/RGsy3
X-Gm-Message-State: AOJu0Yx1pqMMW85L0s2HuQRioviHWyO1FRATjBtzAeshQ1rUbi2cdv0Q
	iu7DysykjwrS7q3dLGdLd4wE2dVD27D3jqjmYQBW2lMhmG7/iaOoMej6lokzxaZAbyoQVGCknW2
	/JVI=
X-Google-Smtp-Source: AGHT+IFxw/acVB2EHXtGZZlJaDbxlYnAu6aKebw9z4yx/qtmDxzS9skXmVZFl0IZoKHs9NrcnbeOMA==
X-Received: by 2002:a17:907:9723:b0:a6f:1f7b:6a8b with SMTP id a640c23a62f3a-a6f1f7b6be5mr236570566b.66.1718042822298;
        Mon, 10 Jun 2024 11:07:02 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm333715566b.192.2024.06.10.11.07.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:07:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a52dfd081so169651a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwk7pAX34YgkGjDtFaqygu9v2HC0aY9I+jlwPeEr0pvgfHxtAq9BGJ29eOefbUzr1pYwt2vtWZhzfQOp37aEbyBwGU9hR8ro6fdqqT
X-Received: by 2002:a50:8d54:0:b0:574:ec8a:5267 with SMTP id
 4fb4d7f45d1cf-57c50990bc5mr6829442a12.31.1718042821079; Mon, 10 Jun 2024
 11:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <20240610104352.GT8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240610104352.GT8774@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 11:06:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5DAR=a12cbKbxDy875hTOtPmNUDEn+dU2VS47h9MgcQ@mail.gmail.com>
Message-ID: <CAHk-=wh5DAR=a12cbKbxDy875hTOtPmNUDEn+dU2VS47h9MgcQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 03:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- linux-2.6.orig/arch/Kconfig
> +++ linux-2.6/arch/Kconfig
> @@ -1492,6 +1492,9 @@ config HAVE_SPARSE_SYSCALL_NR
>  config ARCH_HAS_VDSO_DATA
>         bool
>
> +config HAVE_RUNTIME_CONST
> +       bool

No. We're not adding a stupid config variable, when nothing actually wants it.

> +#define __runtime_const(sym, op, type)                 \
> +({                                                     \
> +       typeof(sym) __ret;                              \
> +       asm(op " %1, %0\n1:\n"                          \
> +           ".pushsection __runtime_const, \"aw\"\n\t"  \
> +           ".long %c3 - .      # sym \n\t"             \
> +           ".long %c2          # size \n\t"            \
> +           ".long 1b - %c2 - . # addr \n\t"            \
> +           ".popsection\n\t"                           \
> +           : "=r" (__ret)                              \
> +           : "i" ((type)0x0123456789abcdefull),        \
> +             "i" (sizeof(type)),                       \
> +             "i" ((void *)&sym));                      \
> +       __ret;                                          \
> +})
> +
> +#define runtime_const(sym)                                             \
> +({                                                                     \
> +       typeof(sym) __ret;                                              \
> +       switch(sizeof(sym)) {                                           \
> +       case 1: __ret = __runtime_const(sym, "movb", u8); break;        \
> +       case 2: __ret = __runtime_const(sym, "movs", u16); break;       \
> +       case 4: __ret = __runtime_const(sym, "movl", u32); break;       \
> +       case 8: __ret = __runtime_const(sym, "movq", u64); break;       \
> +       default: BUG();                                                 \
> +       }                                                               \
> +       __ret;                                                          \
> +})

And no. We're not adding magic "generic" helpers that have zero use
and just make the code harder to read, and don't even work on 32-bit
x86 anyway.

Because I didn't test, but I am pretty sure that clang will not
compile the above on x86-32, because clang verifies the inline asm,
and "movq" isn't a valid instruction.

We had exactly that for the uaccess macros, and needed to special-case
the 64-bit case for that reason.

And we don't *need* to. All of the above is garbage waiting for a use
that shouldn't exist.

> +++ linux-2.6/kernel/runtime_const.c
> @@ -0,0 +1,119 @@

And here you basically tripled the size of the patch in order to have
just one section, when I had per-symbol sections.

So no.

I envision a *couple* of runtime constants. The absolutely only reason
to use a runtime constant is that it is *so* hot that the difference
between "load a variable" and "write code with a constant" is
noticeable.

I can point to exactly one such case in the kernel right now.

I'm sure there are others, but I'd expect that "others" to be mainly a handful.

This needs to be simple, obvious, and literally designed for very targeted use.

This is a *very* special case for a *very* special code. Not for generic use.

I do not ever expect to see this used by modules, for example. There
is no way in hell I will expose the instruction rewriting to a module.
The *use* of a constant is a _maybe_, but it's questionable too. By
definition, module code cannot be all that core.

             Linus

