Return-Path: <linux-kernel+bounces-197303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D48D6906
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30B61F2742E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92E7E0E9;
	Fri, 31 May 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMoFOfJX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DE7C097
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180538; cv=none; b=iiOtUKHeDsAwaXJd9u5+R+TiXZGe+1WnU5zU4zqFohfRSz0Rx/BGLCyx2GkSWmkaKZ+Ch5CCfw8r6PLKWZhnmpw6HiFC9l82Z4ScuJVhkHio+rk6sSAN3RhyW2dhygZGYZerskdVn98vArXRYjNj27CkKH8mXTCvs7JfK3TwEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180538; c=relaxed/simple;
	bh=r7DQ3avihlSDHYQgeFqpv8TcDPZqxHs/SRRgjLXHxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezu4LL2K1dMXkDCzN/CJC4cQc97cf7piEQIkEhGU9dtmoSrdmYrhbXW6EF3NiGMOjUE2z7sQ293TBJp9URL4qYPd/xRRSvNLszXJJlK1nYbOPtbtlnq5OJ1mRaWBtMrE2zjH3Xksv/6JjTa7SoEpzW71hAsgbUVJE3n6OU2v3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMoFOfJX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717180536; x=1748716536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r7DQ3avihlSDHYQgeFqpv8TcDPZqxHs/SRRgjLXHxvI=;
  b=eMoFOfJXIsYG7FOQvEHbsQri9n0lCuUq2I9LL3qjO2zighi1c1rhIoL8
   JmFTNWe0XlwM/OMpb6/+VAN3f1ADZZS0TSsH+F78nxF1AXZ0E/P7z+IJ8
   stpbN78lXA93aMQLr1QxH5gCF2IvHEstW+ijmExQfOLlyadOhQ3JO3HoK
   VYhi3ZxgAEtVv99mzM04QkSwA+celLHP4R0Pxwwj2HSbMX8ZA+uploJ4v
   XxQ+i9x1IMfhK/XdK0EUUQJfrSpITd+lZRvKEoN7Sws3cyFP9Rnxkeppt
   MbYQTjF4TnUahAmA7F8RKZ21RiDN9HhVsrGzSyrNg3P7mBDlA1KegYJto
   Q==;
X-CSE-ConnectionGUID: UvfxusF8RKO1q9s+RzJuwQ==
X-CSE-MsgGUID: /XijxneuS5+n9fqGccxAHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24400404"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="24400404"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:35:35 -0700
X-CSE-ConnectionGUID: 2aN9h814TI+3vFApkNNgOQ==
X-CSE-MsgGUID: Yby8Si2cSDGLlXOp5EhbUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36167529"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2024 11:35:32 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD769-000He7-25;
	Fri, 31 May 2024 18:35:29 +0000
Date: Sat, 1 Jun 2024 02:34:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <202406010252.0xgcgnD7-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/RISC-V-Use-Zkr-to-seed-KASLR-base-address/20240601-002545
base:   linus/master
patch link:    https://lore.kernel.org/r/20240531162327.2436962-1-jesse%40rivosinc.com
patch subject: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240601/202406010252.0xgcgnD7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010252.0xgcgnD7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010252.0xgcgnD7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/kernel/pi/archrandom_early.pi.o: in function `__pi_.L0 ':
>> __pi_archrandom_early.c:(.init.pi.text+0x90): undefined reference to `__pi__printk'
--
   In file included from include/linux/kernel.h:31,
                    from include/linux/cpumask.h:11,
                    from arch/riscv/include/asm/processor.h:71,
                    from arch/riscv/include/asm/archrandom.h:13,
                    from arch/riscv/kernel/pi/archrandom_early.c:13:
>> include/linux/printk.h:619: warning: "pr_err_once" redefined
     619 | #define pr_err_once(fmt, ...)                                   \
         | 
   arch/riscv/kernel/pi/archrandom_early.c:9: note: this is the location of the previous definition
       9 | #define pr_err_once(...)
         | 


vim +/pr_err_once +619 include/linux/printk.h

16cb839f133249 Joe Perches     2011-01-12  612  
16cb839f133249 Joe Perches     2011-01-12  613  #define pr_emerg_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  614  	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12  615  #define pr_alert_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  616  	printk_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12  617  #define pr_crit_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  618  	printk_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12 @619  #define pr_err_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  620  	printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12  621  #define pr_warn_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  622  	printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12  623  #define pr_notice_once(fmt, ...)				\
16cb839f133249 Joe Perches     2011-01-12  624  	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
16cb839f133249 Joe Perches     2011-01-12  625  #define pr_info_once(fmt, ...)					\
16cb839f133249 Joe Perches     2011-01-12  626  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
eb012d125a2419 Tetsuo Handa    2020-05-25  627  /* no pr_cont_once, don't do that... */
36d308d8b547ee Mikhail Gruzdev 2013-02-21  628  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

