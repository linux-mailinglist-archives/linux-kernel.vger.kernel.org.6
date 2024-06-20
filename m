Return-Path: <linux-kernel+bounces-222661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E2910572
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9791F21732
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257671AE08A;
	Thu, 20 Jun 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er8bmFWI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD31ACE85
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888704; cv=none; b=SRvqawsPCgntyk2oBNhPwu4lMbQGIfoQZMbw6K3Om8UbAW2UqoHaFmjZhYCLvvsjNZCjTFKYLe1czDMJFp0NaWHAJEZUPqIA9AFZPHgOmEgte3gYIBdSpZxj67sK0LsVxqqKQIbBqnRMw6drnAB/w2AjV8xVTSMJ31MZjTlEg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888704; c=relaxed/simple;
	bh=2IAyNZnC98g3I3C/asGtHAo0qZn8Ytw+IP3P2W+a0IU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gbUebxWiu8KkiVIqm4sPufu8zDzS8WN0Cq0jHJZ+HgQr+VsvwdyY1x0gY+K7aad15VIx8o8sYgpjuDsC4CgvyZ6sIViMQp9b357cBXFjZxj5Vql+4HqsR3jTleQqHBnrq02KqruWGj8ZZCP7PPYOlYViVr83H8k/iaNrqmm5DEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Er8bmFWI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718888702; x=1750424702;
  h=date:from:to:cc:subject:message-id;
  bh=2IAyNZnC98g3I3C/asGtHAo0qZn8Ytw+IP3P2W+a0IU=;
  b=Er8bmFWI+bcXn+LYfVbqL+N7V/BNQMRN0CEfu+siybD2REpvv2xsX6aI
   uBcOZAYbxWIgw+nzF7NigwmQ3GGzD4XhQIgcdlTFFo6/IfhkWkElRQkBK
   WG42ytrBNVID4rkIA6umEWh1KciSd/2gXqNMqe+DTHG85c5BYFrLNaKc0
   z8PEn88HRz07N86MqdLSUp+vGf9JM4J8ZIdOaPsMElUr+VJC2hM/Ucw+r
   aGgh6dEjFhdtgzJTHpOYqnlK9EKAHGnZiNq4M6f6BOy7//qMY6AQ3Lpos
   SrJul6JssjHDZeMn1uqArX+H0JnpWxuQVmijhQ+VfvRK3XlvY3XTgaxjC
   A==;
X-CSE-ConnectionGUID: Xg5bswgNSwm0tPxYzZCdSw==
X-CSE-MsgGUID: 5F7pQS95SJSagrWhTiX3RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27283712"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="27283712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:05:02 -0700
X-CSE-ConnectionGUID: gnaYTiFjQvKOcGYsAQQbXg==
X-CSE-MsgGUID: Ea20yFmrQKGXzCc+LMFh7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42695742"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Jun 2024 06:05:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKHTG-0007cc-1N;
	Thu, 20 Jun 2024 13:04:58 +0000
Date: Thu, 20 Jun 2024 21:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 99ef9f59847cab1f9091cd4b9d7efbee0ae4fc86
Message-ID: <202406202155.OPN2VH7t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 99ef9f59847cab1f9091cd4b9d7efbee0ae4fc86  x86/sev: Allow non-VMPL0 execution when an SVSM is present

elapsed time: 3070m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240619   gcc-13.2.0
arc                   randconfig-002-20240619   gcc-13.2.0
arm                         assabet_defconfig   clang-15
arm                            hisi_defconfig   gcc-13.2.0
arm                   randconfig-001-20240619   clang-19
arm                   randconfig-002-20240619   clang-19
arm                   randconfig-003-20240619   clang-19
arm                   randconfig-004-20240619   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm                       versatile_defconfig   gcc-13.2.0
arm64                 randconfig-001-20240619   clang-19
arm64                 randconfig-002-20240619   clang-19
arm64                 randconfig-003-20240619   clang-19
arm64                 randconfig-004-20240619   clang-19
csky                  randconfig-001-20240619   gcc-13.2.0
csky                  randconfig-002-20240619   gcc-13.2.0
hexagon               randconfig-001-20240619   clang-15
hexagon               randconfig-002-20240619   clang-19
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch             randconfig-001-20240619   gcc-13.2.0
loongarch             randconfig-002-20240619   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
nios2                 randconfig-001-20240619   gcc-13.2.0
nios2                 randconfig-002-20240619   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240619   gcc-13.2.0
parisc                randconfig-002-20240619   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                     asp8347_defconfig   clang-17
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240619   gcc-13.2.0
powerpc               randconfig-002-20240619   clang-15
powerpc               randconfig-003-20240619   gcc-13.2.0
powerpc64             randconfig-001-20240619   gcc-13.2.0
powerpc64             randconfig-002-20240619   gcc-13.2.0
powerpc64             randconfig-003-20240619   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240619   clang-15
riscv                 randconfig-002-20240619   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240619   clang-19
s390                  randconfig-002-20240619   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                    randconfig-001-20240619   gcc-13.2.0
sh                    randconfig-002-20240619   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240619   gcc-13.2.0
sparc64               randconfig-002-20240619   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240619   clang-19
um                    randconfig-002-20240619   clang-19
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240619   clang-18
x86_64       buildonly-randconfig-002-20240619   clang-18
x86_64       buildonly-randconfig-003-20240619   gcc-11
x86_64       buildonly-randconfig-004-20240619   clang-18
x86_64       buildonly-randconfig-005-20240619   clang-18
x86_64       buildonly-randconfig-006-20240619   gcc-13
x86_64                randconfig-001-20240619   gcc-13
x86_64                randconfig-002-20240619   clang-18
x86_64                randconfig-003-20240619   gcc-8
x86_64                randconfig-004-20240619   clang-18
x86_64                randconfig-005-20240619   clang-18
x86_64                randconfig-006-20240619   gcc-13
x86_64                randconfig-011-20240619   gcc-13
x86_64                randconfig-012-20240619   gcc-13
x86_64                randconfig-013-20240619   gcc-13
x86_64                randconfig-014-20240619   clang-18
x86_64                randconfig-015-20240619   clang-18
x86_64                randconfig-016-20240619   gcc-11
x86_64                randconfig-071-20240619   clang-18
x86_64                randconfig-072-20240619   clang-18
x86_64                randconfig-073-20240619   gcc-9
x86_64                randconfig-074-20240619   gcc-9
x86_64                randconfig-075-20240619   clang-18
x86_64                randconfig-076-20240619   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                          iss_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240619   gcc-13.2.0
xtensa                randconfig-002-20240619   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

