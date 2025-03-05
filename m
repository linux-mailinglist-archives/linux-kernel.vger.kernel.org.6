Return-Path: <linux-kernel+bounces-547076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB4A502C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0F7189DC73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22924BBE3;
	Wed,  5 Mar 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvTfGNi6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350924A073;
	Wed,  5 Mar 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186074; cv=none; b=XOGbXep+MFmWSiaUw7OpY08tvGxADgVvFPe3xQMYb7Me7DfcIf7gB6xlDdmStNl2/9cE4J2W2EpYNIqNN6TJfs+X4VJEPzOKfbzaOBgq+GGtaAxvQAT0pd5+CCJlJq9/FrzE+drW89Uj+YR8LhDzb/jYoeLCH+GiFn/Of44OH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186074; c=relaxed/simple;
	bh=joP68b7Dh0p2ZNLJiJaNW8ilprYFELiWiIzeuH6IOho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edv2d8pb86yUaM3/+LjNIAj2gGLk3WuDm1TnccCp7mWXwbJGtnA+k87JIekCfODhz+VTAtcobyyf/kxcznZyqJQw7oBHUlr7Zqa43udAEOpBNSPbLmyELDzU3ASfV9RmekRYv67wu/vL6A/9M7INC5yFDqA2cOX2gim6riBJIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvTfGNi6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741186073; x=1772722073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joP68b7Dh0p2ZNLJiJaNW8ilprYFELiWiIzeuH6IOho=;
  b=dvTfGNi6TWsjW/E1sBzNxbhGfofkRP05mOufz5GWMcYy/poalsO3B+IP
   rzlZrdLjv6RM23fxfGzGDowbujwbGOwJ0tP7UG+adVWH+wMvN9wOIEISV
   p4Qk3z8pOVMOMiUJJkg7lZ2z1BOMeeuIagV3Ofm0ohLqEbCEPL15lF9Pv
   t5GMDEbq2JVkMJm7sYbx3bFEGioQlIEDvqPRYKFEMB5QvTR8/TxAHPszm
   1n6L/paOHWWiBmJ1bHuUr495CavjU1wGD137g5p3Xv32NGACdZvcUW3Nd
   tXx8BYYOI9h3DtROoavh7c1jKJ7iloeectDxoOXzU3hC3WKpbrF73HBHy
   g==;
X-CSE-ConnectionGUID: gnOX6nhiT0eEdebX3GWuJw==
X-CSE-MsgGUID: JG7ELMBEQv+TB40YcpC1Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52788463"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52788463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:47:52 -0800
X-CSE-ConnectionGUID: vI3ceUfnRrCGa1MWYBvuaA==
X-CSE-MsgGUID: g0XkJtvfRtWxahAhx2Iiww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118421301"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2025 06:47:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpq2D-000L5W-2p;
	Wed, 05 Mar 2025 14:47:45 +0000
Date: Wed, 5 Mar 2025 22:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
	si.yanteng@linux.dev, tglx@linutronix.de, jiaxun.yang@flygoat.com,
	peterz@infradead.org, wangliupu@loongson.cn, lvjianmin@loongson.cn,
	maobibo@loongson.cn, siyanteng@cqsoftware.com.cn,
	gaosong@loongson.cn, yangtiezhu@loongson.cn
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: Re: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
Message-ID: <202503052234.SiXLJuat-lkp@intel.com>
References: <20250303101533.31462-3-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303101533.31462-3-zhangtianyang@loongson.cn>

