Return-Path: <linux-kernel+bounces-186856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF78CCA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3101F21C36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42237E;
	Thu, 23 May 2024 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgnW6zNB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AED6FA8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716422715; cv=none; b=Ln5AhgOOpmuDfMR6fvCK9mqU5kGYjZjNe7QbK7NiDf46n5S/ll16yPK4RhAvh9rvs10OnsBj3qZv7GhqdLXsLErrkPJVzHXE+9pRW0BPeKEHE2LIZjVLcZ/8SbOk6wKK362IaLi1XRvYAD08aA5BNXpgRKyyFPQivdU1Bk+V3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716422715; c=relaxed/simple;
	bh=lDviXl1nKOdVCZCMFZaJWVgTwpp7lqGfBNbXHh1tCX4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nipq38mN/NscPsYdZgBEO+iYmEUaHh0puiIp0ezoMvW1SW5xv8WzfA4T5UYRKn6AifAfCwCGvq0N728wzwlpbXva/k71ujq2SfZArKruu/6fDLGLrRlFqJEdfSWDe2Q6DJ7VWwyHkVYa1E5l+8PZjPwtMA03bEOQ2i7KeZBRYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgnW6zNB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716422714; x=1747958714;
  h=date:from:to:cc:subject:message-id;
  bh=lDviXl1nKOdVCZCMFZaJWVgTwpp7lqGfBNbXHh1tCX4=;
  b=AgnW6zNB3vbyfltXyJBVGeRI524Ia7YHj0frnzWjcaPVq/ypV1PCelrO
   1P1pcopAMCJJ0KGyYS4NOdohMmWDg+FmHez/suYsioPtYcq0AcC/BAQ+T
   jBypplsvu6N6ly/yn8/i8sNZzvAzibExF3M2i3xEOceqdB7lZDaHpSFqu
   xtMujN3IvGssWOk6xGeG8s/WROmNuHzmRuP+Bso2Fnwcn8j0LUvq+8fqY
   IM1BoT69tEH/1iJ4FcfxOG4ULPGW+arVYC0goTmpKzkkQuqDeC6ZWY110
   XUv1tR+aVFE3x4QfCeDSm6ncXR2h6ZFc2q4WfKfVepf3zEOH0AcXEcRQw
   w==;
X-CSE-ConnectionGUID: UeSa4zbAQTi2XFMLo1UahQ==
X-CSE-MsgGUID: nNRoQGzeRP6pWqivrKRfTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16550918"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16550918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:05:13 -0700
X-CSE-ConnectionGUID: VfGPq1aRRl+4ZnavVrDEBw==
X-CSE-MsgGUID: f4+hyf/oT4uzDVojGH6JBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33310616"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 May 2024 17:05:12 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9vxF-0002HH-2m;
	Thu, 23 May 2024 00:05:09 +0000
Date: Thu, 23 May 2024 08:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bdc42ded3ec7592d666b609e1349ae259fcddf02
Message-ID: <202405230842.pckZxzM4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bdc42ded3ec7592d666b609e1349ae259fcddf02  Merge branch into tip/master: 'x86/percpu'

elapsed time: 971m

configs tested: 26
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

