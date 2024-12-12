Return-Path: <linux-kernel+bounces-442705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E99EE08D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF77161267
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB81FECD6;
	Thu, 12 Dec 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbqC/3/T"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36F259483
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989697; cv=none; b=hRIO11VY0qEq8zoq8lBGFLCXaE1hgS9OoTZxzxhJ2JcE5a8AyZD6RQJOecxVhqb8oUtzj8iY7AFdquz4+lauVo1whOFwFgNV2EvZIDZeADOsqeIAWeRHBu26+wB6LZqSFACMuVFW0ntOqeLa46iXrn0bX1eAxYidL7py0Xc99pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989697; c=relaxed/simple;
	bh=246hYc6/htTp8omV00i3ZQ9xhrFVidmAoKooHLfT3hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEK0XirantIkugtbOxTvMrUzeqO+7P5xP3GBk3KsfbiQKTtui6fepZ2rO1jEIMy2FKg8mTMqUfz+3lHoZByTlMhcwTH98PEIu0ZEjC9jPZDc6Frog7sBRl19TOzunhK8PGVRYYJ7yMRviCeD55B/GRzDZGMrkvOcbl3/VSr5vJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbqC/3/T; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678c9310afso139391cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733989694; x=1734594494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gShx5eL4ySW6cWAOawjF75lidbVT80UueggVpXtuG3o=;
        b=mbqC/3/TZWDLqtvWfzXn0QtNWgGQJJiCRjmc0LFImXx+kh7LJ/ZqyVjcJH7jcwjaqX
         EcrSYosH8mXzC6XxBaYTQF0UcK+4wddIG49rvS87QI4fOWKJ36UxDnV1tPFHaqFK2dwC
         OIgZW4jF7nxXbVpvxOMiLRkOCuJBpbqZHWXjS6F0tDUNrlYbe3y+6nM98xQTgd+nJ2Ks
         1fm8FFEZg/OsbsVwNnmXGH4lwnOD1OiyQWXTR8Brr36scTqB6YREndPTwuEYjCQQW5Nd
         rhp2gMhzkZDlRY5HJH+Qh3uQzwB37tpBIkLNuHA9McCMZq6pVrwTk7nzQoeIK8GWlk8G
         FzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733989694; x=1734594494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gShx5eL4ySW6cWAOawjF75lidbVT80UueggVpXtuG3o=;
        b=bClZJBTneAwddcJyhYSYTL6GOo1iynitCzuQJe5dnUWRqI6wG4YyGqayskMWbFFKFY
         cqHAVQ0WWJ29YY5gkGOuHQzI2BJFvE8Bn38UoPLzSMvjjFNFFeW9XefwaKkHPAz2DmSZ
         UoyjkwU9Dn4/VW7u9nQfApFcYtDwcgY0jMBSR9N+zxg1nOlYoTwu3gtrrYcXkjLngkH7
         OSDp9s0EGlr2pyxZqr2wCgvtnwuAp4qcdyQy/y5uuRsDK04K4tH8uUPKyzqi/FQq75b0
         L7mJSP2SQ4WEHCqz60oNCiAtn40SsrbVCz3u/0eZxllIt9PIG8+aI68/g8yMnjfBXenV
         Fmhg==
X-Forwarded-Encrypted: i=1; AJvYcCV1W/ehA5X3LwObNDKEqsqtsuHGNcFB83YUP4404SJfMSCqcFTYS7AlzPqE0gH6ch8VP2uA6J7F4J6+nzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DZbt0sW8Nns8vPhEjtPPAtXyjvouMAgqKWtLscjrOmpyVVnc
	8vvPG2jNgEn9kFRb2Xif0diizCdzFp257QyhS+ouzf+bsPR8FMbIRan71xofo4oUwWAfL10aygu
	z7eWldz+NZhkVDZpcsjBrTIR0o4LWiuh4PrdI
X-Gm-Gg: ASbGncsurkViFGAhNzNmNkIVoVbwawYF8rrop3zMRwnYRNMVK7nh7Bfk8xSe6SMfjoJ
	Cd2MDYVa47Jby0hwr5YmoTYewxNmwIo8n9KqI
