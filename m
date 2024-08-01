Return-Path: <linux-kernel+bounces-271182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D3944A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3356A1F236E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818418E04D;
	Thu,  1 Aug 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l83NJdSh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB318DF6B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512133; cv=none; b=BTYPzUQz5Aqg2sb20u3vo3vedav7nZqqU6HQQAxcz5e8gu4diyBaF94TenZhVj4vBYFCzLV7xmc/GREAc+G0NGXWeQ5+PCe8lmx5b5C+oJsp8IIYBCvF5K7CC3FFDxxoeXzwjbIRnb6ztL5+W1mGMoLmQpc0y952wtsqXmPXmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512133; c=relaxed/simple;
	bh=qhdqmMNrGaKh+6q/FW281omFfqWYlK8TRFPg+zf3Qss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=noum3Ki0gTV6jRFrgONqYPxrBhmu8o1lxD9N+V51P719kdhFHjHbBgU/8kTttSFw5KMcAMiE25v9RyLmLTC7JrsTmLq1HZoW0KIS345WGJEUPZJq8LF5V5Aj5gLH7LmMtxpH8fsrgS8KZ/c8tEYqpqCUz1SnoN6eSK4JN554Od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l83NJdSh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722512132; x=1754048132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qhdqmMNrGaKh+6q/FW281omFfqWYlK8TRFPg+zf3Qss=;
  b=l83NJdShNxWruXx9WLV+IHcPEgya3ZI2mo9hAG26wufS1G1hNGIMZA1u
   cQ4sThOzhILFTmWqkAMJUnzpIFxQvmNBKMINbvRGCvNk6rIXxnDwAr/yb
   pcsw2u3/UuEpbzsMBxn5dC577SuBNB0hmKSRVfIynZxtoxCCxGe+r6y7F
   PCgOv26bSm0mbBaW1rtsiQ2hy4AJOw0kQ7WdhKh1QM+6fKxmLqxecYhT7
   5MAOmlxpAiiLIaUkAEHcm184EjYp9+1mNOxyLx0V3080uNsN9leHNklCO
   nLiWPmX0ygcdesW81E8/ZZ88MLtT6bqIQrDR9udWvHiZwo1OevFueQMTg
   g==;
X-CSE-ConnectionGUID: O58Iu3dCSYaNvwj5L87kfQ==
X-CSE-MsgGUID: 99qhgiyRQoG/JW4be9cOmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="42982781"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="42982781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 04:35:31 -0700
X-CSE-ConnectionGUID: Kl7rpbVgTDWJf6a6rQ2ilg==
X-CSE-MsgGUID: wzOpMSq5T/agRDfGIpk21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="54978926"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Aug 2024 04:35:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZU5e-000vXY-2V;
	Thu, 01 Aug 2024 11:35:26 +0000
Date: Thu, 1 Aug 2024 19:35:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
Message-ID: <202408011956.wscyBwq6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408011956.wscyBwq6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
   In file included from drivers/infiniband/core/uverbs.h:46:
   In file included from include/rdma/ib_verbs.h:15:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
   In file included from drivers/infiniband/core/uverbs.h:46:
   In file included from include/rdma/ib_verbs.h:15:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
   In file included from drivers/infiniband/core/uverbs.h:46:
   In file included from include/rdma/ib_verbs.h:15:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
   In file included from drivers/infiniband/core/uverbs.h:46:
   In file included from include/rdma/ib_verbs.h:15:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
   In file included from drivers/infiniband/core/uverbs.h:49:
   In file included from include/rdma/uverbs_std_types.h:10:
>> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
     643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
         | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     644 |               "struct member likely outside of struct_group_tagged()");
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
     643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     644 |               "struct member likely outside of struct_group_tagged()");
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   7 warnings and 1 error generated.


vim +643 include/rdma/uverbs_ioctl.h

   630	
   631	struct uverbs_attr_bundle {
   632		/* New members MUST be added within the struct_group() macro below. */
   633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
   634			struct ib_udata driver_udata;
   635			struct ib_udata ucore;
   636			struct ib_uverbs_file *ufile;
   637			struct ib_ucontext *context;
   638			struct ib_uobject *uobject;
   639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
   640		);
   641		struct uverbs_attr attrs[];
   642	};
 > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
   644		      "struct member likely outside of struct_group_tagged()");
   645	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

