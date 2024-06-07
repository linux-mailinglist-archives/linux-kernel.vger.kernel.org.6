Return-Path: <linux-kernel+bounces-206327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020FF9007F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9183928C019
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E891190672;
	Fri,  7 Jun 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJzxpYu8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE92197521
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772188; cv=none; b=qqphPKGP0S00Qa6wNUIZizqaRhLRmtKDRNNYaMtWcKCtfqesD+yD0/ZPmQnTd/p3jFasfbgzaaNnk4oCn8wiu0DziRdK6wne/tr5nGuuviHOf3eOnOt9KlF3z1ftn5GoITr89Y3nBOnSOWybXAxa7w0dDqTvSooKnbm7j3MlxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772188; c=relaxed/simple;
	bh=TR6j5xQ8JwRMb625G8EwznpI1B+XloEkiPYMO+zinpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YluKw0OrX+PK8vWSJaj7X78vfcXWr2x7EqKN9pb7ufApCXWxpXYzJIVxvKXrjmTkpa96sxuinDChrOH0hBVs6GjpXKtZDfUJdjs9T6BDRS9HGkdOTHfOtZxBrmeWoC4ct0ofmRmvgpuxgbuWu0V0VaG2/B/Q6XHIee4bFt2owc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJzxpYu8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717772187; x=1749308187;
  h=date:from:to:cc:subject:message-id;
  bh=TR6j5xQ8JwRMb625G8EwznpI1B+XloEkiPYMO+zinpM=;
  b=TJzxpYu8HUHzfr58t1s0PAy17QsBd2cVYlKiIk4HwWmn+ypM8ICAvcgT
   Us5B/5Rj/B2wa2G+fv1siLhygLWbohUOLzrcfiWRqDbMnQ0v6R3c2PVY5
   I735EBtB6dcvNyZJcwnUmcXXsXW8P2DFhoPB6BbvgKbmT3SRB56IPPhUN
   CC5n93sjRnSau4jPaqt29ij4vsHQqpVAy5raWzJKMo2+YCd8pg4uj2tad
   rabbfTgjZ+fWalZe0CJihmHBM+isl1WbL6BNrh/y1phRaOrrzIvrT1GW9
   i3DqzwqKjQIl9kQwl4DAD+OvWnV1r/i1+d5KCIe0LENNv45mzK50hewVr
   A==;
X-CSE-ConnectionGUID: ufSVHwD5TY+7+4PYvaU9TA==
X-CSE-MsgGUID: R5i7dOKwRfWlip+yJvOf7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14615127"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14615127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 07:56:27 -0700
X-CSE-ConnectionGUID: /yi/hbelSXeDJvh4FBvukg==
X-CSE-MsgGUID: LvZw0HgQQoiDtP3S/BKD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43277611"
Received: from lkp-server01.sh.intel.com (HELO 7b447d911354) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Jun 2024 07:56:25 -0700
Received: from kbuild by 7b447d911354 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFb0x-00003g-0Y;
	Fri, 07 Jun 2024 14:56:23 +0000
Date: Fri, 07 Jun 2024 22:56:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 ababa16fd9bd0e2727a1c31c4fb68d6be053bddc
Message-ID: <202406072206.O9cyRfUc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: ababa16fd9bd0e2727a1c31c4fb68d6be053bddc  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

elapsed time: 1449m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240607   clang
i386         buildonly-randconfig-002-20240607   clang
i386         buildonly-randconfig-003-20240607   clang
i386         buildonly-randconfig-004-20240607   clang
i386         buildonly-randconfig-005-20240607   clang
i386         buildonly-randconfig-006-20240607   clang
i386                                defconfig   clang
i386                  randconfig-001-20240607   gcc  
i386                  randconfig-002-20240607   gcc  
i386                  randconfig-011-20240607   clang
i386                  randconfig-013-20240607   clang
i386                  randconfig-014-20240607   clang
i386                  randconfig-015-20240607   clang
i386                  randconfig-016-20240607   clang
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
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

