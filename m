Return-Path: <linux-kernel+bounces-428659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60B9E11E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567D0B217AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2215EFA1;
	Tue,  3 Dec 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S890G2d/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FD1FC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197126; cv=none; b=tQHP26S4AkrwMAYUko3PM25AX9oxj751ZyHJLZAL54nEzJmMrMexxotWjpFhigZYBi14mn6qHcMv+joVRkXLoOITay7xgSyRvvos3+X5fCTMPwfWe+hI5LmVDIqobEzBbN4zm04rmuWx07zFxgTNG6p/ypm5JsWY/XF4b+UN3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197126; c=relaxed/simple;
	bh=1zp5HtnmoPX/Xnx/hZlDQFxVoXM+hT7X3CYtNLA8XEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=meGtqsObDCUBN/GSp9FGO8odQG6p6DmtFvNDH+TVTr3x5sJXLnAH2dDOgN/w5Z8EtbnvT9VkKaH23aK7GYNVuGtRq2w7hk7dQyhlnOVFtKvoPbIUG2ZAPWvPWQBhAdu2ZWAO8eRQS/jlidGp9HjCg1VKtXv8C00IWKYmTgvi9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S890G2d/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733197125; x=1764733125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1zp5HtnmoPX/Xnx/hZlDQFxVoXM+hT7X3CYtNLA8XEE=;
  b=S890G2d/jYaKx+UuV/PDnJqi5fQsPaPab0KafTTyZxh1vb++N/J412gZ
   GDugK7gGrlRTGEQ8/bRCJXplhWTTP2MQlW110TtteQSQzLZWNQCan5s/i
   75C6AA70nFEthxwfVrKEa9MF98mxYcnesn3utGWxUxjIPgHbNDLcjV/7F
   zhjIOjbXIWFbZL5b2Dfif+2QVjL+e4lRam+apcoctWjSQUrSdynOzzhpJ
   GiIWfAdha/NUOs0y+zfz08NXs6GXxKVjR9j3AVRlI8ikyGoOkTFIOy+MP
   6+rwTmBRfWLpC/NwiOWj8wNZYNsoludzDRu2DvowmeaoVjosCunisQRmp
   g==;
X-CSE-ConnectionGUID: c5Yn9FWqSaCUTciyYGO3hA==
X-CSE-MsgGUID: +ppfrkd8R6S4TRlVDTJ/5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44779758"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44779758"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:38:44 -0800
X-CSE-ConnectionGUID: /I0dctYoScS42YOfv4zNxw==
X-CSE-MsgGUID: 8woiB/UwRKWjg0ZUD6HPWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="92968096"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Dec 2024 19:38:22 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIJjw-000029-0S;
	Tue, 03 Dec 2024 03:38:20 +0000
