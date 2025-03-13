Return-Path: <linux-kernel+bounces-559921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3001A5FB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA29F881274
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3326E647;
	Thu, 13 Mar 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBQ6k8yD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE23269816;
	Thu, 13 Mar 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882088; cv=none; b=fvN01syvwDvbOlW8cUJvj3jsH1HzGAlhL5ARpooFFcrwvb3ssFBCdw27SUwF6vBjnxURGYgiIsiRwpSgPEdw1Y13qioRrCMdRvhHnMcIshfvMtVG/pEY6bHywsRGb9TxbLIKPKuzo/03B4KDZVGuQ0gfi9NK4vbTG9JF4pSdq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882088; c=relaxed/simple;
	bh=hMqJXk5eOhmEOR+ONN1O/Bon0ZOcsikAip9Gjm/6PQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG7XCCyGDa+gsDGBFO2tTMgwx5noSwduR9FEIq/agBZ6CcnpXvcaXjPOJwyAsaIRIMyEve4GPkg2lYFa/fQUoNi61iRvfZ5hpwfPazkKF+ygP3xbpULM7JtenlQt3aNnO9xFw3RiHiuaieDzBCkwBxQNzeJKXjjXHApLB5BXyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBQ6k8yD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882087; x=1773418087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMqJXk5eOhmEOR+ONN1O/Bon0ZOcsikAip9Gjm/6PQ8=;
  b=GBQ6k8yDAh7PQVmt6RnaS7XW0L8wMyNm1pm/QMKb3+fh+lLMQ7u6ZX7J
   K08cY/9fU8r5W+8Ne8zzxHt/QkXjESm2NMwHNajBTBVgf2QPrbVmEAfEx
   Jm4kTWBthtrOYBWaEgZtNE00z6vEN8sXYVipGd+P8EYzc4joR5er59AiF
   7cDb6taHw1TtmccrI8RzCjAgZIgEeSNvtsy6G8+7hjcIr4IhJs91Orfhv
   DwHIOXNee4nnJgZb0l+P9d64geRLnFoluflPFs4wB8RtN6kUU1MNdZKVi
   Q6EJoXdLKv8tnDIojo5MjZ1FdQ5X6dUro4fT8sztuWIoerHr1g5reorNE
   Q==;
X-CSE-ConnectionGUID: M7EvsXYTRqer/zrEOFpQww==
X-CSE-MsgGUID: rrlfn55zQbqF+ijUZgXt+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42179559"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42179559"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:08:06 -0700
X-CSE-ConnectionGUID: BktotUkyRWGZ6FHY7LxLrg==
X-CSE-MsgGUID: AbCLbLZxSdexJGFg60jKbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121496932"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Mar 2025 09:08:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsl6G-0009dE-2e;
	Thu, 13 Mar 2025 16:08:00 +0000
Date: Fri, 14 Mar 2025 00:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jameson Thies <jthies@google.com>, tzungbi@kernel.org,
	ukaszb@chromium.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org,
	swboyd@chromium.org, akuchynski@chromium.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Jameson Thies <jthies@google.com>
Subject: Re: [PATCH v1 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
Message-ID: <202503132357.RnlF5A0E-lkp@intel.com>
References: <20250312195951.1579682-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312195951.1579682-4-jthies@google.com>

Hi Jameson,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9fc83373f0ffb8834da48b1446a5c2fef9525bb1]

url:    https://github.com/intel-lab-lkp/linux/commits/Jameson-Thies/dt-bindings-Add-cros-ec-ucsi-to-cros-ec-typec-device-tree-documentation/20250313-040216
base:   9fc83373f0ffb8834da48b1446a5c2fef9525bb1
patch link:    https://lore.kernel.org/r/20250312195951.1579682-4-jthies%40google.com
patch subject: [PATCH v1 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is defined in OF or ACPI
config: x86_64-buildonly-randconfig-003-20250313 (https://download.01.org/0day-ci/archive/20250313/202503132357.RnlF5A0E-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132357.RnlF5A0E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132357.RnlF5A0E-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/cros_ec_dev.c:273:12: error: incompatible function pointer types passing 'int (struct device *, void *)' to parameter of type 'device_match_t' (aka 'int (*)(struct device *, const void *)') [-Wincompatible-function-pointer-types]
     273 |                                                             ucsi_acpi_match);
         |                                                             ^~~~~~~~~~~~~~~
   include/linux/device.h:1101:21: note: passing argument to parameter 'match' here
    1101 |                                  device_match_t match);
         |                                                 ^
   1 error generated.


