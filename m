Return-Path: <linux-kernel+bounces-415743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191629D3AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A50B22492
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418FE1A7264;
	Wed, 20 Nov 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pfc0QGwk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3661A0BDC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106269; cv=none; b=OXlsnJzoTVjaxOeK2Ql/Z3WnyBG3whHKX2Sb203TVHvktFLsDio7s+iA5yh2D5hlQe0jgSmYQ7jGmXF67BEbrMMLj2751YYLF/NX2auaDFsieX4i66wiaVYkXDsjTAnz5dHiU6Ld3usNizPyS7fTtY/SPqoIW1xCkJrWuva34tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106269; c=relaxed/simple;
	bh=Io+MrPujp338j6pT2tJE5+n1yJcPk7Gg195i2ZaHO+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SPAtIaDNa7mIuuA9InGTYYEaEWlKtYz5VCbBTiqo9PVFfo0lWXa2v4pw+dfpyUdAa175ORijLRZBmj+yFet7jyQ6PD/fPAJ6zXswo7/yhLtFNXyvKUsoAkB+K80jyAURXqUB+P6cxy1Rg/NsjOgLMxk1+nEA0i6pZBaF4R1KKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pfc0QGwk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732106267; x=1763642267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Io+MrPujp338j6pT2tJE5+n1yJcPk7Gg195i2ZaHO+A=;
  b=Pfc0QGwkYh42KWMz/IZViyBcAId9apdNO1P89FF2UXCR+nJSzx/8G1kq
   uqmnPAWT7RfOH6ItzOxe3uihPat71NsgVt45N2qSBQsrrYKI7HA+uRKpL
   6iBcVus0fwK1cHp5n2F+wXYUOA75c/DsVkJGpEOHI3IwyygGBlTKUKkt/
   5CmPkFy1C2f5nWOUiSr5WI/l4qYlz4Atgxr8pK3ZxVBX9BChq+oqlPXer
   oXc3VALLWiPvAxQJTLa0NbSRvyDbsgbF2XRqVoxTPF5PQ4HzESu3B3078
   8gdWo4vRx2F6f+TkQ+XO5tKDN8RJy+yAJohWDkKmlWLeOJfNO67a75MXp
   g==;
X-CSE-ConnectionGUID: hz4xg4u0Q5OJj22MgubkyQ==
X-CSE-MsgGUID: WiMlgrlXSkSqmjE23BeoTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32219473"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="32219473"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 04:37:47 -0800
X-CSE-ConnectionGUID: pUNNXDQlSyiIUXONTdeGmw==
X-CSE-MsgGUID: 2R93c1OtSVS2VmltzVPWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="94961794"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Nov 2024 04:37:45 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDjxn-0000rD-0K;
	Wed, 20 Nov 2024 12:37:43 +0000
Date: Wed, 20 Nov 2024 20:37:33 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/44x/gpio.c:63:28: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202411202043.oL4Dt1U0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf9aa14fc523d2763fc9a10672a709224e8fcaf4
commit: d5d1a1a55a7f227c0f41847b0598982f0a93170d powerpc/platforms: Move files from 4xx to 44x
date:   5 months ago
config: powerpc-randconfig-r112-20241119 (https://download.01.org/0day-ci/archive/20241120/202411202043.oL4Dt1U0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241120/202411202043.oL4Dt1U0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411202043.oL4Dt1U0-lkp@intel.com/

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

