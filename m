Return-Path: <linux-kernel+bounces-446468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40F9F24B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4127C18856C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB9191F81;
	Sun, 15 Dec 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlqoMaqi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C9A47
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278154; cv=none; b=fkP4m1sqrHiK0tPQoL3yRDoR8EdkooHX0kzvufo438KOIUWaF4S7FJVQ4o+D+b8NMv6hmZtCTkaqhQ5vsNk/tRZrOYu1ViY57Kw68IU3NAb4Ogrxuw8s/7uoKDZ2RDhRrD9N4xEnFq3e54K1pMiPo/BejR8OKnTNygBa2fN3JHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278154; c=relaxed/simple;
	bh=XhzlO11oB49O9ZSFGwKnpdQOYtdsGxUrSdCaZO9CiPw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uB7DSAuOZwvFonTN8i7dxkQeVNo+JdycMM6mekDY/oobOexUtHzi2EU6Jx2+H7ysF/MOXjlbupCXSk4VAVJJcI4vlCtkzwd9dBSo0XtPTNrRohyGYnjigVxS2IHOqaHAbSwPvZ+y+F2gaHhhv0pmlsCVnLXqpxZsULkX3y6HaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlqoMaqi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734278153; x=1765814153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XhzlO11oB49O9ZSFGwKnpdQOYtdsGxUrSdCaZO9CiPw=;
  b=XlqoMaqiMEr6WWrQNnbhc5BCBdim/MZjVWoIee0ZZhAuAg4zCgRe3v5F
   RXINam0uceY7idFyyIdHC1a1wHq5XaPsn6qitSCccK2q5ZF1z57cPy7zw
   xtbcW/pWBAGFqcVndEWCPYf9KhAPrXQYYy7mmC2QjXb8bdg60mhv5ztWP
   CmtNxyTeU0c6LShMr5KaSegUCk6nVOL7bvAqcr2Y5VfYTTGvbwHJ3NRKB
   31uBicE6ObaCFb8Xot29i3vwk7Lu/bZadjN34G6oU99yA1TIpA8dE/X9/
   PJlVkxXelCKtlf1hVty9t3fcKCe1pdievDHNPSltHTKBtBAeZwLViLNLh
   w==;
X-CSE-ConnectionGUID: iaFq7yIhTG2+mnftfQPktA==
X-CSE-MsgGUID: ++IQfeFRQr+NtjUXVH3ofg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45673709"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45673709"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 07:55:53 -0800
X-CSE-ConnectionGUID: 4Di3BDa1SzeMfAOgX6yAbA==
X-CSE-MsgGUID: UDF2rVvjQICov6zTJR7KmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97780346"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Dec 2024 07:55:51 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMqyD-000DhG-02;
	Sun, 15 Dec 2024 15:55:49 +0000
Date: Sun, 15 Dec 2024 23:55:28 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might
 be a candidate for 'gnu_printf' format attribute
Message-ID: <202412152318.z9ab4gLN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
commit: 63aadb77669a6856b26d73da85b4f788731524a3 m68k: coldfire: use clkdev_lookup on most coldfire
date:   3 years, 6 months ago
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20241215/202412152318.z9ab4gLN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152318.z9ab4gLN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412152318.z9ab4gLN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/clkdev.c: In function 'vclkdev_alloc':
>> drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     173 |                 vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
         |                 ^~~~~~~~~~


vim +173 drivers/clk/clkdev.c

0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  155  
bd721ea73e1f965 drivers/clk/clkdev.c     Fabian Frederick 2016-08-02  156  static struct clk_lookup * __ref
d5622a9c13752be drivers/clk/clkdev.c     Russell King     2015-03-02  157  vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
e9d7f4065408e92 drivers/clk/clkdev.c     Russell King     2012-05-02  158  	va_list ap)
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  159  {
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  160  	struct clk_lookup_alloc *cla;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  161  
0d4e3d005cb3c7b drivers/clk/clkdev.c     Stephen Boyd     2018-01-02  162  	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  163  	if (!cla)
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  164  		return NULL;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  165  
d5622a9c13752be drivers/clk/clkdev.c     Russell King     2015-03-02  166  	cla->cl.clk_hw = hw;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  167  	if (con_id) {
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  168  		strlcpy(cla->con_id, con_id, sizeof(cla->con_id));
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  169  		cla->cl.con_id = cla->con_id;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  170  	}
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  171  
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  172  	if (dev_fmt) {
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09 @173  		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  174  		cla->cl.dev_id = cla->dev_id;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  175  	}
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  176  
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  177  	return &cla->cl;
0318e693d3a5683 arch/arm/common/clkdev.c Russell King     2008-11-09  178  }
e9d7f4065408e92 drivers/clk/clkdev.c     Russell King     2012-05-02  179  

:::::: The code at line 173 was first introduced by commit
:::::: 0318e693d3a56836632bf1a2cfdafb7f34bcc703 [ARM] clkdev: add generic clkdev infrastructure

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

