Return-Path: <linux-kernel+bounces-331267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96897AA80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DFB2311A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB32E3F7;
	Tue, 17 Sep 2024 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+x3kZ7g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952D2628C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726545168; cv=none; b=Wj6FGIp2zXZUTDr4f104uthp1kySYvA42dwtSFv7bRSAAdIP8NQUIiPniigkSlD4SHig1zZ85lRdu7oJ8HWmikN70x5rEn7Ka8t3X3U8nY6d1H01KOXcSZ+RJeGVxxG8hU4rBcbtI88HCWEs8f7DVHzG0b4D5ZKa1LQ2F0uxlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726545168; c=relaxed/simple;
	bh=zujx90QDbJv1WdnVpadTHhF4McANNwX6I+TDOa6mtlA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f0+Sqj2p749Xi3PACTACX1Sg1WENOPEEfmBNYsKZHwsYsypOR5JLLypSPM1fKXxjWSpwHXKOfVTlheNVe2YFsf/zHmej/6tH8vvWL3kAmBNHJk38ep6CegoWa9N8hj+wywetMjdQFVmJrpvWObJepJ/wafkzg7Wv4qS8WahFm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+x3kZ7g; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726545167; x=1758081167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zujx90QDbJv1WdnVpadTHhF4McANNwX6I+TDOa6mtlA=;
  b=k+x3kZ7gijMa/IebQM9XuQ7LefAQgpJzE+5YtlDD3nfy9oHekQi0f6ES
   xqXO74Rq3cKIsMVYxxRKwRMBW3MOTnhi5liwGtSLkPvb4oQFC66KiANgf
   Dyrxy1EE81eGbckBeJV24gUfSoTPhPowlLgY/p79EXF469vdaZXutSFRM
   y34KIKxu4LdjU9fwN8F/JMrNWNDNkEq++FeN6VJG9s9UNmzotJ0vjTSK0
   TVgrNPPozXuKV5NyoCn6Wt/Eb2hrHoeVeyqA2FyVmjnOP5/PGRV8dXNlu
   8+DPfJMAR6Isjv6EvtQP67wutPByUDY5qaGEm5No/WrJ2AqHj2zLzxlIl
   Q==;
X-CSE-ConnectionGUID: 5QLcyi+CQc+kxnI5d4HZzg==
X-CSE-MsgGUID: sOXBm6ZLSwmrGohbvE3/RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25490178"
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="25490178"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 20:52:47 -0700
X-CSE-ConnectionGUID: MOG/oijBTw2yCyxLI3ROrA==
X-CSE-MsgGUID: Wu2IQpKxRN606WB9qZOY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="73892321"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Sep 2024 20:52:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqPGc-000AlK-27;
	Tue, 17 Sep 2024 03:52:42 +0000
Date: Tue, 17 Sep 2024 11:52:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: drivers/cpufreq/s3c64xx-cpufreq.c:55:22: error: variable 'old_freq'
 set but not used
Message-ID: <202409171104.Z7qFxsc7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a430d95c5efa2b545d26a094eb5f624e36732af0
commit: 81746019b9fbb9fbf7c522dcbeefb572ac0f9458 cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers
date:   13 days ago
config: x86_64-sof-customedconfig-compile-test-defconfig (https://download.01.org/0day-ci/archive/20240917/202409171104.Z7qFxsc7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240917/202409171104.Z7qFxsc7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409171104.Z7qFxsc7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/s3c64xx-cpufreq.c: In function 's3c64xx_cpufreq_set_target':
>> drivers/cpufreq/s3c64xx-cpufreq.c:55:22: error: variable 'old_freq' set but not used [-Werror=unused-but-set-variable]
      55 |         unsigned int old_freq, new_freq;
         |                      ^~~~~~~~
>> drivers/cpufreq/s3c64xx-cpufreq.c:54:30: error: variable 'dvfs' set but not used [-Werror=unused-but-set-variable]
      54 |         struct s3c64xx_dvfs *dvfs;
         |                              ^~~~
   cc1: all warnings being treated as errors


vim +/old_freq +55 drivers/cpufreq/s3c64xx-cpufreq.c

b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15  50  
b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15  51  static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
9c0ebcf78fde0f drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2013-10-25  52  				      unsigned int index)
b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15  53  {
b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15 @54  	struct s3c64xx_dvfs *dvfs;
d4019f0a92ab80 drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2013-08-14 @55  	unsigned int old_freq, new_freq;
d4019f0a92ab80 drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2013-08-14  56  	int ret;
b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15  57  
652ed95d5fa607 drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2014-01-09  58  	old_freq = clk_get_rate(policy->clk) / 1000;
d4019f0a92ab80 drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2013-08-14  59  	new_freq = s3c64xx_freq_table[index].frequency;
9c0ebcf78fde0f drivers/cpufreq/s3c64xx-cpufreq.c Viresh Kumar 2013-10-25  60  	dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
b3748ddd80569e arch/arm/plat-s3c64xx/cpufreq.c   Mark Brown   2009-06-15  61  

:::::: The code at line 55 was first introduced by commit
:::::: d4019f0a92ab802f385cc9c8ad3ab7b5449712cb cpufreq: move freq change notifications to cpufreq core

:::::: TO: Viresh Kumar <viresh.kumar@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

