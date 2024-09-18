Return-Path: <linux-kernel+bounces-332183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CA97B683
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295991F23B51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800496FCC;
	Wed, 18 Sep 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiKNXNhk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D164428;
	Wed, 18 Sep 2024 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726620772; cv=none; b=hWpDAf63hePXObzIcpWZS0HtdZ8thzBWd+awdALo7U8+RuXEgf9r6mzn0IszUGD8e8sm74tPECxCJz6m+ostYiwXeuAYAiJ1WS2mSCbG+eLsDbRD6Btcg1t12kcfusWwhboq5Al2WFg1PqGEz7Tv+FrEwkEFAnAjwqMZMzTa9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726620772; c=relaxed/simple;
	bh=Viy7M+d8DmzMY2Qjb2WpfLhBST+9UAOUykc41pF/uIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONGSiRT1X8hYB5j8Zl2mc65v29+A/yE5fKC5XCWM61V2K9/rzXux09U1lQ/F4QWyinEronnPUJF+rxT9V8k27ciHl+ahQhYc6r67IFACygpZo19DKAs1XuRvlpbFVCHRrwqiWrnYKn2iMAupBmO62WDFms90sdE4ZLlBCEFt0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiKNXNhk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726620771; x=1758156771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Viy7M+d8DmzMY2Qjb2WpfLhBST+9UAOUykc41pF/uIE=;
  b=AiKNXNhkiqNXPDeRkzE9yEEasdABD1abWnSmhoOCnqu0GnltDenuYCo0
   SsFxSZXrb9j23TynuytsH/UBmC+0SUWQbiw2y0lo0dSZQYlPxLcbUqbpF
   ZPDuDfYNUYgqs29EsF9pOFSI4/9lRBS4Si4Z8zLeA54LZFQIMhz+2L6XG
   90cJ1WPYXPeLwc1vqoPbMcvuMfO75Lqd8ilKWHmQ+7wIS4GZKlgc1X+Xj
   xNjWdUd5cQzwHBeMtNCCM931XUb5djHAcIPQCUXHvrVlz1mNMDrYcUMxY
   QmU74c66SGgfSaNZqMgqbhYaSyVXH/TVOrJyd0Hl7FlLLf+DJwLP4gllC
   w==;
X-CSE-ConnectionGUID: ALWPpigZRDGbm5pQspnF6g==
X-CSE-MsgGUID: J434PIu+TZiNPtaPbcKlwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25394134"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25394134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 17:52:51 -0700
X-CSE-ConnectionGUID: C32OqAMbSkiGpokrp+zf6Q==
X-CSE-MsgGUID: +rzghz59RZSuP0iJ91MN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="92678630"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2024 17:52:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqiw2-000BkA-2Z;
	Wed, 18 Sep 2024 00:52:46 +0000
Date: Wed, 18 Sep 2024 08:52:12 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/mpi - Extend support for scope-based
 resource management
Message-ID: <202409180851.4taVWgfI-lkp@intel.com>
References: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-crypto-2.6/master]
[also build test ERROR on herbert-cryptodev-2.6/master linus/master v6.11 next-20240917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/crypto-lib-mpi-Extend-support-for-scope-based-resource-management/20240917-173519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git master
patch link:    https://lore.kernel.org/r/bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc%40web.de
patch subject: [PATCH] crypto: lib/mpi - Extend support for scope-based resource management
config: i386-buildonly-randconfig-001-20240918 (https://download.01.org/0day-ci/archive/20240918/202409180851.4taVWgfI-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180851.4taVWgfI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180851.4taVWgfI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from crypto/dh.c:14:
>> include/linux/mpi.h:49:48: error: use of undeclared identifier 'T_'
      49 | DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
         |                                                ^
   include/linux/mpi.h:49:62: error: use of undeclared identifier 'T_'
      49 | DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
         |                                                              ^
   2 errors generated.


vim +/T_ +49 include/linux/mpi.h

    45	
    46	/*-- mpiutil.c --*/
    47	MPI mpi_alloc(unsigned nlimbs);
    48	void mpi_free(MPI a);
  > 49	DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

