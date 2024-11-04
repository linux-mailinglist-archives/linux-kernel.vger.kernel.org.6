Return-Path: <linux-kernel+bounces-394428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2E9BAF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6464DB223B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3311A7240;
	Mon,  4 Nov 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFBG946F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FF187FEC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711103; cv=none; b=pURTEkIBvmeCgtzOGXpmzL6UQ6WTL2UJ/ZUZERm6yp0O933B3hlf//edOEkNgrGY8z0R+u8bWuCmeLMuUqlJ9rEe4HyZs9CD1BD+pkoXKGlem3dLyMaImARORCldvF2y+n7wIephRrdvF5aeQ4U31sTTWkhMUsbwhdFNULV/H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711103; c=relaxed/simple;
	bh=e3+aseUTrwh9xazULRXaVJomMZbtJ7XHX9eWoKDhgR0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=efNGRYa3kAoSy8IQAg2kHnrI9oFmKq/WtvTNClHmnUrUgM2gcw4TBCjQP/8RPhFr317r0PJ9vDDdq/JPFCNfHw2bUuFzmZjHFldNsb+lLSgowN+RL/vMtRtUFFXnEdki3WNYh8IiSb7MfiaKmI4FLrtd4ro83edBCFmlvrJoSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFBG946F; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730711101; x=1762247101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e3+aseUTrwh9xazULRXaVJomMZbtJ7XHX9eWoKDhgR0=;
  b=SFBG946FG6ndcJ/YwfX/o2/ejq68JHJLBiCryiAbZPSZ50RghSjintjp
   hwZXUnzp6Y5VzSTC4CrRk8ryjXAc7PmpLAiYZEq4ZG86Xj1sRQaWKKioN
   NtaRdrgihfZ2ZBI6566CemP2h8rii73ypK0nKunCBgJK4i/CyodkW7yjt
   LmC58NAvasht2Otqstkm53oZCzBoRb2j0YB3w9pHDtA/OD0/WL528ZBsr
   7R9SQnxPr2wCPjc+4WkTphI9q3Mg7fGgB9m9AhZaVS16hq5FqnZUxfRUK
   9nEDSHAyoOFHMYm4kjuX9c1sJ2DKxIRet3Nbu2OjoSJmG1pqrIr7ZGMzG
   w==;
X-CSE-ConnectionGUID: NaxX9C76SUe+H+MIl1HOXA==
X-CSE-MsgGUID: Gi9j+H+4S9ON6AuI6sUFYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30250600"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30250600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:05:01 -0800
X-CSE-ConnectionGUID: s2l0tw1nSS2Th2aUq3LHRg==
X-CSE-MsgGUID: g7gA9q34TR6jVV7PBm/vjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="121053884"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2024 01:04:56 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7t16-000kfl-0m;
	Mon, 04 Nov 2024 09:04:56 +0000
Date: Mon, 4 Nov 2024 17:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241028-sa-with-flex 26/26]
 net/ipv4/arp.c:1188:34: error: invalid application of 'sizeof' to an
 incomplete type 'char[]'
Message-ID: <202411041638.igTDF2vU-lkp@intel.com>
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
commit: db9bcb6db903744311cc25148aa4a5f88fd5a9d4 [26/26] uapi: socket: Introduce struct sockaddr_legacy
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241104/202411041638.igTDF2vU-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411041638.igTDF2vU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041638.igTDF2vU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/ipv4/arp.c:83:
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
>> net/ipv4/arp.c:1188:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
         |                                         ^~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:41: note: expanded from macro 'min'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                                               ^
   include/linux/minmax.h:105:28: note: expanded from macro '__careful_cmp'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                   ^
   include/linux/minmax.h:99:42: note: expanded from macro '__careful_cmp_once'
      99 |         __auto_type ux = (x); __auto_type uy = (y);     \
         |                                                 ^
   include/linux/fortify-string.h:678:53: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                                                     ^
   include/linux/fortify-string.h:621:41: note: expanded from macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
