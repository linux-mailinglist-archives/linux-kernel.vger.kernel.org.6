Return-Path: <linux-kernel+bounces-226618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301CB914107
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B20283718
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833F8C13;
	Mon, 24 Jun 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciZcw43o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD1CA6B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202864; cv=none; b=Bg/ZWGycS90TnZmtNcIS6cH5wtOfipuk8bdIfhaSCU9vR2ZdWkv3CGnJ+pZ/6HJMkrVmRS1aav4dBkAd9ZtBq8929dO3Xhe2tyZ1IdJvrCET6yUn6vPtQwb7StKqnjvhxGOgBu5PAS9wWICzMtRkt2wPpKj1X3RH2kWt0+ax9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202864; c=relaxed/simple;
	bh=YqlgdYpooMizTjiUeD/Mwjc0NmTTVx/683V0iz/Mkfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZSKym+D71iRP58keLvvmbTdY+6kSW02dnaMWhbEauvnKHToLK7Q2XJyQ1i+5zaFkoTq9zV/VGbCWIUIXtO8k97h8YPlB7LRfs0s44MLJusILtSB0wGyvlPbSi9JoiWuCjf+pxyw720R51MCxNaGiAULLzrHVGw8TSHxsxW4XSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciZcw43o; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719202863; x=1750738863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YqlgdYpooMizTjiUeD/Mwjc0NmTTVx/683V0iz/Mkfg=;
  b=ciZcw43o69fXFF92b8CTqufrev3ft0Tb7smTJIDGthdvs65bmaBTRBx0
   +4YOwdg+gIWuoDjJ93AHAkEsNIHB6Orw2X6WEFgTyM2H5EINSjd3d/9qK
   Xs1KknleOhph9JunEtDFtj3Cgt9oj9E9BkDUTwcbnCMDycXWPaJhuEUVL
   w+SqF2df/Mf7pCv3ID0R+veDR5TnrLUQ7exu4Z10iL01bgHWwbDyd8XOz
   eYxXEDN3GCRx+QdlSVckMYIrOrAk5RO8rIWth8CeyC1U15Ksw2U0UA+Pm
   o+7ksvtAKqkdOzB6+29xAHcbFhkNaR8q10fNJqRccJyVaW3MkG3r37m8B
   A==;
X-CSE-ConnectionGUID: jgsd9VQdQaCYZGYuowKutQ==
X-CSE-MsgGUID: j7IYhn41QluwG9LYuNmXJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="41559960"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="41559960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 21:21:02 -0700
X-CSE-ConnectionGUID: j8z3E6ILRtOxt9MhhcYP4w==
X-CSE-MsgGUID: ygfhCFixQgaM05FUUiUVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="48335153"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Jun 2024 21:21:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLbCM-000C5s-0h;
	Mon, 24 Jun 2024 04:20:58 +0000
Date: Mon, 24 Jun 2024 12:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: error: ABI 'o32' is not supported on CPU 'mips4'
Message-ID: <202406241220.InhXAWQe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2661062f16b2de5d7b6a5c42a9a5c96326b8454
commit: bfc0a330c1b4526b88f6f9e711484b342cb00fb5 MIPS: Fallback CPU -march flag to ISA level if unsupported
date:   4 months ago
config: mips-randconfig-r062-20240624 (https://download.01.org/0day-ci/archive/20240624/202406241220.InhXAWQe-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406241220.InhXAWQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406241220.InhXAWQe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: ABI 'o32' is not supported on CPU 'mips4'
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> error: ABI 'o32' is not supported on CPU 'mips4'
>> error: ABI 'o32' is not supported on CPU 'mips4'
   make[3]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
   make[3]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1198: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

