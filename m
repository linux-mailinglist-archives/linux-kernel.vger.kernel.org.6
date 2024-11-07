Return-Path: <linux-kernel+bounces-399583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F599C0117
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6070DB22049
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6B1DFDB4;
	Thu,  7 Nov 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSoC+cqo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D4196D8F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971568; cv=none; b=FIgaKqU37vku0rwKIiYVzqhlP8/aYDpcNjfIVHc2uFvtp/XZ/cMDFW3K/ct7HlAaN6RDUo6j/5HNWpe9YRyt37b0NN6SpJ8xOG91ijhrw4CyEPubQ2UTBrs5TECLrpNw3pihDBDRZNwRYD1Xbtef7C0err6r4SJXdH3DJaehWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971568; c=relaxed/simple;
	bh=U5/ccJ77IXXKQq3eD1JDD1Vlv4ondkJEtPe/ExT09Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=feJGW6T+eYUmOT7VSSG+Bil4H6Ounx+3Jy+D2+yNokNp3aNoLrPj88de44JS1uxNa+Y3cJ11uOVstuEYyLFYy0lSXV+oKjWv4BK9u/NSPOWLR2qQEE02tTNVPMypERg9SkH+oH/yyKpHc7USmTF3zB5vzfEKTrsGBDjWXUSNX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSoC+cqo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730971566; x=1762507566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U5/ccJ77IXXKQq3eD1JDD1Vlv4ondkJEtPe/ExT09Ow=;
  b=LSoC+cqoXE3tlbOLDCq67uLWLGs3zQ8J9SBRIsUDw1P86ZnkY94VeS5+
   Ekeh74umn7DSdWrpDlw0u4apXeO+EoYenOuk4kfJnmV3qkjWMnu+mBknm
   aNFgQ9pHWm7GFzQGwpB5WmgbC0/o7qKpZ5dQ0LR5MB2uz2wUzWe3JE8KP
   YEmh+CAHjmEqBMSYuPtQdlo1L9jSIsQQvJHvYNM8RKugoQNeKNt8MOrwj
   D2NbFs1cnB62Tx+DhFkWawOfcqstL6G6R+HaJyfkMcJtz3xWVhLqtNFsd
   YwNUs2WEf93A5bSf27Lwf3KojwXmxHR7pGbU6Y18FoZSHeaBKELHdMp6X
   g==;
X-CSE-ConnectionGUID: 6C0EabZrR9CZhNNYs52YGw==
X-CSE-MsgGUID: Ug/m/S5ITIikcePfUEycLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30964564"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30964564"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 01:26:06 -0800
X-CSE-ConnectionGUID: a4xoUCBFTySR3v5DdN5pug==
X-CSE-MsgGUID: zii9D0O3QkapifSm/3ap1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="122504058"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Nov 2024 01:26:04 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8ymA-000q38-11;
	Thu, 07 Nov 2024 09:26:02 +0000
