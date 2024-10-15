Return-Path: <linux-kernel+bounces-365936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E899EE27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84571C203D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048C189F30;
	Tue, 15 Oct 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/Gy0IHH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748A20311
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000278; cv=none; b=Mx8Rrb6OAByKh3K2HTmMVqV6XOTvx1elhIHpEuOjdkHb5CqJCQHV4Foz1f1cuC9omR8GxSNuEE63qsc7vATISRdThOfueHkCJeu6/NfPcASiOVLJ0LL/v9qe4PYbppemYvscyU5MjvzZhexfOLz1SWSC67QEevCrmZvu9++moQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000278; c=relaxed/simple;
	bh=v34AO2/w1FJNH9rpjHwbZw0s455VymKO/WzCEHZsVOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ23TjQFDsxci5pgIWrxaZgebBPHphcwl80WNCpu7MrQubf85XMhAUVZuyxEOcOZE0JIHvBaur7US7g/vCVdyyuAk5RUJYUn+aySia9Z4qjmo1isT3bL/dD6/2n9CH9+KlmcnTyNYf/LGnXvNlLAr2yJjzFPamgwso/iN+KiLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f/Gy0IHH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso12606551fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729000275; x=1729605075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ODytrdty9/l8W4bhXX0aVFku2lv2Z3WhuLQqcWmQRg=;
        b=f/Gy0IHHF93+8B0rC5ACLo1y6ByIYBszcJTca6LsNZKtKs4/ioK6/V/FOZA9fvL4y8
         IU05/+QOXeEC7MXuOCEJLgVfGyGd3pfY409Om4yBWETqbHrBHRlZQiamrfeJuQGQM4Mk
         K0b8nGa7qkE0EPevZlzRg1/1v8yaw+lw4JgWIJ3PO9RLIeqiWDxOE7emCWMv9kerzfjc
         EiqUiKv/S2kxsj2f6Dw1chS6cKfSiYYJcrHx2FVcG7Z5Ijv//RbTfutJ/LBwtmhLkI8e
         eEwrGEd9pGWPBuk5NGj61cObZZ5gZGedYgzUdX4K4fBsJRIJ8YfVd/aFS+urjnEdvEDX
         faBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000275; x=1729605075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ODytrdty9/l8W4bhXX0aVFku2lv2Z3WhuLQqcWmQRg=;
        b=I6dfqp1l6QytPBXxkRGTUNoTl0+IPGXsKNqjzQbEss99uPW3UtMrvowJ57xBHhmL/h
         ZBMzhBeI9u7q4cpQfy70NQnDXgj6j4y/e/za9sC6k9bExFXJxjCfG3c4SLbXS83OF7Zj
         K9uYuM3eoYBY1VHqX2PFpiSFaN9JEGkaNi+q9MoqI8/LcWb9GO1aht131VcMnKugMvtk
         xxkosHcjrmLMf1H5vo+jv8oJGt7TF53Cy6HUeBqrlrY+gaTmQ+VLAWF7ch7/UwCcvV+c
         7jt+/SitbbmREeeR91OZSf6j5hgYZdroHEHqdVEyHX/pzamixKd8WIiC0jpfli1refLK
         g9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL7qE5WDCjjnDIJJwLtV0pKnPhB7wNNgt3wXDTYWv8jKrHWKchR26mRs/nBzGyvLH+E7uUmBep4Imakog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpSo/SlfodAsbIT16r9gxMgwt2/IrwuZviVjcjMELrZUQhfK26
	8Sicw1S83BCtV2A9LUiDy7/n60b9jndSJ19FeUECNdhkrU91JCstETEPzsj9eb2S0acq6Vdq+2s
	+tKxHJdpwngByXy/sdPv4gvpAhZyjiqNJSv8PPA==
