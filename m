Return-Path: <linux-kernel+bounces-251333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B99303A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE6A283D18
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967133D1;
	Sat, 13 Jul 2024 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrK+3PS/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AD1870
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720845246; cv=none; b=FP1pQsUON3JJ1dky0LBethoum73kc/bnhdNeEUyR9IQjlSvebL6Xr/JuZm4hM9xE3xhvJlhG6uZqP35/X0MLf18PlD+EVqEGt9kuLUxOK74kspzUrba71sH4UZMRsjPYYsEci1dEmjdXJflbtn6mIji8EK81eBuxba4pTdAy0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720845246; c=relaxed/simple;
	bh=180YlyQvz8mEyOSMDYutC4JLb7HsRMTJjfmK/cK5aOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fl1K2/BLq61Si0AoFBQuYE1124lkMBm3MbXgWaKktD/STdgY7CfEdHDqU9huiqRf6KqElAjWVTZAPPVNdsY6m/CvOS4lQVcX292GS2c+YFDuVrxImgQXMmcma8XYRV0GinSPb6SPJYL9EMF2HqB6N61KlQuxNbtPDTgvApruTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrK+3PS/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720845244; x=1752381244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=180YlyQvz8mEyOSMDYutC4JLb7HsRMTJjfmK/cK5aOY=;
  b=YrK+3PS/a2bLGmqvVLN7x/TeYB+NSspvKFlsYpJoejvtZEqb3bZvbOcA
   5D1BvgmBP4+YsC946mpuPjRSdJsxS9AzuRc1iC4FMBIJKwpVX0OH/0Elq
   Y3JAQ3WFEHHDM6liSccCRya66VFS8J78IiQ48XOXTy4OD6X9cF3+z30Pd
   oyOI4lncHguvLvoyNu/Am1Z7mdGjgiwowAsF88acOYp+B3rxsb882Mfqi
   lzId+DivgnCPyzmGzhPBeQI0E9Now58tFxOuhZQHpb/4ky1TSYSeGFmsd
   krStU0QuGQ4/VSefSjUfs+9PUkX1DRYwPgPgnGQ0rgMyc+tIk8GKfexsq
   w==;
X-CSE-ConnectionGUID: 7LGiw+zGQhmwB7GZfi8cjg==
X-CSE-MsgGUID: DigV/rM+S4uibhXUl041kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="17915962"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="17915962"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 21:34:04 -0700
X-CSE-ConnectionGUID: a+jRCVjdRyKhsPUdU2GTgg==
X-CSE-MsgGUID: 2DC4OgmWRcCzC2+TXzjVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="54050530"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Jul 2024 21:34:03 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSUSO-000bh0-25;
	Sat, 13 Jul 2024 04:34:00 +0000
Date: Sat, 13 Jul 2024 12:33:56 +0800
From: kernel test robot <lkp@intel.com>
To: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "xmb_inject_err" [drivers/misc/xilinx_tmr_inject.ko]
 undefined!
Message-ID: <202407131208.j6frPIb7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   528dd46d0fc35c0176257a13a27d41e44fcc6cb3
commit: 895ae5bee159d148bac21a82899292c408c1aab1 drivers: misc: Add Support for TMR Inject IP
date:   1 year, 6 months ago
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240713/202407131208.j6frPIb7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131208.j6frPIb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131208.j6frPIb7-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "xmb_manager_register" [drivers/misc/xilinx_tmr_manager.ko] undefined!
>> ERROR: modpost: "xmb_inject_err" [drivers/misc/xilinx_tmr_inject.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

