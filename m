Return-Path: <linux-kernel+bounces-348891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81B98ED36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BE41F22A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356E14B080;
	Thu,  3 Oct 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRVCDWs0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474A13A24A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952210; cv=none; b=aHXtCQlo2Zg0tfBMhbGO/gSZ+8KDNNZjNMtiy7sHlfYHMaloedqnmTvTC/drLyZk8PjGVSVVHs1zCjlO01sX+BGskQlU8e/GNq5MSoHq//uie4PnyUSd8HhBA+K30+4D8/A3sM8dvSu2j7JrqMMcS4cnZ3XlJnRcpBhYUWSoJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952210; c=relaxed/simple;
	bh=RlbnNZT7QpwWDHp3Jjyd+J4JzPD5KxNjzLqkgHPCAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mnxg7oFh3jHrOB3SgK72Y/W5Fjipv1HVxBZiS85DNdFA+cgtRZ5zofF/LGxK0vHEg8LEnAuWRqIeqfixHPU7Bx8ehtZ6oBGmu1b0BFZhBqHsErPfwR8Kwje77BptQzaPjqbRSVon2bFn0GNFqckM33hbtybC5dUhlFZSS1J5kA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRVCDWs0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727952208; x=1759488208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RlbnNZT7QpwWDHp3Jjyd+J4JzPD5KxNjzLqkgHPCAWc=;
  b=gRVCDWs08c+PPBF+P3oCvjAzUZM76PB8KVFrPzFLRWFxFTckGONDqgkH
   YjbAWg72e24iOA5f779nrZPablU2PTXpycnN5JliLpscACwjyBmH4x3ue
   fgdD2XsIgTcZsAbi79w3JY/0GNCmWXhNfkFPhdWPvTGRQ1Mo3UNFdTtjl
   jwGcYF2HIs7X6fuowYZIQIBVCpTpjGH6+eMV3xHcnPs8hXoBxLWeHfTrE
   0rwCnya80iYTLWG92RaGAMlr1hPRN5MM1QPBRt1OyHddGzjB2CGIgLrKo
   hCd9xRE1SBvpiB930oQjuWQlMnvMl/l9VAD/Xe7+ijjmvctmRoMkamtmr
   Q==;
X-CSE-ConnectionGUID: e1m76tRBQ7uphOZAkDbuBA==
X-CSE-MsgGUID: k5aVbmv+TUSdMr4R8AEQig==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44668304"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44668304"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 03:43:27 -0700
X-CSE-ConnectionGUID: uPMDftwhRqy7JvcNr1L+Qg==
X-CSE-MsgGUID: VuEh6EtOQ/2+L9Ik5uEu8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="79156289"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Oct 2024 03:43:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swJIo-0000Ik-18;
	Thu, 03 Oct 2024 10:43:22 +0000
Date: Thu, 3 Oct 2024 18:42:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:1083:5: warning:
 use of bitwise '|' with boolean operands
