Return-Path: <linux-kernel+bounces-264198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6C93E019
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048981C210D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D156185E5A;
	Sat, 27 Jul 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzBUAbHI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC5185607
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096877; cv=none; b=iGG1Fg1Uja6FYXxrYaX2Dgpe1ZLoGUpxj/bDbyovMdlmYHk6vSRrmXPpqepHrRGZ8ZtIff15PN5bBNyNsAVCuwIyZcAsN1kR5FDcfNPyWeMLrqOh45NzjDNkWx2UxftnmWmWvCHJ9aQByrJsUQKkggFW3dczWDQNO6KtwQvzbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096877; c=relaxed/simple;
	bh=4QXn+6awezAwV1/Id7kEpKf1/XjZArKQs57tFB4Hd5Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sTO0qVjFX02bPBEavozjs73q9bhez2GQvUVhxey0nIb3WlpMwZY+tm+cQmYVCiEUm+zKyIG4beSzwMnS1alS6yD/AExKsfVEtMC/L1ysXE4KDSAbwxHHeeK3r/d6T+igZRASqxrfJNahrskRgQoAzldoym15XBsLLRKANjrbWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzBUAbHI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722096875; x=1753632875;
  h=date:from:to:cc:subject:message-id;
  bh=4QXn+6awezAwV1/Id7kEpKf1/XjZArKQs57tFB4Hd5Y=;
  b=PzBUAbHIPphgHpa+YfmumwtyYmzt7Hw0lDfgpyhkah+9LOGsGh2JhWdR
   +jCNCm8w9j6PwXjiArNOsy5wFI5DJddligjcq58Dkp1ocjNUpC15WQoqN
   e7FGEfezK2dIUrmQSTJRn6yaWtN4yKsOrbHuUvhrzexni19tJFkFZ89eT
   qFtiUvgenQBjoIzrvymmOWtZ1/OU/tSVcYXwmrV9504BhAYWl8ysdslqq
   LEM7yNwa/AfsMYV1LTiCkNFiHTEN29OpwN8IrCI0iy/p2wRCkIHIOjgl1
   99oRBArbmhO5dNq+sF+uvAfeda1mmLlO07QWP5yKznF/VE63mcR/hvXdJ
   A==;
X-CSE-ConnectionGUID: qrKlHzReSzyZnC4fQIs+ZA==
X-CSE-MsgGUID: 9auwadElTZKwNdh3XmkfyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="42406840"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="42406840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 09:14:32 -0700
X-CSE-ConnectionGUID: Qe+Z9l7dTt+lH6kTL3d/fg==
X-CSE-MsgGUID: g3zv8qtkQvyNoOkth2DthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="53457151"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Jul 2024 09:14:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXk3w-000q3Y-0u;
	Sat, 27 Jul 2024 16:14:28 +0000
Date: Sun, 28 Jul 2024 00:14:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc] BUILD
 REGRESSION ba4d0a22cd60f51cf49570a61486bef14df575c2
