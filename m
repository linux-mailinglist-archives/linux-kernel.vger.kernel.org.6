Return-Path: <linux-kernel+bounces-234996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17E91CE19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1453D1F21EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330085624;
	Sat, 29 Jun 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/PiVevi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509D481B9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678514; cv=none; b=N7J1FDDbLUJBhvmNcR9ZnoMtD6b3LAjWKYPRxsGRIIvNQK16x3vlAL9uQyqnSoXMIuo84fGg1hXXbKQ6cVf6w1OgR+He1RZoKmO/8WkR5IoEZiWBV3AuOeGLZ86vkFSOYKaVYbrpnHCfiTA/M09rp/pkGhzeRTSuOgmS0H5HDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678514; c=relaxed/simple;
	bh=sjz/CfyyTi31ZBtszauzfrV5eOT66e9WiJI4FJ/AC00=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BuI91YzigvPo0s46AlBE1fh9I7eaLIChZpGBCkLdMMHsOLES8+OjXmocPaCG8hboEfS8o75ocigiiN+em13PFzcjy/pGK8cMv4PwHDWs83jNgOjfjOpPnV2VAUzZNhltjZ+Fjq+EJc92wjwZ54ySUgfRrLM2o1isVj0mMnNLeWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/PiVevi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719678513; x=1751214513;
  h=date:from:to:cc:subject:message-id;
  bh=sjz/CfyyTi31ZBtszauzfrV5eOT66e9WiJI4FJ/AC00=;
  b=I/PiVevipyvFYR6ilstBIPqq8dYX+7e+mGeM9LL1QjV7NTMFRKSMmuuR
   pAFYVZM329+0wBflIy0r0VskDv1vazRmYF8CInyVG+xIuHdIz8MVzRJV3
   mdHOP1iab59quc2Z/Jrz0qoWu6M3+iO+hOOLkiyiJ0meRtyNIeBqmmZiP
   QoVAmpA5aKzUwg2a9+hpm4ECaFpJIJoOKAavDv8tdIXhSxqYGn+PDIjgm
   0iqJazzXvaglhV2Dml8g1vfdOIB8YvUpI4YVGB8ldUEfqgSnY1wnMkqIT
   zjv1DeBS+b86X6d1HPClMmK6odjDbi7N2hwB1P/776MjZVR+NQFx6B3Al
   A==;
X-CSE-ConnectionGUID: 1n3Qug39TOabYlgIQa3aAg==
X-CSE-MsgGUID: 2WR5JE/GQoCWSU+zAf1qBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20665336"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="20665336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 09:28:32 -0700
X-CSE-ConnectionGUID: hgQe2V26QNSwOhcKD5D10g==
X-CSE-MsgGUID: yE04JJ0xR+mBp1tOHtrwUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45149253"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jun 2024 09:28:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNaw9-000Jjo-02;
	Sat, 29 Jun 2024 16:28:29 +0000
Date: Sun, 30 Jun 2024 00:27:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 be5e5f3a1120bada0cff1bc84c2a1805da308f6e
Message-ID: <202406300054.u9zz59ep-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: be5e5f3a1120bada0cff1bc84c2a1805da308f6e  Revert "irqchip/dw-apb-ictl: Support building as module"

elapsed time: 5539m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                                 defconfig   clang-14
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-002-20240628   clang-19
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240628   gcc-13
um                    randconfig-002-20240628   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240627   clang-18
x86_64       buildonly-randconfig-002-20240627   clang-18
x86_64       buildonly-randconfig-003-20240627   clang-18
x86_64       buildonly-randconfig-004-20240627   gcc-13
x86_64       buildonly-randconfig-005-20240627   gcc-13
x86_64       buildonly-randconfig-006-20240627   clang-18
x86_64                randconfig-001-20240627   clang-18
x86_64                randconfig-002-20240627   gcc-13
x86_64                randconfig-003-20240627   clang-18
x86_64                randconfig-004-20240627   clang-18
x86_64                randconfig-005-20240627   gcc-13
x86_64                randconfig-006-20240627   clang-18
x86_64                randconfig-011-20240627   clang-18
x86_64                randconfig-012-20240627   clang-18
x86_64                randconfig-013-20240627   gcc-13
x86_64                randconfig-014-20240627   clang-18
x86_64                randconfig-015-20240627   gcc-13
x86_64                randconfig-016-20240627   clang-18
x86_64                randconfig-071-20240627   clang-18
x86_64                randconfig-072-20240627   gcc-13
x86_64                randconfig-073-20240627   clang-18
x86_64                randconfig-074-20240627   gcc-13
x86_64                randconfig-075-20240627   gcc-13
x86_64                randconfig-076-20240627   clang-18
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

