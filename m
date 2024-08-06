Return-Path: <linux-kernel+bounces-275715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E49488FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D8D1C2264C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD51BB6AB;
	Tue,  6 Aug 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8iMUTjT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE233997
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922443; cv=none; b=j+FwE2Z9+5Tf68uJZxMS5XaizHueKkFFDEXBazbD+zKe0DmUZWRMS0/W0RBOKYpYIDQmIHDROd/30PMSTV7w702uH9wFiNqhG3VHICc8eOCSX1nuo3KNyqqZgshSFJlLQLLESTL7C6vhI7QQ7LjQICjzDOpD7fWNMdxJwhiZf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922443; c=relaxed/simple;
	bh=wfir/TEkyJzeTkn3aLhB61Md5yefOfS6J2rNSgK7K+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p/23LRX6R0OqErcCEsB0XffSmbRS43j9/VgwZMrJJcpx76/fUQgkQGTofCC0bG/3FDSggatWhco+7LplLZv3+h70vy2/OniwLNIxOpNMqqhvBAD3gFeGQ2pkOIAh4wXzB6vJPE9Yv/rbac0pRNUYNsQGNF+9fVSbsWHEoxDDwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8iMUTjT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722922441; x=1754458441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wfir/TEkyJzeTkn3aLhB61Md5yefOfS6J2rNSgK7K+0=;
  b=L8iMUTjTXUOggBJZKpuiICa7sv8fzOMw41z/QoE3CyOJnr+N+EfZo5CU
   CJv9vqlPHSFHvXm1g9rdj7rHiCxglw54P7rhxxgeP/U9CAW1apXuFUKIU
   JJxKoO6xrZdHfWAlQFuRGID0pvnkU/wlXLaTz+GatG+ERiRKoKNC/5HZj
   3xRuPse2j4bvCNQ197ftY6O4ivsBkJQr9yePSngCj/r6TUP7UchnGQxbj
   V925PyROE0/Q1NZ8RFlV0EvjVlI3a2ygH0sVTzSUt4TE/PrVSQ8khR91H
   50AiqR4ogOuBAzS0QfoiOR8atLRYe1Vp/Ulm6+zPi9WFeEKoYMa+is8X7
   w==;
X-CSE-ConnectionGUID: rmTQteCKQ127KzWcxEY/lw==
X-CSE-MsgGUID: 5+GG+hwrRMC/wWvWN2RqtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20883646"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20883646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:34:00 -0700
X-CSE-ConnectionGUID: POpm9kTHSNmXaJDI+/QKiQ==
X-CSE-MsgGUID: +C8A/2zPRACELWNUzIH0Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56089368"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2024 22:33:59 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbCpY-0004Bh-39;
	Tue, 06 Aug 2024 05:33:56 +0000
Date: Tue, 6 Aug 2024 13:33:40 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Schumaker <Anna.Schumaker@netapp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: ERROR: modpost: "__popcountsi2" [drivers/hwmon/adt7462.ko] undefined!
Message-ID: <202408061322.n4rrGhOt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anna,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b446a2dae984fa5bd56dd7c3a02a426f87e05813
commit: a60214c2465493aac0b014d87ee19327b6204c42 NFS: Allow very small rsize & wsize again
date:   1 year, 8 months ago
config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240806/202408061322.n4rrGhOt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408061322.n4rrGhOt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408061322.n4rrGhOt-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
ERROR: modpost: "__popcountsi2" [drivers/hwtracing/intel_th/intel_th_pti.ko] undefined!
>> ERROR: modpost: "__popcountsi2" [drivers/hwmon/adt7462.ko] undefined!
WARNING: modpost: suppressed 3 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

