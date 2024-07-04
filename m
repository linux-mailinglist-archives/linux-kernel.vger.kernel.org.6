Return-Path: <linux-kernel+bounces-240397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A0926D32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9970B21659
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F04DDA9;
	Thu,  4 Jul 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCrs/P+5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5BBE5E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057539; cv=none; b=ecq2EjPqjxKuNe8n+8m29Tq9PZbWJ7h05adtnAcXis0az42gJgmKlC/zGJbJYPcpx4GPhBBjxwdcnEU8rkyBtX/hYpdyK+WcaNdjdyob8QjjEH+SFKvmSzpLeiOsn+b7eMpFwhLDUVDVbtnqtQ+W8j6jw+0CfQz1WAmHtjJNRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057539; c=relaxed/simple;
	bh=oXdyRexVCrhXbXlDzI/l8sgojHJcocB5TR9jofRyogQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uUg9kBgHA/Ei7Iqb3BBnLNMD9GMN/zBZTpktjPHzuO3SRvwzZ/uf7OkfcyxSGCMedk3rXMht3Pwt5fik6Ga48f/iO2eiN4k3mxeoQepVSAGzIU4XOXo7v9SBaJM0ZqME/B9VTfxFnTfn2LwAdSiDArO/eWN9Q8oyQ3dq+RIZ1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCrs/P+5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720057538; x=1751593538;
  h=date:from:to:cc:subject:message-id;
  bh=oXdyRexVCrhXbXlDzI/l8sgojHJcocB5TR9jofRyogQ=;
  b=fCrs/P+5mBcCgUYAwJYzN19oZx3vLmtbHI5XlQ9OUrzQQ8Z6Rx7fpqLo
   Y6UdRHuN9cwt3QbJWucYP9CyWjOSfP9f2iI+aifQ/M8sHP+t0DJvPdSs2
   wF/UIZZrFfF4QzWLt/SWDoOAuVAXQUa78YdO9VBnTrVRajNLB67F6897Z
   ZKO/owKeqzSroJuz181U7AVGfdaeDs1DlvEfiJNNkqY8VXu/DBcdXcsgY
   x1K4fkMitbelzmWga7goVlzvjIVsGU/PwXYHXOR9oEHrl3rlBju7I8tzn
   tryoXkaa4GyB3XGq8o4DEWb2Xj96c4WoIl+XMkhFMlJf6gJ9i5Eg1LQ87
   A==;
X-CSE-ConnectionGUID: /apw2lTCSpe3Z02rTybDCA==
X-CSE-MsgGUID: s8aAhIMNS4C9g8RMravI6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="34856884"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="34856884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:45:37 -0700
X-CSE-ConnectionGUID: ckLPEp5JQpmEiyAm3SLNxQ==
X-CSE-MsgGUID: wEQNpLdST5WiYCtprxT/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46452515"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jul 2024 18:45:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPBXS-000QPm-22;
	Thu, 04 Jul 2024 01:45:34 +0000
Date: Thu, 04 Jul 2024 09:45:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ac8b270b61d48fcc61f052097777e3b5e11591e0
Message-ID: <202407040928.QSEmpENb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ac8b270b61d48fcc61f052097777e3b5e11591e0  x86/bhi: Avoid warning in #DB handler due to BHI mitigation

elapsed time: 743m

configs tested: 59
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386                                defconfig   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                          atari_defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
powerpc                      ppc40x_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

