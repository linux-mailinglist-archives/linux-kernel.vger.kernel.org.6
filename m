Return-Path: <linux-kernel+bounces-255929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA49346BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE387B21A50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E437144;
	Thu, 18 Jul 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yyn81LMB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B342837B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273413; cv=none; b=O9IaNDXzs0Sp3QIrNu6i9L3XyKpjYGEzw435CoG6QNI/7z6FOBjRSao/NsntGI2CSWBTlI/+d5wRa2hWyB+g/cwN3NpG4cagCejwrzRb4XysH5LyOZx+qdc/kg9lX7gM0uj3wUF4wAdf+mv2mV+4vxIBZvqU29iXvsMKNDyhH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273413; c=relaxed/simple;
	bh=e7aqxENTZwpJUR1rHEzvxWfw7/7CguTULKYsJZYPlqE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LVsXeTSqITaS3lg2qfMLgZ3dzMvhz9qDngNSxMAOr91yxm18XIST6Mq9H281Vc5aFHvdZCupGbgcgnGF+X6gGWd0Rjat+RmL+79hcl1CXUd7AKFrY4eeXOctxYWpp5Y5CIO1E/yCphAwWj/03l6DKM0EeBzD2SL5Ij82lHHvN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yyn81LMB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721273411; x=1752809411;
  h=date:from:to:cc:subject:message-id;
  bh=e7aqxENTZwpJUR1rHEzvxWfw7/7CguTULKYsJZYPlqE=;
  b=Yyn81LMBNzWk2YFuv+cBj+MRYErjWvy52CzJ6Xg0bFXWEXelV/NhYuCj
   Wr24uz1T0shfDRCDpYt4+g0mE/VNOsynnoPyL4bex9R+QmJYTLVV4Zbp8
   vA/oZ0qsanX1i44tsJlUCgzuvF3sQIBuU94SjfS6UN3gp2Bscqj8jP2Uw
   bv18vymhhaBHt7enfec0xlrQI2NCUy61jsdOs9MhOgj9L8koJ15hkwUib
   p+HkXc4fvxMZslDcjb82j2A1p2bbc2Wt1QMpEnoqYmUHMCoFSa5t2QzBs
   nkoq2KEUAPqCs2aJn8xPNS2xik2hohwKY4n+imesCe3sxGGZEAr0DYpQd
   g==;
X-CSE-ConnectionGUID: uOyAG7d8SdCRD+1Xh+Ib3g==
X-CSE-MsgGUID: DpVNMeesTKCO3fFVpctYMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18949873"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="18949873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 20:30:10 -0700
X-CSE-ConnectionGUID: p1MeVWc+SQK1i9TGndBQzw==
X-CSE-MsgGUID: cZM79tUvQruK9Svzhs3gcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="50379619"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2024 20:30:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUHqJ-000gus-32;
	Thu, 18 Jul 2024 03:30:07 +0000
Date: Thu, 18 Jul 2024 11:30:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 dce2a224763ce968445e14c43b49321936309c75
Message-ID: <202407181157.sUMqMd4t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: dce2a224763ce968445e14c43b49321936309c75  locking/atomic/x86: Redeclare x86_32 arch_atomic64_{add,sub}() as void

elapsed time: 728m

configs tested: 44
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-016-20240718   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   clang-18
x86_64       buildonly-randconfig-003-20240718   clang-18
x86_64       buildonly-randconfig-004-20240718   clang-18
x86_64       buildonly-randconfig-005-20240718   clang-18
x86_64       buildonly-randconfig-006-20240718   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-13
x86_64                randconfig-002-20240718   gcc-13
x86_64                randconfig-003-20240718   clang-18
x86_64                randconfig-004-20240718   gcc-13
x86_64                randconfig-005-20240718   clang-18
x86_64                randconfig-006-20240718   clang-18
x86_64                randconfig-011-20240718   clang-18
x86_64                randconfig-012-20240718   gcc-9
x86_64                randconfig-013-20240718   clang-18
x86_64                randconfig-014-20240718   clang-18
x86_64                randconfig-015-20240718   clang-18
x86_64                randconfig-016-20240718   clang-18
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

