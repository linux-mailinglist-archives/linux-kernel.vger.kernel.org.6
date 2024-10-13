Return-Path: <linux-kernel+bounces-362701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670E99B83C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C619B1F218BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 04:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA381304AB;
	Sun, 13 Oct 2024 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYo/yf9U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302C22097
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728794680; cv=none; b=ogOz2KqTsby2j87s0bu4z3fgLBUh9Vp+0E7UamlO9b2Re0Ig3iNQu0Y46QyJU9We5tWyWEfuPShnYNsqKqUGJx5+s2bEAf7xY4o8OYxvblRb9MzpmBsJjFdL0P7uyureSsXres7wWP8MmDve3FVNZ41AoREXndCwyMm/n1TkOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728794680; c=relaxed/simple;
	bh=tRYYBLYXXs4vYSkw5VwRO6CEPfI+MUG+AO9xmzYTguo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B5sgcHzqNX+vOKyDcg0ehzCSQd8T8PySKa+l4sf0v1ncI06iHbVY0zoRSkLmK/UAOS2Bw0rBeq1gdAWXAGklt1Vt3BYDDOF06LxEQL496PdV2SOSFzZGP2xZA2rxBKf5DQylEkX9E7HGIlqczOer3gGtA2uQZTEDFRvGtPdrYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYo/yf9U; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728794678; x=1760330678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tRYYBLYXXs4vYSkw5VwRO6CEPfI+MUG+AO9xmzYTguo=;
  b=lYo/yf9Uusc5U0ma0G4TvRAwmOAys5A6CTk6xPzc2bEcYhkz0BxB7TAP
   Gs60uLLuyUDasRV5j1oZlupsnyixQi+IF4DS6rXhhkk0MzFfURuACzcbL
   5S1zhiePtn/4XsVMMVkohRGhtWHx8a4XinQpbc5UBooLplLzK4Fw3QfIh
   jeUZTkbTRwyKbjLgDC+4+F+FQnXEDlhbfLMv7IB0/tuui0W3DybI1johS
   70C5ou9vB72AKfPIbsNEIn9LAOif/lviiEnMK0OJUCmnMp2s7UkOn0kM7
   5W74DnD2fn+i605deD5SJjylaaCANHQIvrF1VynbBBaglRwaH/L8Zx3UP
   w==;
X-CSE-ConnectionGUID: 8Kr7quUHQ52SnxLCI0VBGw==
X-CSE-MsgGUID: 917KJxpNRxqfiNb0soUrkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28034615"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28034615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 21:44:37 -0700
X-CSE-ConnectionGUID: azdCyP97R9inLPCqJxrZqg==
X-CSE-MsgGUID: KxkfXUfkSa+TubNbwaiDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="81823992"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Oct 2024 21:44:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szqT3-000E5z-2y;
	Sun, 13 Oct 2024 04:44:33 +0000
Date: Sun, 13 Oct 2024 12:44:29 +0800
From: kernel test robot <lkp@intel.com>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: drivers/hwmon/scpi-hwmon.c:115:19: warning: 'snprintf' output may be
 truncated before the last format character
Message-ID: <202410131210.VThsB2aJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   36c254515dc6592c44db77b84908358979dd6b50
commit: ea98b29a05e9c70dbe159cbc6254d111059a2bb9 hwmon: Support sensors exported via ARM SCP interface
date:   9 years ago
config: arm64-randconfig-004-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131210.VThsB2aJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131210.VThsB2aJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131210.VThsB2aJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/bug.h:62:0,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/arm64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:64,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from drivers/hwmon/scpi-hwmon.c:18:
   include/linux/gfp.h: In function 'gfp_zone':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    #define BUG_ON(condition) do { if (condition) ; } while (0)
                                                  ^
   include/linux/mmdebug.h:17:25: note: in expansion of macro 'BUG_ON'
    #define VM_BUG_ON(cond) BUG_ON(cond)
                            ^~~~~~
   include/linux/gfp.h:255:2: note: in expansion of macro 'VM_BUG_ON'
     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
     ^~~~~~~~~
   include/linux/gfp.h: In function '__alloc_pages_node':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    #define BUG_ON(condition) do { if (condition) ; } while (0)
                                                  ^
   include/linux/mmdebug.h:17:25: note: in expansion of macro 'BUG_ON'
    #define VM_BUG_ON(cond) BUG_ON(cond)
                            ^~~~~~
   include/linux/gfp.h:313:2: note: in expansion of macro 'VM_BUG_ON'
     VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
     ^~~~~~~~~
   include/linux/seq_file.h: In function 'seq_get_buf':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    #define BUG_ON(condition) do { if (condition) ; } while (0)
                                                  ^
   include/linux/seq_file.h:70:2: note: in expansion of macro 'BUG_ON'
     BUG_ON(m->count > m->size);
     ^~~~~~
   include/linux/seq_file.h: In function 'seq_commit':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    #define BUG_ON(condition) do { if (condition) ; } while (0)
                                                  ^
   include/linux/seq_file.h:93:3: note: in expansion of macro 'BUG_ON'
      BUG_ON(m->count + num > m->size);
      ^~~~~~
   drivers/hwmon/scpi-hwmon.c: In function 'scpi_hwmon_probe':
