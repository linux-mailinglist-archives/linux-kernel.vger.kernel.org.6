Return-Path: <linux-kernel+bounces-516311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B3BA36F90
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79743B05F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7741E5B77;
	Sat, 15 Feb 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQoUf22X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E341D89FA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638515; cv=none; b=qWrN27oWDThPo4yZezbAKL5NithjYOTDFld7KqBemU7/ChLkzBxBRvH7zbfgS6Yksr30For6xZCEeV84yJI14SeaiVq17LBiUGQVNnGpw+k4VJNrn//2mAGn2IOJYGJVR2UjZsmoNzgmetDSGs4QtBa9+876uBR4aV4dBTkpvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638515; c=relaxed/simple;
	bh=Hj5GrYaA4Y3pXk9qtf6QXQptx7dLeL6RqSbL2+NQc7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9cHz88bIyq/TfxCwqWxP/QzkCd8TH94s2Vfkf9qZwCMk5bl/BCj7HCcdQzTzw1yjJwyaJ/QShoop8JThUqvzU5gQ7SvxBEK0VhDXJqJ6b3UYY8hROdCYZ2cQ52LSgX+bEB4DHaFCKt1ywFTvCQvn4Ncalu4UiXJpoek4Fgi/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQoUf22X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739638513; x=1771174513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hj5GrYaA4Y3pXk9qtf6QXQptx7dLeL6RqSbL2+NQc7Q=;
  b=JQoUf22X8ASvmOJ4V2gvQTxLXAZXtO7v8nlOhdsqxIBaMSuiLuKP4XHn
   0ZEP5Sb57IYTYtC20yUbpherYDkX9tOjkiV6unbgY5oRWPrM6OP/6Ko3t
   GX/HBP76qoHjtlHJNFoPtIWmkXuz/abbGfbn9WIPBq0qf5ppP/LUZNJpW
   wBxb4AdZMFAcOswOY2p0vxktdC9jxYK691+yrfQ6AcgAfQuGe9PEzM8hs
   ypGHUsCeBoRQS3ZLwrin1WOH11Nc7Vgg6N+mUeCgbEHHCdtbiTOxayPxm
   zPn9SMfX0CoQvBrA/ML2K8iX3ZURDxfn28656IglZKEodyFoi1zFhnk6t
   g==;
X-CSE-ConnectionGUID: IUjb6aDqR6C/TIW2q+IOKA==
X-CSE-MsgGUID: KwfmjJ4UTOqH38NidAO90g==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40498647"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40498647"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 08:55:12 -0800
X-CSE-ConnectionGUID: F9EE5cSNSpqUiVco1sAkBw==
X-CSE-MsgGUID: mXEs2OP5T0O/u16zJRzJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136952523"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Feb 2025 08:55:08 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjLRa-001B0x-0Z;
	Sat, 15 Feb 2025 16:55:06 +0000
Date: Sun, 16 Feb 2025 00:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 7/7] mm, swap: simplify folio swap allocation
Message-ID: <202502160040.5ULBvBsP-lkp@intel.com>
References: <20250214175709.76029-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-8-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-avoid-reclaiming-irrelevant-swap-cache/20250215-020239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250214175709.76029-8-ryncsn%40gmail.com
patch subject: [PATCH 7/7] mm, swap: simplify folio swap allocation
config: x86_64-buildonly-randconfig-001-20250215 (https://download.01.org/0day-ci/archive/20250216/202502160040.5ULBvBsP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160040.5ULBvBsP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160040.5ULBvBsP-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:14:
>> include/linux/swap.h:591:1: error: expected identifier or '(' before '{' token
     591 | {
         | ^
>> include/linux/swap.h:590:13: warning: 'folio_alloc_swap' declared 'static' but never defined [-Wunused-function]
     590 | static bool folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
         |             ^~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=2631350961
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=2631350961
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=2631350961
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=2631350961
   make: Target 'prepare' not remade because of errors.


vim +591 include/linux/swap.h

8334b96221ff0d Minchan Kim    2015-09-08  589  
f8d9ff0d052908 Kairui Song    2025-02-15 @590  static bool folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @591  {
f8d9ff0d052908 Kairui Song    2025-02-15  592  	return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  593  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  594  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

