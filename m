Return-Path: <linux-kernel+bounces-555367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1BAA5B681
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C283AD9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810C1E520A;
	Tue, 11 Mar 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUYPGQ2B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A91C6F55
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658906; cv=none; b=LQ922ENG4pRobZ/5GcfAvAA1ICsgZTKl0QRsMsRDkCBRgnUg1fJBQuvjxBPGovfTrKPGC2HuCRNKkHLrNG5xwdLbaePIBWaO7bJAgVE+8WuJLvIoOeRWHJ9ocp/nR9AQLV7OhAOG7Kciv6UA03HVvCqa8tlhR7RiyAYHiDtadtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658906; c=relaxed/simple;
	bh=F8aX5Z0XrqZM+TF7u9XoSyBFmRP/s92INxUv3RpOnVg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q6snSMc620S55tUoVcaFwmovv8wRGbQouZEn8X3yHveSYtBLNnIijvPVEOd/pY4TlhQ/LI2MzdhTDQ6ybx2qF5k2fbzdRWh1ntJMvC/2jAZEZhpu1cTpHKYLypmegmP2bGONwgi12RCdSCd2q1bTVdrO0BXsRiCeQ4nXQy7atIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUYPGQ2B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741658905; x=1773194905;
  h=date:from:to:cc:subject:message-id;
  bh=F8aX5Z0XrqZM+TF7u9XoSyBFmRP/s92INxUv3RpOnVg=;
  b=aUYPGQ2Bz3dbpQDNZyg5EIprqdKJtiJ6zOfFsbK5XGg22aBKRyC1eWJ+
   gZ5w5CYkixLpEy2OsnpF0NGjcP755lzrzZDdqDDa4fkEATN++zdcfjgBr
   yLw9963i1gbXoKky6G5jv7+q7U0beEKKVx0dk36A/pZmgRnlOqcrtWiqi
   OWkFquJGApcSrGj/TCqWLzWjLtRTIVWF6hLdOnrxNvMgzkKtCUDipdr4y
   M8Ic7raKTlfUVwh6E2+ec2o5suN565Qbt6NZrtVtdouYy4MbggHVGbkpY
   k1WZ3XHo40TQoSvB6/vVJYV6rP6kZkpeaTTj34zE4RKtRngeblfc1PO6f
   Q==;
X-CSE-ConnectionGUID: FYwOPn+kSvCR4pe38tkjHA==
X-CSE-MsgGUID: YDXv3C8nQr6Wj3f0aotbqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41846110"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="41846110"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 19:08:24 -0700
X-CSE-ConnectionGUID: QaSMYhfFQf+JBLYJ34aixg==
X-CSE-MsgGUID: 1Y4LdM9GT/+KrCybB0eotw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120874810"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 10 Mar 2025 19:08:23 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trp2b-0006Gu-0A;
	Tue, 11 Mar 2025 02:08:21 +0000
Date: Tue, 11 Mar 2025 10:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250304] BUILD REGRESSION
 6d2e9e1f723433e96db706772bc630bc704bf9ba
Message-ID: <202503111018.6E528Ano-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250304
branch HEAD: 6d2e9e1f723433e96db706772bc630bc704bf9ba  wifi: ath12k: core.h: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503102143.Rm06fBbo-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503110126.sgFy2aj6-lkp@intel.com

    drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
    drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:31: error: field 'tx' has incomplete type
    drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:31: error: field 'pti_req_tx_cmd' has incomplete type
    drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
    drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:31: error: field 'tx_cmd' has incomplete type
    drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
    drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:31: error: field 'tx' has incomplete type

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- loongarch-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- loongarch-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- mips-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- openrisc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- parisc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- parisc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- powerpc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- powerpc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|-- riscv-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|-- riscv-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
`-- um-allmodconfig
    |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
    |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
    `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr

elapsed time: 1164m

configs tested: 121
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250310    gcc-13.2.0
arc                   randconfig-002-20250310    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250310    clang-21
arm                   randconfig-002-20250310    gcc-14.2.0
arm                   randconfig-003-20250310    gcc-14.2.0
arm                   randconfig-004-20250310    clang-21
arm                             rpc_defconfig    clang-17
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250310    clang-19
arm64                 randconfig-002-20250310    clang-17
arm64                 randconfig-003-20250310    clang-15
arm64                 randconfig-004-20250310    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250310    gcc-14.2.0
csky                  randconfig-002-20250310    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250310    clang-21
hexagon               randconfig-002-20250310    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250310    clang-19
i386        buildonly-randconfig-002-20250310    clang-19
i386        buildonly-randconfig-003-20250310    clang-19
i386        buildonly-randconfig-004-20250310    clang-19
i386        buildonly-randconfig-005-20250310    clang-19
i386        buildonly-randconfig-006-20250310    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250310    gcc-14.2.0
loongarch             randconfig-002-20250310    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250310    gcc-14.2.0
nios2                 randconfig-002-20250310    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250310    gcc-14.2.0
parisc                randconfig-002-20250310    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-21
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250310    clang-17
powerpc               randconfig-002-20250310    clang-21
powerpc               randconfig-003-20250310    clang-17
powerpc64             randconfig-001-20250310    gcc-14.2.0
powerpc64             randconfig-002-20250310    gcc-14.2.0
powerpc64             randconfig-003-20250310    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250310    clang-19
riscv                 randconfig-002-20250310    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250310    gcc-14.2.0
s390                  randconfig-002-20250310    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250310    gcc-14.2.0
sh                    randconfig-002-20250310    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250310    gcc-14.2.0
sparc                 randconfig-002-20250310    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250310    gcc-14.2.0
sparc64               randconfig-002-20250310    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250310    gcc-12
um                    randconfig-002-20250310    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250310    gcc-12
x86_64      buildonly-randconfig-002-20250310    clang-19
x86_64      buildonly-randconfig-003-20250310    clang-19
x86_64      buildonly-randconfig-004-20250310    clang-19
x86_64      buildonly-randconfig-005-20250310    clang-19
x86_64      buildonly-randconfig-006-20250310    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250310    gcc-14.2.0
xtensa                randconfig-002-20250310    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

