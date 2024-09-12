Return-Path: <linux-kernel+bounces-326560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE99769FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F1FB23C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EFB19F42D;
	Thu, 12 Sep 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ux6Wj2Eq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D01A2639
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146363; cv=none; b=GR1vFYP6CNmTlfv9vtIdJZzMW4H52ubg7gJdox+0FTPxLntmOLOez6Sz66Ba1PBmdxsaxuvKGYj2nlBHdai2xeXxJ65lrEoq1EdjmtJrukHA6YoYSwOexJxiE2l1HWdyKApkEy5kCP5vgUSGFk/pr4poge+n361bkvrGWQNCVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146363; c=relaxed/simple;
	bh=elqqLGSNxrq+uu0tXdg0E9WKcdzDciPN1q2YQNljUHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nO1jg1522uUIMY3BedWGyDhtp7AMOMu1W4G2i0vA5c1EHs6xaTBfrEpxcBYTcLwQtMgodqVwyDRzWwmLkrec99WC7PCa9fZGUd2rtMMbxjy2GICBpkZR1RlyKglgHOp6f1BMOqsyE5KWWGJYbukXU0hxRp4xTj89UQAKQdX/VNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ux6Wj2Eq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146362; x=1757682362;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=elqqLGSNxrq+uu0tXdg0E9WKcdzDciPN1q2YQNljUHA=;
  b=Ux6Wj2EqCYlw3BZT5Qph6IS6IVIFjzK5sB4p2H93l0TlgaqfURRocAHj
   5i1vbrFml/nYjsrWEVmgzVozLx0J5GyGsukY3s88f6t7CI40ts1xUVifL
   SdLLjdCe2uHEbPnEnv3X14F45DAourwH0372oNvc3SewPk04D2UH9ds6D
   /XX4Y0ejlIvU/CLHDZiFqK68KR4GwOL1+cFM4UJ6I33fXTI5x3zBO76rz
   nCmMkh/B6gqiH9aTGHl6maSCH7TcI246ttX0Z+s69WUfBGCY1ORjMHJMI
   ZBnKDqzjwOZzDh3rnM1SxCe+l6zMf4eyltf5YAmVOHciOLANweiaFTjJd
   A==;
X-CSE-ConnectionGUID: +8DQK4M5TfW1XP0XfrtU/w==
X-CSE-MsgGUID: 7pR/1UhKTs+olBPFRlzwgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24481253"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24481253"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:06:02 -0700
X-CSE-ConnectionGUID: fhQmcLv0SuW6o5ZBh+jwtA==
X-CSE-MsgGUID: Vsno+zAATXKZRmx8xhx0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67696009"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 06:06:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sojWH-0005Bm-2M;
	Thu, 12 Sep 2024 13:05:57 +0000
Date: Thu, 12 Sep 2024 21:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter
 or member 'pm_suspend_backup.imr' not described in 'atmel_pioctrl'
