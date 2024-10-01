Return-Path: <linux-kernel+bounces-345171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D4098B2B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7384282412
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8118DF67;
	Tue,  1 Oct 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqxDaDmd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986918CBEF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753215; cv=none; b=JqNbPThI+m4aY+wFuyTfwTLoJFN32FyWVpRP8dLBvRA3eMX4bj7i5hwyg6femt1Oxt3amExO/eglPXpWqmxQGbMwKauymL611atf/i3cDNSETlfndLCjTUa2qBiXmGXHqdXxBi7oAUIe6eXcfDLduy/pNwpOI+3fbtmgU/HvWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753215; c=relaxed/simple;
	bh=BZSGgs6xQkIailMKfFzTNSA3/PsvFMStaPKXMjG0bKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LBLilCFUXzamY2kY6KRC2fhGOkJrRx3lkj7gwDzrgkQAU+BRdrRrrZwPI5valNIttlUlFsCdA6Nb4k+Ls/kIHhZAs9c3EQA+81DcePvgdGizLwcCupbGGi/I7Bz14RMmxUgXe2g3aTXG+EzS7dQwi5NsiXBeKRZRuOcC6mwPUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqxDaDmd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727753213; x=1759289213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BZSGgs6xQkIailMKfFzTNSA3/PsvFMStaPKXMjG0bKk=;
  b=iqxDaDmdyHPmDT0V3eCwyQd6i6nvXw1drHXlQl3s4hynY549HbEyvlmN
   Gvo5LtPFsLgJWO+GOiLs/PWeex2P82pnLFBBCc5zHo0+QF9m2Jxtfqngi
   1/Xe3IWkPnFRjhbaccIzfHP4izvet3ocLV+WwQ1KyGKuGJcUBSIiinmKK
   gD9bBCyWQgTqDFJ/jaU7mvZOstC/8fynj+TtlPKiujdD1ACGGv5gB9vr2
   yY1IDS+33OsRAy6eIKRTHhzvWFyGauohBh32mJeY84QR6KrGJ2l8sw5cK
   AHQtiIkMiHUPCyHqG9FqVxRdjTZfVyY7/Icu3D449jSeE2gmDjq9z1lzy
   A==;
X-CSE-ConnectionGUID: YizTDzOITu696qx/kO9T6A==
X-CSE-MsgGUID: gqLkx+2HTPyvrW5K354FxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44327603"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44327603"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 20:26:53 -0700
X-CSE-ConnectionGUID: 5KafOjeeTLaFd+bYywwKkg==
X-CSE-MsgGUID: 9YS5Ng9URk6VQ/OVI2W5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73819095"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2024 20:26:51 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svTXF-000QCV-0n;
	Tue, 01 Oct 2024 03:26:49 +0000
Date: Tue, 1 Oct 2024 11:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
Message-ID: <202410011107.U2xbVLRA-lkp@intel.com>
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
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   7 months ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20241001/202410011107.U2xbVLRA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011107.U2xbVLRA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011107.U2xbVLRA-lkp@intel.com/

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

