Return-Path: <linux-kernel+bounces-184208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23358CA455
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D317281A31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39413793A;
	Mon, 20 May 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhcrrUnv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB71C286
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716242630; cv=none; b=LF2Dk+xz0eBwkC0s4tz3MZQPxeqncmQ/iPH/blVqoCKzp2Eq3qWe+NbcYlPn8Fj73xWfwyNkXwhLI8Z6BZLM2GB50zLcD54rMENDloDzs7IvYtpY0gGiZM8c8vcMMIaWCKYZb3gBIqMYW4eFVo33wfu3d1JizgGVnRhorsGpnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716242630; c=relaxed/simple;
	bh=cqYrNCaRpRMRE52xar5noIcDWk/QHxh3VD4YLiIWUXg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rh1wtp9lPKdJXqpVClf1pauoPKXVJ8NxKu31VAl6RFi5/4HKuwRHw8gfCIDjw4D7sx5kZzB4N1Xk4oZxBJalSGNYOrlT2A2Jz1/PXQ8rpNUk8aJygtFiHZhIZchTb0H/8NOg8injf1Svv+dqvVRu40W5BW15k/1cHzGh0qEgPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhcrrUnv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716242630; x=1747778630;
  h=date:from:to:cc:subject:message-id;
  bh=cqYrNCaRpRMRE52xar5noIcDWk/QHxh3VD4YLiIWUXg=;
  b=QhcrrUnvYpJL0YFAX7zz9FQe7KlTepQ7SWAotqzlrOotIVy/nRfSB3xd
   E8rTxPWaPcatEGFAj+B+B3RXVAPpYVeSJZRb3hl5hwCqJbSvqlLS0rn3Z
   6NhAoIv9i26rXQC9bzso9gWCnApfSINWKk77drkrjpgd0XjKADHnYz6MK
   CwmR7yea60XuZejkoVFbFnfsbPHzNG29YVm3OZSQpKGDp0YakebHJPqbi
   3OO3WR/++LAfque1puptg4+agP+jgz6uKb1l0/dLxOiEM8YyMRt2/C3CF
   rqMKEH6ek5kWRb3Ux3fEKy/sRBhXvQgezizssiSiY8X/346z3KxhFV1ZN
   g==;
X-CSE-ConnectionGUID: yGodQ4BYQX2IzW4xX0Y+hA==
X-CSE-MsgGUID: gLZqKElBQDeMa6gBSSooOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="11614279"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="11614279"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:03:49 -0700
X-CSE-ConnectionGUID: OArdl5IZQG6sCczb6F0P8Q==
X-CSE-MsgGUID: dGs8PaaST9KhSmLI9kt3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37517633"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 May 2024 15:03:47 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9B63-0005Bi-15;
	Mon, 20 May 2024 22:03:19 +0000
Date: Tue, 21 May 2024 06:01:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 66ee3636eddcc82ab82b539d08b85fb5ac1dff9b
Message-ID: <202405210617.mmYVtzTR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 66ee3636eddcc82ab82b539d08b85fb5ac1dff9b  x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y

elapsed time: 726m

configs tested: 50
configs skipped: 133

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

