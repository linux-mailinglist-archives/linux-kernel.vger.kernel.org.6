Return-Path: <linux-kernel+bounces-181633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090E8C7EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBCB1F219C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF722AF16;
	Thu, 16 May 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adpeSmUk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FA282F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901646; cv=none; b=r9wng1Kjxmao1z3suNHD8EYzUnYsmaeG/0ws/81hwDoyom8QfeHbCGqT6EagY3VXoCKxZfw2dwnZTEuCvM+cH2tC5B9gXMX4YTh5N4MWtFQJ8VnqbBU8p6e9/tUxifKNmZqJEWGf/ZUEHah4segSQQtnuiGY4icYz0X2IXHY10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901646; c=relaxed/simple;
	bh=zsloFsld115NMSqWlw4QIi1C23DsTBpeqV2fGuGi4iU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pK43ixEkdJ0cnC4oJ6Osz+PqonvDTg+3fVwEH4jv3TxsQYXjYDmGF+G8BTvvTsilG9POtP6sDliIWRPJV8eCeIhU8sKMfzkB5J0pebZBdaEZyo+7KRoH/h7WaXs/JX77iApn7+Zb4IVQ7xh0XSK9b6SfMz3rdc7j/wM/P/OEJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adpeSmUk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715901645; x=1747437645;
  h=date:from:to:cc:subject:message-id;
  bh=zsloFsld115NMSqWlw4QIi1C23DsTBpeqV2fGuGi4iU=;
  b=adpeSmUketvPmtCJyh46ej4/lUgdEOV4GWUOsbjwAOdFK8JNQJxxUVns
   yPAqGzcT1PuZpv6hphxEHuuKLF8Ncpg+HZBHY6nOF7CEpoCMqIoX4C/d5
   LlT+g4/E1bAb1YxG8dPzFryynxGTHOfAKKz/V21eZFve1V2Ls3FdsxVhR
   NTOtxdMQElhM7Ih9Kb7uXLwxJ+4PdfePBfk6cqIDC/TAWJAYhTc2OkOw+
   SM1PdmllKjNknEJqxSvPOPbh7l1IuXKAs8A/gY5e6HdxFsvQF2gyTGGLY
   UA+LJW57vcZZ7/TG6srEWvRKvgSe76SrYKZGwY4EjJD1os/o7EjybmbNQ
   w==;
X-CSE-ConnectionGUID: +0yLlotdQrOXLlD8KXWx/A==
X-CSE-MsgGUID: TxqmbuWHS4yGleUm4a09LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22731114"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="22731114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 16:20:44 -0700
X-CSE-ConnectionGUID: 2lS/ElnjRZS+/kmhTtceTA==
X-CSE-MsgGUID: qQsLaUuPS6qm1MKPr2enYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="32136750"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2024 16:20:43 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7kOu-000EyT-2O;
	Thu, 16 May 2024 23:20:40 +0000
Date: Fri, 17 May 2024 07:20:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 995ca29c7bde561889901bbead62af6f37966f00
Message-ID: <202405170703.vAIzKctf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 995ca29c7bde561889901bbead62af6f37966f00  Merge branch into tip/master: 'x86/urgent'

elapsed time: 745m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240516   gcc  
arc                   randconfig-002-20240516   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                         nhk8815_defconfig   clang
arm                   randconfig-001-20240516   gcc  
arm                   randconfig-002-20240516   clang
arm                   randconfig-003-20240516   gcc  
arm                   randconfig-004-20240516   clang
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240516   gcc  
arm64                 randconfig-002-20240516   clang
arm64                 randconfig-003-20240516   clang
arm64                 randconfig-004-20240516   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240516   gcc  
csky                  randconfig-002-20240516   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240516   clang
i386         buildonly-randconfig-002-20240516   clang
i386         buildonly-randconfig-003-20240516   clang
i386         buildonly-randconfig-004-20240516   gcc  
i386         buildonly-randconfig-005-20240516   gcc  
i386         buildonly-randconfig-006-20240516   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240516   gcc  
i386                  randconfig-002-20240516   gcc  
i386                  randconfig-003-20240516   clang
i386                  randconfig-004-20240516   clang
i386                  randconfig-005-20240516   clang
i386                  randconfig-006-20240516   clang
i386                  randconfig-011-20240516   gcc  
i386                  randconfig-012-20240516   gcc  
i386                  randconfig-013-20240516   clang
i386                  randconfig-014-20240516   gcc  
i386                  randconfig-015-20240516   gcc  
i386                  randconfig-016-20240516   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
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
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

