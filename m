Return-Path: <linux-kernel+bounces-196216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BC8D58F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E428333A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BB44384;
	Fri, 31 May 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmrytSbx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624612110F;
	Fri, 31 May 2024 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125409; cv=none; b=dPoy0Hqp82cf0IAcpaf94WRBntgD3IQ2GoAdkJmnfgCLEp3+uPI772SkW8HY2PWy++nVOIYY89ScUnbEXuI14Stm8ReeijJyojprM/wT+AWqKh08hr3Kbq8Gu5LZ5xn9qC7ZDBZOTaxrVVvV7KbtJp53uR30S6YDd+8c3R4Wd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125409; c=relaxed/simple;
	bh=iyCW7kFSKDXz/X1KwEbJdlMwEoExWyUSJt412bkH+VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL7s3wfrbYs6+RJJIDwuyimKW37ohWL3dI4lHzL1/UuTXQwM2uy7PPSai4ejpiVJDk8ildV9cdfb8QrF37+Dtc3p7J0m2B2yp79lUgXsH8WaIwujKAO3jjQWBCiyohL/GY0lAc6fRaE+2t9nRQ3aBmShp/nrmny+cFJoquoemMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmrytSbx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717125406; x=1748661406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyCW7kFSKDXz/X1KwEbJdlMwEoExWyUSJt412bkH+VM=;
  b=UmrytSbxHO9IECaBfeKVTqU81xuxLR6XH8asFAoCZ2ZoIvLcdX2lVcPe
   ck0PdFYVRC9+FFd3T1+Ecd77/SVQ4K9SPd2p2GN0bH62h9m10n+vsk7hc
   CtMAApqyubM+oJ7CaslxVOyjtLBucA6L8GEyQ++PW2fRNi/iicFNh87xe
   bJdzd7UYXa0XZihdFC1ZWxdDuS6ZD8CaYTsWN3F+45V6k4WBrwXQxhzsw
   VG9m073K+ZmvRq7eOFJhwwnOpgkn3QQ7hEgsLSKJeLpo/MN2Pm9DSG15B
   jdu+q7Ls/qWOLeKccLLcp9V2bEhCgF+vKSX/eM7XvYtQlhZkL6+XxuN5B
   w==;
X-CSE-ConnectionGUID: zGt4a10QQeOLrSE5e3aGfA==
X-CSE-MsgGUID: GqD0dORNQKG1uyg96A/HQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13879849"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13879849"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 20:16:45 -0700
X-CSE-ConnectionGUID: 7RCSr1coRSadS/8n1Im5Ww==
X-CSE-MsgGUID: TJKVUWf4SJ6j9iBpxstteA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40477855"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 May 2024 20:16:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCsky-000GRT-2p;
	Fri, 31 May 2024 03:16:40 +0000
Date: Fri, 31 May 2024 11:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v5] drivers: hwmon: max31827: Add PEC support
Message-ID: <202405311134.f2ALUwLL-lkp@intel.com>
References: <20240530112505.14831-1-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112505.14831-1-radu.sabau@analog.com>

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau/drivers-hwmon-max31827-Add-PEC-support/20240530-192727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240530112505.14831-1-radu.sabau%40analog.com
patch subject: [PATCH v5] drivers: hwmon: max31827: Add PEC support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240531/202405311134.f2ALUwLL-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405311134.f2ALUwLL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405311134.f2ALUwLL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/hwmon/max31827.c:336:32: error: declaration of anonymous struct must be a definition
     336 | static int max31827_chip_write(struct *regmap, u32 attr, long val)
         |                                ^
>> drivers/hwmon/max31827.c:339:7: error: use of undeclared identifier 'hwmon_chip_pec'; did you mean 'hwmon_chip'?
     339 |         case hwmon_chip_pec:
         |              ^~~~~~~~~~~~~~
         |              hwmon_chip
   include/linux/hwmon.h:21:2: note: 'hwmon_chip' declared here
      21 |         hwmon_chip,
         |         ^
>> drivers/hwmon/max31827.c:340:29: error: use of undeclared identifier 'regmap'
     340 |                 return regmap_update_bits(regmap, MAX31827_CONFIGURATION_REG,
         |                                           ^
>> drivers/hwmon/max31827.c:341:8: error: use of undeclared identifier 'MAX38127_CONFIGURATION_PEC_EN_MASK'
     341 |                                           MAX38127_CONFIGURATION_PEC_EN_MASK,
         |                                           ^
   drivers/hwmon/max31827.c:342:14: error: use of undeclared identifier 'MAX38127_CONFIGURATION_PEC_EN_MASK'
     342 |                                           val ? MAX38127_CONFIGURATION_PEC_EN_MASK : 0);
         |                                                 ^
