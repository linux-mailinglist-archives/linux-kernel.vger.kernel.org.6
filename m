Return-Path: <linux-kernel+bounces-206435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822299009B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587DFB2029A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9318199EAD;
	Fri,  7 Jun 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzLxpzFL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74419885E;
	Fri,  7 Jun 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775787; cv=none; b=kMy0UVq2CObOCnU5ehg7CJSdtAwRKkZOCbOCoYE/tU8mGm7oamNN5WP/Kn04I8WG3qOfGsf2/ANLY+ZsSIYCMSM6x2F8t0AJ/e8Ytv/dr1mKTLflwIPUXbDkRXDmj1e+VQbpRX7VyjH6iIe3pCL1UjKFCNT4knk48xNxeIjdPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775787; c=relaxed/simple;
	bh=QyCtiVbsdznSlYWboPZDIQv5by3PO7uwRbT+3Y5ZKtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpgA9vRTHfLoIXyS7/rXDav545xjViu/hWYaUX2UKSR3PdICoo6YwIQH9MTLoYcURkcDXyu+ztGj8f9CTtelpO0uX9bCZG2edM0Erhk1J8LsXGlK8bYUraAH8oWM+Xs/GW7cDO3Kjq5Fog1ZBn+8BvGJjTzMKmNSLZR8OzxkDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzLxpzFL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717775785; x=1749311785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QyCtiVbsdznSlYWboPZDIQv5by3PO7uwRbT+3Y5ZKtM=;
  b=BzLxpzFLS6raLIy/5L+Ac0Lf5GxXxQv7pgaZ1lJMnve1dBGtt8xw0+NT
   HrO2yhxhCA1GYFxpk7n7dB5rs/Mnpgg39yLIlIFbbTGLKh4yLjUPCyLII
   nwQ6u7ybT0tm6kDfnGG47bSBUDgPbHG8tPMfN+t/5Ypy7MGGNm8zW3wiB
   bUm7ntCSu/t/2utlrYek8A5F9TfMMxZLzen51AJxcM2dO6EncXLsJAuk0
   /l6b3KOllD3FyBbGWK+K1e7Ib0hQCarMnsPOD4vskyny8OosLpzo1mzFH
   MaTVRiTLciHPLfX8my5Kha8r5bupneBSoFIwog43aLVbLEwX9ApjHxsXc
   A==;
X-CSE-ConnectionGUID: 0p8+7MUsTha5IXfZ2730LQ==
X-CSE-MsgGUID: /grvQ6toRkOI8QrFd9ohrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="32048728"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="32048728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:56:20 -0700
X-CSE-ConnectionGUID: O7MLN+YwS7qkXvFqrSto5Q==
X-CSE-MsgGUID: A6v6P8j/RamywGIt98zkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43495677"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Jun 2024 08:56:17 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFbws-00004s-30;
	Fri, 07 Jun 2024 15:56:14 +0000
Date: Fri, 7 Jun 2024 23:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, mka@chromium.org,
	gregkh@linuxfoundation.org, javier.carrasco@wolfvision.net,
	benjamin.bara@skidata.com, m.felsch@pengutronix.de,
	jbrunet@baylibre.com, frieder.schrempf@kontron.de,
	stefan.eichenberger@toradex.com, michal.simek@amd.com
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] usb: misc: add Microchip usb5744 SMBus programming
 support
Message-ID: <202406072332.qRphZq3E-lkp@intel.com>
References: <1717676883-2876611-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717676883-2876611-1-git-send-email-radhey.shyam.pandey@amd.com>

Hi Radhey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radhey-Shyam-Pandey/usb-misc-add-Microchip-usb5744-SMBus-programming-support/20240606-203028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1717676883-2876611-1-git-send-email-radhey.shyam.pandey%40amd.com
patch subject: [PATCH] usb: misc: add Microchip usb5744 SMBus programming support
config: i386-randconfig-063-20240607 (https://download.01.org/0day-ci/archive/20240607/202406072332.qRphZq3E-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072332.qRphZq3E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072332.qRphZq3E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/misc/onboard_usb_dev.c:311:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __be16 [usertype] @@
   drivers/usb/misc/onboard_usb_dev.c:311:55: sparse:     expected unsigned short [usertype] value
   drivers/usb/misc/onboard_usb_dev.c:311:55: sparse:     got restricted __be16 [usertype]
   drivers/usb/misc/onboard_usb_dev.c:316:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __be16 [usertype] @@
   drivers/usb/misc/onboard_usb_dev.c:316:55: sparse:     expected unsigned short [usertype] value
   drivers/usb/misc/onboard_usb_dev.c:316:55: sparse:     got restricted __be16 [usertype]
   drivers/usb/misc/onboard_usb_dev.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   drivers/usb/misc/onboard_usb_dev.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +311 drivers/usb/misc/onboard_usb_dev.c

   299	
   300	int onboard_dev_5744_i2c_init(struct i2c_client *client)
   301	{
   302		struct device *dev = &client->dev;
   303		int ret;
   304	
   305		char wr_buf[7] = {0x00, 0x05, 0x00, 0x01, 0x41, 0x1D, 0x08};
   306	
   307		ret = i2c_smbus_write_block_data(client, 0, sizeof(wr_buf), wr_buf);
   308		if (ret)
   309			return dev_err_probe(dev, ret, "BYPASS_UDC_SUSPEND bit configuration failed\n");
   310	
 > 311		ret = i2c_smbus_write_word_data(client, 0x99, htons(0x3700));
   312		if (ret)
   313			return dev_err_probe(dev, ret, "Configuration Register Access Command failed\n");
   314	
   315		/* Send SMBus command to boot hub. */
   316		ret = i2c_smbus_write_word_data(client, 0xAA, htons(0x5600));
   317		if (ret < 0)
   318			return dev_err_probe(dev, ret, "USB Attach with SMBus command failed\n");
   319	
   320		return ret;
   321	}
   322	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

