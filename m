Return-Path: <linux-kernel+bounces-376897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B59AB72D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC011C23453
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672591CB311;
	Tue, 22 Oct 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtlWFGJ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8414A08E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626727; cv=none; b=YgDDK671p3nDwHFJ4Qc39xj9yen23gf7dMtzgsBkM/MeKoo875d6iZ6celKRzocC6PLDcyhwejkkORtT+aNix3FMjfWXhgqSHUbFuEMaj19r3bLfUeinTqcIxKHQuXnkAl1nRK6RYXLhp1ploi+4uN2maa4kECIwSJ14lpiVmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626727; c=relaxed/simple;
	bh=UlSzvYSwUTwKszAfPfGtBb/1Wy2hu7cv8ILTCepA7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJJ4ZCfCFc+ZCFo43oBw89bit7VZzSktbZaEfI5EtcrDvVuy9/wtgK3pXhL7Cv/kR73yuSIaqShJaM8aRcZZowPd08jNffiIGfP1C6II+xAlFYw0lBgFClJGWbOysU3NXpCVaYbPCVmGIs6nWZvu8l0DsiKDSqs6tC9uKyr2Qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtlWFGJ9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729626726; x=1761162726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UlSzvYSwUTwKszAfPfGtBb/1Wy2hu7cv8ILTCepA7tU=;
  b=JtlWFGJ9nWJ0EcgIti86rNaRYRbOUALBUtnpc/+mfzxt/HNVY6ThkxCx
   lnWhZC0SbZtLTrd0V5xqvU0JwVwCBW8hCU6riQEf9aCwKTn1c7wPy4c6d
   ULF8vji1qQ+CJhEfgwB/kBCFK8sB0J7wH8AIViMsT5/ZGjz3Sv4TiUrO+
   hs8Dw3rQoOqo3PwyPyyRn9fZs1I8DzIIX3q457bWkR+ztETf+28VYSbJ0
   AKB+PsMIKkv5MZdiQPzqq57ndVpapFl5MtzLwIWg+tkTG1BFLZjO48CYq
   jEEAL/HElzyjXWS0otcdujp5jbHIkP8c4kbTpKpqCeYwx3xPwLZjZxXq5
   Q==;
X-CSE-ConnectionGUID: m46uCsvVQG6uXC11qUpBNQ==
X-CSE-MsgGUID: 9pZ8OhrWQI6TqCR3Oj8Qew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28965267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28965267"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:52:05 -0700
X-CSE-ConnectionGUID: Hd7C0uazSJyFDhVm50mY0g==
X-CSE-MsgGUID: 5xrvzvoTRWWzZR0ykl21Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79538027"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Oct 2024 12:52:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3Kv9-000U2M-0D;
	Tue, 22 Oct 2024 19:51:59 +0000
Date: Wed, 23 Oct 2024 03:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 4/9] kasan: sw_tags: Support tag widths less than 8
 bits
Message-ID: <202410230319.eQozBGh7-lkp@intel.com>
References: <20241022015913.3524425-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022015913.3524425-5-samuel.holland@sifive.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on arm64/for-next/core masahiroy-kbuild/for-next masahiroy-kbuild/fixes linus/master v6.12-rc4 next-20241022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/kasan-sw_tags-Use-arithmetic-shift-for-shadow-computation/20241022-100129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241022015913.3524425-5-samuel.holland%40sifive.com
patch subject: [PATCH v2 4/9] kasan: sw_tags: Support tag widths less than 8 bits
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20241023/202410230319.eQozBGh7-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230319.eQozBGh7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230319.eQozBGh7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/um/kernel/asm-offsets.c:1:
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:5:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:234:
   In file included from include/linux/kasan.h:7:
   In file included from include/linux/kasan-tags.h:5:
>> arch/um/include/asm/kasan.h:19:2: error: "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
      19 | #error "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
         |  ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:102: arch/um/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +19 arch/um/include/asm/kasan.h

5b301409e8bc5d7 Patricia Alfonso 2022-07-01  12  
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  13  #ifdef CONFIG_X86_64
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  14  #define KASAN_HOST_USER_SPACE_END_ADDR 0x00007fffffffffffUL
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  15  /* KASAN_SHADOW_SIZE is the size of total address space divided by 8 */
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  16  #define KASAN_SHADOW_SIZE ((KASAN_HOST_USER_SPACE_END_ADDR + 1) >> \
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  17  			KASAN_SHADOW_SCALE_SHIFT)
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  18  #else
5b301409e8bc5d7 Patricia Alfonso 2022-07-01 @19  #error "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  20  #endif /* CONFIG_X86_64 */
5b301409e8bc5d7 Patricia Alfonso 2022-07-01  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