Date: Tue, 3 Dec 2024 11:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202412031124.o0Te9YD6-lkp@intel.com>
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
commit: 15104de122a4f0258981b06ed94cf616a6eb03ef x86: Adjust types used in port I/O helpers
date:   2 years, 8 months ago
config: i386-randconfig-062-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031124.o0Te9YD6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031124.o0Te9YD6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031124.o0Te9YD6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     expected unsigned int [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     got restricted __le32 [usertype]
>> drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     expected unsigned short [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse:     expected unsigned int val
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:24: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short val @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse:     expected unsigned short val
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:24: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     got void *
--
>> drivers/tty/ipwireless/hardware.c:431:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:431:30: sparse:     expected unsigned short [usertype] value
   drivers/tty/ipwireless/hardware.c:431:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     expected unsigned short [usertype] value
   drivers/tty/ipwireless/hardware.c:445:30: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short @@
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:46: sparse:     got unsigned short
   drivers/tty/ipwireless/hardware.c:889:46: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short @@
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:889:46: sparse:     got unsigned short

vim +452 drivers/isdn/hardware/mISDN/hfcmulti.c

af69fb3a8ffa37e Karsten Keil 2008-07-27  445  
af69fb3a8ffa37e Karsten Keil 2008-07-27  446  /* write fifo data (REGIO) */
5b8343540a3d27f Hannes Eder  2008-12-12  447  static void
af69fb3a8ffa37e Karsten Keil 2008-07-27  448  write_fifo_regio(struct hfc_multi *hc, u_char *data, int len)
af69fb3a8ffa37e Karsten Keil 2008-07-27  449  {
af69fb3a8ffa37e Karsten Keil 2008-07-27  450  	outb(A_FIFO_DATA0, (hc->pci_iobase) + 4);
af69fb3a8ffa37e Karsten Keil 2008-07-27  451  	while (len >> 2) {
b3e0aeeb7e0f897 Karsten Keil 2008-08-02 @452  		outl(cpu_to_le32(*(u32 *)data), hc->pci_iobase);
af69fb3a8ffa37e Karsten Keil 2008-07-27  453  		data += 4;
af69fb3a8ffa37e Karsten Keil 2008-07-27  454  		len -= 4;
af69fb3a8ffa37e Karsten Keil 2008-07-27  455  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  456  	while (len >> 1) {
b3e0aeeb7e0f897 Karsten Keil 2008-08-02 @457  		outw(cpu_to_le16(*(u16 *)data), hc->pci_iobase);
af69fb3a8ffa37e Karsten Keil 2008-07-27  458  		data += 2;
af69fb3a8ffa37e Karsten Keil 2008-07-27  459  		len -= 2;
af69fb3a8ffa37e Karsten Keil 2008-07-27  460  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  461  	while (len) {
af69fb3a8ffa37e Karsten Keil 2008-07-27  462  		outb(*data, hc->pci_iobase);
af69fb3a8ffa37e Karsten Keil 2008-07-27  463  		data++;
af69fb3a8ffa37e Karsten Keil 2008-07-27  464  		len--;
af69fb3a8ffa37e Karsten Keil 2008-07-27  465  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  466  }
af69fb3a8ffa37e Karsten Keil 2008-07-27  467  /* write fifo data (PCIMEM) */
5b8343540a3d27f Hannes Eder  2008-12-12  468  static void
af69fb3a8ffa37e Karsten Keil 2008-07-27  469  write_fifo_pcimem(struct hfc_multi *hc, u_char *data, int len)
af69fb3a8ffa37e Karsten Keil 2008-07-27  470  {
af69fb3a8ffa37e Karsten Keil 2008-07-27  471  	while (len >> 2) {
b3e0aeeb7e0f897 Karsten Keil 2008-08-02  472  		writel(cpu_to_le32(*(u32 *)data),
b3e0aeeb7e0f897 Karsten Keil 2008-08-02  473  		       hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37e Karsten Keil 2008-07-27  474  		data += 4;
af69fb3a8ffa37e Karsten Keil 2008-07-27  475  		len -= 4;
af69fb3a8ffa37e Karsten Keil 2008-07-27  476  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  477  	while (len >> 1) {
b3e0aeeb7e0f897 Karsten Keil 2008-08-02  478  		writew(cpu_to_le16(*(u16 *)data),
b3e0aeeb7e0f897 Karsten Keil 2008-08-02  479  		       hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37e Karsten Keil 2008-07-27  480  		data += 2;
af69fb3a8ffa37e Karsten Keil 2008-07-27  481  		len -= 2;
af69fb3a8ffa37e Karsten Keil 2008-07-27  482  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  483  	while (len) {
b3e0aeeb7e0f897 Karsten Keil 2008-08-02  484  		writeb(*data, hc->pci_membase + A_FIFO_DATA0);
af69fb3a8ffa37e Karsten Keil 2008-07-27  485  		data++;
af69fb3a8ffa37e Karsten Keil 2008-07-27  486  		len--;
af69fb3a8ffa37e Karsten Keil 2008-07-27  487  	}
af69fb3a8ffa37e Karsten Keil 2008-07-27  488  }
eac74af9b547e29 Karsten Keil 2009-05-22  489  

:::::: The code at line 452 was first introduced by commit
:::::: b3e0aeeb7e0f89791c4c3bdfd98b36074c5178e6 Fix remaining big endian issue of hfcmulti

:::::: TO: Karsten Keil <kkeil@suse.de>
:::::: CC: Karsten Keil <kkeil@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