X-Google-Smtp-Source: AGHT+IEjg+oNmPlVRuJ8pkfPVdg+5ie4HBYgAkEDVDyZgEVWbqqs90OfojuOPZIC0pqhRyMuznx/G4XAshimAxobopg=
X-Received: by 2002:a2e:d01:0:b0:2f6:649e:bf5c with SMTP id
 38308e7fff4ca-2fb32786cf4mr52281651fa.17.1729000274334; Tue, 15 Oct 2024
 06:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com> <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
In-Reply-To: <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 15:51:02 +0200
Message-ID: <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:

> I think what's happening here is that when switching from prev to next
> in the scheduler, we switch to next's mm before we actually switch to
> next's register state, and there's a transient window where prev is
> executed using next's mm. AFAICT we don't map prev's KASAN stack shadow
> into next's mm anywhere, and so inlined KASAN_STACK checks recursively
> fault on this until we switch to the overflow stack.

Oh my, that's pretty advanced. Well spotted!
So it has nothing to do with Ards commit, correlation does not
imply causation.

> More details on that below.
>
> Linus, are you able to look into this?

Of course, I'm trying to reproduce the bug.

> >  __dabt_svc from do_translation_fault+0x30/0x2b0
> >  do_translation_fault from do_DataAbort+0x74/0x1dc
> >  do_DataAbort from __dabt_svc+0x4c/0x80
> > Exception stack(0xac003ad8 to 0xac003b20)
> > 3ac0:                                                       ac003bc8
> > 00000005
> > 3ae0: ac003b88 74800779 7480078f ac003b88 7480078f ac003b88 00000005
> > 82412640
> > 3b00: ac003d20 ac003d54 00000051 ac003b28 80125c14 80125920 200f0193
> > ffffffff
> >  __dabt_svc from do_translation_fault+0x30/0x2b0
> >  do_translation_fault from do_DataAbort+0x74/0x1dc
> >  do_DataAbort from __dabt_svc+0x4c/0x80
> > Exception stack(0xac003b88 to 0xac003bd0)
> > 3b80:                   ac003c78 00000805 ac003c38 7480078f 74800798
> > ac003c38
> > 3ba0: 74800798 ac003c38 00000805 82412640 ac003d20 ac003d54 00000051
> > ac003bd8
> > 3bc0: 80125c14 80125920 200f0193 ffffffff
> >  __dabt_svc from do_translation_fault+0x30/0x2b0
> >  do_translation_fault from do_DataAbort+0x74/0x1dc
> >  do_DataAbort from __dabt_svc+0x4c/0x80
>
> The above frames are the same; whatever the kernel is accessing at
> do_translation_fault+0x30 is causing this to go recursive...
>
> I can reproduce this, pretty easily, with a similar enough trace, though
> faddr2line isn't happy to give me a line number.

Did you reproduce it the same way with a few find /?

