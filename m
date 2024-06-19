Return-Path: <linux-kernel+bounces-220463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C007B90E213
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2C71C2187C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6482B9D9;
	Wed, 19 Jun 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJlWUhSn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4A208DA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768984; cv=none; b=ISn9NDatcsYB5r2d5qS7tFJEq6ItVAPzFZfXf+kqpBdfzsgWYyAhXYHmuetq7RdhPFUBlo3bRu3irIxm0B4kgdfiiRtT0pEeYwfrtovKZJKvmsA3wbTtn3tMwl1Qiuo+J1Aet27paiNKYKHleCy2nTgmJknqadIwetrHGxwXm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768984; c=relaxed/simple;
	bh=MUw+ibmYoJb8MKDQAZ5k87pJkkiazzfMgw22529YSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgrtb7SnvR09/CvKpGNSuA2t+rHv8LuPrbLBKZbLXiYG0qcQnW29RmtNaJZCHnrbSl1hvopckloMCVLgJtX5wWFNyiX6TYowZolyytMvyjX+mrIsHX4vDG085giRIJ8u0bLvJLHAVXe64Qxi+0yOQLge/HhWDrrXMQEZSHL3kdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJlWUhSn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718768983; x=1750304983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MUw+ibmYoJb8MKDQAZ5k87pJkkiazzfMgw22529YSAU=;
  b=iJlWUhSnIJqvr2Kra7UHLmh9LANi6HrKipdEnpFcJ4g6sUakKyHiXnqc
   0IkUdDiD9TeybOjgLV6kwcje/EkgLzXNyibh4aVmXiHp3JCs7vH1uo5VG
   jwV6+2e0bmthYHR7DdebdwuResUD+APLEc1+v3oZy816v7CnKeyt9zXnQ
   0nMj0s5lrJCaKOByDPKfuwKICxHLFaNk2Y+auhpUwKDi/eO0zhnB0CN62
   ZnyuuTZ2bXprtT7zgAsYwSYKk2GkZncJp5IDJqGb2DYfNFgWyegGaOQFI
   icjdI4PfjcY0+ahRuRr41zZaLug6lJ8Z+9TqAESrcC933Q2PgBoTijAZM
   Q==;
X-CSE-ConnectionGUID: z8e2zWuNRwiAKWQzVtZoyw==
X-CSE-MsgGUID: jn4bJzWJR3evDeBMxo+xpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15814075"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15814075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 20:49:42 -0700
X-CSE-ConnectionGUID: IC5iXBdERSG61vk2c5M2yA==
X-CSE-MsgGUID: kdhh/Va1RCGuBjiFC0VBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="42483704"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 20:49:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJmKH-0006Fr-2I;
	Wed, 19 Jun 2024 03:49:37 +0000
Date: Wed, 19 Jun 2024 11:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, geert@linux-m68k.org
Cc: oe-kbuild-all@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] zorro: Use str_plural() in amiga_zorro_probe()
Message-ID: <202406191127.BtrdVDxQ-lkp@intel.com>
References: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>

Hi Jiapeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on geert-m68k/for-linus gerg-m68knommu/for-next linus/master v6.10-rc4 next-20240618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/zorro-Use-str_plural-in-amiga_zorro_probe/20240618-181203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20240618073205.65303-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH] zorro: Use str_plural() in amiga_zorro_probe()
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240619/202406191127.BtrdVDxQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191127.BtrdVDxQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191127.BtrdVDxQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/zorro/zorro.c:11:
   drivers/zorro/zorro.c: In function 'amiga_zorro_probe':
