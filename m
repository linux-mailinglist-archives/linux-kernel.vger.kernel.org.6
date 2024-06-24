Return-Path: <linux-kernel+bounces-228094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9C915AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0841C20E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8461A2FB1;
	Mon, 24 Jun 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dayYMUp+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F41A2C01
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273336; cv=none; b=DGG57NqGxqOV2rlsNRmadn3WbpDNICu9J8DV6HzvWxM8epWyfTsXBVmOt8PNb4TlxPNf4AR6m3pKXtYSZVqj8iRKqNvw7YzvKvQfxeulNTAMXc8IHtvac6xNuV2A7ckxruPD5HdJt4bj3xk0SkZIxxQzoCwu7DguTx1Ed/Djg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273336; c=relaxed/simple;
	bh=ACvZf18Hpp9edcVXTL0zhBkjKiullQ2QOtwa4yuKRMk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fnUSq3kXJ4J3bl79G5o/4UKZcpsQM//XXke48UVLjxpZPdVNsAEzac/jFq31awZZAfVgHn0VBbwtDdbSaNRZwcSar91OM57vNduHTuN2BRg8uRqPMUFuaQbeTNBj9EcOAjm6n43HPRgGdFAqybqrK0iAP7z0LEjj4otA6sZiSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dayYMUp+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719273335; x=1750809335;
  h=date:from:to:cc:subject:message-id;
  bh=ACvZf18Hpp9edcVXTL0zhBkjKiullQ2QOtwa4yuKRMk=;
  b=dayYMUp+pQ+qXW/SCw9sUZ2VdZ9TeewEkZAdFg8HWOvY2g0mR1oIl6QY
   8W13snA3BHyuYqyfLWcnfvAxRumwhZb/xBNmBdg+stF/SlXOtjfrZqurw
   dwrR64Ii1g6KkWFiyUR5dzZbyfebOUI/2uatNw+c0RX/D7NSRwo/OaCWk
   2NVbNbyp4jIcaGVkRxu8TsvFcSh54z4lFRS36XkQghDWNmIuRqK20+0JC
   rFErPQH9YLtvNY127pOM12aM+x7ZfERvfD+ccsNp9l6vWHblTphP+EuwD
   ytf6mA2M9Kk0wc5hojyEO/kNtZITOAmrnaMoC16Lvis/cIRiDLR5jkKQT
   A==;
X-CSE-ConnectionGUID: LLtk1lBzTgWtWVuVtTop+w==
X-CSE-MsgGUID: EtKWGN88QH6OjEB7uJEFrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16412675"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16412675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:55:34 -0700
X-CSE-ConnectionGUID: WULACP7NQDSqWoTHLcQlXg==
X-CSE-MsgGUID: v33N/40tQx+F+LdVkKDBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47996139"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2024 16:55:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLtX1-000Dpo-0s;
	Mon, 24 Jun 2024 23:55:31 +0000
Date: Tue, 25 Jun 2024 07:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD REGRESSION
 f2605e1715dd28e8943b557453fed3a40421d3b5
