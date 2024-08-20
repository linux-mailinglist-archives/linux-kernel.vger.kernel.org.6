Return-Path: <linux-kernel+bounces-294507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9B958E87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F021C223E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83915AAB8;
	Tue, 20 Aug 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieTtzW6T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4A1537AA;
	Tue, 20 Aug 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181595; cv=none; b=Nlj8Nfx29b0HuaYx3zZo/2q1AFDj/frnqB4HVNXxVWFmUTo8Yj7xMYMfn1dl1400yy27P8+rqm+bREs/L4fWnDChtiHfHk9IhwPXLld8rHpkB7aBHQMxD3+GVJLOcqXvO4NLD3WiBqgxCylhswk72u1ZMSno5Xnz8wY3PQTiVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181595; c=relaxed/simple;
	bh=xU3uY0htm2cSztCws4pR2cSeThXulFKAH/QNsVDLCwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh5bMILFzeOxoG9vvjeBgtw/ovn9SSiDMEkMfF3uTSRaVEKEJdVjPmpZwcbuyIP1C3D0CL6POWBRWIhz9753U8KKQWvTMsBEVRdUcmHe9t/M7WTpSnmYNE1u/4LXrDN4xblt2MGg2GHgkbLc7gI1VKe7gXWOSXHYViFnNpsITJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieTtzW6T; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724181593; x=1755717593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xU3uY0htm2cSztCws4pR2cSeThXulFKAH/QNsVDLCwY=;
  b=ieTtzW6ThE3vJ32wmoRuEJsX5KVGIAomRr8gciZMtbRad0ZelyIx4MvW
   485pLG1lxzrk/kEibsxWHC/ZMvJoeP6UdvFhXECIdzRRAr9+wFqDuw/2t
   1Ft5hT/xpkq+zIFBJJ+6y1wZ3hBk7QDvlBERL49/iUmqr13Ajq+F4Zqis
   E8meAPWmXpq94qa/1Enk7iHxgSTfd3Ez/+pY8VZC+3083ToO2MD0bnw0T
   FwDM2G1YDUI3yhMuKjg7YF8y42rz9zyvXf23rzANMdvyPCG0EXMjFr3YD
   JfTI7hduf9/3Eh509eaN/KFe5+FZ1kidjmuIy1EQolnW8N98jY+QzX4c2
   w==;
X-CSE-ConnectionGUID: nrRBtiQxRr+wP4CT1Jw39g==
X-CSE-MsgGUID: yM9oJ/D/QS+1b/zWfvBhOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22316786"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22316786"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:19:53 -0700
X-CSE-ConnectionGUID: pHoWMbF4TmS32GYeofvigg==
X-CSE-MsgGUID: cI2+5qEEQdy9pJV3fYi/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="84026663"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Aug 2024 12:19:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgUOS-000AWw-2Q;
	Tue, 20 Aug 2024 19:19:48 +0000
Date: Wed, 21 Aug 2024 03:18:57 +0800
From: kernel test robot <lkp@intel.com>
To: Xi Huang <xuiagnh@gmail.com>, jeremy@system76.com,
	productdev@system76.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] platform/x86: system76: Reducing redundant conditional
 judgments in system76_add()
Message-ID: <202408210354.eRwpaGm7-lkp@intel.com>
References: <20240820090239.17771-1-xuiagnh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820090239.17771-1-xuiagnh@gmail.com>

Hi Xi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc4 next-20240820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xi-Huang/platform-x86-system76-Reducing-redundant-conditional-judgments-in-system76_add/20240820-170328
base:   linus/master
patch link:    https://lore.kernel.org/r/20240820090239.17771-1-xuiagnh%40gmail.com
patch subject: [PATCH] platform/x86: system76: Reducing redundant conditional judgments in system76_add()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240821/202408210354.eRwpaGm7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210354.eRwpaGm7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210354.eRwpaGm7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/system76_acpi.c: In function 'system76_add':
>> drivers/platform/x86/system76_acpi.c:759:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     759 |         if (err)
         |            ^


vim +/else +759 drivers/platform/x86/system76_acpi.c

