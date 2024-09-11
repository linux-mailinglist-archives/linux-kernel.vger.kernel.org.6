Return-Path: <linux-kernel+bounces-325471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE7975A05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B1DB24C13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33551BA273;
	Wed, 11 Sep 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI6YsDOg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6ED1B9B58
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078033; cv=none; b=Sg9AXMN2FI27ClR38CSntLfohrAFQC4X/H3Ny+unZEa8cH4b1lkAD1GxLk1Xd3uZeGsW5nVdfglfFsrUwxTxhA2EusxiOQl3YQFh/vddpqUsh3OkJ0mYLu+FkILVReejHa2lJ0dowoktJHIQn2eZf8bp91V2eMLRglwT57uDx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078033; c=relaxed/simple;
	bh=wJ/1h/qDCV16AsynIfa1nL0nOvreN+hu2psBTFBTGxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PHuRZd335Ohpc/HJWClHx2Atyijsd/psA6WZihpbBx3ywXHboxU9o+z+Uylu4/eoHpOLagGNe8/gbjYxvkyIOF6l5er4luxrItZ4WYeM8jzlZRRRnuoKtGuwGw4rXpPNidoeqrpCFB/0pXpQI9dmRJt17Z6yITfQTE3TyAOlEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI6YsDOg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726078032; x=1757614032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wJ/1h/qDCV16AsynIfa1nL0nOvreN+hu2psBTFBTGxs=;
  b=bI6YsDOgAYzKofdGt8IcRfmFKUur8T5CON0gcwq6/0tp381bNEAMcB9R
   YOnDNnwDSpNEX7KBypmoa1osIS8+BeOSbe+MRO+DS5b01d2mpFC7MfLab
   VA+T4f/hf2UkTj3EW0tSk2dbaRlmI4iNJCikPx/ncyDFpQDL0N8pfEVc/
   nBELs7zCs6Vorvtuguzcws1gD7eDnslEK/K9ZkAuKx4zTsSyIXA02mgSI
   ZEiMTrjMvV8bj1AqBjJVDAbiQhaeJuzH5E0zl6hibCIgP5GzA9H3cECo6
   VwvFjPAJLRnUlPrlxLyVEFBkDbydCPmGkNxnzpkEm5WB+nAm8NHiVydZn
   g==;
X-CSE-ConnectionGUID: wqSJXOcbSIeOd7TI+64mvw==
X-CSE-MsgGUID: RkEKKjpFRAqJyAgqzOSMdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25032034"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="25032034"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 11:07:11 -0700
X-CSE-ConnectionGUID: lQaSQIxJTwe8pi/2kazLbw==
X-CSE-MsgGUID: IYF8BHDXR5qN/sc/E1N1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67678654"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2024 11:07:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soRkB-0003yg-16;
	Wed, 11 Sep 2024 18:07:07 +0000
Date: Thu, 12 Sep 2024 02:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/comedi/drivers/comedi_8254.c:139:31: sparse: sparse: cast to
 restricted __le16
Message-ID: <202409120105.yV1KBe45-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d8d276ba2fb5f9ac4984f5c10ae60858090babc
commit: 98a15816636044f25be4644db2a3e09fad68aaf7 Revert "comedi: add HAS_IOPORT dependencies"
date:   1 year ago
config: m68k-randconfig-r113-20240911 (https://download.01.org/0day-ci/archive/20240912/202409120105.yV1KBe45-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240912/202409120105.yV1KBe45-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409120105.yV1KBe45-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/comedi/drivers/comedi_8254.c:139:31: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/comedi_8254.c:139:31: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/comedi_8254.c:139:31: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/comedi_8254.c:139:31: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/comedi_8254.c: note: in included file (through arch/m68k/include/asm/io.h, include/linux/io.h):
   arch/m68k/include/asm/io_mm.h:164:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:164:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:164:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:164:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:164:21: sparse: sparse: Using plain integer as NULL pointer

vim +139 drivers/comedi/drivers/comedi_8254.c

d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  121  
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  122  static unsigned int __i8254_read(struct comedi_8254 *i8254, unsigned int reg)
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  123  {
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  124  	unsigned int reg_offset = (reg * i8254->iosize) << i8254->regshift;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  125  	unsigned int val;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  126  
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  127  	switch (i8254->iosize) {
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  128  	default:
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  129  	case I8254_IO8:
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  130  		if (i8254->mmio)
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  131  			val = readb(i8254->mmio + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  132  		else
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  133  			val = inb(i8254->iobase + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  134  		break;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  135  	case I8254_IO16:
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  136  		if (i8254->mmio)
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  137  			val = readw(i8254->mmio + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  138  		else
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23 @139  			val = inw(i8254->iobase + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  140  		break;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  141  	case I8254_IO32:
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  142  		if (i8254->mmio)
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  143  			val = readl(i8254->mmio + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  144  		else
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  145  			val = inl(i8254->iobase + reg_offset);
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  146  		break;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  147  	}
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  148  	return val & 0xff;
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  149  }
d42b5211d861f1 drivers/staging/comedi/drivers/comedi_8254.c H Hartley Sweeten 2015-02-23  150  

:::::: The code at line 139 was first introduced by commit
:::::: d42b5211d861f1077869e9133efa19297a6f152b staging: comedi: comedi_8254: introduce module for 8254 timer support

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

