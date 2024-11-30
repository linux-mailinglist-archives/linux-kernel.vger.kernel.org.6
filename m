Return-Path: <linux-kernel+bounces-426013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01F9DEDBF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10946163E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC33C0B;
	Sat, 30 Nov 2024 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnquQtlO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8719A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925050; cv=none; b=r5pNoJnpqKpw4gLAHdNtVZ+vI2jCUXb6D4/hlIp4403Q5N5TBCrEjtYyzMZ8FFqDO6jh43HvNadzSVt5lPMOO1L2Ua70TdWSDjTjtK5tuHyubLJ2vJzHW7p1W1hqbXsiMiflcOcfostfQVkqpuj3NHbOZk2vq8LDI37qPhkMFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925050; c=relaxed/simple;
	bh=WK+FkrwhEhO3iSPTKIq+4mMCSGY5fsyRvxavMS5y/PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t0cE7al9+7QC56bPPdfPR7ZMxjxWATCWkTrz1fr8bZY5lnaB9c2OV4nRVX7i4m26mCO4+DUQWLI+2Lt3T/IRRogdWgljpO/OYb331+/g0giiq47nRRwOYYm2mzZw4pKVEmSriLHXWu0O8aEDdptbGjUTp/E5xxfg4zZX6qoX5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnquQtlO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732925049; x=1764461049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WK+FkrwhEhO3iSPTKIq+4mMCSGY5fsyRvxavMS5y/PM=;
  b=VnquQtlOUBPgQuKWXBG4DI4g+DK0x+asE297Q4HjfoE7bOq/p2edyIgm
   lX85W4hfX5cTvva0mA2xCpgFdsoUrfndv4kafzgKeEoVbUJGDdajR9oQp
   xlyjTR6zgpgG4I/mrw0tow5ckKZd/wxarqLhnRMjQxm9DToJ0kqQ5OExi
   HHktdjGvtj33l9drfDnOXihB8+nEbddPVV0xtwQZKVzgy6aJriYPc/p3D
   N95cB9w0XT/FHv9met5WX7s57WbAC/ywaL7ZczpWLHWnRgMByYnITeyPX
   AIS+GtFDvoS+CojP94KsjOSkS6pFuCQjZRnFyanoM4eYXwD+d30SIq50g
   A==;
X-CSE-ConnectionGUID: dgIPmu1/S86g/rBXr5Lwcw==
X-CSE-MsgGUID: x99t9ZCYTT+vJ0V0+M+NZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="43648965"
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="43648965"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 16:04:09 -0800
X-CSE-ConnectionGUID: LRc9DJpdTTmnN7dzKC4fMw==
X-CSE-MsgGUID: eKKdDLjLSRe8YLD6uFOZxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,197,1728975600"; 
   d="scan'208";a="92685753"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Nov 2024 16:04:08 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHAxx-0000ma-0q;
	Sat, 30 Nov 2024 00:04:05 +0000
Date: Sat, 30 Nov 2024 08:03:16 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/x86-android-tablets/lenovo.c:604:30: sparse:
 sparse: symbol 'lenovo_yoga_tab2_1380_bq24190_pdata' was not declared.
 Should it be static?
