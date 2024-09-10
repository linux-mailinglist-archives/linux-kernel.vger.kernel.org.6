Return-Path: <linux-kernel+bounces-322296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E339726F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8ABB22D92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2514EC7E;
	Tue, 10 Sep 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIWHpf9K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70881804F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933944; cv=none; b=Gl0fx5UEbOFGLR4U4ZAXeqJ3odBFF3y29DTZiZ876+K/VNBuZpFqFKYxTcvRUHIQLPvvyTtu/RGvlf91Q31FEOauN3FIQO1wXtk6CVzVPS1bWE8+x6znfqqT8srCUHEcrKtaqrxLZP9q/3Tq+USigX/6eo40MyxZTSGQRj4jjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933944; c=relaxed/simple;
	bh=eHpLUMAhRPiz/JBUa5KLoHjCeXwIfT0oIM0GwenYoX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ggk8fVbJ1M4bdgREDTLW+25/ZGCbSPLapGmegzd3spTsmNxfu/YFcfMCzbQTtVTKBjqbgo4xXKpl4xEPRIjf44BTVJ6aGRSZ9VFj2O5ArsWehvxkCGUVDh5YV+oVizKheV57H2dp1QXCOWDTPYzjmic8n0o+XVvXJoV0L0ASZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIWHpf9K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725933943; x=1757469943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eHpLUMAhRPiz/JBUa5KLoHjCeXwIfT0oIM0GwenYoX4=;
  b=GIWHpf9K4jlI1Y1IINcfO3XIYeYQWMa6qqwwJPcR7ExwG3i86xxqJg1C
   dnHYuvdsnj+cqBXGfHrEaqU9hcgUQA93/ZspaA2V71CviHs0r85xYWOvv
   gW4iuOjv3DcVcH2e8fgtPq1w06qkxKDoMwLKA1t5d8IBlTwryg1UpzUHR
   WLobvyHKM3iX1ciQoGFkzrZBfY3nTCcMDAQL4Mm0Myeu88MPJPSJMRQTO
   Pa5Enci/yA9Zp3C0xH7qH1z6XlB0L50er//5Yiml3WARw4jZ+DwRIp0MR
   jou94ZMIZlibGAR6lHWI8GG1sWL8cmnqtr0bbbl3pJ8zfhUoQ6KGR5WMP
   g==;
X-CSE-ConnectionGUID: kLwwC/6/SCGhD3sW8WcTMw==
X-CSE-MsgGUID: VXN3UkBjTz+8aRLoSAlVmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24476988"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24476988"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 19:05:43 -0700
X-CSE-ConnectionGUID: 7smg1IzFTlivl0+yOWgcFg==
X-CSE-MsgGUID: 5SyrMEalSUCtO2oTrqeZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="104318432"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Sep 2024 19:05:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snqGA-000FWA-26;
	Tue, 10 Sep 2024 02:05:38 +0000
Date: Tue, 10 Sep 2024 10:04:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
Message-ID: <202409101018.B75pIBKR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc83b4d1f08695e85e85d36f7b803da58010161d
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   7 months ago
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240910/202409101018.B75pIBKR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101018.B75pIBKR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101018.B75pIBKR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
   drivers/md/dm-vdo/int-map.c:105: warning: Function parameter or struct member 'bucket_count' not described in 'int_map'
   drivers/md/dm-vdo/int-map.c:330: warning: Function parameter or struct member '__always_unused' not described in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:330: warning: Excess function parameter 'map' description in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:461: warning: Function parameter or struct member '__always_unused' not described in 'move_empty_bucket'
   drivers/md/dm-vdo/int-map.c:461: warning: Excess function parameter 'map' description in 'move_empty_bucket'


vim +87 drivers/md/dm-vdo/int-map.c

cc46b9554b3f6d Matthew Sakai 2023-11-16  66  
cc46b9554b3f6d Matthew Sakai 2023-11-16  67  /**
cc46b9554b3f6d Matthew Sakai 2023-11-16  68   * struct bucket - hash bucket
cc46b9554b3f6d Matthew Sakai 2023-11-16  69   *
cc46b9554b3f6d Matthew Sakai 2023-11-16  70   * Buckets are packed together to reduce memory usage and improve cache efficiency. It would be
cc46b9554b3f6d Matthew Sakai 2023-11-16  71   * tempting to encode the hop offsets separately and maintain alignment of key/value pairs, but
cc46b9554b3f6d Matthew Sakai 2023-11-16  72   * it's crucial to keep the hop fields near the buckets that they use them so they'll tend to share
cc46b9554b3f6d Matthew Sakai 2023-11-16  73   * cache lines.
cc46b9554b3f6d Matthew Sakai 2023-11-16  74   */
cc46b9554b3f6d Matthew Sakai 2023-11-16  75  struct __packed bucket {
cc46b9554b3f6d Matthew Sakai 2023-11-16  76  	/**
cc46b9554b3f6d Matthew Sakai 2023-11-16  77  	 * @first_hop: The biased offset of the first entry in the hop list of the neighborhood
cc46b9554b3f6d Matthew Sakai 2023-11-16  78  	 *             that hashes to this bucket.
cc46b9554b3f6d Matthew Sakai 2023-11-16  79  	 */
cc46b9554b3f6d Matthew Sakai 2023-11-16  80  	u8 first_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  81  	/** @next_hop: The biased offset of the next bucket in the hop list. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  82  	u8 next_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  83  	/** @key: The key stored in this bucket. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  84  	u64 key;
cc46b9554b3f6d Matthew Sakai 2023-11-16  85  	/** @value: The value stored in this bucket (NULL if empty). */
cc46b9554b3f6d Matthew Sakai 2023-11-16  86  	void *value;
cc46b9554b3f6d Matthew Sakai 2023-11-16 @87  };
cc46b9554b3f6d Matthew Sakai 2023-11-16  88  

:::::: The code at line 87 was first introduced by commit
:::::: cc46b9554b3f6d2f09b1111386b2706e5b4f56c8 dm vdo: add basic hash map data structures

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

