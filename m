Return-Path: <linux-kernel+bounces-376866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF049AB6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8002EB23C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0A1CC151;
	Tue, 22 Oct 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rl3E10eC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4A1C9EC2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625466; cv=none; b=hnUwJDKB3Y/ZdFVGxykh17766vZ/3wiCF9KU7BUCbBR6iM9Q4YqP55g3Ij0M4UAvN98W4jjKO0FsE6LbzXkSjeQM9mMc98PNQ5mqco8dH5CHN/GgucNIWRcYiJWvEDRPNf58QPFb3oLpfLucYOkpY5Xaozur1RDO3wUIJAcEtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625466; c=relaxed/simple;
	bh=5IQ/ppc7+JlLPx+hkAOzlEt+fDBk4swp5GV5ul9evFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a97kd7rBp99DF12S5c2Icck7s2TDLb8MVy7QPCczwa3ySq2QzNvOaKIwfWAc/Xb/NSwxsPvaPcjqoyfrpdH2f71PiW9sOjBuXr7Fd/Gsc679rxvV6YkHKIgkPMEUZwFK78oVMOCglfZftV+3cJcgq3g/Xs0m6DoscNZjyfYv87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rl3E10eC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729625465; x=1761161465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5IQ/ppc7+JlLPx+hkAOzlEt+fDBk4swp5GV5ul9evFw=;
  b=Rl3E10eCSE/nLyu/Yy8eOzyi8CfHymf6ixmVBA1FIsROIuwNqQ1GCmIF
   f5dFwvdDexDYsSAiqVbq2tZTklDvLsl7Z4tHQJv8zsdVZs8aljRBDjMdl
   MIbyD5YByyml0EXo7jm3zITJzkXf6bWhkYtZngJdyFucXrk68S4g1Dgjz
   GkTttgQ7KNSkrNPR87/xTpU5Xd0PWp4ctbYsLImg2vA3IfJbGGvd4BO//
   4JV33Ou323065+LtdpfInt/oPXdzSWUEyp9nERc6npO84UdwWJ8CF5LAk
   hYm+KPrPY+Qekcsqzks93HfB9lUygqbEw1TtvDzOBcXM65TEKNCnOqz6h
   g==;
X-CSE-ConnectionGUID: +ZS8n8kmTZC+cl7Y42iQMg==
X-CSE-MsgGUID: pLFDKitJQYq+0b544knGYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29077388"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29077388"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:31:04 -0700
X-CSE-ConnectionGUID: Pwm7nuaRS+OM+Ao/bzXSFQ==
X-CSE-MsgGUID: VwQ5hbwkRxu5oP8/NSHLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84759782"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Oct 2024 12:31:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3Kan-000U0d-2J;
	Tue, 22 Oct 2024 19:30:57 +0000
Date: Wed, 23 Oct 2024 03:30:45 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
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
Message-ID: <202410230354.sjewoFxA-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241023/202410230354.sjewoFxA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230354.sjewoFxA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230354.sjewoFxA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kasan.h:7,
                    from include/linux/mm.h:31,
                    from arch/sh/kernel/asm-offsets.c:14:
>> include/linux/kasan-tags.h:5:10: fatal error: asm/kasan.h: No such file or directory
       5 | #include <asm/kasan.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:102: arch/sh/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +5 include/linux/kasan-tags.h

     4	
   > 5	#include <asm/kasan.h>
     6	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

