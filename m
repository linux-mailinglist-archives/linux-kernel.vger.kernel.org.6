Return-Path: <linux-kernel+bounces-169153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2F8BC3E1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 23:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF331F21DDC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4587763E2;
	Sun,  5 May 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/UTFLit"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE67603A
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714943331; cv=none; b=R6NC5LeFRK05jxXgAlsI2apnNssSHPdgdfrmTPs78tBfaTmQWC6T+FxpIz7l1UWY+AyY9YYUpT3S3JspiSJXTObksaD1SwegQ0UN4/NXiyRMHnnXC1CtNbB+J/ns+F72t/kevvwKf+orM7crQGAFD/Gw61rnbfOg0UXVVoAMJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714943331; c=relaxed/simple;
	bh=UilgOujvlJznH56cOFOGftHOPnbl7zSrjAHopgb3Wz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMvg0Ex5jWWvHYGhAulgrfzL96WrqeXYbuXrGilkDYc6UqxN/oAAbBE1UPRo9ZqV1uozawG66ZS/O4N5Z5JakQIfMrhKeq98mN9Py89twK1zTlcqr8dNW+l1BU/hM6Nn4z6u63uzMKad3zG9tRHMS+NGWVlJ3C0YzmEe3oXNfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/UTFLit; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714943329; x=1746479329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UilgOujvlJznH56cOFOGftHOPnbl7zSrjAHopgb3Wz8=;
  b=Y/UTFLitBCVQgpDFuBdLzjOkv0iOteD0MQoe2PuaoXWKiEVcIfYrTLg1
   7KQKQ+wyQC/kNn2CRvSZB+9yF+HoPeStaGvJkKEh/FA9YiAbgkGmjY6dF
   MN0otappnasJX+iN56nUpCc3a2Dj/3u5Mf4515NZp1+daPxFQaaUpi3IT
   3aKTldVURckLZK+ALhvIWs5luXYuyX1VYTJaEM6QAwxuAguBUmOCEQ/ti
   XR9De8MFOdfxM6tWHakJYah06VN2PAthDAtjH/Y5PL2swdQBtwMVxRTFC
   DpRxF4cFWmVgReWyItIaBqJ9FlIvvzDuxFXD3R2mlWBPP0dQMZvdSx3r+
   g==;
X-CSE-ConnectionGUID: NRvfNfjfR62pBbM9EPbXNA==
X-CSE-MsgGUID: Nj7dO03/SMKtpQIKlDPTyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14487010"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14487010"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 14:08:48 -0700
X-CSE-ConnectionGUID: PMgjmJkATjy8GQSTNwDufg==
X-CSE-MsgGUID: nlzVjBX9Q7mvMJc0fw9FNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="58850216"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 May 2024 14:08:46 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3j6B-0000DE-1P;
	Sun, 05 May 2024 21:08:43 +0000
Date: Mon, 6 May 2024 05:08:26 +0800
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
Message-ID: <202405060439.O5mY5RbW-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 2fbe479c0024e1c6b992184a799055e19932aa48]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/platform-chrome-cros_kbd_led_backlight-enable-probing-through-EC_FEATURE_PWM_KEYB/20240505-174413
base:   2fbe479c0024e1c6b992184a799055e19932aa48
patch link:    https://lore.kernel.org/r/20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2%40weissschuh.net
patch subject: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing through EC_FEATURE_PWM_KEYB
config: x86_64-buildonly-randconfig-002-20240506 (https://download.01.org/0day-ci/archive/20240506/202405060439.O5mY5RbW-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240506/202405060439.O5mY5RbW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405060439.O5mY5RbW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/cros_kbd_led_backlight.c:218:42: error: redefinition of 'keyboard_led_drvdata_ec_pwm'
    static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_kbd_led_backlight.c:193:57: note: previous definition of 'keyboard_led_drvdata_ec_pwm' was here
    static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
                                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/cros_kbd_led_backlight.c: In function 'keyboard_led_probe':
>> drivers/platform/chrome/cros_kbd_led_backlight.c:240:14: error: 'keyboard_led_drvdata_ec_pwm_mfd' undeclared (first use in this function); did you mean 'keyboard_led_drvdata_ec_pwm'?
      drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 keyboard_led_drvdata_ec_pwm
   drivers/platform/chrome/cros_kbd_led_backlight.c:240:14: note: each undeclared identifier is reported only once for each function it appears in


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

