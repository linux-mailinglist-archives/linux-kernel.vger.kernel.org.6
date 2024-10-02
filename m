Return-Path: <linux-kernel+bounces-346860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A777B98C9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6855C284189
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B7624;
	Wed,  2 Oct 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mhi5lIp7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48121370
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827459; cv=none; b=ILlEgdfZeSGSoqoT/qg23mUg6KGw5LIuknxRGE7X9bR1Y8gwaV0OnCirrqsqK4VQ3rK3Pnt4K9ifNqINddvfoWS17XvjhBBWMXvewe2aCCU4m4rjt9pHxB9zqLWbi/BtXPDJSVS5uS8sfsmW1e7n5fI1ElvlNpserqGtWzpVBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827459; c=relaxed/simple;
	bh=tYjXEsXoiNSz94c3vfjym9RbDkZVTKhCXZfCvj9MDx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pmEEj9wWEJBZ6Izw2PQrMQ4c4cIhXhBv1TY3848buRgPS5o5pNfGlUZ7YeiPPLi199RETcjXkT7e1UOkzsihmZb9B/GGvbCmgrvjUN2+0Vl30Fq5fouHAEJT6lHO2nrN+Gclq1FK8il0KmkfKDUjnVPf1g8PUrjwUwjT84f6v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mhi5lIp7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727827458; x=1759363458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tYjXEsXoiNSz94c3vfjym9RbDkZVTKhCXZfCvj9MDx4=;
  b=Mhi5lIp7Wp8u6+HRg5zuHlRUkgpl7mpk0zbuperEfnCOT2jqthkiW8ZG
   MGJ8Qb/eUrxSny8/eEgB4QDsfmk2wuKGJcvCgSxddtXF33UA954So7Os2
   u0W+Hm/ZXWsKm06/RNxhc9xban+rw0/wTVBeysQppTJvd2WnXhDT5pBwe
   RIWx8kpjAzxMjZspAw/493+o/PzAF0Rjl+8I4FQk+lAfJg/su+q/1mM7M
   B1EXr18JcyoOAzaUCQP4LOsc8VP6/mXqoVnDduZYWkOENCs92poyDIsWp
   clNpn1i73/toyke6IQtvY3U2bIySw1XixPeJs56t9dLncm1rJdGoldrYV
   w==;
X-CSE-ConnectionGUID: 2IyZBp7hRTeOkbsu0GuV3Q==
X-CSE-MsgGUID: gPTIuUeURO+CSniRk+jAIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26453086"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26453086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:04:17 -0700
X-CSE-ConnectionGUID: VE/bm+WBR8aJhMFtKuvsrQ==
X-CSE-MsgGUID: by8i+sngQwCQbx11hvgAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78376953"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Oct 2024 17:04:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svmqj-000RL5-04;
	Wed, 02 Oct 2024 00:04:13 +0000
Date: Wed, 2 Oct 2024 08:03:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit
 declaration of function 'i2c_transfer'
Message-ID: <202410020735.aBI61ZYn-lkp@intel.com>
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
commit: 25162a4f64f8ba0065f300977589fe1f6af332f0 Input: cyttsp4 - remove driver
date:   8 weeks ago
config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020735.aBI61ZYn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020735.aBI61ZYn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020735.aBI61ZYn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:38,
                    from include/linux/percpu.h:13,
                    from arch/x86/include/asm/msr.h:15,
                    from arch/x86/include/asm/tsc.h:10,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/input/touchscreen/cyttsp_core.h:22,
                    from drivers/input/touchscreen/cyttsp_i2c.c:16:
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:2928:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
    2928 | #if USE_SPLIT_PTE_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
      20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3050:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
    3050 | #if USE_SPLIT_PMD_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/cyttsp_i2c.c: In function 'cyttsp_i2c_read_block_data':
>> drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit declaration of function 'i2c_transfer' [-Werror=implicit-function-declaration]
      47 |         retval = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
         |                  ^~~~~~~~~~~~
   drivers/input/touchscreen/cyttsp_i2c.c: In function 'cyttsp_i2c_probe':
   drivers/input/touchscreen/cyttsp_i2c.c:90:14: error: implicit declaration of function 'i2c_check_functionality' [-Werror=implicit-function-declaration]
      90 |         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/cyttsp_i2c.c: At top level:
   drivers/input/touchscreen/cyttsp_i2c.c:128:1: warning: data definition has no type or storage class
     128 | module_i2c_driver(cyttsp_i2c_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/input/touchscreen/cyttsp_i2c.c:128:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
   drivers/input/touchscreen/cyttsp_i2c.c:128:1: warning: parameter names (without types) in function declaration
   drivers/input/touchscreen/cyttsp_i2c.c:118:26: warning: 'cyttsp_i2c_driver' defined but not used [-Wunused-variable]
     118 | static struct i2c_driver cyttsp_i2c_driver = {
         |                          ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/i2c_transfer +47 drivers/input/touchscreen/cyttsp_i2c.c

    24	
    25	static int cyttsp_i2c_read_block_data(struct device *dev, u8 *xfer_buf,
    26					      u16 addr, u8 length, void *values)
    27	{
    28		struct i2c_client *client = to_i2c_client(dev);
    29		u8 client_addr = client->addr | ((addr >> 8) & 0x1);
    30		u8 addr_lo = addr & 0xFF;
    31		struct i2c_msg msgs[] = {
    32			{
    33				.addr = client_addr,
    34				.flags = 0,
    35				.len = 1,
    36				.buf = &addr_lo,
    37			},
    38			{
    39				.addr = client_addr,
    40				.flags = I2C_M_RD,
    41				.len = length,
    42				.buf = values,
    43			},
    44		};
    45		int retval;
    46	
  > 47		retval = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
    48		if (retval < 0)
    49			return retval;
    50	
    51		return retval != ARRAY_SIZE(msgs) ? -EIO : 0;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

