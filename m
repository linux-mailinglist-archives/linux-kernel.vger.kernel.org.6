Return-Path: <linux-kernel+bounces-437591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB89E9593
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4331886600
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC5231CAD;
	Mon,  9 Dec 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULVJjLeQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5D231CA5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749055; cv=none; b=svV/GN3GLPsDj0uWR3Yz6bDGMIhYAZa6JLzziNb7bmKICm+Oc8owBTgCrzSuPkbRMADzqjB/zZ+KdGJOWIje7Kk0YqPt6BtZtNxLafkZd4NtIm+xQcs7RPpjkgtTTA0Y/oNrdHpYBGeunTJsFk9biO4RW9pGgm5OLuDQaq4a2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749055; c=relaxed/simple;
	bh=4F3mDUZwH6vfD4gxXFEQFVe9uUFOU0E19QdNWCaLaV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jl1/mf3CvvTau/7EvxobfIPNciB93Nz7X87MQPpI0jr6X11kV7a2apEo7uDCY9JqqrgdRy4Duyu6ZALvaBc+PmC6LtqZ5hApOpAoMwnb1uJvuQs3O4NY+l1AdJnorWP5fm/DWK6SMsLMpx+fIQI2j+UkZCL11UbRAaluwqu1+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULVJjLeQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733749054; x=1765285054;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4F3mDUZwH6vfD4gxXFEQFVe9uUFOU0E19QdNWCaLaV0=;
  b=ULVJjLeQqAtRoQyFdhehTiO4MZqIug6MB9+/R4j49oEHk7AzLL1pQNel
   t3wPhik11KOXiHQTtUXT/tQCxc0euSsHDZrscFeXl4O5xiQhOhpUVR/Yp
   PkGBmwjJFfe/MexvCmToCi7ijSbhePPhdOWFv15EyA1fyzDkgDfh2tY41
   Pq9DvtkhgoXQmwJY0A6OhUDS2n6kLeh+qaIyiLzhnJrz9lpXjaMSML+UT
   /vqmsUndrAXRiR3Ob1YiWacYVsYx2/Y/lJ5DX1IQHFMoWizJn4F7w+brB
   vj1LMECQYwjgvEe3oMh8nJjTeZbT64rmaPMlVdE6PRYJgxPMrLRHScguv
   w==;
X-CSE-ConnectionGUID: jN0mz8ujRkmJRNaDLkiFjg==
X-CSE-MsgGUID: qZDiTgZqQhG2SNdPwMLqHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34274795"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34274795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:57:33 -0800
X-CSE-ConnectionGUID: jYuArqaLSWWc+CifHg005A==
X-CSE-MsgGUID: dHvlY0WcQEybUIDfn5LzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95520935"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Dec 2024 04:57:31 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKdKL-0004LL-0q;
	Mon, 09 Dec 2024 12:57:29 +0000