I am trying to reproduce it and failing :/
(Using Torvald's HEAD)

This is my config:

CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
CONFIG_KASAN=3Dy
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
CONFIG_KASAN_GENERIC=3Dy
CONFIG_KASAN_OUTLINE=3Dy
# CONFIG_KASAN_INLINE is not set
# CONFIG_KASAN_STACK is not set
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_KASAN_EXTRA_INFO is not set

Do you use more KASAN?

Then I run:

${QEMU} -M vexpress-a15 -m 512M -no-reboot -smp cpus=3D2 -kernel
${ZIMAGE} -dtb ${DTB} -append "root=3D/dev/mmcblk0 rw roottype=3Dext4
console=3DttyAMA0" -serial stdio -drive
if=3Dsd,driver=3Draw,cache=3Dwriteback,file=3D./arch_rootfs.ext4

This is a rootfs with Debian.

Then I fork a few find /|grep fnord > /dev/null &

root@vexpress:~# find / |grep fnord > /dev/null &
[1] 554
root@vexpress:~# find / |grep fnord > /dev/null &
[2] 556
root@vexpress:~# find / |grep fnord > /dev/null &
[3] 558
root@vexpress:~# find / |grep fnord > /dev/null &
[4] 560
root@vexpress:~# find / |grep fnord > /dev/null &
[5] 562
root@vexpress:~# find / |grep fnord > /dev/null &
[6] 564
root@vexpress:~# find / |grep fnord > /dev/null &
[7] 566
root@vexpress:~# find / |grep fnord > /dev/null &
[8] 568
root@vexpress:~# find / |grep fnord > /dev/null &
[9] 570
root@vexpress:~# find / |grep fnord > /dev/null &
[10] 572
root@vexpress:~# find / |grep fnord > /dev/null &
[11] 574
root@vexpress:~# find / |grep fnord > /dev/null &
[12] 576
root@vexpress:~# find / |grep fnord > /dev/null &
[13] 578
root@vexpress:~# find / |grep fnord > /dev/null &
[14] 580
root@vexpress:~# find / |grep fnord > /dev/null &
[15] 582
root@vexpress:~# find / |grep fnord > /dev/null &
[16] 584
root@vexpress:~# find / |grep fnord > /dev/null &
[17] 586
root@vexpress:~# find / |grep fnord > /dev/null &
^[[A[18] 588
root@vexpress:~# find / |grep fnord > /dev/null &
^[[A[19] 590
root@vexpress:~# find / |grep fnord > /dev/null &
[20] 592
root@vexpress:~#
root@vexpress:~# ps
  PID TTY          TIME CMD
  291 ttyAMA0  00:00:02 login
  550 ttyAMA0  00:00:01 bash
  553 ttyAMA0  00:00:06 find
  554 ttyAMA0  00:00:00 grep
  555 ttyAMA0  00:00:04 find
  556 ttyAMA0  00:00:00 grep
  557 ttyAMA0  00:00:03 find
  558 ttyAMA0  00:00:00 grep
  559 ttyAMA0  00:00:03 find
  560 ttyAMA0  00:00:00 grep
  561 ttyAMA0  00:00:03 find
  562 ttyAMA0  00:00:00 grep
  563 ttyAMA0  00:00:02 find
  564 ttyAMA0  00:00:00 grep
  565 ttyAMA0  00:00:02 find
  566 ttyAMA0  00:00:00 grep
  567 ttyAMA0  00:00:02 find
  568 ttyAMA0  00:00:00 grep
  569 ttyAMA0  00:00:02 find
  570 ttyAMA0  00:00:00 grep
  571 ttyAMA0  00:00:02 find
  572 ttyAMA0  00:00:00 grep
  573 ttyAMA0  00:00:01 find
  574 ttyAMA0  00:00:00 grep
  575 ttyAMA0  00:00:01 find
  576 ttyAMA0  00:00:00 grep
  577 ttyAMA0  00:00:01 find
  578 ttyAMA0  00:00:00 grep
  579 ttyAMA0  00:00:01 find
  580 ttyAMA0  00:00:00 grep
  581 ttyAMA0  00:00:01 find
  582 ttyAMA0  00:00:00 grep
  583 ttyAMA0  00:00:01 find
  584 ttyAMA0  00:00:00 grep
  585 ttyAMA0  00:00:01 find
  586 ttyAMA0  00:00:00 grep
  587 ttyAMA0  00:00:01 find
  588 ttyAMA0  00:00:00 grep
  589 ttyAMA0  00:00:01 find
  590 ttyAMA0  00:00:00 grep
  591 ttyAMA0  00:00:01 find
  592 ttyAMA0  00:00:00 grep
  593 ttyAMA0  00:00:01 ps
root@vexpress:~#

This refused to crash.

Then I recompiled with GCC as I was using LLVM CLANG. But
same non-problem: no crash.

> The relevant asm is:
(...)
> ... so we're using the new task's mm, but still executing in the context =
of the
> old task (and using its stack). I suspect the new task's mm doesn't have =
the
> old task's stack shadow mapped in, and AFAICT we don't map that in explic=
itly
> anywhere before we switch to the new mm.
>
> Linus, can you look into that?

Yeah it looks like a spot-on identification of the problem, I can try to
think about how we could fix this if I can reproduce it, I keep trying
to provoke the crash :/

Yours,
Linus Walleij