Message-ID: <202409122134.crk22zBA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77f587896757708780a7e8792efe62939f25a5ab
commit: 3a025e1d1c2ea42fa497c9c6b21c284e0f69e28b Add optional check for bad kernel-doc comments
date:   7 years ago
config: arm-randconfig-002-20240912 (https://download.01.org/0day-ci/archive/20240912/202409122134.crk22zBA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122134.crk22zBA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122134.crk22zBA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_wakeup_sources' not described in 'atmel_pioctrl'
   drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.imr' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.odsr' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.cfgr' not described in 'atmel_pioctrl'


vim +136 drivers/pinctrl/pinctrl-at91-pio4.c

776180848b574c Ludovic Desroches 2015-09-16   95  
776180848b574c Ludovic Desroches 2015-09-16   96  /**
776180848b574c Ludovic Desroches 2015-09-16   97   * struct atmel_pioctrl - Atmel PIO controller (pinmux + gpio)
776180848b574c Ludovic Desroches 2015-09-16   98   * @reg_base: base address of the controller.
776180848b574c Ludovic Desroches 2015-09-16   99   * @clk: clock of the controller.
776180848b574c Ludovic Desroches 2015-09-16  100   * @nbanks: number of PIO groups, it can vary depending on the SoC.
776180848b574c Ludovic Desroches 2015-09-16  101   * @pinctrl_dev: pinctrl device registered.
776180848b574c Ludovic Desroches 2015-09-16  102   * @groups: groups table to provide group name and pin in the group to pinctrl.
776180848b574c Ludovic Desroches 2015-09-16  103   * @group_names: group names table to provide all the group/pin names to
776180848b574c Ludovic Desroches 2015-09-16  104   *     pinctrl or gpio.
776180848b574c Ludovic Desroches 2015-09-16  105   * @pins: pins table used for both pinctrl and gpio. pin_id, bank and line
776180848b574c Ludovic Desroches 2015-09-16  106   *     fields are set at probe time. Other ones are set when parsing dt
776180848b574c Ludovic Desroches 2015-09-16  107   *     pinctrl.
776180848b574c Ludovic Desroches 2015-09-16  108   * @npins: number of pins.
776180848b574c Ludovic Desroches 2015-09-16  109   * @gpio_chip: gpio chip registered.
776180848b574c Ludovic Desroches 2015-09-16  110   * @irq_domain: irq domain for the gpio controller.
776180848b574c Ludovic Desroches 2015-09-16  111   * @irqs: table containing the hw irq number of the bank. The index of the
776180848b574c Ludovic Desroches 2015-09-16  112   *     table is the bank id.
776180848b574c Ludovic Desroches 2015-09-16  113   * @dev: device entry for the Atmel PIO controller.
776180848b574c Ludovic Desroches 2015-09-16  114   * @node: node of the Atmel PIO controller.
776180848b574c Ludovic Desroches 2015-09-16  115   */
776180848b574c Ludovic Desroches 2015-09-16  116  struct atmel_pioctrl {
776180848b574c Ludovic Desroches 2015-09-16  117  	void __iomem		*reg_base;
776180848b574c Ludovic Desroches 2015-09-16  118  	struct clk		*clk;
776180848b574c Ludovic Desroches 2015-09-16  119  	unsigned		nbanks;
776180848b574c Ludovic Desroches 2015-09-16  120  	struct pinctrl_dev	*pinctrl_dev;
776180848b574c Ludovic Desroches 2015-09-16  121  	struct atmel_group	*groups;
776180848b574c Ludovic Desroches 2015-09-16  122  	const char * const	*group_names;
776180848b574c Ludovic Desroches 2015-09-16  123  	struct atmel_pin	**pins;
776180848b574c Ludovic Desroches 2015-09-16  124  	unsigned		npins;
776180848b574c Ludovic Desroches 2015-09-16  125  	struct gpio_chip	*gpio_chip;
776180848b574c Ludovic Desroches 2015-09-16  126  	struct irq_domain	*irq_domain;
776180848b574c Ludovic Desroches 2015-09-16  127  	int			*irqs;
de4e882f3fbef5 Ludovic Desroches 2015-09-25  128  	unsigned		*pm_wakeup_sources;
ba9e7f2794d815 Alexandre Belloni 2017-04-06  129  	struct {
ba9e7f2794d815 Alexandre Belloni 2017-04-06  130  		u32		imr;
ba9e7f2794d815 Alexandre Belloni 2017-04-06  131  		u32		odsr;
ba9e7f2794d815 Alexandre Belloni 2017-04-06  132  		u32		cfgr[ATMEL_PIO_NPINS_PER_BANK];
ba9e7f2794d815 Alexandre Belloni 2017-04-06  133  	} *pm_suspend_backup;
776180848b574c Ludovic Desroches 2015-09-16  134  	struct device		*dev;
776180848b574c Ludovic Desroches 2015-09-16  135  	struct device_node	*node;
776180848b574c Ludovic Desroches 2015-09-16 @136  };
776180848b574c Ludovic Desroches 2015-09-16  137  

:::::: The code at line 136 was first introduced by commit
:::::: 776180848b574c9c01217fa958f10843ffce584f pinctrl: introduce driver for Atmel PIO4 controller

:::::: TO: Ludovic Desroches <ludovic.desroches@atmel.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

