Return-Path: <linux-kernel+bounces-294508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA580958E89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627DD2845D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F215C148;
	Tue, 20 Aug 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OasUbxU/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD91547C9;
	Tue, 20 Aug 2024 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181597; cv=none; b=fwio6V+gCKJjhYG688EaF9dBRxqkmQQoj3RVUES0pWfQNhxNxCwIZp3Y0kaID7Il1/TRdNGLg70CrGNh0prNgLFkuzdDr9GmY5SLPFcd5GQzhiOROqcd8IRd/R6gB7PS146hnyTNvVpLVegjT9uvzpfjYlUZ+6uHRLgsgW8np54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181597; c=relaxed/simple;
	bh=zVp1b2SV9/XwCusLw9O/RD/Zq0qsylTYg378u0oHrRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY9xHQKRfEKkWgWgN14pRa6bpnCkEMK0NveX1t+oHo74mjsawU+qesUFK+Mk1c0+jojSIOSFmOz2eI/afjs8iEQOBs+cVPkTAjuY2BVS83QRnpgk6kO0ZzDmmkjBwZH2y66z87joE2doqt3BqHFlqr1XLVoTxNjKP9YTdGaZcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OasUbxU/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724181596; x=1755717596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVp1b2SV9/XwCusLw9O/RD/Zq0qsylTYg378u0oHrRU=;
  b=OasUbxU/SdSXIMNSEQMchHzN1y0B637MjcIu1vkm+NpG2bUKWJe1Lula
   4rblfjtaZfqxExxuJDJiIztQpNBOxoQF9luoGLLmwYQ7ZdnJIjzl2NtbJ
   3nDjY7AHbf9iwhu1Efv+I8//3fCOZ3Jz0KMUv447q51cMAO6/T9InjxBx
   apGkCJ5O4aawZSac5sjdJDzx3vpwCfHhdfjFLU3oNB0Q5G95yMBsZei6q
   4u7CmLv8QffGdFLtqdLXqj0Hof5A5JrzSlGUxAuvWvhN6ZZHy4Y6sge41
   nCECmf+C3MdnOtgDtsc1qn2V49HWoO+30DtwiPmV0NzO52i/Z76P2TVqm
   w==;
X-CSE-ConnectionGUID: d0DaJAasS/eFcr/KmPBpig==
X-CSE-MsgGUID: kzZEOKbsQNKI+xxbRhUqEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22316792"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22316792"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:19:53 -0700
X-CSE-ConnectionGUID: GrewprGpSvyP6kEpNJkVlA==
X-CSE-MsgGUID: eCJHkhbQSrCAftN/UdLbHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="84026664"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Aug 2024 12:19:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgUOS-000AWy-2T;
	Tue, 20 Aug 2024 19:19:48 +0000
Date: Wed, 21 Aug 2024 03:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: Xi Huang <xuiagnh@gmail.com>, jeremy@system76.com,
	productdev@system76.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] platform/x86: system76: Reducing redundant conditional
 judgments in system76_add()
Message-ID: <202408210506.TtQpGzMk-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240821/202408210506.TtQpGzMk-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210506.TtQpGzMk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210506.TtQpGzMk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/system76_acpi.c:762:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
     762 |                 else
         |                 ^
   1 warning generated.


