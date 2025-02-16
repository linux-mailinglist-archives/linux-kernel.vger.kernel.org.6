Return-Path: <linux-kernel+bounces-516517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8DA37321
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6B9168B58
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5C189B8D;
	Sun, 16 Feb 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZcYwe0Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F7188907
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698130; cv=none; b=TrIpsRAxbku+j/YrweF9176ZbY6j4/ySIVDqHoNnazWdeO1v13DmKRus6zuv9aaM1ASAXUJSRwMA+D1I4ImmFOCqV47TH9HQc2xuPNtQbMKxNYHOnCWIbacRknP/iN5MDxeM/sRyxzu0/BcP8AX5otlHZ9nPf5NQFZx7eRy2ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698130; c=relaxed/simple;
	bh=O8q4i/RDmEfK6icn8DwJSo/Kcg5DBCPE1ND8TVHrJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FBgmYRHEp28vM0CxhB/BO8hSchGwcIlDZxyHN24weqNgYhMvhjIh00kOAlOrpFt62xCCy0MC0MjYHZ4cn3FCsBCduq0r0OB44wjRCGrgnOpo6cWIxAyHbzwgcTc2DwJGtbs1pqDegDh0X841Kj98ERdP4Ro00x/ZvP6Z1odyu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZcYwe0Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739698129; x=1771234129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O8q4i/RDmEfK6icn8DwJSo/Kcg5DBCPE1ND8TVHrJzE=;
  b=nZcYwe0YCQMh7RIY261VbBc58REhl+PPncuLEVhSAOWc9IxI/AkUCp65
   7OYWKxTrqurxarUNRKXonJrLNu6Gyy3N+O9D2sfcaL+aV/XRs+iaNm5yy
   nhE6IQkrtty71tp6oltjsxS/fkefGkwsjomLgPzCNt2MzwjiQCo7Ms/CR
   8cj+KCcPNUU1vftgMGTqXCWxgYjVW9YwKwo8iKJQ6pqC5jdqCPFQIZShu
   r3J/ySfF2HBUKDFQy6bZXlOPzuB3T8CKytVnsZuJXn2cUsWNnfT3p1TTR
   1dGiS+nhT1x36FTgn92GTU3EPleMYY/JYL2Bx0NPhJ69j+bQVs+UzlWr4
   g==;
X-CSE-ConnectionGUID: S3+EOmg4TmuFAD6EqYozMA==
X-CSE-MsgGUID: aCXcYtCVThaQB6JeJcSvaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="51379386"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="51379386"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:28:49 -0800
X-CSE-ConnectionGUID: wHaPOzNRQpKALzUKzFdEbw==
X-CSE-MsgGUID: VbrDNi3hQlOgk3l8SH8cqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113810256"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Feb 2025 01:28:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjaxB-001BnJ-0s;
	Sun, 16 Feb 2025 09:28:45 +0000
Date: Sun, 16 Feb 2025 17:28:13 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: ld.lld: error: undefined symbol: byte_rev_table
Message-ID: <202502161703.3Vr4M7qg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad1b832bf1cf2df9304f8eb72943111625c7e5a7
commit: a9bcd02fa42217c795bc9538a149936c82648476 auxdisplay: Add driver for MAX695x 7-segment LED controllers
date:   12 months ago
config: hexagon-randconfig-r054-20250216 (https://download.01.org/0day-ci/archive/20250216/202502161703.3Vr4M7qg-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 910be4ff90d7d07bd4518ea03b85c0974672bf9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502161703.3Vr4M7qg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502161703.3Vr4M7qg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: byte_rev_table
   >>> referenced by bitrev.h:18 (include/linux/bitrev.h:18)
   >>>               drivers/auxdisplay/max6959.o:(max6959_disp_update) in archive vmlinux.a
   >>> referenced by bitrev.h:18 (include/linux/bitrev.h:18)
   >>>               drivers/auxdisplay/max6959.o:(max6959_disp_update) in archive vmlinux.a
   >>> referenced by max6959.c:60 (drivers/auxdisplay/max6959.c:60)
   >>>               drivers/auxdisplay/max6959.o:(max6959_disp_update) in archive vmlinux.a
   >>> referenced 1 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

