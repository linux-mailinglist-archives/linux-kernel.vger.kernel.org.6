Return-Path: <linux-kernel+bounces-270554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DC944159
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B897B2577B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AB132116;
	Thu,  1 Aug 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoKRUgW8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8813210B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480281; cv=none; b=pgpmIOrWUo0CH1P1Xbc4vxyfXZmYcNTZlLPRHgMG8cPgilE7CrevtLvUmLPJrIzqfziFJykZNG6rpfFfcpRcyfjPw8c46WZN1FP6GATzdOp5Upz0B7e4hs8cjlitGiEHOPSz9SglAJtdSY4bZok4jpnQq/XsFS6wNnBpSWXcgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480281; c=relaxed/simple;
	bh=fWu49uRUApcALMAyBuzbfvACLbyUiqdCk41ptrSu7B8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I0q0SWvceSG954/um/droaHFe8a5WMebvixQGNH95sGpbBoFFy6VkPU5XS2gYsEPjBe5FhMdLqBkipG3JczEPJNepKXJUfeuSG1W9rb8mzqKuarcm33ieeVyw2bd1ATW/aIguHvVjmYy3Apa2gywraWbZH+Knb5U4c9H2URGad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoKRUgW8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722480279; x=1754016279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fWu49uRUApcALMAyBuzbfvACLbyUiqdCk41ptrSu7B8=;
  b=ZoKRUgW8tmmFUsov36SgfIOmJFhpk5g1oDrB9dOp+bgqopyVfdc/0/av
   5b2ySuvBLecee+ESIgkvgMVrinskvoUU+TR9f1AXTVVVkN+KP6q5qt/wj
   p/5HESbKshC7ebOS3dhvFkhIJgT3g+E/9gBLxBPMWlwe1UPXCNoN5Cc8K
   i1hY5KUcPYFgKugfIDUKrdEiAaQ4qaEXnUI6CJXrtpGk87SEg6avmqKyS
   8wntOHf7kLi9biSqyC1q8gPGYWSYqCs8bEyCRCYSJE2gRWuKn9IwcsNKf
   MwjbtutxpbSh/WVlcROTUqJbv20zBy2eOYJ03L183vvpqsT3wICac2YDD
   A==;
X-CSE-ConnectionGUID: jr9LjFHsTEOfhvSLQUGArg==
X-CSE-MsgGUID: e6rnfnFwROarPza5Wxd/AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20585113"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20585113"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 19:44:15 -0700
X-CSE-ConnectionGUID: f2POSTshQ8eeTBvWJ8v2Gg==
X-CSE-MsgGUID: Eg06LyhzQVyPpEDxIpVN7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="54791746"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 Jul 2024 19:44:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZLnW-000v88-2W;
	Thu, 01 Aug 2024 02:44:10 +0000
Date: Thu, 1 Aug 2024 10:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/44x/gpio.c:63:28: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202408011005.tfDKHMKk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21b136cc63d2a9ddd60d4699552b69c214b32964
commit: d5d1a1a55a7f227c0f41847b0598982f0a93170d powerpc/platforms: Move files from 4xx to 44x
date:   5 weeks ago
config: powerpc-randconfig-r123-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011005.tfDKHMKk-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
reproduce: (https://download.01.org/0day-ci/archive/20240801/202408011005.tfDKHMKk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408011005.tfDKHMKk-lkp@intel.com/

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
--
>> arch/powerpc/platforms/44x/pci.c:116:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:116:54: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:117:74: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *in_addr @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     expected restricted __be32 const [usertype] *in_addr
   arch/powerpc/platforms/44x/pci.c:117:74: sparse:     got unsigned int const [usertype] *
   arch/powerpc/platforms/44x/pci.c:118:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/44x/pci.c:118:52: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1528:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char const volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     expected unsigned char const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1528:30: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1531:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1531:33: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1534:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1534:33: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1585:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     expected unsigned char volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1585:24: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1588:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1588:27: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/pci.c:1591:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/44x/pci.c:1591:27: sparse:     got unsigned int [usertype] *
--
>> arch/powerpc/platforms/44x/uic.c:40:12: sparse: sparse: symbol 'primary_uic' was not declared. Should it be static?

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

