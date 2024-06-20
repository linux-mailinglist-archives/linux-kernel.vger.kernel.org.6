Return-Path: <linux-kernel+bounces-223544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB23D9114AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F7B28467A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944C84A4E;
	Thu, 20 Jun 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VooZn+z1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4A81AC8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919091; cv=none; b=Lh+mLVDs5a0ShWE8BUcf/he921/YMii5D/lLKkAsNnN94w8lwmP/W2uHE7MbElCTULlbVPZR/Hy4en7qQwvnegzgsnkWBgod+J0vFF3RSrQs2c2Yg9RVVWuD9ohh2cMj3bZ7tWzafBMqq26XV1sa26oPSE8ySR2naDdDvW6iXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919091; c=relaxed/simple;
	bh=Ig1nZEbbm+0Tk8Ku3cBwoD3KSG1Tk5O8GvgET8HFgog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3KYMjjecTrvY4xZC9RfIG/+t5B/lBfWICrPVcIQoQE8wb8cyvP69lLrvtRU93aN6ZjBniRHd9F9H7zgvxUl65EFtUI6E82DvZsUfOSVXLoLhXRa+ujRpswjQBFTFsTznXJXwad6ZGrob1OVv2iUEtjcatiE/bU8AaBAj9YMf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VooZn+z1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718919090; x=1750455090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ig1nZEbbm+0Tk8Ku3cBwoD3KSG1Tk5O8GvgET8HFgog=;
  b=VooZn+z1ICcDWDFn5jroIXwpRX/RXZv9oHIw4ARGoNim5OM4wL4xnulw
   ykXFeAKiQT2GDmSF3nzUjtj4nKSqCsUjTSRX2xOmh8NN5QvSsHDFDOUNB
   iT/gpGw3a6Eu3/TfTj0NkZX3lh5hdZ83TLz477lRrSwWQthedJn9kmqNb
   VV8jUj+uYB0IYrLW0I8qp3Uf4T7NjtJvrUHW/hmYzuHFeVlTgnGbySyRR
   YICYPXgqF2iOdwkfejf2VZc7U1jS/3Es1/qOjsM/aXk3q+HgBhTvI8Eqv
   lILg55uiZctWy2v5Wc8MGq5r0IkcbASArvyYulSl6RNbX/BLsbRFhe06Z
   w==;
X-CSE-ConnectionGUID: 6yrH6FEuSjSdsLL8gcICUw==
X-CSE-MsgGUID: YEGBc0tvTIaIA64095SVcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27339516"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="27339516"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 14:31:29 -0700
X-CSE-ConnectionGUID: zASYGrIbSBWPVxARBVvYcA==
X-CSE-MsgGUID: L4OitcScQWS5ZoUOoMC9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47335804"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2024 14:31:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKPNN-0007ya-2O;
	Thu, 20 Jun 2024 21:31:25 +0000
Date: Fri, 21 Jun 2024 05:31:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jianguo Wu <wujianguo@chinatelecom.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: ld: net/netfilter/core.c:830:undefined reference to
 `netfilter_lwtunnel_fini'
Message-ID: <202406210520.6HmrUaA2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50736169ecc8387247fe6a00932852ce7b057083
commit: a2225e0250c5fa397dcebf6ce65a9f05a114e0cf netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
date:   29 hours ago
config: x86_64-buildonly-randconfig-002-20240621 (https://download.01.org/0day-ci/archive/20240621/202406210520.6HmrUaA2-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210520.6HmrUaA2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210520.6HmrUaA2-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `netfilter_init':
   net/netfilter/core.c:819:(.init.text+0xd6428): undefined reference to `netfilter_lwtunnel_init'
>> ld: net/netfilter/core.c:830:(.init.text+0xd645d): undefined reference to `netfilter_lwtunnel_fini'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

