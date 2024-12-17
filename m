Return-Path: <linux-kernel+bounces-449133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9619F4A53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E548188E95F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA11EF088;
	Tue, 17 Dec 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svx3RD1u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D31EF0B1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436382; cv=none; b=K92gUmPG2zTiAA+R6s0aQSxs98/X18wdc212xuTwTjh90QYC0ppp0xmMiBtD50ppXRr+6qkTGAELl06jG5idrkicT9eMOzzuDwn7rFnkgK6UAXlOfXNL2bLmsMIagS0q6e2SrGBE6uydafwPf2i1bQI78NAymO+3P41znkuyvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436382; c=relaxed/simple;
	bh=OHc4Tj1USHWI/M5UeEKPTBOa6AV9jjttGviWtXq10lg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dB+K6w2OktY1FS71/e3Eh27M8rlrFQdrwdmfVG4zhe7Iz9Lmi4TGWF0FGwdoeMjWSPq977P6q58kNV3FAqNeK9MJXyvAY95fmEcSvpNB94v0HzNpTy5sWP5n4J6CqvEQxM4K92fW0BgmgJV+Upqpheibrr+ovCFpZ5xCVVGtZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svx3RD1u; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734436379; x=1765972379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OHc4Tj1USHWI/M5UeEKPTBOa6AV9jjttGviWtXq10lg=;
  b=Svx3RD1u2su/tUCnDfRc9bKoXp3/j0l59vpp4iPsxyDrjogpRNfzyeHQ
   2oKoVE26VHN+P+H98aKIycWx0KOs6cz2tvpPdHSGwD65q5lw5JWtxSu5e
   46VY4evv+SvVphScQJU30ol2l4RAa6vM1QmMEReO+amjA3d6zcw/RbVtG
   uaAc6dBgG5+9Nbb8TQYDk96STzVnKBngFKGkF6PhR+dA3n1S1FngCSRbV
   LeooT7973FrBsTYBf4JWmHMmAkXHjBNw9zCOCpLeZRt+/+eelU7ssvo6s
   7FDGiprgoRR89qNd8RMLo8KYr8bStF8DfJHJEDzoCxs6cdmwwFASCHQlq
   g==;
X-CSE-ConnectionGUID: RSxHcafoS+SFjFG4i+vIoA==
X-CSE-MsgGUID: VWDc/eQTRZaobnLxqiIz+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52265428"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="52265428"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:52:59 -0800
X-CSE-ConnectionGUID: uXRD0rEVRfiqHK2yUDd/eA==
X-CSE-MsgGUID: 9DL7WOtxS9KifxCN031MQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97743307"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Dec 2024 03:52:58 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNW8F-000Eyv-2P;
	Tue, 17 Dec 2024 11:52:55 +0000
Date: Tue, 17 Dec 2024 19:52:05 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/tty/mips_ejtag_fdc.c:685: warning: Excess function parameter
 'opaque' description in 'mips_ejtag_fdc_tty_timer'
Message-ID: <202412172203.6IUAS30l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
commit: 188942f05ce45f80c06f7242ad7478bd204c3387 tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
date:   10 months ago
config: mips-randconfig-r071-20241215 (https://download.01.org/0day-ci/archive/20241217/202412172203.6IUAS30l-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 2dc22615fd46ab2566d0f26d5ba234ab12dc4bf8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412172203.6IUAS30l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412172203.6IUAS30l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/mips_ejtag_fdc.c:685: warning: Function parameter or struct member 't' not described in 'mips_ejtag_fdc_tty_timer'
>> drivers/tty/mips_ejtag_fdc.c:685: warning: Excess function parameter 'opaque' description in 'mips_ejtag_fdc_tty_timer'


vim +685 drivers/tty/mips_ejtag_fdc.c

4cebec609aea6d James Hogan     2015-01-29  673  
4cebec609aea6d James Hogan     2015-01-29  674  /**
4cebec609aea6d James Hogan     2015-01-29  675   * mips_ejtag_fdc_tty_timer() - Poll FDC for incoming data.
4cebec609aea6d James Hogan     2015-01-29  676   * @opaque:	Pointer to driver private data.
4cebec609aea6d James Hogan     2015-01-29  677   *
4cebec609aea6d James Hogan     2015-01-29  678   * This is the timer handler for when interrupts are disabled and polling the
4cebec609aea6d James Hogan     2015-01-29  679   * FDC state is required.
4cebec609aea6d James Hogan     2015-01-29  680   *
4cebec609aea6d James Hogan     2015-01-29  681   * It simply triggers the common FDC handler code and arranges for further
4cebec609aea6d James Hogan     2015-01-29  682   * polling.
4cebec609aea6d James Hogan     2015-01-29  683   */
75d1760f4cd1b2 Kees Cook       2017-10-16  684  static void mips_ejtag_fdc_tty_timer(struct timer_list *t)
4cebec609aea6d James Hogan     2015-01-29 @685  {
75d1760f4cd1b2 Kees Cook       2017-10-16  686  	struct mips_ejtag_fdc_tty *priv = from_timer(priv, t, poll_timer);
4cebec609aea6d James Hogan     2015-01-29  687  
4cebec609aea6d James Hogan     2015-01-29  688  	mips_ejtag_fdc_handle(priv);
4cebec609aea6d James Hogan     2015-01-29  689  	if (!priv->removing)
853f90d49bbabc Thomas Gleixner 2016-07-04  690  		mod_timer(&priv->poll_timer, jiffies + FDC_TTY_POLL);
4cebec609aea6d James Hogan     2015-01-29  691  }
4cebec609aea6d James Hogan     2015-01-29  692  

:::::: The code at line 685 was first introduced by commit
:::::: 4cebec609aea6dff23e67a42b6516d852fa87d07 TTY: Add MIPS EJTAG Fast Debug Channel TTY driver

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

