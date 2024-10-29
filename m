Return-Path: <linux-kernel+bounces-387702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2421B9B54EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E7A28353B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57632209F56;
	Tue, 29 Oct 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJjV6oiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCxB9jQ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43920897B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236743; cv=none; b=e86H44PUfTRPVrw7F4T9XmUWPG6/8mjMqo6hgwDK1rOTaBNVc7HjbKsDOxfRRfFsRdE5xCaCx03XLn0cG56E8i0cMRC95dNR2Zgln077sn74LCK17BvP5WTDnuW7lBJk23c3A747xBIm7mSudjnMd/85tXji6q/quvowEd2dbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236743; c=relaxed/simple;
	bh=dv4bhimSyYfvrOi38m0XgZZxFgyEQwSEMbF7GlVQPaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYuNig75dT5NhcqZ+5gqcqMEX2eegHQCbC8M84KoaIxJsamq/STRpK5Tmxe6U8U+msewJsTIffhfg4n0cAbNB3cDqI3wOZ2YLQsJm4dsHGS29wv5LpCZzHdzAfNjwajvPl+yJ5cNY+0SZkMoxW9vYiDamjh1kLomOzmb3lwMU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJjV6oiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCxB9jQ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730236737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GfcGT3IOuRJChXP2bTvoVUa7Dcb57GbYFaja+I6Wrz0=;
	b=pJjV6oiU4ankcM6KRlgfeK7AJY/YMi1noCW6Q3RfcmISc1YQPJBFfQDQQp/a4XKidj1alL
	HiVTPP7hUj3/q29H7K8UBp0eaDrTP/wsPOdGOGR3FfxSmjZdiKC+lThXEgZvuc/NKbwSEZ
	U07sBl4QRHN4Q0fV/SOZbgFb01LNwhHYqMAx2NBVZWH2lRtyvZwLoUb0gpeB5GMjxMrwTB
	jb6IoRkN1atfg1P2mSS7+21d6ymywuRFrD9RXyfupLVPHtIfMxkFLBAEQkuy2YFUy/0WEF
	b4vv3L5OhQYit7HGX1JjIukZzxLChzVZcX+Z7a9NGOc9cFwK8a5JqLUl+0RKoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730236737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GfcGT3IOuRJChXP2bTvoVUa7Dcb57GbYFaja+I6Wrz0=;
	b=RCxB9jQ3/FsneNC0xIdmxg0SVxjFj4boqFsEMVoUXnsqQR3gcIgRpdvNlF5XoknhO5tG/8
	OCa21/U/cBtLs2BA==
To: kernel test robot <lkp@intel.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [tip:timers/vdso 11/13] include/vdso/page.h:15:39: error:
 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean
 'CONFIG_LOG_BUF_SHIFT'?
In-Reply-To: <202410290639.TBG289SO-lkp@intel.com>
References: <202410290639.TBG289SO-lkp@intel.com>
Date: Tue, 29 Oct 2024 22:18:56 +0100
Message-ID: <87ttcuzjy7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024 at 06:38, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> head:   d4a65302dd849fade9e2ca712826c35b8d068ecb
> commit: efe8419ae78d65e83edc31aad74b605c12e7d60c [11/13] vdso: Introduce vdso/page.h
> config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20241029/202410290639.TBG289SO-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290639.TBG289SO-lkp@intel.com/reproduce)

>      6	
>      7	/*
>      8	 * PAGE_SHIFT determines the page size.
>      9	 *
>     10	 * Note: This definition is required because PAGE_SHIFT is used
>     11	 * in several places throuout the codebase.
>     12	 */
>   > 13	#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>     14	
>   > 15	#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
>     16	

That's actually not the culprit. The problem exists in mainline too. The
actual root cause is:

  5394f1e9b687 ("arch: define CONFIG_PAGE_SIZE_*KB on all architectures")

The config has no CONFIG_PAGE_SHIFT because nothing selects a page size. The
the original code had:

if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
#define PAGE_SHIFT     13
#else
#define PAGE_SHIFT     12
#endif                        

But the Kconfig magic changes made this depend on various other things.

The patch below cures it, but it needs an eyeball from Geert.

Thanks,

        tglx
---
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index cc26df907bfe..6f50fdc4dff2 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -85,15 +85,12 @@ config MMU
 
 config MMU_MOTOROLA
 	bool
-	select HAVE_PAGE_SIZE_4KB
 
 config MMU_COLDFIRE
-	select HAVE_PAGE_SIZE_8KB
 	bool
 
 config MMU_SUN3
 	bool
-	select HAVE_PAGE_SIZE_8KB
 	depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
 
 config ARCH_SUPPORTS_KEXEC
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index c777a129768a..4d16215e7e45 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -21,6 +21,8 @@ choice
 config M68KCLASSIC
 	bool "Classic M68K CPU family support"
 	select HAVE_ARCH_PFN_VALID
+	select HAVE_PAGE_SIZE_4KB if !SUN3
+	select HAVE_PAGE_SIZE_8KB if SUN3
 
 config COLDFIRE
 	bool "Coldfire CPU family support"
@@ -30,7 +32,7 @@ config COLDFIRE
 	select GENERIC_CSUM
 	select GPIOLIB
 	select HAVE_LEGACY_CLK
-	select HAVE_PAGE_SIZE_8KB if !MMU
+	select HAVE_PAGE_SIZE_8KB
 
 endchoice
 
@@ -46,7 +48,6 @@ config M68000
 	select GENERIC_CSUM
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_ARCH_HASH
-	select HAVE_PAGE_SIZE_4KB
 	select LEGACY_TIMER_TICK
 	help
 	  The Freescale (was Motorola) 68000 CPU is the first generation of

