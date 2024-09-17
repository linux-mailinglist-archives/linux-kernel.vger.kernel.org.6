Return-Path: <linux-kernel+bounces-332015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BC97B444
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E87286F19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17D18B46A;
	Tue, 17 Sep 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRpinGl6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D99839F7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600119; cv=none; b=BuZC32ylBt32eg7fFrId/MtGMsOASSEumKhJrH30un1zxdXpBnuFddyk8wZo7HhtDXa4t05F9FqlnXucFvwCzei+OA08FgEJ2+OxRi+ZE6jzzCcLdGWL3olHQog9kWqjkUfJeJxB3nZhxzGEccWrpkxBfoMo4Q+ilygs+ijT8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600119; c=relaxed/simple;
	bh=VVXyMdbz3pAXhVId3IFOhqp+xnxNabSG4U+cUwvSw6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QUkn0El8G91goiej3ZMck/Bynz3GQBMBb33zONInC7p7TPAP3MCwnwGIoTQDouyiosRmAdP/O25tr9A2tetAj49pXP5TNXl3rj8Z5/WpUDoGRorzs94KEIZ7QKOPWTzu2OxIoF9kfAu9X2mhaTpC0yc2JdSLWWYLftnG3ZtRht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRpinGl6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726600116; x=1758136116;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VVXyMdbz3pAXhVId3IFOhqp+xnxNabSG4U+cUwvSw6M=;
  b=IRpinGl6opMWxNU4W00et2ITQVnbBpqlXrDuTYdS19P/mvtq7lfbvmvJ
   bzkHQ5FrbiT4BqX0N58nqnaO/Bz/6rhceQK9ekOqOfIDtwuryH7FyrVuL
   l619XNtyXLEciMBBLm3EDLc/r4jistEmC/9Nie/sEnNtlsxR8/M9MBVsP
   gzbWStXyd/4+S4KVSEnp7F06U2cud63n3iRyfj6hovTwS/CcNcjQeNP6V
   R6Dzv3W//UOZUtDNT+ubK1pcBO4wJ7xgxJoRrc33ZdruTzwBU8Qrlr36s
   uNQbCFBNekFYqSNxGJS6VlTHP3exS2SnyC5xVcjHMLePlRr+Pg/GGs3td
   w==;
X-CSE-ConnectionGUID: xOIXInSYQ4Sfj5LU5NODdA==
X-CSE-MsgGUID: +Um0dypQRbeu4gDY0G+xcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25423628"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25423628"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 12:08:35 -0700
X-CSE-ConnectionGUID: AqTChU5fTsWWLKYfZUdXJQ==
X-CSE-MsgGUID: CxNczTqRRtmOiQ9homPyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="74124996"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Sep 2024 12:08:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqdYr-000BSY-0G;
	Tue, 17 Sep 2024 19:08:29 +0000
Date: Wed, 18 Sep 2024 03:08:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: drivers/gpu/drm/omapdrm/dss/dispc.c:4881:27: warning: stack frame
 size (2056) exceeds limit (2048) in 'dispc_runtime_resume'
Message-ID: <202409180339.6n97u08v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ville,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f27fce67173bbb05d5a0ee03dae5c021202c912
commit: dc6fcaaba5a5411237d042a26c4d46689f3346bb drm/omap: Allow build with COMPILE_TEST=y
date:   4 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240918/202409180339.6n97u08v-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180339.6n97u08v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180339.6n97u08v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/omapdrm/dss/dispc.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gpu/drm/omapdrm/dss/dispc.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/gpu/drm/omapdrm/dss/dispc.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/gpu/drm/omapdrm/dss/dispc.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
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
>> drivers/gpu/drm/omapdrm/dss/dispc.c:4881:27: warning: stack frame size (2056) exceeds limit (2048) in 'dispc_runtime_resume' [-Wframe-larger-than]
    4881 | static __maybe_unused int dispc_runtime_resume(struct device *dev)
         |                           ^
   14 warnings generated.


vim +/dispc_runtime_resume +4881 drivers/gpu/drm/omapdrm/dss/dispc.c

4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4880  
d6c75c295f67b2 drivers/gpu/drm/omapdrm/dss/dispc.c Arnd Bergmann    2021-12-05 @4881  static __maybe_unused int dispc_runtime_resume(struct device *dev)
4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4882  {
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4883  	struct dispc_device *dispc = dev_get_drvdata(dev);
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4884  
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4885  	/*
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4886  	 * The reset value for load mode is 0 (OMAP_DSS_LOAD_CLUT_AND_FRAME)
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4887  	 * but we always initialize it to 2 (OMAP_DSS_LOAD_FRAME_ONLY) in
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4888  	 * _omap_dispc_initial_config(). We can thus use it to detect if
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4889  	 * we have lost register context.
9229b5165bf0c4 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-02-14  4890  	 */
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4891  	if (REG_GET(dispc, DISPC_CONFIG, 2, 1) != OMAP_DSS_LOAD_FRAME_ONLY) {
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4892  		_omap_dispc_initial_config(dispc);
be07dcd7e239a8 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2013-11-21  4893  
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4894  		dispc_errata_i734_wa(dispc);
fbff010bd0b449 drivers/gpu/drm/omapdrm/dss/dispc.c Jyri Sarha       2016-06-07  4895  
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4896  		dispc_restore_context(dispc);
acc3a231d3d145 drivers/gpu/drm/omapdrm/dss/dispc.c Jyri Sarha       2016-06-07  4897  
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4898  		dispc_restore_gamma_tables(dispc);
0925afc9a4851c drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-04-11  4899  	}
0925afc9a4851c drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-04-11  4900  
1f6b6b6267ebe6 drivers/gpu/drm/omapdrm/dss/dispc.c Laurent Pinchart 2018-02-13  4901  	dispc->is_enabled = true;
0925afc9a4851c drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-04-11  4902  	/* ensure the dispc_irq_handler sees the is_enabled value */
0925afc9a4851c drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2014-04-11  4903  	smp_wmb();
4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4904  
4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4905  	return 0;
4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4906  }
4fbafaf371be78 drivers/video/omap2/dss/dispc.c     Tomi Valkeinen   2011-05-27  4907  

:::::: The code at line 4881 was first introduced by commit
:::::: d6c75c295f67b26fad8ba2e72db80e0f744e9da9 omapdrm: dss: mark runtime PM functions __maybe_unused

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

