Return-Path: <linux-kernel+bounces-437939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92369E9ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEC71887E88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D851C5CAD;
	Mon,  9 Dec 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkaFDPTj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7711B4231
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758900; cv=none; b=ZlABQLPf6DwTOnkS2XgvOzR1jRAjKRT/A2QUcKIocM7kebP2CMSh/bEzBLl26ES06u2Q6YtsVrIXQ8PJOqll7OzUOP9a1hS53kJxuTVVRMjJvrvSCo5Qow+ctiZ6nI1parMV+uF7znAa1rO/WNAcs+R+tGaDyFU1sDS+b5XlLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758900; c=relaxed/simple;
	bh=AukZtKhq0s/kTJs0ZaG2Gj1g6nakQk4ddjmJOkDNY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaMWJ8iFZCJHBMEr8omlEZU66XkKVzQLZ7JJl7tvr2XB1y6eJeyqn8ZhOs1dgCE21a78KtRe7Qc/zd7h3XIq4mc95FDHnrUohwxRTfvacK22Ov8eLtfpP98BdnnhmvbTP6FZYqGQdP6nkKGULaSZC+GX4QJXcUXGmojUvPGSVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkaFDPTj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725f3594965so681098b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733758895; x=1734363695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BtWpuyLxaD0VIAJmQX9tGUwSDZTDi1dwjaAHRbMkq8=;
        b=UkaFDPTjJUmTL8OAVcOeETqazPTC11zqOEj8Cw4VNl7mcfwb+uJnIRKdrlm7QlOo/4
         PGaZXU8n/HSNvGM1sTdNd2KDdlElUgk5CZbXQGQ07SLjs3/Hm7IJOD+nDdDQdGUQw8Fu
         oKEQ+i97HfT3hsj2fMaR/5onjUdYfuegIZk0rRmhOhwYABlVqtVLKiqoshe/ywz009Xz
         HctmOSCF6JH6I5B7LnxPK75Xf1AlLOazEWKpN0MAnS2X/1WfDKoq13bpemvWulEK8V0p
         ZTU2ggCqQMEJhAONcdrW7qcN2vrcRjo/2bDiCKv+qZIRglS9FrFTwKkqWx6GESqe/SbC
         K3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758895; x=1734363695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BtWpuyLxaD0VIAJmQX9tGUwSDZTDi1dwjaAHRbMkq8=;
        b=gva5nFkgF/U7dIDTF6Iv+HMf9lhwi9TNnca/D7xqIW81C1SwDU9A8K5SmOgHpbcCUk
         4BxSKNRF8eBtrpYt0Ugrj5CVrs6EU2878fsSnpUK1J7A03FeCMChWSXpiaKtBkyZw/tN
         iku+dJtIh/6uO548hc2M+QLyv68MZbAhBrW60ImGnTcH8f2V1BlsmdJgrkxb//FAcUS1
         qd2WlcbPp8Vf4w9E5e/Y6y6F67mKyHscs67DcLGQA1we1+dJ/Zn2t5y/TpgLQ6LDMXKZ
         6xAbR7vTtB6BNYO8W6Fa4jX6MZC6CVmHZgVENgGJ/9lwXVrDNXXSlH03QGZJ7z7dkn5H
         WloA==
X-Gm-Message-State: AOJu0YxlbUudObuQxF0+IrO1Ll+3X+q0+xTxuZkWS7PBG8W6Ga3wH9pE
	IJuigmydtqPwBymb2rX0y0fYmIAVs1DKnHC8la/gwWekZq6Z24Gd
X-Gm-Gg: ASbGncv9AT1gXcs3KB8LegZzcHblZb45E5GZnx5BqC3weUQEmbDdnAWYtCvM7t31O3p
	vCKj2RVfFK2AIj5vgTbzGrYEcgFRgB4R74j1BHHDPoxCEsgnQfHXRvmzyDfx3yrHexNZvgjGYas
	rgGDOmQmBD+2qBNiP0GkUu0Xl1uA2fYSa53v4UwgKhKmM1MOUUfGeOgZ49yb/wqjwRNGDnIw9lM
	fF+jsqcB3pKEe1yBK+wh5OeLuPF9CDqZJFCgIVBjvIrjbm3usGDGZOdCsBlChI=
X-Google-Smtp-Source: AGHT+IENgU3YfGbmGrAvYlSL11WRcxcdcKtiUGdv9zY5eY11HqTwWfzwNA5LNr0vtvmCaJGE59SgjA==
X-Received: by 2002:a05:6a21:3996:b0:1e1:aa10:5491 with SMTP id adf61e73a8af0-1e1aa10551bmr7377154637.24.1733758895358;
        Mon, 09 Dec 2024 07:41:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e8177c7esm2723784b3a.108.2024.12.09.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:41:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 9 Dec 2024 07:41:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Dave Penkler <dpenkler@gmail.com>,
	Stafford Horne <shorne@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: Linux 6.13-rc2
