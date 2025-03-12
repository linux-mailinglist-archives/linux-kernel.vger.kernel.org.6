Return-Path: <linux-kernel+bounces-557588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED7A5DB40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89BC3B30FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A843226861;
	Wed, 12 Mar 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLd5HTb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666522E011
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778265; cv=none; b=INZ48oRWYglhZIDFsJbv3LMa7L6FP74A3QaGc9Pm8OQjQ6ujYDeC22BEpkeS/qrYyNZnyZEl8vqMJBkyqVm65gEnHD8afMb0Umvr4443u9BZtux4QSXsx7LqdPubPvxtFiQvX0qQ3sFgUzylKgv/nWfC45FITQfsDBmNJpnFZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778265; c=relaxed/simple;
	bh=Difxn6zmWwvn56SZkOIMlT0iFAGft8AMdExKepeek6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uva1JAI7z/QJR5l+GaGDUYGPQLJvujH9zTtax24wEI9DejuK/Bco0x9aTObW8iAwZrlaqL1kWlh8/u7/X7Mw5GM14XYpoD8msgc1rhJA6WbTRBu6Tf3PEIIYAW5HmZ1UoZFvigP49rV8USpd5xawK9iQa9SpOCDUY/DwGIHoJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLd5HTb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC1C4CEEC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778264;
	bh=Difxn6zmWwvn56SZkOIMlT0iFAGft8AMdExKepeek6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lLd5HTb9MevPNBZ0+2ofgnbkwNBfRmgUrwc/hpm2ntLz5gUINxvMZl1f9dgV//r3X
	 NN+C/cucaCKatnUGAecN2XCoGZStAen6OOlzOUt1USssK6DK7fNO/AbHA3ldLn6C89
	 GkjspVQ1zkC9KpaPmtD0dWMhn27h7pHhb59FEFxoGBOl2FM8BBhTgP+Kcv9P4r744L
	 2U1jUKX0hwTeh/mDD3aKdWtjtCvOaBf0PkLcd1cl773GOAH67RT7xjZvpkTNL+iWCY
	 JMHRlN+nQud5A2hfp9Mqh7pPOLmc9xzdTKzGCbGSDiKfDh7Nf/gFQlyZDob2kaRX2T
	 qSYtxYlxiIHJg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so7622912e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWONx+9zWD++8yLp6PimcdCYFhTeoF7LxqcQhgSPWorKIyqIpPX89GosVlGf5WiZqeTXZx44kJUaxdWNjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ce3tZB6i8Lfl/qGYxOKe6u/XloAGKIu6KoEYTNQ/iki8tgMz
	kRLmMoT8z/3Z+wxlcvs7c/bQXTlDFc6uZja+QuuX2jvHYTuOAG8YjIHJ2jB1FyhW3yc5ma2Y5E7
	ANxFlBJdQhDBLgQqf+x/BjwZu5eo=
X-Google-Smtp-Source: AGHT+IFAp+VMLw51ODDXur99a0Agz7RaRFEwezCXMBNUOZVaHg4yigLuulAvrQkyeXc9eyEHkHebcdHujgue2LtHfEU=
X-Received: by 2002:a05:6512:138b:b0:549:2ae5:99db with SMTP id
 2adb3069b0e04-549910cc14cmr8818192e87.45.1741778262832; Wed, 12 Mar 2025
 04:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312102740.602870-2-ardb+git@google.com> <CAMzpN2ig2wKf89Gx51MK=K96p4nHYPrqKQbpthB7d9bzNi_UDQ@mail.gmail.com>
In-Reply-To: <CAMzpN2ig2wKf89Gx51MK=K96p4nHYPrqKQbpthB7d9bzNi_UDQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Mar 2025 12:17:31 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH=nLb-KTJNz37NAvNHOgx60WRvq+-w-QzmzrtGg1PV8g@mail.gmail.com>
X-Gm-Features: AQ5f1JowaR2E6oYkS2l_C0H32K5FP8yp4w_PnEdDH6wPRpWBUmm3AS19SQdcCVI
Message-ID: <CAMj1kXH=nLb-KTJNz37NAvNHOgx60WRvq+-w-QzmzrtGg1PV8g@mail.gmail.com>
Subject: Re: [PATCH] x86/head/64: Avoid Clang < 17 stack protector in startup code
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	x86@kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 at 12:09, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, Mar 12, 2025 at 6:27=E2=80=AFAM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Clang versions before 17 will not honour -fdirect-access-external-data
> > for the load of the stack cookie emitted into each function's prologue
> > and epilogue, and will emit a GOT based reference instead, e.g.,
> >
> >   4c 8b 2d 00 00 00 00    mov    0x0(%rip),%r13
> >           18a: R_X86_64_REX_GOTPCRELX     __ref_stack_chk_guard-0x4
> >   65 49 8b 45 00          mov    %gs:0x0(%r13),%rax
> >
> > This is inefficient, but at least, the linker will usually follow the
> > rules of the x86 psABI, and relax the GOT load into a RIP-relative LEA
> > instruction.  This is still suboptimal, as the per-CPU load could use a
> > RIP-relative reference directly, but at least it gets rid of the first
> > load from memory.
> >
> > However, Boris reports that in some cases, when using distro builds of
> > Clang/LLD 15, the first load gets relaxed into
> >
> >   49 c7 c6 20 c0 55 86  mov    $0xffffffff8655c020,%r14
> >   ffffffff8373bf0f: R_X86_64_32S        __ref_stack_chk_guard
> >   65 49 8b 06           mov    %gs:(%r14),%rax
> >
> > instead, which is fine in principle, as MOV may be cheaper than LEA on
> > some micro-architectures. However, such absolute references assume that
> > the variable in question can be accessed via the kernel virtual mapping=
,
> > and this is not guaranteed for the startup code residing in .head.text.
> >
> > This is therefore a true positive, that was caught using the recently
> > introduced relocs check for absolute references in the startup code:
> >
> >   Absolute reference to symbol '__ref_stack_chk_guard' not permitted in=
 .head.text
> >
> > Work around the issue by disabling the stack protector in the startup
> > code for Clang versions older than 17.
> >
> > Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU =
variable")
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/init.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > index 0e82ebc5d1e1..8b1b1abcef15 100644
> > --- a/arch/x86/include/asm/init.h
> > +++ b/arch/x86/include/asm/init.h
> > @@ -2,7 +2,11 @@
> >  #ifndef _ASM_X86_INIT_H
> >  #define _ASM_X86_INIT_H
> >
> > +#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> > +#define __head __section(".head.text") __no_sanitize_undefined __no_st=
ack_protector
> > +#else
> >  #define __head __section(".head.text") __no_sanitize_undefined
> > +#endif
>
> Just disable it for all __head code.  This runs long before userspace
> can mount a stack smashing attack.
>

Not all of it - some code is emitted into .head.text because it is
called early, but it could still be called much later as well.