Message-ID: <202407280012.JvSU6tni-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
branch HEAD: ba4d0a22cd60f51cf49570a61486bef14df575c2  ethtool: Avoid -Wflex-array-member-not-at-end warning

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   |-- drivers-crypto-caam-caamalg_qi2.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-crypto-rockchip-rk3288_crypto.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- arm-allyesconfig
|   |-- drivers-crypto-caam-caamalg_qi2.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-crypto-rockchip-rk3288_crypto.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- arm64-defconfig
|   |-- drivers-crypto-caam-caamalg_qi2.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-power-supply-cros_charge-control.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- drivers-xen-pci.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- arm64-randconfig-002-20240727
|   `-- drivers-crypto-rockchip-rk3288_crypto.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- i386-allmodconfig
|   |-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   |-- usr-include-linux-ethtool.h:error:unknown-type-name-offsetof
|   |-- usr-include-linux-usb-video.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   `-- usr-include-linux-usb-video.h:error:unknown-type-name-offsetof
|-- i386-allyesconfig
|   |-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   |-- usr-include-linux-ethtool.h:error:unknown-type-name-offsetof
|   |-- usr-include-linux-usb-video.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   `-- usr-include-linux-usb-video.h:error:unknown-type-name-offsetof
|-- i386-buildonly-randconfig-005-20240727
|   |-- usr-include-linux-ethtool.h:error:expected-)
|   |-- usr-include-linux-ethtool.h:warning:type-specifier-missing-defaults-to-int
|   `-- usr-include-linux-usb-video.h:warning:type-specifier-missing-defaults-to-int
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-nouveau-nouveau_svm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-power-supply-cros_charge-control.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- lib-test_hmm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- m68k-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- m68k-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- microblaze-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- microblaze-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- mips-allmodconfig
|   `-- arch-mips-include-asm-kvm_host.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- mips-allnoconfig
|   `-- arch-mips-include-asm-kvm_host.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- mips-allyesconfig
|   `-- arch-mips-include-asm-kvm_host.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- mips-ath79_defconfig
|   `-- arch-mips-include-asm-kvm_host.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- openrisc-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- parisc-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- parisc-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- parisc-randconfig-002-20240727
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc-allmodconfig
|   |-- arch-powerpc-include-asm-hvcall.h:error:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- arch-powerpc-perf-hv-common.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- arch-powerpc-platforms-powermac-nvram.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-crypto-caam-caamalg_qi2.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-gpu-drm-nouveau-nouveau_svm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- lib-test_hmm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- net-netfilter-x_tables.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-002-20240727
|   |-- arch-powerpc-include-asm-hvcall.h:error:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- arch-powerpc-platforms-powermac-nvram.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- arch-powerpc-sysdev-xics-ics-native.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-003-20240727
|   `-- arch-powerpc-platforms-powermac-nvram.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- s390-allyesconfig
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-s390-scsi-zfcp_fc.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- net-netfilter-x_tables.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sh-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sh-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sh-randconfig-001-20240727
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- net-netfilter-x_tables.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sparc-sparc64_defconfig
|   `-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sparc64-randconfig-001-20240727
|   `-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
`-- x86_64-allyesconfig
    |-- usr-include-linux-ethtool.h:error:expected-)
    |-- usr-include-linux-ethtool.h:warning:type-specifier-missing-defaults-to-int
    `-- usr-include-linux-usb-video.h:warning:type-specifier-missing-defaults-to-int

elapsed time: 1453m

configs tested: 133
configs skipped: 5

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240727   gcc-13.2.0
arc                   randconfig-002-20240727   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                          pxa910_defconfig   gcc-14.1.0
arm                   randconfig-001-20240727   gcc-14.1.0
arm                   randconfig-002-20240727   gcc-14.1.0
arm                   randconfig-003-20240727   clang-17
arm                   randconfig-004-20240727   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240727   clang-20
arm64                 randconfig-002-20240727   gcc-14.1.0
arm64                 randconfig-003-20240727   gcc-14.1.0
arm64                 randconfig-004-20240727   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240727   gcc-14.1.0
csky                  randconfig-002-20240727   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240727   clang-20
hexagon               randconfig-002-20240727   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-006-20240727   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240727   gcc-14.1.0
loongarch             randconfig-002-20240727   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                     loongson1b_defconfig   clang-15
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240727   gcc-14.1.0
nios2                 randconfig-002-20240727   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                randconfig-001-20240727   gcc-14.1.0
parisc                randconfig-002-20240727   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                      bamboo_defconfig   clang-20
powerpc                    mvme5100_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   clang-20
powerpc               randconfig-003-20240727   clang-20
powerpc                     tqm8541_defconfig   clang-15
powerpc64             randconfig-001-20240727   clang-20
powerpc64             randconfig-002-20240727   gcc-14.1.0
powerpc64             randconfig-003-20240727   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                 randconfig-001-20240727   gcc-14.1.0
riscv                 randconfig-002-20240727   gcc-14.1.0
s390                             alldefconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240727   gcc-14.1.0
s390                  randconfig-002-20240727   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240727   gcc-14.1.0
sh                    randconfig-002-20240727   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64               randconfig-001-20240727   gcc-14.1.0
sparc64               randconfig-002-20240727   gcc-14.1.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240727   gcc-13
um                    randconfig-002-20240727   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0
xtensa                generic_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240727   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

