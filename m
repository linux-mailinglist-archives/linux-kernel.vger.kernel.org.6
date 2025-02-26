Return-Path: <linux-kernel+bounces-535068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF59CA46E65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A0016983A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD825CC69;
	Wed, 26 Feb 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjpmShBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00325CC62
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608404; cv=none; b=tM9uuNSFRy5QhB8/9tRmZMUiJenxH1kF+0QBWlYe97cM4+g8crhfgZeBtqQbGcv7Gc6zb/eXXXmHO0AEhBq9HbgsWGkRtOcxoiTmG4lWrTNtK9wdCDy0/Cbxbv9V3WCaJFdvm/mMURQq3Kk6Xq5Gn2+aIEIUbXAOTO7414tQbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608404; c=relaxed/simple;
	bh=2R3jk3LWIuwwEVPnk835IzI/96JL1vWLEUpvSgCyDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YcmYJaUY1lnqtzA10F6URBEz9w/w+VcPBc6BKWIBZO0qhbXZZM9HmyeQX8q5bR7maZ/aGctYTHFbCUer3xmtfJjqjuu7+E73qYCL7Jxqbja5Kwehh0YmSohyKxt789+EVYpMeQ/OAlU05SYqesM9Ux1TiB+7P8C+Yg6Gx4iP3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjpmShBT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740608402; x=1772144402;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2R3jk3LWIuwwEVPnk835IzI/96JL1vWLEUpvSgCyDOg=;
  b=VjpmShBTi+LwC7z6tEP5r8bc7we8uyf3W9jQuSsjKFgjbPM3Q+lG74BU
   4Z45m0lEgMk4/X2wvNgwJ+1gPTN8hdgaw7ME7YIqdf0xot9/y7jwAqWWX
   5P55N8AqeO2M26iFjLETciL/4aj3aajsmOsLz2puQJW5cXYnKNO/Q+IjN
   +9NR9lFFCFJzZ8Qr8E+g3cI4dC4962AFevXeDIL8sOTtnwWu1x+XOZ555
   TFvOqWMFdEI9sQNZueAC9cJ0UOHqaaDwNAH7n3wWcg2+GZlTOGmNZHXt2
   miNmrr12ud0gvN75SSF5EcmO5hsK5BJD1UyDf53n7WqzZ9tgDhAnw3228
   g==;
X-CSE-ConnectionGUID: NWXup4W5TiWfhT1sPvkQ7g==
X-CSE-MsgGUID: Vi9CdmKdQrSmQeZl/BNaAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52875884"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52875884"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:20:02 -0800
X-CSE-ConnectionGUID: jjqWLe81Q7Ge0C4qbP3HDg==
X-CSE-MsgGUID: epAsV+qiRpy2wpsDCO+b+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122095666"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 Feb 2025 14:20:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnPkG-000CXd-02;
	Wed, 26 Feb 2025 22:19:25 +0000
Date: Thu, 27 Feb 2025 06:17:57 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: drivers/firmware/turris-mox-rwtm.c:249:90: warning: '%08x' directive
 writing 8 bytes into a region of size between 7 and 9
Message-ID: <202502270657.cNsilu1y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Marek,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
commit: e34e60253d9272311831daed8a2d967cf80ca3dc firmware: turris-mox-rwtm: fix reply status decoding function
date:   3 years, 8 months ago
config: arm-randconfig-r002-20220811 (https://download.01.org/0day-ci/archive/20250227/202502270657.cNsilu1y-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502270657.cNsilu1y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502270657.cNsilu1y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/turris-mox-rwtm.c: In function 'mox_get_board_info':
>> drivers/firmware/turris-mox-rwtm.c:249:90: warning: '%08x' directive writing 8 bytes into a region of size between 7 and 9 [-Wformat-overflow=]
     249 |                         "%06x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x",
         |                                                                                          ^~~~
   drivers/firmware/turris-mox-rwtm.c:248:17: note: 'sprintf' output between 135 and 137 bytes into a destination of size 135
     248 |                 sprintf(rwtm->pubkey,
         |                 ^~~~~~~~~~~~~~~~~~~~~
     249 |                         "%06x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x",
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     250 |                         ret, s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7],
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     251 |                         s[8], s[9], s[10], s[11], s[12], s[13], s[14], s[15]);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +249 drivers/firmware/turris-mox-rwtm.c

