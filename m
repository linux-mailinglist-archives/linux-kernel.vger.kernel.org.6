Return-Path: <linux-kernel+bounces-186736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE28CC829
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455711C20C47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB11459E5;
	Wed, 22 May 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="docTZudA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4231BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413486; cv=none; b=JrLnSGK1m0FiohwSzhIUnqksI5vVfVtBlZ6HoMJc7IeGSrm1GFMDwYx4GshmjDNVVjs3hiI31486pkuZQLT/lTuXPRv7VQEzG286WPcsPHuPUWyCoCOOmN/wiJtlnc4sVWS9ZGJJloPv+3ToV2HZAZMFcqrCxDLC+CLAROBgxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413486; c=relaxed/simple;
	bh=g2nTVwsIJfr+OHQ6TJQ+lsi1EVCjwLAkeXQUQwaecjw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VN0iSkSe1W3sNfS2VMYeFPIoxYegqgGpm4FjgYwt3a3//+LZMSy4tM2hInirQFPkswAG4M280lwzYsMHS+d97JBFQCGUVhlYsV2V3dUjhC2Td01GYnqDgCIybGU3UOFUeZBd+QcKkHKA1HNK1QGHc2/RSasrdJgAms0QO4WCmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=docTZudA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716413484; x=1747949484;
  h=date:from:to:cc:subject:message-id;
  bh=g2nTVwsIJfr+OHQ6TJQ+lsi1EVCjwLAkeXQUQwaecjw=;
  b=docTZudAXyZDrBBz29WNNJ7V4HkdHM3rmxpklQ0J2zD9IP54XnRq2WPV
   a/a2kzcnsVSEXA5j/vKKNb/By101UWfosjTd4kG9t+CCODr+LsZJt9A1m
   Dh07WKS3H55Q5kiXtWCKtXTybBTupxIiGMQ9G+oRymvTIPxBZLx3kyn4N
   5wCoabwKb2aArZzThJCnlXF4e27EZeAdZrCyVkZQrIpGf9ZGAw7YabVcB
   5KpSRGQlbpunhEwFqGTv1hpK+INQRtIJqZ4gkWCUEYiScoNIVkSH8KfxV
   wvg0zOzCq+cmRB+iRBEQS0eg+z/gdUmfDMan6gWHJhnRnsuwVC8+jTX4J
   Q==;
X-CSE-ConnectionGUID: 0MGLtLLQRX2KF9FOJOgcKg==
X-CSE-MsgGUID: T97RMAcQTqOjOAvNYP+jeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30227310"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30227310"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 14:31:24 -0700
X-CSE-ConnectionGUID: fQ6ncwTGSmSPusnyKCHtPw==
X-CSE-MsgGUID: fcaT0BZ1Q1yoqfnUNAq06A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33331402"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 May 2024 14:31:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9tYO-00023B-2z;
	Wed, 22 May 2024 21:31:20 +0000
Date: Thu, 23 May 2024 05:31:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 52cccc64cf7c90696d09d54a383793804ba872ba
Message-ID: <202405230509.EVpHdRuz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 52cccc64cf7c90696d09d54a383793804ba872ba  x86/boot: Clean up the arch/x86/boot/main.c code a bit

elapsed time: 818m

configs tested: 50
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240522   clang
x86_64       buildonly-randconfig-002-20240522   gcc  
x86_64       buildonly-randconfig-003-20240522   clang
x86_64       buildonly-randconfig-004-20240522   gcc  
x86_64       buildonly-randconfig-005-20240522   clang
x86_64       buildonly-randconfig-006-20240522   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240522   gcc  
x86_64                randconfig-002-20240522   clang
x86_64                randconfig-003-20240522   gcc  
x86_64                randconfig-004-20240522   gcc  
x86_64                randconfig-005-20240522   gcc  
x86_64                randconfig-006-20240522   clang
x86_64                randconfig-011-20240522   gcc  
x86_64                randconfig-012-20240522   clang
x86_64                randconfig-013-20240522   gcc  
x86_64                randconfig-014-20240522   clang
x86_64                randconfig-015-20240522   gcc  
x86_64                randconfig-016-20240522   gcc  
x86_64                randconfig-071-20240522   clang
x86_64                randconfig-072-20240522   clang
x86_64                randconfig-073-20240522   gcc  
x86_64                randconfig-074-20240522   clang
x86_64                randconfig-075-20240522   clang
x86_64                randconfig-076-20240522   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

