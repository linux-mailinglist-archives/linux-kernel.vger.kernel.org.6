Return-Path: <linux-kernel+bounces-170440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEB8BD6D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC00CB22208
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3D15B553;
	Mon,  6 May 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlF0LSl2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95473EBB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030830; cv=none; b=KDV+M2sz3tQ/6FKG3UH7VI+8dj1NeQqY2AiB8Z7hon9TpiIVWj4mvJFePeGCyqnZ2S7SFljVNIO7fG6XtZ3Znb0PEE0/AzDbvFDT/fJyYsx+bWLfkN9zLdz/4KvnBHNs9vcv9Jka/Y0IwKSuyYF0GApfTlnVZlxrJ2/TtOiJyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030830; c=relaxed/simple;
	bh=M7ywp95SVgWD3WJ1kjqmTRxgovRaXyNEKPdOAzkhWtE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o4I7RCE5+OtaJvVuAbxZXLMH9zj50Q/sv+yha0jxLk/RUoXlO3DHX6lDhtq6pxlCt5HhOy6+/XG5jjpAWhjIdT2r4/7cjMU17hkZjvsVpJqA6hC/57ELv5uwJVdn1iDnqt4rOjzShSuFjWd0gt5icWcNYb6USqdJp4xYt52SU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlF0LSl2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715030829; x=1746566829;
  h=date:from:to:cc:subject:message-id;
  bh=M7ywp95SVgWD3WJ1kjqmTRxgovRaXyNEKPdOAzkhWtE=;
  b=hlF0LSl2OX451w02OZ9LpmosQAKwxHd86zBA/k7uQ5Kpdy8j1aOPF1zr
   m0av9C2Ad1ohPs1q3d4wop76Rd4lKCBVKq5lAWkWf0XLsrWwJjx4SE6Uu
   tcS0kcMCr+kcruEHPYms3KzxFaHahzN3eY6Ep0fy/gR4A1YBcudpP/Ir+
   xfcmXbMLKhDJ+25be/UT24LdrwE2BPF9XntPrWGkqpnxiU5uJjMjVX6SS
   BIYp7VC7yW4MPjUpoGKilXQTo9nUB68TPfzk0ZVBOu/CWTqCLB9WFR9E1
   T/+Q5iuAcTnfCfu4mQlUTOrMUqALmojebNC2RzvvXnS86c5bg8v+tS4YA
   w==;
X-CSE-ConnectionGUID: sxY3fGQ5RYeYkBYl4g9dHA==
X-CSE-MsgGUID: xWw6O6PQQi2WFkGrkwDuBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22202911"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="22202911"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 14:27:08 -0700
X-CSE-ConnectionGUID: 485EkaneTf+z22/Ogw5Otg==
X-CSE-MsgGUID: eQ3jxmohQoS2YE15q9TnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28259192"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2024 14:27:07 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s45rU-00013R-2f;
	Mon, 06 May 2024 21:27:04 +0000
Date: Tue, 07 May 2024 05:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47
Message-ID: <202405070523.xB4lPPwR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47  x86/microcode: Remove unused struct cpu_info_ctx

elapsed time: 733m

configs tested: 56
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

