Return-Path: <linux-kernel+bounces-251710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE593088A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63BD281E66
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766AF505;
	Sun, 14 Jul 2024 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diiILgqR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1747EEB3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720933082; cv=none; b=gm1ZxIU4Wht7keGtSx04mrz1TTvH9uXjxfz2Ca/agLDuPWXjUh+I7zqrdZ+KL6u+4MQ7jziXYJKGax873UT+YFhvsmnJsNm+WIGOMqmdUEGNJNtIUqIb4Pj5rMT3aIl7d3tPG0jRonkOle17yIVtrzgpEdjcoAd8RnE2/Hj+d5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720933082; c=relaxed/simple;
	bh=hpF3mZOJtUQ5Q0vPs2o0WtvhMekveTSBOWtp6A0Dcqo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PwNpPoNmhwF61p17xAt7fYcBjLHQtOgLt8HdNR2YtV4w2dcTo/XweIs+wJanWPL2XEiX6bZlbBbFurA03+ZJ5u28MMExAmDcVbA2n35E3fIbb4BuEbSnzVUWggXLjRur19j2E+h3IKbjob66EViRgyuPEqFPSq9VF7F5n1MQ3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diiILgqR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720933081; x=1752469081;
  h=date:from:to:cc:subject:message-id;
  bh=hpF3mZOJtUQ5Q0vPs2o0WtvhMekveTSBOWtp6A0Dcqo=;
  b=diiILgqRkZIHNA533s54+DcQp9xxM8mAT9zw8J2NZdMe3Wu7419KOhJD
   ldVNU3rFRVpvVUex7Z/w0XvtfM23W65WeLkvRA/sLI+oUR02tJKPQNSQV
   gZpeCav2FtTnFCddJtydjdn9VJ94fkfRi7mwq9OAPKD9trUQS3s1da4Je
   LhJjQdsD+ihwCwhCcUbH04ICMMv0Ie+tfftis6xJWUf9Dn4PqsDu1qac0
   SunnBsVatkCy2bBhoyV+GvXVgjnA7lqmeoFb3oUBMnUkssWIDyUtJHgif
   VI2S0DUQAklWLEGBUbfoguAyGqjqD+GT/gV4A6Wl58VoARMK7KBHLt2nM
   w==;
X-CSE-ConnectionGUID: vuOYM6A7TBS3oYkLiWpzMw==
X-CSE-MsgGUID: +co7kuqQSvCnh9scQkX64A==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="35764300"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="35764300"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 21:58:00 -0700
X-CSE-ConnectionGUID: msHlBRLsRY26mNs3ZowAKg==
X-CSE-MsgGUID: mOUkO79EQJKIK8tPcPIKEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="54476672"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jul 2024 21:57:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSrJ6-000d4Q-32;
	Sun, 14 Jul 2024 04:57:56 +0000
Date: Sun, 14 Jul 2024 12:57:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc] BUILD
 REGRESSION e3597892cb471e5732700d17c2cca098f3148759
Message-ID: <202407141223.zeFWcpl3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
branch HEAD: e3597892cb471e5732700d17c2cca098f3148759  Bluetooth: HCI: Avoid -Wflex-array-member-not-at-end warnings

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
|-- i386-buildonly-randconfig-003-20240713
|   |-- usr-include-linux-ethtool.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   |-- usr-include-linux-ethtool.h:error:unknown-type-name-offsetof
|   |-- usr-include-linux-usb-video.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   `-- usr-include-linux-usb-video.h:error:unknown-type-name-offsetof
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-nouveau-nouveau_svm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-power-supply-cros_charge-control.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- lib-test_hmm.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- loongarch-randconfig-002-20240714
|   `-- drivers-power-supply-cros_charge-control.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
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
|   |-- arch-mips-include-asm-kvm_host.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- openrisc-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- parisc-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- parisc-allyesconfig
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
|-- powerpc64-randconfig-001-20240714
|   `-- arch-powerpc-platforms-powermac-nvram.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-002-20240714
|   |-- arch-powerpc-include-asm-hvcall.h:error:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-003-20240714
|   `-- arch-powerpc-perf-hv-common.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- s390-allyesconfig
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-s390-scsi-zfcp_fc.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- net-netfilter-x_tables.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sh-allmodconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sh-allyesconfig
|   `-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-leds-leds-cros_ec.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   |-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|   `-- net-netfilter-x_tables.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
`-- sparc64-defconfig
    `-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure

elapsed time: 1451m

configs tested: 141
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                         at91_dt_defconfig   clang-19
arm                            dove_defconfig   gcc-14.1.0
arm                            hisi_defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-19
arm                         orion5x_defconfig   clang-19
arm                   randconfig-001-20240714   clang-19
arm                   randconfig-002-20240714   clang-15
arm                   randconfig-003-20240714   clang-17
arm                   randconfig-004-20240714   clang-15
arm                        shmobile_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240714   clang-15
arm64                 randconfig-002-20240714   clang-19
arm64                 randconfig-003-20240714   clang-19
arm64                 randconfig-004-20240714   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240714   gcc-14.1.0
csky                  randconfig-002-20240714   gcc-14.1.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240714   clang-19
hexagon               randconfig-002-20240714   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-016-20240713   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240714   gcc-14.1.0
loongarch             randconfig-002-20240714   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       bvme6000_defconfig   gcc-14.1.0
m68k                          hp300_defconfig   gcc-14.1.0
m68k                        m5307c3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240714   gcc-14.1.0
nios2                 randconfig-002-20240714   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240714   gcc-14.1.0
parisc                randconfig-002-20240714   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-003-20240714   gcc-14.1.0
powerpc                     skiroot_defconfig   clang-19
powerpc                  storcenter_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240714   gcc-14.1.0
powerpc64             randconfig-002-20240714   gcc-14.1.0
powerpc64             randconfig-003-20240714   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240714   clang-18
x86_64       buildonly-randconfig-002-20240714   gcc-13
x86_64       buildonly-randconfig-003-20240714   gcc-13
x86_64       buildonly-randconfig-004-20240714   clang-18
x86_64       buildonly-randconfig-005-20240714   clang-18
x86_64       buildonly-randconfig-006-20240714   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240714   gcc-13
x86_64                randconfig-002-20240714   clang-18
x86_64                randconfig-003-20240714   gcc-13
x86_64                randconfig-004-20240714   clang-18
x86_64                randconfig-005-20240714   gcc-10
x86_64                randconfig-006-20240714   gcc-10
x86_64                randconfig-011-20240714   clang-18
x86_64                randconfig-012-20240714   gcc-7
x86_64                randconfig-013-20240714   clang-18
x86_64                randconfig-014-20240714   clang-18
x86_64                randconfig-015-20240714   gcc-13
x86_64                randconfig-016-20240714   clang-18
x86_64                randconfig-071-20240714   clang-18
x86_64                randconfig-072-20240714   gcc-13
x86_64                randconfig-073-20240714   clang-18
x86_64                randconfig-074-20240714   clang-18
x86_64                randconfig-075-20240714   clang-18
x86_64                randconfig-076-20240714   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

