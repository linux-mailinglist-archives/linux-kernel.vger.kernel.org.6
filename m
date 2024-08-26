Return-Path: <linux-kernel+bounces-300723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C987E95E798
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B881F21719
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F175B450EE;
	Mon, 26 Aug 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbhdkvR/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CF383BF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645774; cv=none; b=mpUvwuC93WDiS4UQBYeMW8urEWg1q347zi12iXLeo+z2Ffws/IvQ4cj5kn8HVg1t0hx/OgBKP2DuvIlJwigMjxTt/4Q0ebSfUvFWtWV3+XpjJHbId3XC9ZAJjB5AoocHRHqtq58OpSRIcoHt2r2ATPBOo4z+GslUYEpL5U9ZekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645774; c=relaxed/simple;
	bh=Unri9OacCkg6ie+KLCMRLH797BcObua39LYWzctHEYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tPTFnJOCD7NIgY2WIoanM0WkBfR0mbXOHnprvLypYyRtXC4D1B7F5RedDS3aXsAssuwqWePEjGRpI5Mhevq++qhqRp+lq/6JmOKn5ce4lC9OWRBl+m3O1IXop7R5Jzufbom/VZ5qna85ecu4nUjAfpTxuW6/5tpr8QFbVbOlETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbhdkvR/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724645772; x=1756181772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Unri9OacCkg6ie+KLCMRLH797BcObua39LYWzctHEYM=;
  b=nbhdkvR/wReFrCRhhdanuC9TfseyhJxXdgAteV+iYFXmJ4QhWqX+sOe5
   OITCBH/AImP6yr8uJBMQPxuYZTiCVNmrKQ3bQ/0yy4Ds39VYFekMKE4ed
   OKXl3+rNm4OyqCjvyA1F8VeNTvxYRZu8dYSoh+or4A6GQ99HwCPmgngnT
   pqopO1cYLCCXxApjKRy3+yxgjgv6hpUxCpgdhnPbgRWTXy5dgSQXUBphb
   dgwAXSqp7HOlHoSheD7J28wMvMd3hGWrrj4akYut6/9pyLDbM+eU8XOnT
   esjDJ+ykmdrjHxTK7Yb+OLCqBA0ytRDbkjhEsqgI3UU3uB3XBL1kH6Sr0
   Q==;
X-CSE-ConnectionGUID: 9ZIqL8BBROetdY8L6hx+jA==
X-CSE-MsgGUID: ZSxRhGrlTx2J3+e31GWysw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33666924"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="33666924"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 21:16:12 -0700
X-CSE-ConnectionGUID: 9W4a5g5eQ5a2u1OgMH9KrA==
X-CSE-MsgGUID: aUfmLBIDRN2rx26dGp0mqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="67313211"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2024 21:16:10 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siR9D-000Fs5-38;
	Mon, 26 Aug 2024 04:16:07 +0000
Date: Mon, 26 Aug 2024 12:15:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:x86/cleanups 3/9] arch/x86/kernel/eisa.c:20:24: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202408261244.v2gfgSON-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
head:   cc5e03f3be3154f860c9d08b2ac8c139863e1515
commit: 80a4da05642c384bc6f5b602b865ebd7e3963902 [3/9] x86/EISA: Use memremap() to probe for the EISA BIOS signature
config: i386-randconfig-061-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261244.v2gfgSON-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261244.v2gfgSON-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261244.v2gfgSON-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/eisa.c:20:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[assigned] p @@
   arch/x86/kernel/eisa.c:20:24: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/x86/kernel/eisa.c:20:24: sparse:     got void *[assigned] p

vim +20 arch/x86/kernel/eisa.c

6a92b11169a65b Boris Ostrovsky   2018-09-11  11  
f7eaf6e00fd581 Thomas Gleixner   2017-08-28  12  static __init int eisa_bus_probe(void)
f7eaf6e00fd581 Thomas Gleixner   2017-08-28  13  {
80a4da05642c38 Maciej W. Rozycki 2024-08-24  14  	void *p;
6a92b11169a65b Boris Ostrovsky   2018-09-11  15  
0f4a1e80989aca Kevin Loughlin    2024-03-13  16  	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
6a92b11169a65b Boris Ostrovsky   2018-09-11  17  		return 0;
f7eaf6e00fd581 Thomas Gleixner   2017-08-28  18  
80a4da05642c38 Maciej W. Rozycki 2024-08-24  19  	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
6a92b11169a65b Boris Ostrovsky   2018-09-11 @20  	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))

:::::: The code at line 20 was first introduced by commit
:::::: 6a92b11169a65b3f8cc512c75a252cbd0d096ba0 x86/EISA: Don't probe EISA bus for Xen PV guests

:::::: TO: Boris Ostrovsky <boris.ostrovsky@oracle.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

