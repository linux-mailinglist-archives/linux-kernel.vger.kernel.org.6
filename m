Return-Path: <linux-kernel+bounces-280764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B194CED2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7689A1C20DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D41922EA;
	Fri,  9 Aug 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHBFGQvr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22396191F7F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199926; cv=none; b=OMwk+S0oIh2drk8MjH8p6RCIwVX/CFwwcEkH+KAeHFNOf9RIiB+Gjub1jwV8VLm7FBQ9ybYX/XXgw8yJd/jwmbtKMt7eF9zfUyHPBbtVMVnzA8N16GniTe6t5O50f/QruZr5gMo3vqcwIL3+AU9QcnjRx7U02amCoYP0JC8/P7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199926; c=relaxed/simple;
	bh=lR+0eQsUPRC8ECzGEafiH06LADuIu1Uj7h8B8C+uhAY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fbqq7wiZRS0Tsbb6LZYN408w26l3MTeOnevkVwpsnL0fx38NceGOK9bEfNSbp99b16BlZ0/LEiME46Y/U5ijCNbGyYPwwTADryB8yQyKlFy/i3gIxBcEGHnMfG05lGn5v5YdQqyNcvTG45Fb1Xap2Dt9fXvr+5S2dCS6BDoxMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHBFGQvr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723199924; x=1754735924;
  h=date:from:to:cc:subject:message-id;
  bh=lR+0eQsUPRC8ECzGEafiH06LADuIu1Uj7h8B8C+uhAY=;
  b=LHBFGQvrO6MhGSPI46SkRilv9G5x4RePzDr63tuNkkWty5Q1hT8enRBa
   /sEnNI0gjoIFVitFudh6yVH9LPjiQCeqhnS2Ioo+CBqJICFJuLtvkyGf+
   SSUnsG2iCRuIMV8DYaGA2W2bdp9tOf01Xg6f0Cr4in7c1bYETKahFhWaO
   x76MsXKdS1F+cnaAIZOPrdpaQcQeDpLqHPnLtF3Ps2iKuf7LFkd2cPly2
   Y5LHWFb7WYweIBrcxnNMoBq5KRVips9ZEaVLpMDitUB2BFdTUZbBvnLiJ
   IVU6RyAZ5ts4Tc1BgAOeMXCEClTwTrocQwJwLYg8qaTchjnV9Q2HzvXhw
   A==;
X-CSE-ConnectionGUID: GSx+IMAuTC+76qrSBktZ5A==
X-CSE-MsgGUID: gciCP8LxQV+Y1pjUejA81A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21026284"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21026284"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 03:38:43 -0700
X-CSE-ConnectionGUID: 3/SwrlyuShuKwxy6fXDANw==
X-CSE-MsgGUID: RGb93fEYSBGMGeS8fIw8nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57487641"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 09 Aug 2024 03:38:43 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scN16-0007om-28;
	Fri, 09 Aug 2024 10:38:40 +0000
Date: Fri, 09 Aug 2024 18:38:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 919f18f961c03d6694aa726c514184f2311a4614
Message-ID: <202408091814.AYwr66xh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 919f18f961c03d6694aa726c514184f2311a4614  x86/mtrr: Check if fixed MTRRs exist before saving them

elapsed time: 1143m

configs tested: 35
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   clang-18
i386         buildonly-randconfig-003-20240809   gcc-11
i386         buildonly-randconfig-004-20240809   clang-18
i386         buildonly-randconfig-005-20240809   clang-18
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   clang-18
i386                  randconfig-003-20240809   clang-18
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   clang-18
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-11
i386                  randconfig-016-20240809   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240809   clang-18
x86_64       buildonly-randconfig-002-20240809   gcc-12
x86_64       buildonly-randconfig-003-20240809   gcc-12
x86_64       buildonly-randconfig-004-20240809   clang-18
x86_64       buildonly-randconfig-005-20240809   clang-18
x86_64       buildonly-randconfig-006-20240809   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240809   gcc-12
x86_64                randconfig-002-20240809   gcc-12
x86_64                randconfig-003-20240809   gcc-12
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

