Return-Path: <linux-kernel+bounces-441807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919909ED44A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3DD168616
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09C1FECD7;
	Wed, 11 Dec 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMg+yjID"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF61BD9CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940025; cv=none; b=nS7T7myHYiqRPFfIzaUSGZgMiwhIwLUrDpXB49ob+VpHDLs0BipeT5GPpwuLfRocQJA9Jl57Tz8nJ/qD1NgtMX8LHRIQz/zCeNwMwQcHIRV2DqrlNm94c9FVnN/nHGyI09ObNlwOvwCVKl6JBzSWYoZb4dk2yic6t8XiZdgpJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940025; c=relaxed/simple;
	bh=jPTzKbMP+NexNycrcc4J71VjgwSgEGQyfWJzbuIRDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uFPdrxIx/bHXQFfL51J/QLhzyX5QO01SmIginA5P5iJD2HUsHrJU+wVTcMdk2hyYJYUivGYEhRZZsMzUcn4lR18vtcplYWjNUl1AdFIKSzleF3S/bzfQyyjpdzNgH3i9xDdcGOL2efT+BFiI9c68trTzkrDb4ZnmpzHgXMfHZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMg+yjID; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733940022; x=1765476022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jPTzKbMP+NexNycrcc4J71VjgwSgEGQyfWJzbuIRDiE=;
  b=nMg+yjIDw5CjiVZbdb35fYOvoQ5sKn+foQXP+Hy/wLuBlPnkx00nvHq9
   Am6VHOPGMMTW1eepZ2gEcq4NCf4IJA2O/JM1UbWLPlOXLAEt/25vCyfig
   1miYRhV4Erf0UnWLVQE4mXVx0PFe0YwCsjwG6mNclEGe0pOqI9om4a22s
   QAkHgebIQ3yXVds3X5D/hxiV7DtEHmLDbnKn7oN+WF6pBCpROXBqXF4s9
   Syt08juMfhWzbAAAmCV6I8kUTNnQSdICQbw2DaY0CpqIiX9X3Vg9X9yS2
   OdzyM4msSqFjtIXdFHo8GgE7K4GM+2vQQWy9PHblcBU37+jRYPiO+bvqe
   g==;
X-CSE-ConnectionGUID: BEcdSEHmTc2Gijeaga7TkQ==
X-CSE-MsgGUID: jQ66zMUxTCa3dvIc5uC2Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38265562"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38265562"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 10:00:20 -0800
X-CSE-ConnectionGUID: dYZmt2/STNOAWQ4fi5iyaQ==
X-CSE-MsgGUID: 7yuu4rA1TCWSb8pK26M7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="126720578"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2024 10:00:18 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLR0R-0006xV-03;
	Wed, 11 Dec 2024 18:00:15 +0000
Date: Thu, 12 Dec 2024 02:00:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: include/linux/build_bug.h:78:41: error: static assertion failed:
 "sizeof(struct rtw88xxa_efuse) == 512"
Message-ID: <202412120131.qk0x6OhE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f92f4749861b06fed908d336b4dee1326003291b
commit: 0e3e8284f8e1bf2fc0f7bf247194efe5cfc568c1 wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers
date:   5 weeks ago
config: arm-randconfig-r054-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120131.qk0x6OhE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120131.qk0x6OhE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120131.qk0x6OhE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bitfield.h:10,
                    from include/linux/fortify-string.h:5,
                    from include/linux/string.h:390,
                    from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from include/linux/usb.h:5,
                    from drivers/net/wireless/realtek/rtw88/rtw88xxa.c:5:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct rtw88xxa_efuse) == 512"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw88xxa.h:64:1: note: in expansion of macro 'static_assert'
      64 | static_assert(sizeof(struct rtw88xxa_efuse) == 512);
         | ^~~~~~~~~~~~~


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79 Maxim Levitsky   2022-10-25  80  

:::::: The code at line 78 was first introduced by commit
:::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

