Return-Path: <linux-kernel+bounces-197322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400498D694C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621D51C21F20
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2517CA0D;
	Fri, 31 May 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4eF8gge"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02F15AD93
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181804; cv=none; b=qXDrYRdykHY0BMi+tzx+kp1hvInZaKexVqmo0G8D/EutDfWECABQ6vApOZ9kjMQZzCAMNDavdVMtCSRUpAHxOx0hBSrHwMlOb+hCxWtmvxYe05ALbLLyRyfz+UFpGwRzuQM26mbAkLPhl8tveVYHGX3VHXJW/F3QDdYUbU0Z8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181804; c=relaxed/simple;
	bh=SrJwZ/7eOLujVLRysciVp6Tf179CgGDJdlrnRGdI2qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSJc4m8vssOdoho1F7hfioW5IPJvTHFVe1C3humGl+O4VaWdZVA1NsyF+lfIXuXnINE2qHCbvo+dcZDLR3+ayiGyKNoD9Tla/ojFHIB/l+SHk9pCsJLjrnfevWesAODernThfbCq+4MYtoh7ybSlwO0jrBftQ2D/CauvgQImHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4eF8gge; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717181803; x=1748717803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrJwZ/7eOLujVLRysciVp6Tf179CgGDJdlrnRGdI2qk=;
  b=D4eF8gge9we+d5XpioTtWr0g7t6cvEMkNoZLBBKwpH4SGwzxX6EkhwsD
   qMUE6d2oQnoHj0JzOSpG8PhBlUw5A1LtOdvuvtOyQB1kGoLCHQMAKMq+6
   cdB6NNOjYWGBQi4N94cK/aaSZxtNTMf/afxyPPFjdgzoWTfkIGTmd/GvJ
   elX6962W2D4s7QY8eshoMdGztPvFAf3mCahNBzTV/Al8OzeenI4vJuP+L
   kxVpp5fzMoNe8h+hAIwBoz0vU71lXL2hEZ5bhPUlCR6FYjWcbXs3yuybY
   7eEodTUV0RrScQ/BhYZyUnFfrP0YZZfQ2M5aYoNZgwWp3G442klystMZn
   g==;
X-CSE-ConnectionGUID: YvkqDoSwRF6TrnUMPVEZ3A==
X-CSE-MsgGUID: iB+75/OsQO2y3TQzUfCamw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13581624"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13581624"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:56:42 -0700
X-CSE-ConnectionGUID: ghdv28QiTZ+1fU84+KkuEw==
X-CSE-MsgGUID: C3uIBoSNQoqmiTs/k80Z+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40685318"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 31 May 2024 11:56:39 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD7QW-000Hfl-0L;
	Fri, 31 May 2024 18:56:33 +0000
Date: Sat, 1 Jun 2024 02:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <202406010241.HBpKhSuj-lkp@intel.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531162327.2436962-1-jesse@rivosinc.com>

Hi Jesse,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-Use-Zkr-to-seed-KASLR-base-address/20240601-002545
base:   linus/master
patch link:    https://lore.kernel.org/r/20240531162327.2436962-1-jesse%40rivosinc.com
patch subject: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240601/202406010241.HBpKhSuj-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010241.HBpKhSuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010241.HBpKhSuj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/pi/archrandom_early.c:13:
   In file included from arch/riscv/include/asm/archrandom.h:13:
   In file included from arch/riscv/include/asm/processor.h:71:
   In file included from include/linux/cpumask.h:11:
   In file included from include/linux/kernel.h:31:
>> include/linux/printk.h:619:9: warning: 'pr_err_once' macro redefined [-Wmacro-redefined]
     619 | #define pr_err_once(fmt, ...)                                   \
         |         ^
   arch/riscv/kernel/pi/archrandom_early.c:9:9: note: previous definition is here
       9 | #define pr_err_once(...)
         |         ^
>> arch/riscv/kernel/pi/archrandom_early.c:51:22: warning: variable 'tvec' is uninitialized when used here [-Wuninitialized]
      51 |         csr_write(CSR_TVEC, tvec);
         |                             ^~~~
   arch/riscv/include/asm/csr.h:506:38: note: expanded from macro 'csr_write'
     506 |         unsigned long __v = (unsigned long)(val);               \
         |                                             ^~~
   arch/riscv/kernel/pi/archrandom_early.c:44:20: note: initialize the variable 'tvec' to silence this warning
      44 |         unsigned long tvec;
         |                           ^
         |                            = 0
   2 warnings generated.


vim +/pr_err_once +619 include/linux/printk.h

16cb839f1332497 Joe Perches     2011-01-12  612  
16cb839f1332497 Joe Perches     2011-01-12  613  #define pr_emerg_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  614  	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12  615  #define pr_alert_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  616  	printk_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12  617  #define pr_crit_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  618  	printk_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12 @619  #define pr_err_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  620  	printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12  621  #define pr_warn_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  622  	printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12  623  #define pr_notice_once(fmt, ...)				\
16cb839f1332497 Joe Perches     2011-01-12  624  	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
16cb839f1332497 Joe Perches     2011-01-12  625  #define pr_info_once(fmt, ...)					\
16cb839f1332497 Joe Perches     2011-01-12  626  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
eb012d125a24197 Tetsuo Handa    2020-05-25  627  /* no pr_cont_once, don't do that... */
36d308d8b547ee1 Mikhail Gruzdev 2013-02-21  628  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

