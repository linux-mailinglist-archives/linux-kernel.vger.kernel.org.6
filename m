Return-Path: <linux-kernel+bounces-446296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57F9F223F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29621166402
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317A1805A;
	Sun, 15 Dec 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dS/T1Wv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADBBE65
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239528; cv=none; b=lm/sviJUgyazbL54MKPB4Vq/UhXecoXmzuzV8hNMHmQWL39CD6GHpB2PxftgREDBT/23MDYWRuU3PnKZSAp4TY8gbDfmrfEVZJKwjY0xkxmdP44AyQyW0lZhkCy6OcYCQR2JGTMhNiFhz5ARGlEX4FH4fnSUtTl7QIgHu8z5hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239528; c=relaxed/simple;
	bh=eg+KeGZBXkB7LHpi+qqFGWr9Ub4uAHuGGJV8SdQyy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3jvDppJW8C2b6ZozmEUU0alek/C90OWFdXoLQZhF0qjIY1QjJvC1+1Bil/frTOdY15Nv+V731wGtnasjFrL43Wb/HiGyii1IsnkVamg9DpWCbAiar7aXDXAQ2t2yo6GMI7eGHa3lKQ2hCubabUVJc8jhCDqN6R0wI5ZhhU9rnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dS/T1Wv9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734239526; x=1765775526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eg+KeGZBXkB7LHpi+qqFGWr9Ub4uAHuGGJV8SdQyy+M=;
  b=dS/T1Wv9NvoW6chAKE7IHl+za9CEo2VqNqp22kMHK1Cz16Uk5S6e3MXE
   6iTb5Z2pa5XjsNOwSWd1zGVJd2TuDAbg7FdDEjn/wQKIvOPDYUrdP7UPc
   eOk5KSu5baJwW090wWDdY4IZcaBQIuW2wWzqbAvcLLYp4S9dCG6fpXn0o
   pILE2CDvOl+zNUhNr+jO2S1IKKLRM/jqe1BXmVXVVANRLZJLlgYd2rrzd
   WE6XC23PBCnN6qct4rUApx6U2UbrId7ZBKpRGyMLSW6qQtK+HdjURk/Hu
   dgW3d9nJxVBixH+F/je4wokZkBnlsMYAYV8HokSgbJLkfsnyFtk5eh4gh
   Q==;
X-CSE-ConnectionGUID: 49Q7oM+dTbajcmwDaqLBMQ==
X-CSE-MsgGUID: ogsZxWSwSG2L92mCpQJQtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="45253213"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="45253213"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 21:12:05 -0800
X-CSE-ConnectionGUID: zAihRL4uTuiFYp1MDc9pjA==
X-CSE-MsgGUID: IaMaFyUJSNmTnAmrF+AM4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="101920351"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Dec 2024 21:12:04 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMgvB-000DRt-09;
	Sun, 15 Dec 2024 05:12:01 +0000
Date: Sun, 15 Dec 2024 13:11:34 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Shixin <liushixin2@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Nanyong Sun <sunnanyong@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
Message-ID: <202412151252.7ESa61O9-lkp@intel.com>
References: <20241214104401.1052550-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214104401.1052550-1-liushixin2@huawei.com>

Hi Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/mm-hugetlb-independent-PMD-page-table-shared-count/20241214-184912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241214104401.1052550-1-liushixin2%40huawei.com
patch subject: [PATCH] mm: hugetlb: independent PMD page table shared count
config: i386-buildonly-randconfig-001-20241215 (https://download.01.org/0day-ci/archive/20241215/202412151252.7ESa61O9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151252.7ESa61O9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151252.7ESa61O9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:337,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/mm.h: In function 'pagetable_pmd_ctor':
>> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/mm_types.h:553:29: note: in expansion of macro 'NULL'
     553 | #define ptdesc_pmd_pts_init NULL
         |                             ^~~~
   include/linux/mm.h:3192:9: note: in expansion of macro 'ptdesc_pmd_pts_init'
    3192 |         ptdesc_pmd_pts_init(ptdesc);
         |         ^~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=1659946440
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1263: prepare0] Error 2 shuffle=1659946440
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=1659946440
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=1659946440
   make: Target 'prepare' not remade because of errors.


vim +8 include/linux/stddef.h

^1da177e4c3f415 Linus Torvalds   2005-04-16  6  
^1da177e4c3f415 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f415 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e2182874324727 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

