Return-Path: <linux-kernel+bounces-394215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EE9BAC05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F250E1F21B71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CB167296;
	Mon,  4 Nov 2024 05:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/tIxQWk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87DEC4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730697526; cv=none; b=kqkMlcrdOdlrJJxVG3aN2z51sICKq/3+RMnN4q21PkaOy4fw52KiqUxn7SZvMCAbO0OSKuX/eTFatmADSAOVVWZrObx06a7exQ/Edmvx/HZvrluDD9hTA+7+KZmobxxOfaaMHGTHIK/Nn1wtZbtLvNdHMNedr9sLYqDwz2fW5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730697526; c=relaxed/simple;
	bh=CSSD5xLWTwwJjtnZ2lvwmNyKn4kxZKte3Mtk8l63q1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBkE83buWBJI6hY6fmCeyCqQ40ykSZCH9/T9ADebcTNtJdG/KKYrdquUBMR8aYNC4Of+dmNfVYtcVEZbR4hNyw/D+oUL6o5X8TESoFRjgK+ZiNn/pu13tLSDZFOu48jcDxc/b3vpno5Z9eN4bz4Z1MSTk77TcwVMrGiDGAqFWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/tIxQWk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730697524; x=1762233524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CSSD5xLWTwwJjtnZ2lvwmNyKn4kxZKte3Mtk8l63q1U=;
  b=h/tIxQWkOedo5NaCijvy9FwTRJiyiNR6OiqOMngCtvpF3Vd45rpzEwPT
   re0/T0dijHE2vkiVW7Ff3eI8nC3OLnGxg078LYEGsIY3EUMMHCWEwqUBI
   L1CiH7ideub9qqgQGAoZAXThYaKS4sc9xYNgn8HBTJipWk6WSSYLiPNWO
   +SpaJVWvhWjZqtsZ41Sa1JMbuIHFYXqXq3tF9cuStvajuQUGkqqQB15HW
   3Bch+3nXfbdra97tuT+QnHvfyinN1SIdnmbc7gtN/OrRwhrgGVR3ExemA
   g+N4JyOZUxSD8yotjpAHRaQ4sf9W/rrMX0TCw496B7aZMGzgcOobBGYUD
   g==;
X-CSE-ConnectionGUID: 5jET/P1KRvSAcxfjnVD9dA==
X-CSE-MsgGUID: LT6luj29RfqSjJwy8m7Nvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="33218307"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="33218307"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 21:18:43 -0800
X-CSE-ConnectionGUID: u1AVUCJ6QNq6qWmuDgoZeg==
X-CSE-MsgGUID: Soa/Jwx0SmKmk/sktE1EEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88131171"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2024 21:18:42 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7pU7-000kU7-2W;
	Mon, 04 Nov 2024 05:18:39 +0000
Date: Mon, 4 Nov 2024 13:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028-sa-with-flex 26/26]
 net/ncsi/ncsi-rsp.c:649:2: warning: 'memcpy' will always overflow;
 destination buffer has size 0, but size argument is 6
Message-ID: <202411041346.VYUgLq9I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241028-sa-with-flex
head:   0e7c24c783de39e1f965e8c23e96a7de29dfbfca
commit: 0e7c24c783de39e1f965e8c23e96a7de29dfbfca [26/26] uapi: socket: Introduce struct sockaddr_legacy
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241104/202411041346.VYUgLq9I-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411041346.VYUgLq9I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041346.VYUgLq9I-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ncsi/ncsi-rsp.c:9:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/ncsi/ncsi-rsp.c:649:2: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
     649 |         memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
         |         ^
   include/linux/fortify-string.h:678:26: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^
   include/linux/fortify-string.h:633:2: note: expanded from macro '__fortify_memcpy_chk'
     633 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^
   <scratch space>:23:1: note: expanded from here
      23 | __underlying_memcpy
         | ^
   include/linux/fortify-string.h:114:29: note: expanded from macro '__underlying_memcpy'
     114 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   net/ncsi/ncsi-rsp.c:1119:3: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    1119 |                 memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
         |                 ^
   include/linux/fortify-string.h:678:26: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^
   include/linux/fortify-string.h:633:2: note: expanded from macro '__fortify_memcpy_chk'
     633 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^
   <scratch space>:120:1: note: expanded from here
     120 | __underlying_memcpy
         | ^
   include/linux/fortify-string.h:114:29: note: expanded from macro '__underlying_memcpy'
     114 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     571 |                         __write_overflow_field(p_size_field, size);
         |                         ^
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
   10 warnings generated.
