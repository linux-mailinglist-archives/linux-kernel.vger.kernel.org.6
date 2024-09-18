Return-Path: <linux-kernel+bounces-332923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938FC97C0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0502CB21134
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928EA1CA686;
	Wed, 18 Sep 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0MNG8lT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333051C9DFF
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691511; cv=none; b=LAZQ8y26f5xTCRRINqcvvJozDkK5LsQyVNhBiZiffCD/5eK2liPMpTDxrxgVbtCQ+CboL+QyrDnorrCu4huJU7Za10wSjPNyT9dAW4Cq7DZ2uiEPI0jYt/YSyeXOcN+FU9/kmbNGGLB+IZ46Eb6xbMLtjXnctLZ7R5F0iJvtVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691511; c=relaxed/simple;
	bh=Th9X+fpJw6/wQrnmMrXJC9KB33J5LB1Bzr4u5JaTiAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OXtsRwy1GgGPhWXdttDKwoUQeg9nOU7K/5476aLLZfbDlYqh+qhMINDGbxtD9K9xbVx7DN3FbXTNcpDd810rz9qHq3AlvGuXq8szV09WXXLfXsYkITAoFpZBFlt+7tvbPyQIRJwS2YBRihQy/ng7xGh7Fn2m/DLIfvkN4N+jIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0MNG8lT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726691509; x=1758227509;
  h=date:from:to:cc:subject:message-id;
  bh=Th9X+fpJw6/wQrnmMrXJC9KB33J5LB1Bzr4u5JaTiAg=;
  b=I0MNG8lTpx2nHuiUvHvyar20VuO+1RNyim7MAjDuvYGMyFM0Zn8VSnZn
   RaCCearpK6pr3AJ/oE9nq5UAmVR6W7HRpf5Ek76p95gt2izM1135OscMB
   uuAQhc2uFdV5veseWpjYUXbublRmLYZjR90JucOchlnhe9DEjeIbbYKJ7
   7tW7H5uL2RA8ARzS/tZyiMIHek1C3pGofMsRPSu4StxTOHTyF1ihqMKhv
   BgVtAwsqozhznv3Baimg/Hb1J0UWkNYGfqUqO8aVnDaYtcE9ZlNWs+gh2
   Hc9mNkJ56KPjHpbxkbuemUPevgxInjYx+3wPZSlKESpR3l44wipaqVzX2
   Q==;
X-CSE-ConnectionGUID: goliwOf3QaaZp1xRhJatLg==
X-CSE-MsgGUID: lF6e84v6Rde9/GqHOMEvJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25508085"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="25508085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 13:31:48 -0700
X-CSE-ConnectionGUID: OHQz66ttSKCxfRT4uBDzjA==
X-CSE-MsgGUID: AoPsqgAESAiphYefErBZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="74241613"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Sep 2024 13:31:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr1Kz-000CcC-1i;
	Wed, 18 Sep 2024 20:31:45 +0000
Date: Thu, 19 Sep 2024 04:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/rt] BUILD SUCCESS
 2638e4e6b18233d7ec54edb953f253ae9515bac2
Message-ID: <202409190404.zpbpptFt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/rt
branch HEAD: 2638e4e6b18233d7ec54edb953f253ae9515bac2  riscv: Allow to enable PREEMPT_RT.

elapsed time: 2099m

configs tested: 36
configs skipped: 82

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm64                         allnoconfig    gcc-14.1.0
arm64             randconfig-001-20240919    gcc-14.1.0
arm64             randconfig-002-20240919    clang-15
arm64             randconfig-003-20240919    clang-20
arm64             randconfig-004-20240919    gcc-14.1.0
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20240918    clang-18
i386    buildonly-randconfig-002-20240918    gcc-12
i386    buildonly-randconfig-003-20240918    gcc-12
i386    buildonly-randconfig-004-20240918    gcc-12
i386    buildonly-randconfig-005-20240918    clang-18
i386    buildonly-randconfig-006-20240918    gcc-12
i386                            defconfig    clang-18
i386              randconfig-001-20240918    clang-18
i386              randconfig-002-20240918    clang-18
i386              randconfig-003-20240918    clang-18
i386              randconfig-004-20240918    gcc-12
i386              randconfig-005-20240918    gcc-12
i386              randconfig-006-20240918    clang-18
i386              randconfig-011-20240918    gcc-12
i386              randconfig-012-20240918    clang-18
i386              randconfig-013-20240918    gcc-12
i386              randconfig-014-20240918    clang-18
i386              randconfig-015-20240918    clang-18
i386              randconfig-016-20240918    clang-18
riscv                         allnoconfig    gcc-14.1.0
riscv             randconfig-001-20240919    gcc-14.1.0
x86_64                        allnoconfig    clang-18
x86_64                       allyesconfig    clang-18
x86_64                          defconfig    gcc-11
x86_64                       rhel-8.3-bpf    gcc-12
x86_64                     rhel-8.3-kunit    gcc-12
x86_64                       rhel-8.3-ltp    gcc-12
x86_64                      rhel-8.3-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

