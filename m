Return-Path: <linux-kernel+bounces-181632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3328F8C7EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675FB1C21BED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775E29408;
	Thu, 16 May 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJIsdsa0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1F2C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901433; cv=none; b=YGjpctC8DKcMHw+SD3w0kJ1EqRvI8ItNRBBoeJwe69ZPQBfoDFDtSZVuIMdtyLeYVW1gQCHY29rQ4ys4p4zX1Zqk7mk7pe3cvvn9M/kYbhOCX+unIxznXLNKM8viRhJpLRzLjkram/ySBmjW71bh5rWu0YuiTrEaUBlGmQLYLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901433; c=relaxed/simple;
	bh=z7voH0moxdcPyah/TqaRgaWG7jsQPseldExHTSgquyg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I6xwUJAqn/CY7BvRgwSNxciQbUnyGNCKbeiH9wJB8bAW2uYVPUMZbiFQJUpR2ZBGmLa4VQXgWdtwNjCno1BOXRtDoGBThN/loXOhpYaNzJOq6fWYHiU5sbUBJpW5YN0P4+d9NRF5mZn6mOiJlGNTGMW8U5i0QS9rHleE/v4loQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJIsdsa0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715901432; x=1747437432;
  h=date:from:to:cc:subject:message-id;
  bh=z7voH0moxdcPyah/TqaRgaWG7jsQPseldExHTSgquyg=;
  b=MJIsdsa0XmLgbPSfnphGvoLdxLLr2uNCH853YIoYAQhnWf8fquE2oOQu
   B4u903Mun6jKjE9cIYWJF36JJdYKyLsD/N/UtjD6bZBuwU+owt6jB0uO9
   Iz5eO7UEr3jFST/TipLPocqyXfYTKYc/d/rmWoS2NFDhvnXoS/BBm1dSd
   Z9qPXV4KHH5zUawoPFOmG99ZPfDn0499MDK+QRMEBm6vC171fxhV8aY6f
   sMJlOOFMMvfVAqDVDMFX7eeNNxEOrd9SqsVvnp70BChMOPfQVJwpcDCaH
   HkIWZSzAfzs+Lff+NWaL4uAu2fOVfK2Dn6PZYaVbUSPceQBp4k2mEgwzE
   g==;
X-CSE-ConnectionGUID: 2wn+jwkdSuqjQpGeAhuetw==
X-CSE-MsgGUID: AF8esCTwTNW6TmXt8qaGhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11564325"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11564325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 16:17:11 -0700
X-CSE-ConnectionGUID: sGzEMS0oSeWerDdD5Odn5A==
X-CSE-MsgGUID: 8idRZKV/Rg6b455UohZtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36047875"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2024 16:17:10 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7kLU-000Ey9-0q;
	Thu, 16 May 2024 23:17:08 +0000
Date: Fri, 17 May 2024 07:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 dd0716c2b87792ebea30864e7ad1df461d4c1525
Message-ID: <202405170739.dheuM0s1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: dd0716c2b87792ebea30864e7ad1df461d4c1525  x86/boot: Add a fallthrough annotation

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405162054.ryP73vy1-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/x86/boot/printf.c:257:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-buildonly-randconfig-001-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-buildonly-randconfig-002-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-buildonly-randconfig-003-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-defconfig
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-003-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-004-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-005-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-006-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-013-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-141-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-allnoconfig
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-allyesconfig
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-161-20240516
|   `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels
`-- x86_64-rhel-8.3-rust
    `-- arch-x86-boot-printf.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 740m

configs tested: 26
configs skipped: 134

tested configs:
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
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