Message-ID: <12dfd74a-2c01-441d-9085-c1a0ec45f908@roeck-us.net>
References: <CAHk-=wgDe9JfGynY9KQ1exkL0DM-cyLYdeYdOxbCXNHm=qAgSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgDe9JfGynY9KQ1exkL0DM-cyLYdeYdOxbCXNHm=qAgSQ@mail.gmail.com>

On Sun, Dec 08, 2024 at 02:15:17PM -0800, Linus Torvalds wrote:
> The diffstat looks a bit unusual with 80%+ drivers, and a lot of it
> one-liners, but that's actually just because of a couple of automated
> scripts that got run after -rc1 for some cleanups. Nothing
> particularly interesting, but it makes for a lot of noise in the diff.
> 
> That said, there are real fixes in there too, but nothing that looks
> hugely remarkable. The shortlog below gives a flavor of it all. That's
> m ostly drivers too, but there's networking and bpf and some arch
> updates too.
> 
> Please do keep testing, and then we can all take it a bit easier over
> the holidays,
> 

Build results:
	total: 161 pass: 155 fail: 6
Failed builds:
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	openrisc:allmodconfig
	s390:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 544 pass: 528 fail: 16
Failed tests:
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:mem128:net=default:imx25-pdk:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:sd:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net=default:imx25-pdk:ext2
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net=default:imx25-pdk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:mem256:net=nic:net=nic:imx6ul-14x14-evk:initrd
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:sd:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx6ul-evk:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=nic:net=nic:imx6ul-14x14-evk:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:mem256:net=nic:imx7d-sdb:initrd
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:usb1:mem256:net=nic:imx7d-sdb:ext2
	arm:mcimx7d-sabre:imx_v6_v7_defconfig:nodrm:smp2:sd:mem256:net=nic:imx7d-sdb:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mem256:net=default:imx6dl-sabrelite:initrd
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:mmc,b300:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb0:mem256:net=default:imx6dl-sabrelite:ext2
	arm:sabrelite:imx_v6_v7_defconfig:nodrm:usb1:mem256:net=default:imx6dl-sabrelite:ext2
	openrisc:or1200:or1ksim_defconfig
Unit test results:
	pass: 464016 fail: 0

A couple of problems have been fixed since last week. Fixes for the
remaining issues seen in my tests have all been submitted. Most of those
patches are queued in linux-next. Here is a summary from my fixes branch
at git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

4ea915f32887 openrisc: place exception table at the head of vmlinux
5d481cfdbbca ARM: imx: Re-introduce the PINCTRL selection
62fb306f9082 locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT
e49fe26b045d tty: serial: Work around warning backtrace in serial8250_set_defaults
f11efcf05715 staging: gpib: Fix i386 build issue
1468f1923008 staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT

All my build and boot tests pass with those patches applied.

I attached a long version of the commit log for reference and for details.
I added owners to Cc.

Guenter

