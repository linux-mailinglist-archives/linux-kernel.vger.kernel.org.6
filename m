Return-Path: <linux-kernel+bounces-426596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C389DF56A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8046F162495
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0613D509;
	Sun,  1 Dec 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HajdhURB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4517E111
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733053736; cv=none; b=KjQtO3xIDZTkiTb6Vs3pk4FKT4WkLZEtCWQ1SUy2GaGmUt1wsGw05/ck71eOiMe1ddZTFOX8+wcLRhq5aZRL4wcI0nUVZ2g8hAyvyiXoWr6v/ikgsU4p9XVvFc9ApyX/6xVMy43xYofM4srDqLTx33nbastzM1V39i1Vm8NOlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733053736; c=relaxed/simple;
	bh=M86sxjlQe9/Xmtml2kDFrAWKg6HV+R2zDkqdlrQ4lUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e6lDwfHAxYSuGYW2M5igwuiHu5CnQ+mQh1rZDYyP+2+j6W4p4vXcCBpp51rD7ICG2AkzG5RrXbA/16RhS9RpL5Tqqmgw50i35lgaR3NBSwsdR51YZ5JLLdUMA+pg5BkSR1WMreBpYy11fw0pmpZiqjaM6JpCFRLyBINftHeb/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HajdhURB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733053735; x=1764589735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M86sxjlQe9/Xmtml2kDFrAWKg6HV+R2zDkqdlrQ4lUA=;
  b=HajdhURBzmz93QvJv/rJ2f0I/rJWeynTPZmyB+fp5c9EFxy3lkllpzFp
   x5qcXBNwuMvH0iyq0yeOm0eBoiNxPJbuvVZzJuDP4MztLYVP3GlChKaED
   Si2tJXZUS6TDKxAxRdhijDIWKkRQwt+4NsKlG6cyhXp9cB8V739Gf7MNS
   IxpsuJ4zBai+H72ND9UIlUO/XIRR1wXKxhDoVr9XgtFWu5Ap6Pxa0LTTr
   giqEpdnOL9HgGmXIvJ4gcfpH9ZQD8nPCxIy1aD947VpAq1s6qa9HtZh9a
   XJiWLqVVq7KXU8NOV01qPBfuKENKxNousJxU6S8IO1dhCX8eE8h5yAgwu
   g==;
X-CSE-ConnectionGUID: /BZwlPwzSqSdiYavmwp2AA==
X-CSE-MsgGUID: CVrcu/1ISBCNnPJTT3zcJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33099605"
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="33099605"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 03:48:54 -0800
X-CSE-ConnectionGUID: GsAUQ0PaSCqYxQ7nlUoP6g==
X-CSE-MsgGUID: jR6XAsPLRIyOqIdj5a6Y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="92668077"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Dec 2024 03:48:52 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHiRE-0001VR-34;
	Sun, 01 Dec 2024 11:48:36 +0000
Date: Sun, 1 Dec 2024 19:47:27 +0800
From: kernel test robot <lkp@intel.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/adc/at91-sama5d2_adc.c:374: warning: Excess struct
 member 'adc_channels' description in 'at91_adc_platform'
Message-ID: <202412011904.wH9p6YVx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
commit: 8940de2e48902e95b588b6244d5a1b61a4d75c4a iio: adc: at91-sama5d2_adc: convert to platform specific data structures
date:   3 years, 3 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241201/202412011904.wH9p6YVx-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011904.wH9p6YVx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011904.wH9p6YVx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/at91-sama5d2_adc.c:374: warning: Excess struct member 'adc_channels' description in 'at91_adc_platform'


vim +374 drivers/iio/adc/at91-sama5d2_adc.c

   269	
   270	#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
   271		{								\
   272			.type = IIO_VOLTAGE,					\
   273			.channel = num,						\
   274			.address = addr,					\
   275			.scan_index = index,					\
   276			.scan_type = {						\
   277				.sign = 'u',					\
   278				.realbits = 14,					\
   279				.storagebits = 16,				\
   280			},							\
   281			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
   282			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
   283			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
   284					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
   285			.datasheet_name = "CH"#num,				\
   286			.indexed = 1,						\
   287		}
   288	
   289	#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
   290		{								\
   291			.type = IIO_VOLTAGE,					\
   292			.differential = 1,					\
   293			.channel = num,						\
   294			.channel2 = num2,					\
   295			.address = addr,					\
   296			.scan_index = index,					\
   297			.scan_type = {						\
   298				.sign = 's',					\
   299				.realbits = 14,					\
   300				.storagebits = 16,				\
   301			},							\
   302			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
   303			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
   304			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
   305					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
   306			.datasheet_name = "CH"#num"-CH"#num2,			\
   307			.indexed = 1,						\
   308		}
   309	
   310	#define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
   311		{								\
   312			.type = IIO_POSITIONRELATIVE,				\
   313			.modified = 1,						\
   314			.channel = num,						\
   315			.channel2 = mod,					\
   316			.scan_index = num,					\
   317			.scan_type = {						\
   318				.sign = 'u',					\
   319				.realbits = 12,					\
   320				.storagebits = 16,				\
   321			},							\
   322			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
   323			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
   324					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
   325			.datasheet_name = name,					\
   326		}
   327	#define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
   328		{								\
   329			.type = IIO_PRESSURE,					\
   330			.channel = num,						\
   331			.scan_index = num,					\
   332			.scan_type = {						\
   333				.sign = 'u',					\
   334				.realbits = 12,					\
   335				.storagebits = 16,				\
   336			},							\
   337			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
   338			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
   339					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
   340			.datasheet_name = name,					\
   341		}
   342	
   343	#define at91_adc_readl(st, reg)						\
   344		readl_relaxed((st)->base + (st)->soc_info.platform->layout->reg)
   345	#define at91_adc_read_chan(st, reg)					\
   346		readl_relaxed((st)->base + reg)
   347	#define at91_adc_writel(st, reg, val)					\
   348		writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
   349	
   350	/**
   351	 * struct at91_adc_platform - at91-sama5d2 platform information struct
   352	 * @layout:		pointer to the reg layout struct
   353	 * @adc_channels:	pointer to an array of channels for registering in
   354	 *			the iio subsystem
   355	 * @nr_channels:	number of physical channels available
   356	 * @touch_chan_x:	index of the touchscreen X channel
   357	 * @touch_chan_y:	index of the touchscreen Y channel
   358	 * @touch_chan_p:	index of the touchscreen P channel
   359	 * @max_channels:	number of total channels
   360	 * @max_index:		highest channel index (highest index may be higher
   361	 *			than the total channel number)
   362	 * @hw_trig_cnt:	number of possible hardware triggers
   363	 */
   364	struct at91_adc_platform {
   365		const struct at91_adc_reg_layout	*layout;
   366		const struct iio_chan_spec		(*adc_channels)[];
   367		unsigned int				nr_channels;
   368		unsigned int				touch_chan_x;
   369		unsigned int				touch_chan_y;
   370		unsigned int				touch_chan_p;
   371		unsigned int				max_channels;
   372		unsigned int				max_index;
   373		unsigned int				hw_trig_cnt;
 > 374	};
   375	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

