Return-Path: <linux-kernel+bounces-226351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8B913D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D69B211A7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A71836EB;
	Sun, 23 Jun 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Khf36Mrq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C52F4A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164954; cv=none; b=AEGGvStxCUk1m0k9Y71WaTe+JsRGkujxQCAeams8cB43E1bWHbx+SBtZZYE8fcO9Z1y5Hw9Hs0Retd8WLdUcNapx/LJils075He9gJON8mTYzyzDW1m+ik+lv01MucAqWgJ3dPnRXF/wQZiabR/dUoIEtL1q7IIrT5ewlrtP4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164954; c=relaxed/simple;
	bh=3QoGuMYDJFQ64ysOYCpdxWOFL0YwsWoHuLXLdbGZFCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a0SRCXjiU9x3p24BGOALT2EhxxiFW55vfvUvvZqfKdxff06RUBuIHn9pFgcWmqvt0obrfvaQqemTeqteZ8rPqz9/JqRTJytm0j1XKsAZc97YT+V3Mc73hcsKiQAYbU8CrlzrCfRMDqlpPIgNXywJ/C0U7IF7g2FUdtDxRWjU6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Khf36Mrq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719164951; x=1750700951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3QoGuMYDJFQ64ysOYCpdxWOFL0YwsWoHuLXLdbGZFCQ=;
  b=Khf36MrqYQcmYM1/5dfVzl80VblPEiSLTBxkYWy+fJlDQQtO2Api8G74
   4d47utBIySA1TEa+Rn6PyDj2KXaa3/sBfioy/Q4cKA3iNEDnSsYpWFbHH
   VxeMgKT1wRvuyRpksdPz6KAUwk06seLiXXVItDuCti7nUZsKvDKWI0Dg9
   RHxgIs+4l3l6uH63P10H7fORQAWZSmIEgr86bfb97dK6X9tkg5NTYDRDr
   wSH98KjDoxEHUXvXt+OM+cuA4pBmu7SYAQCnVWavzO+F3Wok2tIorpsWm
   A4j3KRpu3pdlkcOeLECKue6JbwPAUUTA80MP2LAlMHLYSBD0aIGIONSSv
   w==;
X-CSE-ConnectionGUID: WZCR5EU8QMC0azcrftoTNQ==
X-CSE-MsgGUID: eoXuK8yrRp2lpxkJE57BIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33593942"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="33593942"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:49:11 -0700
X-CSE-ConnectionGUID: PrKinLl4R+eB6TuOq1rAvA==
X-CSE-MsgGUID: V2hS/XW5RgiyYM4GrXJ9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="42976951"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 23 Jun 2024 10:49:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLRKt-000Aqy-1T;
	Sun, 23 Jun 2024 17:49:07 +0000