Message-ID: <202410031828.alwyd4Cj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ec462100ef9142344ddbf86f2c3008b97acddbe
commit: 8fab6a9d72e4fa0b0607b3a8011a909cabae79f7 linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
date:   6 months ago
config: mips-randconfig-r064-20241003 (https://download.01.org/0day-ci/archive/20241003/202410031828.alwyd4Cj-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031828.alwyd4Cj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031828.alwyd4Cj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:816:4: warning: variable 'i' is incremented both in the loop header and in the loop body [-Wfor-loop-analysis]
     816 |                         i++;
         |                         ^
   drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:811:23: note: incremented here
     811 |                 for (i = 0; i < 10; i++) {
         |                                     ^
>> drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:1083:5: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1083 |                         (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1084 |                                            netdev->phydev->supported) |
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                       ||
    1085 |                          linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1086 |                                            netdev->phydev->supported)) != 0;
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/linkmode.h:46:27: note: expanded from macro 'linkmode_test_bit'
      46 | #define linkmode_test_bit       test_bit
         |                                 ^
   include/linux/bitops.h:63:29: note: expanded from macro 'test_bit'
      63 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                         ^
   include/linux/bitops.h:51:2: note: expanded from macro 'bitop'
      51 |         ((__builtin_constant_p(nr) &&                                   \
         |         ^
   drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:1083:5: note: cast one or both operands to int to silence this warning
   include/linux/linkmode.h:46:27: note: expanded from macro 'linkmode_test_bit'
      46 | #define linkmode_test_bit       test_bit
         |                                 ^
   include/linux/bitops.h:63:29: note: expanded from macro 'test_bit'
      63 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                         ^
   include/linux/bitops.h:51:2: note: expanded from macro 'bitop'
      51 |         ((__builtin_constant_p(nr) &&                                   \
         |         ^
   3 warnings generated.


vim +1083 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c

d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   965  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   966  static int octeon_mgmt_open(struct net_device *netdev)
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   967  {
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   968  	struct octeon_mgmt *p = netdev_priv(netdev);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   969  	union cvmx_mixx_ctl mix_ctl;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   970  	union cvmx_agl_gmx_inf_mode agl_gmx_inf_mode;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   971  	union cvmx_mixx_oring1 oring1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   972  	union cvmx_mixx_iring1 iring1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   973  	union cvmx_agl_gmx_rxx_frm_ctl rxx_frm_ctl;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   974  	union cvmx_mixx_irhwm mix_irhwm;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   975  	union cvmx_mixx_orhwm mix_orhwm;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   976  	union cvmx_mixx_intena mix_intena;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   977  	struct sockaddr sa;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   978  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   979  	/* Allocate ring buffers.  */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   980  	p->tx_ring = kzalloc(ring_size_to_bytes(OCTEON_MGMT_TX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   981  			     GFP_KERNEL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   982  	if (!p->tx_ring)
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   983  		return -ENOMEM;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   984  	p->tx_ring_handle =
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   985  		dma_map_single(p->dev, p->tx_ring,
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   986  			       ring_size_to_bytes(OCTEON_MGMT_TX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   987  			       DMA_BIDIRECTIONAL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   988  	p->tx_next = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   989  	p->tx_next_clean = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   990  	p->tx_current_fill = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   991  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   992  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   993  	p->rx_ring = kzalloc(ring_size_to_bytes(OCTEON_MGMT_RX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   994  			     GFP_KERNEL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   995  	if (!p->rx_ring)
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   996  		goto err_nomem;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   997  	p->rx_ring_handle =
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   998  		dma_map_single(p->dev, p->rx_ring,
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14   999  			       ring_size_to_bytes(OCTEON_MGMT_RX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1000  			       DMA_BIDIRECTIONAL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1001  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1002  	p->rx_next = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1003  	p->rx_next_fill = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1004  	p->rx_current_fill = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1005  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1006  	octeon_mgmt_reset_hw(p);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1007  
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1008  	mix_ctl.u64 = cvmx_read_csr(p->mix + MIX_CTL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1009  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1010  	/* Bring it out of reset if needed. */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1011  	if (mix_ctl.s.reset) {
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1012  		mix_ctl.s.reset = 0;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1013  		cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1014  		do {
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1015  			mix_ctl.u64 = cvmx_read_csr(p->mix + MIX_CTL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1016  		} while (mix_ctl.s.reset);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1017  	}
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1018  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1019  	if (OCTEON_IS_MODEL(OCTEON_CN5XXX)) {
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1020  		agl_gmx_inf_mode.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1021  		agl_gmx_inf_mode.s.en = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1022  		cvmx_write_csr(CVMX_AGL_GMX_INF_MODE, agl_gmx_inf_mode.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1023  	}
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1024  	if (OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1025  		|| OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X)) {
a0ce9b1e899494 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1026  		/* Force compensation values, as they are not
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1027  		 * determined properly by HW
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1028  		 */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1029  		union cvmx_agl_gmx_drv_ctl drv_ctl;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1030  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1031  		drv_ctl.u64 = cvmx_read_csr(CVMX_AGL_GMX_DRV_CTL);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1032  		if (p->port) {
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1033  			drv_ctl.s.byp_en1 = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1034  			drv_ctl.s.nctl1 = 6;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1035  			drv_ctl.s.pctl1 = 6;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1036  		} else {
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1037  			drv_ctl.s.byp_en = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1038  			drv_ctl.s.nctl = 6;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1039  			drv_ctl.s.pctl = 6;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1040  		}
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1041  		cvmx_write_csr(CVMX_AGL_GMX_DRV_CTL, drv_ctl.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1042  	}
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1043  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1044  	oring1.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1045  	oring1.s.obase = p->tx_ring_handle >> 3;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1046  	oring1.s.osize = OCTEON_MGMT_TX_RING_SIZE;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1047  	cvmx_write_csr(p->mix + MIX_ORING1, oring1.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1048  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1049  	iring1.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1050  	iring1.s.ibase = p->rx_ring_handle >> 3;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1051  	iring1.s.isize = OCTEON_MGMT_RX_RING_SIZE;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1052  	cvmx_write_csr(p->mix + MIX_IRING1, iring1.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1053  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1054  	memcpy(sa.sa_data, netdev->dev_addr, ETH_ALEN);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1055  	octeon_mgmt_set_mac_address(netdev, &sa);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1056  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1057  	octeon_mgmt_change_mtu(netdev, netdev->mtu);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1058  
a0ce9b1e899494 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1059  	/* Enable the port HW. Packets are not allowed until
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1060  	 * cvmx_mgmt_port_enable() is called.
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1061  	 */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1062  	mix_ctl.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1063  	mix_ctl.s.crc_strip = 1;    /* Strip the ending CRC */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1064  	mix_ctl.s.en = 1;           /* Enable the port */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1065  	mix_ctl.s.nbtarb = 0;       /* Arbitration mode */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1066  	/* MII CB-request FIFO programmable high watermark */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1067  	mix_ctl.s.mrq_hwm = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1068  #ifdef __LITTLE_ENDIAN
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1069  	mix_ctl.s.lendian = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1070  #endif
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1071  	cvmx_write_csr(p->mix + MIX_CTL, mix_ctl.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1072  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1073  	/* Read the PHY to find the mode of the interface. */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1074  	if (octeon_mgmt_init_phy(netdev)) {
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1075  		dev_err(p->dev, "Cannot initialize PHY on MIX%d.\n", p->port);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1076  		goto err_noirq;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1077  	}
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1078  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1079  	/* Set the mode of the interface, RGMII/MII. */
9e8e6e880d9346 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Philippe Reynes 2016-07-02  1080  	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) && netdev->phydev) {
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1081  		union cvmx_agl_prtx_ctl agl_prtx_ctl;
3c1bcc8614db10 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Andrew Lunn     2018-11-10  1082  		int rgmii_mode =
3c1bcc8614db10 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Andrew Lunn     2018-11-10 @1083  			(linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
3c1bcc8614db10 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Andrew Lunn     2018-11-10  1084  					   netdev->phydev->supported) |
3c1bcc8614db10 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Andrew Lunn     2018-11-10  1085  			 linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
3c1bcc8614db10 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Andrew Lunn     2018-11-10  1086  					   netdev->phydev->supported)) != 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1087  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1088  		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1089  		agl_prtx_ctl.s.mode = rgmii_mode ? 0 : 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1090  		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1091  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1092  		/* MII clocks counts are based on the 125Mhz
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1093  		 * reference, which has an 8nS period. So our delays
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1094  		 * need to be multiplied by this factor.
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1095  		 */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1096  #define NS_PER_PHY_CLK 8
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1097  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1098  		/* Take the DLL and clock tree out of reset */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1099  		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1100  		agl_prtx_ctl.s.clkrst = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1101  		if (rgmii_mode) {
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1102  			agl_prtx_ctl.s.dllrst = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1103  			agl_prtx_ctl.s.clktx_byp = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1104  		}
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1105  		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1106  		cvmx_read_csr(p->agl_prt_ctl); /* Force write out before wait */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1107  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1108  		/* Wait for the DLL to lock. External 125 MHz
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1109  		 * reference clock must be stable at this point.
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1110  		 */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1111  		ndelay(256 * NS_PER_PHY_CLK);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1112  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1113  		/* Enable the interface */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1114  		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1115  		agl_prtx_ctl.s.enable = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1116  		cvmx_write_csr(p->agl_prt_ctl, agl_prtx_ctl.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1117  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1118  		/* Read the value back to force the previous write */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1119  		agl_prtx_ctl.u64 = cvmx_read_csr(p->agl_prt_ctl);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1120  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1121  		/* Enable the compensation controller */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1122  		agl_prtx_ctl.s.comp = 1;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1123  		agl_prtx_ctl.s.drv_byp = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1124  		cvmx_write_csr(p->agl_prt_ctl,	agl_prtx_ctl.u64);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1125  		/* Force write out before wait. */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1126  		cvmx_read_csr(p->agl_prt_ctl);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1127  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1128  		/* For compensation state to lock. */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1129  		ndelay(1040 * NS_PER_PHY_CLK);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1130  
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1131  		/* Default Interframe Gaps are too small.  Recommended
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1132  		 * workaround is.
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1133  		 *
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1134  		 * AGL_GMX_TX_IFG[IFG1]=14
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1135  		 * AGL_GMX_TX_IFG[IFG2]=10
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1136  		 */
906996d6eb8fbd drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2013-06-19  1137  		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0xae);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1138  	}
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1139  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1140  	octeon_mgmt_rx_fill_ring(netdev);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1141  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1142  	/* Clear statistics. */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1143  	/* Clear on read. */
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1144  	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_CTL, 1);
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1145  	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_PKTS_DRP, 0);
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1146  	cvmx_write_csr(p->agl + AGL_GMX_RX_STATS_PKTS_BAD, 0);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1147  
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1148  	cvmx_write_csr(p->agl + AGL_GMX_TX_STATS_CTL, 1);
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1149  	cvmx_write_csr(p->agl + AGL_GMX_TX_STAT0, 0);
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1150  	cvmx_write_csr(p->agl + AGL_GMX_TX_STAT1, 0);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1151  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1152  	/* Clear any pending interrupts */
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1153  	cvmx_write_csr(p->mix + MIX_ISR, cvmx_read_csr(p->mix + MIX_ISR));
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1154  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1155  	if (request_irq(p->irq, octeon_mgmt_interrupt, 0, netdev->name,
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1156  			netdev)) {
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1157  		dev_err(p->dev, "request_irq(%d) failed.\n", p->irq);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1158  		goto err_noirq;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1159  	}
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1160  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1161  	/* Interrupt every single RX packet */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1162  	mix_irhwm.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1163  	mix_irhwm.s.irhwm = 0;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1164  	cvmx_write_csr(p->mix + MIX_IRHWM, mix_irhwm.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1165  
b635e06993076c drivers/net/octeon/octeon_mgmt.c                 David Daney     2010-05-05  1166  	/* Interrupt when we have 1 or more packets to clean.  */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1167  	mix_orhwm.u64 = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1168  	mix_orhwm.s.orhwm = 0;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1169  	cvmx_write_csr(p->mix + MIX_ORHWM, mix_orhwm.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1170  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1171  	/* Enable receive and transmit interrupts */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1172  	mix_intena.u64 = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1173  	mix_intena.s.ithena = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1174  	mix_intena.s.othena = 1;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1175  	cvmx_write_csr(p->mix + MIX_INTENA, mix_intena.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1176  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1177  	/* Enable packet I/O. */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1178  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1179  	rxx_frm_ctl.u64 = 0;
3d305850261dfb drivers/net/ethernet/octeon/octeon_mgmt.c        Chad Reese      2012-08-21  1180  	rxx_frm_ctl.s.ptp_mode = p->has_rx_tstamp ? 1 : 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1181  	rxx_frm_ctl.s.pre_align = 1;
a0ce9b1e899494 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1182  	/* When set, disables the length check for non-min sized pkts
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1183  	 * with padding in the client data.
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1184  	 */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1185  	rxx_frm_ctl.s.pad_len = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1186  	/* When set, disables the length check for VLAN pkts */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1187  	rxx_frm_ctl.s.vlan_len = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1188  	/* When set, PREAMBLE checking is  less strict */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1189  	rxx_frm_ctl.s.pre_free = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1190  	/* Control Pause Frames can match station SMAC */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1191  	rxx_frm_ctl.s.ctl_smac = 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1192  	/* Control Pause Frames can match globally assign Multicast address */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1193  	rxx_frm_ctl.s.ctl_mcst = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1194  	/* Forward pause information to TX block */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1195  	rxx_frm_ctl.s.ctl_bck = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1196  	/* Drop Control Pause Frames */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1197  	rxx_frm_ctl.s.ctl_drp = 1;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1198  	/* Strip off the preamble */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1199  	rxx_frm_ctl.s.pre_strp = 1;
a0ce9b1e899494 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1200  	/* This port is configured to send PREAMBLE+SFD to begin every
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1201  	 * frame.  GMX checks that the PREAMBLE is sent correctly.
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1202  	 */
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1203  	rxx_frm_ctl.s.pre_chk = 1;
368bec0d4a84f7 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-07-05  1204  	cvmx_write_csr(p->agl + AGL_GMX_RX_FRM_CTL, rxx_frm_ctl.u64);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1205  
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1206  	/* Configure the port duplex, speed and enables */
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1207  	octeon_mgmt_disable_link(p);
9e8e6e880d9346 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Philippe Reynes 2016-07-02  1208  	if (netdev->phydev)
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1209  		octeon_mgmt_update_link(p);
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1210  	octeon_mgmt_enable_link(p);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1211  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1212  	p->last_link = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1213  	p->last_speed = 0;
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1214  	/* PHY is not present in simulator. The carrier is enabled
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1215  	 * while initializing the phy for simulator, leave it enabled.
eeae05aa216957 drivers/net/ethernet/octeon/octeon_mgmt.c        David Daney     2012-08-21  1216  	 */
9e8e6e880d9346 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Philippe Reynes 2016-07-02  1217  	if (netdev->phydev) {
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1218  		netif_carrier_off(netdev);
4663ff60257aec drivers/net/ethernet/cavium/octeon/octeon_mgmt.c Ivan Khoronzhuk 2020-09-25  1219  		phy_start(netdev->phydev);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1220  	}
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1221  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1222  	netif_wake_queue(netdev);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1223  	napi_enable(&p->napi);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1224  
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1225  	return 0;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1226  err_noirq:
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1227  	octeon_mgmt_reset_hw(p);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1228  	dma_unmap_single(p->dev, p->rx_ring_handle,
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1229  			 ring_size_to_bytes(OCTEON_MGMT_RX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1230  			 DMA_BIDIRECTIONAL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1231  	kfree(p->rx_ring);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1232  err_nomem:
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1233  	dma_unmap_single(p->dev, p->tx_ring_handle,
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1234  			 ring_size_to_bytes(OCTEON_MGMT_TX_RING_SIZE),
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1235  			 DMA_BIDIRECTIONAL);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1236  	kfree(p->tx_ring);
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1237  	return -ENOMEM;
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1238  }
d6aa60a10b2f50 drivers/net/octeon/octeon_mgmt.c                 David Daney     2009-10-14  1239  

:::::: The code at line 1083 was first introduced by commit
:::::: 3c1bcc8614db10803f1f57ef0295363917448cb2 net: ethernet: Convert phydev advertize and supported from u32 to link mode

:::::: TO: Andrew Lunn <andrew@lunn.ch>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

