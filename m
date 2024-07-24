Return-Path: <linux-kernel+bounces-261535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A087393B86C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24601C23CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2F13B58C;
	Wed, 24 Jul 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdY+YmJq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8013B29B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855441; cv=none; b=Ew7ETo6r8nzc/ygGZMPXwbZXogqL6WgAb8kgT25WwfzyF6WUkQMM8p5gAEg6XN7bJ0yidr93YADF3P7THtx/Yzx/H9KbnA/mHFY20TRflm6IXPtZPrClSmvEdlsiqJNz430UEH617zie6vOUprpgPkbStjeueuqnDeu7DLuHmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855441; c=relaxed/simple;
	bh=wW/zXMdyruZKDdE2qo8r0fZhyxISzk1l6ky+xuxNND8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcwYZf/Lbz9DgrPCbbBnoIZ+NH/i87vrXoom8QQbtiGowbWMraDGpBuTJVNn0QguJ2Tc63DhqXEMb8cyTvGa9mfukM31B6Dxzy305mkdrITx3OKd5Gqtdx9QdmxPsGuOgQAFncfpsFPbAXQzHwXoLIj3KJuzdMFhuGGWYQ6vGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdY+YmJq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721855441; x=1753391441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wW/zXMdyruZKDdE2qo8r0fZhyxISzk1l6ky+xuxNND8=;
  b=ZdY+YmJqMaNl8dTjg2ZijBbJpvrgQpROzulyRBi8dLEbggPBf47QrEbk
   86pJDMh/byNXHNAMnBtSIdBHIg8eZfmknv8DXJ377cqX+zGuJsHDzvjDF
   WneMK7TX0yO0gbeYFFfr+Sf0Z5xR0WYH8WY3owC1z8kLSv4WADksT/iIW
   uKS6xswpHz0ggU+tWHGS/NpenqDzT1PLETdZ2EZhTPKJcmw2DACIxRY/h
   NlW4eOUIib7AhqA4jBmhWkNP1ogidJu3ZlsultIn0hvxSy36A+35K+Ruw
   zE+zqmw3cMozHiW0NuS8iOz+GL1Iz1RKKhaWkHdAzoeOQPhy6gGZTpCa8
   g==;
X-CSE-ConnectionGUID: enSyyQrpSvqGVNMLCBBFwQ==
X-CSE-MsgGUID: z+84SEXFQ92KG3CzVmNW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19525061"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19525061"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:10:40 -0700
X-CSE-ConnectionGUID: 5BSAbpxrR5q0RmoXRdzeOg==
X-CSE-MsgGUID: yAByFR9DTiiLZeZ7zkBs8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57523681"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 Jul 2024 14:10:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWjFr-000nRG-1J;
	Wed, 24 Jul 2024 21:10:35 +0000
Date: Thu, 25 Jul 2024 05:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm: Remove PG_error
Message-ID: <202407250459.K6byaMoI-lkp@intel.com>
References: <20240724010550.1755992-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724010550.1755992-3-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linux/master linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Remove-calls-to-set-and-clear-the-folio-error-flag/20240724-111138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240724010550.1755992-3-willy%40infradead.org
patch subject: [PATCH 2/2] mm: Remove PG_error
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20240725/202407250459.K6byaMoI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250459.K6byaMoI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250459.K6byaMoI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/debug.c:13:
>> include/trace/events/mmflags.h:98:44: error: 'PG_error' undeclared here (not in a function); did you mean 'ma_error'?
      98 | #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
         |                                            ^~~
   include/trace/events/mmflags.h:103:9: note: in expansion of macro 'DEF_PAGEFLAG_NAME'
     103 |         DEF_PAGEFLAG_NAME(error),                                       \
         |         ^~~~~~~~~~~~~~~~~
   mm/debug.c:35:9: note: in expansion of macro '__def_pageflag_names'
      35 |         __def_pageflag_names,
         |         ^~~~~~~~~~~~~~~~~~~~
--
   fs/proc/page.c: In function 'stable_page_flags':
>> fs/proc/page.c:185:49: error: 'PG_error' undeclared (first use in this function); did you mean 'ma_error'?
     185 |         u |= kpf_copy_bit(k, KPF_ERROR,         PG_error);
         |                                                 ^~~~~~~~
         |                                                 ma_error
   fs/proc/page.c:185:49: note: each undeclared identifier is reported only once for each function it appears in


vim +98 include/trace/events/mmflags.h

4beba9486abd2f8 Steven Price  2020-04-22  97  
e26fcc02c7f6c76 Hyeonggon Yoo 2023-01-30 @98  #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
e26fcc02c7f6c76 Hyeonggon Yoo 2023-01-30  99  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

