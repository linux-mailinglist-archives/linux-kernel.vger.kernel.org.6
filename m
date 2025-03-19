Return-Path: <linux-kernel+bounces-567303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6399A6845B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE63BEF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880D212B04;
	Wed, 19 Mar 2025 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT1cuOdj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AD1DEFDA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360833; cv=none; b=uCuF6KumtkjLbNmylKXHHKKjxmieYvfzgZ0nM+eBU4p9yuuRLl2eEtIPBgACf1WFWpXC8nWHqsXaxPfTsTNds2zd0vXa56EJQu3h6tCjAXdivaCWOnyJj8Jj5SyO+U8EUKXlllra4ZCN7Sh0IBwOyUO0Dwbxev7I4FRYyZWt+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360833; c=relaxed/simple;
	bh=aCpyJdqLyzvkjOuIKdcGot0j8nlU0JGD1exVqcWMG94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OkKHdLmN1qvVb37Lagt2CkgmL/Gj+yFdTKI45PG9v+dDTeTJ5S42yjaEGuuSUxYctLzAoOu5s0Kyz6uXmKH2mrYEZ9AmERzXpHnvoi8FbMKFWXgyiUZWWfozPvK8Dp8vmmsJx1plvaiernANFYUhwS8IOKtFUv+5DExZixqgEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT1cuOdj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742360831; x=1773896831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aCpyJdqLyzvkjOuIKdcGot0j8nlU0JGD1exVqcWMG94=;
  b=QT1cuOdj8jBPRq9wwrnUGlSgFlbCSUeLWJsC6ieXB5jZZOXqc4gOpdE4
   5hemxgvhrCYai6lulmhwGYEFxk2rB8oTugutNLR97Mzle68D4A26XZH9h
   M+tVfaO86gL5CHyKCDlaZ2FKGmKOQYjYhms7wVL/SKEWuIivB55iR5P/A
   s09vJel4hTl7etEIgbY1iTJlAWPzRi6IT+0cZ46m3CKkp9pMAJfdbb0JI
   RFOgljF+indlBZm4AwitHpbVkES7EiQ5prSmGXojp/x235UTb69qhzNut
   AAht47qcu6yDTeNJx/W39jrrUpW7d3rAQckcqj6xkEUvSz2U/O3TDyivl
   g==;
X-CSE-ConnectionGUID: k1UiLBW8Tv+PLXWOYDKRQQ==
X-CSE-MsgGUID: RoN9/Wq2TMq7bLy/tu8OZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43265632"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43265632"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 22:07:11 -0700
X-CSE-ConnectionGUID: qPv2bDi7RSmb3pjdL1vnOA==
X-CSE-MsgGUID: ysYKOgBPTpSE1wnazadkPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127569837"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Mar 2025 22:07:09 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuldz-000ENE-03;
	Wed, 19 Mar 2025 05:07:07 +0000
Date: Wed, 19 Mar 2025 13:06:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: cc1: error: cannot load plugin
 ./scripts/gcc-plugins/stackleak_plugin.so:
 ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol:
 _ZN8opt_pass14set_pass_paramEjb
Message-ID: <202503191250.ZHqkeLVs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: b5db73fb18257cd5d9cb59bc4b779fffa629566a riscv: enable HAVE_ARCH_STACKLEAK
date:   8 months ago
config: riscv-randconfig-r064-20250319 (https://download.01.org/0day-ci/archive/20250319/202503191250.ZHqkeLVs-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191250.ZHqkeLVs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503191250.ZHqkeLVs-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so: ./scripts/gcc-plugins/structleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>> cc1: error: cannot load plugin ./scripts/gcc-plugins/stackleak_plugin.so: ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so: ./scripts/gcc-plugins/structleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
   cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>> cc1: error: cannot load plugin ./scripts/gcc-plugins/stackleak_plugin.so: ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
   make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1207: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

