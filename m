Return-Path: <linux-kernel+bounces-523274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8DA3D4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C10171044
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717E1EC01E;
	Thu, 20 Feb 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpY7ULhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099C1E9B38
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043432; cv=none; b=mnMdXjUuuTIuZyjqn/wi0QjV8CC4GXK3pbH4hfC2HZMaZGjeoib1QOfPVhLvn2F7tGGk+h/AYuDfYb+bUL4iTF5+EDWGe6E+C9ZJFdyBmo0Tng/GcuiUkc9weYRieR+nMtPgHI9t06lRvnxFKN7/f7HnXckYwdz+b2n/jFt7Acc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043432; c=relaxed/simple;
	bh=h+6SU1758Xm6bhSjW+4gwk334IJ9TK8GodX4KZSMA74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJwwoW8jqZ9BDd7uI8ZCniLz7HXiGGkCI+oM4pFpwuC0Rc/eMvpIIbS26ebdqGbBXwbBv8pg0Fw2xiEjR/B9LODdj9/myMNQh4b8fSxBHuvGBI5LxDWKVbKabqQsDlJmwI7qv4++fXWa1bRO9yCbWHEFOEqvM/I9hYwN4eogqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpY7ULhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF5BC4CEE8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043431;
	bh=h+6SU1758Xm6bhSjW+4gwk334IJ9TK8GodX4KZSMA74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YpY7ULhscqimxbzR+THQ5lSOyZ1511lHYKtSUEWa5eQqRzEUcU71IS3rsh6YIPXoA
	 vCbsLdmztnDqVGYRwhgM+zhlLwZdEpjkFv9KCGIAAqmkmiS8ibvRCbDskwDGcGNXku
	 f5nd6gG7zFd3Ni+QNWbJiDkwfcidtSyc/iVgbCtGuDcYRJwOmoOFvEOa3eAHFjgNro
	 9loXMGMkTfnEZWX4TsN52kZ1/DYKD4flSXbTC/8vXO3MPpM8CyFxA2c62+zrY8ll/u
	 x6REBdQWygPeFp+/8rT+KLjvCt3gPkGjPiHyZZMAqAynuvq7glwXr3ir9mMjL1BYvT
	 3t+JTmQg1pRdA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30918c29da2so6910151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:23:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVawc/0/OME3HNfzYirceGLi3OrpvdytH/I8JUd5fen6Y/1XqXrOu9HNXcRcosK2I7mx4HqIP3sGlxutUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOHILlXNFrlZ/Gquh3H3XGpHVMiiOnhREfOLyni+HXbMLMWPP
	6MpfUqfvbQY13a4BNrq7xvVNuxH32yAWeAReK/VBLWSxyIvA11ZYAm44SJbdl9EPxYVwStlaHwA
	YM6XryfRDAs0ZFCMmalYo2ZEZTNk=
X-Google-Smtp-Source: AGHT+IHqRt4eH4js/eG3ZfyiiJyegi/p4VsZC59PyvNITsYHx6un3wVpuZYtDTy4Q8xRFS/1bw71SJ8fMFBlpFsQUAI=
X-Received: by 2002:a05:6512:3992:b0:545:d7d:ac53 with SMTP id
 2adb3069b0e04-5452fe86db1mr8784368e87.34.1740043430003; Thu, 20 Feb 2025
 01:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-8-brgerst@gmail.com>
 <20250219195948.GA3075960@ax162>
In-Reply-To: <20250219195948.GA3075960@ax162>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 10:23:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFAwnBi0EjRJaB-MpqPCmV+tYRN7Dw_PUJuxxrnaEnoKg@mail.gmail.com>
X-Gm-Features: AWEUYZlk2aXlYmiuKHscKrCxaSiNUZxu8-o6V_PCHRaxQcl-rmOgjuju9l_VDUg
Message-ID: <CAMj1kXFAwnBi0EjRJaB-MpqPCmV+tYRN7Dw_PUJuxxrnaEnoKg@mail.gmail.com>
Subject: Re: [PATCH v6 07/15] x86/stackprotector/64: Convert to normal percpu variable
To: Nathan Chancellor <nathan@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 20:59, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Jan 23, 2025 at 02:07:39PM -0500, Brian Gerst wrote:
> > Older versions of GCC fixed the location of the stack protector canary
> > at %gs:40.  This constraint forced the percpu section to be linked at
> > absolute address 0 so that the canary could be the first data object in
> > the percpu section.  Supporting the zero-based percpu section requires
> > additional code to handle relocations for RIP-relative references to
> > percpu data, extra complexity to kallsyms, and workarounds for linker
> > bugs due to the use of absolute symbols.
> >
> > GCC 8.1 supports redefining where the canary is located, allowng it to
> > become a normal percpu variable instead of at a fixed location.  This
> > removes the contraint that the percpu section must be zero-based.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
> ...
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 5b773b34768d..88a1705366f9 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
> >          # temporary until string.h is fixed
> >          KBUILD_CFLAGS += -ffreestanding
> >
> > -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> > -        ifeq ($(CONFIG_SMP),y)
> > -            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
> > -                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
> > -        else
> > -            KBUILD_CFLAGS += -mstack-protector-guard=global
> > -        endif
> > -    endif
> > +        percpu_seg := fs
> >  else
> >          BITS := 64
> >          UTS_MACHINE := x86_64
> > @@ -197,6 +190,17 @@ else
> >          KBUILD_CFLAGS += -mcmodel=kernel
> >          KBUILD_RUSTFLAGS += -Cno-redzone=y
> >          KBUILD_RUSTFLAGS += -Ccode-model=kernel
> > +
> > +        percpu_seg := gs
> > +endif
> > +
> > +ifeq ($(CONFIG_STACKPROTECTOR),y)
> > +    ifeq ($(CONFIG_SMP),y)
> > +     KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
> > +     KBUILD_CFLAGS += -mstack-protector-guard-symbol=__ref_stack_chk_guard
> > +    else
> > +     KBUILD_CFLAGS += -mstack-protector-guard=global
> > +    endif
> >  endif
>
> -mstack-protector-guard-symbol was only added in clang-15, so it looks
> like min-tool-version.sh will need an adjustment like GCC did, should I
> send a patch?
>

Yes, please.

