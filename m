Return-Path: <linux-kernel+bounces-426990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD589DFAF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAC162F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDFC1F8F1E;
	Mon,  2 Dec 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cl9vPmC3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5771F8EE7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123520; cv=none; b=WoUhe8T8+SDDtsDaTYaZnpUXXLcEGJli1eJz5Hvab2rpJxecJQbM+zm+6O5Z17GOq1WaOfO7WN3QBgsfEA/DpmO19zoorzLEsYBYo2qcpGpNQmOp9fF3KLPyvySWLAEhfYDKxnE+Y+muwwP7sD3rlPU8g6qp9GvQHK0yy5NGpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123520; c=relaxed/simple;
	bh=apAPBvnlOUu9jB7BXUQK785uKvrqpJoGfXp840wWtAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N/HxnsZRscvZin1XZXBaENofhRoTWm3FW+xDgKsR8s3ztrlU6c5FMx7Kspdm2eDIE92hfgIP9DdeU1tbOxsAZMTnjSl8HqV0aF2pXYQGmSGRGIzQCgL4N94hZTGzgzqOZypiOZ4WRg/pojEgaI/o/3mENoNnQjvSw4s8HnEqs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cl9vPmC3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733123519; x=1764659519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=apAPBvnlOUu9jB7BXUQK785uKvrqpJoGfXp840wWtAI=;
  b=Cl9vPmC3Ip2fBay+x78DVm1tI1ve9dAidThciLxlfAJEVqKe6aIi878t
   xlBEkX8XAmQgbDkYq44epYI28OWdWLYEf2SNazel0o8o3qXRhFmdVbBEL
   6+vhSZMhNkLddHWKrNQLfbGyW9aRrnLrJIESm/O08Ktu9TPKm8q3HeMDw
   w7yK8nqjW4ThzRky/vWmIroxHCU8ZJMK1oXCzKiK2ZFHhtkZPubN3W2gF
   EByRciq0oR6tIufZvSkLzE/qUwGhAMBc67EUixJYJXsXGFH/rVUa//BFO
   LpYEAZZrwxpNbP7LFMLFClvQ2D4EFg8Fm3l5PZ9YF0LyBkVbFfdFY6KY6
   w==;
X-CSE-ConnectionGUID: k9QtZRGJSBSTAtzO780ZAA==
X-CSE-MsgGUID: rpHDEocYQ4yzf16Q6YQP1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="33197277"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="33197277"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 23:11:58 -0800
X-CSE-ConnectionGUID: HKs8UtPFRBOAl1P7eB0/SA==
X-CSE-MsgGUID: nFDOjCpiQjGZASCys1pQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93199542"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Dec 2024 23:11:56 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI0b3-0002AK-2a;
	Mon, 02 Dec 2024 07:11:53 +0000
Date: Mon, 2 Dec 2024 15:11:08 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202412021536.QdX5fFb7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lorenzo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
commit: a3c62a042237d1adeb0290dcb768e17edd6dcd25 net: mtk_eth: add COMPILE_TEST support
date:   3 years ago
config: nios2-randconfig-r121-20241116 (https://download.01.org/0day-ci/archive/20241202/202412021536.QdX5fFb7-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241202/202412021536.QdX5fFb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412021536.QdX5fFb7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [usertype] check @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse:     expected restricted __sum16 [usertype] check
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1113:45: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1801:22: sparse:     got restricted __be32 [usertype] ip
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip4dst @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse:     got restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1846:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4dst @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse:     expected restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1903:38: sparse:     got unsigned int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4src @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse:     expected restricted __be32 [usertype] ip4src
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1907:38: sparse:     got unsigned int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] psrc @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse:     expected restricted __be16 [usertype] psrc
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1909:36: sparse:     got int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] pdst @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse:     expected restricted __be16 [usertype] pdst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1911:36: sparse:     got int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:652:9: sparse: sparse: context imbalance in 'mtk_stats_update' - different lock contexts for basic block
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:677:50: sparse: sparse: context imbalance in 'mtk_get_stats64' - wrong count at exit
   drivers/net/ethernet/mediatek/mtk_eth_soc.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini

vim +1846 drivers/net/ethernet/mediatek/mtk_eth_soc.c

7aab747e5563ec Nelson Chang 2016-09-17  1831  
7aab747e5563ec Nelson Chang 2016-09-17  1832  static int mtk_hwlro_add_ipaddr(struct net_device *dev,
7aab747e5563ec Nelson Chang 2016-09-17  1833  				struct ethtool_rxnfc *cmd)
7aab747e5563ec Nelson Chang 2016-09-17  1834  {
7aab747e5563ec Nelson Chang 2016-09-17  1835  	struct ethtool_rx_flow_spec *fsp =
7aab747e5563ec Nelson Chang 2016-09-17  1836  		(struct ethtool_rx_flow_spec *)&cmd->fs;
7aab747e5563ec Nelson Chang 2016-09-17  1837  	struct mtk_mac *mac = netdev_priv(dev);
7aab747e5563ec Nelson Chang 2016-09-17  1838  	struct mtk_eth *eth = mac->hw;
7aab747e5563ec Nelson Chang 2016-09-17  1839  	int hwlro_idx;
7aab747e5563ec Nelson Chang 2016-09-17  1840  
7aab747e5563ec Nelson Chang 2016-09-17  1841  	if ((fsp->flow_type != TCP_V4_FLOW) ||
7aab747e5563ec Nelson Chang 2016-09-17  1842  	    (!fsp->h_u.tcp_ip4_spec.ip4dst) ||
7aab747e5563ec Nelson Chang 2016-09-17  1843  	    (fsp->location > 1))
7aab747e5563ec Nelson Chang 2016-09-17  1844  		return -EINVAL;
7aab747e5563ec Nelson Chang 2016-09-17  1845  
7aab747e5563ec Nelson Chang 2016-09-17 @1846  	mac->hwlro_ip[fsp->location] = htonl(fsp->h_u.tcp_ip4_spec.ip4dst);
7aab747e5563ec Nelson Chang 2016-09-17  1847  	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
7aab747e5563ec Nelson Chang 2016-09-17  1848  
7aab747e5563ec Nelson Chang 2016-09-17  1849  	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
7aab747e5563ec Nelson Chang 2016-09-17  1850  
7aab747e5563ec Nelson Chang 2016-09-17  1851  	mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[fsp->location]);
7aab747e5563ec Nelson Chang 2016-09-17  1852  
7aab747e5563ec Nelson Chang 2016-09-17  1853  	return 0;
7aab747e5563ec Nelson Chang 2016-09-17  1854  }
7aab747e5563ec Nelson Chang 2016-09-17  1855  

:::::: The code at line 1846 was first introduced by commit
:::::: 7aab747e5563ecbc9f3cb64ddea13fe7b9fee2bd net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO

:::::: TO: Nelson Chang <nelson.chang@mediatek.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

