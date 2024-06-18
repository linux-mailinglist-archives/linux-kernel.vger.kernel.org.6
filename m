Return-Path: <linux-kernel+bounces-220247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08290DE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244F31C23953
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE806178392;
	Tue, 18 Jun 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8/3n0p/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E662178377
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746167; cv=none; b=qcfTq42I3IcgYKdCzAvH8ZLk2rmIgNkI1JQDe3uHpKa2QxmhKQ3EjfGLFIPkR57gTAEUHrM2qOwVGMae3iR6YJXJXRQ5sVkUMkSeN82T54Pd2Kpc2HCcJpc78HbUTM1HaR+hwX/nb4P4Qqa9ro8ojgfRcKsbAgqjlovCsV7ft44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746167; c=relaxed/simple;
	bh=CJFx2bP/BCOpjpRFd7ELrdzD2EgIx27y92X2D0jfZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sfX8utzsPqUFVZr7v7STqUfoBsJHaMiedeR8Q4yAgGkCei3GrO05g8ey3m0Op6NvZnPcq2zhp/i9b16RCflQTE5LdTpOjl4b692IixR8r3ttG2neLuAMw+p+eHlbV/RBs8EU5qDVCKv61GFolTYptiZKiUWI6WeK8KAEfQNlrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8/3n0p/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718746165; x=1750282165;
  h=date:from:to:cc:subject:message-id;
  bh=CJFx2bP/BCOpjpRFd7ELrdzD2EgIx27y92X2D0jfZ2I=;
  b=X8/3n0p/Pwm/FwwnuaPo58U6fSrQdd5hrplmUfwIbqbRZnE8lRRwiMkr
   G5Zq98UAO5bVvh7Jw2Aj8lzf5z5RY/H3c5/0h33DGNtLwXRS2onH6T/fS
   obXY1Rnqi6zRWv3aiLtqSwycDYrhagGm2UvFcwmga+n3KPfYW3KNXfg/3
   ZEOnCGON4AgsdpiDThmbGiJR5WmKZFc0ODlXKv6f1jlNTtkmdGhUSF2lM
   42xEIVsIAvH5y7Mqsn2KRusIBknJE51cTdwcZEjNY8Qk3AdJEbVhqiRwO
   58QAzNFeZ1zWITRLORjHPt4R40FBTgAWX7vB/DbdubhpON882csjN6mAl
   g==;
X-CSE-ConnectionGUID: t5MSKRWdQsq+3WhO7QBGmQ==
X-CSE-MsgGUID: M9vHerFkRimnS93worFGaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33198067"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33198067"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:29:23 -0700
X-CSE-ConnectionGUID: /WigOF/8RMShtWyilj23bA==
X-CSE-MsgGUID: GtKHairATb6QLqcEQ3IEbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41790134"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2024 14:29:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJgOG-0005wO-1n;
	Tue, 18 Jun 2024 21:29:20 +0000
Date: Wed, 19 Jun 2024 05:29:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD REGRESSION
 8cb2dbf94e44bcde4cff0223f2f900f8fb9083a4
Message-ID: <202406190512.z6IGQZCC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 8cb2dbf94e44bcde4cff0223f2f900f8fb9083a4  irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=n

Error/Warning: (recently discovered and may have been fixed)

sparc-linux-ld: irqdomain.c:(.text+0x17dc): undefined reference to `irq_domain_remove_generic_chips'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc-randconfig-002-20240618
    `-- sparc-linux-ld:irqdomain.c:(.text):undefined-reference-to-irq_domain_remove_generic_chips

elapsed time: 1595m

configs tested: 38
configs skipped: 0

tested configs:
arc                   randconfig-001-20240618   gcc-13.2.0
arc                   randconfig-002-20240618   gcc-13.2.0
arm                   randconfig-001-20240618   gcc-13.2.0
arm                   randconfig-002-20240618   gcc-13.2.0
arm                   randconfig-003-20240618   clang-19
arm                   randconfig-004-20240618   gcc-13.2.0
arm64                 randconfig-001-20240618   clang-17
arm64                 randconfig-002-20240618   clang-19
arm64                 randconfig-003-20240618   clang-16
arm64                 randconfig-004-20240618   clang-19
csky                  randconfig-001-20240618   gcc-13.2.0
csky                  randconfig-002-20240618   gcc-13.2.0
hexagon               randconfig-001-20240618   clang-19
hexagon               randconfig-002-20240618   clang-19
loongarch             randconfig-001-20240618   gcc-13.2.0
loongarch             randconfig-002-20240618   gcc-13.2.0
nios2                 randconfig-001-20240618   gcc-13.2.0
nios2                 randconfig-002-20240618   gcc-13.2.0
parisc                randconfig-001-20240618   gcc-13.2.0
parisc                randconfig-002-20240618   gcc-13.2.0
powerpc               randconfig-001-20240618   gcc-13.2.0
powerpc               randconfig-002-20240618   clang-19
powerpc               randconfig-003-20240618   clang-19
powerpc64             randconfig-001-20240618   clang-19
powerpc64             randconfig-002-20240618   clang-17
powerpc64             randconfig-003-20240618   clang-19
riscv                 randconfig-001-20240618   gcc-13.2.0
riscv                 randconfig-002-20240618   clang-14
s390                  randconfig-001-20240618   clang-15
s390                  randconfig-002-20240618   gcc-13.2.0
sh                    randconfig-001-20240618   gcc-13.2.0
sh                    randconfig-002-20240618   gcc-13.2.0
sparc64               randconfig-001-20240618   gcc-13.2.0
sparc64               randconfig-002-20240618   gcc-13.2.0
um                    randconfig-001-20240618   clang-19
um                    randconfig-002-20240618   clang-19
xtensa                randconfig-001-20240618   gcc-13.2.0
xtensa                randconfig-002-20240618   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