389711b3749399 Marek Behún 2019-08-22  190  
389711b3749399 Marek Behún 2019-08-22  191  static int mox_get_board_info(struct mox_rwtm *rwtm)
389711b3749399 Marek Behún 2019-08-22  192  {
389711b3749399 Marek Behún 2019-08-22  193  	struct armada_37xx_rwtm_tx_msg msg;
389711b3749399 Marek Behún 2019-08-22  194  	struct armada_37xx_rwtm_rx_msg *reply = &rwtm->reply;
389711b3749399 Marek Behún 2019-08-22  195  	int ret;
389711b3749399 Marek Behún 2019-08-22  196  
389711b3749399 Marek Behún 2019-08-22  197  	msg.command = MBOX_CMD_BOARD_INFO;
389711b3749399 Marek Behún 2019-08-22  198  	ret = mbox_send_message(rwtm->mbox, &msg);
389711b3749399 Marek Behún 2019-08-22  199  	if (ret < 0)
389711b3749399 Marek Behún 2019-08-22  200  		return ret;
389711b3749399 Marek Behún 2019-08-22  201  
389711b3749399 Marek Behún 2019-08-22  202  	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
389711b3749399 Marek Behún 2019-08-22  203  	if (ret < 0)
389711b3749399 Marek Behún 2019-08-22  204  		return ret;
389711b3749399 Marek Behún 2019-08-22  205  
389711b3749399 Marek Behún 2019-08-22  206  	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
389711b3749399 Marek Behún 2019-08-22  207  	if (ret < 0 && ret != -ENODATA) {
389711b3749399 Marek Behún 2019-08-22  208  		return ret;
389711b3749399 Marek Behún 2019-08-22  209  	} else if (ret == -ENODATA) {
389711b3749399 Marek Behún 2019-08-22  210  		dev_warn(rwtm->dev,
389711b3749399 Marek Behún 2019-08-22  211  			 "Board does not have manufacturing information burned!\n");
389711b3749399 Marek Behún 2019-08-22  212  	} else {
389711b3749399 Marek Behún 2019-08-22  213  		rwtm->serial_number = reply->status[1];
389711b3749399 Marek Behún 2019-08-22  214  		rwtm->serial_number <<= 32;
389711b3749399 Marek Behún 2019-08-22  215  		rwtm->serial_number |= reply->status[0];
389711b3749399 Marek Behún 2019-08-22  216  		rwtm->board_version = reply->status[2];
389711b3749399 Marek Behún 2019-08-22  217  		rwtm->ram_size = reply->status[3];
389711b3749399 Marek Behún 2019-08-22  218  		reply_to_mac_addr(rwtm->mac_address1, reply->status[4],
389711b3749399 Marek Behún 2019-08-22  219  				  reply->status[5]);
389711b3749399 Marek Behún 2019-08-22  220  		reply_to_mac_addr(rwtm->mac_address2, reply->status[6],
389711b3749399 Marek Behún 2019-08-22  221  				  reply->status[7]);
389711b3749399 Marek Behún 2019-08-22  222  		rwtm->has_board_info = 1;
389711b3749399 Marek Behún 2019-08-22  223  
389711b3749399 Marek Behún 2019-08-22  224  		pr_info("Turris Mox serial number %016llX\n",
389711b3749399 Marek Behún 2019-08-22  225  			rwtm->serial_number);
389711b3749399 Marek Behún 2019-08-22  226  		pr_info("           board version %i\n", rwtm->board_version);
389711b3749399 Marek Behún 2019-08-22  227  		pr_info("           burned RAM size %i MiB\n", rwtm->ram_size);
389711b3749399 Marek Behún 2019-08-22  228  	}
389711b3749399 Marek Behún 2019-08-22  229  
389711b3749399 Marek Behún 2019-08-22  230  	msg.command = MBOX_CMD_ECDSA_PUB_KEY;
389711b3749399 Marek Behún 2019-08-22  231  	ret = mbox_send_message(rwtm->mbox, &msg);
389711b3749399 Marek Behún 2019-08-22  232  	if (ret < 0)
389711b3749399 Marek Behún 2019-08-22  233  		return ret;
389711b3749399 Marek Behún 2019-08-22  234  
389711b3749399 Marek Behún 2019-08-22  235  	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
389711b3749399 Marek Behún 2019-08-22  236  	if (ret < 0)
389711b3749399 Marek Behún 2019-08-22  237  		return ret;
389711b3749399 Marek Behún 2019-08-22  238  
389711b3749399 Marek Behún 2019-08-22  239  	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
389711b3749399 Marek Behún 2019-08-22  240  	if (ret < 0 && ret != -ENODATA) {
389711b3749399 Marek Behún 2019-08-22  241  		return ret;
389711b3749399 Marek Behún 2019-08-22  242  	} else if (ret == -ENODATA) {
389711b3749399 Marek Behún 2019-08-22  243  		dev_warn(rwtm->dev, "Board has no public key burned!\n");
389711b3749399 Marek Behún 2019-08-22  244  	} else {
389711b3749399 Marek Behún 2019-08-22  245  		u32 *s = reply->status;
389711b3749399 Marek Behún 2019-08-22  246  
389711b3749399 Marek Behún 2019-08-22  247  		rwtm->has_pubkey = 1;
389711b3749399 Marek Behún 2019-08-22  248  		sprintf(rwtm->pubkey,
389711b3749399 Marek Behún 2019-08-22 @249  			"%06x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x",
389711b3749399 Marek Behún 2019-08-22  250  			ret, s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7],
389711b3749399 Marek Behún 2019-08-22  251  			s[8], s[9], s[10], s[11], s[12], s[13], s[14], s[15]);
389711b3749399 Marek Behún 2019-08-22  252  	}
389711b3749399 Marek Behún 2019-08-22  253  
389711b3749399 Marek Behún 2019-08-22  254  	return 0;
389711b3749399 Marek Behún 2019-08-22  255  }
389711b3749399 Marek Behún 2019-08-22  256  

:::::: The code at line 249 was first introduced by commit
:::::: 389711b374939968d2d0adede01b9e1f3bb4f531 firmware: Add Turris Mox rWTM firmware driver

:::::: TO: Marek Behún <marek.behun@nic.cz>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

