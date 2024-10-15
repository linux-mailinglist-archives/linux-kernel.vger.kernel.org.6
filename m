Return-Path: <linux-kernel+bounces-365955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702299EE85
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57468281EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83D37160;
	Tue, 15 Oct 2024 14:00:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB280034
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000840; cv=none; b=XeXDPrN91ycK6kgZtUPIvWYibckypysDPdW8rzRgr2cAHveQB4JNPk5v8hy4iVM0zfa7SFsGGUOn6br2EpWrdZ/06b30NZQUVJEwpeP9Lsyagj9IFh6TusWXJxnpcFEURwSKQk5ScbXY3II8pD5tuJCDiAWaMcBj3bOBuRJZFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000840; c=relaxed/simple;
	bh=2JyyIMBdKSzveYe6vuVuBLe4BlyrPgpHACvJroJvSQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aswbt3sk/hywgFf5RWC49WJ5+Ghnux85h/m+aaBxOqVo8gR+WHwVAVPchyi/NbatX7zgLOr2YXmeQYlqFOc/G0ysEvXNW+2FAqzg7aWa057wuwasVBxqyrie42BiT+Rgt0+o1dkLrDmKFCD6s9OQB4jEnzXb6VFJIob9Y1kMsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F8BBFEC;
	Tue, 15 Oct 2024 07:01:07 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C1A3F71E;
	Tue, 15 Oct 2024 07:00:35 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:00:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
 <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>

