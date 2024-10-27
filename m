Return-Path: <linux-kernel+bounces-383580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FFA9B1D91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FCE1F214E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130214B941;
	Sun, 27 Oct 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSbnYYjK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764467710C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030469; cv=none; b=LG3r7dk9ignEomfhyx3GdcZ9LhZEH8YSDy7FvluunUYRYb6Ea8SQtaWX1X3GrweItW392jNTOxIwki0+0pAw5jB/222EwqjbhfmTxiXs4k79Q6i6bT9H0osnL4iz0dk0ndTkrK5F9YMNfYFzMbO8GvnwrNRYgAfKB6/+EC0NGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030469; c=relaxed/simple;
	bh=4nPZMrtluGHNTPYya58gPauYxNHpBPyBGDUKo7VWS5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IrQ/A+81dy/YZDFyTW55feWXHGakTlbbAO+chIea7YNLcwh47tL3Thyg3xYxS3W4DGf8u4/F9zNSbBgLoKvsO7c9cAlmic3ZorN4ARqhh7twWFQQKQBIEnoBE1WPO+nXDB7H5TNZrWyAvvXZVV8Xw1XrdSJ2JNs56d3e/r87BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSbnYYjK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730030466; x=1761566466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4nPZMrtluGHNTPYya58gPauYxNHpBPyBGDUKo7VWS5Q=;
  b=PSbnYYjK8Qx7P8OfawYdOA/Ns1CgARwyytZ2SQ5XNSFnU+XIyZmqxnzw
   NFCxb8MTPIoPbnAE4ml4KSVIcpNihBFtc/ES2mrftSlHzc/zntO/KHh+c
   4I3wrOkYq4oKl5Vas0RraQ/Z7jVQ+ANpsidM1VyVKxibtvpyU62xfVANA
   12kZf9xYkdm3l3WU+KxNeEmhdxbPGVBWnBbSWpi1iugHcm4KIRhel7Xc2
   gTLlK/CoXWaS84qHfR4LjG/v2F74dvMoIIeaqiMrUKgkyEKrviEIzjKhP
   GTQUGfX1NgN+T93/e1bef9LiBePjnhxJ2+6+iR6fpt7w/e07IQzG6q955
   Q==;
X-CSE-ConnectionGUID: jTYT8mrJSLmF2BrP4IJkEQ==
X-CSE-MsgGUID: TswgylmCQPm9W44KSYODGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="33442006"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="33442006"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 05:01:05 -0700
X-CSE-ConnectionGUID: NbCbSKxjT+2ipaPR9Hvj/A==
X-CSE-MsgGUID: iC3GAu3QQxeEBuJ70dYjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="104686158"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Oct 2024 05:01:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t51x8-000afs-15;
	Sun, 27 Oct 2024 12:01:02 +0000
Date: Sun, 27 Oct 2024 20:00:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Subject: drivers/gpu/drm/xe/xe_oa.c:401:15: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202410271916.ugChvDGA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
commit: cdf02fe1a94a768cbcd20f5c4e1a1d805f4a06c0 drm/xe/oa/uapi: Add/remove OA config perf ops
date:   4 months ago
config: arm-randconfig-r123-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271916.ugChvDGA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce: (https://download.01.org/0day-ci/archive/20241027/202410271916.ugChvDGA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271916.ugChvDGA-lkp@intel.com/

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

