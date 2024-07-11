Return-Path: <linux-kernel+bounces-249913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EFD92F186
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19130283C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA31A01A9;
	Thu, 11 Jul 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy2MJ43d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181A1A01A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735194; cv=none; b=L97n0PIgFfqs/GM+QvtrT2A9WIPfzBdMDHOYrSq52G+6MiGT2XMWJcsdfbyIdqLsJ+1jWg14PbrTSFpWliXSslKuxaZYB+MBjYwXClVJRpv21vmxXNjLatpPF5hkXdpXXMAdd5BoNo2/BNBLYCOVAoREBedUzjOxaTol55kzlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735194; c=relaxed/simple;
	bh=QGeN6a5lszv25gLKLcKROrWNAHluSv3gWuzDAi7U1yg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uMM/VAKa9EHZOf1wBFgZm/HQkeLwfQQfgOZqfCwc6gg1/fRb9bAABmS2yjkkDflNidPMl27hknMvfBcjh7Qg8PoX7NJ5/isDum3sbFzK2JM8WBdIDcU9R+A4xaBUVr+VMCfqxYJ8qusTTQTl9sKYg8Hw0+oRA8hMiHzRyXRSlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy2MJ43d; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720735193; x=1752271193;
  h=date:from:to:cc:subject:message-id;
  bh=QGeN6a5lszv25gLKLcKROrWNAHluSv3gWuzDAi7U1yg=;
  b=Iy2MJ43dKjrrsZqYDOla6cI/TUiMsGvcJYZrx7vXQRzcsCveiZZ596d5
   crh/Ctj9gadqlWpeKiGBTGBFmYFi6/2nTm0Bk1EfTEuBghAoCgl+ipzvf
   PoIGehdz4f+3EKImEXNPgukyje0Xb0S+nK6cS9k8x+PHzf8SZTeDHM5Sr
   Ff52ubEI4UYSXgXuU+9sTfgbfxBYl+G9VR/bb+zyWaZChFGBCKz91ZmPm
   5oSadlnAM/cYVUpRQPbsb6/qhGC+4rg/5dclVLjMKI/WvEUZ7Mlor6g5/
   IYxmuUzLo5nTHmCJ6MhKzI17JY7Pz0UivRDt5DMnXEi40qvtFnMRB/c/D
   Q==;
X-CSE-ConnectionGUID: DoWsqtYmQAKmjZ6tveafVg==
X-CSE-MsgGUID: rUeGl6/LRS+0/t4EUd7LOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18293261"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18293261"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 14:59:53 -0700
X-CSE-ConnectionGUID: Gi1EziO+Qn22aPpZm7/17A==
X-CSE-MsgGUID: 0WXrZqPWRF2VWSFKbTCrWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="79825958"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jul 2024 14:59:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sS1pM-000ZxR-1a;
	Thu, 11 Jul 2024 21:59:48 +0000
Date: Fri, 12 Jul 2024 05:59:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:for-neeraj.2024.07.10a] BUILD REGRESSION
 6dfea2d3ac9e0874587c0c1d05fd829f520d5458
