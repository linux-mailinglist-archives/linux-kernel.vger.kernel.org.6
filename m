Return-Path: <linux-kernel+bounces-438588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA19EA32B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68366188761D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB9223C6B;
	Mon,  9 Dec 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDwfwm+3"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B01F63F1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788309; cv=none; b=UQb95obVmYHf20zzPfKo81bmju7HIDjJuoOSbUxho5swPdGyxLcJUSezG1IUtQ8WEaAfT/l0ucINv7yKMrwVxqIYCOrclwwPxoRDZBs11kTI00C5YKB6wWI7jYM91ld8D4XJwIewgSnlP89l3CGq65ZxOVmeotzFE/x+K8need4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788309; c=relaxed/simple;
	bh=4Nn+t2Yjyce34wgCQ3ETEjPe8rZLcWfxBP8EUFN0Dy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKEGuRAvB8jrXMZFfedhoxyHXIWFPMQXyJKgYQ/7rs5RTd8K+nr6xLgQbN3PI3V462W1WyrC7hNqjIMQV7i5yWv0Cmsx9G/MptRFCikIDMEpyH760GZxarjY6ul23+8OL3dL7HWsvF/66YVAJX9uW9gMer4OWTVDWtMFe42BfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDwfwm+3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so4396002a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733788307; x=1734393107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSUQjXvXCX7n0zlIPB3T1YFCaCdLs1ofM4KWIMrWBKg=;
        b=aDwfwm+3OsDJ+hy8Yi+maopD92U+iq0Z6QXOZqANjwd6n669vFFVzlPoWRW/0jVQhY
         SCCEBweGkwc8VMyZRzsQu0Hk2ZBndjIbEyWkAbEzeqdNY138WjEQjvdaB2shwOqwVNHM
         dFZDRFhOlBnncBM/tK/w5BhXccL9RfamfIMy7RrJS0z5EyjJm0G42BX44Z3WV8Yttnu2
         i+9cZYl25pvQpmpvn84R3oVANouhiaNIahg+ff1Nl+jA+Alj7MmhVNoqCgFMueuYHaI8
         ejNunuELGOHp/lGILu0zicsTZWwRp3x6561ivktOwFxl/YZp2UB/2sYiv5S40qh4P+1v
         PQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788307; x=1734393107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSUQjXvXCX7n0zlIPB3T1YFCaCdLs1ofM4KWIMrWBKg=;
        b=LHKft7mNRgwwu0H8WOOBTwwiDYxOCQ86QIROcaBSESXAEA6xq0BxqZOIPXR89uDm6q
         dLmMIkX645Qz7syuz0xXiu7c0noEr5QysYBsAZcweaMR3zdmmGl6Ci1/mGxBx09Jfys4
         eWmqACh5Oaxj0GKzg6jJndtrCcwfvDzQxvEA63Gr5oaz6o2T11ZRv6Nxp0pzv7wnwSUh
         xJRxuUeXjmjCYjH+IfBop/XFDVJ1GuKqRdZoNgKXHaljqrDyyKvoh3yVta/4SZ8chrbV
         0Zi+Tg7447g/FW1BeTbWmK6UOs+OuKM70SN9ZB4r3KN5TVw9iZy5AWe0rTBWj8iU7dRs
         xJVA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+WfU297BDXOiWiyju2Ckzl+d6RjLeW0xe8R0jGSe+82at32r/d81aL0VsL7VEpqqtxOsIYLzNgyUr3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGfqoy9AoKB1F1fXN9e2JBr/OjtZ51KbU72iRf7tSk4du7Fos
	vmiJ48X0k9lSbjzsrhHUZhPU9ygho38GVLpB9YadFuHKFF6Fsr6JJpG6Yyu8kZGOrHcOpKoy4uM
	Vps/6DDM1QhzFFAcRGoWVg6UN1tzmUGbQqmo=
X-Gm-Gg: ASbGncvCW8V6nn3ZkSE833QjMOdz7hmjCdb6Ct2yQ/tTpj9c+/YWWspoR1Pcj8UcsjR
	nHbhecm4mAsYNGlBqt+U5jQwJXjchsjmu5zTcEDQpPK8GeBuqHLYjQgLUAiVB1Ooy