On Tue, Oct 15, 2024 at 03:51:02PM +0200, Linus Walleij wrote:
> On Tue, Oct 15, 2024 at 12:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:
> 
> > I think what's happening here is that when switching from prev to next
> > in the scheduler, we switch to next's mm before we actually switch to
> > next's register state, and there's a transient window where prev is
> > executed using next's mm. AFAICT we don't map prev's KASAN stack shadow
> > into next's mm anywhere, and so inlined KASAN_STACK checks recursively
> > fault on this until we switch to the overflow stack.
> 
> Oh my, that's pretty advanced. Well spotted!
> So it has nothing to do with Ards commit, correlation does not
> imply causation.
> 
> > More details on that below.
> >
> > Linus, are you able to look into this?
> 
> Of course, I'm trying to reproduce the bug.
> 
> > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > >  do_DataAbort from __dabt_svc+0x4c/0x80
> > > Exception stack(0xac003ad8 to 0xac003b20)
> > > 3ac0:                                                       ac003bc8
> > > 00000005
> > > 3ae0: ac003b88 74800779 7480078f ac003b88 7480078f ac003b88 00000005
> > > 82412640
> > > 3b00: ac003d20 ac003d54 00000051 ac003b28 80125c14 80125920 200f0193
> > > ffffffff
> > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > >  do_DataAbort from __dabt_svc+0x4c/0x80
> > > Exception stack(0xac003b88 to 0xac003bd0)
> > > 3b80:                   ac003c78 00000805 ac003c38 7480078f 74800798
> > > ac003c38
> > > 3ba0: 74800798 ac003c38 00000805 82412640 ac003d20 ac003d54 00000051
> > > ac003bd8
> > > 3bc0: 80125c14 80125920 200f0193 ffffffff
> > >  __dabt_svc from do_translation_fault+0x30/0x2b0
> > >  do_translation_fault from do_DataAbort+0x74/0x1dc
> > >  do_DataAbort from __dabt_svc+0x4c/0x80
> >
> > The above frames are the same; whatever the kernel is accessing at
> > do_translation_fault+0x30 is causing this to go recursive...
> >
> > I can reproduce this, pretty easily, with a similar enough trace, though
> > faddr2line isn't happy to give me a line number.
> 
> Did you reproduce it the same way with a few find /?
> 
> I am trying to reproduce it and failing :/
> (Using Torvald's HEAD)
> 
> This is my config:
> 
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_KASAN=y
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_OUTLINE=y
> # CONFIG_KASAN_INLINE is not set
> # CONFIG_KASAN_STACK is not set
> # CONFIG_KASAN_VMALLOC is not set
> # CONFIG_KASAN_EXTRA_INFO is not set
> 
> Do you use more KASAN?

I used a config per Clement's instructions, i.e.

| [mark@lakrids:~/src/linux]% git checkout v6.12-rc3                                                                                
| HEAD is now at 8e929cb546ee4 Linux 6.12-rc3
| [mark@lakrids:~/src/linux]% git clean -qfdx       
| [mark@lakrids:~/src/linux]% echo 'CONFIG_KASAN=y' > arch/arm/configs/fragment-kasan.config
| [mark@lakrids:~/src/linux]% usekorg 14.2.0 make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_defconfig fragment-kasan.config
|   HOSTCC  scripts/basic/fixdep
|   HOSTCC  scripts/kconfig/conf.o
|   HOSTCC  scripts/kconfig/confdata.o
|   HOSTCC  scripts/kconfig/expr.o
|   LEX     scripts/kconfig/lexer.lex.c
|   YACC    scripts/kconfig/parser.tab.[ch]
|   HOSTCC  scripts/kconfig/lexer.lex.o
|   HOSTCC  scripts/kconfig/menu.o
|   HOSTCC  scripts/kconfig/parser.tab.o
|   HOSTCC  scripts/kconfig/preprocess.o
|   HOSTCC  scripts/kconfig/symbol.o
|   HOSTCC  scripts/kconfig/util.o
|   HOSTLD  scripts/kconfig/conf
| #
| # configuration written to .config
| #
| Using .config as base
| Merging ./arch/arm/configs/fragment-kasan.config
| Value of CONFIG_KASAN is redefined by fragment ./arch/arm/configs/fragment-kasan.config:
| Previous value: # CONFIG_KASAN is not set
| New value: CONFIG_KASAN=y
| 
| #
| # merged configuration written to .config (needs make)
| #
| #
| # configuration written to .config
| #
| [mark@lakrids:~/src/linux]% grep KASAN .config                                                                                    
| CONFIG_KASAN_SHADOW_OFFSET=0x5f000000
| CONFIG_HAVE_ARCH_KASAN=y
| CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
| CONFIG_CC_HAS_KASAN_GENERIC=y
| CONFIG_KASAN=y
| CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
| CONFIG_KASAN_GENERIC=y
| # CONFIG_KASAN_OUTLINE is not set
| CONFIG_KASAN_INLINE=y
| CONFIG_KASAN_STACK=y
| CONFIG_KASAN_VMALLOC=y
| # CONFIG_KASAN_MODULE_TEST is not set
| # CONFIG_KASAN_EXTRA_INFO is not set

IIUC you'll need CONFIG_KASAN_INLINE=y, CONFIG_KASAN_STACK=y, and
CONFIG_KASAN_VMALLOC=y.

With that, just booting and tapping a few keys was sufficient to trigger
a crash using Debian the initrd Clement linked.

[...]

> > The relevant asm is:
> (...)
> > ... so we're using the new task's mm, but still executing in the context of the
> > old task (and using its stack). I suspect the new task's mm doesn't have the
> > old task's stack shadow mapped in, and AFAICT we don't map that in explicitly
> > anywhere before we switch to the new mm.
> >
> > Linus, can you look into that?
> 
> Yeah it looks like a spot-on identification of the problem, I can try to
> think about how we could fix this if I can reproduce it, I keep trying
> to provoke the crash :/

It's a bit grotty -- AFAICT you'd either need to prefault in the
specific part of the vmalloc space when switching tasks, or we'd need to
preallocate all the shared vmalloc tables at the start of time so that
they're always up-to-date.

While we could disable KASAN_STACK, that's only going to mask the
problem until this happens for any other vmalloc shadow...

Mark.

