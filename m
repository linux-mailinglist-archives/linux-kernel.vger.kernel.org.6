Return-Path: <linux-kernel+bounces-241767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCAE927F64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B674A1F23D25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBB63C8;
	Fri,  5 Jul 2024 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKwADU5a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29715367
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720139741; cv=none; b=JOrs2oMRGgmoKGMXMOgaZ5wl7I9oLlb23/3Dkz2iZBJY1FDGsCW5aJrRpOf1Jno8RYvOWXtBVJCdxyJJ4ZTd8Ark1HA13jAPzxuKQ+8KG9cQLNS2WCTis+Yy4miFW/JwcbNT0T4/Qn7oftwEd4KkrSm27cM/XH1e8UWs6Xpb0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720139741; c=relaxed/simple;
	bh=p8OOfhn+XPTMTyv4z0em8hyAMi9nfYqi2VUXqoaHQPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8zmADI297E7ALaSLSiGZzTC0U2NLg+cG6iHxzV3JqT6LPdadLbycYeLK3iI2jSCd6Dbl27BlWKtPyMbwfA7+uQprKJy9yJPW9UmLJ06HwQKiX9KScu5/j27IPZqGKa1shdg1ynT2NWHIq4DrzVJbEYILpwZSksMneBc3f+myEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKwADU5a; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720139740; x=1751675740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p8OOfhn+XPTMTyv4z0em8hyAMi9nfYqi2VUXqoaHQPI=;
  b=cKwADU5aS36U9GGszjHieCj3t3B70+EhjkTilxTvAhpuKJDFBkciuQbs
   rYMYHnglhGACpBOWnR1SgQjwhTIJ52rEG4tiPl1NGUJEfEPPxb1TuVutq
   F82cW57QSBtDBHEeLjIGbG4ewleq6Wsh9I1uq+N7bAmu6LgN85DoAyBES
   1+6zix/C3W81O2APflXFqz2Mx9SR52CQqz/6fcp4btQI8sEUnZYg8RbBZ
   leW/S7apbMYkaJheiijZqB0f9/Taz3eoD7b6h5PjvQOU8cMMc/Z+29zRu
   cdlk0TWaHJxEGmwaboPTY33c+Xis6yYFKdfeuZgOxmF+nY50xJ+XwzJwQ
   w==;
X-CSE-ConnectionGUID: 3vFx7fdKSni9AbAHn9Lamg==
X-CSE-MsgGUID: 3XVePlkMQ+uYlzTksiV49g==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28823102"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28823102"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:35:39 -0700
X-CSE-ConnectionGUID: pLi5glCgTKKP2TlN9M2qWQ==
X-CSE-MsgGUID: yF0MbkPxRfOGFq0I/RLYAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77867362"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2024 17:35:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPWvG-000RhK-2x;
	Fri, 05 Jul 2024 00:35:34 +0000
Date: Fri, 5 Jul 2024 08:35:11 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/slub.c:2077:1: error: unused function 'prepare_slab_obj_exts_hook'
Message-ID: <202407050845.zNONqauD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   661e504db04c6b7278737ee3a9116738536b4ed4
commit: b4601d096aac8ed26afa88ef8b249975b0530ca1 mm/slab: fix 'variable obj_exts set but not used' warning
date:   10 days ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240705/202407050845.zNONqauD-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407050845.zNONqauD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:2077:1: error: unused function 'prepare_slab_obj_exts_hook' [-Werror,-Wunused-function]
    2077 | prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/prepare_slab_obj_exts_hook +2077 mm/slub.c

0bedcc66d2a43a Vlastimil Babka    2023-10-03  2075  
4b8736964640fe Suren Baghdasaryan 2024-03-21  2076  static inline struct slabobj_ext *
4b8736964640fe Suren Baghdasaryan 2024-03-21 @2077  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
3450a0e5a6fc4c Vlastimil Babka    2023-11-13  2078  {
4b8736964640fe Suren Baghdasaryan 2024-03-21  2079  	return NULL;
4b8736964640fe Suren Baghdasaryan 2024-03-21  2080  }
3450a0e5a6fc4c Vlastimil Babka    2023-11-13  2081  

:::::: The code at line 2077 was first introduced by commit
:::::: 4b8736964640fe160724e7135dc62883bddcdace mm/slab: add allocation accounting into slab allocation and free paths

:::::: TO: Suren Baghdasaryan <surenb@google.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

