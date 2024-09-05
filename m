Return-Path: <linux-kernel+bounces-316371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C72396CE8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A70288BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE23188CD5;
	Thu,  5 Sep 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4XYV4y0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516479F5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514920; cv=none; b=W75MjMsDP32dhI1QxW5bxFVIYGPmRgMmIttPfN1qJDuDsiFkD9yvg1/QSi/Wudspw9cCyifnXChrjvZAE+5pg1tKoafZpnFIeyiY3vjizX2fs5E7mz/sEXDMFgE+gZuYdwyPX6KSYZcaGvxIDVPzuoDc8fMx8Y9vA3z/PF4EXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514920; c=relaxed/simple;
	bh=1bcPxobkNwMKDftQcBwUkHKfb/H/2K0+hr8VNa5lgwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sP1uLPBncEeGvYmF5P6zozH8BxQeK2CwgskVm0pPwiBeKAHAmVYUX2Jl5k6IZsmFGzunDzhQepKhbfxaqsxW/aEft0RpS5G00an4F7ixzcDUT19puC4pk01mB9NADCYBcz8p/sDVhQYXN675R2BdfQjwI4+nyotAyCXJ1EUNJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4XYV4y0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725514919; x=1757050919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1bcPxobkNwMKDftQcBwUkHKfb/H/2K0+hr8VNa5lgwU=;
  b=c4XYV4y0wVeKWe66QCmrDcga61ogtTZ3nyFs6IiFfJeRoc9fJpwj7iuw
   BZEtlEWhmxmFRRiTDZg6EEEH0M0ozPDA3Ll6zSaPVk3peg5YFVdnSs8eP
   Yvxa2BLBqAyAe08zTqYYs53voAUweoYm1X8ydYrC4mm98eD3AvZw7ArIz
   Na3S4hI9zhVTvs8nOiAdeNLzYNsKsckOmYYw8RoZWb89s+rT+rzULk7sN
   9+ehMbS0wvoH87jSYqjOtM0RTpvD8/GKALzSweA9eB1fR13jAzIxUxOod
   Jcyi9aOwAxo/gC3Abmk3qD+R70dzmUoVerCZxYrrFoy8KIydzfJW47CIB
   A==;
X-CSE-ConnectionGUID: 42YQz9l5RhecklMl8HsOgA==
X-CSE-MsgGUID: tg3bjMbNR96hXaC3K3+zNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34873056"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34873056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 22:41:58 -0700
X-CSE-ConnectionGUID: gK/lmMJHR2S8MzhqR+d5yQ==
X-CSE-MsgGUID: 3AeN9hrARmS4GSFrkoc4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65823109"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Sep 2024 22:41:56 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm5Fh-0008yh-2c;
	Thu, 05 Sep 2024 05:41:53 +0000
Date: Thu, 5 Sep 2024 13:41:43 +0800
From: kernel test robot <lkp@intel.com>
To: Wende Tan <twd2.me@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)'
 and 'vmlinux.a(smartpqi_init.o at 1171352)'
Message-ID: <202409051341.lmvIzCrZ-lkp@intel.com>
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
config: riscv-randconfig-002-20240905 (https://download.01.org/0day-ci/archive/20240905/202409051341.lmvIzCrZ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051341.lmvIzCrZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051341.lmvIzCrZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(smartpqi_init.o at 1171352)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(memcontrol.o at 1089572)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(skbuff.o at 1212272)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(hpsa.o at 1171292)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(bnx2.o at 1179752)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(segment.o at 1119272)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(super.o at 1113572)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(trace.o at 1082912)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(mballoc.o at 1101512)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(filter.o at 1213352)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(slub.o at 1089332)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(volumes.o at 1114712)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(tcp.o at 1217312)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(raid5.o at 1203572)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(inode.o at 1114172)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(ixgbe_main.o at 1181852)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(core.o at 1086812)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(igc_main.o at 1181132)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(md.o at 1203752)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 1073432)' and 'vmlinux.a(target_core_transport.o at 1174232)'
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