X-Google-Smtp-Source: AGHT+IHXo0IfHG6BpwnG9eE9yTxic87btuZZPngaszBChZkkLd7ZiXczFYt1kRuEr7i0YmqMuS06R0UjQg3olbCYaDI=
X-Received: by 2002:a05:622a:1143:b0:465:3d28:8c02 with SMTP id
 d75a77b69052e-46796e2f2a7mr2654931cf.26.1733989694209; Wed, 11 Dec 2024
 23:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211222945.1325793-1-xur@google.com> <20241211222945.1325793-2-xur@google.com>
 <20241211230553.GA3654215@ax162>
In-Reply-To: <20241211230553.GA3654215@ax162>
From: Rong Xu <xur@google.com>
Date: Wed, 11 Dec 2024 23:48:02 -0800
Message-ID: <CAF1bQ=RA2J1H97pBsiABxOv0tgUgPQWE8Jgaqx33nbsGJFvH7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Propeller: Remove the architecture specific config
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Yabin Cui <yabinc@google.com>, 
	Will Deacon <will@kernel.org>, Han Shen <shenhan@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 (o

On Wed, Dec 11, 2024 at 3:06=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Rong,
>
> On Wed, Dec 11, 2024 at 02:29:43PM -0800, Rong Xu wrote:
> > The CONFIG_PROPELLER_CLANG option currently depends on
> > ARCH_SUPPORTS_PROPELLER_CLANG, but this dependency seems unnecessary.
> >
> > Remove ARCH_SUPPORTS_PROPELLER_CLANG and allow users to control
> > Propeller builds solely through CONFIG_PROPELLER_CLANG. This simplifies
> > the kconfig and avoids potential confusion.
> >
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Will Deacon <will@kernel.org>
>
> In commit d5dc95836147 ("kbuild: Add Propeller configuration for kernel
> build"), you added .llvm_bb_addr_map to arch/x86/kernel/vmlinux.lds.S.
> Was this to address a orphan section warning from the linker? Is that
> same change needed in the linker scripts of the other architectures that
> clang supports building in the kernel?

The .llvm_bb_addr_map section is created when compiling with the
-fbasic-block-address-map flag (or the older -fbasic-block-sections=3Dlabel=
s
option), with LLVM. We need the change in the linker script to group the
sections together and emit in the final vmlinux.

This applies to all architectures, as LLVM can generate these sections for
any architecture when the corresponding option is used.

The statement that AutoFDO and Propeller are only supported on certain
platforms really refers to the availability of *native* profile generation:
the native profile generation is only available on these platforms.

Hope this helps,

-Rong

> Cheers,
> Nathan
>
> > ---
> >  arch/Kconfig     | 4 ----
> >  arch/x86/Kconfig | 1 -
> >  2 files changed, 5 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 0b36d74d47031..83731b858ba65 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -828,12 +828,8 @@ config AUTOFDO_CLANG
> >
> >         If unsure, say N.
> >
> > -config ARCH_SUPPORTS_PROPELLER_CLANG
> > -     bool
> > -
> >  config PROPELLER_CLANG
> >       bool "Enable Clang's Propeller build"
> > -     depends on ARCH_SUPPORTS_PROPELLER_CLANG
> >       depends on CC_IS_CLANG && CLANG_VERSION >=3D 190000
> >       help
> >         This option enables Clang=E2=80=99s Propeller build. When the P=
ropeller
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 9363d9cc9a00a..6c633d93c6390 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -128,7 +128,6 @@ config X86
> >       select ARCH_SUPPORTS_LTO_CLANG
> >       select ARCH_SUPPORTS_LTO_CLANG_THIN
> >       select ARCH_SUPPORTS_RT
> > -     select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
> >       select ARCH_USE_BUILTIN_BSWAP
> >       select ARCH_USE_CMPXCHG_LOCKREF         if X86_CMPXCHG64
> >       select ARCH_USE_MEMTEST
> > --
> > 2.47.0.338.g60cca15819-goog
> >

