Return-Path: <linux-kernel+bounces-436776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD89E8A87
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01871281E60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBEA192598;
	Mon,  9 Dec 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THlDcfV5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E281714DF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720083; cv=none; b=N36X9XebECiHuRVLRLUAQpRuafVztPGeTTXrQYAO8K16m5NW6EAPuHG48Sgoxp00j3BNBUYpv37MjE3hCWc5owsJCIwBeN+pGfgz/Zjb64yWXlcgPtCdyF9i8eypWmmAqA9OIHErP4+2mTeEQSFUYBG6UY2mOLBNjJztV2vdLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720083; c=relaxed/simple;
	bh=25AC0ZW8bDmUdUGshgsdLaQkBtoAoEyjU9c5Pp/iVX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ahgdtohkMf9YozDOukn5eaCtNois/15kVd8/XR+EwqkkJ4meGzbDjoRbsHKohIIe08xhWKxelgvklvh3U24tLPWn5gj48gVdjJbd5880KHs5iXIzD+fgJxpCwuL8/rNhvgjxqoHNjdt6DS7jf1JLdJJ7U7SnbGiuBwINnA0v4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THlDcfV5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720082; x=1765256082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=25AC0ZW8bDmUdUGshgsdLaQkBtoAoEyjU9c5Pp/iVX0=;
  b=THlDcfV5TWLx4XX9yvk84hILB01T8kwR2lr1jRTUoNVmSoQzfAL0US/L
   EDptPM6cbOVwhLo4xIxbXONB1LPAo+CJYIjQ0A3MLx+ZSJ8kW3ViYyrRm
   mlpgJYDYM6QFozz77klsIi1J+6/V45TCJi9z2MR7m/y294CL9JQip4405
   8RTQ+q1MnZ2CskbEB/G/c945/exMU+fLlFB2NOHMfxtfmnv15unapH0Ha
   v8GcO7+CofrxIXog/V+YHrnKiL/jL/cNXdXQBgiYHa0OxElcJ3uViorbP
   SIeJNFbHIl7hdxeAkpyn8W8jX0U4QKQV4qTLuyyMdP2MLpnYGbw0VqfsJ
   g==;
X-CSE-ConnectionGUID: 60zs/RyAQZOqgUNSRSgZwg==
X-CSE-MsgGUID: fE+ydfvBSuaCK66hZnxJJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37932339"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37932339"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:54:42 -0800
X-CSE-ConnectionGUID: 5uhkmB6oQBuCdWikGDMc2g==
X-CSE-MsgGUID: 9KHn7Ma2TiuN5KkxsJeTvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94829900"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Dec 2024 20:54:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVn3-0003wI-38;
	Mon, 09 Dec 2024 04:54:37 +0000
Date: Mon, 9 Dec 2024 12:53:42 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Zhang <quic_taozha@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: drivers/hwtracing/coresight/coresight-tpdm.c:288 dsb_mode_store()
 warn: unsigned 'val' is never less than zero.
Message-ID: <202412090231.UXsQuWrr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 018e43ad1eeefbb8797e4c933953c50c09e3f4f6 coresight-tpdm: Add node to set dsb programming mode
date:   1 year, 1 month ago
config: arm64-randconfig-r073-20241207 (https://download.01.org/0day-ci/archive/20241209/202412090231.UXsQuWrr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090231.UXsQuWrr-lkp@intel.com/

smatch warnings:
drivers/hwtracing/coresight/coresight-tpdm.c:288 dsb_mode_store() warn: unsigned 'val' is never less than zero.

vim +/val +288 drivers/hwtracing/coresight/coresight-tpdm.c

   279	
   280	static ssize_t dsb_mode_store(struct device *dev,
   281				      struct device_attribute *attr,
   282				      const char *buf,
   283				      size_t size)
   284	{
   285		struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
   286		unsigned long val;
   287	
 > 288		if ((kstrtoul(buf, 0, &val)) || (val < 0) ||
   289				(val & ~TPDM_DSB_MODE_MASK))
   290			return -EINVAL;
   291	
   292		spin_lock(&drvdata->spinlock);
   293		drvdata->dsb->mode = val & TPDM_DSB_MODE_MASK;
   294		spin_unlock(&drvdata->spinlock);
   295		return size;
   296	}
   297	static DEVICE_ATTR_RW(dsb_mode);
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

