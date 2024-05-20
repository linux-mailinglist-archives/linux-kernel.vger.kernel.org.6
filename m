Return-Path: <linux-kernel+bounces-184143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2B8CA319
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6126A1C215DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24A138486;
	Mon, 20 May 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mlx5pXAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349718EB1
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235467; cv=none; b=tTmDcydsnsd9kNYLuC3v0LNBDQfPl+ZYZx/zxoiv8AtlxHJNqvSXkiaf37v2xT593iiixFy4TMiCjpm6xh+S2Vk17AYa1WwRpkLnV6MR84nW+qyKOJPTqjliP7F5pWLjLh/EqhJIavOfjz/S+57sgDljEHYuYKZ+EkuqDWpSksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235467; c=relaxed/simple;
	bh=gE0jJbfeL8Rptb3Y0r70A2PZVj+MXTnaFUlk5wpYuN0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k3qfyKHj5Y1inQJxGf2amHYRrSK/6s3KqShHCulvmgAMfC6LBmm9k7iySj46CAYuBqAIixavhQsOUbU/KJHU9a/d31BjvzLxOXzPLUPmOoHVA9EEtJ+RjzGmT1+Kmmh8qSBq1/KDs4Y7Iig9O+F/ilD/oNiCEKOEQCpl2K+cG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mlx5pXAp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716235465; x=1747771465;
  h=date:from:to:cc:subject:message-id;
  bh=gE0jJbfeL8Rptb3Y0r70A2PZVj+MXTnaFUlk5wpYuN0=;
  b=Mlx5pXApflFt0o9O+x7zpvW0uinV51HTs/mGe0LqfK6C8k215poAA01C
   kOzNHn4Q8HmqnjWakHMcHyEre3J2R9TIqVUUyihKkwmuEF31o25ABJ+vk
   DgTo5bBuz9zgMC2Lk5r23XpJRU3nkJcMArmxeYHVGoMhQVcY61I4S3+Rn
   J6RkMtBWok5c2GWi3jopCQsHx9a1DV+k9VwkXuorOYVsmfgTZoSCm7rxq
   KhGzV2Szwqr4no9HHAjVljf1c3suupBQFz2lEyWIG9/IRA/qv20MgwCye
   U7khL9DrYJIIW7gjF381RC6DL8PwuMNTg0cKjp85rS8L58lfWiAqUnFfa
   g==;
X-CSE-ConnectionGUID: uZxkWJw2SCm8DTeckHHH/Q==
X-CSE-MsgGUID: 95HuAkwwSDWobMmLJCql0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12612334"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12612334"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 13:04:24 -0700
X-CSE-ConnectionGUID: uOE7AkDQSXu70/y8Erw9OQ==
X-CSE-MsgGUID: lrHVJQnKQpe+7rCn1X4hcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32561814"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2024 13:04:23 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s99ES-00057A-3A;
	Mon, 20 May 2024 20:04:08 +0000
Date: Tue, 21 May 2024 04:02:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 73e1bdc9383b59de5d9770f11aef67e7ef9105c4
Message-ID: <202405210432.54QIWejb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 73e1bdc9383b59de5d9770f11aef67e7ef9105c4  Merge branch into tip/master: 'x86/percpu'

elapsed time: 728m

configs tested: 50
configs skipped: 149

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240520   clang
i386         buildonly-randconfig-002-20240520   clang
i386         buildonly-randconfig-003-20240520   clang
i386         buildonly-randconfig-004-20240520   clang
i386         buildonly-randconfig-005-20240520   clang
i386         buildonly-randconfig-006-20240520   clang
i386                                defconfig   clang
i386                  randconfig-001-20240520   clang
i386                  randconfig-002-20240520   clang
i386                  randconfig-003-20240520   gcc  
i386                  randconfig-004-20240520   gcc  
i386                  randconfig-005-20240520   clang
i386                  randconfig-006-20240520   gcc  
i386                  randconfig-011-20240520   gcc  
i386                  randconfig-012-20240520   gcc  
i386                  randconfig-013-20240520   clang
i386                  randconfig-014-20240520   gcc  
i386                  randconfig-015-20240520   clang
i386                  randconfig-016-20240520   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240520   clang
x86_64       buildonly-randconfig-002-20240520   gcc  
x86_64       buildonly-randconfig-003-20240520   gcc  
x86_64       buildonly-randconfig-004-20240520   gcc  
x86_64       buildonly-randconfig-005-20240520   gcc  
x86_64       buildonly-randconfig-006-20240520   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240520   clang
x86_64                randconfig-002-20240520   gcc  
x86_64                randconfig-003-20240520   gcc  
x86_64                randconfig-004-20240520   gcc  
x86_64                randconfig-005-20240520   gcc  
x86_64                randconfig-006-20240520   clang
x86_64                randconfig-011-20240520   clang
x86_64                randconfig-012-20240520   gcc  
x86_64                randconfig-013-20240520   clang
x86_64                randconfig-014-20240520   clang
x86_64                randconfig-015-20240520   gcc  
x86_64                randconfig-016-20240520   gcc  
x86_64                randconfig-071-20240520   clang
x86_64                randconfig-072-20240520   gcc  
x86_64                randconfig-073-20240520   clang
x86_64                randconfig-074-20240520   gcc  
x86_64                randconfig-075-20240520   clang
x86_64                randconfig-076-20240520   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

