Return-Path: <linux-kernel+bounces-401973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE39C21C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E0428272A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43614D717;
	Fri,  8 Nov 2024 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuUv9td+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8C13A27D;
	Fri,  8 Nov 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082454; cv=none; b=ZI99oIkGQUHzV+gQDoDit2Hhh11W/4Mxuxo7eI2o1y2UguvxZzjao/RTs9OtuOtpXLnOxWDaY9n5d/jaxfrnUNUwtDqCERGdYhljFkQ6eaYli9bKLAwWCiFjYER2LzRN//jKGngaJserReuObkXMXOc1URGy1fRcxNOpW23TGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082454; c=relaxed/simple;
	bh=FbEGx8arpbKFFseCr5MCa0A0WxSpNAQcAbyiq0ld9KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aND7nMU9vf1qIK41HjXA0UyBaLFxMone9Zy7/skWexDKNcRQt/WtZdl8ndWEZgH4bknPeZRM70DNZij3EDH1TLsTNsd5XIUjwrNHu6+p19zW1io2ul364CjLvowpq5UgLgZStOtQ7a6Sgyhssn61anoySY51rrHoHajE1K9pBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuUv9td+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731082452; x=1762618452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbEGx8arpbKFFseCr5MCa0A0WxSpNAQcAbyiq0ld9KE=;
  b=fuUv9td+8DZy1vjhCn2MTbcZlTLX7QLlOKUxEgTsT+3K+efQODBJjr/3
   +YrnQLL1C4nzxdnI4QoZcFDBbUXSlxJPP10coKPUm8CaOPtCSHWkesy7s
   S2NpKjMD5M7CNPQ1TKYfG388Qo9+Vi0nNF70LjhTUHPvzPW6Cpzrh6hHE
   WbSo7VvB0LOuE8BLt9AHk9U3yjzn1AyeT1yeuX+JOKK7wWsfez3/VceBh
   gJHOJJ8cACoLYnac3bNIPEc14QNIBra2bQisy/nN5mOh6KumUELeH3BjM
   J8V58Y8st8kdtjls0wQfsLbpZwUim9i8wVdTjWbv4DA3eDclZxqqbum64
   g==;
X-CSE-ConnectionGUID: n8m7lFHHSM6ovaiR/gDKCA==
X-CSE-MsgGUID: 4BQN1yJTQn22mCnJlUG6tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="33829961"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="33829961"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:14:11 -0800
X-CSE-ConnectionGUID: FAzRweEWRV618dJiUSmOtw==
X-CSE-MsgGUID: TvKEs9kOSHa7yUe5SoJVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="116491093"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Nov 2024 08:14:10 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9Rcd-000raM-3C;
	Fri, 08 Nov 2024 16:14:07 +0000
Date: Sat, 9 Nov 2024 00:13:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristopher Calam <ramoncristopher.calam@analog.com>
Subject: Re: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Message-ID: <202411082316.hXgR3Bv2-lkp@intel.com>
References: <20241108093544.9492-2-ramoncristopher.calam@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108093544.9492-2-ramoncristopher.calam@analog.com>

Hi Ramon,

kernel test robot noticed the following build errors:

[auto build test ERROR on e18da71634d12a94a15138947538ef2f0ac22746]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramon-Cristopher-M-Calam/regulator-lt8722-Add-driver-for-LT8722/20241108-174141
base:   e18da71634d12a94a15138947538ef2f0ac22746
patch link:    https://lore.kernel.org/r/20241108093544.9492-2-ramoncristopher.calam%40analog.com
patch subject: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241108/202411082316.hXgR3Bv2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411082316.hXgR3Bv2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411082316.hXgR3Bv2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/lt8722-regulator.c:8:10: fatal error: asm/unaligned.h: No such file or directory
       8 | #include <asm/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +8 drivers/regulator/lt8722-regulator.c

   > 8	#include <asm/unaligned.h>
     9	#include <linux/bitfield.h>
    10	#include <linux/bits.h>
    11	#include <linux/crc8.h>
    12	#include <linux/delay.h>
    13	#include <linux/gpio.h>
    14	#include <linux/math.h>
    15	#include <linux/module.h>
    16	#include <linux/regulator/driver.h>
    17	#include <linux/regulator/machine.h>
    18	#include <linux/regulator/of_regulator.h>
    19	#include <linux/spi/spi.h>
    20	#include <linux/util_macros.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