vim +762 drivers/platform/x86/system76_acpi.c

   673	
   674	// Add a System76 ACPI device
   675	static int system76_add(struct acpi_device *acpi_dev)
   676	{
   677		struct system76_data *data;
   678		int err;
   679	
   680		data = devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
   681		if (!data)
   682			return -ENOMEM;
   683		acpi_dev->driver_data = data;
   684		data->acpi_dev = acpi_dev;
   685	
   686		// Some models do not run open EC firmware. Check for an ACPI method
   687		// that only exists on open EC to guard functionality specific to it.
   688		data->has_open_ec = acpi_has_method(acpi_device_handle(data->acpi_dev), "NFAN");
   689	
   690		err = system76_get(data, "INIT");
   691		if (err)
   692			return err;
   693		data->ap_led.name = "system76_acpi::airplane";
   694		data->ap_led.flags = LED_CORE_SUSPENDRESUME;
   695		data->ap_led.brightness_get = ap_led_get;
   696		data->ap_led.brightness_set_blocking = ap_led_set;
   697		data->ap_led.max_brightness = 1;
   698		data->ap_led.default_trigger = "rfkill-none";
   699		err = devm_led_classdev_register(&acpi_dev->dev, &data->ap_led);
   700		if (err)
   701			return err;
   702	
   703		data->kb_led.name = "system76_acpi::kbd_backlight";
   704		data->kb_led.flags = LED_BRIGHT_HW_CHANGED | LED_CORE_SUSPENDRESUME;
   705		data->kb_led.brightness_get = kb_led_get;
   706		data->kb_led.brightness_set_blocking = kb_led_set;
   707		if (acpi_has_method(acpi_device_handle(data->acpi_dev), "GKBK")) {
   708			// Use the new ACPI methods
   709			data->kbled_type = system76_get(data, "GKBK");
   710	
   711			switch (data->kbled_type) {
   712			case KBLED_NONE:
   713				// Nothing to do: Device will not be registered.
   714				break;
   715			case KBLED_WHITE:
   716				data->kb_led.max_brightness = 255;
   717				data->kb_toggle_brightness = 72;
   718				break;
   719			case KBLED_RGB:
   720				data->kb_led.max_brightness = 255;
   721				data->kb_led.groups = system76_kb_led_color_groups;
   722				data->kb_toggle_brightness = 72;
   723				data->kb_color = 0xffffff;
   724				system76_set(data, "SKBC", data->kb_color);
   725				break;
   726			}
   727		} else {
   728			// Use the old ACPI methods
   729			if (acpi_has_method(acpi_device_handle(data->acpi_dev), "SKBC")) {
   730				data->kbled_type = KBLED_RGB;
   731				data->kb_led.max_brightness = 255;
   732				data->kb_led.groups = system76_kb_led_color_groups;
   733				data->kb_toggle_brightness = 72;
   734				data->kb_color = 0xffffff;
   735				system76_set(data, "SKBC", data->kb_color);
   736			} else {
   737				data->kbled_type = KBLED_WHITE;
   738				data->kb_led.max_brightness = 5;
   739			}
   740		}
   741	
   742		if (data->kbled_type != KBLED_NONE) {
   743			err = devm_led_classdev_register(&acpi_dev->dev, &data->kb_led);
   744			if (err)
   745				return err;
   746		}
   747	
   748		data->input = devm_input_allocate_device(&acpi_dev->dev);
   749		if (!data->input)
   750			return -ENOMEM;
   751	
   752		data->input->name = "System76 ACPI Hotkeys";
   753		data->input->phys = "system76_acpi/input0";
   754		data->input->id.bustype = BUS_HOST;
   755		data->input->dev.parent = &acpi_dev->dev;
   756		input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
   757	
   758		err = input_register_device(data->input);
   759		if (err)
   760			if (data->has_open_ec)
   761				goto free_error;
 > 762			else
   763				return err;
   764	
   765		if (data->has_open_ec) {
   766			err = system76_get_object(data, "NFAN", &data->nfan);
   767			if (err)
   768				goto free_error;
   769	
   770			err = system76_get_object(data, "NTMP", &data->ntmp);
   771			if (err)
   772				goto free_error;
   773	
   774			data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
   775				"system76_acpi", data, &thermal_chip_info, NULL);
   776			err = PTR_ERR_OR_ZERO(data->therm);
   777			if (err)
   778				goto free_error;
   779	
   780			system76_battery_init();
   781		}
   782	
   783		return 0;
   784	
   785	free_error:
   786		kfree(data->ntmp);
   787		kfree(data->nfan);
   788		return err;
   789	}
   790	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