>> net/ipv4/arp.c:1188:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
         |                                         ^~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:41: note: expanded from macro 'min'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                                               ^
   include/linux/minmax.h:105:28: note: expanded from macro '__careful_cmp'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                   ^
   include/linux/minmax.h:100:33: note: expanded from macro '__careful_cmp_once'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |                                        ^
   note: (skipping 8 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/fortify-string.h:678:53: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                                                     ^
   include/linux/fortify-string.h:621:41: note: expanded from macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
>> net/ipv4/arp.c:1188:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    1188 |                min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
         |                                         ^~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:41: note: expanded from macro 'min'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                                               ^
   include/linux/minmax.h:105:28: note: expanded from macro '__careful_cmp'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |                                   ^
   include/linux/minmax.h:100:33: note: expanded from macro '__careful_cmp_once'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |                                        ^
   note: (skipping 8 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/fortify-string.h:678:53: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                                                     ^
   include/linux/fortify-string.h:621:41: note: expanded from macro '__fortify_memcpy_chk'
     621 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   4 warnings and 3 errors generated.
--
   In file included from net/packet/af_packet.c:51:
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
>> net/packet/af_packet.c:3653:34: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    3653 |         memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:512:52: note: expanded from macro 'memset'
     512 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                                                    ^
   include/linux/fortify-string.h:502:35: note: expanded from macro '__fortify_memset_chk'
     502 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   net/packet/af_packet.c:3657:44: error: invalid application of 'sizeof' to an incomplete type 'char[]'
    3657 |                 strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
         |                                                          ^~~~~~~~~~~~~~~~
   include/linux/string.h:113:60: note: expanded from macro 'strscpy'
     113 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |                                                                   ^~~~~~~~~~~
   include/linux/string.h:82:26: note: expanded from macro '__strscpy1'
      82 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |                                 ^~~~
>> net/packet/af_packet.c:4702:11: error: incompatible function pointer types initializing 'int (*)(struct socket *, struct sockaddr *, int)' with an expression of type 'int (struct socket *, struct sockaddr_legacy *, int)' [-Wincompatible-function-pointer-types]
    4702 |         .bind =         packet_bind_spkt,
         |                         ^~~~~~~~~~~~~~~~
   4 warnings and 3 errors generated.
--
   In file included from drivers/net/ethernet/marvell/sky2.c:18:
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
>> drivers/net/ethernet/marvell/sky2.c:4680:3: warning: 'memcpy' will always overflow; destination buffer has size 0, but size argument is 6 [-Wfortify-source]
    4680 |                 memcpy(sa.sa_data, dev->dev_addr, ETH_ALEN);
         |                 ^
   include/linux/fortify-string.h:678:26: note: expanded from macro 'memcpy'
     678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^
   include/linux/fortify-string.h:633:2: note: expanded from macro '__fortify_memcpy_chk'
     633 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^
   <scratch space>:148:1: note: expanded from here
     148 | __underlying_memcpy
         | ^
   include/linux/fortify-string.h:114:29: note: expanded from macro '__underlying_memcpy'
     114 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:571:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     571 |                         __write_overflow_field(p_size_field, size);
         |                         ^
   6 warnings generated.


vim +1188 net/ipv4/arp.c

  1159	
  1160	/*
  1161	 *	Get an ARP cache entry.
  1162	 */
  1163	
  1164	static int arp_req_get(struct net *net, struct arpreq *r)
  1165	{
  1166		__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
  1167		struct neighbour *neigh;
  1168		struct net_device *dev;
  1169	
  1170		if (!r->arp_dev[0])
  1171			return -ENODEV;
  1172	
  1173		dev = arp_req_dev_by_name(net, r, true);
  1174		if (IS_ERR(dev))
  1175			return PTR_ERR(dev);
  1176	
  1177		neigh = neigh_lookup(&arp_tbl, &ip, dev);
  1178		if (!neigh)
  1179			return -ENXIO;
  1180	
  1181		if (READ_ONCE(neigh->nud_state) & NUD_NOARP) {
  1182			neigh_release(neigh);
  1183			return -ENXIO;
  1184		}
  1185	
  1186		read_lock_bh(&neigh->lock);
  1187		memcpy(r->arp_ha.sa_data, neigh->ha,
> 1188		       min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
  1189		r->arp_flags = arp_state_to_flags(neigh);
  1190		read_unlock_bh(&neigh->lock);
  1191	
  1192		neigh_release(neigh);
  1193	
  1194		r->arp_ha.sa_family = dev->type;
  1195		netdev_copy_name(dev, r->arp_dev);
  1196	
  1197		return 0;
  1198	}
  1199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

