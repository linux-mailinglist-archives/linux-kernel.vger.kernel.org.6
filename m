Return-Path: <linux-kernel+bounces-243128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE37929229
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7043B1C212E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D004C3D0;
	Sat,  6 Jul 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfzHcbJt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CD17740
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257405; cv=none; b=EIw5RCJIl+fk62wIehUrJNOJM978ynpUfRCJTYESRiTM/nhV8pQ8z+He4GBiNB7HDKhL8BYmm71lvoIANfqwhAXWQLo29YTkzo72y3037ieyvOwmlySJ5kqNx/q3ZcnpQ3VJCPLAbTUWaMvYMJsYjot3UWTM9jkcWg64yenfcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257405; c=relaxed/simple;
	bh=mSOe5IL52tQA3CSWmiOZHQq3AKs7OVITM1J54jxHzi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISL/oKB86LaUsrz8uL+bnOTwQsQkKmX2gwAYQrJvj2GzzO7D7/T/tZphJKBWClRcb4z6VwlmATz29I1bIUpCIaJZ4f1PLXJt6mEAJqS0wt5iJxHNApxupusOYV1eI2RcJv42uxUg9z1yVcgn83yWh42QitRbT2jtUMKqGWbb2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfzHcbJt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720257403; x=1751793403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSOe5IL52tQA3CSWmiOZHQq3AKs7OVITM1J54jxHzi0=;
  b=ZfzHcbJtMrF2Ga0cxCu9Z8iA76fzkDNK036poUVmHyOuWgo6ddh4reYG
   D0U/5pAHdpsn8x+weeQCo26OadAlePNPi9lTgLHJppOt9+7FCE1p2RjaZ
   d8kZ/vkXhjgeDh3OklpKnuCfRMCNCvQYGr8qx7i77XAtM5QAAInC7psTr
   RdvY/kNRQb93RIK1mvCkeb7MDF8OqtE794NiowFp+0EguX7mvYL1VGuNU
   jxqERSMILI9466wKWiToLukOgQq0G5/hEmA9pEHEYUKtWcUble6VCY/uY
   hhhNJIVr0OfYPTKHr6+r/uBiwWfNOlzl81RsvoPg5MlUTt00XX+o84p0j
   g==;
X-CSE-ConnectionGUID: mABhjQP2TNmokh4CbVECDw==
X-CSE-MsgGUID: XRCSVKCkRwOKEBUy9hrnXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20430098"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="20430098"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 02:16:42 -0700
X-CSE-ConnectionGUID: eg+P6/jNRVOu0yid8K+2YA==
X-CSE-MsgGUID: pRuJzgJKTeKhngIITJkerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="46992364"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jul 2024 02:16:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ1X0-000TXk-04;
	Sat, 06 Jul 2024 09:16:34 +0000
Date: Sat, 6 Jul 2024 17:16:15 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@suse.de>, Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>, peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 7/8] mm/x86: Add missing pud helpers
Message-ID: <202407061716.WH5NMiL2-lkp@intel.com>
References: <20240703212918.2417843-8-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703212918.2417843-8-peterx@redhat.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-dax-Dump-start-address-in-fault-handler/20240705-013812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240703212918.2417843-8-peterx%40redhat.com
patch subject: [PATCH v2 7/8] mm/x86: Add missing pud helpers
config: i386-randconfig-011-20240706 (https://download.01.org/0day-ci/archive/20240706/202407061716.WH5NMiL2-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061716.WH5NMiL2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407061716.WH5NMiL2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/atomic.h:8,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:256,
                    from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/x86/mm/pgtable.c:2:
   In function 'pudp_establish',
       inlined from 'pudp_invalidate' at arch/x86/mm/pgtable.c:649:14:
>> arch/x86/include/asm/cmpxchg.h:67:25: error: call to '__xchg_wrong_size' declared with attribute error: Bad argument size for xchg
      67 |                         __ ## op ## _wrong_size();                      \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/cmpxchg.h:78:33: note: in expansion of macro '__xchg_op'
      78 | #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
         |                                 ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:12:18: note: in expansion of macro 'arch_xchg'
      12 | #define raw_xchg arch_xchg
         |                  ^~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4758:9: note: in expansion of macro 'raw_xchg'
    4758 |         raw_xchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~
   arch/x86/include/asm/pgtable.h:1415:24: note: in expansion of macro 'xchg'
    1415 |                 return xchg(pudp, pud);
         |                        ^~~~


vim +/__xchg_wrong_size +67 arch/x86/include/asm/cmpxchg.h

e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  37  
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  38  /* 
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  39   * An exchange-type operation, which takes a value and a pointer, and
7f5281ae8a8e7f8 Li Zhong            2013-04-25  40   * returns the old value.
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  41   */
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  42  #define __xchg_op(ptr, arg, op, lock)					\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  43  	({								\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  44  	        __typeof__ (*(ptr)) __ret = (arg);			\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  45  		switch (sizeof(*(ptr))) {				\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  46  		case __X86_CASE_B:					\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  47  			asm volatile (lock #op "b %b0, %1\n"		\
2ca052a3710fac2 Jeremy Fitzhardinge 2012-04-02  48  				      : "+q" (__ret), "+m" (*(ptr))	\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  49  				      : : "memory", "cc");		\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  50  			break;						\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  51  		case __X86_CASE_W:					\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  52  			asm volatile (lock #op "w %w0, %1\n"		\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  53  				      : "+r" (__ret), "+m" (*(ptr))	\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  54  				      : : "memory", "cc");		\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  55  			break;						\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  56  		case __X86_CASE_L:					\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  57  			asm volatile (lock #op "l %0, %1\n"		\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  58  				      : "+r" (__ret), "+m" (*(ptr))	\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  59  				      : : "memory", "cc");		\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  60  			break;						\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  61  		case __X86_CASE_Q:					\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  62  			asm volatile (lock #op "q %q0, %1\n"		\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  63  				      : "+r" (__ret), "+m" (*(ptr))	\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  64  				      : : "memory", "cc");		\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  65  			break;						\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  66  		default:						\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30 @67  			__ ## op ## _wrong_size();			\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  68  		}							\
31a8394e069e47d Jeremy Fitzhardinge 2011-09-30  69  		__ret;							\
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  70  	})
e9826380d83d1bd Jeremy Fitzhardinge 2011-08-18  71  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

