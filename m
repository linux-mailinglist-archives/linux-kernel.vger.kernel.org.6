Return-Path: <linux-kernel+bounces-169183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17618BC48C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B8C2816DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B613FD97;
	Sun,  5 May 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCBuHfQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866013FD7F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948429; cv=none; b=bfZalWY8WTwjTCpvv9wtsLAFqnG5EAfPeISNVDE6v01l1B6iXzZxBdcMHjdOCZLw6SUccOgd9zjOhn2bJuO4BSuEw56IE7e2xzBsqAbJGwjWofR/xDegFlKbDFH85R2ol/Hb7aOv3wFelMU7iw5PJ63PtmpoayCpaOtAD/K9UAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948429; c=relaxed/simple;
	bh=NVy75iIFNvmIbmRgBWApp4Iv7pImltO4vpHqlAOGIsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHlcXAAQTz2cQNH5ttCbWnbtvxWxtkP/0Ep+iusIBxoo+8N0MovOmviJgGH5SOUiy/XAQfY3DZFcOQaOTIK2xxyUnc8fLO0qlRvei2BsRzbslLYTFnf5ydicXQO6JYGWMJmNhnA9erdvDH8Gsz64kLfVmWgk77vEjl8tC0W0j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCBuHfQ/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714948428; x=1746484428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVy75iIFNvmIbmRgBWApp4Iv7pImltO4vpHqlAOGIsM=;
  b=oCBuHfQ/l6zbnP8Cm9tDPS6JEhXmT0JoRNE8iuN5LTStM0VU3RK4HxCg
   klV8c2mv52tqOUf4xWLaPv6J6H78GecMSbqxZonDNUZMtgt18F2ZNqsB/
   3bZa0mMLMWSgzXIf7OR8p5zW5E9YCwueNSX8e3yvPC+eSYd8yEjVOKysV
   iBWRvC8/AiL548fgwggII3av70PLqMeUcdR0bY78QToZFUJrrGm/tk017
   BVCMXzv/weybpxsPSv0L+XQ7GrrVWPR/zkwLSx00l7WYOFSIJr/LFs7bl
   0exoLsZyRVmT6VFAu+tBe7vnMEoF/3V8EcQjnjxPja26XIy5v0B4kMa0W
   Q==;
X-CSE-ConnectionGUID: 6QWJH6ljQkqPt8jePnuNyQ==
X-CSE-MsgGUID: NDS/oAo1S++hFYZEbM5Y6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="36069677"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="36069677"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 15:33:47 -0700
X-CSE-ConnectionGUID: y35fWdOCQJ2bpOe3MIKTYQ==
X-CSE-MsgGUID: JKlQ5+UFRWiJkvIgE1caGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59174002"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 May 2024 15:33:44 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3kQQ-0000Fs-0o;
	Sun, 05 May 2024 22:33:42 +0000
Date: Mon, 6 May 2024 06:33:22 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] platform/chrome: cros_kbd_led_backlight: enable probing
 through EC_FEATURE_PWM_KEYB
Message-ID: <202405060655.dD06crN0-lkp@intel.com>
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
config: x86_64-randconfig-072-20240506 (https://download.01.org/0day-ci/archive/20240506/202405060655.dD06crN0-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240506/202405060655.dD06crN0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405060655.dD06crN0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/chrome/cros_kbd_led_backlight.c:218:42: error: redefinition of 'keyboard_led_drvdata_ec_pwm'
     218 | static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
         |                                          ^
   drivers/platform/chrome/cros_kbd_led_backlight.c:184:57: note: previous definition is here
     184 | static const __maybe_unused struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
         |                                                         ^
>> drivers/platform/chrome/cros_kbd_led_backlight.c:240:14: error: use of undeclared identifier 'keyboard_led_drvdata_ec_pwm_mfd'; did you mean 'keyboard_led_drvdata_acpi'?
     240 |                 drvdata = &keyboard_led_drvdata_ec_pwm_mfd;
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            keyboard_led_drvdata_acpi
   drivers/platform/chrome/cros_kbd_led_backlight.c:114:42: note: 'keyboard_led_drvdata_acpi' declared here
     114 | static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
         |                                          ^
   2 errors generated.


vim +240 drivers/platform/chrome/cros_kbd_led_backlight.c

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

