Return-Path: <linux-kernel+bounces-364867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6199DA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D48F2821F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE81DACBB;
	Mon, 14 Oct 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5wu+2xl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B81DAC90
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950003; cv=none; b=KIxiSwwzS+Wk6jPvGj3wjRzH6FF6ANdKoCLFdC2KZZ+u0Bjea3eJpn+EmFr3mDAan3oe71rU3n+U7HqfCUmUbXVUrPf9tFRivvK8QMN7d8ZBIzG6+OEX3cGMWfDLCWSPVWGwXLrvWCr/lznUufwqLaAb6aSDo7blD2gKwRgXdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950003; c=relaxed/simple;
	bh=ooDDEFX8S6g3joVM9vzvha0etGZHvlyZXHSDj/hz2JY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uhkGIQ5178tgQcU9z9yZyyit3Yy0ewGGzXpK1nRTHVTrI6dh151DalcGz0a7JqRu8Vw2EuuAtfTaob9aSx5s8SiU83H/c8OGrM1Cd87kYrsd4L1bLy9u86qDaLz5sZq8J2Hw/K0CAosRwgJht9cOowTmZIhtaqelTZeJ/ys+dI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5wu+2xl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728950001; x=1760486001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ooDDEFX8S6g3joVM9vzvha0etGZHvlyZXHSDj/hz2JY=;
  b=m5wu+2xluhZUga5YK1f34jz1aguv7Wmoa1fBH5t2HFaG1CnROt8jGAi1
   w9RheQJoCxuudO1SZRbyrktvhfGCp6tHY/3HSnPHVGChq0st3fzbR1obC
   sDRQrILawXEc90AHXxx2M4RNJ431TQFXCu+hwGDI7WoW+VPF4XPBiDbS+
   9awCMLp3qjUfxPWbqxIryuGQpC4DLErK07SoslAE73pHNp9t7IB/QCTsx
   8SBwqRkeBJfnyUI05Rke99OCEil0JnUbmu4Z+3JEDpNDLmWm8n1n56Epb
   4y0Y0jL3bisjua3fqto+7L7J/GsgvSiz+WjpsE180/Xcduzi2NVxBesoi
   Q==;
X-CSE-ConnectionGUID: V3HEF2a8SmO1sakp5kGOFQ==
X-CSE-MsgGUID: E7kFwj2JQ/6mQj7CDoaS5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38956042"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="38956042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 16:53:14 -0700
X-CSE-ConnectionGUID: yMIZn+L5Q6++45OiJ7596g==
X-CSE-MsgGUID: 5dGVirN+SxCmkBFFlWtHgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82341048"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2024 16:53:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0UsB-000HL1-1p;
	Mon, 14 Oct 2024 23:53:11 +0000
Date: Tue, 15 Oct 2024 07:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Zhang <quic_taozha@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: drivers/hwtracing/coresight/coresight-tpdm.c:288 dsb_mode_store()
 warn: unsigned 'val' is never less than zero.
Message-ID: <202410150702.UaZ7kvet-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eca631b8fe808748d7585059c4307005ca5c5820
commit: 018e43ad1eeefbb8797e4c933953c50c09e3f4f6 coresight-tpdm: Add node to set dsb programming mode
date:   11 months ago
config: arm-randconfig-r073-20241015 (https://download.01.org/0day-ci/archive/20241015/202410150702.UaZ7kvet-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150702.UaZ7kvet-lkp@intel.com/

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

