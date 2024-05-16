Return-Path: <linux-kernel+bounces-180519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E988C6F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695401C21626
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AF10E3;
	Thu, 16 May 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avmJHgnM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BE64F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819781; cv=none; b=AzELUBbPqSNA3Npiv3g89q5RZAG9rF6+xEhMe13G0uFlMRYjD9ez2um3A43YZSJIEQFRrjnJ5wV6KE2h7HyiDZ7fmA0HNXuOzT5TXPYLR08Er3JbkmwCuI8iJG0ICXzfwKImPBGBNLAZ/0Ys73o1NQs5n59lHPQVQEiQH2pPv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819781; c=relaxed/simple;
	bh=6Mg+8xvN4a+D/lG06X8UDeZxC7PgIfzpT8AlMvxlsA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M7IP6+PGN85IkA3wnzNMaDLJXlRKSsvawKA28hcN/6WCrUzp4CowUWuMlidE5cTJwmcKp16yVpG2JH794D/iLocr5GP/N806QOYYNH+OrqTx4Tt8Ry4De4Bqjiv7NYpTLtB2srz2rOmRD3JnyJR7Hh0kR5BY5o3XYpCRXIoy/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avmJHgnM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715819778; x=1747355778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Mg+8xvN4a+D/lG06X8UDeZxC7PgIfzpT8AlMvxlsA0=;
  b=avmJHgnMqiWV+eBZovDGxCz+lsR4i6cxx+K+Rr77K2EgS5BNTJK0CD/e
   +Vm4PCS3tmDcyIo+56wZInuAntQ2VHy4EIi+IL74IXkcIxLsPqtztGnPF
   D+C/XRJCVgnu6bwtBTPf8ZXrq6YurccD/gg0zStFAqs2oMFlxODF/Bafy
   pvU9FShEmZyHuR1wxMjcgTSUT3fSMo0i9Eq+TaG7UpccCx4lbln45d/HH
   l7qKqhozIC3YTsZs5lUmyUT5agjEattfwSJyG8Ae60CLYw7ns9SpWft+G
   NSg4xoYfvaVv7tgwVse5Uet+Mm8yX2GJ1bd0nsLBdSVjCqfSFeCEaVL4k
   w==;
X-CSE-ConnectionGUID: QyKykVQVQSSonivEWmwMaA==
X-CSE-MsgGUID: gDr1BK7aTMC7gWBzdmE97g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12065548"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="12065548"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 17:36:16 -0700
X-CSE-ConnectionGUID: b7DGzwP5QU6d6y8Qibit6w==
X-CSE-MsgGUID: 3gcY7n8kRg2VkDE0IYJPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="68695404"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 May 2024 17:36:14 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7P6S-000DPH-10;
	Thu, 16 May 2024 00:36:12 +0000
