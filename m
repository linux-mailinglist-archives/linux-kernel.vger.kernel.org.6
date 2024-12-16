Return-Path: <linux-kernel+bounces-447013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5A9F2C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBED18838F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B81FF7DE;
	Mon, 16 Dec 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv2H8c4i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078931CB51B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338203; cv=none; b=NYVMlSZaObD3eTqlzsTpkv4z2e3MAyTN0TOH5kS/hNhdjfDZVFm6qe5qGCJmDsGyxtqQ0U07Ng5QHMeu3nlS5rPBGc7tEB1SkJF+/8kXe9fbJqEBhuseYCeF99ND0FeT4TpX8B06fGYNSpnpzbIl2UkOaGtcG5AaIgXa9TRAFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338203; c=relaxed/simple;
	bh=xcBMAfPwVj1ts+vRJPOTbVGYP1REcVAC0hbJ/1Rtr7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o6oVjWEB5Y+IEg9gxMzqBbTPYGsia84cDMKdoqvxfDa9BbC8N57SM50LInRiJ0b5LqofIUFFiR6spGZiw9bR9JsjIvN9+77sRPnaBkNZb6GbEU+HWtIku2VwEl5Oqeo54fSvkyIy/qiibHu0+x7b5FhqYpOTmGZ5bE2TaxHWans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv2H8c4i; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734338201; x=1765874201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xcBMAfPwVj1ts+vRJPOTbVGYP1REcVAC0hbJ/1Rtr7w=;
  b=Uv2H8c4iClbZF8/H8MYri2c8on2n2a46aTbgjSZL62BGVSH0qtCADi7M
   CbGNDAEbG1SFLcBdgJ6odJz+iMkZRzt1Ibz9YDEoeS6tAp5sdreRoxYz6
   5K5T4kmk4UOt/1XKOrW5a8Yal1kPHUsfHuLlyjnoFn4TCT54ik3STE/qH
   JUQglHhNwB1yARGzfjTbsxdvJxUnpOq5s7j1SOTHdDteWUxgXCi4J3MGo
   t09XMNfXv4g72D3+j6bE8vMuoh1HDRxLsOq3OiWUp4tgw8xSb8x/taFL0
   vZRwVMfpkn/7HFlyl4j3eK2oXZdlGqgeEBYW6lJ5pCSk/GXOgjrFlktpR
   w==;
X-CSE-ConnectionGUID: +MccNnwzQMezY2fh0A3KDw==
X-CSE-MsgGUID: l+4k/jqNSoyLDz1lPt/lkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46109022"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46109022"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:36:41 -0800
X-CSE-ConnectionGUID: qSljELkSR1mRGnjBf8kqeQ==
X-CSE-MsgGUID: qdC+17W4T4aJOl9K3TAOwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="102159125"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Dec 2024 00:36:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tN6ai-000E6u-2E;
	Mon, 16 Dec 2024 08:36:36 +0000
Date: Mon, 16 Dec 2024 16:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Likun Gao <Likun.Gao@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>
Subject: drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1638:5-8:
 Unneeded variable: "ret". Return "0" on line 1642
Message-ID: <202412161655.2LXuAggt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
commit: 3e55845c3983d92e28517a545e403b5eb9acf95b drm/amd/swsmu: add smu v14_0_2 support
date:   8 months ago
config: i386-randconfig-052-20241214 (https://download.01.org/0day-ci/archive/20241216/202412161655.2LXuAggt-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412161655.2LXuAggt-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1638:5-8: Unneeded variable: "ret". Return "0" on line 1642
   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1647:5-8: Unneeded variable: "ret". Return "0" on line 1651
   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1711:5-8: Unneeded variable: "ret". Return "0" on line 1715

vim +1638 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c

  1635	
  1636	static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
  1637	{
> 1638		int ret = 0;
  1639	
  1640		// TODO
  1641	
> 1642		return ret;
  1643	}
  1644	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

