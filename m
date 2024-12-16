Return-Path: <linux-kernel+bounces-446764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC709F28DD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9638C188508E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E9175562;
	Mon, 16 Dec 2024 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaxxRLvF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E644153BE8;
	Mon, 16 Dec 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320543; cv=none; b=gyiZeBNB37wRI5gv/GrlbfbujB2cT7DJw2e5EcDikLomAYsEY4eaoCrE9lIq8OYQREU2QmtahPkCBe+O9Yzgw/VfBiHcqjuOB155i4ErOZ+UdjU6OE90uW9iNz0tZV3bfVBfOEteel2gm/6CMtQIbdGjwoEZtREvCzEEmAeEh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320543; c=relaxed/simple;
	bh=FwRmsw6wbw837rBuXgCnfUMbjXQ6Dm5d5MfH3I7I0Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvdO6RiBFEgDREDipeE6OEGRXR+EKn5ULKBnCDIt0UiRgjFNK9/Q2IWhwYpQZZEJikgz8kgc7GMnPa+yJnVINlZJcaPTJp/TJzOrUoMQopww1cQLaVlUAirbnMkvWpZpR0j/xeGi34omd+UagA/nB48JwSDQ611h/crCJyC0uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaxxRLvF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734320542; x=1765856542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwRmsw6wbw837rBuXgCnfUMbjXQ6Dm5d5MfH3I7I0Hk=;
  b=gaxxRLvFP0BOlbraayvdOSFfprVWUQBW7uZqgkSupxcmG9xpcl42atOp
   7UKDCfvjHz4bdOoByrpgCh4nWSpjt/U/G+PHg5ffVIXNbETgoaRwnJSoH
   CyXcKImHoqpJIaFkpRfBquQm3nixP1fPDBwCGTP5mpaD9nILOapEA7tgz
   U7zJU2CnH8H45pUDKwGZX4hnLeyEi9pXQPinlXE19va7qg1lR5GMAMCLO
   FH5MB4BnZGa357L5tYF38n9zOpAE/EyDshXwNFvuJXF0ReqQS/QKYCV/i
   4zilBrDYAw18KI8nvJxLv5C1G+yri94tXiqx67aR6TPhqMwv7AZBMZr68
   g==;
X-CSE-ConnectionGUID: BZT3ky9FTZ+iG6lzCvdg+A==
X-CSE-MsgGUID: 6tkicswDRhqhWRI+5pJGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="38468834"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="38468834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 19:42:21 -0800
X-CSE-ConnectionGUID: zwsXx41rSJK95/JbEvmPeg==
X-CSE-MsgGUID: E7M6hNgsTCeVlpAopGpkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96980655"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Dec 2024 19:42:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tN1zs-000Dzq-1u;
	Mon, 16 Dec 2024 03:42:16 +0000
Date: Mon, 16 Dec 2024 11:42:15 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Zijun Hu <zijun_hu@icloud.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] of: Fix potential wrong MODALIAS uevent value
Message-ID: <202412161157.HWxjPpzy-lkp@intel.com>
References: <20241216-of_core_fix-v2-6-e69b8f60da63@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-of_core_fix-v2-6-e69b8f60da63@quicinc.com>

Hi Zijun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e]

url:    https://github.com/intel-lab-lkp/linux/commits/Zijun-Hu/of-Fix-API-of_find_node_opts_by_path-finding-OF-device-node-failure/20241216-084408
base:   0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e
patch link:    https://lore.kernel.org/r/20241216-of_core_fix-v2-6-e69b8f60da63%40quicinc.com
patch subject: [PATCH v2 6/7] of: Fix potential wrong MODALIAS uevent value
config: x86_64-buildonly-randconfig-001-20241216 (https://download.01.org/0day-ci/archive/20241216/202412161157.HWxjPpzy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412161157.HWxjPpzy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412161157.HWxjPpzy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:36,
                    from include/linux/i2c.h:21,
                    from drivers/leds/leds-blinkm.c:11:
   include/linux/of.h: In function 'of_modalias':
>> include/linux/of.h:764:16: warning: returning 'int' from a function with return type 'char *' makes pointer from integer without a cast [-Wint-conversion]
     764 |         return -ENODEV;
         |                ^
--
   In file included from include/linux/irqdomain.h:36,
                    from include/linux/gpio/driver.h:9,
                    from drivers/leds/leds-pca955x.c:44:
   include/linux/of.h: In function 'of_modalias':
>> include/linux/of.h:764:16: warning: returning 'int' from a function with return type 'char *' makes pointer from integer without a cast [-Wint-conversion]
     764 |         return -ENODEV;
         |                ^
   drivers/leds/leds-pca955x.c: In function 'pca955x_probe':
   drivers/leds/leds-pca955x.c:555:43: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
     555 |                                          "%d", i);
         |                                           ^~
   drivers/leds/leds-pca955x.c:555:42: note: directive argument in the range [-2147483644, 2147483646]
     555 |                                          "%d", i);
         |                                          ^~~~
   drivers/leds/leds-pca955x.c:554:33: note: 'snprintf' output between 2 and 12 bytes into a destination of size 8
     554 |                                 snprintf(default_label, sizeof(default_label),
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     555 |                                          "%d", i);
         |                                          ~~~~~~~~
--
   In file included from drivers/leds/led-core.c:16:
   include/linux/of.h: In function 'of_modalias':
>> include/linux/of.h:764:16: warning: returning 'int' from a function with return type 'char *' makes pointer from integer without a cast [-Wint-conversion]
     764 |         return -ENODEV;
         |                ^
   drivers/leds/led-core.c: In function 'led_compose_name':
   drivers/leds/led-core.c:551:78: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     551 |                         snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
         |                                                                              ^
   drivers/leds/led-core.c:551:25: note: 'snprintf' output 2 or more bytes (assuming 65) into a destination of size 64
     551 |                         snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     552 |                                  devicename, tmp_buf);
         |                                  ~~~~~~~~~~~~~~~~~~~~


vim +764 include/linux/of.h

bd69f73f2c81eed Grant Likely  2013-02-10  761  
f1f6eae8bdfdfce Zijun Hu      2024-12-16  762  static inline char *of_modalias(const struct device_node *np, ssize_t *lenp)
bd7a7ed774afd1a Miquel Raynal 2023-04-04  763  {
bd7a7ed774afd1a Miquel Raynal 2023-04-04 @764  	return -ENODEV;
bd7a7ed774afd1a Miquel Raynal 2023-04-04  765  }
bd7a7ed774afd1a Miquel Raynal 2023-04-04  766  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