Hi Tianyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on lwn/docs-next linus/master v6.14-rc5 next-20250305]
[cannot apply to tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianyang-Zhang/Docs-LoongArch-Add-Advanced-Extended-Redirect-IRQ-model-description/20250303-181832
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250303101533.31462-3-zhangtianyang%40loongson.cn
patch subject: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
config: loongarch-randconfig-002-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052234.SiXLJuat-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052234.SiXLJuat-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052234.SiXLJuat-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongarch-ir.c:8:
   drivers/irqchip/irq-loongarch-ir.c: In function 'redirect_queue_init':
>> drivers/irqchip/irq-loongarch-ir.c:413:62: error: 'INVALID_QUEUE_PAGE_ORDER' undeclared (first use in this function)
     413 |         pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
         |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/alloc_tag.h:227:16: note: in definition of macro 'alloc_hooks_tag'
     227 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/gfp.h:295:49: note: in expansion of macro 'alloc_hooks'
     295 | #define  alloc_pages_node(...)                  alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   drivers/irqchip/irq-loongarch-ir.c:413:17: note: in expansion of macro 'alloc_pages_node'
     413 |         pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
         |                 ^~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-ir.c:413:62: note: each undeclared identifier is reported only once for each function it appears in
     413 |         pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
         |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/alloc_tag.h:227:16: note: in definition of macro 'alloc_hooks_tag'
     227 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/gfp.h:295:49: note: in expansion of macro 'alloc_hooks'
     295 | #define  alloc_pages_node(...)                  alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   drivers/irqchip/irq-loongarch-ir.c:413:17: note: in expansion of macro 'alloc_pages_node'
     413 |         pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
         |                 ^~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-loongarch-ir.c:413:15: error: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     413 |         pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
         |               ^
   drivers/irqchip/irq-loongarch-ir.c: In function 'redirect_table_init':
>> drivers/irqchip/irq-loongarch-ir.c:440:65: error: 'IRD_PAGE_ORDER' undeclared (first use in this function); did you mean 'NR_PAGE_ORDERS'?
     440 |         pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, IRD_PAGE_ORDER);
         |                                                                 ^~~~~~~~~~~~~~
   include/linux/alloc_tag.h:227:16: note: in definition of macro 'alloc_hooks_tag'
     227 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/gfp.h:295:49: note: in expansion of macro 'alloc_hooks'
     295 | #define  alloc_pages_node(...)                  alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   drivers/irqchip/irq-loongarch-ir.c:440:17: note: in expansion of macro 'alloc_pages_node'
     440 |         pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, IRD_PAGE_ORDER);
         |                 ^~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-ir.c:440:15: error: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     440 |         pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, IRD_PAGE_ORDER);
         |               ^
   drivers/irqchip/irq-loongarch-ir.c: In function 'redirect_table_fini':
   drivers/irqchip/irq-loongarch-ir.c:475:47: error: 'IRD_PAGE_ORDER' undeclared (first use in this function); did you mean 'NR_PAGE_ORDERS'?
     475 |                 __free_pages(ird_table->page, IRD_PAGE_ORDER);
         |                                               ^~~~~~~~~~~~~~
         |                                               NR_PAGE_ORDERS
   drivers/irqchip/irq-loongarch-ir.c:486:44: error: 'INVALID_QUEUE_PAGE_ORDER' undeclared (first use in this function)
     486 |                 __free_pages(rqueue->page, INVALID_QUEUE_PAGE_ORDER);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/INVALID_QUEUE_PAGE_ORDER +413 drivers/irqchip/irq-loongarch-ir.c

   407	
   408	static int redirect_queue_init(int node)
   409	{
   410		struct redirect_queue *rqueue = &(irde_descs[node].inv_queue);
   411		struct page *pages;
   412	
 > 413		pages = alloc_pages_node(0, GFP_KERNEL | __GFP_ZERO, INVALID_QUEUE_PAGE_ORDER);
   414		if (!pages) {
   415			pr_err("Node [%d] Invalid Queue alloc pages failed!\n", node);
   416			return -ENOMEM;
   417		}
   418	
   419		rqueue->page = pages;
   420		rqueue->base = (u64)page_address(pages);
   421		rqueue->max_size = INVALID_QUEUE_SIZE;
   422		rqueue->head = 0;
   423		rqueue->tail = 0;
   424		rqueue->node = node;
   425		raw_spin_lock_init(&rqueue->lock);
   426	
   427		iocsr_write32(0, LOONGARCH_IOCSR_REDIRECT_CQH);
   428		iocsr_write32(0, LOONGARCH_IOCSR_REDIRECT_CQT);
   429		iocsr_write64(((rqueue->base & (CQB_ADDR_MASK << CQB_ADDR_SHIFT)) |
   430					(CQB_SIZE_MASK << CQB_SIZE_SHIFT)), LOONGARCH_IOCSR_REDIRECT_CQB);
   431		return 0;
   432	}
   433	
   434	static int redirect_table_init(int node)
   435	{
   436		struct redirect_table *ird_table = &(irde_descs[node].ird_table);
   437		struct page *pages;
   438		unsigned long *bitmap;
   439	
 > 440		pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, IRD_PAGE_ORDER);
   441		if (!pages) {
   442			pr_err("Node [%d] redirect table alloc pages failed!\n", node);
   443			return -ENOMEM;
   444		}
   445		ird_table->page = pages;
   446		ird_table->table = page_address(pages);
   447	
   448		bitmap = bitmap_zalloc(IRD_ENTRIES, GFP_KERNEL);
   449		if (!bitmap) {
   450			pr_err("Node [%d] redirect table bitmap alloc pages failed!\n", node);
   451			return -ENOMEM;
   452		}
   453	
   454		ird_table->bitmap = bitmap;
   455		ird_table->nr_ird = IRD_ENTRIES;
   456		ird_table->node = node;
   457	
   458		raw_spin_lock_init(&ird_table->lock);
   459	
   460		if (redirect_queue_init(node))
   461			return -EINVAL;
   462	
   463		iocsr_write64(CFG_DISABLE_IDLE, LOONGARCH_IOCSR_REDIRECT_CFG);
   464		iocsr_write64(__pa(ird_table->table), LOONGARCH_IOCSR_REDIRECT_TBR);
   465	
   466		return 0;
   467	}
   468	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

