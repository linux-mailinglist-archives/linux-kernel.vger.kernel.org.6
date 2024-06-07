Return-Path: <linux-kernel+bounces-206363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AE900862
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B311F21C2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3431990CE;
	Fri,  7 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBeaLN9N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8C194A5F;
	Fri,  7 Jun 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773248; cv=none; b=dNJLzH2/5BUtnsCTIuIWcS8DKqzW9K6exr0inWS9QCOrGkjAppd3KkzpzEU2fprMmWJDaH8jTgH2cHUSQHwTnr92K7wdq/qzWEAkJk3KsYuq2LmRkcuOp+TzdjmrG9sCOAskQ3wTwOYkHsCJi1F6XJ+h7OtVK5aBoOndOvYM/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773248; c=relaxed/simple;
	bh=bOlBKkHFjo5WOPdbthyGW/B7AwUCWnxawK0nxHrgEs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxze7mxRId3IEgxmMS0aK2qno5ZacEUk0Qps12+Cmo3tWVDKqBcQgkajEhWVIj4RTGLp7DJ+7XV+UEw5aGgdqLmWQns2efla2HBdMVioaF8tVWfZjaRJehZNlcuteILomRcHvRHAgP8eSQmPM7IQw+Q1Jx3LMCdN5fuQ9+mnNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBeaLN9N; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717773247; x=1749309247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOlBKkHFjo5WOPdbthyGW/B7AwUCWnxawK0nxHrgEs8=;
  b=kBeaLN9Ni4PeDylNGA4MaNLPnw5piSdXOyGTaPp7og/JLrrEMxhc0lH5
   7XZEQZxR+SIaB49ywUTcR3YwfnteivVNmRzeo/jUh2fuPymxk9tKe4mGt
   q4gKoSK/FkWOLJ/zxbAs7vdldIZa0L1lpJfl3TeUi1mOxBhpj8RtdQAVt
   WgzPnE14iUZP9nOJS8Qimy5xy07WM1xNyIMxlngAgq8GxcAfwMfiik0C4
   YvA6qe8DpXPhrBSyz9fSi17AHurV0ZzdLuhqpiYeLieVW7BMwBzZNO78D
   dP9K4cMoFQC/24Sb3bW+vb9p+OiOTrMUxypNAUwX/VPQNWMMsFUM1lkk3
   w==;
X-CSE-ConnectionGUID: jGhFwBmcSoqmprWDbeGL0Q==
X-CSE-MsgGUID: 8e6gyLOWShK471NMDzajCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="37027953"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="37027953"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:14:06 -0700
X-CSE-ConnectionGUID: pzyuSpVlRZGfY/++XMrl8w==
X-CSE-MsgGUID: 6CmrAG3XR06+3ESGqCwpvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43280270"
Received: from lkp-server01.sh.intel.com (HELO b4d3d4be9bbf) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Jun 2024 08:14:03 -0700
Received: from kbuild by b4d3d4be9bbf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFbI0-00001O-1K;
	Fri, 07 Jun 2024 15:14:00 +0000
Date: Fri, 7 Jun 2024 23:13:40 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Omar Sandoval <osandov@osandov.com>,
	linux-debuggers@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: convert page type macros to enum
Message-ID: <202406072244.8rZnMpsR-lkp@intel.com>
References: <20240607001116.1061485-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607001116.1061485-1-stephen.s.brennan@oracle.com>

Hi Stephen,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/mm-convert-page-type-macros-to-enum/20240607-081253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240607001116.1061485-1-stephen.s.brennan%40oracle.com
patch subject: [PATCH v3] mm: convert page type macros to enum
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240607/202406072244.8rZnMpsR-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072244.8rZnMpsR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072244.8rZnMpsR-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:13:
>> fs/f2fs/f2fs.h:1118:6: error: redefinition of 'page_type'
    1118 | enum page_type {
         |      ^
   include/linux/page-flags.h:948:6: note: previous definition is here
     948 | enum page_type {
         |      ^
   1 error generated.
--
   In file included from fs/f2fs/data.c:25:
>> fs/f2fs/f2fs.h:1118:6: error: redefinition of 'page_type'
    1118 | enum page_type {
         |      ^
   include/linux/page-flags.h:948:6: note: previous definition is here
     948 | enum page_type {
         |      ^
   fs/f2fs/data.c:2373:10: warning: variable 'index' set but not used [-Wunused-but-set-variable]
    2373 |         pgoff_t index;
         |                 ^
   1 warning and 1 error generated.
--
   In file included from fs/f2fs/segment.c:21:
>> fs/f2fs/f2fs.h:1118:6: error: redefinition of 'page_type'
    1118 | enum page_type {
         |      ^
   include/linux/page-flags.h:948:6: note: previous definition is here
     948 | enum page_type {
         |      ^
>> fs/f2fs/segment.c:3403:7: warning: case value not in enumerated type 'enum page_type' [-Wswitch]
    3403 |         case DATA:
         |              ^
   fs/f2fs/segment.c:3414:7: warning: case value not in enumerated type 'enum page_type' [-Wswitch]
    3414 |         case NODE:
         |              ^
   fs/f2fs/segment.c:3425:7: warning: case value not in enumerated type 'enum page_type' [-Wswitch]
    3425 |         case META:
         |              ^
   3 warnings and 1 error generated.


vim +/page_type +1118 fs/f2fs/f2fs.h

39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1104  
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1105  /*
e1c42045203071 arter97     2014-08-06  1106   * The below are the page types of bios used in submit_bio().
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1107   * The available types are:
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1108   * DATA			User data pages. It operates as async mode.
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1109   * NODE			Node pages. It operates as async mode.
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1110   * META			FS metadata pages such as SIT, NAT, CP.
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1111   * NR_PAGE_TYPE		The number of page types.
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1112   * META_FLUSH		Make sure the previous pages are written
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1113   *			with waiting the bio's completion
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1114   * ...			Only can be used with META.
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1115   */
7d5e510944ce60 Jaegeuk Kim 2013-11-18  1116  #define PAGE_TYPE_OF_BIO(type)	((type) > META ? META : (type))
87161a2b0aed9e Jaegeuk Kim 2024-02-06  1117  #define PAGE_TYPE_ON_MAIN(type)	((type) == DATA || (type) == NODE)
39a53e0ce0df01 Jaegeuk Kim 2012-11-28 @1118  enum page_type {
6b8beca0edd320 Chao Yu     2022-05-06  1119  	DATA = 0,
6b8beca0edd320 Chao Yu     2022-05-06  1120  	NODE = 1,	/* should not change this */
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1121  	META,
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1122  	NR_PAGE_TYPE,
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1123  	META_FLUSH,
3db1de0e582c35 Daeho Jeong 2022-04-28  1124  	IPU,		/* the below types are used by tracepoints only. */
8ce67cb07dbf6b Jaegeuk Kim 2015-03-17  1125  	OPU,
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1126  };
39a53e0ce0df01 Jaegeuk Kim 2012-11-28  1127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