>> drivers/hwmon/scpi-hwmon.c:115:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "temp%d_input", num_temp + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:114:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "temp%d_input", num_temp + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:117:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "temp%d_label", num_temp + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:116:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "temp%d_label", num_temp + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:129:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "curr%d_input", num_current + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:128:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "curr%d_input", num_current + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/scpi-hwmon.c:131:19: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
         "curr%d_label", num_current + 1);
                      ^
   drivers/hwmon/scpi-hwmon.c:130:4: note: 'snprintf' output between 12 and 21 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "curr%d_label", num_current + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/scpi-hwmon.c:136:14: warning: '_input' directive output may be truncated writing 6 bytes into a region of size between 5 and 14 [-Wformat-truncation=]
         "power%d_input", num_power + 1);
                 ^~~~~~
   drivers/hwmon/scpi-hwmon.c:135:4: note: 'snprintf' output between 13 and 22 bytes into a destination of size 20
       snprintf(sensor->input, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "power%d_input", num_power + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/scpi-hwmon.c:138:14: warning: '_label' directive output may be truncated writing 6 bytes into a region of size between 5 and 14 [-Wformat-truncation=]
         "power%d_label", num_power + 1);
                 ^~~~~~
   drivers/hwmon/scpi-hwmon.c:137:4: note: 'snprintf' output between 13 and 22 bytes into a destination of size 20
       snprintf(sensor->label, sizeof(sensor->input),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "power%d_label", num_power + 1);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +115 drivers/hwmon/scpi-hwmon.c

    68	
    69	static int scpi_hwmon_probe(struct platform_device *pdev)
    70	{
    71		u16 nr_sensors, i;
    72		int num_temp = 0, num_volt = 0, num_current = 0, num_power = 0;
    73		struct scpi_ops *scpi_ops;
    74		struct device *hwdev, *dev = &pdev->dev;
    75		struct scpi_sensors *scpi_sensors;
    76		int ret;
    77	
    78		scpi_ops = get_scpi_ops();
    79		if (!scpi_ops)
    80			return -EPROBE_DEFER;
    81	
    82		ret = scpi_ops->sensor_get_capability(&nr_sensors);
    83		if (ret)
    84			return ret;
    85	
    86		if (!nr_sensors)
    87			return -ENODEV;
    88	
    89		scpi_sensors = devm_kzalloc(dev, sizeof(*scpi_sensors), GFP_KERNEL);
    90		if (!scpi_sensors)
    91			return -ENOMEM;
    92	
    93		scpi_sensors->data = devm_kcalloc(dev, nr_sensors,
    94					   sizeof(*scpi_sensors->data), GFP_KERNEL);
    95		if (!scpi_sensors->data)
    96			return -ENOMEM;
    97	
    98		scpi_sensors->attrs = devm_kcalloc(dev, (nr_sensors * 2) + 1,
    99					   sizeof(*scpi_sensors->attrs), GFP_KERNEL);
   100		if (!scpi_sensors->attrs)
   101			return -ENOMEM;
   102	
   103		scpi_sensors->scpi_ops = scpi_ops;
   104	
   105		for (i = 0; i < nr_sensors; i++) {
   106			struct sensor_data *sensor = &scpi_sensors->data[i];
   107	
   108			ret = scpi_ops->sensor_get_info(i, &sensor->info);
   109			if (ret)
   110				return ret;
   111	
   112			switch (sensor->info.class) {
   113			case TEMPERATURE:
   114				snprintf(sensor->input, sizeof(sensor->input),
 > 115					 "temp%d_input", num_temp + 1);
   116				snprintf(sensor->label, sizeof(sensor->input),
   117					 "temp%d_label", num_temp + 1);
   118				num_temp++;
   119				break;
   120			case VOLTAGE:
   121				snprintf(sensor->input, sizeof(sensor->input),
   122					 "in%d_input", num_volt);
   123				snprintf(sensor->label, sizeof(sensor->input),
   124					 "in%d_label", num_volt);
   125				num_volt++;
   126				break;
   127			case CURRENT:
   128				snprintf(sensor->input, sizeof(sensor->input),
   129					 "curr%d_input", num_current + 1);
   130				snprintf(sensor->label, sizeof(sensor->input),
 > 131					 "curr%d_label", num_current + 1);
   132				num_current++;
   133				break;
   134			case POWER:
   135				snprintf(sensor->input, sizeof(sensor->input),
 > 136					 "power%d_input", num_power + 1);
   137				snprintf(sensor->label, sizeof(sensor->input),
 > 138					 "power%d_label", num_power + 1);
   139				num_power++;
   140				break;
   141			default:
   142				break;
   143			}
   144	
   145			sensor->dev_attr_input.attr.mode = S_IRUGO;
   146			sensor->dev_attr_input.show = scpi_show_sensor;
   147			sensor->dev_attr_input.attr.name = sensor->input;
   148	
   149			sensor->dev_attr_label.attr.mode = S_IRUGO;
   150			sensor->dev_attr_label.show = scpi_show_label;
   151			sensor->dev_attr_label.attr.name = sensor->label;
   152	
   153			scpi_sensors->attrs[i << 1] = &sensor->dev_attr_input.attr;
   154			scpi_sensors->attrs[(i << 1) + 1] = &sensor->dev_attr_label.attr;
   155	
   156			sysfs_attr_init(scpi_sensors->attrs[i << 1]);
   157			sysfs_attr_init(scpi_sensors->attrs[(i << 1) + 1]);
   158		}
   159	
   160		scpi_sensors->group.attrs = scpi_sensors->attrs;
   161		scpi_sensors->groups[0] = &scpi_sensors->group;
   162	
   163		hwdev = devm_hwmon_device_register_with_groups(dev,
   164				"scpi_sensors", scpi_sensors, scpi_sensors->groups);
   165	
   166		return PTR_ERR_OR_ZERO(hwdev);
   167	}
   168	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

