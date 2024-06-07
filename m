Return-Path: <linux-kernel+bounces-206178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB490052E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BE61F24506
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131B19751A;
	Fri,  7 Jun 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4AcObjz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DB194A50;
	Fri,  7 Jun 2024 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767483; cv=none; b=ch6uUxubU4ggITmWlEwBUHfLhTzRZFXoWNmJTWRmigAHmD/NCoHho/AqwTuEON5oKF5YQoKnskx60yeB39rQqi+mwFe4Nc5N6JH4UCp39ZDaBxc77ILS1YY3OCYUoK32cqsojLqfn55T8sgsFLFeVVi7OJtw/XT3qNBfj5x2tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767483; c=relaxed/simple;
	bh=MoflX+rHxmHBfgMPSKgaOvZCQXpiQQ7FIGrPcOvirlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3hLIHlVdsjlPv9ZatGN66YNEqsooacAr2aaY11Sm7OVqKYXgeQCARj5UaZHiYGAdlehNUKPuFjrEWY64+20LsC+5nY7o8aG5R6Edr9GzsL8yjNJXXXR++IwPRDgWX6wjYaDlj3bq2EvhpkZULZoEjpgpJCqAMFjx/LEwvPS8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4AcObjz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717767482; x=1749303482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MoflX+rHxmHBfgMPSKgaOvZCQXpiQQ7FIGrPcOvirlA=;
  b=O4AcObjz5K1hYKy+d+Wewa7BNqb4P+pAWznec/WymRP3uDs2PRqW7JUy
   YwUcS8/E1x/azLnvRU8oUaUMm7zXRR0jMvnWL6zygVImdUpPLrzaDlTVS
   Mf1s+QDRAzF3erC72ZXsbVAPtQyqofwy3tMQmUOGt1VLqfVvNhkUhsb+Q
   mdXlJv+gMF97LEz12t2ecUy4V/P31EWyrOOR0SiFSXJoB5hU3rOyCkXvD
   JW8mHOZjSSzPguB0/9Y3/GCsG3xavgjOKvcR0x/357n6DAQsOfI2EHMna
   4r8XXzf0jakfkMZMjwzJo0Mbp/jd1C/NSK8VS08E2HAwHdAWSfFDm2T4n
   w==;
X-CSE-ConnectionGUID: 9S5Tpdi+Ri6FEfriTmOPrw==
X-CSE-MsgGUID: F3LwJQg8QgmQXPHGwaz88Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="39888376"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="39888376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:38:01 -0700
X-CSE-ConnectionGUID: lIzsaqiPSP+4jgquTnV7DQ==
X-CSE-MsgGUID: i/W2p0RpR+m+reByBpFF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69493998"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jun 2024 06:37:58 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFZn2-0004qc-0L;
	Fri, 07 Jun 2024 13:37:56 +0000
Date: Fri, 7 Jun 2024 21:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Omar Sandoval <osandov@osandov.com>,
	linux-debuggers@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: convert page type macros to enum
Message-ID: <202406072138.EUCgPNSP-lkp@intel.com>
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
config: i386-randconfig-001-20240607 (https://download.01.org/0day-ci/archive/20240607/202406072138.EUCgPNSP-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072138.EUCgPNSP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072138.EUCgPNSP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/recovery.c:12:
>> fs/f2fs/f2fs.h:1118:6: error: nested redefinition of 'enum page_type'
    enum page_type {
         ^~~~~~~~~
   fs/f2fs/f2fs.h:1118:6: error: redeclaration of 'enum page_type'
   In file included from include/linux/mmzone.h:23,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from fs/f2fs/recovery.c:9:
   include/linux/page-flags.h:948:6: note: originally defined here
    enum page_type {
         ^~~~~~~~~


vim +1118 fs/f2fs/f2fs.h

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

