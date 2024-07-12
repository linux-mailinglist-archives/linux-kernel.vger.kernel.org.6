Return-Path: <linux-kernel+bounces-251131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0B930106
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1458F281411
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58EC381BA;
	Fri, 12 Jul 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtElwmi/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6ED2032A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813249; cv=none; b=roWyvSzSIAxHLjL8wFuH9yr97zhS+2KMhq/kyxRsA0+733CkpiuxadGJbTAcALNOwG7vXMmqRRGgYryuzd3wa/xghIrGcY98P8EEvd8JsWowlKxNfjbop0sEeAn9uBvfM0FgOqX3Xag2HoydpYIDSrsVHukVP06tal2/a/M8eTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813249; c=relaxed/simple;
	bh=nuLCVc8jMbYe90IHZEaUZgeJpygDFxblkZEyYUHyi3k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NExXKJVLs2vycEDpWgHoEirfCCZEVwdayAST13Xe7XlwEB1yNn0M7PnokP7kc/DgTmzq4kNgBSizLhMnqIyZhTT8pT4StVNoRWh5FWjf0Mxa6dMXc2Saxqea9gb+WLt16h2KxqkHYh08Ia0Fcy5JcLUHplvh1tXJRhQvP2xeiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtElwmi/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720813247; x=1752349247;
  h=date:from:to:cc:subject:message-id;
  bh=nuLCVc8jMbYe90IHZEaUZgeJpygDFxblkZEyYUHyi3k=;
  b=GtElwmi/fOMce9seWOg2NV1l3GRVpc2g9yCoGongWA7iVPorhei3WMgb
   7LO1mELrF6Bt5lYqgoiEt4eLDPSNawwWBGIA1x36gHjrwbzBZ4r8gVlaW
   q7s1rr55b/83RzbEmHg3HBXPRT3GM7d3SG5VZVBahiOwt8q5F2jwtP7bb
   VxZ0pHs7qrkO1hUnQIZmQ5Cvl9vplAR0mjnKDOo08wki0WSyGY8BsvIxG
   s1c7/RqCiUGpo2Lzl4B4PNEROSrZGj9IB8awXJSJF+RI6buMVKjciml8j
   7Ny+wKMw/XIcbwG4SLqJJplqxbk8bM09J+0TIpAzWn1y1sdxVBswhTYte
   w==;
X-CSE-ConnectionGUID: TiWFaueFQuqZtk6JIQGF+A==
X-CSE-MsgGUID: vK+w76xcQYiw3cAI9axe2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="17981501"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="17981501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 12:40:45 -0700
X-CSE-ConnectionGUID: 6HSTk66eSmKxIzBwAk4Jvg==
X-CSE-MsgGUID: /OivGGwOQo25dkqqdQMhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="72209745"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jul 2024 12:40:45 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSM8I-000bCI-1A;
	Fri, 12 Jul 2024 19:40:42 +0000
Date: Sat, 13 Jul 2024 03:40:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc] BUILD
 REGRESSION 811bc7260e24cf06adefdbf8debb2a83d213e02d
Message-ID: <202407130318.L7fTzXeb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
branch HEAD: 811bc7260e24cf06adefdbf8debb2a83d213e02d  ethtool: Avoid -Wflex-array-member-not-at-end warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407120926.PaHnpipg-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

./usr/include/linux/usb/video.h:403:15: error: unknown type name 'offsetof'
./usr/include/linux/usb/video.h:405:15: error: expected declaration specifiers or '...' before string constant

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/powerpc/include/asm/hvcall.h:697:48: error: structure containing a flexible array member is not at the end of another structure [-Werror=flex-array-member-not-at-end]
arch/powerpc/perf/hv-common.c:12:56: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/powerpc/platforms/powermac/nvram.c:62:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
arch/sparc/kernel/ds.c:891:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/s390/scsi/zfcp_fc.h:105:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/xen/pci.c:48:55: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
net/netfilter/x_tables.c:811:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

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
|-- arm64-randconfig-002-20240712
|   `-- drivers-xen-pci.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
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
|-- i386-buildonly-randconfig-001-20240711
|   |-- usr-include-linux-usb-video.h:error:expected-declaration-specifiers-or-...-before-string-constant
|   `-- usr-include-linux-usb-video.h:error:unknown-type-name-offsetof
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
|-- powerpc64-randconfig-001-20240711
|   `-- arch-powerpc-include-asm-hvcall.h:error:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-003-20240711
|   `-- arch-powerpc-platforms-powermac-nvram.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
|-- powerpc64-randconfig-003-20240712
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
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
|   `-- drivers-scsi-lpfc-lpfc_hw4.h:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure
`-- sparc64-defconfig
    `-- arch-sparc-kernel-ds.c:warning:structure-containing-a-flexible-array-member-is-not-at-the-end-of-another-structure

elapsed time: 1445m

configs tested: 139
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240712   clang-19
arm                   randconfig-002-20240712   clang-19
arm                   randconfig-003-20240712   gcc-14.1.0
arm                   randconfig-004-20240712   clang-15
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240712   gcc-14.1.0
arm64                 randconfig-002-20240712   gcc-14.1.0
arm64                 randconfig-003-20240712   clang-19
arm64                 randconfig-004-20240712   clang-17
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240712   gcc-14.1.0
csky                  randconfig-002-20240712   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240712   clang-14
hexagon               randconfig-002-20240712   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-006-20240712   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-016-20240712   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240712   gcc-14.1.0
loongarch             randconfig-002-20240712   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240712   gcc-14.1.0
nios2                 randconfig-002-20240712   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-14.1.0
parisc                randconfig-002-20240712   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240712   clang-15
powerpc               randconfig-002-20240712   clang-19
powerpc64             randconfig-001-20240712   clang-19
powerpc64             randconfig-002-20240712   clang-19
powerpc64             randconfig-003-20240712   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240712   clang-19
riscv                 randconfig-002-20240712   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240712   gcc-14.1.0
s390                  randconfig-002-20240712   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-14.1.0
sh                    randconfig-002-20240712   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-14.1.0
sparc64               randconfig-002-20240712   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240712   clang-19
um                    randconfig-002-20240712   clang-15
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   gcc-12
x86_64                randconfig-002-20240712   gcc-13
x86_64                randconfig-003-20240712   gcc-12
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   gcc-13
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   gcc-13
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   gcc-13
x86_64                randconfig-072-20240712   gcc-11
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   gcc-9
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240712   gcc-14.1.0
xtensa                randconfig-002-20240712   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

