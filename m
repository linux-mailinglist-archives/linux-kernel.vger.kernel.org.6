Return-Path: <linux-kernel+bounces-394698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70869BB300
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FDEB28829
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6841B3930;
	Mon,  4 Nov 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVt0pUjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0B1B3959
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718610; cv=none; b=YnRgV//Hn6Tpc/f886D3aOgQe3EsOEOOAcMlv4BcV6qxaswJ1PEairgPVOH+54yxQ4Gw0eQ6K7l5huih+VGEFKCBNUel7Otl9XBOKVgfdlN5K5FQ8D3N2o4ukEdVOQeQM5Axu+R2stJNbVWoLbWv+km9tJMUf3k4gTwoDzG8+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718610; c=relaxed/simple;
	bh=vOrBvcms65lgvC0TDZtvVLCxlDXKSwnxMbThfqNucJ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dymr4O2b2P1GAOjz2gcYGeeHhRyQFnDMr/yYn0G2gx+9R59Gb4cfrvRhV377v2ReS7fYogzXGulCZyakKEAnmiszTbVxt0bzQdzudrzAfUT+5Z7NJSJwyWSueTJnW3YUY4GSzX8JUWTyzLopyaQZUOWqA8wViy3doQxGssec6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVt0pUjM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730718608; x=1762254608;
  h=date:from:to:cc:subject:message-id;
  bh=vOrBvcms65lgvC0TDZtvVLCxlDXKSwnxMbThfqNucJ8=;
  b=QVt0pUjMa36s1Tta03r7SevZMvyTYq97Fe6pG9UngljPePHteSSiKDKy
   Beu7fwIO6ywjmUGv+ibTdDEzj2X3sml0Cqz0L84SO/4qnTlo3dQNRW/jH
   Kzt6WY94AjWp4knQam/gvnpp8iidVTa07k8JvEzsjOwfQMqC/s+b40Br/
   Bm0QTZIMoELir2je2JOoBXUFcWJB45sv1/OMbbnLypBxohHTsfKhUueDE
   UWCWJuxqydf/Mjnhbb2jBI4XLHjQJOrytUIiNEIQsPBbup4m9OV1cleFS
   z75TETglUI64v/N2fhkKOU9XbEhEQDvaJhvHSsRMIAt7gRXhY2NvHZ8Y/
   w==;
X-CSE-ConnectionGUID: zKBK+lFaS3y9Ptt8LwCgsQ==
X-CSE-MsgGUID: OIYaHh8eS0+uZj4iIOtxbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34102606"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34102606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:10:08 -0800
X-CSE-ConnectionGUID: haMr2cZZR0Gd5Ulm2GDb5g==
X-CSE-MsgGUID: q7ykyR0gSAOff9ypw+uICA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84442395"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Nov 2024 03:10:07 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7uyC-000kkj-0z;
	Mon, 04 Nov 2024 11:10:04 +0000
Date: Mon, 04 Nov 2024 19:09:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028-sa-with-flex] BUILD
 REGRESSION 0e7c24c783de39e1f965e8c23e96a7de29dfbfca
