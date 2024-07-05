Return-Path: <linux-kernel+bounces-242749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A1928C8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8EDB224F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E816D339;
	Fri,  5 Jul 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2oFY/ZW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EE2F5E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198589; cv=none; b=u2qk4Pt+u+133oqYf1MQjHGp0scgl0xzJCOcOFCxmjSLT6KawyI5hXaxOzSw9c97w9FNwHcsM3LJqYfzzgkYu7b9Fs9ZDT33YRs7rqqiUHIJlTmWMbvRKs+1rI2RRDuu2QpBQJlxRCILum5mn/iPkRWHef2XcEzF4iuZKwRBMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198589; c=relaxed/simple;
	bh=3c83NHxscbCFMyyevE9dy5GhQA7qrWG4fG6eRk+VYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+MseepCO33e25J9/3mRIJBxdQTgNSVoH47MQjjUyFSMcHNBT46houCZyWkQbpO+Kq9aGs9ACSgtQbhQa7suCK/XlI+lQoWK04I73CenUDrRpREMEamyyq24Gen+nQyOKrpL0uw6VgT9SqDrBdFFdI7d1ZZ5cJb9HdErqHJ724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2oFY/ZW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720198588; x=1751734588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3c83NHxscbCFMyyevE9dy5GhQA7qrWG4fG6eRk+VYZs=;
  b=F2oFY/ZWSR/4ld6YPaYsTGjNpIja/I9oMO9JljDUPFF6b0ob5Agxm1s6
   /CatRX0tsXX44XVdwwQZHFj+jDmYmz1sVAS/w8oNVnc3H972XyhV/Sktr
   Tz005SqvXmRY9PM4gqVS65zqOfslqRNxLFHGFMxvX0ePes0CzkgcFRWKO
   /ye8tJv1bwtf8iWxZiLRrZ6ZnhPXFq9/EtAr2aiJpjYq6+VN4Gle3Gz15
   y8iy5BDJz+mCyFLtmZ/5zZCLeMpEzRGaLkWrIdEfaz825qZ3vC2gSUW2y
   KyGhUnJCzhiHvsS0Bd5GPacSahGBttCQ9T4jfwk9MZSD7ezcKtUQL73H+
   Q==;
X-CSE-ConnectionGUID: Xy8SKQlaSuOceRAk50z3yA==
X-CSE-MsgGUID: Hssrb9RvRzKdN2BaAZsrEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17365977"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17365977"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 09:56:27 -0700
X-CSE-ConnectionGUID: kQtLtrRYQ/qcqDzLXVIoqA==
X-CSE-MsgGUID: yIFw6MV5RoupqrHjhkWkUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="84473979"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Jul 2024 09:56:24 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPmEP-000SdM-0n;
	Fri, 05 Jul 2024 16:56:21 +0000
Date: Sat, 6 Jul 2024 00:56:15 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 05/45] mm/pagewalk: Enable walk_pmd_range to handle
 cont-pmds
Message-ID: <202407060025.WIFWw7WY-lkp@intel.com>
References: <20240704043132.28501-6-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704043132.28501-6-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on sj/damon/next powerpc/next powerpc/fixes linus/master v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/arch-x86-Drop-own-definition-of-pgd-p4d_leaf/20240705-042640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240704043132.28501-6-osalvador%40suse.de
patch subject: [PATCH 05/45] mm/pagewalk: Enable walk_pmd_range to handle cont-pmds
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240706/202407060025.WIFWw7WY-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407060025.WIFWw7WY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407060025.WIFWw7WY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/pagewalk.c:3:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/pagewalk.c:3:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/pagewalk.c:3:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> mm/pagewalk.c:91:11: error: call to undeclared function 'pmd_cont_addr_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      91 |                         next = pmd_cont_addr_end(addr, end);
         |                                ^
   12 warnings and 1 error generated.


vim +/pmd_cont_addr_end +91 mm/pagewalk.c

    75	
    76	static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
    77				  struct mm_walk *walk)
    78	{
    79		pmd_t *pmd;
    80		unsigned long next;
    81		const struct mm_walk_ops *ops = walk->ops;
    82		int err = 0;
    83		int depth = real_depth(3);
    84		int cont_pmds;
    85	
    86		pmd = pmd_offset(pud, addr);
    87		do {
    88	again:
    89			if (pmd_cont(*pmd)) {
    90				cont_pmds = CONT_PMDS;
  > 91				next = pmd_cont_addr_end(addr, end);
    92			} else {
    93				cont_pmds = 1;
    94				next = pmd_addr_end(addr, end);
    95			}
    96			if (pmd_none(*pmd)) {
    97				if (ops->pte_hole)
    98					err = ops->pte_hole(addr, next, depth, walk);
    99				if (err)
   100					break;
   101				continue;
   102			}
   103	
   104			walk->action = ACTION_SUBTREE;
   105	
   106			/*
   107			 * This implies that each ->pmd_entry() handler
   108			 * needs to know about pmd_trans_huge() pmds
   109			 */
   110			if (ops->pmd_entry)
   111				err = ops->pmd_entry(pmd, addr, next, walk);
   112			if (err)
   113				break;
   114	
   115			if (walk->action == ACTION_AGAIN)
   116				goto again;
   117	
   118			/*
   119			 * Check this here so we only break down trans_huge
   120			 * pages when we _need_ to
   121			 */
   122			if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
   123			    walk->action == ACTION_CONTINUE ||
   124			    !(ops->pte_entry))
   125				continue;
   126	
   127			if (walk->vma)
   128				split_huge_pmd(walk->vma, pmd, addr);
   129	
   130			err = walk_pte_range(pmd, addr, next, walk);
   131			if (err)
   132				break;
   133	
   134			if (walk->action == ACTION_AGAIN)
   135				goto again;
   136		} while (pmd += cont_pmds, addr = next, addr != end);
   137	
   138		return err;
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

