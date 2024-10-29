Return-Path: <linux-kernel+bounces-387767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D79B55EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39E9284060
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E620969B;
	Tue, 29 Oct 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYnmB7B5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C1209680
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241819; cv=none; b=G1lt9Z5BDOfYFVIZVsZkS8Yx6k94wPRLzjYZuscr/ff38s9/A8QQ+IPxCQHSEMTUmr2/Hc1Rd1E16pcyCTBvGV56msBFQE1O2OMRPcS1GZSK1xMhr9mNo00qBP3EKWwgN2HPZmgb0fK9k3J0bwAK0H7aLLnJmsq3gssn/mDV9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241819; c=relaxed/simple;
	bh=9E3Z00n7dYKrqXAk8LFX3TbpRib9iI7YXTzsr8EXrGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LC/dqLCmz4lwh2ISY2XFT5dqvMfU2uU5jiuDHR99eqDUkEqQp/IfCaSX7AFyteTwvPHJ8JOpX5OipgRl8e3Dt/Am5n/bv9w1HCUDedid7hHqfCns13LkB3kc+7IgCqJrpBr9v+zzdifTpZ4Dy8/308ysXwtLnirZ7vl+nvKOesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYnmB7B5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730241816; x=1761777816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9E3Z00n7dYKrqXAk8LFX3TbpRib9iI7YXTzsr8EXrGM=;
  b=lYnmB7B5SubWFBN7fvmrxvQ0SeXlfH+EW9hC3a5YtJ9ahjCzIHHWrf5n
   me5Oj15Hg17JMHJuuKadrvjw2sxZJ9MDSfbj3aFRASQlTxAnal0YZA/LP
   K+gAFhJe03r6ilwo6rfvdxXtwHzXHZ1FvAUjHbHktr/U5ZarxVZbOIvNT
   266N6IihOpaLd5Xv3qdmErj3SUw14bg2KC9nRBXyRVjSmk5ij9UZMcvP+
   FBh9ykx2+Mnzb0+/7RUvFRYXDELmShRPQSmHenSf9AbUi2afoKNEHk9Ue
   U9t+sgEyr4bIm3oUIkfO738/sDrViqrAarsjvEeP+v9lsFUR/bM3QE3XK
   Q==;
X-CSE-ConnectionGUID: EVxUW50WRlSBbFqdWSHzlQ==
X-CSE-MsgGUID: w4HalFGgTKuCRxyRUaDyAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41016316"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41016316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:43:36 -0700
X-CSE-ConnectionGUID: 9Jf8mYLNSx+TaDVCDfm+Mw==
X-CSE-MsgGUID: HYBiyAk8QkmML/eTtjuhtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="81661933"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2024 15:43:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5uvz-000eEy-2y;
	Tue, 29 Oct 2024 22:43:31 +0000
Date: Wed, 30 Oct 2024 06:43:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/kbuf.c:271:5-24: WARNING: atomic_dec_and_test variation
 before object free at line 273.
Message-ID: <202410300609.JP8Dq6wz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e42b1a9a2557aa94fee47f078633677198386a52
commit: 6b69c4ab4f685327d9e10caf0d84217ba23a8c4b io_uring/kbuf: protect io_buffer_list teardown with a reference
date:   7 months ago
config: arm-randconfig-r061-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300609.JP8Dq6wz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300609.JP8Dq6wz-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> io_uring/kbuf.c:271:5-24: WARNING: atomic_dec_and_test variation before object free at line 273.

vim +271 io_uring/kbuf.c

   268	
   269	static void io_put_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
   270	{
 > 271		if (atomic_dec_and_test(&bl->refs)) {
   272			__io_remove_buffers(ctx, bl, -1U);
 > 273			kfree_rcu(bl, rcu);
   274		}
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

