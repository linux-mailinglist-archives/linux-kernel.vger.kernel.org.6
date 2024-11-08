Return-Path: <linux-kernel+bounces-402105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAD9C23F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA741B26B86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E922C737;
	Fri,  8 Nov 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JL96CrWN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287721CF95;
	Fri,  8 Nov 2024 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087377; cv=none; b=EsGNSDlfSXX/05X+2C+TmtNkIObV/OWY4uy3GSeq4qN85G2StD0Jikv6Ziy494VElsltvscuf7GMjVefiQn/pFCyc9jg/mahIiYNqlfgOWH5I0ziJTSCLVQYiTDl04drxoMNgVdAVLS2lLlhhrgHtZqL0PTXydnVAao9fUK71Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087377; c=relaxed/simple;
	bh=VYRtOv+nPghOh1Cg4oPCcRkHkKNpWrkOKEbceRGuIs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H07O58Rutv9/VA26DHOPAAcdXXatQwRhuYz/aupC2049aPOV9DzWLNYnZoY0agb+4id4JBMVNNVR/r7iGT+GRXCFOEWeEXcDnlkeGxta8LDUTp2dYpMi1u/l0LD4TeuQcgS0vugwsD1VW2Z0W5Ts3xye9XpN1aBE5it6pZFWH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JL96CrWN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731087376; x=1762623376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VYRtOv+nPghOh1Cg4oPCcRkHkKNpWrkOKEbceRGuIs0=;
  b=JL96CrWNlfsP0m+0gdEAlMitbYGVMnQN1GmGUGYtPprqFKuOh5OPxxXu
   51Qqt+yTbgQL+NtlxnrBZwIh11rauPR5LnO3RL61cb7jhOpJrLxK646Iu
   mizeT6YYSJ1jdgFxgbvOjbNPWbLwwGuKf54GkpOba+yvZIzuEg86QJ8DQ
   gj5axWiytmaZUC1eEVdrwwiJvUeSq61wEm1sfHHotJDYoccIjjPIennyo
   KCGNJJtif6397Rs8bTuUvpdFhJCh8LdrNBYqlQXXec69JtdTxd4/dEuUt
   7dvllCJ2HwDZvck2hUuL/GRgE2Bo1RrAE3AHzSQg0ZBLvaqwpUxaSgTm0
   w==;
X-CSE-ConnectionGUID: EjVGo/fWTsqRe9cmp7vBRg==
X-CSE-MsgGUID: BUP3mlDuR2GGBNnxHLagig==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34765144"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="34765144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 09:36:16 -0800
X-CSE-ConnectionGUID: fSSNJeBoT1iCWbyIt3pcaw==
X-CSE-MsgGUID: P11TbQ9UQRKLr4/jfFZM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="108951162"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2024 09:36:13 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9Su3-000reg-0e;
	Fri, 08 Nov 2024 17:36:11 +0000
Date: Sat, 9 Nov 2024 01:36:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristopher Calam <ramoncristopher.calam@analog.com>
Subject: Re: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Message-ID: <202411090141.pm0JwBtT-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241109/202411090141.pm0JwBtT-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090141.pm0JwBtT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090141.pm0JwBtT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/lt8722-regulator.c:8:10: fatal error: 'asm/unaligned.h' file not found
       8 | #include <asm/unaligned.h>
         |          ^~~~~~~~~~~~~~~~~
   1 error generated.

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

