Return-Path: <linux-kernel+bounces-366001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B035699EF63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D78B216C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8271B21BE;
	Tue, 15 Oct 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbepH3NK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3D149E16
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002153; cv=none; b=GJ+XdO8GYRM50GFHgS5gj4RFwl+dbdR7esta+dm+6IlUUMrrFZ07mLfK68d0ThJ2EmeopaawSTlIM3qu0nOF9BjXeiVtImsYRdzr/Gm0yaPWvI4Bykfwz13EPBHt6P2VS5UPz4KdTB9SZQDo8oZJMEwaFqHQwkxZ8OKDGshRUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002153; c=relaxed/simple;
	bh=devtTuHgL7IFyzvPORd4MUSVH/6RavDyucyCuwYH864=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plnH0v8TQbi0Je9FzMezzU6t6fAHiAohL2tSA+2t6GbkQUYRAdvxTGeb7vkXM8o3oN1w+OiioDFtfOA70e+LHsT4OCNj/0+978x3aeq6llhcCYEFd8zNZWgSi2I55I8g7420K02O/MoP99FmbWEhM0ZzIuKix3M5/SgzW8JMvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbepH3NK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEBFC4CED2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002153;
	bh=devtTuHgL7IFyzvPORd4MUSVH/6RavDyucyCuwYH864=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jbepH3NKeLE1Twx9l1VR72K5uilEa8+kFE1F5rzl9dAlvCMXdmUS7g4+RWqND5Z/V
	 +yU33sO01rkniBoVZCThzE6gicCS9P8wBxlQSPG3Kd+jVNSkjizRW9b56BzNVvR9Pw
	 nmIuyYSRWxBwSEe1wZYuRZRdImeeKSu/TriknGbpKg1/QByOjAMI35tn+JbF5zJkF1
	 iNgOXpkHzqEFFIgsg/9vP9eKvkouMGzZyKx9xvpkR4eby2RwHQmeQmmX6eWSKfEv+6
	 h09Pjs4bNieEgvMOPukCBfxI9M3cp6r5yvD+8zcb0zES4YR+g7slxADX987rCiTuuw
	 5YoER/VT1i/Lw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a007743e7so849757e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:22:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqOkFCTiTzbDjQ+uY0iMUaGkkjsMwETQX7NIAboNYtDlLJXUAgaJON78EJ44kun/QVgDopKgyI239pSlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ds9FdndDRliMuRLRjFM2kaHIgxxwuJwdQ7VpsjZcrBgOevub
	o+xSIQ9vEi/8ET3PtT6xVq0SERhmINEx4PspXNVvN1ZlJi6pmFRkfEUPh/pKLP0jFrHhiO15jEP
	JMD5xYqDFjpIuKlrSpn1Y3IU3oG8=
X-Google-Smtp-Source: AGHT+IFqYbTf2aEqCiuWJJAzGvdQ47nkaIEh+ubNeAj+TplREnMor3L/Pj2e/J/KYj2XFwyBXu3hQiFR1zci/aPawc8=
X-Received: by 2002:a05:6512:2589:b0:539:e85c:c888 with SMTP id
 2adb3069b0e04-539e85ccc0amr5093195e87.40.1729002151503; Tue, 15 Oct 2024
 07:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 16:22:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
