Return-Path: <linux-kernel+bounces-448560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF879F41C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6122E164366
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B44145B25;
	Tue, 17 Dec 2024 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azAqCnl+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A41FAA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411100; cv=none; b=NXBOFmVbjdN28twDMoY3oeSe7XyPv6j67sGK/pXT03RPf5g+paZ81Vm18nFnuCypZiHuJVHko7kDIp8rj4n0ZCCPQ5kTHJFV1kF3fKaYurZksGyE5onFP/Q2rAM6DijZxTTQVCeNHyZFDQKeQdkKpOfuxZ7zMeLLy7TB0rWku0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411100; c=relaxed/simple;
	bh=Su8CLPopiskPhrvaiMiBzONLRAfc4TQBbdC4vzs3mZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S5CKEPI1rQj7aSn6NHFxVtc6A/FCPkLe4i0mXhaynpCrVBpR1M0CRa3FxLTJxU3xdw7eKI91JhJJxLmDhf3pPnGRr62qW9FPbvVd58VJpNdz12St/n+37Xv938skrYe3/F6TNmy6qgNmG+POTTguldKr6Rc5EfUEKYt7LtJSwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azAqCnl+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734411097; x=1765947097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Su8CLPopiskPhrvaiMiBzONLRAfc4TQBbdC4vzs3mZU=;
  b=azAqCnl+qJw8KoPu7QdCzLXKR2udmIZpcWHnskrv875dl4FbYP9hhzJE
   mWBzhBGtzOX0xGtMkEHDzaH30iQABU7I4ZfOF0x+kIrK+JGd69pgkL8XW
   v7zcMOgnY5c9pdUxZR5kQyqXB+GKqp5MxyOCiFfx5bwATK68DHTU5IK15
   hfSSU/TlrtE+mpRgsNzBUDuTLDemTXySqp8kzz+P239KsN/e9JB0OOW0W
   y+0tlCpkoAf/h/WpMFSHxrD9vrweiQe7z9kLoRGnRSNOVUdxmhAtFyA7b
   CwjKgoDIM4/uIuQmFdcC9tE/ZsabPHVnZt8bV/FoUzynaYK85HHGyIHs+
   A==;
X-CSE-ConnectionGUID: 8z/5c8t0SFiAVbVyrilCyA==
X-CSE-MsgGUID: cd53JoZzTJ+AbEFao/jEeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52343668"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="52343668"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 20:51:37 -0800
X-CSE-ConnectionGUID: D8bwC8YPTy2VBYzZI4Lw5A==
X-CSE-MsgGUID: VqRaax2MT6uU9ctHxROeqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="128232005"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Dec 2024 20:51:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNPYT-000Eii-1P;
	Tue, 17 Dec 2024 04:51:33 +0000
Date: Tue, 17 Dec 2024 12:50:32 +0800
From: kernel test robot <lkp@intel.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: sound/soc/renesas/dma-sh7760.c:62:3: sparse: sparse: symbol
 'cam_pcm_data' was not declared. Should it be static?
Message-ID: <202412171210.7a4vH3Ew-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lad,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
commit: c087a94bea49acf34d651f7308506fe462a937b3 ASoC: Rename "sh" to "renesas"
date:   7 weeks ago
config: sh-randconfig-r113-20241217 (https://download.01.org/0day-ci/archive/20241217/202412171210.7a4vH3Ew-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241217/202412171210.7a4vH3Ew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412171210.7a4vH3Ew-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/renesas/dma-sh7760.c:62:3: sparse: sparse: symbol 'cam_pcm_data' was not declared. Should it be static?

vim +/cam_pcm_data +62 sound/soc/renesas/dma-sh7760.c

aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  48  
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  49  
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  50  struct camelot_pcm {
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  51  	unsigned long mmio;  /* DMABRG audio channel control reg MMIO */
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  52  	unsigned int txid;    /* ID of first DMABRG IRQ for this unit */
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  53  
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  54  	struct snd_pcm_substream *tx_ss;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  55  	unsigned long tx_period_size;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  56  	unsigned int  tx_period;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  57  
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  58  	struct snd_pcm_substream *rx_ss;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  59  	unsigned long rx_period_size;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  60  	unsigned int  rx_period;
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  61  
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14 @62  } cam_pcm_data[2] = {
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  63  	{
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  64  		.mmio	=	0xFE3C0040,
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  65  		.txid	=	DMABRGIRQ_A0TXF,
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  66  	},
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  67  	{
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  68  		.mmio	=	0xFE3C0060,
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  69  		.txid	=	DMABRGIRQ_A1TXF,
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  70  	},
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  71  };
aef3b06ac69783 sound/soc/sh/dma-sh7760.c Manuel Lauss 2007-05-14  72  

:::::: The code at line 62 was first introduced by commit
:::::: aef3b06ac69783d6a6d1e4357c62bab46dd16141 [ALSA] SH7760 ASoC support

:::::: TO: Manuel Lauss <mano@roarinelk.homelinux.net>
:::::: CC: Jaroslav Kysela <perex@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

