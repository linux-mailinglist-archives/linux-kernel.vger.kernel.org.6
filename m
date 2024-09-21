Return-Path: <linux-kernel+bounces-334958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BEF97DEE4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12D6B212E7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC513D890;
	Sat, 21 Sep 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp89Kwyz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3213C9B8
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952052; cv=none; b=XX4OhETPRXdrv242SH7GZ7GXp7jVnF5mDCVZYRqZWId+eS9x7d/pTHPyx7gJbt/9ZjM4gyQ4XZLWAyjwF8NrhQeg/xo3/ZIWU49S0Z6jSIwsOlL5J3QGTwFyBq1RTP3KodaCms0TzJsatyWSBqwNOjHTMXAlEXxcQ7GZLg6vSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952052; c=relaxed/simple;
	bh=91TZxQaXpMuO6PDywcBlNUQOjeg3LHvetIEWnH3MT18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=goOVXZlWDsn12+4G1MbNHY2dOdUFqs3UQ9MA29I3at/c1AlZAUGokicsLOZOoC251PM6WXTvl3dDMFuARICCzE4+cA28XpBfUzQNqrNo4RE8FcABNWtIcl94jUDntYk/uNheZckLm40r1G+XRke1SIjjF4TN+6Nd84lmkUShgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp89Kwyz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726952049; x=1758488049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=91TZxQaXpMuO6PDywcBlNUQOjeg3LHvetIEWnH3MT18=;
  b=Jp89KwyzFG/O3JHXyA2/dxCdZohxYrXAgeEWTqslcXOY12B2qd46/wsX
   a9quYG9arC5An9BJr2z6TQzFghUjzCX2PpXRO5REEWDKnnsQeto+3Bo+D
   MWLNpIixvlEA5m2MLr3T72vb7iHV4UAFdO27jUs5PgElMW/D0+XeG6W3B
   nkfNw2LPCbkEDicxM2LUF65udEd7wl9/3/w27XzhKnhAE+BZTfC9kWNng
   k8ryphkiLTYENjnEc/xT/+OurFrUxEQ2ZhuR8FTbtij6B2uv+dUIk8M53
   7KblIYQNYCPLjfsmZO+qSM1HGJwQBMsy2/q8iW2QjWCzhOWXIT+PyrhLf
   g==;
X-CSE-ConnectionGUID: 1qm4F9Z/RuKURMearu9lSg==
X-CSE-MsgGUID: don9g7LfQAaXVHLOKifNtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36598612"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="36598612"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 13:54:08 -0700
X-CSE-ConnectionGUID: pYKYCj5UQdqK2WKarjlWzg==
X-CSE-MsgGUID: nRrvXQpqTde8Q6/0MdxiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="75602565"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Sep 2024 13:54:06 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss77E-000Fnm-18;
	Sat, 21 Sep 2024 20:54:04 +0000
Date: Sun, 22 Sep 2024 04:53:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/44x/gpio.c:63:28: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202409220454.xPOzQrig-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88264981f2082248e892a706b2c5004650faac54
commit: d5d1a1a55a7f227c0f41847b0598982f0a93170d powerpc/platforms: Move files from 4xx to 44x
date:   3 months ago
config: powerpc-randconfig-r133-20240921 (https://download.01.org/0day-ci/archive/20240922/202409220454.xPOzQrig-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240922/202409220454.xPOzQrig-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409220454.xPOzQrig-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/44x/gpio.c:63:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:63:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:63:28: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/44x/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:103:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:103:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *

vim +63 arch/powerpc/platforms/44x/gpio.c

878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   51  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   52  /*
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   53   * GPIO LIB API implementation for GPIOs
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   54   *
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   55   * There are a maximum of 32 gpios in each gpio controller.
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   56   */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   57  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   58  static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   59  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   60  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   61  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   62  
eecdf59ad2fb90 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-21  @63  	return !!(in_be32(&regs->ir) & GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   64  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   65  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   66  static inline void
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   67  __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   68  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   69  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   70  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   71  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   72  	if (val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   73  		setbits32(&regs->or, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   74  	else
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   75  		clrbits32(&regs->or, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   76  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   77  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   78  static void
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   79  ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   80  {
0d36fe65f58391 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-08   81  	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   82  	unsigned long flags;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   83  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   84  	spin_lock_irqsave(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   85  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   86  	__ppc4xx_gpio_set(gc, gpio, val);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   87  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   88  	spin_unlock_irqrestore(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   89  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   90  	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   91  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   92  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   93  static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   94  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   95  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
0d36fe65f58391 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-08   96  	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   97  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   98  	unsigned long flags;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   99  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  100  	spin_lock_irqsave(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  101  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  102  	/* Disable open-drain function */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13 @103  	clrbits32(&regs->odr, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  104  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  105  	/* Float the pin */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  106  	clrbits32(&regs->tcr, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  107  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  108  	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  109  	if (gpio < 16) {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  110  		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  111  		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  112  	} else {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  113  		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  114  		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  115  	}
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  116  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  117  	spin_unlock_irqrestore(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  118  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  119  	return 0;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  120  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  121  

:::::: The code at line 63 was first introduced by commit
:::::: eecdf59ad2fb90d8238a42e2ec41f165964349bb powerpc: ppc4cc/gpio: Be sure to clamp return value

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

