Return-Path: <linux-kernel+bounces-268431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457E942495
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A00B24155
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F98179BC;
	Wed, 31 Jul 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXN+jCX7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34C17580
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393978; cv=none; b=RmpsuRGYNIBX6gm3jUQJhspfv2o96TUCbzJ+3pvgkoa8YsOqCGE1s4qyDHYHOPCC3JOCwiEamGnQ0HUzLOV3GiCgIt6pQq0HSHy7/UMZGWgMBMvUkpx0gurg4dFhUmCaxm9W98c373RtpB8ZI662lbGrFI+lq0xQiNGuUkWgntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393978; c=relaxed/simple;
	bh=Piw4WEEU8Zs8jZKdYPZDQvSnhukZPRbyICP3VKw6L1E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u5dye/cT8M9+dfW3kXDDSPst9qFHe2bL/d+sEdyYugsT9WDz9hDC2AIH3ZNwmrErj18tD0Zqp77nEkawLjiZuwmDHvrkwJ0pNEVjT3L3qoPLzQwVOuHeqO9jXDdwIHu1O97yUmEkfOcFghodB5UD+wmAYy72q/G3VRijfpqBUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXN+jCX7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722393976; x=1753929976;
  h=date:from:to:cc:subject:message-id;
  bh=Piw4WEEU8Zs8jZKdYPZDQvSnhukZPRbyICP3VKw6L1E=;
  b=TXN+jCX79jK5dL+3n6/LWYyDaXrQyCYb+Z5r4MneWo0fieWlhZlpiaPE
   ooKNHvxiP+/A1V0Ig7yZUqLfroXKqGbqS8ZvtFGdBa3sp3G48gW1xSbxi
   c+w+OSPI8ODZwj9k52h4TniEuKxjkZ/qR+SjzLiV90WptwG909e+PNfLK
   bxa5Yy4H/sqwrq/1HvWCAYbqNjpKODd+nFjdtAFUNYeHdbIBEoBPN3IHY
   tOCj6iB5y/GWmuM3PKKlHY4Yx4Zu0k1GD1SyPBNiQfOwxskmkH3vK15kQ
   83R3VU6xV6OeJMq1VvsxUiAk7aKCb/AbvfCeBkkv49lAp/Ra3yh1D3smQ
   Q==;
X-CSE-ConnectionGUID: Z7FPtsLbTouPdEZs3KEvuw==
X-CSE-MsgGUID: 8uUTaKNmTA62hOQ9PMR7uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31639319"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="31639319"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 19:46:11 -0700
X-CSE-ConnectionGUID: /b/MZ80LTgqH+z/pAX4HPA==
X-CSE-MsgGUID: MJlMkUowRNOaw654yQEKTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="58867746"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jul 2024 19:46:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYzLs-000tem-0g;
	Wed, 31 Jul 2024 02:46:08 +0000
Date: Wed, 31 Jul 2024 10:45:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 225f2bd064c32397acfe3d9dfd9a2b3bc6d64fd7
Message-ID: <202407311011.yJ6cd1e6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 225f2bd064c32397acfe3d9dfd9a2b3bc6d64fd7  x86/bugs: Add a separate config for GDS

elapsed time: 736m

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

