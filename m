Return-Path: <linux-kernel+bounces-305153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FB962A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804DA1F21C46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417E14A605;
	Wed, 28 Aug 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdbJa3Mv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DA187FFE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855600; cv=none; b=tCxrZI1lccg7l6Hfu2WDrO3yhzfFm5/Xv3qLDUUzuwgUHa0Y2nic43ZRCYhLYUnZKvgWzYmT9JofSMZnKa41gW9LCe6Ms7X5m9c5/DmiybCu33Ynzx1R8FkbqxUa9mUbc3gJ4SL4pc4rAwmHPVXPjdfAM9yjoEqjQ+Lmb163udU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855600; c=relaxed/simple;
	bh=yH6sqxX1WpL6OPsv4TDQK+tHIH7AV+4pvUwbf1QyYvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUMii/4wYFuGyyl7qlOzJkX7+mTgBjygYZBTYuVlcOYOwyBFpxmktEqLIkO05omaYdh82pmMR/HT670q7Bx0uTEA+xMY33PvAUGhUp6DlMPuaX8CfKsuhAB83IEP9TVdst2HL+UoqVpINVByvB10H/VcPgdm78QkuPGE7E2dCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdbJa3Mv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so3251655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724855596; x=1725460396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/KA+QDqe/pnmROlU7V2SrEPUaaBFHZ25kPtl0skdw8=;
        b=EdbJa3Mv3qBdCp/f34yJ7Ss0Vv54V1qHG6Aa2qX+gJrcxmJIzZC1UI3pjG0BlOxwYJ
         QWVKLzmhPVZ3hICtxNOQgsIacXC7HCy0qZuRg1M9I+1YpAZ+lR4clKQQlc5/23C6U+Xk
         9Wh+j+N0wfEUKCT0WbadmBzx+S8C/1HNsPS7U+ghxuHjKuy5jmNjBbjeRD8Z36ylJHQD
         lraiK9E6WtCUKqrX4S7XvIWXYHJZwWm3M7uJyU2OpoSKR1NCf7IdpeNkTRWudNlKM5Di
         caggUQw0AC42JsLcpKNm4qxPUFAkDTG3VNuXAobDeoMcwCF07wTbCJzVsxwsMMs397UL
         vXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855596; x=1725460396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/KA+QDqe/pnmROlU7V2SrEPUaaBFHZ25kPtl0skdw8=;
        b=iFgdmoAqm4mNXMcGydevcI7euYRgjL9VP+rBN5uDjM4u9zeiAChasXbOkuBJkftv79
         x+0rVT1IBa223nrLH0YjlJHsgPlwLjL5WBmQ8FOYPTgkkaQMuo3G+iAvVee48tFt+GGv
         4OpbPgJlLYuHpUGHyUiQnh2v35I8f9Wq4Q7x0ZxSZ+s36S03dlRjHL1dEKPDbwVUkzRl
         Ss2mt9xf2qsD2vXp0MFNDdsFiI0DP91mfcNi7Z1AeOrDCBv4xDvgH2kZdlPo7yljxIkG
         Jozo0PzgKeqatw+KqdkaWVFWOabnVGpm9I4+Nz+BC5AfELfdayJkE2VNf5t+bOaJN4iy
         LjgA==
X-Forwarded-Encrypted: i=1; AJvYcCVyJyOKj56QH45fP+YtIiocNs7E+Tma/h14J2G+/0Jmi2RxNOT0V8x7gYEVkj9F7MBV+rwn8kEwsUjO+J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNDoUtOwOuGKijhFsKsi3kQN0G48COJmuzJFwM1sCXxdNxNos
	eZmsEaXZ2djLhUK6LHFlGrO+Fd2SMeuxGYfTpe3GbpOE7ad5A/U0fA98R54lrtuz6PTO0i1lvPP
	4Bby2bgxhgiYcaWKgeocvT9KLTPYFju43E+/F
