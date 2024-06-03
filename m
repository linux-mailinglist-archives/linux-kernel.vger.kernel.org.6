Return-Path: <linux-kernel+bounces-199388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCFD8D8673
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FF9B21A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D619131BDD;
	Mon,  3 Jun 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxbLk0Iu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98F6F2F2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429782; cv=none; b=HuqmEB7XHc0ZLePQrGyyQ/ueeiWuO0FklepCB5Yyx3WCg6pWR7jeQVZ0UGXo6JEEulWW4MaiEdw9SpwjQZYXRD0WPEOc/QvQN3dQezTIXw+6MIlE8/FnU3Z8mTkcKzqJWtTv+UIjxIZyk5ZdbNe2Nkwu2Dx+4Nn+3i+56ilv+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429782; c=relaxed/simple;
	bh=sAz/0G7IfCaSqCzpa1MGbHiAmlpqGZjbXMIKkPGrMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AuO+lRb380D9mv8e5pau7/zFbEP53bMH3DyB+YMpEqXKIpdWIvaN+XdwKYlCT4Z/KAfsc1R0sVuDbW0NYx1S7V4QFDjbp7VhvO3ZGpoW87jNgI4cV/odzzI97cnua3OB2q6S8UKTdZlcQsoLxxuR0H+jX6ZnMBMjY82xd5HCBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxbLk0Iu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717429780; x=1748965780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sAz/0G7IfCaSqCzpa1MGbHiAmlpqGZjbXMIKkPGrMlM=;
  b=WxbLk0IuepT9a12K2dN9L0pW0O07Ld63lCjRbl0biGNz5Z7w0ztQ3P0t
   Kn4NpNDHuANf+y9MnVec/u1OuXipGkQr06l9NcWuWFB9DD1Opyqjlij8Y
   kYQ9Tef5UJRxjtPFvXufF5LtS12PDrE2+GY4Fxl1pz3Qql+liTfZgLNzj
   M4xPRFUKfQiHMcU9HOHWV3K3ZUcHZISNFU1kqPrKYr4dg6HOLJTTPBhxT
   Tf4k2iBUna+PIijOUYZfmkVgqxDgfPy4JB/Y6+6pzRmcGp3XH2n7XQPT6
   y/Et23t4gQ8JkqszrPc49Iky9NhrSYXvjFUY9jyp5n0Y5iHnNalUVQn90
   w==;
X-CSE-ConnectionGUID: LY/dM+8VT6Si90VMqMLkBQ==
X-CSE-MsgGUID: PP6t5vqMT82ZjK4DzCXRig==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39332393"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="39332393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 08:49:39 -0700
X-CSE-ConnectionGUID: gzsSLXcNRMSSgNwaN94Y3A==
X-CSE-MsgGUID: Gga6ifBpTyWVypU7FalGog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37027997"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jun 2024 08:49:32 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE9w5-000LqJ-2g;
	Mon, 03 Jun 2024 15:49:27 +0000
Date: Mon, 3 Jun 2024 23:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [tip:irq/urgent 3/3] drivers/irqchip/irq-gic-v3-its.c:1973:62:
 error: macro "guard" passed 2 arguments, but takes just 1
Message-ID: <202406032312.di8cohFZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
head:   8dd4302d37bb2fe842acb3be688d393254b4f126
commit: 8dd4302d37bb2fe842acb3be688d393254b4f126 [3/3] irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240603/202406032312.di8cohFZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406032312.di8cohFZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406032312.di8cohFZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_set_vcpu_affinity':
>> drivers/irqchip/irq-gic-v3-its.c:1973:62: error: macro "guard" passed 2 arguments, but takes just 1
    1973 |         guard(raw_spinlock_irq, &its_dev->event_map.vlpi_lock);
         |                                                              ^
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/irqchip/irq-gic-v3-its.c:7:
   include/linux/cleanup.h:163: note: macro "guard" defined here
     163 | #define guard(_name) \
         | 
>> drivers/irqchip/irq-gic-v3-its.c:1973:9: error: 'guard' undeclared (first use in this function)
    1973 |         guard(raw_spinlock_irq, &its_dev->event_map.vlpi_lock);
         |         ^~~~~
   drivers/irqchip/irq-gic-v3-its.c:1973:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/guard +1973 drivers/irqchip/irq-gic-v3-its.c

  1963	
  1964	static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
  1965	{
  1966		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
  1967		struct its_cmd_info *info = vcpu_info;
  1968	
  1969		/* Need a v4 ITS */
  1970		if (!is_v4(its_dev->its))
  1971			return -EINVAL;
  1972	
> 1973		guard(raw_spinlock_irq, &its_dev->event_map.vlpi_lock);
  1974	
  1975		/* Unmap request? */
  1976		if (!info)
  1977			return its_vlpi_unmap(d);
  1978	
  1979		switch (info->cmd_type) {
  1980		case MAP_VLPI:
  1981			return its_vlpi_map(d, info);
  1982	
  1983		case GET_VLPI:
  1984			return its_vlpi_get(d, info);
  1985	
  1986		case PROP_UPDATE_VLPI:
  1987		case PROP_UPDATE_AND_INV_VLPI:
  1988			return its_vlpi_prop_update(d, info);
  1989	
  1990		default:
  1991			return -EINVAL;
  1992		}
  1993	}
  1994	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

