Return-Path: <linux-kernel+bounces-329231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82C978EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98ACF1C22C34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FC13A899;
	Sat, 14 Sep 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQa6vH0I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2A38B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299652; cv=none; b=ZT5uzDYyvlTbIaRDRrqE+L3ZAO/4l1Ducmp2fV//XkBIrqYPiAuCj4oDsjPLCaOwyqqvGAgiWR2siXTyULsYzVthUmQIMtj5gkYhuGUfLKj7jVQz024cijtoaKkB8jcoe6GGCTNShkF9j0SELF7VeSSpLCzMJFInergvDuyH2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299652; c=relaxed/simple;
	bh=6TVOCPKXL+yI9IFKhOfOruHrpAAgXmmkSzo9JZQpyUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VD/W9e9xLe0XeiBD5zcs1SvXLxodq/T90v5E24IeRekJqk1e07dUzbazHgtMNwK4DLT252xeF45rns5aANRW839szkV8veOvQ2TV/ETdmnbQFdSn2FZ9jiQZhBdWn1KVnm8UO8s27oaGFret3Jq5EmyNyA3mzjFa7VVkkQKKoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQa6vH0I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726299651; x=1757835651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6TVOCPKXL+yI9IFKhOfOruHrpAAgXmmkSzo9JZQpyUY=;
  b=XQa6vH0IZSrufkAjWh9MdMarxXU54ehBk4ft4i69uqFdgP/+L+IZkWXk
   42vptfsTcOw+Pt3qjVaCOOpu4ykBphQx8f/DXORp20n532Gh/jHGrQdL9
   aFbFF6gpb1LSm+92+LUMC6JL/3KwIfKdQNIHuoxYXA708C8REn8/iaMPW
   aQ7khHMC6MPW1z/q9CNHtugDnHhEjOH0rQ1IKZC6WVYVAd/IvoJGj61/0
   0/Lh4Id6AEj3lR3acMy/0QcTjSaI3JsQBsxr0i4ML+RoE1ZZxIpvUk0zT
   9LpUsVpVBhe9Mv/8iJizP9LYyyc7qk7aP7k91Bv0oa45FKJArU0cuvLFo
   Q==;
X-CSE-ConnectionGUID: 2bZFYPASTiGhtOhppxaZ0w==
X-CSE-MsgGUID: xpg2Y2RZQEmLoacMEkbrxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25300235"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="25300235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 00:40:50 -0700
X-CSE-ConnectionGUID: qjNTC4IMT0acK6d6Wzh93A==
X-CSE-MsgGUID: rcYbopStRSujERRtNNKj/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="68038030"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Sep 2024 00:40:48 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spNOg-0007VS-1Q;
	Sat, 14 Sep 2024 07:40:46 +0000
Date: Sat, 14 Sep 2024 15:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: drivers/spi/spi-amd.o: warning: objtool: .text.amd_set_spi_freq:
 unexpected end of section
Message-ID: <202409141539.2uAlMu2x-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b7718454f937f50f44f98c1222f5135eaef29132
commit: 6defadbe6cbc3a87dc39c119a6748d19bfba0544 spi: spi_amd: Add support for SPI MEM framework
date:   6 months ago
config: x86_64-randconfig-r052-20240913 (https://download.01.org/0day-ci/archive/20240914/202409141539.2uAlMu2x-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141539.2uAlMu2x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141539.2uAlMu2x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-amd.o: warning: objtool: .text.amd_set_spi_freq: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

