Return-Path: <linux-kernel+bounces-554824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B145DA59FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A5818908F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBD522AE7C;
	Mon, 10 Mar 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBKjG7LX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE52253FE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628537; cv=none; b=iuyJ0n3e28UCA7pkzo3mcxfeMvcVihjTwAEV870Q8yJPtaKXg/TDdCJMpx4TrYYFbG946qPZPK10VE7FcdES5fGzmqzt+dpC7Xux8ilVHztymYKRTGlpvOUyprhah+UTvY9HdNQj9CU8chDhkJHb+HoK/JVenADRSro40WFcbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628537; c=relaxed/simple;
	bh=NEA1pTQlwrJeksGG+0Q9POLg44mqUMimZQWdi8Osx48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hWRr6uEPsy4MsDhKGRv/mq7aZTVF+jpBzopvhiGdipGmogdwuyVArOv3oBZJBuP1SRquWgyzL0jQpg27Srq0x6XroIzPSI4mH4acNRopm7/Z/AZtFTnl5n9c2MNvZuPaTaAWh7XDzEb1iWDguhlJX2MA1KvYTSC3Rb4EYABRSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBKjG7LX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628535; x=1773164535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NEA1pTQlwrJeksGG+0Q9POLg44mqUMimZQWdi8Osx48=;
  b=aBKjG7LXNRJ5VGoD1QVbRfv8+63jOe1s9Ed98/23nYG+vWxtLjYYBggi
   +sa5lPWVDaqp0DV13b35KcsNcvIF3tcmOXVPBc9/XEqCchMLEJOWpkRY6
   pRq5FmdtNHaVPXjM0dJ2FjHquoR4JzxVcSkddTrhigiYEJ4Z0YZFxpd+Y
   L/vYQKHlLio7in0MBu80gZpeOokI8TrWUruWYzKgoOLmK/yTVHv7qHNtl
   k7tgaBkWODpzyFwJpmkN9QIozTUmmncqkz7V3KG7wHSPmLPXJKQq2cMRa
   WYmBRHVtYf0i3icU1z1ISeNVvly0vXim9nhj2fVW5RT9w5op/cA6inudU
   g==;
X-CSE-ConnectionGUID: otrwXOJgQjqOttzPPjH7aw==
X-CSE-MsgGUID: sFQqeeQASki06RHrU+JAiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60187415"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60187415"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:42:14 -0700
X-CSE-ConnectionGUID: GrAumct/QAarUKc07QeWCA==
X-CSE-MsgGUID: zTfeBrd2R/O1d1syM/ySrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120582257"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 10 Mar 2025 10:42:13 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trh8k-0005C4-1B;
	Mon, 10 Mar 2025 17:42:10 +0000
Date: Tue, 11 Mar 2025 01:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250304 5/11]
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:24: error: field has
 incomplete type 'struct iwl_tx_cmd_hdr'
Message-ID: <202503110126.sgFy2aj6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250304
head:   6d2e9e1f723433e96db706772bc630bc704bf9ba
commit: a6053266a6e573a3c22309605547bf35869fbaf3 [5/11] wifi: iwlwifi: dvm: Avoid -Wflex-array-member-not-at-end warnings
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250311/202503110126.sgFy2aj6-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503110126.sgFy2aj6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503110126.sgFy2aj6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2287:
   include/linux/vmstat.h:507:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     507 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/tx.c:27:
>> drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:764:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     764 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   13 warnings and 2 errors generated.
--
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
   In file included from include/linux/pci.h:1662:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2287:
   include/linux/vmstat.h:507:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     507 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:26:
>> drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:764:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     764 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1990:35: warning: implicit conversion from 'unsigned long long' to 'u32' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
    1990 |         trans_pcie->supported_dma_mask = DMA_BIT_MASK(12);
         |                                        ~ ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:40: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                        ^~~~~
   drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1992:36: warning: implicit conversion from 'unsigned long long' to 'u32' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
    1992 |                 trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
         |                                                ~ ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:40: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                        ^~~~~
   15 warnings and 2 errors generated.
--
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:7:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2287:
   include/linux/vmstat.h:507:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     507 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:7:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:7:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:7:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:21:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:30:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/sta.h:15:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h:10:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:10:
>> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:764:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     764 |         struct iwl_tx_cmd_hdr tx;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:21:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:30:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/sta.h:15:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h:10:
>> drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:53:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
      53 |         struct iwl_tx_cmd_hdr tx_cmd;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw.c:21:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:30:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/sta.h:15:
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h:10:
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tdls.h:134:24: error: field has incomplete type 'struct iwl_tx_cmd_hdr'
     134 |         struct iwl_tx_cmd_hdr pti_req_tx_cmd;
         |                               ^
   drivers/net/wireless/intel/iwlwifi/mvm/../fw/api/tx.h:745:9: note: forward declaration of 'struct iwl_tx_cmd_hdr'
     745 |         struct iwl_tx_cmd_hdr tx;
         |                ^
   13 warnings and 4 errors generated.
..


vim +745 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h

   686	
   687	/**
   688	 * struct iwl_compressed_ba_notif - notifies about reception of BA
   689	 * ( BA_NOTIF = 0xc5 )
   690	 * @flags: status flag, see the &iwl_mvm_ba_resp_flags
   691	 * @sta_id: Index of recipient (BA-sending) station in fw's station table
   692	 * @reduced_txp: power reduced according to TPC. This is the actual value and
   693	 *	not a copy from the LQ command. Thus, if not the first rate was used
   694	 *	for Tx-ing then this value will be set to 0 by FW.
   695	 * @tlc_rate_info: TLC rate info, initial rate index, TLC table color
   696	 * @retry_cnt: retry count
   697	 * @query_byte_cnt: SCD query byte count
   698	 * @query_frame_cnt: SCD query frame count
   699	 * @txed: number of frames sent in the aggregation (all-TIDs)
   700	 * @done: number of frames that were Acked by the BA (all-TIDs)
   701	 * @rts_retry_cnt: RTS retry count
   702	 * @reserved: reserved (for alignment)
   703	 * @wireless_time: Wireless-media time
   704	 * @tx_rate: the rate the aggregation was sent at
   705	 * @tfd_cnt: number of TFD-Q elements
   706	 * @ra_tid_cnt: number of RATID-Q elements
   707	 * @tfd: array of TFD queue status updates. See &iwl_compressed_ba_tfd
   708	 *	for details. Length in @tfd_cnt.
   709	 * @ra_tid: array of RA-TID queue status updates. For debug purposes only. See
   710	 *	&iwl_compressed_ba_ratid for more details. Length in @ra_tid_cnt.
   711	 */
   712	struct iwl_compressed_ba_notif {
   713		__le32 flags;
   714		u8 sta_id;
   715		u8 reduced_txp;
   716		u8 tlc_rate_info;
   717		u8 retry_cnt;
   718		__le32 query_byte_cnt;
   719		__le16 query_frame_cnt;
   720		__le16 txed;
   721		__le16 done;
   722		u8 rts_retry_cnt;
   723		u8 reserved;
   724		__le32 wireless_time;
   725		__le32 tx_rate;
   726		__le16 tfd_cnt;
   727		__le16 ra_tid_cnt;
   728		union {
   729			DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_ratid, ra_tid);
   730			DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_tfd, tfd);
   731		};
   732	} __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
   733		       COMPRESSED_BA_RES_API_S_VER_5 */
   734	
   735	/**
   736	 * struct iwl_mac_beacon_cmd_v6 - beacon template command
   737	 * @tx: the tx commands associated with the beacon frame
   738	 * @template_id: currently equal to the mac context id of the coresponding
   739	 *  mac.
   740	 * @tim_idx: the offset of the tim IE in the beacon
   741	 * @tim_size: the length of the tim IE
   742	 * @frame: the template of the beacon frame
   743	 */
   744	struct iwl_mac_beacon_cmd_v6 {
 > 745		struct iwl_tx_cmd_hdr tx;
   746		__le32 template_id;
   747		__le32 tim_idx;
   748		__le32 tim_size;
   749		struct ieee80211_hdr frame[];
   750	} __packed; /* BEACON_TEMPLATE_CMD_API_S_VER_6 */
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