Message-ID: <202411041908.fVMKQ4Td-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241028-sa-with-flex
branch HEAD: 0e7c24c783de39e1f965e8c23e96a7de29dfbfca  uapi: socket: Introduce struct sockaddr_legacy

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202411041346.VYUgLq9I-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202411041638.igTDF2vU-lkp@intel.com

    drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c:148:3: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:442:2: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    drivers/net/ethernet/marvell/sky2.c:4680:3: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_874' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
    include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_875' declared with attribute error: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
    net/ipv4/arp.c:1188:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    net/ncsi/ncsi-rsp.c:649:2: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    net/packet/af_packet.c:3653:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    net/packet/af_packet.c:4702:11: error: incompatible function pointer types initializing 'int (*)(struct socket *, struct sockaddr *, int)' with an expression of type 'int (struct socket *, struct sockaddr_legacy *, int)' [-Wincompatible-function-pointer-types]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allmodconfig
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- i386-buildonly-randconfig-001-20241104
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- i386-randconfig-002-20241104
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- powerpc-allyesconfig
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- riscv-allmodconfig
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- riscv-allyesconfig
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- s390-allmodconfig
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- sparc-allmodconfig
|   |-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256
|-- sparc-allyesconfig
|   |-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
|   `-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256
|-- um-allmodconfig
|   |-- drivers-infiniband-ulp-opa_vnic-opa_vnic_netdev.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|-- x86_64-allyesconfig
|   |-- drivers-infiniband-ulp-opa_vnic-opa_vnic_netdev.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   |-- drivers-net-ethernet-freescale-dpaa-dpaa_eth.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
|   `-- net-ncsi-ncsi-rsp.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
`-- x86_64-kexec
    |-- drivers-net-ethernet-marvell-sky2.c:warning:memcpy-will-always-overflow-destination-buffer-has-size-but-size-argument-is
    |-- net-ipv4-arp.c:error:invalid-application-of-sizeof-to-an-incomplete-type-char
    |-- net-packet-af_packet.c:error:incompatible-function-pointer-types-initializing-int-(-)(struct-socket-struct-sockaddr-int)-with-an-expression-of-type-int-(struct-socket-struct-sockaddr_legacy-int)
    `-- net-packet-af_packet.c:error:invalid-application-of-sizeof-to-an-incomplete-type-char

elapsed time: 764m

configs tested: 130
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241104    gcc-13.2.0
arc                   randconfig-002-20241104    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     am200epdkit_defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20241104    clang-20
arm                   randconfig-002-20241104    clang-20
arm                   randconfig-003-20241104    clang-20
arm                   randconfig-004-20241104    clang-20
arm                       versatile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241104    clang-20
arm64                 randconfig-002-20241104    gcc-14.1.0
arm64                 randconfig-003-20241104    clang-20
arm64                 randconfig-004-20241104    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241104    gcc-14.1.0
csky                  randconfig-002-20241104    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241104    clang-14
hexagon               randconfig-002-20241104    clang-15
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241104    clang-19
i386        buildonly-randconfig-002-20241104    gcc-12
i386        buildonly-randconfig-003-20241104    clang-19
i386        buildonly-randconfig-004-20241104    gcc-12
i386        buildonly-randconfig-005-20241104    clang-19
i386        buildonly-randconfig-006-20241104    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241104    gcc-12
i386                  randconfig-002-20241104    clang-19
i386                  randconfig-003-20241104    gcc-12
i386                  randconfig-004-20241104    clang-19
i386                  randconfig-005-20241104    clang-19
i386                  randconfig-006-20241104    clang-19
i386                  randconfig-011-20241104    gcc-12
i386                  randconfig-012-20241104    gcc-12
i386                  randconfig-013-20241104    clang-19
i386                  randconfig-014-20241104    gcc-12
i386                  randconfig-015-20241104    gcc-12
i386                  randconfig-016-20241104    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241104    gcc-14.1.0
loongarch             randconfig-002-20241104    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    clang-15
mips                         bigsur_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241104    gcc-14.1.0
nios2                 randconfig-002-20241104    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241104    gcc-14.1.0
parisc                randconfig-002-20241104    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                      katmai_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc               randconfig-001-20241104    gcc-14.1.0
powerpc               randconfig-002-20241104    gcc-14.1.0
powerpc               randconfig-003-20241104    gcc-14.1.0
powerpc                    socrates_defconfig    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241104    clang-20
powerpc64             randconfig-002-20241104    gcc-14.1.0
powerpc64             randconfig-003-20241104    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241104    clang-20
riscv                 randconfig-002-20241104    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241104    gcc-14.1.0
s390                  randconfig-002-20241104    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20241104    gcc-14.1.0
sh                    randconfig-002-20241104    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20241104    gcc-14.1.0
sparc64               randconfig-002-20241104    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241104    clang-15
um                    randconfig-002-20241104    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241104    gcc-12
x86_64      buildonly-randconfig-002-20241104    clang-19
x86_64      buildonly-randconfig-003-20241104    gcc-11
x86_64      buildonly-randconfig-004-20241104    clang-19
x86_64      buildonly-randconfig-005-20241104    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241104    gcc-14.1.0
xtensa                randconfig-002-20241104    gcc-14.1.0
xtensa                         virt_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

