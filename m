Return-Path: <linux-kernel+bounces-291382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E995616C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F31C21503
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3C13B7A1;
	Mon, 19 Aug 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpstkaKA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F822064;
	Mon, 19 Aug 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037805; cv=none; b=EI/6pPU/OKtXDmpByCtoB/z2AHhy+h3lKb7nNu8FQayx4fqb2fYdSFmr7TORJCF5PL7/Z0ienS9g8354eRIR3lgB/3iSvbO9dsA1XCvksSHGYol3NfOxFSohZQnR+GPiUa/J+E2LPRzDXcwQkhhBbrHoCUiNyqroumEvLtWs9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037805; c=relaxed/simple;
	bh=8OKLp2oCpiUcOP37XZ74A6BN4htyI4i786NsVEFgc6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8gSF25Ho/Q39Hjlrmii3QuhRr4a7foDNrWb3SrG3eVIO964mr84zgYLjPiZtalLdxI8Ou198tz41BjnYjP5g4QpaxMaUlp93sPVoKvQmCZRsEzGXrtIc/ZXZ6gpWCQ93UljFiU0eXR5vVFwrXFp276K8Vk7jHpOwINRyHenyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpstkaKA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724037803; x=1755573803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8OKLp2oCpiUcOP37XZ74A6BN4htyI4i786NsVEFgc6Y=;
  b=KpstkaKA3oUd1P90pp+oQ3/T+rvZWgc2EyKejo1ks+SGkZ9KWhu3GKun
   bwXUqxZtJDpX/MNZ5M1qoNvlQ4YERDRl6iiv84v7xbIES9fx87gDtvnPA
   4v1ZEfJej6Q+3y36q1S8D0ya7mmGdQJDUSPwZ4ympWwddLE6CJi/u4wsC
   amDzaMtRZ1CQtrgegJ1Qizg25pXMzwnvyte0sojsGC1EXaa8jsxVnd0SP
   S9DEjbCxjDwCdaF21ZicebW8lFI3BVvZNuBnXl4yMZ/WLJIcLJ5NlF6Wj
   LRP/Mo65mzwUuvDD9cbG0V5cvyfCjBGN/Z/UO0YEyraVlpZVR/nBVm1lu
   Q==;
X-CSE-ConnectionGUID: FD2Pig1UQnyKWz/PlNYMQw==
X-CSE-MsgGUID: HQXUK1PWSiSg57MntQdanw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47664497"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="47664497"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:23:23 -0700
X-CSE-ConnectionGUID: ec/sqwvIRo2ezg+IO7KW0g==
X-CSE-MsgGUID: BGLrlpuZQiml7x6nlOhNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65118060"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Aug 2024 20:23:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfszG-0008bG-0o;
	Mon, 19 Aug 2024 03:23:18 +0000
Date: Mon, 19 Aug 2024 11:22:41 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmo Chou <chou.cosmo@gmail.com>, linux@roeck-us.net,
	jdelvare@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH] hwmon: (pt5161l) Fix invalid temperature reading
Message-ID: <202408191001.pTmfYpUn-lkp@intel.com>
References: <20240818194401.172248-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818194401.172248-1-chou.cosmo@gmail.com>

