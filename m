Return-Path: <linux-kernel+bounces-169189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F046D8BC49A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE128173F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF39140369;
	Sun,  5 May 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Axcs7LZf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E813FD88
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949108; cv=none; b=UXRtXa4ah7axzjuuCu+NEna+7j+ZOs/987l/wk/BX2781ecn3HFYJ577gtNV4sv5tTXG8n+bgec/3Dt15X35QnMl0BuXoimOrqzuaSGXFYrd1c436VckcMYKs+w4w5mnGaCempKA6+ffWCjzwgSJa4gqaYeawpe5NdKX0WQktag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949108; c=relaxed/simple;
	bh=1XfbBejj+k4DcvvOJV75CVqzmVhMF/QSd8w/S74/bFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHQDl+GtCbP+JsG7533QZHQLtBdEd0gDfqHRTeVflLOkweGW2vPj1TaJZc4GkAwfZ9eKlBmAb7ctMrjidvQnzsC8/6mcvTS78yaef3a/mOqnMFTMp5j8S+s2mmHqb5Tl4hHLaTb4YcCrMRcwVqoBgswGZPiSFhS6nFMhqT6WXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Axcs7LZf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714949107; x=1746485107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1XfbBejj+k4DcvvOJV75CVqzmVhMF/QSd8w/S74/bFk=;
  b=Axcs7LZf0RRLsMg0dA/WfopAx6pBof2NeYrn3SiU5BhGvjxTxZircDVs
   XD38Z1NslCUI6HsoaRbI2Sa7kOfOiXdRuQMOMgu4tHCERvl5h6IlpXP/w
   OZGRUX5X5AFkAl2Z/jAcCTsorGFAgoA3NxX1WrI755DVr37Ua2vBeUBNM
   On5msAATID1/65TRUc2U4HNt7zXMW9NWRwhC0HXZv0ljot6NhMhaT9RwS
   SyAacC0IyCT4uvOK8inxTdNJDwj+TYAROWByogn9hZ+2mPQNste3a5GkY
   vwMak0/bMWObddTQhipXhuJiJKmUT4a5y78HSNP7LUEpmLNYOEdEG5cGq
   Q==;
X-CSE-ConnectionGUID: aYLAaQN6TXaIgYM9XAhFyQ==
X-CSE-MsgGUID: ZPQRyLF7ReCnWZjr5KkTCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10900533"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10900533"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 15:45:06 -0700
X-CSE-ConnectionGUID: TGAXBbSBSHWp3zebJTNr4Q==
X-CSE-MsgGUID: /5Ztm97LQR6bEsBtoH/fog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28053595"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 May 2024 15:45:03 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3kbM-0000GC-1r;
	Sun, 05 May 2024 22:45:00 +0000
Date: Mon, 6 May 2024 06:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <202405060653.uskC4eSJ-lkp@intel.com>
References: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2fbe479c0024e1c6b992184a799055e19932aa48]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/platform-chrome-cros_kbd_led_backlight-enable-probing-through-EC_FEATURE_PWM_KEYB/20240505-174413
base:   2fbe479c0024e1c6b992184a799055e19932aa48
patch link:    https://lore.kernel.org/r/20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2%40weissschuh.net
patch subject: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing through EC_FEATURE_PWM_KEYB
config: x86_64-randconfig-014-20240506 (https://download.01.org/0day-ci/archive/20240506/202405060653.uskC4eSJ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240506/202405060653.uskC4eSJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405060653.uskC4eSJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/chrome/cros_kbd_led_backlight.c:218:42: error: redefinition of 'keyboard_led_drvdata_ec_pwm'
     218 | static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_kbd_led_backlight.c:184:57: note: previous definition of 'keyboard_led_drvdata_ec_pwm' with type 'const struct keyboard_led_drvdata'
     184 | static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_kbd_led_backlight.c: In function 'keyboard_led_probe':
   drivers/platform/chrome/cros_kbd_led_backlight.c:240:28: error: 'keyboard_led_drvdata_ec_pwm_mfd' undeclared (first use in this function); did you mean 'keyboard_led_drvdata_ec_pwm'?
     240 |                 drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            keyboard_led_drvdata_ec_pwm
   drivers/platform/chrome/cros_kbd_led_backlight.c:240:28: note: each undeclared identifier is reported only once for each function it appears in
   drivers/platform/chrome/cros_kbd_led_backlight.c: At top level:
>> drivers/platform/chrome/cros_kbd_led_backlight.c:218:42: warning: 'keyboard_led_drvdata_ec_pwm' defined but not used [-Wunused-const-variable=]
     218 | static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/keyboard_led_drvdata_ec_pwm +218 drivers/platform/chrome/cros_kbd_led_backlight.c

   217	
 > 218	static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
   219	
   220	#endif /* IS_ENABLED(CONFIG_MFD_CROS_EC_DEV) */
   221	
   222	static int keyboard_led_is_mfd_device(struct platform_device *pdev)
   223	{
   224		if (!IS_ENABLED(CONFIG_MFD_CROS_EC_DEV))
   225			return 0;
   226	
   227		if (!pdev->dev.parent)
   228			return 0;
   229	
   230		return strcmp(pdev->dev.parent->driver->name, "cros-ec-dev") == 0;
   231	}
   232	
   233	static int keyboard_led_probe(struct platform_device *pdev)
   234	{
   235		const struct keyboard_led_drvdata *drvdata;
   236		struct keyboard_led *keyboard_led;
   237		int error;
   238	
   239		if (keyboard_led_is_mfd_device(pdev))
 > 240			drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
   241		else
   242			drvdata = device_get_match_data(&pdev->dev);
   243		if (!drvdata)
   244			return -EINVAL;
   245	
   246		keyboard_led = devm_kzalloc(&pdev->dev, sizeof(*keyboard_led), GFP_KERNEL);
   247		if (!keyboard_led)
   248			return -ENOMEM;
   249		platform_set_drvdata(pdev, keyboard_led);
   250	
   251		if (drvdata->init) {
   252			error = drvdata->init(pdev);
   253			if (error)
   254				return error;
   255		}
   256	
   257		keyboard_led->cdev.name = "chromeos::kbd_backlight";
   258		keyboard_led->cdev.flags |= LED_CORE_SUSPENDRESUME;
   259		keyboard_led->cdev.max_brightness = drvdata->max_brightness;
   260		keyboard_led->cdev.brightness_set = drvdata->brightness_set;
   261		keyboard_led->cdev.brightness_set_blocking = drvdata->brightness_set_blocking;
   262		keyboard_led->cdev.brightness_get = drvdata->brightness_get;
   263	
   264		error = devm_led_classdev_register(&pdev->dev, &keyboard_led->cdev);
   265		if (error)
   266			return error;
   267	
   268		return 0;
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