Message-ID: <202406250742.F26xWOHt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: f2605e1715dd28e8943b557453fed3a40421d3b5  arm64: Kconfig: Allow build irq-stm32mp-exti driver as module

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406250214.WZEjWnnU-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202406250323.bMydP9v3-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/irqchip/irq-dw-apb-ictl.c:206:18: error: use of undeclared identifier 'dw_apb_ictl_handle_irq'
drivers/irqchip/irq-dw-apb-ictl.c:206:32: error: 'dw_apb_ictl_handle_irq' undeclared (first use in this function); did you mean 'dw_apb_ictl_init'?
drivers/irqchip/irq-dw-apb-ictl.c:33:13: error: variable has incomplete type 'void'
drivers/irqchip/irq-dw-apb-ictl.c:33:24: error: expected ';' after top level declarator
drivers/irqchip/irq-dw-apb-ictl.c:33:25: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dw_apb_ictl_handle_irq'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   |-- drivers-irqchip-irq-dw-apb-ictl.c:error:dw_apb_ictl_handle_irq-undeclared-(first-use-in-this-function)
|   `-- drivers-irqchip-irq-dw-apb-ictl.c:error:expected-asm-or-__attribute__-before-dw_apb_ictl_handle_irq
|-- loongarch-allnoconfig
|   |-- drivers-irqchip-irq-loongarch-avec.c:error:SMP_CLEAR_VECT-undeclared-(first-use-in-this-function)
|   `-- drivers-irqchip-irq-loongarch-avec.c:error:implicit-declaration-of-function-loongson_send_ipi_single
|-- loongarch-randconfig-001-20240624
|   |-- drivers-irqchip-irq-loongarch-avec.c:error:SMP_CLEAR_VECT-undeclared-(first-use-in-this-function)
|   `-- drivers-irqchip-irq-loongarch-avec.c:error:implicit-declaration-of-function-loongson_send_ipi_single
`-- loongarch-randconfig-002-20240624
    `-- drivers-irqchip-irq-loongarch-avec.c:error:implicit-declaration-of-function-loongson_send_ipi_single
clang_recent_errors
`-- x86_64-allyesconfig
    |-- drivers-irqchip-irq-dw-apb-ictl.c:error:expected-after-top-level-declarator
    |-- drivers-irqchip-irq-dw-apb-ictl.c:error:use-of-undeclared-identifier-dw_apb_ictl_handle_irq
    `-- drivers-irqchip-irq-dw-apb-ictl.c:error:variable-has-incomplete-type-void

elapsed time: 1500m

configs tested: 107
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240624   gcc-13.2.0
arc                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-001-20240624   clang-17
arm                   randconfig-002-20240624   gcc-13.2.0
arm                   randconfig-003-20240624   gcc-13.2.0
arm                   randconfig-004-20240624   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240624   clang-19
arm64                 randconfig-002-20240624   gcc-13.2.0
arm64                 randconfig-003-20240624   gcc-13.2.0
arm64                 randconfig-004-20240624   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240624   gcc-13.2.0
csky                  randconfig-002-20240624   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240624   clang-19
hexagon               randconfig-002-20240624   clang-19
i386         buildonly-randconfig-001-20240624   gcc-8
i386         buildonly-randconfig-002-20240624   gcc-13
i386         buildonly-randconfig-003-20240624   clang-18
i386         buildonly-randconfig-004-20240624   gcc-10
i386         buildonly-randconfig-005-20240624   clang-18
i386         buildonly-randconfig-006-20240624   clang-18
i386                  randconfig-001-20240624   clang-18
i386                  randconfig-002-20240624   clang-18
i386                  randconfig-003-20240624   gcc-13
i386                  randconfig-004-20240624   gcc-13
i386                  randconfig-005-20240624   gcc-13
i386                  randconfig-006-20240624   clang-18
i386                  randconfig-011-20240624   clang-18
i386                  randconfig-012-20240624   clang-18
i386                  randconfig-013-20240624   gcc-9
i386                  randconfig-014-20240624   clang-18
i386                  randconfig-015-20240624   clang-18
i386                  randconfig-016-20240624   gcc-9
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240624   gcc-13.2.0
loongarch             randconfig-002-20240624   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240624   gcc-13.2.0
nios2                 randconfig-002-20240624   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240624   gcc-13.2.0
parisc                randconfig-002-20240624   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240624   clang-19
powerpc               randconfig-002-20240624   gcc-13.2.0
powerpc               randconfig-003-20240624   clang-16
powerpc64             randconfig-001-20240624   clang-17
powerpc64             randconfig-002-20240624   clang-19
powerpc64             randconfig-003-20240624   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240624   clang-19
riscv                 randconfig-002-20240624   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240624   clang-15
s390                  randconfig-002-20240624   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240624   gcc-13.2.0
sh                    randconfig-002-20240624   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240624   gcc-13.2.0
sparc64               randconfig-002-20240624   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240624   clang-19
um                    randconfig-002-20240624   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240624   gcc-13
x86_64       buildonly-randconfig-002-20240624   gcc-13
x86_64       buildonly-randconfig-003-20240624   clang-18
x86_64       buildonly-randconfig-004-20240624   clang-18
x86_64       buildonly-randconfig-005-20240624   clang-18
x86_64       buildonly-randconfig-006-20240624   clang-18
x86_64                randconfig-001-20240624   clang-18
x86_64                randconfig-002-20240624   clang-18
x86_64                randconfig-003-20240624   clang-18
x86_64                randconfig-004-20240624   clang-18
x86_64                randconfig-005-20240624   gcc-11
x86_64                randconfig-006-20240624   gcc-13
x86_64                randconfig-011-20240624   clang-18
x86_64                randconfig-012-20240624   gcc-8
x86_64                randconfig-013-20240624   clang-18
x86_64                randconfig-014-20240624   gcc-8
x86_64                randconfig-015-20240624   gcc-13
x86_64                randconfig-016-20240624   clang-18
x86_64                randconfig-071-20240624   gcc-10
x86_64                randconfig-072-20240624   gcc-10
x86_64                randconfig-073-20240624   gcc-13
x86_64                randconfig-074-20240624   gcc-13
x86_64                randconfig-075-20240624   gcc-13
x86_64                randconfig-076-20240624   gcc-8
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240624   gcc-13.2.0
xtensa                randconfig-002-20240624   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

