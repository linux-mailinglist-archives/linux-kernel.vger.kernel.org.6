Return-Path: <linux-kernel+bounces-327582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E1977801
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E161E283B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BB1C6893;
	Fri, 13 Sep 2024 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaBg1sBM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F318953E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202258; cv=none; b=PbXhMKOhoUfbZbnYXg+VEjoKDLp3qt9ql17raXwOZ+h6bj30N2UE844aR+dNu8AzQk1NiIFnC1KCSMpNjh1lAwrvDh3m0PE8r+pcnYYefG6HYiifDuTvX7RIOda/pqMemfLAsO+RjOYkSymbOndtf6qCuw/g0IxhwEH4Ezofg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202258; c=relaxed/simple;
	bh=YCHK4h4EgR++bmPEWUyKkMWNRjY+2+bURt8ihoi8IsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raz7Fxff1bdFI/pC+poLmPsi7ngb8TaBbg9ONKwDdqOAPuiGgzXCS4ZV3sVR3aMGfPxGRtafBDQ7YN6Bd5c7Mqq3WyGELDNyB8eHSzyKQyhCrv1FFR2sISXC2qpRxsbwFBhz/a+6INVBMDZug/97RL8/IeEQS/PZwVWDr/TYo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaBg1sBM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726202257; x=1757738257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCHK4h4EgR++bmPEWUyKkMWNRjY+2+bURt8ihoi8IsE=;
  b=WaBg1sBMC92GL5NjpNJ4GAk2IsUObR8C7/XIH4Yk/CRrxG2TA8cnVLEM
   ubnfA6vc8H64echuFw2/KmI2LfYxRIxomRUQYvdwP7t7BlSkctmmtmFup
   8FXRfl6fV8An9GyKDHsYBJRL6zzJuUaSBv+Fp0T2Sfup+ZBPCF02i+va+
   aXLcrrMgjtZrt4Pt7mP+C/vr0T7ILXHwlPoOwzRcOoUqI33b0Oxv26nZ1
   4f+5gZUD6OCNX5umKHnuG4ptEQ1rqLzFe648vTZSPX4O7NeypfF1juJ3j
   wYY4FKIxv0vG5EWIr9zi4iMfVe7adA9o7V5vDPEwkT2W4a1rDCKcLyZqw
   g==;
X-CSE-ConnectionGUID: GfhKxnyHTeCv+664D62ofA==
X-CSE-MsgGUID: PCCkDtXdSByJQ/nEpY+gQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50505079"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="50505079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:37:36 -0700
X-CSE-ConnectionGUID: ODY0LMdqRFipSl07IxGTeQ==
X-CSE-MsgGUID: MkGd3E84QdGIb1dgcqez8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68431419"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2024 21:37:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soy3n-00061E-2v;
	Fri, 13 Sep 2024 04:37:31 +0000
Date: Fri, 13 Sep 2024 12:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Drop unused set_pte_safe()
Message-ID: <202409131214.d09v9mIO-lkp@intel.com>
References: <20240910101026.428808-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910101026.428808-1-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-Drop-unused-set_pte_safe/20240910-181151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240910101026.428808-1-anshuman.khandual%40arm.com
patch subject: [PATCH V2] mm: Drop unused set_pte_safe()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240913/202409131214.d09v9mIO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131214.d09v9mIO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131214.d09v9mIO-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/mm/init_64.c: In function 'set_pte_init':
>> arch/x86/mm/init_64.c:83:17: error: implicit declaration of function 'set_pte_safe'; did you mean 'set_pud_safe'? [-Werror=implicit-function-declaration]
      83 |                 set_##type1##_safe(arg1, arg2);                 \
         |                 ^~~~
   arch/x86/mm/init_64.c:91:1: note: in expansion of macro 'DEFINE_ENTRY'
      91 | DEFINE_ENTRY(pte, pte, init)
         | ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +83 arch/x86/mm/init_64.c

eccd906484d1cd Brijesh Singh 2019-04-17  77  
eccd906484d1cd Brijesh Singh 2019-04-17  78  #define DEFINE_ENTRY(type1, type2, init)			\
eccd906484d1cd Brijesh Singh 2019-04-17  79  static inline void set_##type1##_init(type1##_t *arg1,		\
eccd906484d1cd Brijesh Singh 2019-04-17  80  			type2##_t arg2, bool init)		\
eccd906484d1cd Brijesh Singh 2019-04-17  81  {								\
eccd906484d1cd Brijesh Singh 2019-04-17  82  	if (init)						\
eccd906484d1cd Brijesh Singh 2019-04-17 @83  		set_##type1##_safe(arg1, arg2);			\
eccd906484d1cd Brijesh Singh 2019-04-17  84  	else							\
eccd906484d1cd Brijesh Singh 2019-04-17  85  		set_##type1(arg1, arg2);			\
eccd906484d1cd Brijesh Singh 2019-04-17  86  }
eccd906484d1cd Brijesh Singh 2019-04-17  87  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