Date: Mon, 24 Jun 2024 01:48:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andreas Larsson <andreas@gaisler.com>
Subject: arch/sparc/kernel/head_32.S:121:(.head.text+0x5040): relocation
 truncated to fit: R_SPARC_WDISP22 against `.init.text'
Message-ID: <202406240441.5zaoshVX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sam,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c16f0a4ed1ce7b0dd1c01fc012e5bde89fe7748
commit: 91d3ff922c346d6d8cb8de5ff8d504fe0ca9e17e sparc32: Fix parport build with sparc32
date:   4 months ago
config: sparc-randconfig-r026-20230907 (https://download.01.org/0day-ci/archive/20240624/202406240441.5zaoshVX-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406240441.5zaoshVX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406240441.5zaoshVX-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/head_32.o: in function `current_pc':
>> arch/sparc/kernel/head_32.S:121:(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
   arch/sparc/kernel/head_32.o: in function `halt_notsup':
   arch/sparc/kernel/head_32.S:198:(.head.text+0x5100): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
   arch/sparc/kernel/head_32.o: in function `leon_init':
   arch/sparc/kernel/head_32.S:434:(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o
>> arch/sparc/kernel/process_32.o:(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/process_32.o:(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
>> arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
   arch/sparc/kernel/signal_32.o:(.fixup+0x28): additional relocation overflows omitted from the output


vim +121 arch/sparc/kernel/head_32.S

^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   66  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   67  	.global root_flags
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   68  	.global ram_flags
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   69  	.global root_dev
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   70  	.global sparc_ramdisk_image
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   71  	.global sparc_ramdisk_size
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   72  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   73  /* This stuff has to be in sync with SILO and other potential boot loaders
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   74   * Fields should be kept upward compatible and whenever any change is made,
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   75   * HdrS version should be incremented.
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   76   */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   77  	.ascii	"HdrS"
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   78  	.word	LINUX_VERSION_CODE
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   79  	.half	0x0203		/* HdrS version */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   80  root_flags:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   81  	.half	1
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   82  root_dev:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   83  	.half	0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   84  ram_flags:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   85  	.half	0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   86  sparc_ramdisk_image:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   87  	.word	0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   88  sparc_ramdisk_size:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   89  	.word	0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   90  	.word	reboot_command
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   91  	.word	0, 0, 0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   92  	.word	_end
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   93  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   94  /* Cool, here we go. Pick up the romvec pointer in %o0 and stash it in
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   95   * %g7 and at prom_vector_p. And also quickly check whether we are on
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   96   * a v0, v2, or v3 prom.
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   97   */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   98  gokernel:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16   99  		/* Ok, it's nice to know, as early as possible, if we
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  100  		 * are already mapped where we expect to be in virtual
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  101  		 * memory.  The Solaris /boot elf format bootloader
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  102  		 * will peek into our elf header and load us where
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  103  		 * we want to be, otherwise we have to re-map.
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  104  		 *
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  105  		 * Some boot loaders don't place the jmp'rs address
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  106  		 * in %o7, so we do a pc-relative call to a local
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  107  		 * label, then see what %o7 has.
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  108  		 */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  109  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  110  		mov	%o7, %g4		! Save %o7
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  111  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  112  		/* Jump to it, and pray... */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  113  current_pc:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  114  		call	1f
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  115  		 nop
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  116  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  117  1:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  118  		mov	%o7, %g3
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  119  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  120  		tst	%o0
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16 @121  		be	no_sun4u_here
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  122  		 mov	%g4, %o7		/* Previous %o7. */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  123  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  124  		mov	%o0, %l0		! stash away romvec
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  125  		mov	%o0, %g7		! put it here too
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  126  		mov	%o1, %l1		! stash away debug_vec too
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  127  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  128  		/* Ok, let's check out our run time program counter. */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  129  		set	current_pc, %g5
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  130  		cmp	%g3, %g5
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  131  		be	already_mapped
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  132  		 nop
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  133  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  134  		/* %l6 will hold the offset we have to subtract
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  135  		 * from absolute symbols in order to access areas
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  136  		 * in our own image.  If already mapped this is
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  137  		 * just plain zero, else it is KERNBASE.
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  138  		 */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  139  		set	KERNBASE, %l6
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  140  		b	copy_prom_lvl14
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  141  		 nop
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  142  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  143  already_mapped:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  144  		mov	0, %l6
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  145  
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  146  		/* Copy over the Prom's level 14 clock handler. */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  147  copy_prom_lvl14:
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  148  #if 1
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  149  		/* DJHR
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  150  		 * preserve our linked/calculated instructions
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  151  		 */
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  152  		set	lvl14_save, %g1
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  153  		set	t_irq14, %g3
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  154  		sub	%g1, %l6, %g1		! translate to physical
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  155  		sub	%g3, %l6, %g3		! translate to physical
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  156  		ldd	[%g3], %g4
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  157  		std	%g4, [%g1]
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  158  		ldd	[%g3+8], %g4
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  159  		std	%g4, [%g1+8]
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  160  #endif
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  161  		rd	%tbr, %g1
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  162  		andn	%g1, 0xfff, %g1		! proms trap table base
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  163  		or	%g0, (0x1e<<4), %g2	! offset to lvl14 intr
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  164  		or	%g1, %g2, %g2
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  165  		set	t_irq14, %g3
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  166  		sub	%g3, %l6, %g3
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  167  		ldd	[%g2], %g4
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  168  		std	%g4, [%g3]
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  169  		ldd	[%g2 + 0x8], %g4
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  170  		std	%g4, [%g3 + 0x8]	! Copy proms handler
^1da177e4c3f41 arch/sparc/kernel/head.S Linus Torvalds 2005-04-16  171  

:::::: The code at line 121 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

