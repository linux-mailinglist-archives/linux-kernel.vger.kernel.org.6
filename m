Return-Path: <linux-kernel+bounces-329466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47279791B9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6EE1C215C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5AC1D0155;
	Sat, 14 Sep 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChcJURZr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A4154BE0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726326129; cv=none; b=GlaTlyQfuZJylaJvMTHYZEZIk5BvSRqW8ABuysdW6tn5KyaiCiMkeGjQyls1tvNV2O51OJ10FrAA254Jm8W2jYSGPuvRlCKXCSs/bGLmVT3OnSljQUMZFRwv89ly2zl8bzmuzLAdvEkKNqzR4VDG3WGH8yKNZCM8TzG97zut5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726326129; c=relaxed/simple;
	bh=0fYPa3D21CDIydZzht23bbkVDvaUMa8cH4jDmTZKyXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cBL5ClacHn4H2yXJqWVceANnLMM3Bij1i5GuiQ+lhYNoyQXoG3gxJ7C+M3aHVglwtFCEIKTC2t9VvV+WWSrOGxZAZ0t7EwWQwhBfC1nvoKElYwX4k6tOPaXz4Xdd9agvaW0zulOBMGfHrnE/goDNWsfKNzQ15vofb7KwNqnslN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChcJURZr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726326127; x=1757862127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0fYPa3D21CDIydZzht23bbkVDvaUMa8cH4jDmTZKyXo=;
  b=ChcJURZr8ESEFzvkVMDpxDTC9eIJjZip6CX7+voEKj3QixpikzlAqf60
   iLRDS6NUZ/Fv5/NmWo9xzagwDq3oZMvJ3XWbvXeIHlYuUof3UgtMRkdMX
   94maBemWNY7PxSXrNkT0yoF2rkQ/eeOhw7A8iPsT+XFl3KMdOFTwW0bta
   S9p3H/9myiKV4+o/PMnno9qt0VH3Vp5F0L7zkkf6xJeK0w5511kz8L6K5
   quCZkH6fXw3042XERDK4Z/xG6IhyQnSHRWdBM2cJLnTmrfhdkqktxAu1R
   p0AKss6t1RZx1jR7+cjZ9zYpCzUy7v+nFDvqho23WEVmCIiGPX/N9hYj3
   Q==;
X-CSE-ConnectionGUID: fExOEe2TQh2BdbX/p2pTlg==
X-CSE-MsgGUID: 34PS4zm6Q0a21T9wE/7xnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="47729384"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="47729384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 08:02:07 -0700
X-CSE-ConnectionGUID: fE6zh1OzSeKkb+v9VKWXmQ==
X-CSE-MsgGUID: CKT//k8zR22jgX5AhaS/rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="99268926"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Sep 2024 08:02:05 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spUHi-0007s2-2Q;
	Sat, 14 Sep 2024 15:02:02 +0000
Date: Sat, 14 Sep 2024 23:02:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240912 5/15]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
Message-ID: <202409150115.tShF7di6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240912
head:   f2ca068393cf1157c12ab08556b05824eec16511
commit: 06f3631525808b4ce559a30508e178bae26acb3c [5/15] RDMA/uverbs: Use static_assert() to check struct sizes
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240915/202409150115.tShF7di6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409150115.tShF7di6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150115.tShF7di6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/core/nldev.c:35:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/infiniband/core/nldev.c:37:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
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
   In file included from drivers/infiniband/core/nldev.c:37:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
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
   In file included from drivers/infiniband/core/nldev.c:37:
   In file included from include/net/netlink.h:6:
   In file included from include/linux/netlink.h:7:
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
   In file included from drivers/infiniband/core/nldev.c:44:
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
--
   In file included from drivers/infiniband/core/umem_dmabuf.c:6:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
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
   In file included from drivers/infiniband/core/umem_dmabuf.c:6:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/infiniband/core/umem_dmabuf.c:6:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
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
   In file included from drivers/infiniband/core/umem_dmabuf.c:6:
   In file included from include/linux/dma-buf.h:19:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/infiniband/core/umem_dmabuf.c:11:
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

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
   WARNING: unmet direct dependencies detected for OMAP2PLUS_MBOX
   Depends on [n]: MAILBOX [=y] && (ARCH_OMAP2PLUS || ARCH_K3)
   Selected by [m]:
   - TI_K3_M4_REMOTEPROC [=m] && REMOTEPROC [=y] && (ARCH_K3 || COMPILE_TEST [=y])


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

