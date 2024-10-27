Return-Path: <linux-kernel+bounces-383525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0D79B1CD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5521C20A12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CF824BD;
	Sun, 27 Oct 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er5m3cC1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742957346D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021829; cv=none; b=GsnkNrJcebiNo+J0iU2iY22qO3f44ENH9jPfuiTPxSlRt9T+UeNRwWpnYH4Dk5OVUTf39PGBpEX6Nx9fsP+nUsKOTEUBKIokhgwIPXv0wOswch90u1Dc5DCVFm98b6Zke2qvaNX2PlS9UVih3U+mJ4umWFM01y5+95/1P6J8+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021829; c=relaxed/simple;
	bh=C7BwHFSN1lB9K2jx5JMacFwno1/9R++FE6ZHbNvChr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BqqItxh7CZGkm839sADIqDz3a70YiASFhPgzMrz77jE/0H3r80nPmEt0cP9cgYtXREHj3iKbC0gqlqxa9I8jr36k81DWJhdga/GtZr/A67vCdDanPeE2VwNS0/MRvt44s6Yftw/QZtFuCGkiEdWcqdJBxJQwDDckDx65M9kfzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Er5m3cC1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730021826; x=1761557826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C7BwHFSN1lB9K2jx5JMacFwno1/9R++FE6ZHbNvChr0=;
  b=Er5m3cC1K1qPc9d1Z2uMwGrRgq00GkTfyseym8kKA1QgdKKhwRDd1Sjt
   9Z9awgAFNHnb085Tb9tsKkTqgh0Oupqtx4I+0a4mvlxsNg51mni17fSDX
   PdeTKdRoqEeVujhSxXlfxGsBsrMaq1pzx6+nGH6MRT0FwLnSQVzRSnXZX
   slcbRfHEQHioB09DpDDEAU8CprqawULfoWlnRLogrfmkP9cOt5eSoeXPu
   1LClBqnKthdKEW/LAtxR+X5rTV0Jm4XljymMFTXk3Dd7QVP2qes4dUTTC
   vNaLD+pOsnSnqBCv2lpXphd8aMNkBgq5s2PYPLMB1wY4Phdoy/GbI+8VO
   g==;
X-CSE-ConnectionGUID: 0vGLGeOBQ9uKlQTi79/caA==
X-CSE-MsgGUID: zPmcmD2XQq24Am8ff3ybNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="40218814"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="40218814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 02:37:03 -0700
X-CSE-ConnectionGUID: /qvVD6SlQQmHnLa31aCFRA==
X-CSE-MsgGUID: c+9zF6S5QMmGFdHaOVYiuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81657974"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Oct 2024 02:37:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4zhi-000aav-36;
	Sun, 27 Oct 2024 09:36:58 +0000
Date: Sun, 27 Oct 2024 17:36:56 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse:
 sparse: cast to restricted __be32
