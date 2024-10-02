Return-Path: <linux-kernel+bounces-346973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5098CB81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5655B23DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A111185;
	Wed,  2 Oct 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imOvaFdi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200717597
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839368; cv=none; b=uwL84LaTD6yIM7F3eH7WMG692raFSjoJVoWwVpigRYte+De5wEjpWsV5sYaODDd91dzoGX+zkDY1cbT93Z55yi2hs0hdRYOLCW6ZIPNoQq+pahVjL7eGGpoFyEdDQ+X68zEB02Dvr4Dk+5YfqfdSaRRoHH5QvSuMFTOVJZ0c41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839368; c=relaxed/simple;
	bh=4SmJY190WUJnhwoZKOFhNV89FV1URm3Yw9EHPWRvg14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lrl/UYbmQ/p1hlTVprnd5KiNGJPvK5CjV/U60NHrMYI5Ga0YloRgOihr/PiALy2NVLc8Jb3yT3D3/Gpj94tXg/kLNeMKihQVaiirVPyFZ+lzaqAWZDB+ap9fXzayZ0DkgjefVdlDgbVsmQEPxQsGDZ5WzY8PGy7S4yjMHOJ5fFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imOvaFdi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727839367; x=1759375367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4SmJY190WUJnhwoZKOFhNV89FV1URm3Yw9EHPWRvg14=;
  b=imOvaFdiv7IZ2tpZHXWtEwPPTTOoaN4fT9BnX1M061U2OdLZ/KVaLDCT
   i2uuUQmsIZlHw8pFW3Scla0xCTP0d40fDUH0ocFxLCqAY3XmjhFgQl2Mv
   4dP0HxkU2TZJg47r5BS42nq5nPWENTOR6ivBcflW147te8gtlkiylPwfL
   tggZf0Dqx7LG/aFVaJezgT5v3zKm/PepU4DqHmtGALd+WSDvVgMI9P+PP
   PHF2I4ac46uahCx4fSQlicwXvQMQuB3ouDy3k3m22TfeDF5Ju8yh5ljKA
   +wxqt2GQqfJ5dk45/ZT6Lf5MGNrnYDVYrEd589cinj2REjekNwyD8pmpS
   Q==;
X-CSE-ConnectionGUID: HIH4KXsqQx+Pz77CZJl8JQ==
X-CSE-MsgGUID: kTlUn4tOR9mMNQQ2/I7Jng==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26464713"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="26464713"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 20:22:46 -0700
X-CSE-ConnectionGUID: jFWXfenDQDijk7pkx+/F0A==
X-CSE-MsgGUID: DXhdC6YbQHiiMdekiU27/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="97235801"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Oct 2024 20:22:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svpwo-000RUO-1Q;
	Wed, 02 Oct 2024 03:22:42 +0000
Date: Wed, 2 Oct 2024 11:21:55 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct
 regmap_bus' has no member named 'read'
Message-ID: <202410021111.LknEX9ne-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: c922c634bd926d84967275efbb7275b8645aa343 iio: accel: adxl367: Constify struct regmap_bus
date:   9 weeks ago
config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021111.LknEX9ne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021111.LknEX9ne-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:38,
                    from include/linux/percpu.h:12,
                    from arch/x86/include/asm/msr.h:15,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/iio/accel/adxl367_spi.c:8:
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:2888:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
    2888 | #if USE_SPLIT_PTE_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
      20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3010:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
    3010 | #if USE_SPLIT_PMD_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:75:21: error: variable 'adxl367_spi_regmap_bus' has initializer but incomplete type
      75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
         |                     ^~~~~~~~~~
>> drivers/iio/accel/adxl367_spi.c:76:10: error: 'const struct regmap_bus' has no member named 'read'
      76 |         .read = adxl367_read,
         |          ^~~~
   drivers/iio/accel/adxl367_spi.c:76:17: warning: excess elements in struct initializer
      76 |         .read = adxl367_read,
         |                 ^~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:76:17: note: (near initialization for 'adxl367_spi_regmap_bus')
>> drivers/iio/accel/adxl367_spi.c:77:10: error: 'const struct regmap_bus' has no member named 'write'
      77 |         .write = adxl367_write,
         |          ^~~~~
   drivers/iio/accel/adxl367_spi.c:77:18: warning: excess elements in struct initializer
      77 |         .write = adxl367_write,
         |                  ^~~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:77:18: note: (near initialization for 'adxl367_spi_regmap_bus')
   drivers/iio/accel/adxl367_spi.c:80:21: error: variable 'adxl367_spi_regmap_config' has initializer but incomplete type
      80 | static const struct regmap_config adxl367_spi_regmap_config = {
         |                     ^~~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:81:10: error: 'const struct regmap_config' has no member named 'reg_bits'
      81 |         .reg_bits = 8,
         |          ^~~~~~~~
   drivers/iio/accel/adxl367_spi.c:81:21: warning: excess elements in struct initializer
      81 |         .reg_bits = 8,
         |                     ^
   drivers/iio/accel/adxl367_spi.c:81:21: note: (near initialization for 'adxl367_spi_regmap_config')
   drivers/iio/accel/adxl367_spi.c:82:10: error: 'const struct regmap_config' has no member named 'val_bits'
      82 |         .val_bits = 8,
         |          ^~~~~~~~
   drivers/iio/accel/adxl367_spi.c:82:21: warning: excess elements in struct initializer
      82 |         .val_bits = 8,
         |                     ^
   drivers/iio/accel/adxl367_spi.c:82:21: note: (near initialization for 'adxl367_spi_regmap_config')
   drivers/iio/accel/adxl367_spi.c: In function 'adxl367_spi_probe':
   drivers/iio/accel/adxl367_spi.c:132:18: error: implicit declaration of function 'devm_regmap_init' [-Werror=implicit-function-declaration]
     132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
         |                  ^~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:132:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     132 |         regmap = devm_regmap_init(&spi->dev, &adxl367_spi_regmap_bus, st,
         |                ^
   drivers/iio/accel/adxl367_spi.c: At top level:
   drivers/iio/accel/adxl367_spi.c:75:32: error: storage size of 'adxl367_spi_regmap_bus' isn't known
      75 | static const struct regmap_bus adxl367_spi_regmap_bus = {
         |                                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl367_spi.c:80:35: error: storage size of 'adxl367_spi_regmap_config' isn't known
      80 | static const struct regmap_config adxl367_spi_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +76 drivers/iio/accel/adxl367_spi.c

cbab791c5e2a58 Cosmin Tanislav 2022-02-14  74  
c922c634bd926d Javier Carrasco 2024-07-03  75  static const struct regmap_bus adxl367_spi_regmap_bus = {
cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @76  	.read = adxl367_read,
cbab791c5e2a58 Cosmin Tanislav 2022-02-14 @77  	.write = adxl367_write,
cbab791c5e2a58 Cosmin Tanislav 2022-02-14  78  };
cbab791c5e2a58 Cosmin Tanislav 2022-02-14  79  

:::::: The code at line 76 was first introduced by commit
:::::: cbab791c5e2a58c123d84bd9202c054e5449bc96 iio: accel: add ADXL367 driver

:::::: TO: Cosmin Tanislav <demonsingur@gmail.com>
:::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

