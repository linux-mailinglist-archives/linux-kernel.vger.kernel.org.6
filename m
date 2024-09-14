Return-Path: <linux-kernel+bounces-329151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1897978E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DF21C226D4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6444376;
	Sat, 14 Sep 2024 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a//pjtFh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1C49630
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293287; cv=none; b=kbSYuQIRN3LuOhxZyfGhrrB14hh8uMaK+cEEfY7I8j4YmjrUIcJYGpLeWrj/5S1hf8lX+GaVklvmuq53A8sWeazqHPzGhgXF8wWFsGBk+X4XzUKsNCGVTuGzXxhlMI/h+VNBYQEqc58iFTHbkTh6mjtUd5xBJV1nlCO5kdss+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293287; c=relaxed/simple;
	bh=ZLBKNq0IphChD+uYcOGVnCk5dABAxh20ThwO2CsQFo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eBSqdr/0brcpRej5OU7oFsyO1VHBHuzsNnn1KodsgoITxj2BRAb3D6E1SywWV7Csc2eS1x0Vbovl8ZU8zTH5QeOqwR6HSV899nszlsWUxxKmAD0ePkVYLDyG9nZns9mMEFsU6hZQT2yocW8kPzhfwFlmILIp9Nk5RkolK+hFf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a//pjtFh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726293285; x=1757829285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZLBKNq0IphChD+uYcOGVnCk5dABAxh20ThwO2CsQFo4=;
  b=a//pjtFheR+lDjFSTv8CfwKWKeHXeJuYuWD1oVWgNMecQdWPKttjWano
   6nNyq0SJz6cDHbyA7LoCWyeQu/uAQWslLDyVxkZUzbXhGG/OsTjIWuy+5
   qoGJ5Slt3Ajia18Go53EhzgWF24tIFpZHpHfg2hYQo4aNhVB1Ij39FP1F
   UGnotjuRmC1zabpW/g4UAeTbT56ffOUYdaadQylb+vub7t5jJjX0UaCHI
   dyG6GQ3LKXaog57TmXCj68BmPhHDmJSYcUv3cZmzMUa7FnyeSzZzzQBK2
   pCWZrcGGsVRaMlaincq/7zdz4aPMev7OTS900Yf0C12cmvGldvMW/2qUQ
   g==;
X-CSE-ConnectionGUID: vYsIyTzDTw+DmHRbjLjx4g==
X-CSE-MsgGUID: ZO0Y5UdnRQiAVTIR+Omg/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42678423"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="42678423"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:54:45 -0700
X-CSE-ConnectionGUID: fKL4IcV4RnmZg2YEptAk2Q==
X-CSE-MsgGUID: Mo+S/tC0RripLi3SUTr3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="98995434"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Sep 2024 22:54:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spLk1-0007QZ-15;
	Sat, 14 Sep 2024 05:54:41 +0000
Date: Sat, 14 Sep 2024 13:53:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Subject: drivers/gpu/drm/xe/xe_oa.c:401:15: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202409141346.Wokfate3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b7718454f937f50f44f98c1222f5135eaef29132
commit: cdf02fe1a94a768cbcd20f5c4e1a1d805f4a06c0 drm/xe/oa/uapi: Add/remove OA config perf ops
date:   3 months ago
config: arm-randconfig-r132-20240914 (https://download.01.org/0day-ci/archive/20240914/202409141346.Wokfate3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240914/202409141346.Wokfate3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141346.Wokfate3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/xe/xe_oa.c:388:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __user * @@
   drivers/gpu/drm/xe/xe_oa.c:388:25: sparse:     expected unsigned long long [usertype] *ptr
   drivers/gpu/drm/xe/xe_oa.c:388:25: sparse:     got void [noderef] __user *
>> drivers/gpu/drm/xe/xe_oa.c:401:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] __user *register __p @@     got unsigned long long [usertype] *ptr @@
   drivers/gpu/drm/xe/xe_oa.c:401:15: sparse:     expected unsigned long long [noderef] __user *register __p
   drivers/gpu/drm/xe/xe_oa.c:401:15: sparse:     got unsigned long long [usertype] *ptr

vim +401 drivers/gpu/drm/xe/xe_oa.c

   377	
   378	/**
   379	 * xe_oa_remove_config_ioctl - Removes one OA config
   380	 * @dev: @drm_device
   381	 * @data: pointer to struct @drm_xe_perf_param
   382	 * @file: @drm_file
   383	 */
   384	int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *file)
   385	{
   386		struct xe_oa *oa = &to_xe_device(dev)->oa;
   387		struct xe_oa_config *oa_config;
   388		u64 arg, *ptr = u64_to_user_ptr(data);
   389		int ret;
   390	
   391		if (!oa->xe) {
   392			drm_dbg(&oa->xe->drm, "xe oa interface not available for this system\n");
   393			return -ENODEV;
   394		}
   395	
   396		if (xe_perf_stream_paranoid && !perfmon_capable()) {
   397			drm_dbg(&oa->xe->drm, "Insufficient privileges to remove xe OA config\n");
   398			return -EACCES;
   399		}
   400	
 > 401		ret = get_user(arg, ptr);
   402		if (XE_IOCTL_DBG(oa->xe, ret))
   403			return ret;
   404	
   405		ret = mutex_lock_interruptible(&oa->metrics_lock);
   406		if (ret)
   407			return ret;
   408	
   409		oa_config = idr_find(&oa->metrics_idr, arg);
   410		if (!oa_config) {
   411			drm_dbg(&oa->xe->drm, "Failed to remove unknown OA config\n");
   412			ret = -ENOENT;
   413			goto err_unlock;
   414		}
   415	
   416		WARN_ON(arg != oa_config->id);
   417	
   418		sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
   419		idr_remove(&oa->metrics_idr, arg);
   420	
   421		mutex_unlock(&oa->metrics_lock);
   422	
   423		drm_dbg(&oa->xe->drm, "Removed config %s id=%i\n", oa_config->uuid, oa_config->id);
   424	
   425		xe_oa_config_put(oa_config);
   426	
   427		return 0;
   428	
   429	err_unlock:
   430		mutex_unlock(&oa->metrics_lock);
   431		return ret;
   432	}
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

