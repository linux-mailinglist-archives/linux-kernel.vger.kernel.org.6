Return-Path: <linux-kernel+bounces-424835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD99DBA07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F370BB221B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED181B373A;
	Thu, 28 Nov 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwb8TpWF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACC143C7E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806363; cv=none; b=XnnRslcB6TVrGVf+O4ETo+wOssYXmQJJ5AeuQ3psjsUlZxJKw1KGQOlLw/LbYpDR3/b1jtUnbq+SAdwZqsxceOO+MGO1hXlG3xmfsfe9m/dZ4Z5UnZUC6YFY5PDDliUI0aFZWSWaQgJcDEeI6q0Bb0kyhCVK1I1ofNNZvuMe+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806363; c=relaxed/simple;
	bh=Rt/78/cxh3j3w2s9KmYWZ56N6kK9udqbOk1XcHGYS8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Q09uv1ReC0RChThRQ5UJ+vmPmnHFhdetDp05Z1qGuRtExEce67PCSNQmDriRCKtUZyhXd/Da2Q+QqMF8wjnBNGZmlY/cDCue7jU/VWCPdBYcJ3v6XoX3N2WrgdrlvidsQ0kkvQL6Ii2Cq2LdIdNzbWNcpGbdfN4wF7yOFsmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwb8TpWF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732806362; x=1764342362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rt/78/cxh3j3w2s9KmYWZ56N6kK9udqbOk1XcHGYS8M=;
  b=dwb8TpWFi91EgOSXiCUXpNcKa88EKwl2KNxOYUvn/Usynue/nwGL2W3x
   MgC89OhFAkYC+hnaNESymzDIGbslKb7Pix4pZgD6wcVq06FEzXcXBoiwX
   U/+tOjdIZhStGWDIHTlo2ozH7ZIFbQWpDkKNT5EA38smBtp7rfW9pdIh2
   w8w1d434nQKcfCl9XuAciZC/FWBfJPMzkuljgoty/YRQ06KPnrFvEU8Js
   xqYJsvF1xmzI2vjQGXfgxrJCJrqvhun3/fwYqgfRlbWhq5w3E0aH8bwuh
   iCMgRtfBA4zg9by5yTIOPPrxw6VyjTscr/NMgtaLmjvhBgFhPfBnKpolv
   w==;
X-CSE-ConnectionGUID: bmC4RJyHTGSePM14a/X9jw==
X-CSE-MsgGUID: C8jUKXBGSH+LXC4dxl4CLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32788439"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32788439"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:06:01 -0800
X-CSE-ConnectionGUID: LSAnbzK9TUSjtwBZ8I8p0A==
X-CSE-MsgGUID: FR7LH26mRWe4M/jOu7VF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96349291"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Nov 2024 07:05:56 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGg5a-0009gx-1K;
	Thu, 28 Nov 2024 15:05:54 +0000
Date: Thu, 28 Nov 2024 23:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <David.Laight@aculab.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	'Arnd Bergmann' <arnd@kernel.org>, 'Jens Axboe' <axboe@kernel.dk>,
	'Matthew Wilcox' <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Dan Carpenter' <dan.carpenter@linaro.org>,
	"'Jason A . Donenfeld'" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
	'Mateusz Guzik' <mjguzik@gmail.com>,
	'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
Message-ID: <202411282222.oF0B4110-lkp@intel.com>
References: <8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20241121]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-h-Add-whitespace-around-operators-and-after-commas/20241121-152617
base:   next-20241121
patch link:    https://lore.kernel.org/r/8f69f4deac014f558bab186444bac2e8%40AcuMS.aculab.com
patch subject: [PATCH next 6/7] minmax.h: Simplify the variants of clamp()
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241128/202411282222.oF0B4110-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282222.oF0B4110-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282222.oF0B4110-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/magnetometer/yamaha-yas530.c:30:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/magnetometer/yamaha-yas530.c:414:20: warning: implicit conversion from 'unsigned long' to 'typeof (h[i])' (aka 'int') changes value from 18446744073709543424 to -8192 [-Wconstant-conversion]
     414 |                         clamp_val(h[i], -BIT(13), BIT(13) - 1);
         |                         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:233:66: note: expanded from macro 'clamp_val'
     233 | #define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/minmax.h:197:26: note: expanded from macro '__careful_clamp'
     197 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:188:14: note: expanded from macro '__clamp_once'
     188 |         type ulo = (lo);                                                        \
         |              ~~~    ^~
   5 warnings generated.


