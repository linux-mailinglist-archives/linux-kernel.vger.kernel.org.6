Return-Path: <linux-kernel+bounces-285638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C067C9510C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77688284E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376591AC450;
	Tue, 13 Aug 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpOPruNb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157C383BF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592819; cv=none; b=GMls/z5u/RKcpBTx+PLkhD6SdsYKIf01wSix784YylSd6fn2gyBDdG1LaqEgk3wrgauFka+F99RLi+PEBdd6K2f5kXeDPD4VYL8or8cBNdsTSBve+KFlI0X43KWAHqH3/QE9e8mvGkJSXfyGagzr1NpjZR5qtjqlWycrfut3tWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592819; c=relaxed/simple;
	bh=7vQK0vHaFwPYyhQesUTF0TSjKnO3CW6G6D1Wl0z1RTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t697uMWMxEoP4vaEttl+Xdz6/Knd4Kgg0Yo4xJuEB4+nZvZImGkQvHRLYI7rLeIRFAJFT6LdDs2UuBbhJHiagcz8qWdhZ8MDtcg3A9eBDG8IFzRBHAwe5N6lPeSGnRycYdCLr6oYWPnfBx/21uqXC8m4ytCx/yxGTVbcZ6iXgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpOPruNb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723592817; x=1755128817;
  h=date:from:to:cc:subject:message-id;
  bh=7vQK0vHaFwPYyhQesUTF0TSjKnO3CW6G6D1Wl0z1RTg=;
  b=dpOPruNbkLhQuLd9ew57KXz5HQ4DrBPPSaTTVGVrGmYEfQWfbrERaPg6
   8H+eZPPy13z5k3AsN3LOnAjsZFQ3LXMm/c3202yHpX7sSBZh0eqVq4Dnk
   2wHE4sMtJZw+7co4RlIAKU2SNH0tqnBH0RbnKt0GUxH0z5HDSHReLkT1q
   zTj6mrD5lOOkcHHjq+KJj8HbLcc9QbvS1hDrMv7EaGsVGKLrDnWnoL3bQ
   2vVbtrdQML1V9r0yODjpsWeXJX4BOstFhgG5EoF8MxBWm/GaMgHHtmsyH
   kfA69KFBKHrNs45T3fKMRdwHSyqirZysZ3mgEGYI1KNwL41Y8I3c2wYWF
   w==;
X-CSE-ConnectionGUID: PzQYX2+GTSi3ouo+7WjXsQ==
X-CSE-MsgGUID: 598s7NrhRPOgSgcm6EnMSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21653657"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21653657"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 16:46:57 -0700
X-CSE-ConnectionGUID: InGGE+kKTXS35fP5AH0QBA==
X-CSE-MsgGUID: Sw/HSetqSXKzyhvBhHE4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63493765"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2024 16:46:55 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1se1E5-0000mU-1h;
	Tue, 13 Aug 2024 23:46:53 +0000
Date: Wed, 14 Aug 2024 07:46:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1d00f3427bfdb9f5b7a817b1f4f44c5b02da3edd
Message-ID: <202408140736.5CCLjEyz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1d00f3427bfdb9f5b7a817b1f4f44c5b02da3edd  Merge branch into tip/master: 'x86/timers'

elapsed time: 1173m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240813   gcc-13.2.0
arc                   randconfig-002-20240813   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240813   gcc-14.1.0
arm                   randconfig-002-20240813   gcc-14.1.0
arm                   randconfig-003-20240813   gcc-14.1.0
arm                   randconfig-004-20240813   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240813   gcc-14.1.0
arm64                 randconfig-002-20240813   gcc-14.1.0
arm64                 randconfig-003-20240813   clang-20
arm64                 randconfig-004-20240813   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240813   gcc-14.1.0
csky                  randconfig-002-20240813   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240813   clang-20
hexagon               randconfig-002-20240813   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240813   gcc-12
i386         buildonly-randconfig-002-20240813   gcc-12
i386         buildonly-randconfig-003-20240813   gcc-12
i386         buildonly-randconfig-004-20240813   gcc-11
i386         buildonly-randconfig-005-20240813   clang-18
i386         buildonly-randconfig-006-20240813   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240813   gcc-12
i386                  randconfig-002-20240813   clang-18
i386                  randconfig-003-20240813   gcc-12
i386                  randconfig-004-20240813   gcc-12
i386                  randconfig-005-20240813   clang-18
i386                  randconfig-006-20240813   clang-18
i386                  randconfig-011-20240813   gcc-12
i386                  randconfig-012-20240813   gcc-12
i386                  randconfig-013-20240813   clang-18
i386                  randconfig-014-20240813   clang-18
i386                  randconfig-015-20240813   clang-18
i386                  randconfig-016-20240813   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240813   gcc-14.1.0
loongarch             randconfig-002-20240813   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240813   gcc-14.1.0
nios2                 randconfig-002-20240813   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240813   gcc-14.1.0
parisc                randconfig-002-20240813   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-002-20240813   gcc-14.1.0
powerpc               randconfig-003-20240813   gcc-14.1.0
powerpc64             randconfig-001-20240813   gcc-14.1.0
powerpc64             randconfig-002-20240813   gcc-14.1.0
powerpc64             randconfig-003-20240813   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240813   gcc-14.1.0
riscv                 randconfig-002-20240813   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240813   clang-20
s390                  randconfig-002-20240813   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240813   gcc-14.1.0
sh                    randconfig-002-20240813   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240813   gcc-14.1.0
sparc64               randconfig-002-20240813   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240813   gcc-12
um                    randconfig-002-20240813   clang-14
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240813   clang-18
x86_64       buildonly-randconfig-002-20240813   gcc-11
x86_64       buildonly-randconfig-003-20240813   clang-18
x86_64       buildonly-randconfig-004-20240813   gcc-12
x86_64       buildonly-randconfig-005-20240813   gcc-12
x86_64       buildonly-randconfig-006-20240813   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240813   gcc-12
x86_64                randconfig-002-20240813   clang-18
x86_64                randconfig-003-20240813   gcc-12
x86_64                randconfig-004-20240813   gcc-12
x86_64                randconfig-005-20240813   gcc-12
x86_64                randconfig-006-20240813   clang-18
x86_64                randconfig-011-20240813   gcc-12
x86_64                randconfig-012-20240813   gcc-12
x86_64                randconfig-013-20240813   gcc-12
x86_64                randconfig-014-20240813   gcc-11
x86_64                randconfig-015-20240813   gcc-11
x86_64                randconfig-016-20240813   gcc-12
x86_64                randconfig-071-20240813   clang-18
x86_64                randconfig-072-20240813   clang-18
x86_64                randconfig-073-20240813   gcc-11
x86_64                randconfig-074-20240813   gcc-12
x86_64                randconfig-075-20240813   gcc-12
x86_64                randconfig-076-20240813   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240813   gcc-14.1.0
xtensa                randconfig-002-20240813   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

