Return-Path: <linux-kernel+bounces-197689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC48D6DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059361C211BB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47FDDBB;
	Sat,  1 Jun 2024 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTsc+Q/i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC5AD5A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717218550; cv=none; b=LXKy8zuxeJ6IVfvxdyQd64tZHTQ09VKHgKLTBZtZu/QKB0Uw9e7kiSutMdKzkbmo5lee0OWZDx/MwIJeap8OGU1cTPCST0mtPflrq25Yh6uwevSSjMvwn4q0/7gulrjdC/1i/i+dgO7YWYPc1eQLvGyfVaeh6ZzafqShw3Snl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717218550; c=relaxed/simple;
	bh=tKYTmVHs6IMI7rjpM20cWi/8xgeoZcaJdXkzRHvYPR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1TTh8F9l1J9dBXMyTVdjbdOBAFEvpDFH0t6sFzqzvSihifPvQH+sppZtQLhjN4Tm8FHXlMjDF7dPO1KPtVj2dy0pKkwEmXNIg398UQst08LDAkKUXRLKA7Digje/wxQP8b9WAfEu37Sx7TJuYEEhuVu08SXAffJkyskHPmTe1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTsc+Q/i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717218548; x=1748754548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tKYTmVHs6IMI7rjpM20cWi/8xgeoZcaJdXkzRHvYPR0=;
  b=TTsc+Q/iih3zCv8c/rqE2chBX9CIzwvGNSsEDB/9IeTXe2++e8mRq6Ea
   tODmhiRZ1fBw4rHNuA2IEwaPOwZQElLVW//LImyXepJW02WWxok4UdtnF
   24m66mISOVmoZdkkZSbR8O14gaEdcQ8XTMPwJ/0cd1SbqHndYag/a/xGO
   0Lm56Ub7jVakV8FdjRr8hvMAPZ//rsH+EnRBpMzz1T9mIoBm6YoJnOYSE
   MDuYA9aQ+mjLRRMTpfE9/aWd0764/QzyRxIQn5F7aKS6ECvEiHTwbVdrx
   x5fhsg1kJz6kToCMl1xlYgCx+qTLvogyuVCiIAY1iAmjYveqFfLbEt6pS
   w==;
X-CSE-ConnectionGUID: eIxjqUCASM+nbYQnmWprqA==
X-CSE-MsgGUID: hROSLjJ/Qf6FQFkIFT0wXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17570138"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="17570138"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:09:08 -0700
X-CSE-ConnectionGUID: t4bv1537SM6B9vxLcsByig==
X-CSE-MsgGUID: /62jstHhSxWc/FUZHbEKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="40797318"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 22:09:06 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDGzH-000IQL-33;
	Sat, 01 Jun 2024 05:09:03 +0000
Date: Sat, 1 Jun 2024 13:08:12 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] dmaengine: fsl-edma: remove redundant "idle" field
 from fsl_chan
Message-ID: <202406011229.5vpeVXX2-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240601/202406011229.5vpeVXX2-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011229.5vpeVXX2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011229.5vpeVXX2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/mcf-edma-main.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/dma/mcf-edma-main.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/dma/mcf-edma-main.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/dma/mcf-edma-main.c:8:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/dma/mcf-edma-main.c:67:24: error: no member named 'idle' in 'struct fsl_edma_chan'
      67 |                         mcf_edma->chans[ch].idle = true;
         |                         ~~~~~~~~~~~~~~~~~~~ ^
   drivers/dma/mcf-edma-main.c:199:13: error: no member named 'idle' in 'struct fsl_edma_chan'
     199 |                 mcf_chan->idle = true;
         |                 ~~~~~~~~  ^
   7 warnings and 2 errors generated.


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

