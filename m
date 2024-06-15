Return-Path: <linux-kernel+bounces-215697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F179095F5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56AA1C212DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9459EAEB;
	Sat, 15 Jun 2024 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqeHn8xp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9FD502
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718424462; cv=none; b=FML10Nst8y7kOWJPhe/GIsmj0UA4996YWZWxowoBf2v29eu57XWgu1nvk2StikS9AItMXdFgpdRKfedwcnHTVuFr66ZKri7ZHalnVilfr1UsC0X4OmOc2tsXV3CdBgD8kliXXCvIzQPpNCT/ZZ2kUhgEGbd7geefPRotKHpmY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718424462; c=relaxed/simple;
	bh=y3c6h2tG9DxcPyjXhmiCjcvub1lzEr/UydsmZvaDtSQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FVT1uZyoUb4vzGlVPd/cFLDvjuK2iHYm/8ldMDrZscU8L2KxRqNQ5IFL1AlIALXestySTqAL4D7ZpEQLiK7W6Nlp6hlnEkoxxo8EVZbeMUGCl9IG048iRDuWbbjSKIp3cj2F9MdAWsHiuEgmPV6QpYfvdmwIz11pTwI2GHqS0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqeHn8xp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718424460; x=1749960460;
  h=date:from:to:cc:subject:message-id;
  bh=y3c6h2tG9DxcPyjXhmiCjcvub1lzEr/UydsmZvaDtSQ=;
  b=eqeHn8xp38/h/+gokSWEzVi5v9esw5ZLsr7WlJGy5No5BLMVjj2V7oNw
   7A4r9y3UVSGPWuGY1nNwJBH2gKR+iduUCu99HdrRqxwB0bRxWd/Irb0kP
   KQrLKr6zyxL15RAu2jMhZHQ/calh6KlSkj8Z4He5KUvhi55CS5eqPdxMX
   MQ1IP8QKjwOLtjYpyMzXwIs2vfRWEkXn5cCjxFfTh5pe5z7nIRkapEMM+
   b1HWg9D75hZl7+quqZcy6KOqSo/3Cwp9kZsUrd1dkf3J1SHr7/4AuXmw7
   F0IpeZWOlAA1AsSeRA95ohhaP2ofkt7f6yE2ysv1WwxpWWfRCKEHtqqyp
   w==;
X-CSE-ConnectionGUID: 2uO5GiV9TdaMLGTwzhXrtA==
X-CSE-MsgGUID: XTtuZhoITl2WB6epS5PX2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15556446"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="15556446"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 21:07:39 -0700
X-CSE-ConnectionGUID: ARmugajrTT2xrAo5L7SQoQ==
X-CSE-MsgGUID: GF6Cw/FlQZ65+aWunzJghA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="40794686"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Jun 2024 21:07:39 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIKhU-00026v-2B;
	Sat, 15 Jun 2024 04:07:36 +0000
Date: Sat, 15 Jun 2024 12:07:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b2747f108b8034271fd5289bd8f3a7003e0775a3
Message-ID: <202406151216.krC8YSE0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b2747f108b8034271fd5289bd8f3a7003e0775a3  x86/boot: Don't add the EFI stub to targets, again

elapsed time: 2587m

configs tested: 50
configs skipped: 213

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240614   clang-18
i386         buildonly-randconfig-002-20240614   clang-18
i386         buildonly-randconfig-003-20240614   gcc-12
i386         buildonly-randconfig-004-20240614   gcc-8
i386         buildonly-randconfig-005-20240614   gcc-13
i386         buildonly-randconfig-006-20240614   gcc-10
i386                                defconfig   clang-18
i386                  randconfig-001-20240614   gcc-13
i386                  randconfig-002-20240614   gcc-8
i386                  randconfig-003-20240614   gcc-13
i386                  randconfig-004-20240614   clang-18
i386                  randconfig-005-20240614   gcc-13
i386                  randconfig-006-20240614   gcc-10
i386                  randconfig-011-20240614   gcc-13
i386                  randconfig-012-20240614   clang-18
i386                  randconfig-013-20240614   gcc-13
i386                  randconfig-014-20240614   gcc-13
i386                  randconfig-015-20240614   clang-18
i386                  randconfig-016-20240614   clang-18
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240614   clang-18
x86_64       buildonly-randconfig-002-20240614   gcc-8
x86_64       buildonly-randconfig-003-20240614   clang-18
x86_64       buildonly-randconfig-004-20240614   gcc-8
x86_64       buildonly-randconfig-005-20240614   gcc-10
x86_64       buildonly-randconfig-006-20240614   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240614   clang-18
x86_64                randconfig-002-20240614   clang-18
x86_64                randconfig-003-20240614   clang-18
x86_64                randconfig-004-20240614   gcc-11
x86_64                randconfig-005-20240614   clang-18
x86_64                randconfig-006-20240614   clang-18
x86_64                randconfig-011-20240614   clang-18
x86_64                randconfig-012-20240614   clang-18
x86_64                randconfig-013-20240614   gcc-10
x86_64                randconfig-014-20240614   gcc-8
x86_64                randconfig-015-20240614   gcc-13
x86_64                randconfig-016-20240614   gcc-13
x86_64                randconfig-071-20240614   gcc-10
x86_64                randconfig-072-20240614   gcc-13
x86_64                randconfig-073-20240614   clang-18
x86_64                randconfig-074-20240614   gcc-10
x86_64                randconfig-075-20240614   gcc-13
x86_64                randconfig-076-20240614   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

