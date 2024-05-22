Return-Path: <linux-kernel+bounces-185700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543088CB904
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BABB21EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9470CC9;
	Wed, 22 May 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbxavvHx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981E1F614
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345890; cv=none; b=reeRI3z02DE9w2C9vhTHARdLRmSr9fmTYeBhNHWbX9ejIy1QcGLaqrnN2R8+6E9wk3uRQRNmYnhn/TvrehLk+v+Lwq8liJIM0j9LuG9NV8hYkzTt8gAaTmpxQY40drZMgxhbM92dTSFUVBfl0bvNRS2dpbZD+1sTCH2/j5vpdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345890; c=relaxed/simple;
	bh=FZdcV3NkCxHOANFDdD5SRNHeu8cJhoGznpWI0UwOjJE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jMY6wS4D4q13ixOaXMSK8Rfe/SGrRqiVtrKXr6VntLmW6bA63j/mjGCV8Gxi+RELgzCDNfF+X6Ek783XZXU6OLPIOFSM5Oi1CQAftdElX1zbck5dwp5TtFqkmllYvyNAaAU+y2rCdJaIvDQDZjLLYY+EBx6W9KTstpKEI/BUJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbxavvHx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716345889; x=1747881889;
  h=date:from:to:cc:subject:message-id;
  bh=FZdcV3NkCxHOANFDdD5SRNHeu8cJhoGznpWI0UwOjJE=;
  b=hbxavvHx7ESIUN16/3Ly0Ec/GSU8IS0M1Hsb9N2iG1yebr9RCqYC81/K
   aZt68xgA8NzvuMxIUOCD2rmSVfu9HBOwnh/KXg1I0h+uAsEXZ/cCKvJAi
   AHp1oFJAABnSN5xOj2FIT/yhFHEz/0+QT9OussL5Ej9lBN7LFjKi88xYv
   MbhgjLCKCa3TeTPfV/+RJexeB6GOKQvIDE2hEu3cve5uszP1f1nHlxy3W
   iVfoggWpViU5Mi4iaJcRomtdeBcy18FR8qC0TsfhwQLZEq0BxSIHCqoiD
   +VTmDFJaEViLbb+SGPrx1SapzFbQ9viphUI7GXaMMaubnGqiyvVn9DGa+
   g==;
X-CSE-ConnectionGUID: 1tItylhsS0OVQSiQTfHzKA==
X-CSE-MsgGUID: LoTORbOWQa6Iy6rqk3zvHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12686943"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12686943"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 19:44:47 -0700
X-CSE-ConnectionGUID: 9Sxe4y9yRiKT8Vv/iw6dLw==
X-CSE-MsgGUID: OubM1GHsSIaCWMGRCFzEdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33552737"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2024 19:44:46 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9by6-0000xz-26;
	Wed, 22 May 2024 02:44:42 +0000
Date: Wed, 22 May 2024 10:44:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 15c4fbf8eacf4abcad1c9a05291325e042884e2e
Message-ID: <202405221032.ZAFTVNFP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 15c4fbf8eacf4abcad1c9a05291325e042884e2e  x86/boot: Clean up the arch/x86/boot/main.c code a bit

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

