Return-Path: <linux-kernel+bounces-373612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7EA9A5964
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462E2B2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A01990D0;
	Mon, 21 Oct 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROfo3rCr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC0187FE4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729483240; cv=none; b=dBYbQnsSl6XrT5isRgbY4t1ogIlXylzOetMzp4kUePr2RogyKKNHDQfBAc4JpAtNQE4Y1q4iL6VSe9BPEAdfwC94X3GPa4wz2gOs19T28SSg9LlS5YRWbOXZeCE7e7ln3nQNol0WhEtQNge418H+yd3nJm2UbZjNUd03g8008b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729483240; c=relaxed/simple;
	bh=KPwaQfgL5UdQTL0Ck0/QRdf944jj7b2G8Gs0rKT8LNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JAh0cRh5l5lLilMbaxP86/d0vj4UwsyAXA71OL2gyxoQrEgBTGIHQKGA8AQ3mv10TalI/U8BvoxTcsT5G3slFZxw5cqtcwo/u0noiK/nuHlPIm7RaV5qiOGmOW3o3JPbrXwJ4gkC4vLirGItOVlGEPkDviQ5vbwnsKIpGjsG4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROfo3rCr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729483239; x=1761019239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPwaQfgL5UdQTL0Ck0/QRdf944jj7b2G8Gs0rKT8LNI=;
  b=ROfo3rCr8zDdxmDVQteucAoKKLUbrOPnupLWDd/emdzS0xdgx5KvXRaV
   YvczU0mN8eA7sytKT2WzY7tEH9kQYwwhDUgitMKqCTdYFwccckBiexktQ
   dNivFf8E23l6wuZ1g3Rhw/AP3Vtj1DdwS57177uZqqCQI8BDlw+eQ2I/a
   ucQ2cLLBdkoCfbEHoIZWfrT2JeBiHNZhLLSEoka94qVAeGvFC9bJTfrOB
   BaAeNETg41Hnl95UT6JYggpBxDBoVdD5CAE0ba3faOEF+fy4gxCBwNz7R
   nuvIm/D3vMldUYcevd9agvJVdpMPfTVzqNfP5UBxa2VwHFoCumA8c9f5q
   g==;
X-CSE-ConnectionGUID: ILCacb7wS4eGbHRxRMOdEw==
X-CSE-MsgGUID: x+G5jcsWRJWm+tjhZjKERQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28829391"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28829391"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 21:00:38 -0700
X-CSE-ConnectionGUID: PzDkbZPtRjymmlY6O+0eKw==
X-CSE-MsgGUID: zTyqm3CzRXuiSKauEsgw6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="79052803"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Oct 2024 21:00:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2jas-000R8C-1W;
	Mon, 21 Oct 2024 04:00:34 +0000
Date: Mon, 21 Oct 2024 11:59:37 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: drivers/ata/pata_gayle.c:53:27: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202410211139.nbQGaA39-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42f7652d3eb527d03665b09edac47f85fb600924
commit: c7db3832ff19a9a1116c1b3d435c9db165a2f2f8 m68k: io: Mark mmio read addresses as const
date:   1 year, 1 month ago
config: m68k-randconfig-r132-20241021 (https://download.01.org/0day-ci/archive/20241021/202410211139.nbQGaA39-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241021/202410211139.nbQGaA39-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211139.nbQGaA39-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/ata/pata_gayle.c:53:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_gayle.c:53:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:53:27: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:53:27: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:55:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:55:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:55:28: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:55:28: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:65:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:65:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:65:35: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:65:35: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:69:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c:69:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *port @@     got unsigned short [usertype] * @@
   drivers/ata/pata_gayle.c:69:36: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *port
   drivers/ata/pata_gayle.c:69:36: sparse:     got unsigned short [usertype] *
   drivers/ata/pata_gayle.c:181:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_gayle.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +53 drivers/ata/pata_gayle.c

9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  40  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  41  /* FIXME: is this needed? */
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  42  static unsigned int pata_gayle_data_xfer(struct ata_queued_cmd *qc,
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  43  					 unsigned char *buf,
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  44  					 unsigned int buflen, int rw)
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  45  {
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  46  	struct ata_device *dev = qc->dev;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  47  	struct ata_port *ap = dev->link->ap;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  48  	void __iomem *data_addr = ap->ioaddr.data_addr;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  49  	unsigned int words = buflen >> 1;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  50  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  51  	/* Transfer multiple of 2 bytes */
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  52  	if (rw == READ)
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16 @53  		raw_insw((u16 *)data_addr, (u16 *)buf, words);
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  54  	else
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  55  		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  56  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  57  	/* Transfer trailing byte, if any. */
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  58  	if (unlikely(buflen & 0x01)) {
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  59  		unsigned char pad[2] = { };
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  60  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  61  		/* Point buf to the tail of buffer */
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  62  		buf += buflen - 1;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  63  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  64  		if (rw == READ) {
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  65  			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  66  			*buf = pad[0];
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  67  		} else {
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  68  			pad[0] = *buf;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  69  			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  70  		}
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  71  		words++;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  72  	}
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  73  
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  74  	return words << 1;
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  75  }
9ab27d1d35fda0 Bartlomiej Zolnierkiewicz 2018-03-16  76  

:::::: The code at line 53 was first introduced by commit
:::::: 9ab27d1d35fda0c5fce624083e92546a8545e7e5 ata: add Amiga Gayle PATA controller driver

:::::: TO: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