Message-ID: <202407120543.IpY0WNtm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-neeraj.2024.07.10a
branch HEAD: 6dfea2d3ac9e0874587c0c1d05fd829f520d5458  rcu: Let dump_cpu_task() be used without preemption disabled

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407110950.SoSbeyIm-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407111030.UYYhi3JZ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/rcu/tree_exp.h:556:48: error: call to undeclared function 'csd_lock_is_stuck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/rcu/tree_exp.h:556:48: error: implicit declaration of function 'csd_lock_is_stuck' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tree_stall.h:798:49: error: call to undeclared function 'csd_lock_is_stuck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
kernel/rcu/tree_stall.h:798:49: error: implicit declaration of function 'csd_lock_is_stuck' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tree_stall.h:798:63: error: implicit declaration of function 'csd_lock_is_stuck' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- arm64-allnoconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- arm64-randconfig-001-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- arm64-randconfig-003-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- arm64-randconfig-004-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- hexagon-allmodconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-allyesconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-001-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-allmodconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-allyesconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-001-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-003-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-004-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-005-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-buildonly-randconfig-006-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-defconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-001-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-003-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-004-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-005-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-006-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-011-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-012-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-013-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- i386-randconfig-015-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-016-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- loongarch-allmodconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- loongarch-randconfig-001-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- loongarch-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- openrisc-allyesconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- parisc-allmodconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- parisc-allyesconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- parisc-defconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- parisc-randconfig-001-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- parisc-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- powerpc-allmodconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- powerpc-allyesconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc-randconfig-002-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc64-randconfig-001-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- powerpc64-randconfig-002-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc64-randconfig-003-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- riscv-allmodconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allyesconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-defconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-randconfig-001-20240711
|   |-- kernel-rcu-tree_exp.h:error:implicit-declaration-of-function-csd_lock_is_stuck-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- riscv-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- s390-allmodconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allnoconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-defconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-randconfig-001-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-randconfig-002-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- sh-defconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- sparc-allmodconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- sparc64-defconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-allyesconfig
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-002-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-003-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-004-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-defconfig
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-randconfig-014-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-015-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-016-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-randconfig-072-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-randconfig-074-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-randconfig-076-20240711
|   `-- kernel-rcu-tree_stall.h:error:implicit-declaration-of-function-csd_lock_is_stuck
|-- x86_64-randconfig-161-20240711
|   |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-rhel-8.3-rust
    |-- kernel-rcu-tree_exp.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- kernel-rcu-tree_stall.h:error:call-to-undeclared-function-csd_lock_is_stuck-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1460m

configs tested: 143
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240711   clang-19
arm                   randconfig-002-20240711   gcc-13.3.0
arm                   randconfig-003-20240711   clang-19
arm                   randconfig-004-20240711   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.3.0
arm64                 randconfig-001-20240711   clang-19
arm64                 randconfig-002-20240711   gcc-13.3.0
arm64                 randconfig-003-20240711   gcc-13.3.0
arm64                 randconfig-004-20240711   gcc-13.3.0
csky                              allnoconfig   gcc-13.3.0
csky                  randconfig-001-20240711   gcc-13.3.0
csky                  randconfig-002-20240711   gcc-13.3.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240711   clang-19
hexagon               randconfig-002-20240711   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.3.0
loongarch             randconfig-001-20240711   gcc-14.1.0
loongarch             randconfig-002-20240711   gcc-14.1.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.3.0
m68k                             allyesconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.3.0
nios2                 randconfig-001-20240711   gcc-14.1.0
nios2                 randconfig-002-20240711   gcc-14.1.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240711   gcc-14.1.0
parisc                randconfig-002-20240711   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240711   gcc-14.1.0
powerpc               randconfig-002-20240711   clang-19
powerpc               randconfig-003-20240711   clang-19
powerpc64             randconfig-001-20240711   gcc-14.1.0
powerpc64             randconfig-002-20240711   clang-16
powerpc64             randconfig-003-20240711   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240711   clang-14
riscv                 randconfig-002-20240711   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240711   clang-19
s390                  randconfig-002-20240711   gcc-14.1.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.3.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240711   gcc-14.1.0
sh                    randconfig-002-20240711   gcc-14.1.0
sparc                            allmodconfig   gcc-13.3.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240711   gcc-14.1.0
sparc64               randconfig-002-20240711   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240711   gcc-8
um                    randconfig-002-20240711   gcc-8
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   gcc-13
x86_64       buildonly-randconfig-006-20240711   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240711   gcc-13
x86_64                randconfig-002-20240711   gcc-13
x86_64                randconfig-003-20240711   gcc-11
x86_64                randconfig-004-20240711   gcc-9
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   gcc-13
x86_64                randconfig-011-20240711   gcc-13
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   gcc-13
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   gcc-10
x86_64                randconfig-071-20240711   gcc-13
x86_64                randconfig-072-20240711   gcc-13
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   gcc-13
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.3.0
xtensa                randconfig-001-20240711   gcc-14.1.0
xtensa                randconfig-002-20240711   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

