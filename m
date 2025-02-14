Return-Path: <linux-kernel+bounces-514312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F27A35569
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FCF16DDE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C81537C8;
	Fri, 14 Feb 2025 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeRrqAfp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0241C85
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505014; cv=none; b=EmSmHcLYPQ1Fh80unfv0IMfbQtwZnwOQx3hxOHeTemLVQ5SgRQl4Ue3/XsC650mwBVamzOTmj3rbfIp9Hi3rLm/mEKjT2SBRqG8mG97rYEnx1mj/UcvcJ5Z3F4QM8KGIeWvAoE8E7MDAo8lnTSDVJoVUa7rXar8Pc3xLmNdWoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505014; c=relaxed/simple;
	bh=dFCnL6m0BQ9tuaNAYDzO7/lRXpyIcUiYlzZQFiMI8aU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HyXXA64Sa2ObSMX4BricEPvdAkZsF7+5rNvZbPENskyAeCkQR5TMW7kkklPgou8zJ0eZrouUyzQQdSQ4QO3oApLhNXsYQbvVx6VOacaWagz5fwufFrJ30Gt2K78c4osp/X2LXp3a2lfQSx6OYZmM5djTEoxg5j0bKzcqLVJCb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeRrqAfp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739505012; x=1771041012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dFCnL6m0BQ9tuaNAYDzO7/lRXpyIcUiYlzZQFiMI8aU=;
  b=LeRrqAfpzaB8wEd8stAZ6DG2TUo939LBQtWvP+oCRu5b+wAY2NoXkJCT
   ENw6S5GLjN6YIfB4RaT288ax8Bu+jE6s+oy6PmzS66lEJ35qTcvNfaDyI
   pD9aeq2m93iOWAP21y0u6foVteh/pzagyIWUdeALviIgyNORtGGVlxvEt
   Lq+NFnpzVQHB0Pg++/aCHToG3T6Ra2Zey8zl3ee9x6UwiS1BokgsEdsU9
   wnJkm7BzQHCB8NrLYuyzaoO8cBV9CIQkOFQyqzqviMiN09PSK4ls/FEAA
   hB6OxqAV8lbrPukjv1Qblljhmu1H58n2hVXBF9E7IFPdl/vuOYS/zPQmS
   g==;
X-CSE-ConnectionGUID: NREyRB4GRqaFJ5nR8sg3tw==
X-CSE-MsgGUID: DgzZtnU+Q+iNCRoxb778aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40356768"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40356768"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 19:50:11 -0800
X-CSE-ConnectionGUID: Xe90Jx/+TRa3xJBAAWo+mw==
X-CSE-MsgGUID: mOa+msBNQh+MBSBKVPbvwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113865563"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Feb 2025 19:50:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1timiN-00192H-1M;
	Fri, 14 Feb 2025 03:50:07 +0000
Date: Fri, 14 Feb 2025 11:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/freescale/ucc_geth.c:3411:24: sparse: sparse:
 symbol 'ugeth_mac_ops' was not declared. Should it be static?
Message-ID: <202502141128.9HfxcdIE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68763b29e0a6441f57f9ee652bbf8e7bc59183e5
commit: 53036aa8d03178a8d056a24a52a301ad290877d4 net: freescale: ucc_geth: phylink conversion
date:   2 months ago
config: powerpc-randconfig-r111-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141128.9HfxcdIE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250214/202502141128.9HfxcdIE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141128.9HfxcdIE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/freescale/ucc_geth.c:1737:50: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1762:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1762:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1762:33: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1774:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1774:42: sparse:     expected void const *objp
   drivers/net/ethernet/freescale/ucc_geth.c:1774:42: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1863:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1865:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:1910:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:1910:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1910:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:1913:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:1913:29: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:1913:29: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:2057:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void *_res @@
   drivers/net/ethernet/freescale/ucc_geth.c:2057:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2057:40: sparse:     got void *_res
   drivers/net/ethernet/freescale/ucc_geth.c:2065:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2065:47: sparse:     expected void *
   drivers/net/ethernet/freescale/ucc_geth.c:2065:47: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2085:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2085:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2085:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2118:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem * @@     got void *_res @@
   drivers/net/ethernet/freescale/ucc_geth.c:2118:40: sparse:     expected unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2118:40: sparse:     got void *_res
   drivers/net/ethernet/freescale/ucc_geth.c:2145:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2145:37: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2145:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2207:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2207:32: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2207:32: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2213:57: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2213:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2213:57: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2225:35: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2225:35: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2225:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2273:37: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *upsmr_register @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2273:37: sparse:     expected unsigned int [noderef] [usertype] __iomem *upsmr_register
   drivers/net/ethernet/freescale/ucc_geth.c:2273:37: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2351:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2351:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2351:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2354:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing @@
   drivers/net/ethernet/freescale/ucc_geth.c:2354:45: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2354:45: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] endOfRing
   drivers/net/ethernet/freescale/ucc_geth.c:2574:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2574:64: sparse:     expected void const volatile *address
   drivers/net/ethernet/freescale/ucc_geth.c:2574:64: sparse:     got unsigned char [noderef] [usertype] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2841:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2841:21: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2841:21: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:2880:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] [usertype] __iomem *p_utodr @@
   drivers/net/ethernet/freescale/ucc_geth.c:2880:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2880:22: sparse:     got restricted __be16 [noderef] [usertype] __iomem *p_utodr
   drivers/net/ethernet/freescale/ucc_geth.c:2907:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/net/ethernet/freescale/ucc_geth.c:2907:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:2907:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3035:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3056:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3056:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3056:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3057:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3057:34: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3057:34: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3059:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_ucce @@
   drivers/net/ethernet/freescale/ucc_geth.c:3059:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3059:22: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_ucce
   drivers/net/ethernet/freescale/ucc_geth.c:3065:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3065:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3065:38: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3299:17: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/ucc_geth.c:3325:25: sparse:     got restricted __be32 [noderef] [usertype] __iomem *p_uccm
>> drivers/net/ethernet/freescale/ucc_geth.c:3411:24: sparse: sparse: symbol 'ugeth_mac_ops' was not declared. Should it be static?
   drivers/net/ethernet/freescale/ucc_geth.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false

vim +/ugeth_mac_ops +3411 drivers/net/ethernet/freescale/ucc_geth.c

  3410	
> 3411	struct phylink_mac_ops ugeth_mac_ops = {
  3412		.mac_link_up = ugeth_mac_link_up,
  3413		.mac_link_down = ugeth_mac_link_down,
  3414		.mac_config = ugeth_mac_config,
  3415	};
  3416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