Date: Thu, 7 Nov 2024 17:25:03 +0800
From: kernel test robot <lkp@intel.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: arch/sh/cchips/hd6446x/hd64461.c:27:16: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202411071733.0WhA131G-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Artur,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2
commit: 1e21acb7fbfb15fcb4afe21fb5a50a1bc00743ec sh: hd64461: Make setup_hd64461() static
date:   8 months ago
config: sh-randconfig-r111-20241107 (https://download.01.org/0day-ci/archive/20241107/202411071733.0WhA131G-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241107/202411071733.0WhA131G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411071733.0WhA131G-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/sh/cchips/hd6446x/hd64461.c:27:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:27:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:27:16: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:29:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:29:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:29:9: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:38:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:38:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:38:16: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:40:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:40:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:40:9: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:49:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:49:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:49:17: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse:     got unsigned int
>> arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse:     got unsigned long
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:105:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:105:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:105:9: sparse:     got unsigned int
   arch/sh/cchips/hd6446x/hd64461.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:106:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:106:9: sparse:     got unsigned int

vim +27 arch/sh/cchips/hd6446x/hd64461.c

f1382305b9357c arch/sh/cchips/hd6446x/hd64461.c       Kristoffer Ericson    2007-09-11   20  
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   21  static void hd64461_mask_irq(struct irq_data *data)
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   22  {
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   23  	unsigned int irq = data->irq;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   24  	unsigned short nimr;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   25  	unsigned short mask = 1 << (irq - HD64461_IRQBASE);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   26  
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28  @27  	nimr = __raw_readw(HD64461_NIMR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   28  	nimr |= mask;
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   29  	__raw_writew(nimr, HD64461_NIMR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   30  }
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   31  
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   32  static void hd64461_unmask_irq(struct irq_data *data)
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   33  {
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   34  	unsigned int irq = data->irq;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   35  	unsigned short nimr;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   36  	unsigned short mask = 1 << (irq - HD64461_IRQBASE);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   37  
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   38  	nimr = __raw_readw(HD64461_NIMR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   39  	nimr &= ~mask;
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   40  	__raw_writew(nimr, HD64461_NIMR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   41  }
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   42  
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   43  static void hd64461_mask_and_ack_irq(struct irq_data *data)
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   44  {
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   45  	hd64461_mask_irq(data);
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   46  
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   47  #ifdef CONFIG_HD64461_ENABLER
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   48  	if (data->irq == HD64461_IRQBASE + 13)
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   49  		__raw_writeb(0x00, HD64461_PCC1CSCR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   50  #endif
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   51  }
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   52  
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   53  static struct irq_chip hd64461_irq_chip = {
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   54  	.name		= "HD64461-IRQ",
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   55  	.irq_mask	= hd64461_mask_irq,
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   56  	.irq_mask_ack	= hd64461_mask_and_ack_irq,
19add7e11656dc arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-10-27   57  	.irq_unmask	= hd64461_unmask_irq,
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   58  };
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   59  
bd0b9ac405e179 arch/sh/cchips/hd6446x/hd64461.c       Thomas Gleixner       2015-09-14   60  static void hd64461_irq_demux(struct irq_desc *desc)
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   61  {
9d56dd3b083a3b arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-01-26   62  	unsigned short intv = __raw_readw(HD64461_NIRR);
3bf509230a626d arch/sh/cchips/hd6446x/hd64461.c       Rafael Ignacio Zurita 2009-03-20   63  	unsigned int ext_irq = HD64461_IRQBASE;
3bf509230a626d arch/sh/cchips/hd6446x/hd64461.c       Rafael Ignacio Zurita 2009-03-20   64  
3bf509230a626d arch/sh/cchips/hd6446x/hd64461.c       Rafael Ignacio Zurita 2009-03-20   65  	intv &= (1 << HD64461_IRQ_NUM) - 1;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   66  
b06ede84dd1473 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-05   67  	for (; intv; intv >>= 1, ext_irq++) {
b06ede84dd1473 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-05   68  		if (!(intv & 1))
b06ede84dd1473 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-05   69  			continue;
b06ede84dd1473 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-05   70  
b06ede84dd1473 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-05   71  		generic_handle_irq(ext_irq);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   72  	}
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   73  }
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   74  
1e21acb7fbfb15 arch/sh/cchips/hd6446x/hd64461.c       Artur Rojek           2024-02-11   75  static int __init setup_hd64461(void)
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   76  {
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   77  	int irq_base, i;
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   78  
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   79  	printk(KERN_INFO
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   80  	       "HD64461 configured at 0x%x on irq %d(mapped into %d to %d)\n",
62669e61a5f559 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2009-05-20   81  	       HD64461_IOBASE, CONFIG_HD64461_IRQ, HD64461_IRQBASE,
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   82  	       HD64461_IRQBASE + 15);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   83  
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   84  /* Should be at processor specific part.. */
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   85  #if defined(CONFIG_CPU_SUBTYPE_SH7709)
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28  @86  	__raw_writew(0x2240, INTC_ICR1);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   87  #endif
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   88  	__raw_writew(0xffff, HD64461_NIMR);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   89  
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   90  	irq_base = irq_alloc_descs(HD64461_IRQBASE, HD64461_IRQBASE, 16, -1);
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   91  	if (IS_ERR_VALUE(irq_base)) {
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   92  		pr_err("%s: failed hooking irqs for HD64461\n", __func__);
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   93  		return irq_base;
6eb6f98396f7bd arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-02   94  	}
6eb6f98396f7bd arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2010-02-02   95  
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   96  	for (i = 0; i < 16; i++)
051f923d922d10 arch/sh/cchips/hd6446x/hd64461.c       Paul Mundt            2012-05-18   97  		irq_set_chip_and_handler(irq_base + i, &hd64461_irq_chip,
135210b378d26f arch/sh/cchips/hd6446x/hd64461.c       Matt Fleming          2008-11-28   98  					 handle_level_irq);
^1da177e4c3f41 arch/sh/cchips/hd6446x/hd64461/setup.c Linus Torvalds        2005-04-16   99  
fcb8918fd242f3 arch/sh/cchips/hd6446x/hd64461.c       Thomas Gleixner       2011-03-24  100  	irq_set_chained_handler(CONFIG_HD64461_IRQ, hd64461_irq_demux);
fcb8918fd242f3 arch/sh/cchips/hd6446x/hd64461.c       Thomas Gleixner       2011-03-24  101  	irq_set_irq_type(CONFIG_HD64461_IRQ, IRQ_TYPE_LEVEL_LOW);
3bf509230a626d arch/sh/cchips/hd6446x/hd64461.c       Rafael Ignacio Zurita 2009-03-20  102  

:::::: The code at line 27 was first introduced by commit
:::::: 135210b378d26f9a9a0c901d0089522c06b5807a sh: Switch HD64461 from hw_interrupt_type to irq_chip

:::::: TO: Matt Fleming <mjf@gentoo.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

