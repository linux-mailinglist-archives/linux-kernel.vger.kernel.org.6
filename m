Return-Path: <linux-kernel+bounces-191787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9888D1415
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478FD1F22C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9AA4D9F4;
	Tue, 28 May 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQGsnahm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F2F4EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716875736; cv=none; b=bPEFzsFLJR/0JuqFCNwEz7Yt+52jnHQvodE2oFVbWP9O1TyIEx8Q6khJbqrCMiAYPFW1M2ytsEs2UxxLhRLDw8jYVAZqZJQhN1Y52jZ04ckM68jMFGf6iBT5LU0fZwuB775eDs55U/5/oL0aRUKi3I4z0roGdggQ5fVZkKt/E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716875736; c=relaxed/simple;
	bh=Txyp7it1Ne8l6xfA6Bk46bIz0pZVoVDNXX1lQrO5IBc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fKNJYEXUzuFrQBAL0NMyeyZ/oRZxHhjtwF/MQig3jKM5GewXY+Az2hZLNmCcJ/BNXtnJV+t5JBerWmq2lzWNIailo2s5whgw5+Pf2xPFi9zo5MS85fFjEhvDIL9rOZS6pu0Y98l6dLhkneYxVO7JcluIjMf1NuUOCMBa5Rxa6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQGsnahm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716875736; x=1748411736;
  h=date:from:to:cc:subject:message-id;
  bh=Txyp7it1Ne8l6xfA6Bk46bIz0pZVoVDNXX1lQrO5IBc=;
  b=fQGsnahmNKKrp04rnljEHPTF55rfwXZKAFcYHxMHxfx+w9qEoDVXwB/L
   89gU504bn5X4le0h31IXdM0pqmnNEG9OXxz+QA7ZoWVoXh3DWJ3PLzysF
   gObiFyYudvc5unWnsSJ5mcLihgTB2i3stthaQVOwHEluSa9paYv8drLbL
   SB21l/Jzt6Jqk1P3FJbUJaIR3gjyp+WYxgWAxtPVbqnwkSMJqmehjmuXZ
   2v1kDZ3hBqjv9eicO90hC7rS3IFXM5JKwZEURM3MlEVNalNnpRY+G6P2p
   fYO0Nk3Vjc/2b4Wo7PLMc6VWoube+RLxr3Oyt3vGyAFM+OlsSqRuD43SU
   g==;
X-CSE-ConnectionGUID: 9lnL04SDRueThQu4asXNGA==
X-CSE-MsgGUID: IPHvTHnzST2KB2h1IImLcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13321718"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13321718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 22:55:35 -0700
X-CSE-ConnectionGUID: TLAGMezpT7a8GjILPNMP4w==
X-CSE-MsgGUID: MaNyKNZ7SfmSyNRgjIKeRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35552091"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 27 May 2024 22:55:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBpnv-000BlP-1f;
	Tue, 28 May 2024 05:55:25 +0000
Date: Tue, 28 May 2024 13:54:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 0c40b1c7a897bd9733e72aca2396fd3a62f1db17
Message-ID: <202405281339.DPlujAs0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 0c40b1c7a897bd9733e72aca2396fd3a62f1db17  x86/setup: Warn when option parsing is done too early

elapsed time: 737m

configs tested: 66
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240528   gcc  
i386         buildonly-randconfig-002-20240528   clang
i386         buildonly-randconfig-003-20240528   clang
i386         buildonly-randconfig-004-20240528   clang
i386         buildonly-randconfig-005-20240528   clang
i386         buildonly-randconfig-006-20240528   clang
i386                                defconfig   clang
i386                  randconfig-001-20240528   clang
i386                  randconfig-002-20240528   clang
i386                  randconfig-003-20240528   gcc  
i386                  randconfig-004-20240528   gcc  
i386                  randconfig-005-20240528   gcc  
i386                  randconfig-006-20240528   gcc  
i386                  randconfig-011-20240528   clang
i386                  randconfig-012-20240528   gcc  
i386                  randconfig-013-20240528   gcc  
i386                  randconfig-014-20240528   clang
i386                  randconfig-015-20240528   gcc  
i386                  randconfig-016-20240528   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

