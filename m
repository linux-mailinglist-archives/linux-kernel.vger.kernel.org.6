Return-Path: <linux-kernel+bounces-190071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA128CF92C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECB91F219B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CBE15AF1;
	Mon, 27 May 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXpdJ4Qx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA21BC59
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791552; cv=none; b=FFBo7aOh3b2Q6W+8lOXjRYmEzjH3J1wYEKwfJMGK16XPgiGJF5xCpqx3HHCaVcbjUveQbn4CLO6SZZLON5QZEXtexBHgWaqQPSkm0JHIW+Yd809v2ZBudN6VuZDDWN8n08ntRPdU/bI1LMQEypg2iYk0cp7v46CsvgKxaHckqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791552; c=relaxed/simple;
	bh=auVjQlWyoHQdIMybmSN8O+mK3/mRNQukHdMV1W+b0oA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMIXP1RU3OyTZBc6MzTFuwSaEw9cCM0k8TEDBbd1OQHqErMjcpiZ7iGdpZSy1HIUrKIb02J2WpIKO1aSbC/G3gD4XSlceKz4y243jYU3Qq349M2UN/zzrLWdv1Po7Kfuvo2/j6FUzTroA7K1mroHwXrCKos7RNpm1uUhy0fcuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXpdJ4Qx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716791550; x=1748327550;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=auVjQlWyoHQdIMybmSN8O+mK3/mRNQukHdMV1W+b0oA=;
  b=LXpdJ4QxT3+LuakAbjZTMQF5eMGjoUDQEbjgaA1+CahEqHbRB4uF0pNI
   kAsjekAsf/75zKNHGIY2to4YahqTjY8jzGApdlby8xmtG60p86vaRBqSD
   CKpUx6PQg7M1gj0Lqx1dT6ApqinCuPqGWzSCqgvj9hP/rfYrepdzY3Lv6
   Ot/fpqilxq/XlMa0aJBgmOB1WSwvlM9rQTGpwO/NB37Taik8v+wR0FAql
   h1QUhCVEF+y4rGenvnA34ckFgfBPso8muid4UZoKy0V0ayWpf/3LRvAEK
   ct5sYrE4mb6pVFLvmxamuNuuNQw6UzdBnJqAZmORvB441f6L9L/EZ/uep
   A==;
X-CSE-ConnectionGUID: QYHl7F2CQXSxsvuPJwZLbg==
X-CSE-MsgGUID: S7LMDVTHQ6uVK5zsFkdtDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13215150"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13215150"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 23:32:29 -0700
X-CSE-ConnectionGUID: tVu+4zmCQdaSKioLnOq7Hg==
X-CSE-MsgGUID: gde25LMFRPGtsewYoyXRiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="57847351"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 May 2024 23:32:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBTu9-0009Wj-2r;
	Mon, 27 May 2024 06:32:22 +0000
Date: Mon, 27 May 2024 14:31:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/target/fc.c:150:2: warning: 'counted_by' should not be
 applied to an array with element of unknown size because 'struct
 nvmet_fc_fcp_iod' is a struct type with a flexible array member. This will
 be an error in a future compiler version
Message-ID: <202405271448.bD0Hn0p4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
commit: ccd3129aca286c41616afe357e3494c5b43350a0 nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by
date:   8 months ago
config: s390-randconfig-002-20240527 (https://download.01.org/0day-ci/archive/20240527/202405271448.bD0Hn0p4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271448.bD0Hn0p4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405271448.bD0Hn0p4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/target/fc.c:6:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2168:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/nvme/target/fc.c:8:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/nvme/target/fc.c:150:2: warning: 'counted_by' should not be applied to an array with element of unknown size because 'struct nvmet_fc_fcp_iod' is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     150 |         struct nvmet_fc_fcp_iod         fod[] __counted_by(sqsize);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:177:1: warning: unused function 'nvmet_fc_iodnum' [-Wunused-function]
     177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
         | ^~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:183:1: warning: unused function 'nvmet_fc_fodnum' [-Wunused-function]
     183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
         | ^~~~~~~~~~~~~~~
   16 warnings generated.


vim +150 drivers/nvme/target/fc.c

   128	
   129	struct nvmet_fc_tgt_queue {
   130		bool				ninetypercent;
   131		u16				qid;
   132		u16				sqsize;
   133		u16				ersp_ratio;
   134		__le16				sqhd;
   135		atomic_t			connected;
   136		atomic_t			sqtail;
   137		atomic_t			zrspcnt;
   138		atomic_t			rsn;
   139		spinlock_t			qlock;
   140		struct nvmet_cq			nvme_cq;
   141		struct nvmet_sq			nvme_sq;
   142		struct nvmet_fc_tgt_assoc	*assoc;
   143		struct list_head		fod_list;
   144		struct list_head		pending_cmd_list;
   145		struct list_head		avail_defer_list;
   146		struct workqueue_struct		*work_q;
   147		struct kref			ref;
   148		struct rcu_head			rcu;
   149		/* array of fcp_iods */
 > 150		struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
   151	} __aligned(sizeof(unsigned long long));
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

