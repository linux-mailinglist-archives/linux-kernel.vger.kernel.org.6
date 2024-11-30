Return-Path: <linux-kernel+bounces-426322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615E9DF1B9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09282810AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234917C210;
	Sat, 30 Nov 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIHhUyPS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C7433BC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980659; cv=none; b=tbhOjxWHoe08rlIb+WS/Mk8uy+whK7J7zTpOv3XLdeK5ttvD+j1CwwPVGI2mGM+dI1hktge8Kw/gq2kv8cOaeKwTm9PZo81OeXmosz1RiuJLbPNG4hLMcBpXQtqYjZWbuJHTuBzAryb+Y0nGn7ataqbq+nhWJ7byn/cQZY+jcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980659; c=relaxed/simple;
	bh=oT9waIkIkkIDDtu1EVOfYovXOkkXNe9r1HZSd1PMIAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljZ/hhDBJdRIboQhgdsKtmWN7rW7gfNrqJojjCdo4j2RQ7yyDWQGBebAnrz1skNZpq4IzqA+LBvDtOTX8Je0nrhNR0LxtvpCRg7qlqrVgDjKKTcYaHBTijffY2Wh24In2E5qC0JfkU2SZXzImrN1eatm+u0ACRhr4BFYTfVNzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIHhUyPS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732980658; x=1764516658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oT9waIkIkkIDDtu1EVOfYovXOkkXNe9r1HZSd1PMIAs=;
  b=HIHhUyPSDAca8n3W/u0PM7Us4lcYBqtvy7PW3ZiPhCPUdKG4bGo8FBJ8
   fIQBgpkvp2TFj7RoUvhz+Kv28xMYH+j2FMNN5nZMNEF+83HQG/R4JSDrI
   APWwGdSpe2n5fFM3CjEB6QFWqDR0JFhL/2mFV/QMHW3hRcOcKHJ3L8Yx7
   JBZ/7K3923ZQlpCUg/8iGCoqjH+NeyvGmiK9I8r4QIFEkzitdIX77qiR0
   mLbuMw+p4bd3za/R5UGouLuonOtAc71k1f3vVVDWHwBTGuwqanDC2hRUT
   OZN2PDF3PZfqeWysa2uo5ec7In0XMMI+mmDnqjHzjk7nKIZf7e7PHGe4G
   Q==;
X-CSE-ConnectionGUID: 6/Cy310CTvKbhOM839Jcqw==
X-CSE-MsgGUID: mt5wyF9TR/ShU2OvThbH1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33048559"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="33048559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 07:30:57 -0800
X-CSE-ConnectionGUID: o8ncxb24QtenWfIRPjtkgw==
X-CSE-MsgGUID: Qx7ZPBjWSM6HW9rfPLEh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="93173849"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Nov 2024 07:30:56 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHPQ0-0000lK-1y;
	Sat, 30 Nov 2024 15:30:13 +0000
Date: Sat, 30 Nov 2024 23:29:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: error: ABI 'o32' is not supported on CPU 'mips4'
Message-ID: <202411302320.drPYfjqR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiaxun,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: bfc0a330c1b4526b88f6f9e711484b342cb00fb5 MIPS: Fallback CPU -march flag to ISA level if unsupported
date:   9 months ago
config: mips-randconfig-r112-20241007 (https://download.01.org/0day-ci/archive/20241130/202411302320.drPYfjqR-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce: (https://download.01.org/0day-ci/archive/20241130/202411302320.drPYfjqR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411302320.drPYfjqR-lkp@intel.com/

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