Date: Thu, 16 May 2024 08:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202405160853.3qyaSj8w-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thorsten,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8c06da67d0bd3139a97f301b4aa9c482b9d4f29e
commit: 5eefb477d21a26183bc3499aeefa991198315a2d net: smc91x: Fix m68k kernel compilation for ColdFire CPU
date:   2 days ago
config: m68k-randconfig-r123-20240516 (https://download.01.org/0day-ci/archive/20240516/202405160853.3qyaSj8w-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240516/202405160853.3qyaSj8w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *a @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     expected void *a
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *a @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     expected void *a
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *a @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     expected void *a
   drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *a @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:     expected void *a
   drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:     got void [noderef] __iomem *

vim +590 drivers/net/ethernet/smsc/smc91x.c

^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  535  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  536  /*
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  537   * This is called to actually send a packet to the chip.
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  538   */
7961fb1089f826 drivers/net/ethernet/smsc/smc91x.c Allen Pais       2020-09-14  539  static void smc_hardware_send_pkt(struct tasklet_struct *t)
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  540  {
7961fb1089f826 drivers/net/ethernet/smsc/smc91x.c Allen Pais       2020-09-14  541  	struct smc_local *lp = from_tasklet(lp, t, tx_task);
7961fb1089f826 drivers/net/ethernet/smsc/smc91x.c Allen Pais       2020-09-14  542  	struct net_device *dev = lp->dev;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  543  	void __iomem *ioaddr = lp->base;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  544  	struct sk_buff *skb;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  545  	unsigned int packet_no, len;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  546  	unsigned char *buf;
8ff499e43c5376 drivers/net/smc91x.c               Dongdong Deng    2009-08-23  547  	unsigned long flags;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  548  
6389aa458ed995 drivers/net/ethernet/smsc/smc91x.c Ben Boeckel      2013-11-01  549  	DBG(3, dev, "%s\n", __func__);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  550  
8ff499e43c5376 drivers/net/smc91x.c               Dongdong Deng    2009-08-23  551  	if (!smc_special_trylock(&lp->lock, flags)) {
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  552  		netif_stop_queue(dev);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  553  		tasklet_schedule(&lp->tx_task);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  554  		return;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  555  	}
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  556  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  557  	skb = lp->pending_tx_skb;
be83668a253149 drivers/net/smc91x.c               Nicolas Pitre    2005-06-19  558  	if (unlikely(!skb)) {
8ff499e43c5376 drivers/net/smc91x.c               Dongdong Deng    2009-08-23  559  		smc_special_unlock(&lp->lock, flags);
be83668a253149 drivers/net/smc91x.c               Nicolas Pitre    2005-06-19  560  		return;
be83668a253149 drivers/net/smc91x.c               Nicolas Pitre    2005-06-19  561  	}
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  562  	lp->pending_tx_skb = NULL;
be83668a253149 drivers/net/smc91x.c               Nicolas Pitre    2005-06-19  563  
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  564  	packet_no = SMC_GET_AR(lp);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  565  	if (unlikely(packet_no & AR_FAILED)) {
6389aa458ed995 drivers/net/ethernet/smsc/smc91x.c Ben Boeckel      2013-11-01  566  		netdev_err(dev, "Memory allocation failed.\n");
09f75cd7bf1372 drivers/net/smc91x.c               Jeff Garzik      2007-10-03  567  		dev->stats.tx_errors++;
09f75cd7bf1372 drivers/net/smc91x.c               Jeff Garzik      2007-10-03  568  		dev->stats.tx_fifo_errors++;
8ff499e43c5376 drivers/net/smc91x.c               Dongdong Deng    2009-08-23  569  		smc_special_unlock(&lp->lock, flags);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  570  		goto done;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  571  	}
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  572  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  573  	/* point to the beginning of the packet */
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  574  	SMC_SET_PN(lp, packet_no);
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  575  	SMC_SET_PTR(lp, PTR_AUTOINC);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  576  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  577  	buf = skb->data;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  578  	len = skb->len;
6389aa458ed995 drivers/net/ethernet/smsc/smc91x.c Ben Boeckel      2013-11-01  579  	DBG(2, dev, "TX PNR 0x%x LENGTH 0x%04x (%d) BUF 0x%p\n",
6389aa458ed995 drivers/net/ethernet/smsc/smc91x.c Ben Boeckel      2013-11-01  580  	    packet_no, len, len, buf);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  581  	PRINT_PKT(buf, len);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  582  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  583  	/*
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  584  	 * Send the packet length (+6 for status words, length, and ctl.
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  585  	 * The card will pad to 64 bytes with zeroes if packet is too small.
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  586  	 */
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  587  	SMC_PUT_PKT_HDR(lp, 0, len + 6);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  588  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  589  	/* send the actual data */
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22 @590  	SMC_PUSH_DATA(lp, buf, len & ~1);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  591  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  592  	/* Send final ctl word with the last byte if there is one */
d09d747ae4c25a drivers/net/ethernet/smsc/smc91x.c Robert Jarzmik   2016-10-17  593  	SMC_outw(lp, ((len & 1) ? (0x2000 | buf[len - 1]) : 0), ioaddr,
d09d747ae4c25a drivers/net/ethernet/smsc/smc91x.c Robert Jarzmik   2016-10-17  594  		 DATA_REG(lp));
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  595  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  596  	/*
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  597  	 * If THROTTLE_TX_PKTS is set, we stop the queue here. This will
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  598  	 * have the effect of having at most one packet queued for TX
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  599  	 * in the chip's memory at all time.
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  600  	 *
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  601  	 * If THROTTLE_TX_PKTS is not set then the queue is stopped only
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  602  	 * when memory allocation (MC_ALLOC) does not succeed right away.
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  603  	 */
ea9375607f8b31 drivers/net/smc91x.c               Nicolas Pitre    2005-04-12  604  	if (THROTTLE_TX_PKTS)
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  605  		netif_stop_queue(dev);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  606  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  607  	/* queue the packet for TX */
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  608  	SMC_SET_MMU_CMD(lp, MC_ENQUEUE);
8ff499e43c5376 drivers/net/smc91x.c               Dongdong Deng    2009-08-23  609  	smc_special_unlock(&lp->lock, flags);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  610  
860e9538a9482b drivers/net/ethernet/smsc/smc91x.c Florian Westphal 2016-05-03  611  	netif_trans_update(dev);
09f75cd7bf1372 drivers/net/smc91x.c               Jeff Garzik      2007-10-03  612  	dev->stats.tx_packets++;
09f75cd7bf1372 drivers/net/smc91x.c               Jeff Garzik      2007-10-03  613  	dev->stats.tx_bytes += len;
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  614  
cfdfa86536d2fb drivers/net/smc91x.c               Magnus Damm      2008-02-22  615  	SMC_ENABLE_INT(lp, IM_TX_INT | IM_TX_EMPTY_INT);
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds   2005-04-16  616  

:::::: The code at line 590 was first introduced by commit
:::::: cfdfa86536d2fbc8102780ec15faea185e957d3d smc91x: pass along private data V2

:::::: TO: Magnus Damm <magnus.damm@gmail.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