>> drivers/zorro/zorro.c:155:37: error: implicit declaration of function 'str_plural' [-Werror=implicit-function-declaration]
     155 |                  zorro_num_autocon, str_plural(zorro_num_autocon));
         |                                     ^~~~~~~~~~
   include/linux/printk.h:436:33: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:537:9: note: in expansion of macro 'printk'
     537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/zorro/zorro.c:154:9: note: in expansion of macro 'pr_info'
     154 |         pr_info("Zorro: Probing AutoConfig expansion devices: %u device%s\n",
         |         ^~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:436:25: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:537:9: note: in expansion of macro 'printk'
     537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:537:16: note: in expansion of macro 'KERN_INFO'
     537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   drivers/zorro/zorro.c:154:9: note: in expansion of macro 'pr_info'
     154 |         pr_info("Zorro: Probing AutoConfig expansion devices: %u device%s\n",
         |         ^~~~~~~
   cc1: some warnings being treated as errors


vim +/str_plural +155 drivers/zorro/zorro.c

  > 11	#include <linux/module.h>
    12	#include <linux/types.h>
    13	#include <linux/kernel.h>
    14	#include <linux/init.h>
    15	#include <linux/zorro.h>
    16	#include <linux/bitops.h>
    17	#include <linux/string.h>
    18	#include <linux/platform_device.h>
    19	#include <linux/dma-mapping.h>
    20	#include <linux/slab.h>
    21	
    22	#include <asm/byteorder.h>
    23	#include <asm/setup.h>
    24	#include <asm/amigahw.h>
    25	
    26	#include "zorro.h"
    27	
    28	
    29	    /*
    30	     *  Zorro Expansion Devices
    31	     */
    32	
    33	unsigned int zorro_num_autocon;
    34	struct zorro_dev_init zorro_autocon_init[ZORRO_NUM_AUTO] __initdata;
    35	struct zorro_dev *zorro_autocon;
    36	
    37	
    38	    /*
    39	     *  Zorro bus
    40	     */
    41	
    42	struct zorro_bus {
    43		struct device dev;
    44		struct zorro_dev devices[];
    45	};
    46	
    47	
    48	    /*
    49	     *  Find Zorro Devices
    50	     */
    51	
    52	struct zorro_dev *zorro_find_device(zorro_id id, struct zorro_dev *from)
    53	{
    54		struct zorro_dev *z;
    55	
    56		if (!zorro_num_autocon)
    57			return NULL;
    58	
    59		for (z = from ? from+1 : &zorro_autocon[0];
    60		     z < zorro_autocon+zorro_num_autocon;
    61		     z++)
    62			if (id == ZORRO_WILDCARD || id == z->id)
    63				return z;
    64		return NULL;
    65	}
    66	EXPORT_SYMBOL(zorro_find_device);
    67	
    68	
    69	    /*
    70	     *  Bitmask indicating portions of available Zorro II RAM that are unused
    71	     *  by the system. Every bit represents a 64K chunk, for a maximum of 8MB
    72	     *  (128 chunks, physical 0x00200000-0x009fffff).
    73	     *
    74	     *  If you want to use (= allocate) portions of this RAM, you should clear
    75	     *  the corresponding bits.
    76	     *
    77	     *  Possible uses:
    78	     *      - z2ram device
    79	     *      - SCSI DMA bounce buffers
    80	     *
    81	     *  FIXME: use the normal resource management
    82	     */
    83	
    84	DECLARE_BITMAP(zorro_unused_z2ram, 128);
    85	EXPORT_SYMBOL(zorro_unused_z2ram);
    86	
    87	
    88	static void __init mark_region(unsigned long start, unsigned long end,
    89				       int flag)
    90	{
    91		if (flag)
    92			start += Z2RAM_CHUNKMASK;
    93		else
    94			end += Z2RAM_CHUNKMASK;
    95		start &= ~Z2RAM_CHUNKMASK;
    96		end &= ~Z2RAM_CHUNKMASK;
    97	
    98		if (end <= Z2RAM_START || start >= Z2RAM_END)
    99			return;
   100		start = start < Z2RAM_START ? 0x00000000 : start-Z2RAM_START;
   101		end = end > Z2RAM_END ? Z2RAM_SIZE : end-Z2RAM_START;
   102		while (start < end) {
   103			u32 chunk = start>>Z2RAM_CHUNKSHIFT;
   104	
   105			if (flag)
   106				set_bit(chunk, zorro_unused_z2ram);
   107			else
   108				clear_bit(chunk, zorro_unused_z2ram);
   109			start += Z2RAM_CHUNKSIZE;
   110		}
   111	}
   112	
   113	
   114	static struct resource __init *zorro_find_parent_resource(
   115		struct platform_device *bridge, struct zorro_dev *z)
   116	{
   117		int i;
   118	
   119		for (i = 0; i < bridge->num_resources; i++) {
   120			if (resource_contains(&bridge->resource[i], &z->resource))
   121				return &bridge->resource[i];
   122		}
   123	
   124		return &iomem_resource;
   125	}
   126	
   127	static int __init amiga_zorro_probe(struct platform_device *pdev)
   128	{
   129		struct zorro_bus *bus;
   130		struct zorro_dev_init *zi;
   131		struct zorro_dev *z;
   132		struct resource *r;
   133		unsigned int i;
   134		int error;
   135	
   136		/* Initialize the Zorro bus */
   137		bus = kzalloc(struct_size(bus, devices, zorro_num_autocon),
   138			      GFP_KERNEL);
   139		if (!bus)
   140			return -ENOMEM;
   141	
   142		zorro_autocon = bus->devices;
   143		bus->dev.parent = &pdev->dev;
   144		dev_set_name(&bus->dev, zorro_bus_type.name);
   145		error = device_register(&bus->dev);
   146		if (error) {
   147			pr_err("Zorro: Error registering zorro_bus\n");
   148			put_device(&bus->dev);
   149			kfree(bus);
   150			return error;
   151		}
   152		platform_set_drvdata(pdev, bus);
   153	
   154		pr_info("Zorro: Probing AutoConfig expansion devices: %u device%s\n",
 > 155			 zorro_num_autocon, str_plural(zorro_num_autocon));
   156	
   157		/* First identify all devices ... */
   158		for (i = 0; i < zorro_num_autocon; i++) {
   159			zi = &zorro_autocon_init[i];
   160			z = &zorro_autocon[i];
   161	
   162			z->rom = zi->rom;
   163			z->id = (be16_to_cpu(z->rom.er_Manufacturer) << 16) |
   164				(z->rom.er_Product << 8);
   165			if (z->id == ZORRO_PROD_GVP_EPC_BASE) {
   166				/* GVP quirk */
   167				unsigned long magic = zi->boardaddr + 0x8000;
   168	
   169				z->id |= *(u16 *)ZTWO_VADDR(magic) & GVP_PRODMASK;
   170			}
   171			z->slotaddr = zi->slotaddr;
   172			z->slotsize = zi->slotsize;
   173			sprintf(z->name, "Zorro device %08x", z->id);
   174			zorro_name_device(z);
   175			z->resource = DEFINE_RES_MEM_NAMED(zi->boardaddr, zi->boardsize, z->name);
   176			r = zorro_find_parent_resource(pdev, z);
   177			error = request_resource(r, &z->resource);
   178			if (error && !(z->rom.er_Type & ERTF_MEMLIST))
   179				dev_err(&bus->dev,
   180					"Address space collision on device %s %pR\n",
   181					z->name, &z->resource);
   182			z->dev.parent = &bus->dev;
   183			z->dev.bus = &zorro_bus_type;
   184			z->dev.id = i;
   185			switch (z->rom.er_Type & ERT_TYPEMASK) {
   186			case ERT_ZORROIII:
   187				z->dev.coherent_dma_mask = DMA_BIT_MASK(32);
   188				break;
   189	
   190			case ERT_ZORROII:
   191			default:
   192				z->dev.coherent_dma_mask = DMA_BIT_MASK(24);
   193				break;
   194			}
   195			z->dev.dma_mask = &z->dev.coherent_dma_mask;
   196		}
   197	
   198		/* ... then register them */
   199		for (i = 0; i < zorro_num_autocon; i++) {
   200			z = &zorro_autocon[i];
   201			error = device_register(&z->dev);
   202			if (error) {
   203				dev_err(&bus->dev, "Error registering device %s\n",
   204					z->name);
   205				put_device(&z->dev);
   206				continue;
   207			}
   208		}
   209	
   210		/* Mark all available Zorro II memory */
   211		zorro_for_each_dev(z) {
   212			if (z->rom.er_Type & ERTF_MEMLIST)
   213				mark_region(zorro_resource_start(z),
   214					    zorro_resource_end(z)+1, 1);
   215		}
   216	
   217		/* Unmark all used Zorro II memory */
   218		for (i = 0; i < m68k_num_memory; i++)
   219			if (m68k_memory[i].addr < 16*1024*1024)
   220				mark_region(m68k_memory[i].addr,
   221					    m68k_memory[i].addr+m68k_memory[i].size,
   222					    0);
   223	
   224		return 0;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

