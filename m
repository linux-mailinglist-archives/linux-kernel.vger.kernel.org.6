Return-Path: <linux-kernel+bounces-434540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF39E6806
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3BD163B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498A1DC184;
	Fri,  6 Dec 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/jIZs/m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E81B4F1F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470624; cv=none; b=ob3/Zs7eWY7qgK/RPPpocizoK+nFuZJBagzx0Vbr59BdSWaILkT0T5FDkKVeLt8IaQXXhb8k2AW7HtrULAjf6z0Uo+FE/3D22IWiZlZJWfmRHINpjBjANbwXA6IgGQA+cXXbbRZSz38C+Wf7JU4N5eEjVO91jBqkmQzKCz1u1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470624; c=relaxed/simple;
	bh=rW1zGLV6GTd/TuyA7CJ5ZhgHBXyrglW4LXqh85Cy7Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GWG5Bp9h2gErTAL9i816f5HWm90l0S/pWMfHSeVyAW4+u0Z/7v9dMC58qTZyURjXPaLun+4PN/0qXLSUW+7TqlOqRflb0ajWGPiJZRjc6C2iGXUZEMsWRozF0wb1PjRSSk3MjGPcb2yAAJNBbTmxlJPw7ChDtP02h0Y77MPjYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/jIZs/m; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733470622; x=1765006622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rW1zGLV6GTd/TuyA7CJ5ZhgHBXyrglW4LXqh85Cy7Ms=;
  b=B/jIZs/m3Okt7ZEOX97Fp0OKUba8ZMzwzmQV5fFVsoVHwZ7NiA1I+9Sy
   Pxaed5xNIEKZVdClP3HS14j/ILDn/pqqD8p2iULWgIYYLF0MqKe69QJW3
   E104ZnSnJwH/rpX4sIsWyip9eJBJCboomjUHs8xhkkgwG7S4ngZTehZmZ
   1zeYCAtu+GVfiMTeDzvU4dU9s25WY8KoGIA9GCJwgCADrnWYevb+ZEE0x
   SmdyAe24lTcvtq5ikQsdwddF+Yb7a3DTGcsAS3oWsn5jEGbEMdrpQ4X78
   uAJcjB4KgUbnmnrvueztxuDELC15dQcWn7FgFNeJIQ/ykNSY7mUeh5HZZ
   A==;
X-CSE-ConnectionGUID: qLT/cOmfRWyvBXG3oaZ2tw==
X-CSE-MsgGUID: UxbFQpgKRm67S2LxSumpJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51349829"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="51349829"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 23:37:02 -0800
X-CSE-ConnectionGUID: 89jERL4lS0CfN0d7LhvzVA==
X-CSE-MsgGUID: gxST0mFARj+y9oflYWhSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94526314"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Dec 2024 23:37:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJStW-0000od-27;
	Fri, 06 Dec 2024 07:36:58 +0000
Date: Fri, 6 Dec 2024 15:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/tty/serial/pic32_uart.c:904:34: warning:
 'pic32_serial_dt_ids' defined but not used
Message-ID: <202412061528.c3mAs1pi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f52214c61a5b99a54168145378e91b40d10c90
commit: e3e7b13bffae85e2806c73e3ccacd4447bcb19ed serial: allow COMPILE_TEST for some drivers
date:   2 years, 8 months ago
config: mips-randconfig-r111-20241114 (https://download.01.org/0day-ci/archive/20241206/202412061528.c3mAs1pi-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241206/202412061528.c3mAs1pi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061528.c3mAs1pi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/pic32_uart.c:904:34: warning: 'pic32_serial_dt_ids' defined but not used [-Wunused-const-variable=]
     904 | static const struct of_device_id pic32_serial_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/pic32_serial_dt_ids +904 drivers/tty/serial/pic32_uart.c

157b9394709ed52 Andrei Pistirica 2016-01-13  903  
157b9394709ed52 Andrei Pistirica 2016-01-13 @904  static const struct of_device_id pic32_serial_dt_ids[] = {
157b9394709ed52 Andrei Pistirica 2016-01-13  905  	{ .compatible = "microchip,pic32mzda-uart" },
157b9394709ed52 Andrei Pistirica 2016-01-13  906  	{ /* sentinel */ }
157b9394709ed52 Andrei Pistirica 2016-01-13  907  };
157b9394709ed52 Andrei Pistirica 2016-01-13  908  MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
157b9394709ed52 Andrei Pistirica 2016-01-13  909  

:::::: The code at line 904 was first introduced by commit
:::::: 157b9394709ed5233288986a293405def22792ed serial: pic32_uart: Add PIC32 UART driver

:::::: TO: Andrei Pistirica <andrei.pistirica@microchip.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

