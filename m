Return-Path: <linux-kernel+bounces-223436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C069112EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B881C213D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4B1B4C54;
	Thu, 20 Jun 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ac24A9vd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEB41C67
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914707; cv=none; b=VAxwpB1g9p2kZVzdFuznXzNHfGWMd+6bRSN3mVXlIZ4XeV8NwRcE4gtiDlMW6v26GFafA0j/LNX0LLTW0RSvdN5cVGaO1rQ3rcepFAblf4ed8IbvoR29nF6f1t/AjGspDO7znyrnAVus4VUBWNQIOPjY4T/8WsuVy6hbh+/0Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914707; c=relaxed/simple;
	bh=nvApPSFmCjxeUDDGUmOlYJkHn838hGVAoBW4Y65MfTM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XudkqAiyIZI6xar6B9uD9j6+B9OyYQSsz+bG25fJQsiBH8XhY2GZ5XBwEM6qsitFMRTiPrLLeeKZLklXZbEJ2kwsYtK/vVxmceniPv2GQuypFbVplionzCz+EtBCXamBjJ7+m6XS0aa5A9a97DtgQkBZbxdTUTxxEfrDT4kcCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ac24A9vd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718914704; x=1750450704;
  h=date:from:to:cc:subject:message-id;
  bh=nvApPSFmCjxeUDDGUmOlYJkHn838hGVAoBW4Y65MfTM=;
  b=ac24A9vdSKLfd2OSuwzMb1QCqrLpbZ4JPu8O16oFnMpVotbxpPqEmedh
   TdchWtpx0UK6YzZ5irqmKpHuz7S/Ayh9IHV1Qmjm5tnHA2Ae83Aav/L3g
   Bzfln35gxoJ569D49HQrMvU9MV/f13CZpJ/COJvThLr91wkVUVJNzvobM
   76kqmpF1pzqlqinPodXlQLeBzjgA87K6RPZwhnSp0oR+8SCQeRNJ9eaPI
   PyhpI5QipopP3mvldbIOMGewRVg25p2zQvPCgDIoChd5Wb6/MpfpV4eAF
   sQ0et/0gmIM6ynVv2bTFa4adOlDtoCEbogac7Fhe7h9M2SplKy5lktKMA
   Q==;
X-CSE-ConnectionGUID: 0crUlZMXR5ac1JL/EVTmCg==
X-CSE-MsgGUID: omf2VCvMTjC2A1SwXc/1Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19805502"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19805502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 13:18:24 -0700
X-CSE-ConnectionGUID: 4YONSDGXSZKms2Y4iQf7Hw==
X-CSE-MsgGUID: Di0He3tWTzaqtyu6o0S9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42174145"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jun 2024 13:18:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKOEe-0007u6-2f;
	Thu, 20 Jun 2024 20:18:20 +0000
Date: Fri, 21 Jun 2024 04:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.06.18a] BUILD REGRESSION
 f29bcafffef0ecc8a5d2cdc1bbef9a6889225263
Message-ID: <202406210444.QtaCgJ25-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.06.18a
branch HEAD: f29bcafffef0ecc8a5d2cdc1bbef9a6889225263  rcutorture: Limit callback flooding for Tiny SRCU in preemptible kernels

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406201116.d69O9imA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202406201149.s6KWE7XP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/time/clocksource.c:1167:36: error: use of undeclared identifier 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US'
kernel/time/clocksource.c:136:25: error: 'CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arc-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm-randconfig-003-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm-randconfig-004-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm64-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm64-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- arm64-randconfig-003-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- csky-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- csky-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- loongarch-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- loongarch-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- nios2-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- nios2-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- parisc-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- powerpc-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- powerpc-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- powerpc64-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- powerpc64-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- s390-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- s390-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sh-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sh-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sparc-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- sparc64-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- um-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
|-- xtensa-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
`-- xtensa-randconfig-002-20240620
    `-- kernel-time-clocksource.c:error:CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- arm-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