Message-ID: <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 16:00, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> > On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Mark Rutland <mark.rutland@arm=
.com> wrote:
> > > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:
> >
> > > I think what's happening here is that when switching from prev to nex=
t
> > > in the scheduler, we switch to next's mm before we actually switch to
> > > next's register state, and there's a transient window where prev is
> > > executed using next's mm. AFAICT we don't map prev's KASAN stack shad=
ow
> > > into next's mm anywhere, and so inlined KASAN_STACK checks recursivel=
y
> > > fault on this until we switch to the overflow stack.
> >
> > Oh my, that's pretty advanced. Well spotted!
> > So it has nothing to do with Ards commit, correlation does not
> > imply causation.
> >
> > > More details on that below.
> > >
> > > Linus, are you able to look into this?
> >
> > Of course, I'm trying to reproduce the bug.
> >
> > > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > > >  do_DataAbort from __dabt_svc+0x4c/0x80
> > > > Exception stack(0xac003ad8 to 0xac003b20)
> > > > 3ac0:                                                       ac003bc=
8
> > > > 00000005
> > > > 3ae0: ac003b88 74800779 7480078f ac003b88 7480078f ac003b88 0000000=
5
> > > > 82412640
> > > > 3b00: ac003d20 ac003d54 00000051 ac003b28 80125c14 80125920 200f019=
3
> > > > ffffffff
> > > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > > >  do_DataAbort from __dabt_svc+0x4c/0x80
> > > > Exception stack(0xac003b88 to 0xac003bd0)
> > > > 3b80:                   ac003c78 00000805 ac003c38 7480078f 7480079=
8
> > > > ac003c38
> > > > 3ba0: 74800798 ac003c38 00000805 82412640 ac003d20 ac003d54 0000005=
1
> > > > ac003bd8
> > > > 3bc0: 80125c14 80125920 200f0193 ffffffff
> > > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > > >  do_DataAbort from __dabt_svc+0x4c/0x80
> > >
> > > The above frames are the same; whatever the kernel is accessing at
> > > do_translation_fault+0x30 is causing this to go recursive...
> > >
> > > I can reproduce this, pretty easily, with a similar enough trace, tho=
ugh
> > > faddr2line isn't happy to give me a line number.
> >
> > Did you reproduce it the same way with a few find /?
> >
> > I am trying to reproduce it and failing :/
> > (Using Torvald's HEAD)
> >
> > This is my config:
> >
> > CONFIG_HAVE_ARCH_KASAN=3Dy
> > CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> > CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> > CONFIG_KASAN=3Dy
> > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
> > CONFIG_KASAN_GENERIC=3Dy
> > CONFIG_KASAN_OUTLINE=3Dy
> > # CONFIG_KASAN_INLINE is not set
> > # CONFIG_KASAN_STACK is not set
> > # CONFIG_KASAN_VMALLOC is not set
> > # CONFIG_KASAN_EXTRA_INFO is not set
> >
> > Do you use more KASAN?
>
> I used a config per Clement's instructions, i.e.
>
> | [mark@lakrids:~/src/linux]% git checkout v6.12-rc3
> | HEAD is now at 8e929cb546ee4 Linux 6.12-rc3
> | [mark@lakrids:~/src/linux]% git clean -qfdx
> | [mark@lakrids:~/src/linux]% echo 'CONFIG_KASAN=3Dy' > arch/arm/configs/=
fragment-kasan.config
> | [mark@lakrids:~/src/linux]% usekorg 14.2.0 make ARCH=3Darm CROSS_COMPIL=
E=3Darm-linux-gnueabi- vexpress_defconfig fragment-kasan.config
> |   HOSTCC  scripts/basic/fixdep
> |   HOSTCC  scripts/kconfig/conf.o
> |   HOSTCC  scripts/kconfig/confdata.o
> |   HOSTCC  scripts/kconfig/expr.o
> |   LEX     scripts/kconfig/lexer.lex.c
> |   YACC    scripts/kconfig/parser.tab.[ch]
> |   HOSTCC  scripts/kconfig/lexer.lex.o
> |   HOSTCC  scripts/kconfig/menu.o
> |   HOSTCC  scripts/kconfig/parser.tab.o
> |   HOSTCC  scripts/kconfig/preprocess.o
> |   HOSTCC  scripts/kconfig/symbol.o
> |   HOSTCC  scripts/kconfig/util.o
> |   HOSTLD  scripts/kconfig/conf
> | #
> | # configuration written to .config
> | #
> | Using .config as base
> | Merging ./arch/arm/configs/fragment-kasan.config
> | Value of CONFIG_KASAN is redefined by fragment ./arch/arm/configs/fragm=
ent-kasan.config:
> | Previous value: # CONFIG_KASAN is not set
> | New value: CONFIG_KASAN=3Dy
> |
> | #
> | # merged configuration written to .config (needs make)
> | #
> | #
> | # configuration written to .config
> | #
> | [mark@lakrids:~/src/linux]% grep KASAN .config
> | CONFIG_KASAN_SHADOW_OFFSET=3D0x5f000000
> | CONFIG_HAVE_ARCH_KASAN=3Dy
> | CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> | CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> | CONFIG_KASAN=3Dy
> | CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
> | CONFIG_KASAN_GENERIC=3Dy
> | # CONFIG_KASAN_OUTLINE is not set
> | CONFIG_KASAN_INLINE=3Dy
> | CONFIG_KASAN_STACK=3Dy
> | CONFIG_KASAN_VMALLOC=3Dy
> | # CONFIG_KASAN_MODULE_TEST is not set
> | # CONFIG_KASAN_EXTRA_INFO is not set
>
> IIUC you'll need CONFIG_KASAN_INLINE=3Dy, CONFIG_KASAN_STACK=3Dy, and
> CONFIG_KASAN_VMALLOC=3Dy.
>
> With that, just booting and tapping a few keys was sufficient to trigger
> a crash using Debian the initrd Clement linked.
>
> [...]
>
> > > The relevant asm is:
> > (...)
> > > ... so we're using the new task's mm, but still executing in the cont=
ext of the
> > > old task (and using its stack). I suspect the new task's mm doesn't h=
ave the
> > > old task's stack shadow mapped in, and AFAICT we don't map that in ex=
plicitly
> > > anywhere before we switch to the new mm.
> > >
> > > Linus, can you look into that?
> >
> > Yeah it looks like a spot-on identification of the problem, I can try t=
o
> > think about how we could fix this if I can reproduce it, I keep trying
> > to provoke the crash :/
>
> It's a bit grotty -- AFAICT you'd either need to prefault in the
> specific part of the vmalloc space when switching tasks, or we'd need to
> preallocate all the shared vmalloc tables at the start of time so that
> they're always up-to-date.
>
> While we could disable KASAN_STACK, that's only going to mask the
> problem until this happens for any other vmalloc shadow...
>

Is the other vmalloc shadow not covered by the ordinary on-demand faulting?

When I implemented VMAP_STACK for ARM, I added an explicit load from
the new stack while still running from the old one (in __switch_to) so
that the ordinary faulting code can deal with it. Couldn't we do the
same for the vmalloc shadow of the new stack?