Date: Mon, 9 Dec 2024 20:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Dietrich <marvin24@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: drivers/staging/nvec/nvec.c:583:29: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202412092049.OjIxptXr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
commit: c8c96293a599c6291fa2622830fcbfc1ce0f5a7d staging: nvec: make i2c controller register writes robust
date:   6 months ago
config: arm64-randconfig-r122-20241209 (https://download.01.org/0day-ci/archive/20241209/202412092049.OjIxptXr-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce: (https://download.01.org/0day-ci/archive/20241209/202412092049.OjIxptXr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412092049.OjIxptXr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/staging/nvec/nvec.c:583:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reg @@
   drivers/staging/nvec/nvec.c:583:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/nvec/nvec.c:583:29: sparse:     got void *reg
>> drivers/staging/nvec/nvec.c:586:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *reg @@
   drivers/staging/nvec/nvec.c:586:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/nvec/nvec.c:586:23: sparse:     got void *reg
>> drivers/staging/nvec/nvec.c:623:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:623:56: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:623:56: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:715:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:715:54: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:715:54: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:747:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:747:42: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:747:42: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:751:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:751:51: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:751:51: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:752:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:752:43: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:752:43: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:754:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:754:58: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:754:58: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:755:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:755:40: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:755:40: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c:764:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *reg @@     got void [noderef] __iomem * @@
   drivers/staging/nvec/nvec.c:764:65: sparse:     expected void *reg
   drivers/staging/nvec/nvec.c:764:65: sparse:     got void [noderef] __iomem *
   drivers/staging/nvec/nvec.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +583 drivers/staging/nvec/nvec.c

   572	
   573	/**
   574	 * tegra_i2c_writel - safely write to an I2C client controller register
   575	 * @val: value to be written
   576	 * @reg: register to write to
   577	 *
   578	 * A write to an I2C controller register needs to be read back to make sure
   579	 * that the value has arrived.
   580	 */
   581	static void tegra_i2c_writel(u32 val, void *reg)
   582	{
 > 583		writel_relaxed(val, reg);
   584	
   585		/* read back register to make sure that register writes completed */
 > 586		readl_relaxed(reg);
   587	}
   588	
   589	/**
   590	 * nvec_interrupt - Interrupt handler
   591	 * @irq: The IRQ
   592	 * @dev: The nvec device
   593	 *
   594	 * Interrupt handler that fills our RX buffers and empties our TX
   595	 * buffers. This uses a finite state machine with ridiculous amounts
   596	 * of error checking, in order to be fairly reliable.
   597	 */
   598	static irqreturn_t nvec_interrupt(int irq, void *dev)
   599	{
   600		unsigned long status;
   601		unsigned int received = 0;
   602		unsigned char to_send = 0xff;
   603		const unsigned long irq_mask = I2C_SL_IRQ | END_TRANS | RCVD | RNW;
   604		struct nvec_chip *nvec = dev;
   605		unsigned int state = nvec->state;
   606	
   607		status = readl(nvec->base + I2C_SL_STATUS);
   608	
   609		/* Filter out some errors */
   610		if ((status & irq_mask) == 0 && (status & ~irq_mask) != 0) {
   611			dev_err(nvec->dev, "unexpected irq mask %lx\n", status);
   612			return IRQ_HANDLED;
   613		}
   614		if ((status & I2C_SL_IRQ) == 0) {
   615			dev_err(nvec->dev, "Spurious IRQ\n");
   616			return IRQ_HANDLED;
   617		}
   618	
   619		/* The EC did not request a read, so it send us something, read it */
   620		if ((status & RNW) == 0) {
   621			received = readl(nvec->base + I2C_SL_RCVD);
   622			if (status & RCVD)
 > 623				tegra_i2c_writel(0, nvec->base + I2C_SL_RCVD);
   624		}
   625	
   626		if (status == (I2C_SL_IRQ | RCVD))
   627			nvec->state = 0;
   628	
   629		switch (nvec->state) {
   630		case 0:		/* Verify that its a transfer start, the rest later */
   631			if (status != (I2C_SL_IRQ | RCVD))
   632				nvec_invalid_flags(nvec, status, false);
   633			break;
   634		case 1:		/* command byte */
   635			if (status != I2C_SL_IRQ) {
   636				nvec_invalid_flags(nvec, status, true);
   637			} else {
   638				nvec->rx = nvec_msg_alloc(nvec, NVEC_MSG_RX);
   639				/* Should not happen in a normal world */
   640				if (unlikely(!nvec->rx)) {
   641					nvec->state = 0;
   642					break;
   643				}
   644				nvec->rx->data[0] = received;
   645				nvec->rx->pos = 1;
   646				nvec->state = 2;
   647			}
   648			break;
   649		case 2:		/* first byte after command */
   650			if (status == (I2C_SL_IRQ | RNW | RCVD)) {
   651				udelay(33);
   652				if (nvec->rx->data[0] != 0x01) {
   653					dev_err(nvec->dev,
   654						"Read without prior read command\n");
   655					nvec->state = 0;
   656					break;
   657				}
   658				nvec_msg_free(nvec, nvec->rx);
   659				nvec->state = 3;
   660				nvec_tx_set(nvec);
   661				to_send = nvec->tx->data[0];
   662				nvec->tx->pos = 1;
   663			} else if (status == (I2C_SL_IRQ)) {
   664				nvec->rx->data[1] = received;
   665				nvec->rx->pos = 2;
   666				nvec->state = 4;
   667			} else {
   668				nvec_invalid_flags(nvec, status, true);
   669			}
   670			break;
   671		case 3:		/* EC does a block read, we transmit data */
   672			if (status & END_TRANS) {
   673				nvec_tx_completed(nvec);
   674			} else if ((status & RNW) == 0 || (status & RCVD)) {
   675				nvec_invalid_flags(nvec, status, true);
   676			} else if (nvec->tx && nvec->tx->pos < nvec->tx->size) {
   677				to_send = nvec->tx->data[nvec->tx->pos++];
   678			} else {
   679				dev_err(nvec->dev,
   680					"tx buffer underflow on %p (%u > %u)\n",
   681					nvec->tx,
   682					(uint)(nvec->tx ? nvec->tx->pos : 0),
   683					(uint)(nvec->tx ? nvec->tx->size : 0));
   684				nvec->state = 0;
   685			}
   686			break;
   687		case 4:		/* EC does some write, we read the data */
   688			if ((status & (END_TRANS | RNW)) == END_TRANS)
   689				nvec_rx_completed(nvec);
   690			else if (status & (RNW | RCVD))
   691				nvec_invalid_flags(nvec, status, true);
   692			else if (nvec->rx && nvec->rx->pos < NVEC_MSG_SIZE)
   693				nvec->rx->data[nvec->rx->pos++] = received;
   694			else
   695				dev_err(nvec->dev,
   696					"RX buffer overflow on %p: Trying to write byte %u of %u\n",
   697					nvec->rx, nvec->rx ? nvec->rx->pos : 0,
   698					NVEC_MSG_SIZE);
   699			break;
   700		default:
   701			nvec->state = 0;
   702		}
   703	
   704		/* If we are told that a new transfer starts, verify it */
   705		if ((status & (RCVD | RNW)) == RCVD) {
   706			if (received != nvec->i2c_addr)
   707				dev_err(nvec->dev,
   708					"received address 0x%02x, expected 0x%02x\n",
   709					received, nvec->i2c_addr);
   710			nvec->state = 1;
   711		}
   712	
   713		/* Send data if requested, but not on end of transmission */
   714		if ((status & (RNW | END_TRANS)) == RNW)
   715			tegra_i2c_writel(to_send, nvec->base + I2C_SL_RCVD);
   716	
   717		/* If we have send the first byte */
   718		if (status == (I2C_SL_IRQ | RNW | RCVD))
   719			nvec_gpio_set_value(nvec, 1);
   720	
   721		dev_dbg(nvec->dev,
   722			"Handled: %s 0x%02x, %s 0x%02x in state %u [%s%s%s]\n",
   723			(status & RNW) == 0 ? "received" : "R=",
   724			received,
   725			(status & (RNW | END_TRANS)) ? "sent" : "S=",
   726			to_send,
   727			state,
   728			status & END_TRANS ? " END_TRANS" : "",
   729			status & RCVD ? " RCVD" : "",
   730			status & RNW ? " RNW" : "");
   731	
   732		return IRQ_HANDLED;
   733	}
   734	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

