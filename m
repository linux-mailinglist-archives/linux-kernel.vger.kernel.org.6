Return-Path: <linux-kernel+bounces-236678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9F91E5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A58284F04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5F16DECB;
	Mon,  1 Jul 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7DFxlTq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DB16D9D4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852340; cv=none; b=H3Ny4+Q2lPsNCmD6jtoX1AkOfWgxibD0rFCFgQtglK554NZU3xprJSEZl7740ByQgoKS46NVIzlPRC8cXRYnns2+UiBJe5hEd0OJZGbRDtJ4At1pzYpbEvDEn0j6nfWiaNkX4S/OScU+bQWm8RRLPcEpoQxYo/cHQsRahJS9oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852340; c=relaxed/simple;
	bh=mKKbgvej0BMpV1+VeJ3esgVLJocbnF5zZqn8HKzMwEY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VKkf6vELz9nptHfcTgDTl6kT9ww4dWACuTh+ExyrUuCEUO+y+E+sdeIl/LSdoDJilDf9EYpTYobf4vMxUY/wkuLYSyMQqde0BjyG5O8tPEBHbLB9jZmSjp2z7OU0QFhEFQ4rBk9x8QChHlcbzR6+f3VXp04uYoZBDPZZ5cZtuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7DFxlTq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719852339; x=1751388339;
  h=date:from:to:cc:subject:message-id;
  bh=mKKbgvej0BMpV1+VeJ3esgVLJocbnF5zZqn8HKzMwEY=;
  b=G7DFxlTqM4soIfU9+BLVtTBILEH8zbAaGEosZVSWQMds0Cl61/Izl/dS
   B7JRjL0EM+7vJg+Z/NfH6h7noA5CHTItQZZzo+NaVocys349ZOwS52+UK
   t7o4KMmpyLhxRlt33sb7wZejvUNEKLhkkV/xdQNEp25DaCacziYHp5q6F
   Rb60Mj05MiiWyLIJOecE2RcB7cYMPnErEPEeYdPLBDXE40trK0CNSunyT
   GnJRbNqoHS1AbXhLDwmtG0spEZapiunPXle4Bv/gwIMulGnKchLTm0Trc
   2mVijd5GeVf/0X/1KErFhrQvt9eXLEKeJjKqw4tHdtW6srFtkBieS8KgD
   A==;
X-CSE-ConnectionGUID: NwovFJ2tSaOpTZ20AWvuSA==
X-CSE-MsgGUID: DWACE1CfSY+YC09539ALBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17122541"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17122541"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:45:39 -0700
X-CSE-ConnectionGUID: xqgXYp+3TK6ZX6W46/UtzQ==
X-CSE-MsgGUID: ZA9qh3QqTyCLKmL8JLGtIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46019705"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2024 09:45:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOK9n-000N2K-0T;
	Mon, 01 Jul 2024 16:45:35 +0000
Date: Tue, 02 Jul 2024 00:44:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6
Message-ID: <202407020031.MfTLX96v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6  x86/kmsan: Fix hook for unaligned accesses

elapsed time: 8962m

configs tested: 52
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   clang-16
arm                         lpc32xx_defconfig   clang-19
arm                            mps2_defconfig   clang-19
arm                        realview_defconfig   clang-19
arm                        spear3xx_defconfig   clang-16
arm64                            allmodconfig   clang-19
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   clang-19
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                     ksi8560_defconfig   gcc-13.2.0
powerpc                       maple_defconfig   clang-19
powerpc                      tqm8xx_defconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                            allyesconfig   clang-19
s390                             allmodconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allyesconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