Message-ID: <202411300756.2nxL7nIJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 3eee73ad42c3899d97e073bf2c41e7670a3c575c platform/x86: x86-android-tablets: Add Lenovo Yoga Tablet 2 Pro 1380F/L data
date:   8 months ago
config: i386-randconfig-061-20241130 (https://download.01.org/0day-ci/archive/20241130/202411300756.2nxL7nIJ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411300756.2nxL7nIJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411300756.2nxL7nIJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/x86-android-tablets/lenovo.c:604:30: sparse: sparse: symbol 'lenovo_yoga_tab2_1380_bq24190_pdata' was not declared. Should it be static?
>> drivers/platform/x86/x86-android-tablets/lenovo.c:729:12: sparse: sparse: symbol 'lenovo_yoga_tab2_1380_modules' was not declared. Should it be static?

vim +/lenovo_yoga_tab2_1380_bq24190_pdata +604 drivers/platform/x86/x86-android-tablets/lenovo.c

   603	
 > 604	struct bq24190_platform_data lenovo_yoga_tab2_1380_bq24190_pdata = {
   605		.regulator_init_data = &lenovo_yoga_tab2_1380_bq24190_vbus_init_data,
   606	};
   607	
   608	static const struct property_entry lenovo_yoga_tab2_1380_lc824206xa_props[] = {
   609		PROPERTY_ENTRY_BOOL("onnn,enable-miclr-for-dcp"),
   610		{ }
   611	};
   612	
   613	static const struct software_node lenovo_yoga_tab2_1380_lc824206xa_node = {
   614		.properties = lenovo_yoga_tab2_1380_lc824206xa_props,
   615	};
   616	
   617	static const char * const lenovo_yoga_tab2_1380_lms303d_mount_matrix[] = {
   618		"0", "-1", "0",
   619		"-1", "0", "0",
   620		"0", "0", "1"
   621	};
   622	
   623	static const struct property_entry lenovo_yoga_tab2_1380_lms303d_props[] = {
   624		PROPERTY_ENTRY_STRING_ARRAY("mount-matrix", lenovo_yoga_tab2_1380_lms303d_mount_matrix),
   625		{ }
   626	};
   627	
   628	static const struct software_node lenovo_yoga_tab2_1380_lms303d_node = {
   629		.properties = lenovo_yoga_tab2_1380_lms303d_props,
   630	};
   631	
   632	static const struct x86_i2c_client_info lenovo_yoga_tab2_1380_i2c_clients[] __initconst = {
   633		{
   634			/* BQ27541 fuel-gauge */
   635			.board_info = {
   636				.type = "bq27541",
   637				.addr = 0x55,
   638				.dev_name = "bq27541",
   639				.swnode = &fg_bq24190_supply_node,
   640			},
   641			.adapter_path = "\\_SB_.I2C1",
   642		}, {
   643			/* bq24292i battery charger */
   644			.board_info = {
   645				.type = "bq24190",
   646				.addr = 0x6b,
   647				.dev_name = "bq24292i",
   648				.swnode = &lenovo_yoga_tab2_1380_bq24190_node,
   649				.platform_data = &lenovo_yoga_tab2_1380_bq24190_pdata,
   650			},
   651			.adapter_path = "\\_SB_.I2C1",
   652			.irq_data = {
   653				.type = X86_ACPI_IRQ_TYPE_GPIOINT,
   654				.chip = "INT33FC:02",
   655				.index = 2,
   656				.trigger = ACPI_EDGE_SENSITIVE,
   657				.polarity = ACPI_ACTIVE_HIGH,
   658				.con_id = "bq24292i_irq",
   659			},
   660		}, {
   661			/* LP8557 Backlight controller */
   662			.board_info = {
   663				.type = "lp8557",
   664				.addr = 0x2c,
   665				.dev_name = "lp8557",
   666				.platform_data = &lenovo_lp8557_pwm_and_reg_pdata,
   667			},
   668			.adapter_path = "\\_SB_.I2C3",
   669		}, {
   670			/* LC824206XA Micro USB Switch */
   671			.board_info = {
   672				.type = "lc824206xa",
   673				.addr = 0x48,
   674				.dev_name = "lc824206xa",
   675				.swnode = &lenovo_yoga_tab2_1380_lc824206xa_node,
   676			},
   677			.adapter_path = "\\_SB_.I2C3",
   678			.irq_data = {
   679				.type = X86_ACPI_IRQ_TYPE_GPIOINT,
   680				.chip = "INT33FC:02",
   681				.index = 1,
   682				.trigger = ACPI_LEVEL_SENSITIVE,
   683				.polarity = ACPI_ACTIVE_LOW,
   684				.con_id = "lc824206xa_irq",
   685			},
   686		}, {
   687			/* AL3320A ambient light sensor */
   688			.board_info = {
   689				.type = "al3320a",
   690				.addr = 0x1c,
   691				.dev_name = "al3320a",
   692			},
   693			.adapter_path = "\\_SB_.I2C5",
   694		}, {
   695			/* LSM303DA accelerometer + magnetometer */
   696			.board_info = {
   697				.type = "lsm303d",
   698				.addr = 0x1d,
   699				.dev_name = "lsm303d",
   700				.swnode = &lenovo_yoga_tab2_1380_lms303d_node,
   701			},
   702			.adapter_path = "\\_SB_.I2C5",
   703		}, {
   704			/* Synaptics RMI touchscreen */
   705			.board_info = {
   706				.type = "rmi4_i2c",
   707				.addr = 0x38,
   708				.dev_name = "rmi4_i2c",
   709				.platform_data = &lenovo_yoga_tab2_830_1050_rmi_pdata,
   710			},
   711			.adapter_path = "\\_SB_.I2C6",
   712			.irq_data = {
   713				.type = X86_ACPI_IRQ_TYPE_APIC,
   714				.index = 0x45,
   715				.trigger = ACPI_EDGE_SENSITIVE,
   716				.polarity = ACPI_ACTIVE_HIGH,
   717			},
   718		}
   719	};
   720	
   721	static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initconst = {
   722		{
   723			/* For the Tablet 2 Pro 1380's custom fast charging driver */
   724			.name = "lenovo-yoga-tab2-pro-1380-fastcharger",
   725			.id = PLATFORM_DEVID_NONE,
   726		},
   727	};
   728	
 > 729	const char * const lenovo_yoga_tab2_1380_modules[] __initconst = {
   730		"bq24190_charger",            /* For the Vbus regulator for lc824206xa */
   731		NULL
   732	};
   733	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

