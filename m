Return-Path: <linux-kernel+bounces-428596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4C9E110C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9502016449C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081F1304BA;
	Tue,  3 Dec 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiZZFbXC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740E80035
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191488; cv=none; b=uZe2N0SUolIr81nKixpgckmSZmORerHpIgHRCAWSMMCVdY/FoYlWQpWXQvBhSjaHgtVvD98Kpyh05gZYKwmddWJescN6GSgmZzgHsColjNvCjiJESaObO2RjSLWpJEe0tPv4TnlgeVDBMarEeRYEtROPlIX/DEIR09d1+VIrTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191488; c=relaxed/simple;
	bh=6AHTOTQ+BkDAw29f1gLm4fxDaCgMv7TLc2DRxb74kxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tkup0OlgJ0wFP7zGZZiJ5nH+Bm6NiZKVN60XUXyJHzd0UQge7FIppupJMgUNmJNPcxHmWd9Wy54FQ6I5lA6j2M8YIAFYRjMciKjXAWxACm7MuC5KoWoYVk5QllYbreZd0nGrGs9Wmgdnj9oh8gUlAY2GSE4kpwxQiOBeed0fkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiZZFbXC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733191487; x=1764727487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6AHTOTQ+BkDAw29f1gLm4fxDaCgMv7TLc2DRxb74kxI=;
  b=XiZZFbXCbhDX6UkXusda4IFAMTppwzUFQ5Qy2FZo9N3h2iYzME4e+Ie/
   nZ/AFAHpEJfcb7tSsCBDlQTkmpgl5j7vpUOGTX2F2M/qamrjX3HeHCHeP
   3L/353UPD5FUkjA5GKsJEp663KBefgOEPtNKLkmsFcZHAXfmJQTggYb8O
   Rton3t7YB24sunNrcxLXm2P7abG+Ly6pOXJIk13pcVhDnlsaezilXFXBi
   VbWUnPYLDL5npe8ENFC4OPEPNurUsn0CfEgqHabmjHUpUqFgIY/WJfbhL
   nC3qBXYJ3+KsCD8Tjh8ZyounB9B7TQBxm3IfGUYURyVZVwPN06p14c/dq
   w==;
X-CSE-ConnectionGUID: V/u0eF//RC6waEzisBSvnQ==
X-CSE-MsgGUID: NQLDwiguRxuwgUU+BWnmHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33263831"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33263831"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:04:47 -0800
X-CSE-ConnectionGUID: s0KSbzEKRsOFFKMAAy2oRA==
X-CSE-MsgGUID: yudMqvu/Sd+C7McsmuMpxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93369303"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Dec 2024 18:04:44 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIHE-00039n-1L;
	Tue, 03 Dec 2024 02:04:37 +0000
Date: Tue, 3 Dec 2024 10:04:00 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, Alex Shi <alexs@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: arch/m68k/include/asm/m54xxsim.h:112:33: error: passing argument 1
 of 'readl' makes pointer from integer without a cast
Message-ID: <202412031041.k4eDb4zq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   2 years, 9 months ago
config: m68k-randconfig-r072-20241111 (https://download.01.org/0day-ci/archive/20241203/202412031041.k4eDb4zq-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031041.k4eDb4zq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031041.k4eDb4zq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/mcfsim.h:46,
                    from arch/m68k/include/asm/io_no.h:35,
                    from arch/m68k/include/asm/io.h:6,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from arch/m68k/coldfire/m54xx.c:16:
   arch/m68k/coldfire/m54xx.c: In function 'm54xx_i2c_init':
>> arch/m68k/include/asm/m54xxsim.h:112:33: error: passing argument 1 of 'readl' makes pointer from integer without a cast [-Wint-conversion]
     112 | #define MCF_PAR_FECI2CIRQ       (MCF_MBAR + 0x00000a44) /* FEC/I2C/IRQ */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   arch/m68k/coldfire/m54xx.c:70:19: note: in expansion of macro 'MCF_PAR_FECI2CIRQ'
      70 |         r = readl(MCF_PAR_FECI2CIRQ);
         |                   ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/io_no.h:74:54: note: expected 'const volatile void *' but argument is of type 'int'
      74 | static inline u32 readl(const volatile void __iomem *addr)
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/m68k/include/asm/m54xxsim.h:112:33: error: passing argument 2 of 'writel' makes pointer from integer without a cast [-Wint-conversion]
     112 | #define MCF_PAR_FECI2CIRQ       (MCF_MBAR + 0x00000a44) /* FEC/I2C/IRQ */
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   arch/m68k/coldfire/m54xx.c:72:19: note: in expansion of macro 'MCF_PAR_FECI2CIRQ'
      72 |         writel(r, MCF_PAR_FECI2CIRQ);
         |                   ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/io_no.h:91:61: note: expected 'volatile void *' but argument is of type 'int'
      91 | static inline void writel(u32 value, volatile void __iomem *addr)
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/readl +112 arch/m68k/include/asm/m54xxsim.h

ea49f8ffae6262 arch/m68k/include/asm/m548xsim.h Philippe De Muyter 2010-09-20  111  
2d24b532f95b8b arch/m68k/include/asm/m54xxsim.h Steven King        2014-06-30 @112  #define MCF_PAR_FECI2CIRQ	(MCF_MBAR + 0x00000a44)	/* FEC/I2C/IRQ */
2d24b532f95b8b arch/m68k/include/asm/m54xxsim.h Steven King        2014-06-30  113  #define MCF_PAR_FECI2CIRQ_SDA	(1 << 3)
2d24b532f95b8b arch/m68k/include/asm/m54xxsim.h Steven King        2014-06-30  114  #define MCF_PAR_FECI2CIRQ_SCL	(1 << 2)
2d24b532f95b8b arch/m68k/include/asm/m54xxsim.h Steven King        2014-06-30  115  

:::::: The code at line 112 was first introduced by commit
:::::: 2d24b532f95b8b1b61bf670ef5bdee52bcf59640 m68knommu: platform support for i2c devices on ColdFire SoC

:::::: TO: Steven King <sfking@fdwdc.com>
:::::: CC: Greg Ungerer <gerg@linux-m68k.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