fd13c8622a5ad4f Jeremy Soller 2019-10-09  673  
fd13c8622a5ad4f Jeremy Soller 2019-10-09  674  // Add a System76 ACPI device
fd13c8622a5ad4f Jeremy Soller 2019-10-09  675  static int system76_add(struct acpi_device *acpi_dev)
fd13c8622a5ad4f Jeremy Soller 2019-10-09  676  {
fd13c8622a5ad4f Jeremy Soller 2019-10-09  677  	struct system76_data *data;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  678  	int err;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  679  
fd13c8622a5ad4f Jeremy Soller 2019-10-09  680  	data = devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
fd13c8622a5ad4f Jeremy Soller 2019-10-09  681  	if (!data)
fd13c8622a5ad4f Jeremy Soller 2019-10-09  682  		return -ENOMEM;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  683  	acpi_dev->driver_data = data;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  684  	data->acpi_dev = acpi_dev;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  685  
c4499272566d677 Tim Crawford  2021-12-22  686  	// Some models do not run open EC firmware. Check for an ACPI method
c4499272566d677 Tim Crawford  2021-12-22  687  	// that only exists on open EC to guard functionality specific to it.
c4499272566d677 Tim Crawford  2021-12-22  688  	data->has_open_ec = acpi_has_method(acpi_device_handle(data->acpi_dev), "NFAN");
c4499272566d677 Tim Crawford  2021-12-22  689  
fd13c8622a5ad4f Jeremy Soller 2019-10-09  690  	err = system76_get(data, "INIT");
fd13c8622a5ad4f Jeremy Soller 2019-10-09  691  	if (err)
fd13c8622a5ad4f Jeremy Soller 2019-10-09  692  		return err;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  693  	data->ap_led.name = "system76_acpi::airplane";
fd13c8622a5ad4f Jeremy Soller 2019-10-09  694  	data->ap_led.flags = LED_CORE_SUSPENDRESUME;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  695  	data->ap_led.brightness_get = ap_led_get;
5b36398dc846a52 Nick Shipp    2020-07-09  696  	data->ap_led.brightness_set_blocking = ap_led_set;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  697  	data->ap_led.max_brightness = 1;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  698  	data->ap_led.default_trigger = "rfkill-none";
fd13c8622a5ad4f Jeremy Soller 2019-10-09  699  	err = devm_led_classdev_register(&acpi_dev->dev, &data->ap_led);
fd13c8622a5ad4f Jeremy Soller 2019-10-09  700  	if (err)
fd13c8622a5ad4f Jeremy Soller 2019-10-09  701  		return err;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  702  
fd13c8622a5ad4f Jeremy Soller 2019-10-09  703  	data->kb_led.name = "system76_acpi::kbd_backlight";
fd13c8622a5ad4f Jeremy Soller 2019-10-09  704  	data->kb_led.flags = LED_BRIGHT_HW_CHANGED | LED_CORE_SUSPENDRESUME;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  705  	data->kb_led.brightness_get = kb_led_get;
5b36398dc846a52 Nick Shipp    2020-07-09  706  	data->kb_led.brightness_set_blocking = kb_led_set;
5d36931f0fe5166 Tim Crawford  2023-07-19  707  	if (acpi_has_method(acpi_device_handle(data->acpi_dev), "GKBK")) {
5d36931f0fe5166 Tim Crawford  2023-07-19  708  		// Use the new ACPI methods
5d36931f0fe5166 Tim Crawford  2023-07-19  709  		data->kbled_type = system76_get(data, "GKBK");
5d36931f0fe5166 Tim Crawford  2023-07-19  710  
5d36931f0fe5166 Tim Crawford  2023-07-19  711  		switch (data->kbled_type) {
5d36931f0fe5166 Tim Crawford  2023-07-19  712  		case KBLED_NONE:
5d36931f0fe5166 Tim Crawford  2023-07-19  713  			// Nothing to do: Device will not be registered.
5d36931f0fe5166 Tim Crawford  2023-07-19  714  			break;
5d36931f0fe5166 Tim Crawford  2023-07-19  715  		case KBLED_WHITE:
5d36931f0fe5166 Tim Crawford  2023-07-19  716  			data->kb_led.max_brightness = 255;
5d36931f0fe5166 Tim Crawford  2023-07-19  717  			data->kb_toggle_brightness = 72;
5d36931f0fe5166 Tim Crawford  2023-07-19  718  			break;
5d36931f0fe5166 Tim Crawford  2023-07-19  719  		case KBLED_RGB:
5d36931f0fe5166 Tim Crawford  2023-07-19  720  			data->kb_led.max_brightness = 255;
5d36931f0fe5166 Tim Crawford  2023-07-19  721  			data->kb_led.groups = system76_kb_led_color_groups;
5d36931f0fe5166 Tim Crawford  2023-07-19  722  			data->kb_toggle_brightness = 72;
5d36931f0fe5166 Tim Crawford  2023-07-19  723  			data->kb_color = 0xffffff;
5d36931f0fe5166 Tim Crawford  2023-07-19  724  			system76_set(data, "SKBC", data->kb_color);
5d36931f0fe5166 Tim Crawford  2023-07-19  725  			break;
5d36931f0fe5166 Tim Crawford  2023-07-19  726  		}
5d36931f0fe5166 Tim Crawford  2023-07-19  727  	} else {
5d36931f0fe5166 Tim Crawford  2023-07-19  728  		// Use the old ACPI methods
fd13c8622a5ad4f Jeremy Soller 2019-10-09  729  		if (acpi_has_method(acpi_device_handle(data->acpi_dev), "SKBC")) {
5d36931f0fe5166 Tim Crawford  2023-07-19  730  			data->kbled_type = KBLED_RGB;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  731  			data->kb_led.max_brightness = 255;
603a7dd08f881e1 Tim Crawford  2021-10-06  732  			data->kb_led.groups = system76_kb_led_color_groups;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  733  			data->kb_toggle_brightness = 72;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  734  			data->kb_color = 0xffffff;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  735  			system76_set(data, "SKBC", data->kb_color);
fd13c8622a5ad4f Jeremy Soller 2019-10-09  736  		} else {
5d36931f0fe5166 Tim Crawford  2023-07-19  737  			data->kbled_type = KBLED_WHITE;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  738  			data->kb_led.max_brightness = 5;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  739  		}
5d36931f0fe5166 Tim Crawford  2023-07-19  740  	}
5d36931f0fe5166 Tim Crawford  2023-07-19  741  
5d36931f0fe5166 Tim Crawford  2023-07-19  742  	if (data->kbled_type != KBLED_NONE) {
fd13c8622a5ad4f Jeremy Soller 2019-10-09  743  		err = devm_led_classdev_register(&acpi_dev->dev, &data->kb_led);
fd13c8622a5ad4f Jeremy Soller 2019-10-09  744  		if (err)
fd13c8622a5ad4f Jeremy Soller 2019-10-09  745  			return err;
5d36931f0fe5166 Tim Crawford  2023-07-19  746  	}
fd13c8622a5ad4f Jeremy Soller 2019-10-09  747  
0de30fc684b3883 Jeremy Soller 2021-10-06  748  	data->input = devm_input_allocate_device(&acpi_dev->dev);
0de30fc684b3883 Jeremy Soller 2021-10-06  749  	if (!data->input)
0de30fc684b3883 Jeremy Soller 2021-10-06  750  		return -ENOMEM;
0de30fc684b3883 Jeremy Soller 2021-10-06  751  
0de30fc684b3883 Jeremy Soller 2021-10-06  752  	data->input->name = "System76 ACPI Hotkeys";
0de30fc684b3883 Jeremy Soller 2021-10-06  753  	data->input->phys = "system76_acpi/input0";
0de30fc684b3883 Jeremy Soller 2021-10-06  754  	data->input->id.bustype = BUS_HOST;
0de30fc684b3883 Jeremy Soller 2021-10-06  755  	data->input->dev.parent = &acpi_dev->dev;
0de30fc684b3883 Jeremy Soller 2021-10-06  756  	input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
0de30fc684b3883 Jeremy Soller 2021-10-06  757  
0de30fc684b3883 Jeremy Soller 2021-10-06  758  	err = input_register_device(data->input);
0de30fc684b3883 Jeremy Soller 2021-10-06 @759  	if (err)
634a2087bfdcba7 Xi Huang      2024-08-20  760  		if (data->has_open_ec)
634a2087bfdcba7 Xi Huang      2024-08-20  761  			goto free_error;
634a2087bfdcba7 Xi Huang      2024-08-20  762  		else
634a2087bfdcba7 Xi Huang      2024-08-20  763  			return err;
0de30fc684b3883 Jeremy Soller 2021-10-06  764  
c4499272566d677 Tim Crawford  2021-12-22  765  	if (data->has_open_ec) {
95563d45b5da9cd Jeremy Soller 2021-10-06  766  		err = system76_get_object(data, "NFAN", &data->nfan);
95563d45b5da9cd Jeremy Soller 2021-10-06  767  		if (err)
634a2087bfdcba7 Xi Huang      2024-08-20  768  			goto free_error;
95563d45b5da9cd Jeremy Soller 2021-10-06  769  
95563d45b5da9cd Jeremy Soller 2021-10-06  770  		err = system76_get_object(data, "NTMP", &data->ntmp);
95563d45b5da9cd Jeremy Soller 2021-10-06  771  		if (err)
634a2087bfdcba7 Xi Huang      2024-08-20  772  			goto free_error;
95563d45b5da9cd Jeremy Soller 2021-10-06  773  
95563d45b5da9cd Jeremy Soller 2021-10-06  774  		data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
95563d45b5da9cd Jeremy Soller 2021-10-06  775  			"system76_acpi", data, &thermal_chip_info, NULL);
95563d45b5da9cd Jeremy Soller 2021-10-06  776  		err = PTR_ERR_OR_ZERO(data->therm);
95563d45b5da9cd Jeremy Soller 2021-10-06  777  		if (err)
634a2087bfdcba7 Xi Huang      2024-08-20  778  			goto free_error;
95563d45b5da9cd Jeremy Soller 2021-10-06  779  
76f7eba3e0a248a Tim Crawford  2021-10-06  780  		system76_battery_init();
c4499272566d677 Tim Crawford  2021-12-22  781  	}
76f7eba3e0a248a Tim Crawford  2021-10-06  782  
fd13c8622a5ad4f Jeremy Soller 2019-10-09  783  	return 0;
95563d45b5da9cd Jeremy Soller 2021-10-06  784  
634a2087bfdcba7 Xi Huang      2024-08-20  785  free_error:
95563d45b5da9cd Jeremy Soller 2021-10-06  786  	kfree(data->ntmp);
95563d45b5da9cd Jeremy Soller 2021-10-06  787  	kfree(data->nfan);
95563d45b5da9cd Jeremy Soller 2021-10-06  788  	return err;
fd13c8622a5ad4f Jeremy Soller 2019-10-09  789  }
fd13c8622a5ad4f Jeremy Soller 2019-10-09  790  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

