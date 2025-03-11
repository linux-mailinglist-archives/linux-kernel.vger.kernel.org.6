Return-Path: <linux-kernel+bounces-555983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C46A5BF09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B213B1F74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F7F253B59;
	Tue, 11 Mar 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMMU27jL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B732206A4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692703; cv=none; b=t4UAlACYCHWu+rliPBTRDZAuuFts45rQojgQvznhjxKV063SILJhJIxyAxV/N2k7qBbBWh1L78Nk5gj7n8Dh1NwkShtKZYryYjPIMlk8C4tBfotRHg7PIDg7rdrGm7CD9bqmHBFGSYEm7PMfdNoBvA7R2TXrV9i9T2dCTNpd8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692703; c=relaxed/simple;
	bh=0tsQsh3zhZV4peIz77XXKqRoGd4Q7VV6Rr61QE3yElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBt9WkliFdnyNkY+rZ2VF0Z9G7JK9tN6jRPVSg6QFGbREyG8WGKjiwxrXBbx2rp+akpnO/4g3Y9k/pFnf5MI6niNXb2DX4tTdVlviWWW1EE6amgbgyQSlPiu+T/px9vqTdjqcvE/SPiKErwUqD/1gDQBPRyd0UUAzKgirJypXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMMU27jL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741692702; x=1773228702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tsQsh3zhZV4peIz77XXKqRoGd4Q7VV6Rr61QE3yElU=;
  b=mMMU27jL531kG8H6/2nP23aZv+1BmSYCxYHjWKwIWI1eVGTkBNgP8DHl
   7e7GiLCbRGDt1ZzOwI66pNRK7KY/altMdlvRHonBtTiTmJofRWWhdkFu3
   WI789upI4SoEd/FZ8EK/+Ypac8vuxKRAL22hYT30PQVctAyOrXklDSwd0
   RSjW8hboqn17TKGvqeSEFeKpsKbk1KjN8/IWovE8eSdrHkNlIffk0QCIP
   UuujKd77QDXTXG439aY04LhdqmjJPexipu/p1pi1OjShSkZxF/lnztkWK
   vqcdcVY8gU3qoQgJP/4QyIAfCYrYXf27bDkyRfppNs9YfG/rENWusegjT
   A==;
X-CSE-ConnectionGUID: QxdGqE7HTuWlKfIXO1HSCw==
X-CSE-MsgGUID: JOna0Z4TQkiqlWT87E5IvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65182174"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="65182174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 04:31:41 -0700
X-CSE-ConnectionGUID: saD4g5O3RZC3b8rSV/pfXw==
X-CSE-MsgGUID: cabz44ZsQo6Mwgwk+BYESQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="124897106"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 11 Mar 2025 04:31:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trxpd-0006c0-2r;
	Tue, 11 Mar 2025 11:31:33 +0000
Date: Tue, 11 Mar 2025 19:31:24 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Graf <graf@amazon.com>, James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
Message-ID: <202503111944.pfx9UdvP-lkp@intel.com>
References: <20250310120318.2124-5-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310120318.2124-5-arbn@yandex-team.com>

Hi Andrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Ryabinin/kstate-Add-kstate-a-mechanism-to-describe-and-migrate-kernel-state-across-kexec/20250310-200803
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250310120318.2124-5-arbn%40yandex-team.com
patch subject: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
config: i386-buildonly-randconfig-003-20250311 (https://download.01.org/0day-ci/archive/20250311/202503111944.pfx9UdvP-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503111944.pfx9UdvP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503111944.pfx9UdvP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/vmcore_info.c:24:
>> kernel/kexec_internal.h:39:43: error: incomplete definition of type 'struct kimage'
      39 |         return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
         |                                             ~~~~~^
   kernel/kexec_internal.h:9:8: note: forward declaration of 'struct kimage'
       9 | struct kimage *do_kimage_alloc_init(void);
         |        ^
   kernel/kexec_internal.h:40:9: error: incomplete definition of type 'struct kimage'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                  ~~~~~^
   kernel/kexec_internal.h:9:8: note: forward declaration of 'struct kimage'
       9 | struct kimage *do_kimage_alloc_init(void);
         |        ^
>> kernel/kexec_internal.h:40:19: error: use of undeclared identifier 'KEXEC_TYPE_DEFAULT'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                                 ^
   3 errors generated.


vim +39 kernel/kexec_internal.h

    36	
    37	static inline bool kexec_late_load(struct kimage *image)
    38	{
  > 39		return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
  > 40			(image->type == KEXEC_TYPE_DEFAULT);
    41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

