Return-Path: <linux-kernel+bounces-309575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE506966CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C437284FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C4F190049;
	Fri, 30 Aug 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+F+Kv9+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FF15C150
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061367; cv=none; b=c5Yw4Pwwp5nnspLBMv88QGnMzj7gR5LQhmH0G1bYyvLn0VKK794q4ICI5eRRKSnB6Msi2HIbWSX6AdH3T2qOuf9Vo3lOVwFLe64gpB2c7CQu//n/260zTputEPtKAOkkEfaLR/YMl7EJkEcodZ07ZBEZm0N/i3FiLRlgE6JIXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061367; c=relaxed/simple;
	bh=hgvODO1xl+N9l15+2DgxbYjvJXkNYYi7umvXalPA1TM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RWohP2d+CP2bYu3onNYPEuywZD5cXYGYNLLPDsaeK26Ve2iPxMRR5hzg8vVabw4FjrBW6erKBb6sSisKd4pZ0a7oUal/UofX+UG0UalOGUVgPjNBsdjhqaSluj/LqYx0E5sC17NMoC6DuBEjx65+civsPVg5d2nyYsCCzACu9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+F+Kv9+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725061366; x=1756597366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hgvODO1xl+N9l15+2DgxbYjvJXkNYYi7umvXalPA1TM=;
  b=g+F+Kv9+s1SQhx+wuC83JPoSmjPjmjzy0AmncSm293BkiHrUynsHGBsa
   OBdpIf9ykwQ8kFj/7V6Kxw4suShmGfZzSgmrE7mN4HHiQeO0HzZPxJTSu
   oSLrJQXB8fXBclnY3oRrPp4dT+gfe5Qm3uciwelgV9N/R2SxV+71Vrspu
   jruHoq5tGSqfLwXo8KheLsiHXWuslezprMF/NCp+OoXcBBeoIfRsBlmkd
   m/79Hey6kwuQKaKtI6jHRMIJUstF4g+ZIPBBjF3WDe8fc4TqNyytvcg1h
   MmnpgxCxmUfoTp6pP7ya2UAaEQGwTSauiMBidoNOrKPtVb4Y6u93CJx0a
   Q==;
X-CSE-ConnectionGUID: NXIv88YGR6CqmdjYd5VWOQ==
X-CSE-MsgGUID: oBtEDtI/Tt+IMpjFNZF1pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23601173"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="23601173"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 16:42:43 -0700
X-CSE-ConnectionGUID: EmelMn+RTFWA7JgXS/E1wg==
X-CSE-MsgGUID: tl4gfJYSTKy2ZQvVQEbNQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="68446163"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 16:42:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skBGJ-0002DG-2t;
	Fri, 30 Aug 2024 23:42:39 +0000
Date: Sat, 31 Aug 2024 07:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: lib/maple_tree.c:330:20: error: unused function 'mte_set_full'
Message-ID: <202408310728.S7EE59BN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb24560f31f9dff2c97707cfed6029bfebebaf1c
commit: 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa Maple Tree: add new data structure
date:   1 year, 11 months ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240831/202408310728.S7EE59BN-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310728.S7EE59BN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310728.S7EE59BN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/maple_tree.c:330:20: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
     330 | static inline void mte_set_full(const struct maple_enode *node)
         |                    ^~~~~~~~~~~~
>> lib/maple_tree.c:335:20: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
     335 | static inline void mte_clear_full(const struct maple_enode *node)
         |                    ^~~~~~~~~~~~~~
   2 errors generated.


vim +/mte_set_full +330 lib/maple_tree.c

   329	
 > 330	static inline void mte_set_full(const struct maple_enode *node)
   331	{
   332		node = (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
   333	}
   334	
 > 335	static inline void mte_clear_full(const struct maple_enode *node)
   336	{
   337		node = (void *)((unsigned long)node | MAPLE_ENODE_NULL);
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

