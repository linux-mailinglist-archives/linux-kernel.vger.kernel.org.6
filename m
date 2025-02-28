Return-Path: <linux-kernel+bounces-539450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685FBA4A468
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777CF16B4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1861B87FB;
	Fri, 28 Feb 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7sirNY1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CA23F38F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775776; cv=none; b=XmvOZ12ilMnHXCehkbhGINCXW+0TPadtIwzlmk5O4kziFvw9iPWxGyw9IqhcPyzXyWGZLWWBlzNeuDTJynzMz8Ouiv6U2J8EasmD4Y9fgfJZcfsL/RFxuaftJmRXtprpP8boEypJkRtr3NoOUAprx6+z3jD7n5ZSSCxZ7j6lvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775776; c=relaxed/simple;
	bh=zkXVGkVrpsDAcei3ubhvZoUQlpvIbOP/dtO/0SVTUmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZxOOMU8K4JSrda+XHMLxPCXMQS8+uwxafP9JFqbYjkpyUMTFNeuE6X10Ok3og+xlddFtN1VA6uhKD/Fc4VfbTcK5rgC5hVfXFhE4LCQvnfy0qJE2Y6ths03mwu2lo3QP77GRyTOVQsEhl2vr7dUH+LV9BVSesh3uAlDX1lHZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7sirNY1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740775774; x=1772311774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zkXVGkVrpsDAcei3ubhvZoUQlpvIbOP/dtO/0SVTUmc=;
  b=S7sirNY1pycY8VofXQDZk2D3pWj8gtlODTNdV/+PaQMrYIeTX3wMkdGT
   1JfohPlJxdRuAWML5IdYjoKwSmdQPqxEIJjtre13doMDTTnWusQGyj+zj
   CAkr/grVhtFYCvpgteeqiStKOrhmIKT3bSXXWT4JTXzQYTCBgNEFSVTz0
   NNH3MUn7hDgO1rFJK/TB4DeXnUbnraAl0nxZ3mHlA6f7JNNuOx59jfCiw
   tsiBzkRb7na99x/c4jG+8RDoGMlMO76eQi0MpuxeJ3sx7512H1TBQD0aw
   9xk90tSsr2KerjcStGQiTnWfrthv0a1gz2BcrtIdl1KffUhlfBRgRJ7lJ
   w==;
X-CSE-ConnectionGUID: RfVcTpS0RRamdAg6XcyZuA==
X-CSE-MsgGUID: +Gw03dTzRIG6cvFWR8Q3SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45368343"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45368343"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:49:34 -0800
X-CSE-ConnectionGUID: hhVUkCXKT7O6pfQg0y9N0Q==
X-CSE-MsgGUID: DyRhmPc8SVOanC/bEGxlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122396174"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 12:49:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to7IX-000FV6-24;
	Fri, 28 Feb 2025 20:49:29 +0000
Date: Sat, 1 Mar 2025 04:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>
Subject: kismet: WARNING: unmet direct dependencies detected for G2_DMA when
 selected by SND_AICA
Message-ID: <202503010458.iZun3bkL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   276f98efb64a2c31c099465ace78d3054c662a0f
commit: f477a538c14d07f8c45e554c8c5208d588514e98 sh: dma: fix kconfig dependency for G2_DMA
date:   4 years, 2 months ago
config: sh-kismet-CONFIG_G2_DMA-CONFIG_SND_AICA-0-0 (https://download.01.org/0day-ci/archive/20250301/202503010458.iZun3bkL-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250301/202503010458.iZun3bkL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010458.iZun3bkL-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for G2_DMA when selected by SND_AICA
   WARNING: unmet direct dependencies detected for G2_DMA
     Depends on [n]: SH_DREAMCAST [=y] && SH_DMA_API [=n]
     Selected by [y]:
     - SND_AICA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SUPERH [=y] && SH_DREAMCAST [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

