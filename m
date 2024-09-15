Return-Path: <linux-kernel+bounces-329631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A709793D6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809DB28174A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA195186A;
	Sun, 15 Sep 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjVqZKo9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17C64A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726359270; cv=none; b=P4yv49yTTLy613nwWG9zQzwngbPfIkomarm6B9CNop0hZRl/3lluvHz1L2vMXin1bW+R8nl4ieIGESPwXevzUnD7lAPzI21EyfXAGk+aFSJaqkMovNWdHD6pgWiPgm2riTJEnrfEdv5p6wdji8G4yP9mNHy08Bh0zEMLRFeo0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726359270; c=relaxed/simple;
	bh=BdYacXOqQohaxunfJ3Ex29cYyhUX8gvn4VF/Sr/EtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=haGZUIsUBLirmrZitRcABbW5t3XS7OATZ5Hwe++3gjjc1l6Qet5+T2zD4EVWmMumICZYkvWPl5AZ4bPbxtkAHZNhLXHmminJ5O7Mc8/tDArQwbKulnM3YZ2GhCoCM+v2obmXIT9d07UPI1gm5S13sWS7CcUnQ3GWy2PLfPSG/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjVqZKo9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726359268; x=1757895268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BdYacXOqQohaxunfJ3Ex29cYyhUX8gvn4VF/Sr/EtnE=;
  b=TjVqZKo9vjOe7ervMWX4sVoL0puSiW1iCWBWrFnSnOHh/Ou7nlifArtw
   S6e/U07g9Yy9dgMiQk7631IsXRNPUG+qsDZeQv2xkQN+46rL2610a3gVa
   9snyW4c87nwTcaGXfgj+E569xXNkCwWWg8ppzayxrlqmN7vMYgQ8jmZUw
   IcXtw/1Ms2ibiF1B4JWDOe8MSTEo9O0wyeoDQs8M5C+lb12/qNB13wMlb
   SPDh80Rj6H8UbcgTTtyxwr5PP+5ZhJfQPC3OS3OkG5eoJNu3/Hjesk1v+
   OQQ9yZBPrdYX+MLvPxPYJZIljRDvhuGbZ3EqCuVwmWKaIjQozs8+ouTwY
   Q==;
X-CSE-ConnectionGUID: lIymC5bYQd+ufGFBqWVPXA==
X-CSE-MsgGUID: 8yHMrstSRm+KGP5wiwq0gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="36611763"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="36611763"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 17:14:28 -0700
X-CSE-ConnectionGUID: AxzMmjRSSG+5FSiUoBekfg==
X-CSE-MsgGUID: 9YwPrlfTTPmOOoh1T0bihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="73330222"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Sep 2024 17:14:25 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spcuD-0008Gs-36;
	Sun, 15 Sep 2024 00:14:21 +0000
Date: Sun, 15 Sep 2024 08:13:32 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: arch/s390/kernel/ipl.c:1973 sys_vmcmd_on_reboot_store() warn:
 unsigned 'len' is never less than zero.
Message-ID: <202409150811.A0rDxG88-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 247576bf624a200b9d4dba6126e760af0d5ebe0e s390/ipl: Do not accept z/VM CP diag X'008' cmds longer than max length
date:   4 months ago
config: s390-randconfig-r072-20240915 (https://download.01.org/0day-ci/archive/20240915/202409150811.A0rDxG88-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150811.A0rDxG88-lkp@intel.com/

smatch warnings:
arch/s390/kernel/ipl.c:1973 sys_vmcmd_on_reboot_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1974 sys_vmcmd_on_panic_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1975 sys_vmcmd_on_halt_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1976 sys_vmcmd_on_poff_store() warn: unsigned 'len' is never less than zero.
arch/s390/kernel/ipl.c:1977 sys_vmcmd_on_restart_store() warn: unsigned 'len' is never less than zero.

vim +/len +1973 arch/s390/kernel/ipl.c

99ca4e582d4a40 Michael Holzheu 2008-01-26  1972  
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1973  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_reboot, "%s\n", "%s\n", vmcmd_on_reboot);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1974  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_panic, "%s\n", "%s\n", vmcmd_on_panic);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1975  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_halt, "%s\n", "%s\n", vmcmd_on_halt);
99ca4e582d4a40 Michael Holzheu 2008-01-26 @1976  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_poff, "%s\n", "%s\n", vmcmd_on_poff);
7dd6b3343fdc19 Michael Holzheu 2011-08-03 @1977  DEFINE_IPL_ATTR_STR_RW(vmcmd, on_restart, "%s\n", "%s\n", vmcmd_on_restart);
99ca4e582d4a40 Michael Holzheu 2008-01-26  1978  

:::::: The code at line 1973 was first introduced by commit
:::::: 99ca4e582d4a4088969681efff97be44d98421a1 [S390] kernel: Shutdown Actions Interface

:::::: TO: Michael Holzheu <holzheu@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

