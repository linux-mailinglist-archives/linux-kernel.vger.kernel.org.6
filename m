Return-Path: <linux-kernel+bounces-436756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463EF9E8A54
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A7C16381E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B46158534;
	Mon,  9 Dec 2024 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXG5x+2w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BB15575E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718681; cv=none; b=XBEobCCldF7L1mNdC8ZgA3m6xhkc4h5IjbA83lMuI5nK+tIBoNCB44ZKI1prwUVqqtHlem2+VUzY7Avr+mpjUggrnic7JeR+5DrFmxVjE8GRZvFhscE+imx6/HTBzLq9FMn9AskDDHL/0NF+zDfzrwXbBg0RRKXhLypjmVL824w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718681; c=relaxed/simple;
	bh=T/ux19x+J27VpzLUXrDCqi6aU/O7+y6Q0KiSPhZeYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=thFSF+xHRi2AqJ0lg9/uM8YNmBKyi7d+QK0aIm1pEDEc6rxq8WvF2QBOp/ppqUl9nCbWtMUtdK+w/ayjiD40oHHTaA9eyYSZi1Nl4vTRcwiMlZ1H7Dt/lIBVWcnn8nYQmVh41ciBVuoWsnlgIjeNi479j7bdsUFz8ZGsi8WC66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXG5x+2w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718680; x=1765254680;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T/ux19x+J27VpzLUXrDCqi6aU/O7+y6Q0KiSPhZeYjQ=;
  b=lXG5x+2wOeHJDBp8Ey6BdpE0762LMP1qdqdbaLFg+q6Qa6rn82URJAYB
   MmkcPAEDHJ0vE1kYN4N7TEjA6H0Z2PAlvlsyfhkDGx8OonAK2vjWz3hcs
   0Z/2lq8TM5YuXgbkr/8DiudmsZmCm0vuiLzPRdlY9RfUtZgmObSOsi9wn
   rbPDkbky2gb5f+inZO/RmhSS+rZgwrQPmBIZDglXCBwdQVcFTl2IT7XU3
   qQmTMoIsA1K7LhHqYqugCvig6yiO+MvHVMsi3mGu+cyP5n5lrPSmMHV4t
   x6tcirSGDM9wuL0eSzelGs+fLOLbwN0q8Ip0u9hQy55G3yOmFmKXXpzTV
   g==;
X-CSE-ConnectionGUID: xZFhZsJLQVm9EqMB2J7R6Q==
X-CSE-MsgGUID: yuZioORXSyK2B4bxYJ24Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37931015"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37931015"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:31:19 -0800
X-CSE-ConnectionGUID: dVZF6pvlSougKsUgzmBWIQ==
X-CSE-MsgGUID: 09Q+1ketQNCbE/Sa8n3anw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95751433"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Dec 2024 20:31:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVQS-0003rv-0O;
	Mon, 09 Dec 2024 04:31:16 +0000
Date: Mon, 9 Dec 2024 12:30:34 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-eyeq.c:131 eqc_pll_downshift_factors() warn: always
 true condition '(*mult <= (~0)) => (0-u32max <= u32max)'
Message-ID: <202412080533.Inh1JBwa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 25d904946a0baf08b16204d95dc3624096d99c38 clk: eyeq: add driver
date:   6 weeks ago
config: nios2-randconfig-r073-20241206 (https://download.01.org/0day-ci/archive/20241208/202412080533.Inh1JBwa-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080533.Inh1JBwa-lkp@intel.com/

smatch warnings:
drivers/clk/clk-eyeq.c:131 eqc_pll_downshift_factors() warn: always true condition '(*mult <= (~0)) => (0-u32max <= u32max)'
drivers/clk/clk-eyeq.c:131 eqc_pll_downshift_factors() warn: always true condition '(*div <= (~0)) => (0-u32max <= u32max)'
drivers/clk/clk-eyeq.c:374 eqc_probe() warn: 'base' from ioremap() not released on lines: 358.

vim +131 drivers/clk/clk-eyeq.c

   112	
   113	/*
   114	 * Both factors (mult and div) must fit in 32 bits. When an operation overflows,
   115	 * this function throws away low bits so that factors still fit in 32 bits.
   116	 *
   117	 * Precision loss depends on amplitude of mult and div. Worst theorical
   118	 * loss is: (UINT_MAX+1) / UINT_MAX - 1 = 2.3e-10.
   119	 * This is 1Hz every 4.3GHz.
   120	 */
   121	static void eqc_pll_downshift_factors(unsigned long *mult, unsigned long *div)
   122	{
   123		unsigned long biggest;
   124		unsigned int shift;
   125	
   126		/* This function can be removed if mult/div switch to unsigned long. */
   127		static_assert(sizeof_field(struct clk_fixed_factor, mult) == sizeof(unsigned int));
   128		static_assert(sizeof_field(struct clk_fixed_factor, div) == sizeof(unsigned int));
   129	
   130		/* No overflow, nothing to be done. */
 > 131		if (*mult <= UINT_MAX && *div <= UINT_MAX)
   132			return;
   133	
   134		/*
   135		 * Compute the shift required to bring the biggest factor into unsigned
   136		 * int range. That is, shift its highest set bit to the unsigned int
   137		 * most significant bit.
   138		 */
   139		biggest = max(*mult, *div);
   140		shift = __fls(biggest) - (BITS_PER_BYTE * sizeof(unsigned int)) + 1;
   141	
   142		*mult >>= shift;
   143		*div >>= shift;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