--
   In file included from drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c:53:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c:148:3: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
     148 |                 memcpy(saddr.sa_data, info->vport.base_mac_addr,
         |                 ^
   include/linux/fortify-string.h:678:26: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^
   include/linux/fortify-string.h:633:2: note: expanded from macro '__fortify_memcpy_chk'
     633 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^
   <scratch space>:34:1: note: expanded from here
      34 | __underlying_memcpy
         | ^
   include/linux/fortify-string.h:114:29: note: expanded from macro '__underlying_memcpy'
     114 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     571 |                         __write_overflow_field(p_size_field, size);
         |                         ^
   6 warnings generated.
--
   In file included from drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:12:
   In file included from include/linux/of_mdio.h:12:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:442:2: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
     442 |         memcpy(old_addr.sa_data, net_dev->dev_addr,  ETH_ALEN);
         |         ^
   include/linux/fortify-string.h:678:26: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^
   include/linux/fortify-string.h:633:2: note: expanded from macro '__fortify_memcpy_chk'
     633 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^
   <scratch space>:219:1: note: expanded from here
     219 | __underlying_memcpy
         | ^
   include/linux/fortify-string.h:114:29: note: expanded from macro '__underlying_memcpy'
     114 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     571 |                         __write_overflow_field(p_size_field, size);
         |                         ^
   6 warnings generated.


vim +/memcpy +649 net/ncsi/ncsi-rsp.c

138635cc27c973 Gavin Shan     2016-07-19  626  
74b449b98dccdf Ivan Mikhaylov 2023-06-07  627  /* Response handler for Get Mac Address command */
74b449b98dccdf Ivan Mikhaylov 2023-06-07  628  static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
16e8c4ca21a238 Vijay Khemka   2018-11-26  629  {
16e8c4ca21a238 Vijay Khemka   2018-11-26  630  	struct ncsi_dev_priv *ndp = nr->ndp;
16e8c4ca21a238 Vijay Khemka   2018-11-26  631  	struct net_device *ndev = ndp->ndev.dev;
16e8c4ca21a238 Vijay Khemka   2018-11-26  632  	struct ncsi_rsp_oem_pkt *rsp;
16e8c4ca21a238 Vijay Khemka   2018-11-26  633  	struct sockaddr saddr;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  634  	u32 mac_addr_off = 0;
16e8c4ca21a238 Vijay Khemka   2018-11-26  635  	int ret = 0;
16e8c4ca21a238 Vijay Khemka   2018-11-26  636  
16e8c4ca21a238 Vijay Khemka   2018-11-26  637  	/* Get the response header */
16e8c4ca21a238 Vijay Khemka   2018-11-26  638  	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
16e8c4ca21a238 Vijay Khemka   2018-11-26  639  
16e8c4ca21a238 Vijay Khemka   2018-11-26  640  	saddr.sa_family = ndev->type;
16e8c4ca21a238 Vijay Khemka   2018-11-26  641  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  642  	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
74b449b98dccdf Ivan Mikhaylov 2023-06-07  643  		mac_addr_off = BCM_MAC_ADDR_OFFSET;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  644  	else if (mfr_id == NCSI_OEM_MFR_MLX_ID)
74b449b98dccdf Ivan Mikhaylov 2023-06-07  645  		mac_addr_off = MLX_MAC_ADDR_OFFSET;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  646  	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
74b449b98dccdf Ivan Mikhaylov 2023-06-07  647  		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  648  
74b449b98dccdf Ivan Mikhaylov 2023-06-07 @649  	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
74b449b98dccdf Ivan Mikhaylov 2023-06-07  650  	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
74b449b98dccdf Ivan Mikhaylov 2023-06-07  651  		eth_addr_inc((u8 *)saddr.sa_data);
74b449b98dccdf Ivan Mikhaylov 2023-06-07  652  	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
74b449b98dccdf Ivan Mikhaylov 2023-06-07  653  		return -ENXIO;
74b449b98dccdf Ivan Mikhaylov 2023-06-07  654  
9e860947d8d7a1 Vijay Khemka   2019-12-27  655  	/* Set the flag for GMA command which should only be called once */
9e860947d8d7a1 Vijay Khemka   2019-12-27  656  	ndp->gma_flag = 1;
9e860947d8d7a1 Vijay Khemka   2019-12-27  657  
790071347a0a1a Ivan Mikhaylov 2023-06-07  658  	rtnl_lock();
790071347a0a1a Ivan Mikhaylov 2023-06-07  659  	ret = dev_set_mac_address(ndev, &saddr, NULL);
790071347a0a1a Ivan Mikhaylov 2023-06-07  660  	rtnl_unlock();
16e8c4ca21a238 Vijay Khemka   2018-11-26  661  	if (ret < 0)
16e8c4ca21a238 Vijay Khemka   2018-11-26  662  		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
16e8c4ca21a238 Vijay Khemka   2018-11-26  663  
16e8c4ca21a238 Vijay Khemka   2018-11-26  664  	return ret;
16e8c4ca21a238 Vijay Khemka   2018-11-26  665  }
16e8c4ca21a238 Vijay Khemka   2018-11-26  666  

:::::: The code at line 649 was first introduced by commit
:::::: 74b449b98dccdf24288d562f9d207fa066da793d net/ncsi: make one oem_gma function for all mfr id

:::::: TO: Ivan Mikhaylov <fr0st61te@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

