Return-Path: <linux-kernel+bounces-268433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B99942498
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F27284E44
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFA17BA9;
	Wed, 31 Jul 2024 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTNBRxQV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2335175BF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394216; cv=none; b=FgDFvSHIvAR0GCXEWXZOhwQ3LGFdw8GSqHLuSicQySe4mZ3CldIrj5qyWyQEyN5S/zI7Ml2m5YnKDf935vqRljEm+hghfj9f+HIlAB383YLZuc1QOrpm49wU6l26Yp/HPhDOclf9rOsYbbCP4tjMkOQZZAo7Vv+YPX8WgfE7LIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394216; c=relaxed/simple;
	bh=kF2XrtTCoWen7P7/ZlYUUWYvPYSUY9uyD5IOHa+GqDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DSQCXMJUtY0cJxr19Y0P0LuIiuXTjDorSyVJJ6QfOwNibz+K69rBuY6n9gkWfMZyJy2Qae4IJ0Q6UmW9SS5fKcwJULw0iRaj4Kqg5NN9UbIdo0t4H++grq/NyhiIbW8iKZs3aFs0S+h1kvEmL15uoJN+gQZGozGLyQQfP9fRX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTNBRxQV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722394215; x=1753930215;
  h=date:from:to:cc:subject:message-id;
  bh=kF2XrtTCoWen7P7/ZlYUUWYvPYSUY9uyD5IOHa+GqDY=;
  b=fTNBRxQVzuWPGKor0bPwX/fd0qIK8SryDCQagCHhW5FI+YbDfwrXyUHN
   Fe14HLP9IvvBUkn0tzx2vO7pHxEWO7IarFLtKhKbWyuVbPOiHzSoN8Li7
   qTPK4UmUuQVx5dd9JxpBP49P0DXu6qfmYlFS7rDQJUPBHmGnJKWZQrA0a
   u/BQECZeZuFCnMohRxckhf1Nut8jcMzvxedQr5ZZG4dCHm0hZXu6X9Nvn
   nzogt1g8MM1nW+UmNNTPYAWVAiefi5jKojydBrTZmxsY0yeGBq/rq42GS
   feAb0Sq1xi1OKGr4NE/WHRg0iWrFPaW742EYXRkbi2RH9CakGks2wxUh4
   g==;
X-CSE-ConnectionGUID: gF+NJUjBR5G8Exj1bsA22Q==
X-CSE-MsgGUID: QSEmLP8LQaSQDG4eSJZ8sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20406550"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20406550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 19:50:12 -0700
X-CSE-ConnectionGUID: xPe2GF78QzajilUA9e+mTA==
X-CSE-MsgGUID: WZQuAJ5yTTGInLlSmw1XYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="59615601"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Jul 2024 19:50:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYzPk-000tfK-1h;
	Wed, 31 Jul 2024 02:50:08 +0000
Date: Wed, 31 Jul 2024 10:49:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 5343558a868e7e635b40baa2e46bf53df1a2d131
Message-ID: <202407311022.xog4hhXQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 5343558a868e7e635b40baa2e46bf53df1a2d131  x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang false positive

elapsed time: 740m

configs tested: 32
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240731   clang-18
i386         buildonly-randconfig-002-20240731   clang-18
i386         buildonly-randconfig-003-20240731   clang-18
i386         buildonly-randconfig-004-20240731   gcc-13
i386         buildonly-randconfig-005-20240731   clang-18
i386         buildonly-randconfig-006-20240731   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240731   gcc-13
i386                  randconfig-002-20240731   clang-18
i386                  randconfig-003-20240731   clang-18
i386                  randconfig-004-20240731   clang-18
i386                  randconfig-005-20240731   gcc-13
i386                  randconfig-006-20240731   clang-18
i386                  randconfig-011-20240731   gcc-12
i386                  randconfig-012-20240731   gcc-13
i386                  randconfig-013-20240731   clang-18
i386                  randconfig-014-20240731   gcc-8
i386                  randconfig-015-20240731   gcc-10
i386                  randconfig-016-20240731   gcc-13
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
s390                              allnoconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

