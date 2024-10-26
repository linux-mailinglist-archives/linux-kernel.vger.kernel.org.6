Return-Path: <linux-kernel+bounces-382862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679F9B141E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D79B21C09
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4F13B2A5;
	Sat, 26 Oct 2024 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezMSSXF+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52770813
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729907808; cv=none; b=I/oCfN3iHrd76JtCEM85IANO/5YUSeJMnEp1dAPHLTXZLg455mgitdZ0aHN45pBjEkLK7xSt91UOh+HJuv2V3OH1sWMe2+5dfzj8aiKP5nmGiN/FAE0YxyWOviAthc0EudO4kJOBL7yGDz/wGFppVkNAuWL2To/i4ec4zBKIIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729907808; c=relaxed/simple;
	bh=tG3+xLbFSNbeMcSeH7xbGduUdqBK6M8d1HeoYJLKAug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oPZCe6a+zFoNv77NVTjC1xP7G97MKHys5FWXHyo27LDQffIqOv907kwkhSJjLaRxilaAW4F9NbUXHOjSgfc7QfF0HiuzHLoL5DLYzlAUuGPZhQwxDX1aSM95ICDH5oqNeTH7sQEV2h/iIkAOrOrKayMu/7cLH+1OGaN0qyrcUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezMSSXF+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729907807; x=1761443807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tG3+xLbFSNbeMcSeH7xbGduUdqBK6M8d1HeoYJLKAug=;
  b=ezMSSXF+OUAUaSgUKrmdzs/ZCVIG49GlkjSSXvtVUTTrWuBd+tTS1LWL
   GFvzdVguVp95d4Wy616WQQ1CCiQ5JBEI/8AxuR5MBOYYwNn2QrieDIeME
   RALUkT766pyOgeW3HwuHGRA4zPatKwBB5fRgptEz7xXPMPhhWO0qEHU9a
   FxSjd7M6Q5FvcL93PS4XNRvCUjHqL5KW3sdkw18gF3EK1fofcA1sgw+Jr
   Ji2lryeTdPOFXJ+wQlP023Nt7HCa1KCjGu6Wdq3GoaWDA+BRnzK4ZSe7Z
   Ow417uVdyoMoYdTbOqlnBQNUhy65FGol4Xdb2qWbIhfbuoNec5/kTlwnC
   g==;
X-CSE-ConnectionGUID: IKY4EgXgSmunrZccSKOR5w==
X-CSE-MsgGUID: sqkpL1LvSKmF1Q63mSmwtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29452096"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29452096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 18:56:44 -0700
X-CSE-ConnectionGUID: UZJ+KsxHTlaTKTDj0RpQzg==
X-CSE-MsgGUID: PzNk6H1LRkKldWnysYR89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85050157"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 18:56:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4W2h-000Z9O-1m;
	Sat, 26 Oct 2024 01:56:39 +0000
Date: Sat, 26 Oct 2024 09:55:53 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, Alex Shi <alexs@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: drivers/mtd/maps/solutionengine.c:52:39: error: assignment to 'void
 *' from 'int' makes pointer from integer without a cast
Message-ID: <202410260957.rI7wuDpF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   850925a8133c73c4a2453c360b2c3beb3bab67c9
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   2 years, 7 months ago
config: sh-randconfig-001-20241026 (https://download.01.org/0day-ci/archive/20241026/202410260957.rI7wuDpF-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260957.rI7wuDpF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260957.rI7wuDpF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/mtd/maps/solutionengine.c:9:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1396:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1396 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1382:27: note: 'mem_section' declared here
    1382 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
>> drivers/mtd/maps/solutionengine.c:52:39: error: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      52 |                 soleng_flash_map.virt = P2SEGADDR(0x01000000);
         |                                       ^
   drivers/mtd/maps/solutionengine.c:54:39: error: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      54 |                 soleng_eprom_map.virt = P1SEGADDR(0);
         |                                       ^


vim +52 drivers/mtd/maps/solutionengine.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  35  
^1da177e4c3f41 Linus Torvalds 2005-04-16  36  static int __init init_soleng_maps(void)
^1da177e4c3f41 Linus Torvalds 2005-04-16  37  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  38  	/* First probe at offset 0 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  39  	soleng_flash_map.phys = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  40  	soleng_flash_map.virt = (void __iomem *)P2SEGADDR(0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  41  	soleng_eprom_map.phys = 0x01000000;
^1da177e4c3f41 Linus Torvalds 2005-04-16  42  	soleng_eprom_map.virt = (void __iomem *)P1SEGADDR(0x01000000);
^1da177e4c3f41 Linus Torvalds 2005-04-16  43  	simple_map_init(&soleng_eprom_map);
^1da177e4c3f41 Linus Torvalds 2005-04-16  44  	simple_map_init(&soleng_flash_map);
^1da177e4c3f41 Linus Torvalds 2005-04-16  45  
^1da177e4c3f41 Linus Torvalds 2005-04-16  46  	printk(KERN_NOTICE "Probing for flash chips at 0x00000000:\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  47  	flash_mtd = do_map_probe("cfi_probe", &soleng_flash_map);
^1da177e4c3f41 Linus Torvalds 2005-04-16  48  	if (!flash_mtd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  49  		/* Not there. Try swapping */
^1da177e4c3f41 Linus Torvalds 2005-04-16  50  		printk(KERN_NOTICE "Probing for flash chips at 0x01000000:\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  51  		soleng_flash_map.phys = 0x01000000;
^1da177e4c3f41 Linus Torvalds 2005-04-16 @52  		soleng_flash_map.virt = P2SEGADDR(0x01000000);
^1da177e4c3f41 Linus Torvalds 2005-04-16  53  		soleng_eprom_map.phys = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  54  		soleng_eprom_map.virt = P1SEGADDR(0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  55  		flash_mtd = do_map_probe("cfi_probe", &soleng_flash_map);
^1da177e4c3f41 Linus Torvalds 2005-04-16  56  		if (!flash_mtd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  57  			/* Eep. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  58  			printk(KERN_NOTICE "Flash chips not detected at either possible location.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  59  			return -ENXIO;
^1da177e4c3f41 Linus Torvalds 2005-04-16  60  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  61  	}
1d25e3eeed1d98 Randy Dunlap   2018-07-24  62  	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
1d25e3eeed1d98 Randy Dunlap   2018-07-24  63  	       &soleng_flash_map.phys,
1d25e3eeed1d98 Randy Dunlap   2018-07-24  64  	       &soleng_eprom_map.phys);
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  	flash_mtd->owner = THIS_MODULE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);
^1da177e4c3f41 Linus Torvalds 2005-04-16  68  	if (eprom_mtd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  		eprom_mtd->owner = THIS_MODULE;
ee0e87b174bb41 Jamie Iles     2011-05-23  70  		mtd_device_register(eprom_mtd, NULL, 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  
390e9eacf1dcec Paul Bolle     2014-05-23  73  	mtd_device_parse_register(flash_mtd, probes, NULL, NULL, 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  74  
^1da177e4c3f41 Linus Torvalds 2005-04-16  75  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  76  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  77  

:::::: The code at line 52 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