vim +414 drivers/iio/magnetometer/yamaha-yas530.c

de8860b1ed4701 Linus Walleij 2020-12-24  358  
65f79b50103067 Jakob Hauser  2022-08-13  359  /**
65f79b50103067 Jakob Hauser  2022-08-13  360   * yas537_measure() - Make a measure from the hardware
65f79b50103067 Jakob Hauser  2022-08-13  361   * @yas5xx: The device state
65f79b50103067 Jakob Hauser  2022-08-13  362   * @t: the raw temperature measurement
65f79b50103067 Jakob Hauser  2022-08-13  363   * @x: the raw x axis measurement
65f79b50103067 Jakob Hauser  2022-08-13  364   * @y1: the y1 axis measurement
65f79b50103067 Jakob Hauser  2022-08-13  365   * @y2: the y2 axis measurement
65f79b50103067 Jakob Hauser  2022-08-13  366   * @return: 0 on success or error code
65f79b50103067 Jakob Hauser  2022-08-13  367   */
65f79b50103067 Jakob Hauser  2022-08-13  368  static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
de8860b1ed4701 Linus Walleij 2020-12-24  369  {
65f79b50103067 Jakob Hauser  2022-08-13  370  	struct yas5xx_calibration *c = &yas5xx->calibration;
65f79b50103067 Jakob Hauser  2022-08-13  371  	unsigned int busy;
65f79b50103067 Jakob Hauser  2022-08-13  372  	u8 data[8];
65f79b50103067 Jakob Hauser  2022-08-13  373  	u16 xy1y2[3];
65f79b50103067 Jakob Hauser  2022-08-13  374  	s32 h[3], s[3];
65f79b50103067 Jakob Hauser  2022-08-13  375  	int i, ret;
65f79b50103067 Jakob Hauser  2022-08-13  376  
65f79b50103067 Jakob Hauser  2022-08-13  377  	mutex_lock(&yas5xx->lock);
65f79b50103067 Jakob Hauser  2022-08-13  378  
65f79b50103067 Jakob Hauser  2022-08-13  379  	/* Contrary to YAS530/532, also a "cont" bit is set, meaning unknown */
65f79b50103067 Jakob Hauser  2022-08-13  380  	ret = regmap_write(yas5xx->map, YAS537_MEASURE, YAS5XX_MEASURE_START |
65f79b50103067 Jakob Hauser  2022-08-13  381  			   YAS5XX_MEASURE_CONT);
65f79b50103067 Jakob Hauser  2022-08-13  382  	if (ret < 0)
65f79b50103067 Jakob Hauser  2022-08-13  383  		goto out_unlock;
65f79b50103067 Jakob Hauser  2022-08-13  384  
65f79b50103067 Jakob Hauser  2022-08-13  385  	/* Use same timeout like YAS530/532 but the bit is in data row 2 */
65f79b50103067 Jakob Hauser  2022-08-13  386  	ret = regmap_read_poll_timeout(yas5xx->map, YAS5XX_MEASURE_DATA + 2, busy,
65f79b50103067 Jakob Hauser  2022-08-13  387  				       !(busy & YAS5XX_MEASURE_DATA_BUSY),
65f79b50103067 Jakob Hauser  2022-08-13  388  				       500, 20000);
65f79b50103067 Jakob Hauser  2022-08-13  389  	if (ret) {
65f79b50103067 Jakob Hauser  2022-08-13  390  		dev_err(yas5xx->dev, "timeout waiting for measurement\n");
65f79b50103067 Jakob Hauser  2022-08-13  391  		goto out_unlock;
65f79b50103067 Jakob Hauser  2022-08-13  392  	}
65f79b50103067 Jakob Hauser  2022-08-13  393  
65f79b50103067 Jakob Hauser  2022-08-13  394  	ret = regmap_bulk_read(yas5xx->map, YAS5XX_MEASURE_DATA,
65f79b50103067 Jakob Hauser  2022-08-13  395  			       data, sizeof(data));
65f79b50103067 Jakob Hauser  2022-08-13  396  	if (ret)
65f79b50103067 Jakob Hauser  2022-08-13  397  		goto out_unlock;
65f79b50103067 Jakob Hauser  2022-08-13  398  
65f79b50103067 Jakob Hauser  2022-08-13  399  	mutex_unlock(&yas5xx->lock);
65f79b50103067 Jakob Hauser  2022-08-13  400  
65f79b50103067 Jakob Hauser  2022-08-13  401  	*t = get_unaligned_be16(&data[0]);
65f79b50103067 Jakob Hauser  2022-08-13  402  	xy1y2[0] = FIELD_GET(GENMASK(13, 0), get_unaligned_be16(&data[2]));
65f79b50103067 Jakob Hauser  2022-08-13  403  	xy1y2[1] = get_unaligned_be16(&data[4]);
65f79b50103067 Jakob Hauser  2022-08-13  404  	xy1y2[2] = get_unaligned_be16(&data[6]);
65f79b50103067 Jakob Hauser  2022-08-13  405  
65f79b50103067 Jakob Hauser  2022-08-13  406  	/* The second version of YAS537 needs to include calibration coefficients */
65f79b50103067 Jakob Hauser  2022-08-13  407  	if (yas5xx->version == YAS537_VERSION_1) {
65f79b50103067 Jakob Hauser  2022-08-13  408  		for (i = 0; i < 3; i++)
65f79b50103067 Jakob Hauser  2022-08-13  409  			s[i] = xy1y2[i] - BIT(13);
65f79b50103067 Jakob Hauser  2022-08-13  410  		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);
65f79b50103067 Jakob Hauser  2022-08-13  411  		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);
65f79b50103067 Jakob Hauser  2022-08-13  412  		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);
65f79b50103067 Jakob Hauser  2022-08-13  413  		for (i = 0; i < 3; i++) {
65f79b50103067 Jakob Hauser  2022-08-13 @414  			clamp_val(h[i], -BIT(13), BIT(13) - 1);
65f79b50103067 Jakob Hauser  2022-08-13  415  			xy1y2[i] = h[i] + BIT(13);
65f79b50103067 Jakob Hauser  2022-08-13  416  		}
65f79b50103067 Jakob Hauser  2022-08-13  417  	}
65f79b50103067 Jakob Hauser  2022-08-13  418  
65f79b50103067 Jakob Hauser  2022-08-13  419  	*x = xy1y2[0];
65f79b50103067 Jakob Hauser  2022-08-13  420  	*y1 = xy1y2[1];
65f79b50103067 Jakob Hauser  2022-08-13  421  	*y2 = xy1y2[2];
65f79b50103067 Jakob Hauser  2022-08-13  422  
65f79b50103067 Jakob Hauser  2022-08-13  423  	return 0;
65f79b50103067 Jakob Hauser  2022-08-13  424  
65f79b50103067 Jakob Hauser  2022-08-13  425  out_unlock:
65f79b50103067 Jakob Hauser  2022-08-13  426  	mutex_unlock(&yas5xx->lock);
65f79b50103067 Jakob Hauser  2022-08-13  427  	return ret;
65f79b50103067 Jakob Hauser  2022-08-13  428  }
65f79b50103067 Jakob Hauser  2022-08-13  429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