X-Google-Smtp-Source: AGHT+IH/zZbQB//HIrX1JNipWnHUi43H4PwqcC6flKakC4Wp5vy64rAYnKcCmJw4Ryeyp5nKhAclTMf/QPAcT0muhIo=
X-Received: by 2002:a17:90b:4cce:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2efcf29a179mr3714478a91.29.1733788307107; Mon, 09 Dec 2024
 15:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222540.27495-1-yabinc@google.com> <20241209162028.GD12428@willie-the-truck>
 <CAF1bQ=SiHi8oCyo5YnXGpQGofM1zAsnBdqSEet1mS-BYNKVU8A@mail.gmail.com> <20241209185623.GA13084@willie-the-truck>
In-Reply-To: <20241209185623.GA13084@willie-the-truck>
From: Yabin Cui <yabinc@google.com>
Date: Mon, 9 Dec 2024 15:51:34 -0800
X-Gm-Features: AZHOrDkYQ4V69Y7vLhOpgw-bfrlmqVn8MSQhz800aNeQq_Tq1k4ujC1njQBPuGU
Message-ID: <CALJ9ZPNfUFF8OrpvziTnTvGU7OxEgyy9ZTc3aF-NhZ5hMbp7RQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Allow CONFIG_AUTOFDO_CLANG to be selected
To: Will Deacon <will@kernel.org>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Kees Cook <kees@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On Mon, Dec 9, 2024 at 10:56=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> (Aside: please try to avoid top-posting on the public lists as it messes =
up
> the flow of conversation; I'll try to piece this back together.)
>
> On Mon, Dec 09, 2024 at 09:30:50AM -0800, Rong Xu wrote:
> > On Mon, Dec 9, 2024 at 8:20=E2=80=AFAM Will Deacon <will@kernel.org> wr=
ote:
> > > On Mon, Nov 18, 2024 at 02:25:40PM -0800, Yabin Cui wrote:
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index fd9df6dcc593..c3814df5e391 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -103,6 +103,7 @@ config ARM64
> > > >       select ARCH_SUPPORTS_PER_VMA_LOCK
> > > >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > > >       select ARCH_SUPPORTS_RT
> > > > +     select ARCH_SUPPORTS_AUTOFDO_CLANG
> > > >       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > > >       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> > > >       select ARCH_WANT_DEFAULT_BPF_JIT
> > >
> > > After this change, both arm64 and x86 select this option unconditiona=
lly
> > > and with no apparent support code being added. So what is actually
> > > required in order to select ARCH_SUPPORTS_AUTOFDO_CLANG and why isn't
> > > it just available for all architectures instead?

I think it's similar to ARCH_SUPPORTS_LTO_CLANG, which also doesn't need an=
y
support code but requires testing to ensure it works on a specific architec=
ture.

>
> > Enabling an AutoFDO build requires users to explicitly set CONFIG_AUTOF=
DO_CLANG.
> > The support code is in Commit 315ad8780a129e82 (kbuild: Add AutoFDO
> > support for Clang build).
>
> Yes, that is precisely my point. The user has to enable
> CONFIG_AUTOFDO_CLANG anyway, so what is the point in having
> ARCH_SUPPORTS_AUTOFDO_CLANG. Why would an architecture _not_ want to
> select that?
>
> > We are not enabling this for all architectures because AutoFDO's optimi=
zed build
> > relies on Last Branch Records (LBR) which aren't available on all archi=
tectures.
>
> So? ETM isn't available on all arm64 machines and I doubt whether LBR is
> available on _all_ x86 machines either. So there's a runtime failure
> mode that needs to be handled anyway and I don't think the arch-specific
> Kconfig option is really doing anything useful.

My understanding of the benefits of ARCH_SUPPORTS_AUTOFDO_CLANG is:
1. Generally, we don't prefer to collect an AutoFDO profile on one
architecture and use it to build the kernel for another architecture.
This is because the profile misses data for architecture-dependent
code. ARCH_SUPPORTS_AUTOFDO_CLANG can partially prevent this from
happening.

2. Building a kernel with an AutoFDO profile involves using new
optimization flags for clang.  Having ARCH_SUPPORTS_AUTOFDO_CLANG=3Dy
for one architecture means someone has tested building a kernel with
an AutoFDO profile on this architecture.
>
> Will

