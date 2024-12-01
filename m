Return-Path: <linux-kernel+bounces-426559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB09DF4F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00641162ABC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797F7082F;
	Sun,  1 Dec 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCgiUxWK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2954277
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733040658; cv=none; b=bF+LJlTDwlX+fn0z2RJBdeSgJB8vhYDv5F5lm8hg3q9M4WLKWezf/VauaMQkbc/PEzTX5I7UQrXQGj+93iLk7QDu2PcVDOGp+dkADBdF99ACU1rWjBgnXwN8YhQxsMVbCH1zxG9BlYBuTl8R4MEu6It3fgILChWFPeWj9bgJCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733040658; c=relaxed/simple;
	bh=0+pgO/7qnysvbLifVDdhqfVsDMvDtd7xOM81/6jbjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dkT0bbtHXRE++Ku/4juahfWzyLrrc7j/b/wfxw+nJDuNyAThY2bY5e6hbbE1OiB/xd9TrPL21fk30H/BoqsEqY7Y6xzyuVuG/BIO2KYOnEbks6l2YT6tzTaXJBa/6Zlt6bVvTXDwzLdl9l23ZokIS70Gq0/ftasW+MizQquSxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCgiUxWK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733040657; x=1764576657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0+pgO/7qnysvbLifVDdhqfVsDMvDtd7xOM81/6jbjF8=;
  b=gCgiUxWKpsoiHaXF1d6Fu8lLUcOnplfKuxDyxYLLmPmcNyysbLgo+1dW
   br28p5Pq6QwEhhalBMHbdpVL5EnDmzR6+/HggXI1amBAS8HJ96tFoQSi7
   7mUU8aDPNXPuW6Z9RMp2U1KFl8wwU3aCfWvnjIfNpSEeqH2MfpsVOtbGu
   K39cXEFvmJnGj0qRVY9vhTLWV6wvmm/U31EJq8VxbcWkOoioIYmVqpUF0
   KUDD/j2hsmj23PBGxt1uqOGZLqAaLlFoFrGzy5EaIe8/IvQqAlzj7SvG4
   R0aPvK4tX2TgSgmXmxYKQccfoNI/QVLlYyV+gF8mACeV0HJVGhB0sWC/A
   w==;
X-CSE-ConnectionGUID: ENuCfl6BTvq4kdPOUTI7SA==
X-CSE-MsgGUID: MXgnBP+GTVSuoZE2GpoUjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="36877941"
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="36877941"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 00:10:56 -0800
X-CSE-ConnectionGUID: CqnG80AFSWKbxVgF/Hj7+g==
X-CSE-MsgGUID: VY8pMU5bRIOk3NwNG5HeQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,200,1728975600"; 
   d="scan'208";a="116088813"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Dec 2024 00:10:55 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHf1T-0001N5-1w;
	Sun, 01 Dec 2024 08:09:50 +0000
Date: Sun, 1 Dec 2024 16:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: John Crispin <john@phrozen.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>
Subject: drivers/irqchip/irq-ath79-cpu.c:92:13: sparse: sparse: symbol
 'ath79_cpu_irq_init' was not declared. Should it be static?
Message-ID: <202412011509.kGQkDr1y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
commit: 51fa4f8912c0934cf1410f435516d2abbcf88a9e MIPS: ath79: drop legacy IRQ code
date:   6 years ago
config: mips-randconfig-r122-20241119 (https://download.01.org/0day-ci/archive/20241201/202412011509.kGQkDr1y-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241201/202412011509.kGQkDr1y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011509.kGQkDr1y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-ath79-cpu.c:92:13: sparse: sparse: symbol 'ath79_cpu_irq_init' was not declared. Should it be static?

vim +/ath79_cpu_irq_init +92 drivers/irqchip/irq-ath79-cpu.c

81ffb18ce4a0c4 Alban Bedel 2016-01-23  58  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  59  static int __init ar79_cpu_intc_of_init(
81ffb18ce4a0c4 Alban Bedel 2016-01-23  60  	struct device_node *node, struct device_node *parent)
81ffb18ce4a0c4 Alban Bedel 2016-01-23  61  {
81ffb18ce4a0c4 Alban Bedel 2016-01-23  62  	int err, i, count;
81ffb18ce4a0c4 Alban Bedel 2016-01-23  63  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  64  	/* Fill the irq_wb_chan table */
81ffb18ce4a0c4 Alban Bedel 2016-01-23  65  	count = of_count_phandle_with_args(
81ffb18ce4a0c4 Alban Bedel 2016-01-23  66  		node, "qca,ddr-wb-channels", "#qca,ddr-wb-channel-cells");
81ffb18ce4a0c4 Alban Bedel 2016-01-23  67  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  68  	for (i = 0; i < count; i++) {
81ffb18ce4a0c4 Alban Bedel 2016-01-23  69  		struct of_phandle_args args;
81ffb18ce4a0c4 Alban Bedel 2016-01-23  70  		u32 irq = i;
81ffb18ce4a0c4 Alban Bedel 2016-01-23  71  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  72  		of_property_read_u32_index(
81ffb18ce4a0c4 Alban Bedel 2016-01-23  73  			node, "qca,ddr-wb-channel-interrupts", i, &irq);
81ffb18ce4a0c4 Alban Bedel 2016-01-23  74  		if (irq >= ARRAY_SIZE(irq_wb_chan))
81ffb18ce4a0c4 Alban Bedel 2016-01-23  75  			continue;
81ffb18ce4a0c4 Alban Bedel 2016-01-23  76  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  77  		err = of_parse_phandle_with_args(
81ffb18ce4a0c4 Alban Bedel 2016-01-23  78  			node, "qca,ddr-wb-channels",
81ffb18ce4a0c4 Alban Bedel 2016-01-23  79  			"#qca,ddr-wb-channel-cells",
81ffb18ce4a0c4 Alban Bedel 2016-01-23  80  			i, &args);
81ffb18ce4a0c4 Alban Bedel 2016-01-23  81  		if (err)
81ffb18ce4a0c4 Alban Bedel 2016-01-23  82  			return err;
81ffb18ce4a0c4 Alban Bedel 2016-01-23  83  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  84  		irq_wb_chan[irq] = args.args[0];
81ffb18ce4a0c4 Alban Bedel 2016-01-23  85  	}
81ffb18ce4a0c4 Alban Bedel 2016-01-23  86  
81ffb18ce4a0c4 Alban Bedel 2016-01-23  87  	return mips_cpu_irq_of_init(node, parent);
81ffb18ce4a0c4 Alban Bedel 2016-01-23  88  }
81ffb18ce4a0c4 Alban Bedel 2016-01-23  89  IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
81ffb18ce4a0c4 Alban Bedel 2016-01-23  90  		ar79_cpu_intc_of_init);
81ffb18ce4a0c4 Alban Bedel 2016-01-23  91  
81ffb18ce4a0c4 Alban Bedel 2016-01-23 @92  void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)

:::::: The code at line 92 was first introduced by commit
:::::: 81ffb18ce4a0c400b051c3df67e452410d6be1ec irqchip/ath79-cpu: Move the CPU IRQ driver from arch/mips/ath79/

:::::: TO: Alban Bedel <albeu@free.fr>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

