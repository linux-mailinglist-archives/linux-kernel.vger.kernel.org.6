Return-Path: <linux-kernel+bounces-565246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B555A66468
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5102F189ED60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A113AA53;
	Tue, 18 Mar 2025 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/l+hFTK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920878F59
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259561; cv=none; b=aTo0eJWHaUWUtEsIG9eh3Z7wfX3yf/34ljnr85s0q3MZSlxJWkLyEfRYhms0MOmLtC+ANTZpMrhCstp+EyW445MXw2768aue219YT+UnrV4D+xA9aW3RGkvJmiFzt3WHyiwDQro8lChw+Bn8jGRPga/rZarFURQVGR80ahxZh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259561; c=relaxed/simple;
	bh=mlvq6Pao3x4D35y/vZe+FP2WopZsZz+VDrTayEVYAuo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=szwwRU2wIHQOgwnoflZZKhAd7TkZaxenQpQLAgDUmj5ZhoSrGT7vGaolIxjObv6MSEhNPeR6YqqrBy0Dt5oEFJwdiY9J8ohTKFVElZLgyLYLsx94LsqeC9+QnIhGbDCc+JYQ3en0gQQldRJjZ5AVkSiV/13TbYKuommBNy9O0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/l+hFTK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742259560; x=1773795560;
  h=date:from:to:cc:subject:message-id;
  bh=mlvq6Pao3x4D35y/vZe+FP2WopZsZz+VDrTayEVYAuo=;
  b=F/l+hFTKf8jTaH3WCWHJDhcFhNBT7wvb40bTnDwF7pu6SdqqVY+KRuth
   nc8w5BJwZagCY06dW8bNypAxqO4NRu7mNxIIoygq3Wfa3CqlP57n1zF7j
   hyd9vE/SEYvXV8mVsmAi3RZ9+EkwQpcWsLISyqge/2jBeo9cWwJDERUpU
   zehF+LlFVZXHp0q3llgeixZ08aiubCbF3WGsPXjHEugO5uUuo/2ssolcJ
   CIwRbfFh42lA9fTgA1Nm3uVOqSSD6GosauT1VE0W1EAx636bc9ZGMU7ih
   QllY+xfb4f7tqT09kCSU6JqK8dsqARr8M9NcXwH28XRLkaIcoaoOd0C7x
   g==;
X-CSE-ConnectionGUID: srpYRnkQS7q2ET/IxwXx1w==
X-CSE-MsgGUID: pB1agB5tRaKH95GpZTR1ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43291160"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="43291160"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 17:59:19 -0700
X-CSE-ConnectionGUID: jLE0PDssSq+jgups4Sfpyg==
X-CSE-MsgGUID: psOVrKXIT1GIePQjz3KaXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="152952168"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Mar 2025 17:59:18 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuLIQ-000DGR-2b;
	Tue, 18 Mar 2025 00:59:09 +0000
Date: Tue, 18 Mar 2025 08:58:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250304] BUILD REGRESSION
 ebfbbb3a2cfb8c24ee218c05360d581a962ddec4
Message-ID: <202503180821.qbZFUGtQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250304
branch HEAD: ebfbbb3a2cfb8c24ee218c05360d581a962ddec4  usb: gadget: uvc: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arm-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arm-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arm-randconfig-002-20250317
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- arm64-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|-- i386-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- i386-allyesconfig
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
|-- sparc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- sparc64-randconfig-002-20250317
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- um-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|-- um-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type
|-- x86_64-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-has-incomplete-type-struct-iwl_tx_cmd_hdr
`-- xtensa-allyesconfig
    |-- drivers-net-wireless-intel-iwlwifi-fw-api-tx.h:error:field-tx-has-incomplete-type
    |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-pti_req_tx_cmd-has-incomplete-type
    |-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tdls.h:error:field-tx_cmd-has-incomplete-type
    `-- drivers-net-wireless-intel-iwlwifi-mvm-..-fw-api-tx.h:error:field-tx-has-incomplete-type

elapsed time: 1444m

configs tested: 122
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20250317    gcc-13.2.0
arc                   randconfig-002-20250317    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                       netwinder_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250317    gcc-14.2.0
arm                   randconfig-002-20250317    gcc-14.2.0
arm                   randconfig-003-20250317    gcc-14.2.0
arm                   randconfig-004-20250317    clang-21
arm                        shmobile_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250317    gcc-14.2.0
arm64                 randconfig-002-20250317    gcc-14.2.0
arm64                 randconfig-003-20250317    gcc-14.2.0
arm64                 randconfig-004-20250317    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250317    gcc-14.2.0
csky                  randconfig-002-20250317    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250317    clang-21
hexagon               randconfig-002-20250317    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250317    gcc-12
i386        buildonly-randconfig-002-20250317    clang-20
i386        buildonly-randconfig-003-20250317    clang-20
i386        buildonly-randconfig-004-20250317    clang-20
i386        buildonly-randconfig-005-20250317    gcc-12
i386        buildonly-randconfig-006-20250317    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250317    gcc-14.2.0
loongarch             randconfig-002-20250317    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250317    gcc-14.2.0
nios2                 randconfig-002-20250317    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250317    gcc-14.2.0
parisc                randconfig-002-20250317    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250317    clang-15
powerpc               randconfig-002-20250317    clang-21
powerpc               randconfig-003-20250317    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250317    gcc-14.2.0
powerpc64             randconfig-002-20250317    gcc-14.2.0
powerpc64             randconfig-003-20250317    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250317    gcc-14.2.0
riscv                 randconfig-002-20250317    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250317    clang-15
s390                  randconfig-002-20250317    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250317    gcc-14.2.0
sh                    randconfig-002-20250317    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250317    gcc-14.2.0
sparc                 randconfig-002-20250317    gcc-14.2.0
sparc64               randconfig-001-20250317    gcc-14.2.0
sparc64               randconfig-002-20250317    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250317    gcc-12
um                    randconfig-002-20250317    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250317    gcc-12
x86_64      buildonly-randconfig-002-20250317    clang-20
x86_64      buildonly-randconfig-003-20250317    gcc-12
x86_64      buildonly-randconfig-004-20250317    gcc-12
x86_64      buildonly-randconfig-005-20250317    gcc-12
x86_64      buildonly-randconfig-006-20250317    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250317    gcc-14.2.0
xtensa                randconfig-002-20250317    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

