Return-Path: <linux-kernel+bounces-230062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B39177F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634B31F2211F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534213E3EA;
	Wed, 26 Jun 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f22WUHXa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3022089
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379078; cv=none; b=mUWdxINGRmEwh4u0hvEWMTTAAmucGH5Bfq2xeyPOL2h1jG54Xzel0kz6FhneTSnTDG7M3oFnUCziX9U87IcOPVO62py7DOE4TBe1EIud5bdxtdxiELPSSqWo2Fpst7bzH72mJmQsAhgFb9WKJuP4s2Cozfr6MMQKU6xxCOTYhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379078; c=relaxed/simple;
	bh=5490Gp8c+2F2vrqCK3ohvVNWHHbIVol+9XYfVM63o6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+SXpAFFjEmCGdWHCn6wPksq1kaZMEav7zOMkgl1+h0LOhuQU/bbxC5UMvc20cu7hEZDcynwhDy6Bt4NPANieZuNn0l9IuXYgSlYTdSivDwTc0vCzrkHw/4+6jxfCtPwJpUIdrehEe+ptsht+6TKj/5KJLijxHiZrUar4nQHfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f22WUHXa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719379076; x=1750915076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5490Gp8c+2F2vrqCK3ohvVNWHHbIVol+9XYfVM63o6k=;
  b=f22WUHXaGVl5P8ogj6CBGiwvaNzzwnbrOqn3vR8VI3LYLwYWfY9aX4ca
   WdyXu7CZv4bHkd3KzPsYlc4mVqVAabD2Su7mWuthhc4ougwaw90D+0ZiV
   JKKlRGxVzT/h6fKeh5lQ9lOQl+LpHUoI5VbAt5z7QHIy9gjDOK74WtZ0U
   SZYXsCYno2HXQKRE5iHZRIZcxtR4BrPFzJ9rr8q1MSYgccuVb0QH/7DkF
   0u/A/DqpLDZ0fEv0Ml3Wp32ed/4X/59+WlgyWdYXuUqeI+Rtpbd0cPoYJ
   3jeF+82KzfVt6Mj9a1JeMbybxxnc2OZuE14Cz1tPDrdQnuMOC9nGJBajk
   g==;
X-CSE-ConnectionGUID: wUpohQeBTiGRhVL5G1eHhg==
X-CSE-MsgGUID: oUOGXXjTTCStLFa8TXh+9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20207266"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="20207266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 22:17:56 -0700
X-CSE-ConnectionGUID: RyKmArY4S9KBTh0nqVMD2A==
X-CSE-MsgGUID: u45v10tsRxSrhirAK5DjVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48261648"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 22:17:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sML2U-000F0r-1M;
	Wed, 26 Jun 2024 05:17:50 +0000
Date: Wed, 26 Jun 2024 13:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Sun <yi.sun@unisoc.com>, sunyibuaa@gmail.com, tj@kernel.org,
	jaegeuk@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ebiggers@google.com,
	jiangshanlai@gmail.com, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, niuzhiguo84@gmail.com,
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH 1/2] workqueue: add io priority to work_struct
Message-ID: <202406261227.ngU3vsdJ-lkp@intel.com>
References: <20240621062617.595007-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621062617.595007-2-yi.sun@unisoc.com>

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-wq/for-next]
[also build test ERROR on jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Sun/workqueue-add-io-priority-to-work_struct/20240625-165935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20240621062617.595007-2-yi.sun%40unisoc.com
patch subject: [PATCH 1/2] workqueue: add io priority to work_struct
config: csky-randconfig-001-20240626 (https://download.01.org/0day-ci/archive/20240626/202406261227.ngU3vsdJ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261227.ngU3vsdJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261227.ngU3vsdJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/workqueue.o: in function `may_adjust_work_task_ioprio':
   workqueue.c:(.text+0x460): undefined reference to `set_task_ioprio'
   csky-linux-ld: kernel/workqueue.o: in function `restore_work_task_ioprio':
   workqueue.c:(.text+0x47c): undefined reference to `set_task_ioprio'
>> csky-linux-ld: workqueue.c:(.text+0x4bc): undefined reference to `set_task_ioprio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

