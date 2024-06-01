Return-Path: <linux-kernel+bounces-197697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABF8D6E2B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB431F237E0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDE10A3D;
	Sat,  1 Jun 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elT5zf7I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E822594
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717221040; cv=none; b=tTZqsaxUYjEn67gPhCipXKKtWiQ2QnxbSqpXY85OcwRkyijzqjdg1yCQvdxP6kh52DX0wGCuZtNmoZ1KezrVshDYBApZuHjg5xf3L/LEc/N0LOJZHVFdIuD8U5nbyiZwkAb5hsvh8qbUSErr3bDEhw4TOo81DLsrm3Yhj8dDQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717221040; c=relaxed/simple;
	bh=sWbc3uG2lmnElC1fzYYw8hroZJ/7dZbzi/7Nr/hh7w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0PVbbgse1fja9SgvvK+rxL7UKsUYrhkCzoliGCpE2Xdr8kXLDTL7PlZqGE33Qa7aVtkbMpj6jgoF3EsRa9V8kG9VFpmDaoXerGG+r2fLsHX5z2Rl2wHajLOgBwB05/8u7ccReLcq1knUa7S6mT/aVU8fQNy+LhZtga0Y4ptNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elT5zf7I; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717221037; x=1748757037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWbc3uG2lmnElC1fzYYw8hroZJ/7dZbzi/7Nr/hh7w8=;
  b=elT5zf7Ig6S8dVDh5orunkc2IQOyG0mT+6tzNmgoZVf1isg5KmA68EHk
   oSo3V/udoF0H1V3uGMPPwY45SkqkEKPaSmykHkggwoZyza7df/FCmYNI8
   b67pNBnwH5/rZRDwME1dgPjJcz+Gc62OGRIU1mI3SUhnXgsmD8Bc7sxc7
   WUTns0toYs8D1PtDfVXvOzEY7nPBcAE0B6TnM1Zj2Kmeqr9Qh9yLFtd0w
   8qzjd+tmKFGLJjWIhsAB+3GNNONuZEI5wMitGbgtRAufeZXH+JJJCnk7J
   sl/pDoKUomgeEOWfzwbnEZnynEcU2GAm45IBH3dO31S/d9J1HD4sR0YAI
   g==;
X-CSE-ConnectionGUID: K27vlKXSQki0ONDLYJcaRQ==
X-CSE-MsgGUID: H30zBaTcRL+TGC4FXrKgCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="25181563"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="25181563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:50:36 -0700
X-CSE-ConnectionGUID: lMt31lgjRqO5B20eKNv4yA==
X-CSE-MsgGUID: dfDHijn8QYOH+XgjOQ/eMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="36810149"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 31 May 2024 22:50:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDHdQ-000ISF-1D;
	Sat, 01 Jun 2024 05:50:32 +0000
Date: Sat, 1 Jun 2024 13:49:46 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] dmaengine: fsl-edma: remove redundant "idle" field
 from fsl_chan
Message-ID: <202406011344.s3sPp61I-lkp@intel.com>
References: <20240531210152.1878443-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531210152.1878443-2-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-remove-redundant-idle-field-from-fsl_chan/20240601-050401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20240531210152.1878443-2-Frank.Li%40nxp.com
patch subject: [PATCH 2/2] dmaengine: fsl-edma: remove redundant "idle" field from fsl_chan
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406011344.s3sPp61I-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011344.s3sPp61I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011344.s3sPp61I-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_err_handler':
>> drivers/dma/mcf-edma-main.c:67:44: error: 'struct fsl_edma_chan' has no member named 'idle'
      67 |                         mcf_edma->chans[ch].idle = true;
         |                                            ^
   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_probe':
   drivers/dma/mcf-edma-main.c:199:25: error: 'struct fsl_edma_chan' has no member named 'idle'
     199 |                 mcf_chan->idle = true;
         |                         ^~


vim +67 drivers/dma/mcf-edma-main.c

e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  39  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  40  static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  41  {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  42  	struct fsl_edma_engine *mcf_edma = dev_id;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  43  	struct edma_regs *regs = &mcf_edma->regs;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  44  	unsigned int err, ch;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  45  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  46  	err = ioread32(regs->errl);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  47  	if (!err)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  48  		return IRQ_NONE;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  49  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  50  	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  51  		if (err & BIT(ch)) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  52  			fsl_edma_disable_request(&mcf_edma->chans[ch]);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  53  			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
79434f9b973616 drivers/dma/mcf-edma-main.c Frank Li          2023-08-21  54  			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  55  		}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  56  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  57  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  58  	err = ioread32(regs->errh);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  59  	if (!err)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  60  		return IRQ_NONE;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  61  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  62  	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  63  		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  64  			fsl_edma_disable_request(&mcf_edma->chans[ch]);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  65  			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  66  			mcf_edma->chans[ch].status = DMA_ERROR;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19 @67  			mcf_edma->chans[ch].idle = true;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  68  		}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  69  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  70  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  71  	return IRQ_HANDLED;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  72  }
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello 2018-08-19  73  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

