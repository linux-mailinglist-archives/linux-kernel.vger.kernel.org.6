Return-Path: <linux-kernel+bounces-418952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EC9D67BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA821612CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4A15C144;
	Sat, 23 Nov 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlwEBwRK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D7F4FA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732340896; cv=none; b=hJvX87rhIwYrXqNKe5IOUr4lgVzHlECc2u7JVU/q6xebvFEeZkCV5Hp2/d92Z7Cf+zEK3WZAvmuZS6w9Y22UCmSzPi7yxvXBzoLg81e5RSQ6RRZxhKAJyUlUpybduXgpMZ5ZlDkCApPCthQN0UyN6dhesUDFT6aHi+2kQkIA+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732340896; c=relaxed/simple;
	bh=JxW8BdtAY8/vxbG0fEallOS3z5SOwSSEhjeIh5GXuS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bPbteQyq7FYnpxi2yqQ1KziUk9sjXjYKB9K38Htxa6uNdjDR6gDtD356FdSttyQdQD7nKcEW6Vg/WqR/6hYsjJuKjZGvPiFRT1/agIb1mGwpATJ1dTkPajjANNg3x/OhMS+ovy8jvkvtuawyXO6QX+Xa5FB8rflH+EbMgJpKC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlwEBwRK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732340893; x=1763876893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JxW8BdtAY8/vxbG0fEallOS3z5SOwSSEhjeIh5GXuS0=;
  b=MlwEBwRK94Yl+uVdxfW0eTewqkFqfkRXJN6VOVQGk4qVeRfikaIFp0lg
   izJOhc5HGMNfrE6BdkhecV71hrs8yR7g+SC+y5u2jM6ghnoI/poC6jiMl
   k1I8Pm/THnMvMmM94JB4YAn/SQJROBeVcPzzo+VS/N6sg14hcixh+sHIb
   dVbOJJC9t28XqULs3gA4G8TCnDUXgLdLv3F7a6SAyqZgtMPQm9pTTGx7i
   ObWiyWv5tTR0l+YgTpN5sEAB/HuobSMdSaITUXqFC9HSm6vekp4Pgf7cQ
   jccQ1ZTNb8A7j235XKD+Z7keBlyzRyaIo1nZKblmMZyZFRAJYDrMhaTCX
   A==;
X-CSE-ConnectionGUID: fZHEhoklSSOHTAHurJIEQg==
X-CSE-MsgGUID: vmIeSNLeSZWTQ+4JteRzDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43118636"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43118636"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 21:48:13 -0800
X-CSE-ConnectionGUID: P3XGoM1hT4ClTh6MZSa71Q==
X-CSE-MsgGUID: HnWEDpfySl6BVxL42b3RaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95699697"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Nov 2024 21:48:11 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEj04-0004S7-3B;
	Sat, 23 Nov 2024 05:48:08 +0000
Date: Sat, 23 Nov 2024 13:47:20 +0800
From: kernel test robot <lkp@intel.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: arch/sh/cchips/hd6446x/hd64461.c:27:16: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202411231306.6FROo9Kg-lkp@intel.com>
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
head:   2a163a4cea153348172e260a0c5b5569103a66a3
commit: 1e21acb7fbfb15fcb4afe21fb5a50a1bc00743ec sh: hd64461: Make setup_hd64461() static
date:   8 months ago
config: sh-randconfig-r133-20241123 (https://download.01.org/0day-ci/archive/20241123/202411231306.6FROo9Kg-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241123/202411231306.6FROo9Kg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411231306.6FROo9Kg-lkp@intel.com/

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
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:62:31: sparse:     got unsigned int
>> arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:86:9: sparse:     got unsigned long
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/cchips/hd6446x/hd64461.c:88:9: sparse:     got unsigned int

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

