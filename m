Return-Path: <linux-kernel+bounces-316484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6EE96D02D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5735FB24178
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE7193074;
	Thu,  5 Sep 2024 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biNVtvUZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA31925AB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520508; cv=none; b=nZJG4KN0rk2YgqbUURzeYOBQQ+m66bX9hmB1IfI8/iJPCGHHBDYlSOBMiHrQblwDxTFzkKSv0pw3D2rHss20k76p9uWKZr8VkIaXWSoRRI+RsbHP+9Esx7R3J2rM/tUpMkdp+cTYXrIj7U0iNK0p+uiwLVEF266Zbd3hd7J1+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520508; c=relaxed/simple;
	bh=u/YelIEUUNe6qXoY7aOUePv/qteUXwtt7gdYajzcxoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pwz8Rk/wuEjKe7vm45Wv1Lc9ddqVE20hELYDJTck00jx4zcvRAKLUmmQ7qbilRCiCQguIRgUd34yabEP50EF+mwCX0+vYel5j/Um1p+KWV5EXUu0m3JG5Nk1ImBrBqPJagcJ4gOTJHRIMzA2o1SAoQaxAYj+Trgulj8WPEj8Ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biNVtvUZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725520507; x=1757056507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u/YelIEUUNe6qXoY7aOUePv/qteUXwtt7gdYajzcxoo=;
  b=biNVtvUZB5umajRb1B4bNjfcQ9lJ8sG9Jk3MWIchZzuOrEwL13JM87Aw
   e5DMsIH24UN+q+n2EU8HZvcPAfyhz84QWqmib7HB466sU/4GObe/nj3Sj
   bwira4GpwvcjjENoyrvat0qGosLiME5ccK4Lo9M3baa6OsIBaMJ0ojQ9/
   ZCTxPcJglzQzEe/1kSgUjmYWBkgepNgv0xX0DkY8eAE1ElhNshkPqCQPS
   qQ9nK+E/MikFt2xp9hJi6bf/ku/AGQl53J2KOsV+2DnI+VGvLzcIN+Aeh
   SngByhWW6buukms1pqsEh9PKmne5aeQ6tns7SQ01KJ6jlygeMzCosjBEI
   Q==;
X-CSE-ConnectionGUID: AXftJBMZTumy+PiA8NTycw==
X-CSE-MsgGUID: hd2aAOKmTzqtplLAIzrr0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23726549"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="23726549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:15:06 -0700
X-CSE-ConnectionGUID: PRSp9CsuR2qwNnZtBReOiQ==
X-CSE-MsgGUID: 36LQNsDMSdOHz3MCBrFRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="96263966"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Sep 2024 00:15:04 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm6hq-00093D-05;
	Thu, 05 Sep 2024 07:15:02 +0000
Date: Thu, 5 Sep 2024 15:14:03 +0800
From: kernel test robot <lkp@intel.com>
To: Wende Tan <twd2.me@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)'
 and 'vmlinux.a(target_core_transport.o at 1174232)'
Message-ID: <202409051523.ucZvHv7v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c763c43396883456ef57e5e78b64d3c259c4babc
commit: 021d23428bdbae032294e8f4a29cb53cb50ae71c RISC-V: build: Allow LTO to be selected
date:   8 months ago
config: riscv-randconfig-002-20240905 (https://download.01.org/0day-ci/archive/20240905/202409051523.ucZvHv7v-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051523.ucZvHv7v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051523.ucZvHv7v-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(smartpqi_init.o at 1171352)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(slub.o at 1089332)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(trace.o at 1082912)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(mballoc.o at 1101512)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(target_core_transport.o at 1174232)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(skbuff.o at 1212272)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(tcp.o at 1217312)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(memcontrol.o at 1089572)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(raid5.o at 1203572)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(mpt3sas_base.o at 1171772)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(e1000_main.o at 1180292)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(be_main.o at 1172612)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(segment.o at 1119272)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(hpsa.o at 1171292)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(volumes.o at 1114712)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(forcedeth.o at 1184252)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(bnx2.o at 1179752)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(md.o at 1203752)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(super.o at 1113572)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(core.o at 1086812)'
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

