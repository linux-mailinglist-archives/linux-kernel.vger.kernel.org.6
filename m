Return-Path: <linux-kernel+bounces-185699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD08CB903
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F7AB21EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F58339A8;
	Wed, 22 May 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpx3mrnv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E01168DA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345889; cv=none; b=d8DboIMMfp67vu9vyVIbMg9Ss1XyauBnJpLTIIN0bkpcxund+xgVeh1IR4aWlgT99lMzxJOp3r0IzpwLuMmM0eGNuP0yj1tG6CXu2mZf9U66puSaljv9ZUnbjUxE3LvphykpyOQ90ZETP8mg1kXtT4slBQlFZMGNmjElsuFoFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345889; c=relaxed/simple;
	bh=huhjTH5GzNM7RVVLwwLnShp+NRi1N4SW8y0eQ50p21I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NOX2pX/tUUTMtRKyvPg03qjPe8iUGB0zMjor/XpDIeOfFIdkhLzcnWJD8NcJSTZuKF8Ex2IKj8X7RUYnkR2i4LhFv1KGurD4kGcNvAT/OKP2TvFYTleD5oGQwbYylDpiICqFDmp/+pjKxxJMXuLlbzqDApKxXG9drcyiUI+dNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpx3mrnv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716345887; x=1747881887;
  h=date:from:to:cc:subject:message-id;
  bh=huhjTH5GzNM7RVVLwwLnShp+NRi1N4SW8y0eQ50p21I=;
  b=Qpx3mrnv4cZJWyO/owPCAJE5Cg8y1jg3Sz/+yQ5/zjQKJejDKa7eJkpD
   VPHNqB0UL9HVdaIQ8Zyr3GpxWDEqebzssRPJzdev6pPlAbLZQdr6QtwkZ
   OEruiiaN3qiGJ+XPVhQm8vfP2+L06/KYSLzFcYk4v2Zn66Loet6/evxSu
   h4VFWNcrSyoSb0UyinA2GZ0wdB0MaNEmL4lB+ge9sileZkmaw4Ailu6x0
   LcZaqVM3dRUqR1DjnpRxbFcCfpzC5q161/TnKUtrA6/z/GlnSffUWBtj2
   X+TGsC3TCN3RehtUeFtFS6z09185imFKjTbxtMJxuKQrKc6brD/Tr6/Jj
   g==;
X-CSE-ConnectionGUID: misbYX1KRteknLLFSswSGQ==
X-CSE-MsgGUID: tf42JtjGQvmMRRP8LuQeSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12686945"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12686945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 19:44:47 -0700
X-CSE-ConnectionGUID: RWqxMgYQTCSzM/FZvp/fHQ==
X-CSE-MsgGUID: 50GvMBB0RrO1KkJx9R53Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33552738"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2024 19:44:46 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9by6-0000xv-1y;
	Wed, 22 May 2024 02:44:42 +0000
Date: Wed, 22 May 2024 10:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9d22c96316ac59ed38e80920c698fed38717b91b
Message-ID: <202405221055.i7h3ifZq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9d22c96316ac59ed38e80920c698fed38717b91b  x86/topology: Handle bogus ACPI tables correctly

elapsed time: 726m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

