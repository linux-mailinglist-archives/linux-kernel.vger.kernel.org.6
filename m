Return-Path: <linux-kernel+bounces-379121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB19ADA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FCB1F2021D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E100158546;
	Thu, 24 Oct 2024 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWE96jH4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29242A8A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739614; cv=none; b=mo9W9RVGTZbp9p9G+2CEiCVCo+AVoLXhqv5EG9/ENYxezKgvdoQ70BOKIi8w8hHLeSJFHgSGX3thji4VfHHTHQn5qoqfVLDbdCKsnJclgE4OYoJ3GStrEW6te8eHr9GneSPOFvMhFY3HB6AH5/r1ZoS38meTfJcr1v0xgwItPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739614; c=relaxed/simple;
	bh=HlyBFHyv9hsQPPn+8YHCz9N5cAhzFqasCkuhwzeYXvs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RC8yle/tpdfqS+X3lT1ANA33pJq5I0gFS6hITGc1LBbrppQRjDNikMjmE4DjDsyS7IRenYfJ38n/RGBC51mdAegA8Aoq8SNFx8xvdTd0QBlKV/TppzdIl7S+gD3wH6cgK/5xyIq3s92sCxypjm0cEgMIdwUYe8XyXZrFXgB4FXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWE96jH4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729739613; x=1761275613;
  h=date:from:to:cc:subject:message-id;
  bh=HlyBFHyv9hsQPPn+8YHCz9N5cAhzFqasCkuhwzeYXvs=;
  b=NWE96jH49AWs1WSPYgKS1Ca2GTcyKQOW2R9zwDjeMivd/IKMlEMCA52b
   NS6R7/C395CU1TdMYksqo3BjXGybJ/LE5drk9bWYb0IbkOw6wj6JuYlb8
   leJQjyIlCKvn4aprP/x98tz8wOQglIDAE0pKkkapUL+84aUSQO2gKfuuk
   qGcRKTltToX/HAgBhJJZt96NR9Sk85v2BNDtdT5kHBad+lHeGNxa/Br1h
   NzuIfwMNw+4OrgjBQZijMU+TfGQMzxPqpkLveK+vAuSYJiHDXqEKHotIu
   VgtA2ym4BWNb07OUaqQzOeAdK238y89wHQrV3zQbniTeTHda8eRaqwmQq
   A==;
X-CSE-ConnectionGUID: m6kMEIEmTauUjqA7hFJmBA==
X-CSE-MsgGUID: r/yWKwqVRHuikQ/oiiknVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33158229"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33158229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:13:32 -0700
X-CSE-ConnectionGUID: tCwvYTd5RwypaipU+Jc6Tg==
X-CSE-MsgGUID: i2z3balZSiavEgXqOaxU6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80873754"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Oct 2024 20:13:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3oHx-000Vs6-0a;
	Thu, 24 Oct 2024 03:13:29 +0000
Date: Thu, 24 Oct 2024 11:12:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 88a921aa3c6b006160d6a46a231b8b32227e8196
Message-ID: <202410241140.4DVdsHvv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 88a921aa3c6b006160d6a46a231b8b32227e8196  x86/sev: Ensure that RMP table fixups are reserved

elapsed time: 933m

configs tested: 64
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.1.0
arc                        allmodconfig    clang-20
arc                         allnoconfig    gcc-14.1.0
arc                        allyesconfig    clang-20
arc              vdk_hs38_smp_defconfig    gcc-14.1.0
arm                        allmodconfig    clang-20
arm                         allnoconfig    gcc-14.1.0
arm                        allyesconfig    clang-20
arm                  spear3xx_defconfig    gcc-14.1.0
arm                     stm32_defconfig    gcc-14.1.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.1.0
csky                       alldefconfig    gcc-14.1.0
csky                        allnoconfig    gcc-14.1.0
csky                          defconfig    gcc-14.1.0
hexagon                     allnoconfig    gcc-14.1.0
i386                       allmodconfig    clang-18
i386                       allmodconfig    gcc-12
i386                        allnoconfig    clang-18
i386                        allnoconfig    gcc-12
i386                       allyesconfig    clang-18
i386                       allyesconfig    gcc-12
i386                          defconfig    clang-18
loongarch                  allmodconfig    gcc-14.1.0
loongarch                   allnoconfig    gcc-14.1.0
m68k                       allmodconfig    gcc-14.1.0
m68k                        allnoconfig    gcc-14.1.0
m68k                       allyesconfig    gcc-14.1.0
m68k                  m5272c3_defconfig    gcc-14.1.0
m68k                 m5275evb_defconfig    gcc-14.1.0
m68k                     virt_defconfig    gcc-14.1.0
microblaze                 allmodconfig    gcc-14.1.0
microblaze                  allnoconfig    gcc-14.1.0
microblaze                 allyesconfig    gcc-14.1.0
mips                        allnoconfig    gcc-14.1.0
nios2                       allnoconfig    gcc-14.1.0
openrisc                    allnoconfig    clang-20
parisc                      allnoconfig    clang-20
powerpc                     allnoconfig    clang-20
powerpc                mgcoge_defconfig    gcc-14.1.0
powerpc         mpc834x_itxgp_defconfig    gcc-14.1.0
riscv                       allnoconfig    clang-20
s390                       allmodconfig    gcc-14.1.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.1.0
sh                         allmodconfig    gcc-14.1.0
sh                          allnoconfig    gcc-14.1.0
sh                         allyesconfig    gcc-14.1.0
sh          ecovec24-romimage_defconfig    gcc-14.1.0
sh                  edosk7760_defconfig    gcc-14.1.0
sh                     se7712_defconfig    gcc-14.1.0
sh                     se7751_defconfig    gcc-14.1.0
sh             sh7724_generic_defconfig    gcc-14.1.0
sparc                      allmodconfig    gcc-14.1.0
um                          allnoconfig    clang-20
x86_64                      allnoconfig    clang-18
x86_64                     allyesconfig    clang-18
x86_64                        defconfig    clang-18
x86_64                        defconfig    gcc-11
x86_64                            kexec    clang-18
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
xtensa                      allnoconfig    gcc-14.1.0
xtensa            cadence_csp_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

