Return-Path: <linux-kernel+bounces-369731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B09A21E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CCC284B38
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C21DD0E5;
	Thu, 17 Oct 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZ72juds"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEE1D88D7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167026; cv=none; b=tn+pgh0OmXSMOUunaZMuxCbK/QQRf9iO8+mQRyPRkxQifeN3JzKT3sx3S0x+P2gKyTkODMChMz7W6Cnc/Gk4xqi/CFDLSXqd7qAF8qsYrlTAXHrRXGMMH7dpNg7QIqbTXm4T3u6sT0rM7NwxCL78cmb++Xbb4WGTbTA1qScV1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167026; c=relaxed/simple;
	bh=W98tUE+Ifkh/W/kdB83NF+tetshF/l4KCS5OEk4oASU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OtvyUk9MxX//dBHrrQ/rD28VwHRIB0yGeow8Q3TjEfEVlRrcMeLZnw5zZxmENE4EbZsh4VAKmAdFVsEz07PILtmefD7kzG46qBYBUh9Hti6Wm56nqUoyAmBuSXEWA+5kO0rYahT5iEOLtQ9yHEBMjlarvDtystudIZ6T2ZSZokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZ72juds; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729167023; x=1760703023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W98tUE+Ifkh/W/kdB83NF+tetshF/l4KCS5OEk4oASU=;
  b=TZ72judsgH84M8k2C6KZ3W+tXTUEq5x0v4Tx1PAwcvr/NmlH3U50CZlY
   OTV1+k7B4iViieytNfVXGTDRXKOJFCFlGgLriRRE7JLbT8GChqsMZ7LwC
   aWjgoNt1Ok6KgVY/pblASO/Q2gNjpuxNNLel1zM23CbmzOzj+6v/WImrN
   2uNMJiBPFwr/N1xnYPgM90VIo9BNCgPrBixLWKsUIyl55rfSyug79Y7XK
   ueJ8TG4frAkO8HgbcR4hwEexQqmMj6+1n7FtiUQOlwB/roY0C6N5vbGGK
   4H7GrsG8ArwUDCfKJ5U04pkB8I1eAVcfP0uKekke/HwMOGLdIEV69RrXA
   Q==;
X-CSE-ConnectionGUID: L0xG48k+SGKpO+vvzkDKlg==
X-CSE-MsgGUID: 58iYp5z3S7O47sYK6kbjjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28532238"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28532238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:10:23 -0700
X-CSE-ConnectionGUID: 56qDFaGaSn672Z4To671rQ==
X-CSE-MsgGUID: Efr4kZRPToOtXmFgBFLjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83176399"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 05:10:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1PKd-000MHh-0K;
	Thu, 17 Oct 2024 12:10:19 +0000
Date: Thu, 17 Oct 2024 20:09:49 +0800
From: kernel test robot <lkp@intel.com>
To: Nate Watterson <nwatterson@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:726:15: sparse:
 sparse: symbol 'cmdqv_debugfs_dir' was not declared. Should it be static?
Message-ID: <202410172003.bRQEReTc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c964ced7726294d40913f2127c3f185a92cb4a41
commit: 918eb5c856f6ce4cf93b4b38e4b5e156905c5943 iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
date:   7 weeks ago
config: arm64-randconfig-r123-20241017 (https://download.01.org/0day-ci/archive/20241017/202410172003.bRQEReTc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241017/202410172003.bRQEReTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172003.bRQEReTc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:726:15: sparse: sparse: symbol 'cmdqv_debugfs_dir' was not declared. Should it be static?

vim +/cmdqv_debugfs_dir +726 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

   725	
 > 726	struct dentry *cmdqv_debugfs_dir;
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

