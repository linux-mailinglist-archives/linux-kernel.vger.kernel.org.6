Return-Path: <linux-kernel+bounces-299971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BAC95DD22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588521C21114
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531121547CA;
	Sat, 24 Aug 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdn3QvY5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA88BEC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491082; cv=none; b=fHUITWuS94yPM3ni3ye/feTZH28OIeJkgvppFbwmFKYF6hzxM2P2xXgFpy+S1OoCpQpZGaRscnX/7Ut2MW3Y1aJKEK7plLFe7fmET4ttLCUmj5Thm2y3U2S5uVXGUXPCQnoaVBvH7aHj7TfT60bcaqBcYD2sR+3QsiX9Ndn91+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491082; c=relaxed/simple;
	bh=PKPzkeZDuXfyPKNJkXHR2U9tmGs/Eu1jXijfXhI2Fu8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SQCkLNjRvmHI7nSyn+UzZM1rndzQYmIDD4pO8VeJJMG7Vs/GLDgW379rJcqRl/T1yrmFsBcd23jBra//XeTjLkjMnx4/D5z2ujmN2/isqJQsVqHF+N2Pq7mqroiAU6dg2DEE1RKuW4hvhe3hMG9NPWfZ7l12kuf82kHkb0oE7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdn3QvY5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724491081; x=1756027081;
  h=date:from:to:cc:subject:message-id;
  bh=PKPzkeZDuXfyPKNJkXHR2U9tmGs/Eu1jXijfXhI2Fu8=;
  b=Tdn3QvY5xh5L4J4Pxlf/by8U5ZyxZIZZLgwJkjPca4xkXuaDlvyrJU33
   I4Pj03KEd9SG7RZ269IohdOKvfz0iJjZvP5PYb7Lbz7yqYfwqO+FkY+II
   1bCyj3ANzkB/pqZjhyKUBgwjHv/XzKIIQq1WMBvj5HboVtwkChZicfKEB
   VQUoDh2YQBBVZFkezYSW08nEhdOU/t38ypDPOLAZKAoQf6EZcs+xDVLAP
   lTLX6cN1FrJFKV9qqAUCpX+5rbUQtdcWTSCeOEClTeQNt3UxIzif6CwrS
   zMNgRpe4XyvvCIg+2DGJ24OSSK/kY9jXQIkSFDZkvO8nsFMCpStTKsX+9
   w==;
X-CSE-ConnectionGUID: NvtKYmepRvqxwc+Vbj1q2g==
X-CSE-MsgGUID: JHmKe34IT4KUVPmZgd+J4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="34386609"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="34386609"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 02:18:00 -0700
X-CSE-ConnectionGUID: GdEFGCPGRXC2EJx1qQPH5g==
X-CSE-MsgGUID: LF1xSQkPRhaEZCDpWJcKwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66977065"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Aug 2024 02:17:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shmuC-000ENn-38;
	Sat, 24 Aug 2024 09:17:56 +0000
Date: Sat, 24 Aug 2024 17:17:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 d19d638b1e6cf746263ef60b7d0dee0204d8216a
Message-ID: <202408241716.Mg6EpG8l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git x86/misc
branch HEAD: d19d638b1e6cf746263ef60b7d0dee0204d8216a  x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()

elapsed time: 837m

configs tested: 45
configs skipped: 157

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240824   clang-18
i386         buildonly-randconfig-002-20240824   clang-18
i386         buildonly-randconfig-003-20240824   clang-18
i386         buildonly-randconfig-004-20240824   clang-18
i386         buildonly-randconfig-005-20240824   clang-18
i386         buildonly-randconfig-006-20240824   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240824   clang-18
i386                  randconfig-002-20240824   clang-18
i386                  randconfig-003-20240824   clang-18
i386                  randconfig-004-20240824   clang-18
i386                  randconfig-005-20240824   clang-18
i386                  randconfig-006-20240824   clang-18
i386                  randconfig-011-20240824   clang-18
i386                  randconfig-012-20240824   clang-18
i386                  randconfig-013-20240824   clang-18
i386                  randconfig-014-20240824   clang-18
i386                  randconfig-015-20240824   clang-18
i386                  randconfig-016-20240824   clang-18
openrisc                            defconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

