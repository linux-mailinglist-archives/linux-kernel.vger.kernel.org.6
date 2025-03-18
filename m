Return-Path: <linux-kernel+bounces-566413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35866A677BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB9E188FCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FD20F082;
	Tue, 18 Mar 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGvZ6w8X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79A20E6EE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311441; cv=none; b=ARivtlTYXYrla0d/na9urtMf2Ez7yBbZxgO9CY3+FjMaiBcND5tKLnCKRJQMlt/CJWTBXA5G5Xidzx1+lftGz0xsBWCqpSLXQ55gO7gHDN6Fdm4EfFvX5ZIredYhAMKW6z+lMzb3qrId/apjumgmk7JsS/ES+d0tZltD0M5oeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311441; c=relaxed/simple;
	bh=JAvu1umPYP5wxpojZDUKz51DsO814eKTbuaUHENNPLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YiA/PIQ1Ijpk5r3K+vVF3cxKQhaUHzm0odTHC9WuomCb4236hO5lp9EmZjypOQYLAEG3lv54nTNa/2veA2kc5WG79FzUSvbh/ynq/ByCy9x6dQmO4BCsChC87U5LyRr2QoSYK/Q0RQq/oPXF4kyXIyy7gEvpsKHJ2yizzmiMdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGvZ6w8X; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742311440; x=1773847440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JAvu1umPYP5wxpojZDUKz51DsO814eKTbuaUHENNPLc=;
  b=BGvZ6w8XoXjzYOEAb7DyM4A9GxZkZarzJlVWVdBLW99BP3lVJpfqc1o+
   GkrwSTdvXqvMXqsV2OKrBnRDw+udXOd+5RzGjZJU+YSsVnmIKiDTPIfi/
   3E1OUApqoLFgayY8lmTSnwndmTPbjSotvEmPypp6v3ZnC5wvPQyLK1fy6
   ZdigBK8H5eWZurMHSsBGNZP7ytA7RqR+iJXCPKDH8gE4qSOgikC0vVdr6
   PJa8lTQzPbIdEBxFACL7T1/SefG5V3LiiRYWzThlzCMvkC2fgP5dVLq3a
   T24ndg3hyznbWADRHl6bSHmRACC+TPyk+MwMe2dImMc56HfJmCcKYkKKA
   A==;
X-CSE-ConnectionGUID: v2iTX40pQ0agiAAamWN+Rg==
X-CSE-MsgGUID: 4d3QscDYSmSV0gQ2XVvLSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43629082"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43629082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:24:00 -0700
X-CSE-ConnectionGUID: AF3aio6HQo+JGTDp8C3Kdg==
X-CSE-MsgGUID: btczNph4T8uHOAgVeR/vxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122261376"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 08:23:58 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuYnL-000Dt9-2c;
	Tue, 18 Mar 2025 15:23:55 +0000
Date: Tue, 18 Mar 2025 23:23:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Justin Stitt <justinstitt@google.com>
Subject: vmlinux.o: warning: objtool: .text.rk806_set_mode_dcdc: unexpected
 end of section
Message-ID: <202503182350.52KeHGD4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76b6905c11fd3c6dc4562aefc3e8c4429fefae1e
commit: 9bf4e919ccad613b3596eebf1ff37b05b6405307 Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()
date:   11 months ago
config: x86_64-randconfig-077-20250318 (https://download.01.org/0day-ci/archive/20250318/202503182350.52KeHGD4-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503182350.52KeHGD4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503182350.52KeHGD4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: .text.rk806_set_mode_dcdc: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

