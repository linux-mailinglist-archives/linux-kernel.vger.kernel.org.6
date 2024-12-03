Return-Path: <linux-kernel+bounces-428638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865A9E11A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E77B225FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD2537FF;
	Tue,  3 Dec 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kstq9CzI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCF364AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195991; cv=none; b=NW1NYtOqarJb+KpEdW4NzGCx1zSJ1m78QbTqHLULHWuyHmYE5Uidzu01O3gTH8zWc4WG+TX236l/68146rw8BMM3QQEBLw6NNK6g9Rp5rmC8fUZVoJbFFNPjesvhXRuhTEN51PcBKzqIBF1B7dxBX1fZ7oKvAyV7WMYQpEvMw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195991; c=relaxed/simple;
	bh=7+Q6MAMzvG4nZi1d55VvgRBaQyiillqR8GyY2R6XpFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RvB1crLLYals1eOdxZPTEuSHQcFcFtl4QclDuDJBzJqotBQl0qXO8I9gDTOrcA3SLBGK7dQj+IjzYK1m8pM+dfZTCf7W3L2uP0pWeD0ZYxUrwTQV8c80t6y3nTZ2DRNdVJb64C0wwRoVvvWLvLgqAXLCVhjQyTMAy6h25YBWQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kstq9CzI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733195990; x=1764731990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7+Q6MAMzvG4nZi1d55VvgRBaQyiillqR8GyY2R6XpFM=;
  b=Kstq9CzInBEzGy0spABRBNyNmmyd+CjybEEolUmWDuZr35w/X6Z4UGe5
   P2X7/YZYDoUpcTPVbRrmWiAuaRraO9D0038nte7pOtuMmfvc8rxeefM+t
   qbLYAZgBTXHoMjHNaGyKn3MLv3y3S5SPNzpf6vXCKU+yrCLkTU1LdAG/n
   m+4uj/7W8A1Xbkzuc1qz2GGHPurwzZPrtj+jQmgPDnC1Rgdq+FKQ9ra85
   23COWIvekQau1QYV38cP5acABmR1KgMclIBqUhFiZwJrZUUZHUWoqO2hA
   d86ppqWIuHYyt/dbspWSE6SwjH8jgcU38P1CB7OezOb8CpnR/qSCQjA3a
   Q==;
X-CSE-ConnectionGUID: sF8IOwEJRNKKkuwfUnKYhA==
X-CSE-MsgGUID: GVVCxvWmR+qUvJ+aozABxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44777475"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44777475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:19:49 -0800
X-CSE-ConnectionGUID: PpxbGhjXS5+AmFsPhlMGBw==
X-CSE-MsgGUID: 5JDEs3n4Q4izTdasyaOGmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124135160"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 19:19:47 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIJRu-0003Df-1X;
	Tue, 03 Dec 2024 03:19:43 +0000
Date: Tue, 3 Dec 2024 11:17:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202412031102.G0OBzQ8g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 938a000e3f9bead24ea753286b3e4d2423275c9e fortify: Detect struct member overflows in memmove() at compile-time
date:   2 years, 10 months ago
config: i386-randconfig-063-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031102.G0OBzQ8g-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031102.G0OBzQ8g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031102.G0OBzQ8g-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src

vim +496 drivers/video/fbdev/hgafb.c

^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  482  
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  483  static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  484  {
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  485  	u_int rows, y1, y2;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  486  	u8 __iomem *src;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  487  	u8 __iomem *dest;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  488  
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  489  	if (area->dy <= area->sy) {
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  490  		y1 = area->sy;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  491  		y2 = area->dy;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  492  
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  493  		for (rows = area->height; rows--; ) {
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  494  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  495  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d2 drivers/video/hgafb.c Brent Cook     2010-12-31 @496  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  497  			y1++;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  498  			y2++;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  499  		}
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  500  	} else {
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  501  		y1 = area->sy + area->height - 1;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  502  		y2 = area->dy + area->height - 1;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  503  
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  504  		for (rows = area->height; rows--;) {
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  505  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  506  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d2 drivers/video/hgafb.c Brent Cook     2010-12-31  507  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  508  			y1--;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  509  			y2--;
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  510  		}
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  511  	}
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  512  }
^1da177e4c3f415 drivers/video/hgafb.c Linus Torvalds 2005-04-16  513  

:::::: The code at line 496 was first introduced by commit
:::::: 529ed806d4540d23ca2f68b28c3715d1566fc3ac video: Fix the HGA framebuffer driver

:::::: TO: Brent Cook <busterb@gmail.com>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