vim +273 drivers/mfd/cros_ec_dev.c

   181	
   182	static int ec_device_probe(struct platform_device *pdev)
   183	{
   184		int retval = -ENOMEM;
   185		struct device_node *node;
   186		struct device *dev = &pdev->dev;
   187		struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
   188		struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
   189		struct ec_response_pchg_count pchg_count;
   190		int i;
   191	
   192		if (!ec)
   193			return retval;
   194	
   195		dev_set_drvdata(dev, ec);
   196		ec->ec_dev = dev_get_drvdata(dev->parent);
   197		ec->dev = dev;
   198		ec->cmd_offset = ec_platform->cmd_offset;
   199		ec->features.flags[0] = -1U; /* Not cached yet */
   200		ec->features.flags[1] = -1U; /* Not cached yet */
   201		device_initialize(&ec->class_dev);
   202	
   203		for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
   204			/*
   205			 * Check whether this is actually a dedicated MCU rather
   206			 * than an standard EC.
   207			 */
   208			if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
   209				dev_info(dev, "CrOS %s MCU detected\n",
   210					 cros_mcu_devices[i].desc);
   211				/*
   212				 * Help userspace differentiating ECs from other MCU,
   213				 * regardless of the probing order.
   214				 */
   215				ec_platform->ec_name = cros_mcu_devices[i].name;
   216				break;
   217			}
   218		}
   219	
   220		/*
   221		 * Add the class device
   222		 */
   223		ec->class_dev.class = &cros_class;
   224		ec->class_dev.parent = dev;
   225		ec->class_dev.release = cros_ec_class_release;
   226	
   227		retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
   228		if (retval) {
   229			dev_err(dev, "dev_set_name failed => %d\n", retval);
   230			goto failed;
   231		}
   232	
   233		retval = device_add(&ec->class_dev);
   234		if (retval)
   235			goto failed;
   236	
   237		/* check whether this EC is a sensor hub. */
   238		if (cros_ec_get_sensor_count(ec) > 0) {
   239			retval = mfd_add_hotplug_devices(ec->dev,
   240					cros_ec_sensorhub_cells,
   241					ARRAY_SIZE(cros_ec_sensorhub_cells));
   242			if (retval)
   243				dev_err(ec->dev, "failed to add %s subdevice: %d\n",
   244					cros_ec_sensorhub_cells->name, retval);
   245		}
   246	
   247		/*
   248		 * The following subdevices can be detected by sending the
   249		 * EC_FEATURE_GET_CMD Embedded Controller device.
   250		 */
   251		for (i = 0; i < ARRAY_SIZE(cros_subdevices); i++) {
   252			if (cros_ec_check_features(ec, cros_subdevices[i].id)) {
   253				retval = mfd_add_hotplug_devices(ec->dev,
   254							cros_subdevices[i].mfd_cells,
   255							cros_subdevices[i].num_cells);
   256				if (retval)
   257					dev_err(ec->dev,
   258						"failed to add %s subdevice: %d\n",
   259						cros_subdevices[i].mfd_cells->name,
   260						retval);
   261			}
   262		}
   263	
   264		/*
   265		 * FW nodes can load cros_ec_ucsi, but early PDC devices did not define
   266		 * the required nodes. On PDC systems without FW nodes for cros_ec_ucsi,
   267		 * the driver should be added as an mfd subdevice.
   268		 */
   269		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
   270		    cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM)) {
   271			struct device *acpi_dev = device_find_child(ec->ec_dev->dev,
   272								    NULL,
 > 273								    ucsi_acpi_match);
   274	
   275			if (!!acpi_dev) {
   276				put_device(acpi_dev);
   277			} else if (!of_find_compatible_node(NULL, NULL, "google,cros-ec-ucsi")) {
   278				retval = mfd_add_hotplug_devices(ec->dev,
   279							cros_ec_ucsi_cells,
   280							ARRAY_SIZE(cros_ec_ucsi_cells));
   281				if (retval)
   282					dev_warn(ec->dev,
   283						 "failed to add cros_ec_ucsi: %d\n",
   284						 retval);
   285			}
   286		}
   287	
   288		/*
   289		 * UCSI provides power supply information so we don't need to separately
   290		 * load the cros_usbpd_charger driver.
   291		 */
   292		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
   293		    !cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM)) {
   294			retval = mfd_add_hotplug_devices(ec->dev,
   295							 cros_usbpd_charger_cells,
   296							 ARRAY_SIZE(cros_usbpd_charger_cells));
   297	
   298			if (retval)
   299				dev_warn(ec->dev, "failed to add usbpd-charger: %d\n",
   300					 retval);
   301		}
   302	
   303		/*
   304		 * Lightbar is a special case. Newer devices support autodetection,
   305		 * but older ones do not.
   306		 */
   307		if (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
   308		    dmi_match(DMI_PRODUCT_NAME, "Link")) {
   309			retval = mfd_add_hotplug_devices(ec->dev,
   310						cros_ec_lightbar_cells,
   311						ARRAY_SIZE(cros_ec_lightbar_cells));
   312			if (retval)
   313				dev_warn(ec->dev, "failed to add lightbar: %d\n",
   314					 retval);
   315		}
   316	
   317		/*
   318		 * The PD notifier driver cell is separate since it only needs to be
   319		 * explicitly added on platforms that don't have the PD notifier ACPI
   320		 * device entry defined.
   321		 */
   322		if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
   323			if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
   324				retval = mfd_add_hotplug_devices(ec->dev,
   325						cros_usbpd_notify_cells,
   326						ARRAY_SIZE(cros_usbpd_notify_cells));
   327				if (retval)
   328					dev_err(ec->dev,
   329						"failed to add PD notify devices: %d\n",
   330						retval);
   331			}
   332		}
   333	
   334		/*
   335		 * The PCHG device cannot be detected by sending EC_FEATURE_GET_CMD, but
   336		 * it can be detected by querying the number of peripheral chargers.
   337		 */
   338		retval = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_PCHG_COUNT, NULL, 0,
   339				     &pchg_count, sizeof(pchg_count));
   340		if (retval >= 0 && pchg_count.port_count) {
   341			retval = mfd_add_hotplug_devices(ec->dev,
   342						cros_ec_pchg_cells,
   343						ARRAY_SIZE(cros_ec_pchg_cells));
   344			if (retval)
   345				dev_warn(ec->dev, "failed to add pchg: %d\n",
   346					 retval);
   347		}
   348	
   349		/*
   350		 * The following subdevices cannot be detected by sending the
   351		 * EC_FEATURE_GET_CMD to the Embedded Controller device.
   352		 */
   353		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_platform_cells,
   354						 ARRAY_SIZE(cros_ec_platform_cells));
   355		if (retval)
   356			dev_warn(ec->dev,
   357				 "failed to add cros-ec platform devices: %d\n",
   358				 retval);
   359	
   360		/* Check whether this EC instance has a VBC NVRAM */
   361		node = ec->ec_dev->dev->of_node;
   362		if (of_property_read_bool(node, "google,has-vbc-nvram")) {
   363			retval = mfd_add_hotplug_devices(ec->dev, cros_ec_vbc_cells,
   364							ARRAY_SIZE(cros_ec_vbc_cells));
   365			if (retval)
   366				dev_warn(ec->dev, "failed to add VBC devices: %d\n",
   367					 retval);
   368		}
   369	
   370		return 0;
   371	
   372	failed:
   373		put_device(&ec->class_dev);
   374		return retval;
   375	}
   376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

