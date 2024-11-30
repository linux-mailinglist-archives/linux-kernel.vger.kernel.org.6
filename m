Return-Path: <linux-kernel+bounces-426157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5D9DEF9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A06B21232
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA014BF87;
	Sat, 30 Nov 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3IHM35S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147251448F2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959385; cv=none; b=TCmBpHeWU2OERMZ2Y3POgQZc79tjyL9jBNCxHNOLLoQ5k80g2qsykTIShsAv6x1YuRZC/Yd6UbP7Nz8zJuPkN9Jjx4UDSmOqyjSpgAiFNX7EFLu0rFJsxF1E2bIYkezBR7NwuPmaFl0dh/NYgI/OaGL6vAYwQ+JY+RzF7opElcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959385; c=relaxed/simple;
	bh=KRGXrthuPFOyMm2BWQxsto+YZZVuiIhdKs8l13Kwlzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fB5LYhbftCBxFV+wVTC4r1fHurYspVCC3dCdEmEKk9aueDtvexTWf747Ewz7iGlHbn4h4MIO4C3oAsCWFHhTZqEeNoJpXYLVFe+ObfIHteQBRqmfeNugzcHj8hfI0frvYGCn9pXkR7PFTDKOOR77BZWfPPk3jQy5x8D4wE1c3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3IHM35S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732959384; x=1764495384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KRGXrthuPFOyMm2BWQxsto+YZZVuiIhdKs8l13Kwlzs=;
  b=Y3IHM35SaCwdMSlaTDaXvf7ME/Whs45XdH1LuIFrck35Bgu09ySjfTQM
   1twMHtT/L92IdwbuVeOi1Htuk5bvcuiQzQ+ml/tC/gWPu24i53Mo6e/sH
   tzVVv42epoVnXz6+92gVh9Eib5/OM3zZIyXiuDJo0r9AaYJFnkQ9TabRT
   3XDVJnNuHBQTDWfd4OSyZIPDQzRs2JOZ3wK/fnEZAwvaoKxBfkRrfAxR6
   zarZtnsM7I1i3rPPoZHL00MYVwk8EEjY5Zjrjr0kXmeI3xnBJOXbVuodX
   ShX0VkO0+oU2AJ6twJKN1kB7fzMSzuzsF/b/bQWroHk4l7jZ5/9/adNBU
   A==;
X-CSE-ConnectionGUID: MdS5d6suQCmGWN9yNLNqpQ==
X-CSE-MsgGUID: YZmmiDvZTbGghUSgoHE1mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="44544677"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="44544677"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 01:36:23 -0800
X-CSE-ConnectionGUID: /fJCFeQFTVC3Y90MEIByLA==
X-CSE-MsgGUID: d15pd0OiRSefhEyoOXQlgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="115934155"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 30 Nov 2024 01:36:22 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHJtW-0000Vl-0w;
	Sat, 30 Nov 2024 09:36:09 +0000
Date: Sat, 30 Nov 2024 17:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/mtd/nand/raw/sh_flctl.c:510:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202411301739.a3ivjvS3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 005b73d0dd83c9cb9420a196bea8070cde30ecac m68knommu: __force type casts for raw IO access
date:   4 years, 4 months ago
config: m68k-randconfig-r111-20241119 (https://download.01.org/0day-ci/archive/20241130/202411301739.a3ivjvS3-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241130/202411301739.a3ivjvS3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411301739.a3ivjvS3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:456:16: sparse: sparse: cast to restricted __le32
   drivers/mtd/nand/raw/sh_flctl.c:479:26: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/sh_flctl.c:494:38: sparse: sparse: cast to restricted __be32
>> drivers/mtd/nand/raw/sh_flctl.c:510:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:510:17: sparse:     expected unsigned int volatile [usertype]
   drivers/mtd/nand/raw/sh_flctl.c:510:17: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse:     expected unsigned long
   drivers/mtd/nand/raw/sh_flctl.c:523:24: sparse:     got restricted __be32 [usertype]

vim +510 drivers/mtd/nand/raw/sh_flctl.c

6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  500  
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  501  static void write_fiforeg(struct sh_flctl *flctl, int rlen,
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  502  						unsigned int offset)
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  503  {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  504  	int i, len_4align;
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19  505  	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  506  
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  507  	len_4align = (rlen + 3) / 4;
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  508  	for (i = 0; i < len_4align; i++) {
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  509  		wait_wfifo_ready(flctl);
e8a9d8f31c592e drivers/mtd/nand/sh_flctl.c Bastian Hecht     2012-10-19 @510  		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  511  	}
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  512  }
6028aa01f759a1 drivers/mtd/nand/sh_flctl.c Yoshihiro Shimoda 2008-10-14  513  

:::::: The code at line 510 was first introduced by commit
:::::: e8a9d8f31c592eea89f1b0d3fd425e7a96944e88 mtd: sh_flctl: Minor cleanups

:::::: TO: Bastian Hecht <hechtb@googlemail.com>
:::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

