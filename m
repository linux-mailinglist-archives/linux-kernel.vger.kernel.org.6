Return-Path: <linux-kernel+bounces-527580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57689A40CD5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C7A189CDF4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D71C84BD;
	Sun, 23 Feb 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmaKKQTD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39534545
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 05:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740288471; cv=none; b=rjmakO6K9c+D9coUNiqI2I4DvnzeXFE9EOMhehqd2XPcrhKmk78okPp+p+8BoefxRsPI5lApLbZx20NCjgnJ3bt2OY1UTQ0uOnUJDShEGISLk0U/5ayVhoi5FqQWw/LfKH+mm0IjWuKlZNoDOG8FFkw3sSrgnno32z0AN8MessM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740288471; c=relaxed/simple;
	bh=ZoFMidOYBshnEsnzIKH5pW7glP8uk+guezRItblF2Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsdla1R/0bhFHWY6EBFKU6ixH32tgtJdmZ4Vc5NN+2wFd7GkqG4kpXxmHZtYQPc/s6G1m8DKZeVP5tniDQfDWf7TCsxaPuKSfzRQ1K0Bov8m1PxQbY6pghxYzoKyPkbakLp0aoDylw4gbo2UlwvcHILaRLPdoGI9AwTbUUWyPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmaKKQTD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740288470; x=1771824470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZoFMidOYBshnEsnzIKH5pW7glP8uk+guezRItblF2Ys=;
  b=EmaKKQTDP7TVqARWgE9p0Z+O5lSUSfmco2NMQ/lE+X3WJCntZNM55aY+
   RxSqkJBEnQsUfh60zmCfAIrSH/FYoVY8an2makRcyo2mcW9DoLTM7cSkQ
   I5uNug9tZl4COMRq9c+EAFnu6NOExzqvJBnSBgWoip8HJW97L20WbVxdc
   SOee5/cD1FDHGMO09wAVU+H18l1kPxNcyf7ofWTx1JVF7RtaiUp+K8Odo
   4jG7LVyIlsER8heAZDv9evNvr182s3Jz2BBzP2WVhXW4lPJMrLXsOXmve
   erLJU4HEpsDi++OrT7jlXKWDwD4kfa1EZ3KSFdCdKPOPJB+L/Fsftg4rC
   w==;
X-CSE-ConnectionGUID: F6rcsylpRzGLN/Vev/j3Cg==
X-CSE-MsgGUID: k/2bozEzST2vXdm9u744Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52494653"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52494653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 21:27:49 -0800
X-CSE-ConnectionGUID: MDi6dxZtSu61rtEuamNdDw==
X-CSE-MsgGUID: 5Ce2PjiPSwG7ocpbQD3+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="116261630"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Feb 2025 21:27:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm4Wl-00079L-0b;
	Sun, 23 Feb 2025 05:27:43 +0000
Date: Sun, 23 Feb 2025 13:26:58 +0800
From: kernel test robot <lkp@intel.com>
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
	tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	liangjian010@huawei.com, chenjianmin@huawei.com,
	lidongming5@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	shenjian15@huawei.com, shaojijie@huawei.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <202502231304.BCzV4Y8D-lkp@intel.com>
References: <20250222025102.1519798-8-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-8-shiyongbang@huawei.com>

Hi Yongbang,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc3 next-20250221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-Restructuring-the-header-dp_reg-h/20250222-110052
base:   linus/master
patch link:    https://lore.kernel.org/r/20250222025102.1519798-8-shiyongbang%40huawei.com
patch subject: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
config: arm64-randconfig-004-20250223 (https://download.01.org/0day-ci/archive/20250223/202502231304.BCzV4Y8D-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 204dcafec0ecf0db81d420d2de57b02ada6b09ec)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231304.BCzV4Y8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_client_init" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] undefined!
>> ERROR: modpost: "drm_client_register" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] undefined!
>> ERROR: modpost: "drm_client_release" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