|-- arm64-randconfig-004-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
|-- hexagon-randconfig-001-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
|-- hexagon-randconfig-002-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
|-- powerpc-randconfig-003-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
|-- powerpc64-randconfig-003-20240620
|   `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
`-- um-randconfig-001-20240620
    `-- kernel-time-clocksource.c:error:use-of-undeclared-identifier-CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US

elapsed time: 1577m

configs tested: 80
configs skipped: 0

tested configs:
arc                   randconfig-001-20240620   gcc-13.2.0
arc                   randconfig-002-20240620   gcc-13.2.0
arm                   randconfig-001-20240620   gcc-13.2.0
arm                   randconfig-002-20240620   clang-19
arm                   randconfig-003-20240620   gcc-13.2.0
arm                   randconfig-004-20240620   gcc-13.2.0
arm64                 randconfig-001-20240620   gcc-13.2.0
arm64                 randconfig-002-20240620   gcc-13.2.0
arm64                 randconfig-003-20240620   gcc-13.2.0
arm64                 randconfig-004-20240620   clang-19
csky                  randconfig-001-20240620   gcc-13.2.0
csky                  randconfig-002-20240620   gcc-13.2.0
hexagon               randconfig-001-20240620   clang-19
hexagon               randconfig-002-20240620   clang-19
i386         buildonly-randconfig-001-20240620   gcc-13
i386         buildonly-randconfig-002-20240620   clang-18
i386         buildonly-randconfig-003-20240620   gcc-13
i386         buildonly-randconfig-004-20240620   gcc-10
i386         buildonly-randconfig-005-20240620   gcc-13
i386         buildonly-randconfig-006-20240620   clang-18
i386                  randconfig-001-20240620   clang-18
i386                  randconfig-002-20240620   clang-18
i386                  randconfig-003-20240620   gcc-13
i386                  randconfig-004-20240620   gcc-10
i386                  randconfig-005-20240620   clang-18
i386                  randconfig-006-20240620   gcc-10
i386                  randconfig-011-20240620   gcc-7
i386                  randconfig-012-20240620   clang-18
i386                  randconfig-013-20240620   clang-18
i386                  randconfig-014-20240620   gcc-7
i386                  randconfig-015-20240620   clang-18
i386                  randconfig-016-20240620   clang-18
loongarch             randconfig-001-20240620   gcc-13.2.0
loongarch             randconfig-002-20240620   gcc-13.2.0
nios2                 randconfig-001-20240620   gcc-13.2.0
nios2                 randconfig-002-20240620   gcc-13.2.0
parisc                randconfig-001-20240620   gcc-13.2.0
parisc                randconfig-002-20240620   gcc-13.2.0
powerpc               randconfig-001-20240620   gcc-13.2.0
powerpc               randconfig-002-20240620   gcc-13.2.0
powerpc               randconfig-003-20240620   clang-17
powerpc64             randconfig-001-20240620   gcc-13.2.0
powerpc64             randconfig-002-20240620   gcc-13.2.0
powerpc64             randconfig-003-20240620   clang-17
riscv                 randconfig-001-20240620   clang-19
riscv                 randconfig-002-20240620   clang-14
s390                  randconfig-001-20240620   gcc-13.2.0
s390                  randconfig-002-20240620   gcc-13.2.0
sh                    randconfig-001-20240620   gcc-13.2.0
sh                    randconfig-002-20240620   gcc-13.2.0
sparc64               randconfig-001-20240620   gcc-13.2.0
sparc64               randconfig-002-20240620   gcc-13.2.0
um                    randconfig-001-20240620   clang-19
um                    randconfig-002-20240620   gcc-13
x86_64       buildonly-randconfig-001-20240620   clang-18
x86_64       buildonly-randconfig-002-20240620   gcc-10
x86_64       buildonly-randconfig-003-20240620   clang-18
x86_64       buildonly-randconfig-004-20240620   gcc-13
x86_64       buildonly-randconfig-005-20240620   clang-18
x86_64       buildonly-randconfig-006-20240620   gcc-13
x86_64                randconfig-001-20240620   clang-18
x86_64                randconfig-002-20240620   gcc-13
x86_64                randconfig-003-20240620   clang-18
x86_64                randconfig-004-20240620   clang-18
x86_64                randconfig-005-20240620   gcc-11
x86_64                randconfig-006-20240620   clang-18
x86_64                randconfig-011-20240620   gcc-13
x86_64                randconfig-012-20240620   gcc-13
x86_64                randconfig-013-20240620   gcc-13
x86_64                randconfig-014-20240620   gcc-13
x86_64                randconfig-015-20240620   clang-18
x86_64                randconfig-016-20240620   clang-18
x86_64                randconfig-071-20240620   gcc-13
x86_64                randconfig-072-20240620   gcc-13
x86_64                randconfig-073-20240620   gcc-13
x86_64                randconfig-074-20240620   clang-18
x86_64                randconfig-075-20240620   clang-18
x86_64                randconfig-076-20240620   clang-18
xtensa                randconfig-001-20240620   gcc-13.2.0
xtensa                randconfig-002-20240620   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

