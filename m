Return-Path: <linux-kernel+bounces-539631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C82A4A6B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D8D178296
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387ED1DF72D;
	Fri, 28 Feb 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nj/SMvmr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0351DED6C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786215; cv=none; b=u8CZHMISDOZk4BVIsYOEP5lsf6yOv5nZhTHXd6/xBxmedAIrW7urTIlQgoXqaWyD8eP7W7Y+5cKA5f0Jm8/J6UvoqyIn0WR4NNSmnKir6vWl51TBMtZw1auTGcpXW2/OC0LldjMKpY72q0oAapTiDVUKtXF8kitD05sR1mtrof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786215; c=relaxed/simple;
	bh=2VZtFRkJEsSMsYwyW5YkrmvG6ytxtG4N7R9LLuWDglc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8oPoduNR00vwgBgKrIbMdFcDqHREM995dsEI0ThXOpa2axNYO4lDnzMsk1gsrC88Lma7KtnoGR6xvs21Uy/HPZOrcDpmXE+oCjziz/fNQTMLAZoA8l6I/k3YkIPIitvlJ1lDJkX3zYa+ofSmnPH+k6gRLvmE3CPB5ev7DSL7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nj/SMvmr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740786214; x=1772322214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VZtFRkJEsSMsYwyW5YkrmvG6ytxtG4N7R9LLuWDglc=;
  b=nj/SMvmrzyf7k4jCwxWwQdb/W1I5GBm83ZqZ07zCIMgUkpiVxB0NfWQl
   SVBwHWN4Q6ZbYFnGAsAmymnKC7zMHTIzcTiIl8Jin6PSHD8ZdFJBdTuUy
   IaNBYtqyjEa9lyy/tAHawLYuB3iKYKZo6zLWxkTJyy3j/bfcSshkWzJK1
   D6AqDN/IG5dRTnLRnNYy+dOfahi76B7Y3LkMeK2HRwghckYlXCkKgUE/9
   9ArVlis8uWWQrMvVloQHlg+YA1ujgxRKurVIS2TsV4IXKQFtuVLq6uh8X
   WZGqp2G41IRUGnzinTni/KGZFmRIxp0jIbP7rzad9nP9wxPwNZ4UBnwr6
   w==;
X-CSE-ConnectionGUID: S/LS6/paS+a7htadYJ9A0g==
X-CSE-MsgGUID: VJr53Mt4TWSUFMS6n1o7xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59142060"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="59142060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 15:43:34 -0800
X-CSE-ConnectionGUID: z9ZvOejSREuBdpyqCCxU2g==
X-CSE-MsgGUID: G+wmTntjQ9y/SfxpQxI0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118372589"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 28 Feb 2025 15:43:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toA0u-000Fdg-1N;
	Fri, 28 Feb 2025 23:43:28 +0000
Date: Sat, 1 Mar 2025 07:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <202503010632.CEkonAAQ-lkp@intel.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>

Hi Brendan,

kernel test robot noticed the following build errors:

[auto build test ERROR on d58172d128acbafa2295aa17cc96e28260da9a86]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/mm-page_alloc-Add-lockdep-assertion-for-pageblock-type-change/20250228-002107
base:   d58172d128acbafa2295aa17cc96e28260da9a86
patch link:    https://lore.kernel.org/r/20250227-pageblock-lockdep-v1-1-3701efb331bb%40google.com
patch subject: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type change
config: i386-buildonly-randconfig-005-20250301 (https://download.01.org/0day-ci/archive/20250301/202503010632.CEkonAAQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010632.CEkonAAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010632.CEkonAAQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'set_pageblock_migratetype':
>> mm/page_alloc.c:421:17: error: implicit declaration of function 'in_mem_hotplug' [-Werror=implicit-function-declaration]
     421 |                 in_mem_hotplug() ||
         |                 ^~~~~~~~~~~~~~
   include/asm-generic/bug.h:171:32: note: in definition of macro 'WARN_ON'
     171 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:282:14: note: in expansion of macro 'WARN_ON_ONCE'
     282 |         do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
         |              ^~~~~~~~~~~~
   mm/page_alloc.c:420:9: note: in expansion of macro 'lockdep_assert_once'
     420 |         lockdep_assert_once(system_state == SYSTEM_BOOTING ||
         |         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/in_mem_hotplug +421 mm/page_alloc.c

   417	
   418	void set_pageblock_migratetype(struct page *page, int migratetype)
   419	{
   420		lockdep_assert_once(system_state == SYSTEM_BOOTING ||
 > 421			in_mem_hotplug() ||
   422			lockdep_is_held(&page_zone(page)->lock));
   423	
   424		if (unlikely(page_group_by_mobility_disabled &&
   425			     migratetype < MIGRATE_PCPTYPES))
   426			migratetype = MIGRATE_UNMOVABLE;
   427	
   428		set_pfnblock_flags_mask(page, (unsigned long)migratetype,
   429					page_to_pfn(page), MIGRATETYPE_MASK);
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

