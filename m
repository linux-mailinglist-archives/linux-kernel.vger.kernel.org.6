Return-Path: <linux-kernel+bounces-393493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4C9BA148
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5549B214D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219AB1A725F;
	Sat,  2 Nov 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QObOxf0J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB241A0BF1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561988; cv=none; b=t4rA/TFJVnkp2mufcdE/vZdlGg+vPiPtaKMiI9bDkGq0Zrf6DDSUefsAtI1JGoYRKY22+3uzmyRjOWaonbUNvph7o9aFmNzNlz1DY9dCUcdtB7FSrhCUAk3FugERNVGodx3E5TDbgS/wBWJrHS4qv7+Zr8bs0ecK6vMdxbGPm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561988; c=relaxed/simple;
	bh=6xdnxqTTRU/Hew1YfnBAtA+49Z2PkSSXvr/YM2PbjL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP7Av3BmXrIb+Ra9gG/bQKttdziFNaZzZfxohDhe/gsBRwFMfHQ8cQAmrkc9GHXQF0B6xCHJMVn9LdLAxLsINQh0AIKfTGde+xw1NlhqF9Z1058+TquTiNJKjCAjlGBCnkhoHn+OykZ3elN/SMDjUPloOQQXS80tpjNzg2y3/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QObOxf0J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730561986; x=1762097986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6xdnxqTTRU/Hew1YfnBAtA+49Z2PkSSXvr/YM2PbjL8=;
  b=QObOxf0J3fUOzLSf0CFZM3r5VeWjCLQdZfsdGWRP2eM8tOY3etPJRQSf
   xiJOt/JjGV06Gc/2e6l8BWdQ+LTkeOhJ0h5OY4tM4un1CM7P75lDg77F6
   4ciN+BnxvxBdfppToElMtzGR5WDORrtXSQO/R02VVQ8OCqSa8h9aGjVoN
   iXm9tu8lZl/idj1FDLKhzK2I/HqxJcD9IYkHXGS6suSmQoEhLAQUiPuu5
   yDw+yJopWUrQAuRqPzNpiMkAp+pCv3+87HV9KCnw/f2Z2S9wWtvsjhqp2
   Ddww7/KASLMTzlVHcMB4ZxziAyelKPq3c2MonWwn/KUqrTuzqTP+9GcZ+
   A==;
X-CSE-ConnectionGUID: eLiGtICHShq6W2TFvEv4Qw==
X-CSE-MsgGUID: K/nqAtOUQ3imGWK1NRzaIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30188255"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30188255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 08:39:46 -0700
X-CSE-ConnectionGUID: F9HMnr+FTreWyvojn1ZRcg==
X-CSE-MsgGUID: g3cMNDXsSQKT8RHorv8cMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="84058110"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Nov 2024 08:39:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7GE0-000j7l-0l;
	Sat, 02 Nov 2024 15:39:40 +0000
Date: Sat, 2 Nov 2024 23:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v2 6/6] mm/truncate: use folio_split() for truncate
 operation.
Message-ID: <202411022321.XN6rYrgx-lkp@intel.com>
References: <20241101150357.1752726-7-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101150357.1752726-7-ziy@nvidia.com>

Hi Zi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20241101]
[cannot apply to linus/master v6.12-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-huge_memory-add-two-new-yet-used-functions-for-folio_split/20241101-230623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241101150357.1752726-7-ziy%40nvidia.com
patch subject: [PATCH v2 6/6] mm/truncate: use folio_split() for truncate operation.
config: arm-multi_v4t_defconfig (https://download.01.org/0day-ci/archive/20241102/202411022321.XN6rYrgx-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022321.XN6rYrgx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022321.XN6rYrgx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/truncate.c:12:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2211:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/truncate.c:24:
   In file included from mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/truncate.c:214:6: error: call to undeclared function 'split_folio_at'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     214 |         if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
         |             ^
   3 warnings and 1 error generated.


vim +/split_folio_at +214 mm/truncate.c

   166	
   167	/*
   168	 * Handle partial folios.  The folio may be entirely within the
   169	 * range if a split has raced with us.  If not, we zero the part of the
   170	 * folio that's within the [start, end] range, and then split the folio if
   171	 * it's large.  split_page_range() will discard pages which now lie beyond
   172	 * i_size, and we rely on the caller to discard pages which lie within a
   173	 * newly created hole.
   174	 *
   175	 * Returns false if splitting failed so the caller can avoid
   176	 * discarding the entire folio which is stubbornly unsplit.
   177	 */
   178	bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
   179	{
   180		loff_t pos = folio_pos(folio);
   181		unsigned int offset, length;
   182		long in_folio_offset;
   183	
   184		if (pos < start)
   185			offset = start - pos;
   186		else
   187			offset = 0;
   188		length = folio_size(folio);
   189		if (pos + length <= (u64)end)
   190			length = length - offset;
   191		else
   192			length = end + 1 - pos - offset;
   193	
   194		folio_wait_writeback(folio);
   195		if (length == folio_size(folio)) {
   196			truncate_inode_folio(folio->mapping, folio);
   197			return true;
   198		}
   199	
   200		/*
   201		 * We may be zeroing pages we're about to discard, but it avoids
   202		 * doing a complex calculation here, and then doing the zeroing
   203		 * anyway if the page split fails.
   204		 */
   205		if (!mapping_inaccessible(folio->mapping))
   206			folio_zero_range(folio, offset, length);
   207	
   208		if (folio_needs_release(folio))
   209			folio_invalidate(folio, offset, length);
   210		if (!folio_test_large(folio))
   211			return true;
   212	
   213		in_folio_offset = PAGE_ALIGN_DOWN(offset) / PAGE_SIZE;
 > 214		if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
   215			return true;
   216		if (folio_test_dirty(folio))
   217			return false;
   218		truncate_inode_folio(folio->mapping, folio);
   219		return true;
   220	}
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