---
commit 4ea915f3288756d829ba8abbd6cee10cf84a5a11
Author:     Masahiro Yamada <masahiroy@kernel.org>
AuthorDate: Mon Dec 2 15:28:22 2024 +0900
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    openrisc: place exception table at the head of vmlinux
    
    Since commit 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in
    text output section"), the exception table in arch/openrisc/kernel/head.S
    is no longer positioned at the very beginning of the kernel image, which
    causes a boot failure.
    
    Currently, the exception table resides in the regular .text section.
    Previously, it was placed at the head by relying on the linker receiving
    arch/openrisc/kernel/head.o as the first object. However, this behavior
    has changed because sections like .text.{asan,unknown,unlikely,hot} now
    precede the regular .text section.
    
    The .head.text section is intended for entry points requiring special
    placement. However, in OpenRISC, this section has been misused: instead
    of the entry points, it contains boot code meant to be discarded after
    booting. This feature is typically handled by the .init.text section.
    
    This commit addresses the issue by replacing the current __HEAD marker
    with __INIT and re-annotating the entry points with __HEAD. Additionally,
    it adds __REF to entry.S to suppress the following modpost warning:
    
      WARNING: modpost: vmlinux: section mismatch in reference: _tng_kernel_start+0x70 (section: .text) -> _start (section: .init.text)
    
    Fixes: 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in text output section")
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Closes: https://lore.kernel.org/all/5e032233-5b65-4ad5-ac50-d2eb6c00171c@roeck-us.net/#t
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Link: https://lore.kernel.org/r/20241202062909.2194341-1-masahiroy@kernel.org
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 5d481cfdbbca351f7fa347bd59f1471db7123305
Author:     Fabio Estevam <festevam@denx.de>
AuthorDate: Wed Nov 27 16:06:05 2024 -0300
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    ARM: imx: Re-introduce the PINCTRL selection
    
    Since commit 17d210018914 ("ARM: imx: Allow user to disable pinctrl"),
    the CONFIG_PINCTRL option is no longer implicitly selected, causing
    several i.MX SoC pinctrl drivers no longer getting selected by default.
    
    This causes boot regressions on the ARMv4, ARMv5, ARMv6 and ARMv7
    i.MX SoCs.
    
    Fix it by selecting CONFIG_PINCTRL as before.
    
    This defeats the purpose of 7d210018914 ("ARM: imx: Allow user to disable
    pinctrl"), but it is the less invasive fix for the boot regressions.
    
    The attempt to build Layerscape without pinctrl can still be explored
    later as suggested by Arnd:
    
    "Overall, my best advice here is still to not change the way
    i.MX pinctrl works at all, but just fix Layerscape to not depend
    on i.MX. The reason for the 'select' here is clearly that the
    i.MX machines would fail to boot without pinctrl, and changing
    that because of Layerscape seems backwards."
    
    Fixes: 17d210018914 ("ARM: imx: Allow user to disable pinctrl")
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Closes: https://lore.kernel.org/linux-arm-kernel/49ff070a-ce67-42d7-84ec-8b54fd7e9742@roeck-us.net/
    Signed-off-by: Fabio Estevam <festevam@denx.de>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Link: https://lore.kernel.org/20241127190605.1367157-1-festevam@gmail.com
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 62fb306f9082badff8e7ddc65140c156f380cb96
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Wed Nov 27 21:00:09 2024 -0500
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT
    
    Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
    that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
    they will not be forced to address unimportant raw lock nesting issues
    when they want to enable PROVE_LOCKING.  They do have the option
    to enable it to look for these raw locking nesting problems if they
    choose to.
    
    Suggested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Waiman Long <longman@redhat.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Link: https://lore.kernel.org/r/20241128020009.83347-1-longman@redhat.com
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit e49fe26b045d7819e45e0ed7156d9c546b0e5276
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Thu Dec 5 06:30:33 2024 -0800
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    tty: serial: Work around warning backtrace in serial8250_set_defaults
    
    Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
    triggers warning backtraces on a number of platforms which don't support
    IO ports.
    
    WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
    Unsupported UART type 0
    
    The problem is seen because serial8250_set_defaults() is called for
    all members of the serial8250_ports[] array even if that array is
    not initialized.
    
    Work around the problem by only displaying the warning if the port
    type is not 0 (UPIO_PORT) or if iobase is set for the port.
    
    Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Cc: Niklas Schnelle <schnelle@linux.ibm.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Tested-by: Stafford Horne <shorne@gmail.com>
    Link: https://lore.kernel.org/r/20241205143033.2695333-1-linux@roeck-us.net
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit f11efcf05715a9f4df0411452cdebb832006798a
Author:     Dave Penkler <dpenkler@gmail.com>
AuthorDate: Wed Dec 4 17:21:28 2024 +0100
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    staging: gpib: Fix i386 build issue
    
    These drivers cast resource_type_t to void * causing the build to fail.
    
    With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
    int which cannot be cast to a 32 bit pointer.
    
    Disable these drivers if X68_PAE is enabled
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
    Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
    Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
    Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
    Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
    Signed-off-by: Dave Penkler <dpenkler@gmail.com>
    Link: https://lore.kernel.org/r/20241204162128.25617-1-dpenkler@gmail.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

commit 1468f19230080ec3c5b6f8565e679c6482d650fb
Author:     Nathan Chancellor <nathan@kernel.org>
AuthorDate: Sat Nov 23 13:03:25 2024 -0700
Commit:     Guenter Roeck <linux@roeck-us.net>
CommitDate: Sun Dec 8 15:41:42 2024 -0800

    staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT
    
    After commit 78ecb0375685 ("staging: gpib: make port I/O code
    conditional"), building tnt4882.ko on platforms without HAS_IOPORT (such
    as hexagon and s390) fails with:
    
      ERROR: modpost: "inb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
      ERROR: modpost: "inw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
      ERROR: modpost: "nec7210_locking_ioport_write_byte" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
      ERROR: modpost: "nec7210_locking_ioport_read_byte" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
      ERROR: modpost: "outb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
      ERROR: modpost: "outw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
    
    Only allow tnt4882.ko to be built when CONFIG_HAS_IOPORT is set to avoid
    this build failure, as this driver unconditionally needs it.
    
    Fixes: 78ecb0375685 ("staging: gpib: make port I/O code conditional")
    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
    Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Link: https://lore.kernel.org/r/20241123-gpib-tnt4882-depends-on-has_ioport-v1-1-033c58b64751@kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>