Hi Cosmo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.11-rc4 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmo-Chou/hwmon-pt5161l-Fix-invalid-temperature-reading/20240819-034826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240818194401.172248-1-chou.cosmo%40gmail.com
patch subject: [PATCH] hwmon: (pt5161l) Fix invalid temperature reading
config: i386-buildonly-randconfig-001-20240819 (https://download.01.org/0day-ci/archive/20240819/202408191001.pTmfYpUn-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408191001.pTmfYpUn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408191001.pTmfYpUn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pt5161l.c:452:43: warning: format specifies type 'unsigned long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
     452 |                         dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
         |                                                        ~~~     ^~~~~~~~
         |                                                        %x
   include/linux/dev_printk.h:168:46: note: expanded from macro 'dev_dbg'
     168 |         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                             ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +452 drivers/hwmon/pt5161l.c

1b2ca93cd0592b Cosmo Chou 2024-02-06  423  
1b2ca93cd0592b Cosmo Chou 2024-02-06  424  static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
1b2ca93cd0592b Cosmo Chou 2024-02-06  425  			u32 attr, int channel, long *val)
1b2ca93cd0592b Cosmo Chou 2024-02-06  426  {
1b2ca93cd0592b Cosmo Chou 2024-02-06  427  	struct pt5161l_data *data = dev_get_drvdata(dev);
1b2ca93cd0592b Cosmo Chou 2024-02-06  428  	int ret;
1b2ca93cd0592b Cosmo Chou 2024-02-06  429  	u8 buf[8];
4aa2c2144fb2eb Cosmo Chou 2024-08-19  430  	u32 adc_code;
1b2ca93cd0592b Cosmo Chou 2024-02-06  431  
1b2ca93cd0592b Cosmo Chou 2024-02-06  432  	switch (attr) {
1b2ca93cd0592b Cosmo Chou 2024-02-06  433  	case hwmon_temp_input:
1b2ca93cd0592b Cosmo Chou 2024-02-06  434  		if (!data->init_done) {
1b2ca93cd0592b Cosmo Chou 2024-02-06  435  			ret = pt5161l_init_dev(data);
1b2ca93cd0592b Cosmo Chou 2024-02-06  436  			if (ret)
1b2ca93cd0592b Cosmo Chou 2024-02-06  437  				return ret;
1b2ca93cd0592b Cosmo Chou 2024-02-06  438  		}
1b2ca93cd0592b Cosmo Chou 2024-02-06  439  
1b2ca93cd0592b Cosmo Chou 2024-02-06  440  		mutex_lock(&data->lock);
1b2ca93cd0592b Cosmo Chou 2024-02-06  441  		ret = pt5161l_read_wide_reg(data,
1b2ca93cd0592b Cosmo Chou 2024-02-06  442  					    ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4,
1b2ca93cd0592b Cosmo Chou 2024-02-06  443  					    buf);
1b2ca93cd0592b Cosmo Chou 2024-02-06  444  		mutex_unlock(&data->lock);
1b2ca93cd0592b Cosmo Chou 2024-02-06  445  		if (ret) {
1b2ca93cd0592b Cosmo Chou 2024-02-06  446  			dev_dbg(dev, "Read adc_code failed %d\n", ret);
1b2ca93cd0592b Cosmo Chou 2024-02-06  447  			return ret;
1b2ca93cd0592b Cosmo Chou 2024-02-06  448  		}
1b2ca93cd0592b Cosmo Chou 2024-02-06  449  
1b2ca93cd0592b Cosmo Chou 2024-02-06  450  		adc_code = buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
1b2ca93cd0592b Cosmo Chou 2024-02-06  451  		if (adc_code == 0 || adc_code >= 0x3ff) {
1b2ca93cd0592b Cosmo Chou 2024-02-06 @452  			dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
1b2ca93cd0592b Cosmo Chou 2024-02-06  453  			return -EIO;
1b2ca93cd0592b Cosmo Chou 2024-02-06  454  		}
1b2ca93cd0592b Cosmo Chou 2024-02-06  455  
1b2ca93cd0592b Cosmo Chou 2024-02-06  456  		*val = 110000 +
1b2ca93cd0592b Cosmo Chou 2024-02-06  457  		       ((adc_code - (ARIES_TEMP_CAL_CODE_DEFAULT + 250)) *
1b2ca93cd0592b Cosmo Chou 2024-02-06  458  			-320);
1b2ca93cd0592b Cosmo Chou 2024-02-06  459  		break;
1b2ca93cd0592b Cosmo Chou 2024-02-06  460  	default:
1b2ca93cd0592b Cosmo Chou 2024-02-06  461  		return -EOPNOTSUPP;
1b2ca93cd0592b Cosmo Chou 2024-02-06  462  	}
1b2ca93cd0592b Cosmo Chou 2024-02-06  463  
1b2ca93cd0592b Cosmo Chou 2024-02-06  464  	return 0;
1b2ca93cd0592b Cosmo Chou 2024-02-06  465  }
1b2ca93cd0592b Cosmo Chou 2024-02-06  466  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

