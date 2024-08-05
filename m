Return-Path: <linux-kernel+bounces-274503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D883E9478FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F73E1C20CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6D153803;
	Mon,  5 Aug 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kds9TAYf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBB14D456
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852282; cv=none; b=c2Q5jYFFEctlP0GMmurB0GiDnR3BEp46zGfzzbYWaPPBBBYEXaAiWjkcr3PFz/KFuvdSyvndaR90J1LlIWdXObIUdkjh1gJbYmQ50H/aQAbNvldVkuQCrtDN3ymWLOAI4usUK0Cd+L0SiE6kccrNmrCKWbPQ+4PjijeadgNPrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852282; c=relaxed/simple;
	bh=DHCK5EzPFWfoSWC30hJdr2F05P1VmNla4Ud7dS/pMSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OU70Lvanl6rkSwIB6S3XBiEhicnOgl8DG/Efk7mOrBcxzfpRFfIxJ3BOQrs8Vk/7iZ4HBCglNfnGPISwRJdMtcIAhwn6ztMuN2sM+VYfsOHhHOrBBDl07fn1xgMSDmlChltGo4NBAh4v2A2QtaKfi6ByIwZuqBWQ6RIA3dFf1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kds9TAYf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722852280; x=1754388280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DHCK5EzPFWfoSWC30hJdr2F05P1VmNla4Ud7dS/pMSM=;
  b=kds9TAYfqpJ3BatKsPbZ7dtpA+7lobS6go3YuULt5fwNNBPgmc75+GWr
   V3EHhIpo7BAMjYjCEeYyRaYLFkz+Z58ZlYj+ADvVi958SfSMI50XufIdK
   mF/B3gV6LV/c97mr8DF0Hw2Je4TuauJizTRGDdbsWdy4xSaGd45E2OkNP
   Ua5SHrCEUi0hE5fw8dugLY9IoJfWwmjriILZqrVtsPvlCs10YF9uySgCL
   +QbhjgZjmSCMi+pEGAiFtu/OEzGbU+ijwPVuRXW3HGc1W5x+jPYazAKw4
   602QPQ6StqcwKB5fe6bNn/nyxfmfQDwAh70rmCAIOOQVO7/WP3USvdH85
   w==;
X-CSE-ConnectionGUID: W/aA8ZIkS9yOXsRsTuurdw==
X-CSE-MsgGUID: GVyTRNGwRMCmO60Jtf+qqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31462834"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="31462834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 03:04:40 -0700
X-CSE-ConnectionGUID: S03/D9r5TiO7RRwUw4KP5w==
X-CSE-MsgGUID: hg2Zc3pPTIavltbCboXIbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56036259"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 05 Aug 2024 03:04:39 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sauZw-00023k-12;
	Mon, 05 Aug 2024 10:04:36 +0000
Date: Mon, 5 Aug 2024 18:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: fs/xfs/scrub/common.o: warning: objtool: .text.unlikely: unexpected
 end of section
Message-ID: <202408051834.jcuyCxWe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
commit: b27ce0da60a523fc32e3795f96b2de5490642235 xfs: use dontcache for grabbing inodes during scrub
date:   3 months ago
config: x86_64-buildonly-randconfig-r005-20221226 (https://download.01.org/0day-ci/archive/20240805/202408051834.jcuyCxWe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408051834.jcuyCxWe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408051834.jcuyCxWe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/xfs/scrub/common.o: warning: objtool: .text.unlikely: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

