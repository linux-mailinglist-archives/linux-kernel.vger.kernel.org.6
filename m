Return-Path: <linux-kernel+bounces-399351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D869BFDCF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB8BB22B32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5E194123;
	Thu,  7 Nov 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV4ogm92"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC3192B8C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958420; cv=none; b=PPeWurJvCN5wgEKJZykEdOmq+Ev2jI+QMqj0qnqEOoOHmza0coPQMaWagLoD+mn3ZtgBLrFmA8/HlFBqOB2TSYyu4HZenSPOgTVy5BEBWzJ3mjP8+VSdtZGW6REtJfy6oB0lVrgm9+riB1ZSq+53FjrkvJZbO6qvfTXstPHjfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958420; c=relaxed/simple;
	bh=JPxeCjdGq8a0zMzUJVf7kWzJDmpJp0Jzp57/Ycn+1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qTZQJGGZojfB+0+PFoqALw1ALW3aiVpeRWdMYD+i23IuqnzKKEp8w57eZ6ABKYm+HUbhtjbzVwlOKGonWHIuc4s5WuGe9/FPFBbsgunLhD11h1DHCstuWSQSTVHBzLshAEXbTLQnzeDBQoyNwZ85x0g6W5cXX3k4sg8KM5tBgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV4ogm92; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730958419; x=1762494419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JPxeCjdGq8a0zMzUJVf7kWzJDmpJp0Jzp57/Ycn+1Tk=;
  b=kV4ogm92GN3CGRjj2LxsQfDh5uYR4MaZ5KutyA5dh37qWLZe2E6hUis/
   TLsnFux1usKqJneGhtMAl8cYJrfaEdDIupIlwLJLXZ9Zx/FFy4h19YpGO
   hR+Zd+9oVXRYjr32CC3WucB1nhcm0CiiJl0mnicNCSZqhIRoqbPWs4wSc
   GZKhZVWOLCdjorh2Dv4eJ9tCi5Q5eJlar+ev4Mdieqzxhh1uY62dCrfd7
   BPmNqRsuQqkp0lF7ZdbJZygrleUVX+ALu9zy4ezYOgrLu5JX1OwjHp4Bt
   IfQhu2m0Ao1e/zVkDY8qLm6Ml0Bvf2t+Z6QUjmXUxyHRyfcAuB3cCvldw
   w==;
X-CSE-ConnectionGUID: 9ZOtamcuTdyLfkhXkR7ZZA==
X-CSE-MsgGUID: vnOPJEk8RmG03AmpZpMkug==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30905434"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="30905434"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 21:46:58 -0800
X-CSE-ConnectionGUID: 5AbG2F7vRTuRMDRo0r1I4Q==
X-CSE-MsgGUID: TDwDifHmRU6KGHLE2pl7PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="88893668"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2024 21:46:56 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8vM6-000prY-2I;
	Thu, 07 Nov 2024 05:46:54 +0000
Date: Thu, 7 Nov 2024 13:45:59 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/device.h:381:23: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <202411071306.NRIW9j4f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2
commit: f6bb3e9d98c2e8d70587d5ddaf9426ef30d7865c net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
date:   4 months ago
config: s390-randconfig-r121-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071306.NRIW9j4f-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241107/202411071306.NRIW9j4f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411071306.NRIW9j4f-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/pcs/pcs-xpcs-plat.c: note: in included file:
>> include/linux/device.h:381:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/device.h:381:23: sparse:     expected void [noderef] __iomem *
   include/linux/device.h:381:23: sparse:     got void *

vim +381 include/linux/device.h

da7c07b1083809 Mark Brown 2023-07-18  376  
da7c07b1083809 Mark Brown 2023-07-18  377  static inline
da7c07b1083809 Mark Brown 2023-07-18  378  void __iomem *devm_ioremap_resource(struct device *dev,
da7c07b1083809 Mark Brown 2023-07-18  379  				    const struct resource *res)
da7c07b1083809 Mark Brown 2023-07-18  380  {
da7c07b1083809 Mark Brown 2023-07-18 @381  	return ERR_PTR(-EINVAL);
da7c07b1083809 Mark Brown 2023-07-18  382  }
da7c07b1083809 Mark Brown 2023-07-18  383  

:::::: The code at line 381 was first introduced by commit
:::::: da7c07b1083809888c82522e74370f962fb7685e driver core: Provide stubs for !IOMEM builds

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

