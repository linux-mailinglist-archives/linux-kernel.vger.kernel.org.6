Return-Path: <linux-kernel+bounces-559750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C8A5F915
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA73B28CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282772686A1;
	Thu, 13 Mar 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg7rXks3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D411CA9;
	Thu, 13 Mar 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877685; cv=none; b=iXb+sue/xYfY7QKy6Npa+N7kW3x4/+4mBxn98ErYAJu3jgw6ef+NU5RBMyslpJwPqN5cpYbCB8WJSwc6lJp4fh8TXij3z5UFDOU90oKPnjWt9bMrcfjHPIxjdwEIQmRx+WEmhYwk/ge6LmyQVOjEw1LWjTPwyAPUgGiv1XsZI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877685; c=relaxed/simple;
	bh=T44nDw2LEfKVsCx2WxvTXGvhUUEfV3wxXQ1+rKA6t7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8k/Rm9kOovgvVXEpVLWy/BPpRj0dT5FFxBAP7+yb94s647de618UMY9hIcDFEUBWDVZjRZvmrSwGDapDWbR+X+FmaHG495FYSgVy2PQSbYXa+JY0VjTx1z+5rzlfsy2xB4wSaNxscnoJKWI8r2W/YT957BIo4YrUctq7vPO3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg7rXks3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741877684; x=1773413684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T44nDw2LEfKVsCx2WxvTXGvhUUEfV3wxXQ1+rKA6t7w=;
  b=Qg7rXks3iPCRpYx34SiOXpsBqtC/aVBCWazEOL7h4ZGaBRLNHzFik+Oe
   RCuwsoiyPEobEQOBUMFcSW+xGQoRA706vH9yGDbpfEgvMiDepb+g4bmbT
   9Y7aeIUZZsOozznUKrJFXZwOgmSQsoReFirYxTcYiNdeQreK2iV34xLJe
   wUJePCu0f5puce2whaH6EYTzuiI7Ss5Wk5t0KYsAvg1NbT/Qdnf/p8owi
   vM5KE57IDBcwuzKx71i8PEctWMoEAi2awJ0HnDKI0mSaVsiABdNZJICtm
   4sua8lgt8KuYa8JFmwpnRVYbBLkUJ7PVMDoud5tU+utZ7j8HeWycJ9r/T
   w==;
X-CSE-ConnectionGUID: c8FfMZqFRyGRaaHnNMDaBw==
X-CSE-MsgGUID: uLbu5zK6RUCbXIwBcWqBYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53636313"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53636313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:54:43 -0700
X-CSE-ConnectionGUID: OJibDJw0SEKWo9QtAOKErw==
X-CSE-MsgGUID: Z1sJvMHiSyCSL33+cdl3tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="125601523"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Mar 2025 07:54:41 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsjxG-0009YK-2M;
	Thu, 13 Mar 2025 14:54:38 +0000
Date: Thu, 13 Mar 2025 22:53:55 +0800
From: kernel test robot <lkp@intel.com>
To: Subu Dwevedi <messigoatcr7nop@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon/applesmc: add fan support for newer macs
Message-ID: <202503132205.Vf8imlWS-lkp@intel.com>
References: <20250312123055.1735-3-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312123055.1735-3-messigoatcr7nop@gmail.com>

Hi Subu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Subu-Dwevedi/hwmon-applesmc-add-MMIO-for-newer-macs/20250312-203248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250312123055.1735-3-messigoatcr7nop%40gmail.com
patch subject: [PATCH 2/2] hwmon/applesmc: add fan support for newer macs
config: i386-randconfig-002-20250313 (https://download.01.org/0day-ci/archive/20250313/202503132205.Vf8imlWS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132205.Vf8imlWS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132205.Vf8imlWS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/applesmc.c: In function 'applesmc_show_fan_manual':
>> drivers/hwmon/applesmc.c:1155:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1155 |         int ret;
         |             ^~~


vim +/ret +1155 drivers/hwmon/applesmc.c

6f2fad748ccced5 Nicolas Boichat 2007-05-08  1151  
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1152  static ssize_t applesmc_show_fan_manual(struct device *dev,
3eba2bf7c5fb786 Henrik Rydberg  2010-11-09  1153  			struct device_attribute *attr, char *sysfsbuf)
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1154  {
6f2fad748ccced5 Nicolas Boichat 2007-05-08 @1155  	int ret;
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1156  	u16 manual = 0;
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1157  	u8 buffer[2];
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1158  
beab9ce267efe06 Subu Dwevedi    2025-03-12  1159  	if (is_fan_manual_fmt) {
beab9ce267efe06 Subu Dwevedi    2025-03-12  1160  		ret = applesmc_read_key(FANS_MANUAL_FMT, buffer, 1);
beab9ce267efe06 Subu Dwevedi    2025-03-12  1161  		manual = buffer[0];
beab9ce267efe06 Subu Dwevedi    2025-03-12  1162  	} else {
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1163  		ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
cecf7560f00a841 Tom Rix         2020-08-20  1164  		manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
beab9ce267efe06 Subu Dwevedi    2025-03-12  1165  	}
1f4d4af4d7a1c79 Guenter Roeck   2021-03-21  1166  	return sysfs_emit(sysfsbuf, "%d\n", manual);
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1167  }
6f2fad748ccced5 Nicolas Boichat 2007-05-08  1168  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