Message-ID: <202410271721.jiVrriXD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Breno,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
commit: 782fe08e9861d00ce8aca370453dd9ceb9a23d50 soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
date:   3 months ago
config: arm-randconfig-r123-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce: (https://download.01.org/0day-ci/archive/20241027/202410271721.jiVrriXD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271721.jiVrriXD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file:
>> include/soc/fsl/qman.h:245:16: sparse: sparse: cast to restricted __be32
>> include/soc/fsl/qman.h:245:16: sparse: sparse: cast from restricted __be16

vim +2745 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c

86c0c196cbe48f8 Camelia Groza             2020-11-25  2650  
9ad1a37493338ca Madalin Bucur             2016-11-15  2651  static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
9ad1a37493338ca Madalin Bucur             2016-11-15  2652  						struct qman_fq *fq,
f84754dbc55e3ab Sebastian Andrzej Siewior 2020-11-02  2653  						const struct qm_dqrr_entry *dq,
f84754dbc55e3ab Sebastian Andrzej Siewior 2020-11-02  2654  						bool sched_napi)
9ad1a37493338ca Madalin Bucur             2016-11-15  2655  {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2656  	bool ts_valid = false, hash_valid = false;
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2657  	struct skb_shared_hwtstamps *shhwtstamps;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2658  	unsigned int skb_len, xdp_meta_len = 0;
9ad1a37493338ca Madalin Bucur             2016-11-15  2659  	struct rtnl_link_stats64 *percpu_stats;
9ad1a37493338ca Madalin Bucur             2016-11-15  2660  	struct dpaa_percpu_priv *percpu_priv;
9ad1a37493338ca Madalin Bucur             2016-11-15  2661  	const struct qm_fd *fd = &dq->fd;
9ad1a37493338ca Madalin Bucur             2016-11-15  2662  	dma_addr_t addr = qm_fd_addr(fd);
a1e031ffb422bb8 Camelia Groza             2020-11-25  2663  	struct dpaa_napi_portal *np;
9ad1a37493338ca Madalin Bucur             2016-11-15  2664  	enum qm_fd_format fd_format;
9ad1a37493338ca Madalin Bucur             2016-11-15  2665  	struct net_device *net_dev;
056057e288e7075 Madalin Bucur             2017-08-27  2666  	u32 fd_status, hash_offset;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2667  	struct qm_sg_entry *sgt;
9ad1a37493338ca Madalin Bucur             2016-11-15  2668  	struct dpaa_bp *dpaa_bp;
d57e57d0cd04be5 Camelia Groza             2020-11-25  2669  	struct dpaa_fq *dpaa_fq;
9ad1a37493338ca Madalin Bucur             2016-11-15  2670  	struct dpaa_priv *priv;
9ad1a37493338ca Madalin Bucur             2016-11-15  2671  	struct sk_buff *skb;
9ad1a37493338ca Madalin Bucur             2016-11-15  2672  	int *count_ptr;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2673  	u32 xdp_act;
056057e288e7075 Madalin Bucur             2017-08-27  2674  	void *vaddr;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2675  	u32 hash;
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2676  	u64 ns;
9ad1a37493338ca Madalin Bucur             2016-11-15  2677  
d57e57d0cd04be5 Camelia Groza             2020-11-25  2678  	dpaa_fq = container_of(fq, struct dpaa_fq, fq_base);
7d6f8dc0b2180ed Claudiu Manoil            2016-12-15  2679  	fd_status = be32_to_cpu(fd->status);
7d6f8dc0b2180ed Claudiu Manoil            2016-12-15  2680  	fd_format = qm_fd_get_format(fd);
d57e57d0cd04be5 Camelia Groza             2020-11-25  2681  	net_dev = dpaa_fq->net_dev;
9ad1a37493338ca Madalin Bucur             2016-11-15  2682  	priv = netdev_priv(net_dev);
9ad1a37493338ca Madalin Bucur             2016-11-15  2683  	dpaa_bp = dpaa_bpid2pool(dq->fd.bpid);
9ad1a37493338ca Madalin Bucur             2016-11-15  2684  	if (!dpaa_bp)
9ad1a37493338ca Madalin Bucur             2016-11-15  2685  		return qman_cb_dqrr_consume;
9ad1a37493338ca Madalin Bucur             2016-11-15  2686  
eb11ddf36eb87f3 Madalin Bucur             2016-11-15  2687  	/* Trace the Rx fd */
eb11ddf36eb87f3 Madalin Bucur             2016-11-15  2688  	trace_dpaa_rx_fd(net_dev, fq, &dq->fd);
eb11ddf36eb87f3 Madalin Bucur             2016-11-15  2689  
9ad1a37493338ca Madalin Bucur             2016-11-15  2690  	percpu_priv = this_cpu_ptr(priv->percpu_priv);
9ad1a37493338ca Madalin Bucur             2016-11-15  2691  	percpu_stats = &percpu_priv->stats;
433dfc99aa3e0ac Camelia Groza             2021-02-18  2692  	np = &percpu_priv->np;
9ad1a37493338ca Madalin Bucur             2016-11-15  2693  
abba4b16fddda9a Sebastian Andrzej Siewior 2020-11-02  2694  	if (unlikely(dpaa_eth_napi_schedule(percpu_priv, portal, sched_napi)))
9ad1a37493338ca Madalin Bucur             2016-11-15  2695  		return qman_cb_dqrr_stop;
9ad1a37493338ca Madalin Bucur             2016-11-15  2696  
9ad1a37493338ca Madalin Bucur             2016-11-15  2697  	/* Make sure we didn't run out of buffers */
9ad1a37493338ca Madalin Bucur             2016-11-15  2698  	if (unlikely(dpaa_eth_refill_bpools(priv))) {
9ad1a37493338ca Madalin Bucur             2016-11-15  2699  		/* Unable to refill the buffer pool due to insufficient
9ad1a37493338ca Madalin Bucur             2016-11-15  2700  		 * system memory. Just release the frame back into the pool,
9ad1a37493338ca Madalin Bucur             2016-11-15  2701  		 * otherwise we'll soon end up with an empty buffer pool.
9ad1a37493338ca Madalin Bucur             2016-11-15  2702  		 */
9ad1a37493338ca Madalin Bucur             2016-11-15  2703  		dpaa_fd_release(net_dev, &dq->fd);
9ad1a37493338ca Madalin Bucur             2016-11-15  2704  		return qman_cb_dqrr_consume;
9ad1a37493338ca Madalin Bucur             2016-11-15  2705  	}
9ad1a37493338ca Madalin Bucur             2016-11-15  2706  
9ad1a37493338ca Madalin Bucur             2016-11-15  2707  	if (unlikely(fd_status & FM_FD_STAT_RX_ERRORS) != 0) {
9ad1a37493338ca Madalin Bucur             2016-11-15  2708  		if (net_ratelimit())
9ad1a37493338ca Madalin Bucur             2016-11-15  2709  			netif_warn(priv, hw, net_dev, "FD status = 0x%08x\n",
9ad1a37493338ca Madalin Bucur             2016-11-15  2710  				   fd_status & FM_FD_STAT_RX_ERRORS);
9ad1a37493338ca Madalin Bucur             2016-11-15  2711  
9ad1a37493338ca Madalin Bucur             2016-11-15  2712  		percpu_stats->rx_errors++;
9ad1a37493338ca Madalin Bucur             2016-11-15  2713  		dpaa_fd_release(net_dev, fd);
9ad1a37493338ca Madalin Bucur             2016-11-15  2714  		return qman_cb_dqrr_consume;
9ad1a37493338ca Madalin Bucur             2016-11-15  2715  	}
9ad1a37493338ca Madalin Bucur             2016-11-15  2716  
8151ee88bad568f Madalin Bucur             2019-10-31  2717  	dma_unmap_page(dpaa_bp->priv->rx_dma_dev, addr, DPAA_BP_RAW_SIZE,
060ad66f97954fa Madalin Bucur             2019-10-23  2718  		       DMA_FROM_DEVICE);
9ad1a37493338ca Madalin Bucur             2016-11-15  2719  
9ad1a37493338ca Madalin Bucur             2016-11-15  2720  	/* prefetch the first 64 bytes of the frame or the SGT start */
056057e288e7075 Madalin Bucur             2017-08-27  2721  	vaddr = phys_to_virt(addr);
056057e288e7075 Madalin Bucur             2017-08-27  2722  	prefetch(vaddr + qm_fd_get_offset(fd));
9ad1a37493338ca Madalin Bucur             2016-11-15  2723  
9ad1a37493338ca Madalin Bucur             2016-11-15  2724  	/* The only FD types that we may receive are contig and S/G */
9ad1a37493338ca Madalin Bucur             2016-11-15  2725  	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
9ad1a37493338ca Madalin Bucur             2016-11-15  2726  
9ad1a37493338ca Madalin Bucur             2016-11-15  2727  	/* Account for either the contig buffer or the SGT buffer (depending on
9ad1a37493338ca Madalin Bucur             2016-11-15  2728  	 * which case we were in) having been removed from the pool.
9ad1a37493338ca Madalin Bucur             2016-11-15  2729  	 */
9ad1a37493338ca Madalin Bucur             2016-11-15  2730  	count_ptr = this_cpu_ptr(dpaa_bp->percpu_count);
9ad1a37493338ca Madalin Bucur             2016-11-15  2731  	(*count_ptr)--;
9ad1a37493338ca Madalin Bucur             2016-11-15  2732  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2733  	/* Extract the timestamp stored in the headroom before running XDP */
86c0c196cbe48f8 Camelia Groza             2020-11-25  2734  	if (priv->rx_tstamp) {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2735  		if (!fman_port_get_tstamp(priv->mac_dev->port[RX], vaddr, &ns))
86c0c196cbe48f8 Camelia Groza             2020-11-25  2736  			ts_valid = true;
9ad1a37493338ca Madalin Bucur             2016-11-15  2737  		else
86c0c196cbe48f8 Camelia Groza             2020-11-25  2738  			WARN_ONCE(1, "fman_port_get_tstamp failed!\n");
86c0c196cbe48f8 Camelia Groza             2020-11-25  2739  	}
86c0c196cbe48f8 Camelia Groza             2020-11-25  2740  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2741  	/* Extract the hash stored in the headroom before running XDP */
86c0c196cbe48f8 Camelia Groza             2020-11-25  2742  	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
86c0c196cbe48f8 Camelia Groza             2020-11-25  2743  	    !fman_port_get_hash_result_offset(priv->mac_dev->port[RX],
86c0c196cbe48f8 Camelia Groza             2020-11-25  2744  					      &hash_offset)) {
86c0c196cbe48f8 Camelia Groza             2020-11-25 @2745  		hash = be32_to_cpu(*(u32 *)(vaddr + hash_offset));
86c0c196cbe48f8 Camelia Groza             2020-11-25  2746  		hash_valid = true;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2747  	}
86c0c196cbe48f8 Camelia Groza             2020-11-25  2748  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2749  	if (likely(fd_format == qm_fd_contig)) {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2750  		xdp_act = dpaa_run_xdp(priv, (struct qm_fd *)fd, vaddr,
d57e57d0cd04be5 Camelia Groza             2020-11-25  2751  				       dpaa_fq, &xdp_meta_len);
a1e031ffb422bb8 Camelia Groza             2020-11-25  2752  		np->xdp_act |= xdp_act;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2753  		if (xdp_act != XDP_PASS) {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2754  			percpu_stats->rx_packets++;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2755  			percpu_stats->rx_bytes += qm_fd_get_length(fd);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2756  			return qman_cb_dqrr_consume;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2757  		}
86c0c196cbe48f8 Camelia Groza             2020-11-25  2758  		skb = contig_fd_to_skb(priv, fd);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2759  	} else {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2760  		/* XDP doesn't support S/G frames. Return the fragments to the
86c0c196cbe48f8 Camelia Groza             2020-11-25  2761  		 * buffer pool and release the SGT.
86c0c196cbe48f8 Camelia Groza             2020-11-25  2762  		 */
86c0c196cbe48f8 Camelia Groza             2020-11-25  2763  		if (READ_ONCE(priv->xdp_prog)) {
86c0c196cbe48f8 Camelia Groza             2020-11-25  2764  			WARN_ONCE(1, "S/G frames not supported under XDP\n");
86c0c196cbe48f8 Camelia Groza             2020-11-25  2765  			sgt = vaddr + qm_fd_get_offset(fd);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2766  			dpaa_release_sgt_members(sgt);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2767  			free_pages((unsigned long)vaddr, 0);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2768  			return qman_cb_dqrr_consume;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2769  		}
9ad1a37493338ca Madalin Bucur             2016-11-15  2770  		skb = sg_fd_to_skb(priv, fd);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2771  	}
9ad1a37493338ca Madalin Bucur             2016-11-15  2772  	if (!skb)
9ad1a37493338ca Madalin Bucur             2016-11-15  2773  		return qman_cb_dqrr_consume;
9ad1a37493338ca Madalin Bucur             2016-11-15  2774  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2775  	if (xdp_meta_len)
86c0c196cbe48f8 Camelia Groza             2020-11-25  2776  		skb_metadata_set(skb, xdp_meta_len);
86c0c196cbe48f8 Camelia Groza             2020-11-25  2777  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2778  	/* Set the previously extracted timestamp */
86c0c196cbe48f8 Camelia Groza             2020-11-25  2779  	if (ts_valid) {
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2780  		shhwtstamps = skb_hwtstamps(skb);
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2781  		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2782  		shhwtstamps->hwtstamp = ns_to_ktime(ns);
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2783  	}
4664856e9ca2e50 Yangbo Lu                 2018-06-25  2784  
9ad1a37493338ca Madalin Bucur             2016-11-15  2785  	skb->protocol = eth_type_trans(skb, net_dev);
9ad1a37493338ca Madalin Bucur             2016-11-15  2786  
86c0c196cbe48f8 Camelia Groza             2020-11-25  2787  	/* Set the previously extracted hash */
86c0c196cbe48f8 Camelia Groza             2020-11-25  2788  	if (hash_valid) {
056057e288e7075 Madalin Bucur             2017-08-27  2789  		enum pkt_hash_types type;
056057e288e7075 Madalin Bucur             2017-08-27  2790  
056057e288e7075 Madalin Bucur             2017-08-27  2791  		/* if L4 exists, it was used in the hash generation */
056057e288e7075 Madalin Bucur             2017-08-27  2792  		type = be32_to_cpu(fd->status) & FM_FD_STAT_L4CV ?
056057e288e7075 Madalin Bucur             2017-08-27  2793  			PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3;
86c0c196cbe48f8 Camelia Groza             2020-11-25  2794  		skb_set_hash(skb, hash, type);
056057e288e7075 Madalin Bucur             2017-08-27  2795  	}
056057e288e7075 Madalin Bucur             2017-08-27  2796  
9ad1a37493338ca Madalin Bucur             2016-11-15  2797  	skb_len = skb->len;
9ad1a37493338ca Madalin Bucur             2016-11-15  2798  
e4d1b37c17d000a Camelia Groza             2018-03-14  2799  	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
e4d1b37c17d000a Camelia Groza             2018-03-14  2800  		percpu_stats->rx_dropped++;
9ad1a37493338ca Madalin Bucur             2016-11-15  2801  		return qman_cb_dqrr_consume;
e4d1b37c17d000a Camelia Groza             2018-03-14  2802  	}
9ad1a37493338ca Madalin Bucur             2016-11-15  2803  
9ad1a37493338ca Madalin Bucur             2016-11-15  2804  	percpu_stats->rx_packets++;
9ad1a37493338ca Madalin Bucur             2016-11-15  2805  	percpu_stats->rx_bytes += skb_len;
9ad1a37493338ca Madalin Bucur             2016-11-15  2806  
9ad1a37493338ca Madalin Bucur             2016-11-15  2807  	return qman_cb_dqrr_consume;
9ad1a37493338ca Madalin Bucur             2016-11-15  2808  }
9ad1a37493338ca Madalin Bucur             2016-11-15  2809  

:::::: The code at line 2745 was first introduced by commit
:::::: 86c0c196cbe48f844721783d9162e46bc35c0c5a dpaa_eth: add basic XDP support

:::::: TO: Camelia Groza <camelia.groza@nxp.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

