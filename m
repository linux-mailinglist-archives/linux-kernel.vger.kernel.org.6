Return-Path: <linux-kernel+bounces-334845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB197DD4C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01D3282263
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3E156C7B;
	Sat, 21 Sep 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnmGn8si"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1905381E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726923653; cv=none; b=VwdoPrg11c4lYHYmPfN3yEBxb2sK6J254XPx4YxngD+afcLboWz0ies0jabQ8mlV50itYxXPpKfsGFbiw0XiPBX906qnimlKL5CN5Lx3/uWeZxuv3UJZAZMoCnhPkEewFh6PvNIFsCbEjrfqJZAvZcw5lYupZosSvpJTb7Pwzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726923653; c=relaxed/simple;
	bh=Pmek6XAve7jVPI6J2vxpueFwka4dfbjCe5CSQWVH3QY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xtpnrxwrih4O0DqS6+E4DpOajaKpFA7hffxh9UzubWFhr/VAK4YNS9akMI10NnLzvvKpUqrfoze9CDPwHWb9Sjedct7GZw2IC+Ft4rrPgY7t3HZNE5Z/6BFI46zFhOI3hl1FbWSgnWCG+LfllfmE+fbeeuG7T0xfj6ULOuKr8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnmGn8si; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726923651; x=1758459651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pmek6XAve7jVPI6J2vxpueFwka4dfbjCe5CSQWVH3QY=;
  b=XnmGn8si4sZt/zPneW0KsMOZDGXuK7r40t0xV+4bbkPqgiDTyOropSwS
   YyApVu51cYvGve+MjpbOprz4lawPnZjsNZlhl8x5qVKWYShI5TTd+1cFX
   Oyjn6h0cxc+WuREFdsb0hxUcUc5ho+xTxwzZuw1Ifa2pcPxgycljbi9mH
   a6RNZQ9w4gv3doOWLYKL+zangPsKxJ2Anb0xtWJvtuWdz/tooJyiaVp96
   W/91uOM98kkZUSlQrhMYIi2im/pt2Y2mcbp32l5c/8icfuPH1uvjRjv5P
   bbAziqgijiDJCSjd1daIU6KVw/ogTfLQpy+CqU7iKebo9ITIJInZTZnOJ
   w==;
X-CSE-ConnectionGUID: WuO5FqLYSVCPYMg2e2xhYg==
X-CSE-MsgGUID: M9Naxi4ASOKPoYb9nK649w==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29818701"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29818701"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 06:00:50 -0700
X-CSE-ConnectionGUID: oc/8JwfZQEqZv5wRHSSvKw==
X-CSE-MsgGUID: wt4UMraRSN6m9jyrynsJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="74982764"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2024 06:00:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srzjC-000FRd-1z;
	Sat, 21 Sep 2024 13:00:46 +0000
Date: Sat, 21 Sep 2024 20:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: drivers/nvme/target/nvmet.o: warning: objtool:
 .text.nvmet_ctrl_state_show: unexpected end of section
Message-ID: <202409212053.fLdBbDBj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1868f9d0260e9afaf7c6436d14923ae12eaea465
commit: 649fd41420a816b11b07423ebf4dbd4ac1ac2905 nvmet: add debugfs support
date:   3 months ago
config: x86_64-randconfig-101-20240921 (https://download.01.org/0day-ci/archive/20240921/202409212053.fLdBbDBj-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409212053.fLdBbDBj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409212053.fLdBbDBj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/target/nvmet.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

