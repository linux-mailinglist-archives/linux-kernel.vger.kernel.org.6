Return-Path: <linux-kernel+bounces-389989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970879B742E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD3D1C21B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DED13D61B;
	Thu, 31 Oct 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b19cH/i+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91113C906
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730353381; cv=none; b=G+JvVYyVn0fR1hDHimhvaEo027G2+SoB0JON+VoSxDSxuLNVFJvW2cRlE5JYlzw1J48Z1QgdpvX2E1x5gMqHwcAL0GcW+zUrPwI8lGy6SJ/n0qFNcK3zDOLqBgw3junsjA2qn9aGqiFzGa0+kZ/s1jmxYpaC3sCnLx7gDfeXxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730353381; c=relaxed/simple;
	bh=Ac/j4MOgUEPCHxoddjHszNDloaEzY0OScDCcj5Fz9Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBbTsLI1B+PLYW/6kWJrAmY0IuVf/Ci96CkWwO5gsv3Ul35r2dvdXKpE53xQ7n0C//Vdjpajsw6v4X2rtqmPjFvfmA65EJncma4ATUgCsulktC2YcnND7ntktHpak2JFmmRwvQuFI9iTc/BK3FWR00qCFwAgC7b5E2LtcbCOFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b19cH/i+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730353380; x=1761889380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ac/j4MOgUEPCHxoddjHszNDloaEzY0OScDCcj5Fz9Y4=;
  b=b19cH/i+P7u1V+7/2h1c/chmmyXHfqhGvTgauYQHgmeuZun2sEO49P+g
   KR9KOyr6MRyT0pM1uS65iUDJJzhLKcJoxkjI1ytjeG+/GGCsdWZs3g9ZL
   hVNcxy5qPVr+TFJIDK9Lgo72XBxotw9HiPRPu4xsADvdBIopdHUuoWrkW
   3xCE04drZLKCcWSxRwmU83Bz4UjqjljcmI3nm0rSAH3X0RwWC5AsDRypa
   kn7ry+4XuoxtF+XcOKtEK0Cngz1ptYByJjePM+LMdWdXnPMt2d/B2cmmu
   HVE+5ddbiJF41IRzTVwT2jS/+RObPORLIjszZoGCPbcyWKmTwVWvfcNMl
   A==;
X-CSE-ConnectionGUID: r4tJ+TYxQQ20HUT9QnoArQ==
X-CSE-MsgGUID: zHZFaSN/T+GqU3iRVhJf6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30186609"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30186609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 22:42:59 -0700
X-CSE-ConnectionGUID: 3uxnDGihSNiF0PmHsGxmCw==
X-CSE-MsgGUID: x1RbFepxTGaYiezTVuY9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82640306"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Oct 2024 22:42:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6NxN-000fiI-2U;
	Thu, 31 Oct 2024 05:42:53 +0000
Date: Thu, 31 Oct 2024 13:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH 2/5] memory: ti-aemif: export aemif_set_cs_timing()
Message-ID: <202410311304.0fuqFK2M-lkp@intel.com>
References: <20241030104717.88688-3-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030104717.88688-3-bastien.curutchet@bootlin.com>

Hi Bastien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk-mem-ctrl/for-next]
[also build test WARNING on mtd/nand/next linus/master v6.12-rc5 next-20241030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet/memory-ti-aemif-Create-aemif_set_cs_timings/20241030-184949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20241030104717.88688-3-bastien.curutchet%40bootlin.com
patch subject: [PATCH 2/5] memory: ti-aemif: export aemif_set_cs_timing()
config: arc-randconfig-001-20241031 (https://download.01.org/0day-ci/archive/20241031/202410311304.0fuqFK2M-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311304.0fuqFK2M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311304.0fuqFK2M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/memory/ti-aemif.c:130: warning: Function parameter or struct member 'config_cs_lock' not described in 'aemif_device'
>> drivers/memory/ti-aemif.c:130: warning: Excess struct member 'cs_config_lock' description in 'aemif_device'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +130 drivers/memory/ti-aemif.c

5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  111  
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  112  /**
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  113   * struct aemif_device: structure to hold device data
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  114   * @base: base address of AEMIF registers
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  115   * @clk: source clock
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  116   * @clk_rate: clock's rate in kHz
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  117   * @num_cs: number of assigned chip-selects
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  118   * @cs_offset: start number of cs nodes
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  119   * @cs_data: array of chip-select settings
0f034c3604121bf Bastien Curutchet 2024-10-30  120   * @cs_config_lock: lock used to access CS configuration
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  121   */
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  122  struct aemif_device {
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  123  	void __iomem *base;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  124  	struct clk *clk;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  125  	unsigned long clk_rate;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  126  	u8 num_cs;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  127  	int cs_offset;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  128  	struct aemif_cs_data cs_data[NUM_CS];
0f034c3604121bf Bastien Curutchet 2024-10-30  129  	spinlock_t config_cs_lock;
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24 @130  };
5a7c81547c1db75 Ivan Khoronzhuk   2014-02-24  131  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

