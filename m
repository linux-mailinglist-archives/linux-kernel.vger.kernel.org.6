Return-Path: <linux-kernel+bounces-525892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3C3A3F6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D0F175B65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60320E6FA;
	Fri, 21 Feb 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Ai0wd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E696433DE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147227; cv=none; b=FvIiCSfxp0POFOu1vMvYbXcfRD96KnpFWSLrg9e4uNnIfiEhZ6/6GBwJNBOsdtDyUiebwAGkGO17sUlhTuI/CqKSxtTQ2cad78bfo0skTGtOttLkVdeNFc6J3W3gzWCSGwmYgNWFAJDUGAJP5C/d/2BO2bFweJhapQEZVHu2GAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147227; c=relaxed/simple;
	bh=5Wvq0cTOkb1qFZ+FmAL4lOfu3qF2mOv72Tk8TOkYG5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSX/AIAoi39Xzd7HFmpmEXFt65NOWwQgtVwXr9u+4QMoOWPsi6vrFRuCbUb6cFCArn35Ie0y1ScT38tpSdfrni83gO4/fu6zSS84KfmOqgytn1hEw8P050StyDjn2eEtzzBpBRCplP6bgQtHYnasT0oVjamDn4D/4OcSAsOcpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Ai0wd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD3C4CEE7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740147226;
	bh=5Wvq0cTOkb1qFZ+FmAL4lOfu3qF2mOv72Tk8TOkYG5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C3Ai0wd25ztA28XAZDVL9METHpV8jWSps/NfBJmKEbeoyYrY+jmNaFausXudWYM2q
	 BnUOjRa67DKysZaT/SnaUT8GmyEcNjYEuRw+P+qi5B3ubkGirvUpzUagjI2PMo7wEq
	 XEstv2sRIITb/6EW6lOkqNU4W2hID0pnBaedjfM64eYgie4X1Sgy8HksD/2GNCP01m
	 /lwQEWxrFASaaihvBUVTmziWCs13KqMsksjUdM9gr8g8FfTm7aQ7z1q78vtffJ73S2
	 y/wJi8uzzLnSvUNXnyaNnb9YR3f57J8HTdUlhFZP3ioJw8gx4R7wPlwFQ9fsWkudlv
	 Z++MUiY5vfwuQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a2594435dso32028001fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUglqa31lAqWHqW/i7HkKSQ6VKlLJQUugKgdbTY+CNs2vPqwfi5um0+OJrPWV8nhm/8d5WaXwGHR8ztVsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAy2DNtMZR4hNh8RZHmvbF+2YE47CJGuZpQBo5444kg7Km+hj8
	EgcHp8EcrW6ckq2K/pis+5oOqvTMuU1uzU9qG9it5ly9wPqejQ0Ez3D41daG1mkrdH8uPwlXSnk
	uqUyp4GO32LxKCFo/i+CQoPyBMZU=
X-Google-Smtp-Source: AGHT+IG3K5N+fDEdlLTiueQSzzFBO145ZXWDE3VAPQipIFIcwzV+RtC36En4RUVhZO8Sr2UtkDNu9He9vk5b6/sYAx4=
X-Received: by 2002:a2e:2a04:0:b0:309:31bf:ec17 with SMTP id
 38308e7fff4ca-30a506516aemr22347381fa.15.1740147225116; Fri, 21 Feb 2025
 06:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com> <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
In-Reply-To: <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Feb 2025 15:13:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
X-Gm-Features: AWEUYZk8R4HJq5obFpbGGz9sISSWNIenvi0lK62lpKl8u34jXrY5WkTyxCDmin4
Message-ID: <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 at 15:02, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Fri, Feb 21, 2025 at 2:37=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Fri, Feb 21, 2025 at 8:25=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > On Fri, Feb 21, 2025 at 1:54=E2=80=AFPM Brian Gerst <brgerst@gmail.co=
m> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 3:04=E2=80=AFPM Uros Bizjak <ubizjak@gmail.=
com> wrote:
> > > > >
> > > > > Move stack canary from __stack_chk_guard to struct pcpu_hot and
> > > > > alias __stack_chk_guard to point to the new location in the
> > > > > linker script.
> > > > >
> > > > > __stack_chk_guard is one of the hottest data structures on x86, s=
o
> > > > > moving it there makes sense even if its benefit cannot be measure=
d
> > > > > explicitly.
> > > > >
> > > > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > Cc: Brian Gerst <brgerst@gmail.com>
> > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > ---
> > > > >  arch/x86/include/asm/current.h | 13 +++++++++++++
> > > > >  arch/x86/kernel/cpu/common.c   |  1 -
> > > > >  arch/x86/kernel/vmlinux.lds.S  |  2 ++
> > > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/as=
m/current.h
> > > > > index bf5953883ec3..e4ff1d15b465 100644
> > > > > --- a/arch/x86/include/asm/current.h
> > > > > +++ b/arch/x86/include/asm/current.h
> > > > > @@ -15,6 +15,9 @@ struct task_struct;
> > > > >  struct pcpu_hot {
> > > > >         union {
> > > > >                 struct {
> > > > > +#ifdef CONFIG_STACKPROTECTOR
> > > > > +                       unsigned long           stack_canary;
> > > > > +#endif
> > > > >                         struct task_struct      *current_task;
> > > > >                         int                     preempt_count;
> > > > >                         int                     cpu_number;
> > > > > @@ -35,6 +38,16 @@ struct pcpu_hot {
> > > > >  };
> > > > >  static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> > > > >
> > > > > +/*
> > > > > + * stack_canary should be at the beginning of struct pcpu_hot to=
 avoid:
> > > > > + *
> > > > > + * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard
> > > >
> > > > This should be R_X86_64_PC32 relocations.
> > >
> > > This is what the build system reports if any offset (including 0) is =
added to
> > >
> > > PROVIDE(__stack_chk_guard =3D pcpu_hot);
> > >
> > > It is not a warning, but an error that fails the build.
> > >
> > > As was discussed in the previous thread, the above is required to
> > > handle !SMP case, where mstack-protector-guard=3Dglobal (used by !SMP
> > > builds) ignores the
> > > -mstack-protector-guard-symbol option and always uses __stack_chk_gua=
rd.
> >
> > I got a warning from the relocs tool, but not a hard error.  What
> > compiler/linker are you using?
> >
> > Does the attached patch build in your configuration?
>
> Ah, the attached patch is similar to my previous approach, where the
> build system *warned* on an offset (the patch was abandoned due to
> Ard's request to put stack_canary to the *beginning* of struct
> pcpu_hot, and this allowed for a simplified patch).
>
> The attached patch builds for me without warning/error for both, SMP
> and !SMP build.
>

Did you try building modules too?

