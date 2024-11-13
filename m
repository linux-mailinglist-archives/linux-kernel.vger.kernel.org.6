Return-Path: <linux-kernel+bounces-407733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADC9C73E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B4B23A34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D122339;
	Wed, 13 Nov 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf/paZAQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614AE111AD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506618; cv=none; b=iYJJ/oN5925BimkSSAipsi1/KoiX9KDx/Dz0dI2n3mip5SWJdPJrUbYj+fLJqq+e4YHGDbMLHaCnYnCb4DsSnXQpG9kvsEt8k2HaT9WymVQHz5QKWze+w0tR3z6Zb1s40pELZyBmpvghvpPUWv+KqqS7v18J7FIPtqvXcWIc5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506618; c=relaxed/simple;
	bh=mQwM7MUR+K6GisLt//X9jfcRj3guSvU+ov8rpExK3DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6XRKUvtOQPhw5Sma+LqMtGloK1CW5uLfNUo9vPtLPlqHlt/a8ux2yS6Xfd+IN0qwvOklbov15FXEc8V2aGak4R1iNCZY5to+DIYwqNT7GYqoPeZC57QlgYKoMIW4eDc+qSWmdnM5db6yJWC+uQBS3Zr2mr2Ix+Q3sjsz0fOMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf/paZAQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731506616; x=1763042616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQwM7MUR+K6GisLt//X9jfcRj3guSvU+ov8rpExK3DU=;
  b=Gf/paZAQd98W63r7o6fzrVj12z7pcnaWZwJHURYRNhogPjqGmZRrHtgp
   CB5xSOYq3FfNLVmEtOYEAzuoUa+p/tLDzhAU9+Gm/XYg9Tsn/XotZqitk
   YoSouwGQe5bjN2qJ1f+AS+UJF0Q3VuT9zVC6LcxhHDebHJrfOabcqcJvy
   LuMyJTNd/EOTi0+ax2/TGK2EIHD/wLVD2KLROopnqAQrS9FAhdlqPi9Ry
   VR/ijmCAiDEJ+YIQHEurRp+nTAoKGykn3OC8yHPhn6GePDR95mRcpl6qZ
   pd+MjourUcp7LlAta/g97djLOhddrNGOt24WtE8M9UP4vK0S2NlnG49nS
   Q==;
X-CSE-ConnectionGUID: f6c9CHZgQseFPK9WjJqW1w==
X-CSE-MsgGUID: 4m0doOonTa6njrb8bisiJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31555510"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31555510"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:03:35 -0800
X-CSE-ConnectionGUID: EXvLhkO9RHuITBa/hoTiBg==
X-CSE-MsgGUID: drpgI0sYT1q0bkphm50NpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="111194773"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2024 06:03:32 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBDxy-0000RV-0p;
	Wed, 13 Nov 2024 14:03:30 +0000
Date: Wed, 13 Nov 2024 22:03:20 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Chao <liuchao173@huawei.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lixiaokeng@huawei.com, caihe@huawei.com
Subject: Re: [PATCH] Add interface to trigger backtrace on specified CPUs
Message-ID: <202411132108.ZvhAmel0-lkp@intel.com>
References: <20241112125609.1406586-1-liuchao173@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112125609.1406586-1-liuchao173@huawei.com>

Hi Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Chao/Add-interface-to-trigger-backtrace-on-specified-CPUs/20241112-210050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241112125609.1406586-1-liuchao173%40huawei.com
patch subject: [PATCH] Add interface to trigger backtrace on specified CPUs
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241113/202411132108.ZvhAmel0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411132108.ZvhAmel0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411132108.ZvhAmel0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/backtrace.c:29:12: error: use of undeclared identifier 'no_llseek'; did you mean 'noop_llseek'?
      29 |         .llseek = no_llseek,
         |                   ^~~~~~~~~
         |                   noop_llseek
   include/linux/fs.h:3241:15: note: 'noop_llseek' declared here
    3241 | extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
         |               ^
   1 error generated.


vim +29 kernel/backtrace.c

    25	
    26	static const struct file_operations backtrace_fops = {
    27		.owner  = THIS_MODULE,
    28		.write  = backtrace_write,
  > 29		.llseek = no_llseek,
    30	};
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