X-Google-Smtp-Source: AGHT+IFngu+lOZiQhK7I2JkEpmzUKSWgHSV7Du7I8jr3kRO7LtLBrAaDzIIQMrFM36Ky24PXORx0Se/LhC4+5fVBhYo=
X-Received: by 2002:adf:b19c:0:b0:368:37e3:dff7 with SMTP id
 ffacd0b85a97d-37311863b94mr11429728f8f.34.1724855596065; Wed, 28 Aug 2024
 07:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-shadow-call-stack-v6-1-495a7e3eb0ef@google.com> <CAMj1kXGtH+yna6CLncxTYi+ie2WF5-nSA3q0Re9L1VJt1EoQ9A@mail.gmail.com>
In-Reply-To: <CAMj1kXGtH+yna6CLncxTYi+ie2WF5-nSA3q0Re9L1VJt1EoQ9A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 28 Aug 2024 16:33:03 +0200
Message-ID: <CAH5fLgiE9TsCSj2JWny+d_StTPcw3iVu7zNQf0TSUVu2H8Dr5A@mail.gmail.com>
Subject: Re: [PATCH v6] rust: support for shadow call stack sanitizer
To: Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:48=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Mon, 26 Aug 2024 at 16:23, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > This patch adds all of the flags that are needed to support the shadow
> > call stack (SCS) sanitizer with Rust, and updates Kconfig to allow only
> > configurations that work.
> >
> > The -Zfixed-x18 flag is required to use SCS on arm64, and requires rust=
c
> > version 1.80.0 or greater. This restriction is reflected in Kconfig.
> >
> > When CONFIG_DYNAMIC_SCS is enabled, the build will be configured to
> > include unwind tables in the build artifacts. Dynamic SCS uses the
> > unwind tables at boot to find all places that need to be patched. The
> > -Cforce-unwind-tables=3Dy flag ensures that unwind tables are available
> > for Rust code.
> >
> > In non-dynamic mode, the -Zsanitizer=3Dshadow-call-stack flag is what
> > enables the SCS sanitizer. Using this flag requires rustc version 1.82.=
0
> > or greater on the targets used by Rust in the kernel. This restriction
> > is reflected in Kconfig.
> >
> > It is possible to avoid the requirement of rustc 1.80.0 by using
> > -Ctarget-feature=3D+reserve-x18 instead of -Zfixed-x18. However, this f=
lag
> > emits a warning during the build, so this patch does not add support fo=
r
> > using it and instead requires 1.80.0 or greater.
> >
> > The dependency is placed on `select HAVE_RUST` to avoid a situation
> > where enabling Rust silently turns off the sanitizer. Instead, turning
> > on the sanitizer results in Rust being disabled. We generally do not
> > want changes to CONFIG_RUST to result in any mitigations being changed
> > or turned off.
> >
> > At the time of writing, rustc 1.82.0 only exists via the nightly releas=
e
> > channel. There is a chance that the -Zsanitizer=3Dshadow-call-stack fla=
g
> > will end up needing 1.83.0 instead, but I think it is small.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Link: https://lore.kernel.org/rust-for-linux/20240808221138.873750-1-oj=
eda@kernel.org/ [1]
> > ---
> > Changes in v6:
> > - Move Kconfig requirements into arch/*/Kconfig.
> > - List non-dynamic SCS as supported on 1.82. This reflects newly added
> >   things in rustc.
> > - Link to v5: https://lore.kernel.org/r/20240806-shadow-call-stack-v5-1=
-26dccb829154@google.com
> >
> > Changes in v5:
> > - Rebase series on v6.11-rc2.
> > - The first patch is no longer included as it was merged in v6.11-rc2.
> > - The commit message is rewritten from scratch.
> > - Link to v4: https://lore.kernel.org/r/20240729-shadow-call-stack-v4-0=
-2a664b082ea4@google.com
> >
> > Changes in v4:
> > - Move `depends on` to CONFIG_RUST.
> > - Rewrite commit messages to include more context.
> > - Link to v3: https://lore.kernel.org/r/20240704-shadow-call-stack-v3-0=
-d11c7a6ebe30@google.com
> >
> > Changes in v3:
> > - Use -Zfixed-x18.
> > - Add logic to reject unsupported rustc versions.
> > - Also include a fix to be backported.
> > - Link to v2: https://lore.kernel.org/rust-for-linux/20240305-shadow-ca=
ll-stack-v2-1-c7b4a3f4d616@google.com/
> >
> > Changes in v2:
> > - Add -Cforce-unwind-tables flag.
> > - Link to v1: https://lore.kernel.org/rust-for-linux/20240304-shadow-ca=
ll-stack-v1-1-f055eaf40a2c@google.com/
> > ---
> >  Makefile            | 1 +
> >  arch/arm64/Kconfig  | 7 ++++++-
> >  arch/arm64/Makefile | 3 +++
> >  arch/riscv/Kconfig  | 7 ++++++-
> >  init/Kconfig        | 1 -
> >  5 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 44c02a6f60a1..eb01a26d8354 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -927,6 +927,7 @@ ifdef CONFIG_SHADOW_CALL_STACK
> >  ifndef CONFIG_DYNAMIC_SCS
> >  CC_FLAGS_SCS   :=3D -fsanitize=3Dshadow-call-stack
> >  KBUILD_CFLAGS  +=3D $(CC_FLAGS_SCS)
> > +KBUILD_RUSTFLAGS +=3D -Zsanitizer=3Dshadow-call-stack
> >  endif
> >  export CC_FLAGS_SCS
> >  endif
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a2f8ff354ca6..28c4a3035331 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -231,7 +231,7 @@ config ARM64
> >         select HAVE_FUNCTION_ARG_ACCESS_API
> >         select MMU_GATHER_RCU_TABLE_FREE
> >         select HAVE_RSEQ
> > -       select HAVE_RUST if CPU_LITTLE_ENDIAN
> > +       select HAVE_RUST if RUSTC_SUPPORTS_ARM64
> >         select HAVE_STACKPROTECTOR
> >         select HAVE_SYSCALL_TRACEPOINTS
> >         select HAVE_KPROBES
> > @@ -265,6 +265,11 @@ config ARM64
> >         help
> >           ARM 64-bit (AArch64) Linux support.
> >
> > +config RUSTC_SUPPORTS_ARM64
>
> Nit: could we choose a better name here? ARCH_HAVE_RUST perhaps?

This is the name suggested by Will Deacon in the previous version. I'm
happy to change it if you prefer, but I'm wondering if that name is
too close to HAVE_RUST? Perhaps ARCH_SUPPORTS_RUST? Ultimately I think
that the current name is okay.

> > +       def_bool y
> > +       depends on CPU_LITTLE_ENDIAN
> > +       depends on !SHADOW_CALL_STACK || RUSTC_VERSION >=3D 108200 || R=
USTC_VERSION >=3D 108000 && UNWIND_PATCH_PAC_INTO_SCS
> > +
>
> This is a bit opaque, so I'd prefer to have a comment here, explaining
> that rustc 1.82 supports emitting the instrumentation statically, but
> 1.80 is needed to get the X18 reservation, which the DWARF based
> patching logic relies on.

Hmm. I tried a few different wordings and ended on this:

config RUSTC_SUPPORTS_ARM64
       def_bool y
       depends on CPU_LITTLE_ENDIAN
       # Shadow call stack is only supported on some versions of rustc.
       #
       # When using the UNWIND_PATCH_PAC_INTO_SCS option, rustc version 1.8=
0+ is
       # required due to use of the -Zfixed-x18 flag.
       #
       # Otherwise, rustc version 1.82+ is required due to use of the
       # -Zsanitizer=3Dshadow-call-stack flag.
       depends on !SHADOW_CALL_STACK || RUSTC_VERSION >=3D 108200 ||
RUSTC_VERSION >=3D 108000 && UNWIND_PATCH_PAC_INTO_SCS

This wording avoids getting into the weeds of how SCS works. Do you
prefer something that gets into more detail than this?

> >  config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
> >         def_bool CC_IS_CLANG
> >         # https://github.com/ClangBuiltLinux/linux/issues/1507
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index f6bc3da1ef11..b058c4803efb 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -57,9 +57,11 @@ KBUILD_AFLAGS        +=3D $(call cc-option,-mabi=3Dl=
p64)
> >  ifneq ($(CONFIG_UNWIND_TABLES),y)
> >  KBUILD_CFLAGS  +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
> >  KBUILD_AFLAGS  +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
> > +KBUILD_RUSTFLAGS +=3D -Cforce-unwind-tables=3Dn
> >  else
> >  KBUILD_CFLAGS  +=3D -fasynchronous-unwind-tables
> >  KBUILD_AFLAGS  +=3D -fasynchronous-unwind-tables
> > +KBUILD_RUSTFLAGS +=3D -Cforce-unwind-tables=3Dy -Zuse-sync-unwind=3Dn
> >  endif
> >
> >  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> > @@ -114,6 +116,7 @@ endif
> >
> >  ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
> >  KBUILD_CFLAGS  +=3D -ffixed-x18
> > +KBUILD_RUSTFLAGS +=3D -Zfixed-x18
> >  endif
> >
> >  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0f3cd7c3a436..476e38ed9c00 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -172,7 +172,7 @@ config RISCV
> >         select HAVE_REGS_AND_STACK_ACCESS_API
> >         select HAVE_RETHOOK if !XIP_KERNEL
> >         select HAVE_RSEQ
> > -       select HAVE_RUST if 64BIT
> > +       select HAVE_RUST if RUSTC_SUPPORTS_RISCV
> >         select HAVE_SAMPLE_FTRACE_DIRECT
> >         select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >         select HAVE_STACKPROTECTOR
> > @@ -202,6 +202,11 @@ config RISCV
> >         select UACCESS_MEMCPY if !MMU
> >         select ZONE_DMA32 if 64BIT
> >
> > +config RUSTC_SUPPORTS_RISCV
> > +       def_bool y
> > +       depends on 64BIT
> > +       depends on !SHADOW_CALL_STACK || RUSTC_VERSION >=3D 108200
> > +
>
> Same nit as above. Also, if this enables shadow call stack on RISC-V
> too, please mention it in the commit log more clearly, as it only
> mentions arm64 by name.

Same question as above. I came up with:

config RUSTC_SUPPORTS_RISCV
       def_bool y
       depends on 64BIT
       # Shadow call stack requires rustc version 1.82+ due to use of the
       # -Zsanitizer=3Dshadow-call-stack flag.
       depends on !SHADOW_CALL_STACK || RUSTC_VERSION >=3D 108200

> >  config CLANG_SUPPORTS_DYNAMIC_FTRACE
> >         def_bool CC_IS_CLANG
> >         # https://github.com/ClangBuiltLinux/linux/issues/1817
> > diff --git a/init/Kconfig b/init/Kconfig
> > index fe76c5d0a72e..e095e94eb9db 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1909,7 +1909,6 @@ config RUST
> >         depends on !MODVERSIONS
> >         depends on !GCC_PLUGINS
> >         depends on !RANDSTRUCT
> > -       depends on !SHADOW_CALL_STACK
> >         depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> >         help
> >           Enables Rust support in the kernel.
> >
> > ---
> > base-commit: 5953fd808fca8116a91678ee5fac00fc198ad93d
> > change-id: 20240304-shadow-call-stack-9c197a4361d9
> >
>
> With the comments addressed (or refuted)
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for the review!

Alice