>> drivers/hwmon/max31827.c:357:48: error: too many arguments to function call, expected 2, have 3
     357 |                 return max31827_chip_write(st->regmap, attr, val);
         |                        ~~~~~~~~~~~~~~~~~~~                   ^~~
   drivers/hwmon/max31827.c:336:12: note: 'max31827_chip_write' declared here
     336 | static int max31827_chip_write(struct *regmap, u32 attr, long val)
         |            ^                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/max31827.c:399:7: error: duplicate case value 'hwmon_chip'
     399 |         case hwmon_chip:
         |              ^
   drivers/hwmon/max31827.c:356:7: note: previous case defined here
     356 |         case hwmon_chip:
         |              ^
>> drivers/hwmon/max31827.c:601:53: error: use of undeclared identifier 'HWMON_C_PEC'
     601 |         HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL | HWMON_C_PEC),
         |                                                            ^
   7 warnings and 8 errors generated.


vim +336 drivers/hwmon/max31827.c

   335	
 > 336	static int max31827_chip_write(struct *regmap, u32 attr, long val)
   337	{
   338		switch (attr) {
 > 339		case hwmon_chip_pec:
 > 340			return regmap_update_bits(regmap, MAX31827_CONFIGURATION_REG,
 > 341						  MAX38127_CONFIGURATION_PEC_EN_MASK,
 > 342						  val ? MAX38127_CONFIGURATION_PEC_EN_MASK : 0);
   343		default:
   344			return -EOPNOTSUPP;
   345		}
   346	}
   347	
   348	static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
   349				  u32 attr, int channel, long val)
   350	{
   351		struct max31827_state *st = dev_get_drvdata(dev);
   352		int res = 1;
   353		int ret;
   354	
   355		switch (type) {
   356		case hwmon_chip:
 > 357			return max31827_chip_write(st->regmap, attr, val);
   358		case hwmon_temp:
   359			switch (attr) {
   360			case hwmon_temp_enable:
   361				if (val >> 1)
   362					return -EINVAL;
   363	
   364				mutex_lock(&st->lock);
   365				/**
   366				 * The chip should not be enabled while a conversion is
   367				 * performed. Neither should the chip be enabled when
   368				 * the alarm values are changed.
   369				 */
   370	
   371				st->enable = val;
   372	
   373				ret = regmap_update_bits(st->regmap,
   374							 MAX31827_CONFIGURATION_REG,
   375							 MAX31827_CONFIGURATION_1SHOT_MASK |
   376							 MAX31827_CONFIGURATION_CNV_RATE_MASK,
   377							 MAX31827_DEVICE_ENABLE(val));
   378	
   379				mutex_unlock(&st->lock);
   380	
   381				return ret;
   382	
   383			case hwmon_temp_max:
   384				return write_alarm_val(st, MAX31827_TH_REG, val);
   385	
   386			case hwmon_temp_max_hyst:
   387				return write_alarm_val(st, MAX31827_TH_HYST_REG, val);
   388	
   389			case hwmon_temp_min:
   390				return write_alarm_val(st, MAX31827_TL_REG, val);
   391	
   392			case hwmon_temp_min_hyst:
   393				return write_alarm_val(st, MAX31827_TL_HYST_REG, val);
   394	
   395			default:
   396				return -EOPNOTSUPP;
   397			}
   398	
 > 399		case hwmon_chip:
   400			if (attr == hwmon_chip_update_interval) {
   401				if (!st->enable)
   402					return -EINVAL;
   403	
   404				/*
   405				 * Convert the desired conversion rate into register
   406				 * bits. res is already initialized with 1.
   407				 *
   408				 * This was inspired by lm73 driver.
   409				 */
   410				while (res < ARRAY_SIZE(max31827_conversions) &&
   411				       val < max31827_conversions[res])
   412					res++;
   413	
   414				if (res == ARRAY_SIZE(max31827_conversions))
   415					res = ARRAY_SIZE(max31827_conversions) - 1;
   416	
   417				res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
   418						 res);
   419	
   420				ret = regmap_update_bits(st->regmap,
   421							 MAX31827_CONFIGURATION_REG,
   422							 MAX31827_CONFIGURATION_CNV_RATE_MASK,
   423							 res);
   424				if (ret)
   425					return ret;
   426	
   427				st->update_interval = val;
   428			}
   429			break;
   430	
   431		default:
   432			return -EOPNOTSUPP;
   433		}
   434	
   435		return 0;
   436	}
   437	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

