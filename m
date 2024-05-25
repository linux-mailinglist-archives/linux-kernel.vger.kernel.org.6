Return-Path: <linux-kernel+bounces-189556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1818CF1EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8FF1C21015
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD086AFA;
	Sat, 25 May 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk/+v+N7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62050200BF
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678070; cv=none; b=TClV2Z3+Vs8mbUFvgzQ/YcA3o9i/+jyOo7687zFu0CoNEZk/hhXIuK2JoIDn2XVmKeGoKRBexqQYBqTq6SKCAJ400s3Hh91LjqM6ggOwb/cmpbmG3i8SkoDNicK8bNzm7cQr3tqAJdYMlPFV9M+XU6OOSTGbJDvFvp2HF3dN/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678070; c=relaxed/simple;
	bh=oOCFkkm20kOKs8yOEzYiW2PUiW0mS/ndNHsooJweSkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCyuQ7Ghj+MM1dvLoggh6CWsqlwZaqDZ5nEYZScZYezs9RsRfxHYJvHFUIlFXYCTWqoKusxEfc0pn+q+RuEZ94cu4XYH8CNBUZVgjCWUFqpYQhHlLqbqMU3J6iOmjtyOUSbbq00kvWIeD6jAXftEnBdyXqLe0tpZR815XR8J5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk/+v+N7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716678068; x=1748214068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oOCFkkm20kOKs8yOEzYiW2PUiW0mS/ndNHsooJweSkU=;
  b=Hk/+v+N79lG0dXFV8Nf5Ex9PNfEwkOCKHk/uf1FFU7TBz9Mky1yIpfLx
   v2IR2mRcL4eTVKfXIv8hiYwJqX0sgj+iyyu6x/wK08IuWn1jkFlZsLD10
   McayhZExZiqF9Cgm5FJI9NYa1Ba2n4GA8WaRbCU4Z9S3Nzzl031ECYl7Z
   CXFKXn84Fr1/4TSx9+S20p12OQeiGSxRcr9NlZziH8PdL4ZTrf8zoUIWE
   JujB4hjShi+aSunZNPpX+qbYzaUU/OfuUVIgnjvA0OS7+WXMqUVfD/LbZ
   BIeKuxNqOFtJO2CWWhGF3rWBT96MyJq1+nXD0fAxxaE/AMiqaN3rsneKE
   A==;
X-CSE-ConnectionGUID: 5x7oeLCZR3qI8DoAyh7yRA==
X-CSE-MsgGUID: F+334S+ER3q/zp5vHTgi2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="30557648"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="30557648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 16:01:08 -0700
X-CSE-ConnectionGUID: 2MCU28CNR3SByl3Mz/BfSA==
X-CSE-MsgGUID: X9uSWWsoRIy2AgZEIebn7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="34283215"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 25 May 2024 16:01:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB0Nq-0007Vb-2p;
	Sat, 25 May 2024 23:01:02 +0000
Date: Sun, 26 May 2024 07:00:58 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] x86/asm/bitops: Change function return types from long
 to int
Message-ID: <202405260651.QCsLIzXc-lkp@intel.com>
References: <20240525174448.174824-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525174448.174824-2-thorsten.blum@toblux.com>

Hi Thorsten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0b32d436c015d5a88b3368405e3d8fe82f195a54]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/x86-asm-bitops-Change-function-return-types-from-long-to-int/20240526-014828
base:   0b32d436c015d5a88b3368405e3d8fe82f195a54
patch link:    https://lore.kernel.org/r/20240525174448.174824-2-thorsten.blum%40toblux.com
patch subject: [PATCH] x86/asm/bitops: Change function return types from long to int
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240526/202405260651.QCsLIzXc-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405260651.QCsLIzXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405260651.QCsLIzXc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:573,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:374,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/devcoredump.h:8,
                    from sound/soc/intel/catpt/dsp.c:8:
   sound/soc/intel/catpt/dsp.c: In function 'catpt_dsp_set_srampge':
>> sound/soc/intel/catpt/dsp.c:181:44: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
     181 |                         dev_dbg(cdev->dev, "sanitize block %ld: off 0x%08x\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   sound/soc/intel/catpt/dsp.c:181:25: note: in expansion of macro 'dev_dbg'
     181 |                         dev_dbg(cdev->dev, "sanitize block %ld: off 0x%08x\n",
         |                         ^~~~~~~
   sound/soc/intel/catpt/dsp.c:181:62: note: format string is defined here
     181 |                         dev_dbg(cdev->dev, "sanitize block %ld: off 0x%08x\n",
         |                                                            ~~^
         |                                                              |
         |                                                              long int
         |                                                            %d


vim +181 sound/soc/intel/catpt/dsp.c

64b9b1b005743a Cezary Rojewski 2020-09-29  153  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  154  static void catpt_dsp_set_srampge(struct catpt_dev *cdev, struct resource *sram,
ba202a7bc3da05 Cezary Rojewski 2020-09-29  155  				  unsigned long mask, unsigned long new)
ba202a7bc3da05 Cezary Rojewski 2020-09-29  156  {
ba202a7bc3da05 Cezary Rojewski 2020-09-29  157  	unsigned long old;
ba202a7bc3da05 Cezary Rojewski 2020-09-29  158  	u32 off = sram->start;
ba202a7bc3da05 Cezary Rojewski 2020-09-29  159  	u32 b = __ffs(mask);
ba202a7bc3da05 Cezary Rojewski 2020-09-29  160  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  161  	old = catpt_readl_pci(cdev, VDRTCTL0) & mask;
ba202a7bc3da05 Cezary Rojewski 2020-09-29  162  	dev_dbg(cdev->dev, "SRAMPGE [0x%08lx] 0x%08lx -> 0x%08lx",
ba202a7bc3da05 Cezary Rojewski 2020-09-29  163  		mask, old, new);
ba202a7bc3da05 Cezary Rojewski 2020-09-29  164  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  165  	if (old == new)
ba202a7bc3da05 Cezary Rojewski 2020-09-29  166  		return;
ba202a7bc3da05 Cezary Rojewski 2020-09-29  167  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  168  	catpt_updatel_pci(cdev, VDRTCTL0, mask, new);
ba202a7bc3da05 Cezary Rojewski 2020-09-29  169  	/* wait for SRAM power gating to propagate */
ba202a7bc3da05 Cezary Rojewski 2020-09-29  170  	udelay(60);
ba202a7bc3da05 Cezary Rojewski 2020-09-29  171  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  172  	/*
ba202a7bc3da05 Cezary Rojewski 2020-09-29  173  	 * Dummy read as the very first access after block enable
ba202a7bc3da05 Cezary Rojewski 2020-09-29  174  	 * to prevent byte loss in future operations.
ba202a7bc3da05 Cezary Rojewski 2020-09-29  175  	 */
ba202a7bc3da05 Cezary Rojewski 2020-09-29  176  	for_each_clear_bit_from(b, &new, fls_long(mask)) {
ba202a7bc3da05 Cezary Rojewski 2020-09-29  177  		u8 buf[4];
ba202a7bc3da05 Cezary Rojewski 2020-09-29  178  
ba202a7bc3da05 Cezary Rojewski 2020-09-29  179  		/* newly enabled: new bit=0 while old bit=1 */
ba202a7bc3da05 Cezary Rojewski 2020-09-29  180  		if (test_bit(b, &old)) {
ba202a7bc3da05 Cezary Rojewski 2020-09-29 @181  			dev_dbg(cdev->dev, "sanitize block %ld: off 0x%08x\n",
ba202a7bc3da05 Cezary Rojewski 2020-09-29  182  				b - __ffs(mask), off);
ba202a7bc3da05 Cezary Rojewski 2020-09-29  183  			memcpy_fromio(buf, cdev->lpe_ba + off, sizeof(buf));
ba202a7bc3da05 Cezary Rojewski 2020-09-29  184  		}
ba202a7bc3da05 Cezary Rojewski 2020-09-29  185  		off += CATPT_MEMBLOCK_SIZE;
ba202a7bc3da05 Cezary Rojewski 2020-09-29  186  	}
ba202a7bc3da05 Cezary Rojewski 2020-09-29  187  }
ba202a7bc3da05 Cezary Rojewski 2020-09-29  188  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

