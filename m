Return-Path: <linux-kernel+bounces-393517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4629BA1AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162428182A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B41A7AF6;
	Sat,  2 Nov 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ld2H0vHM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426B2FC52
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730568172; cv=none; b=ciXhnjTTx3Y3HDr+TyNYlg2kwR0LNOTmYr6OQ84kxiy9gEgBdzKAmmONw7/MCUNkkN5oZ3Ff4olNAsTrzxlCl/iST2/oj8AB1XC5pt/svfx4/vdunqB+Nk+vC0Fb7aEweb/AVdgSC9DrLeuXQj/ilsE9vGpjJ5TbWq1cBL0ISrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730568172; c=relaxed/simple;
	bh=XNGKGxWAqSn8LnzAKe6C4ocwFgOA/8v5UdCwrk4wPKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhiaRLqD4qGmV5GOh5q0ah1aZdWMp9lX269UfS4AgGCXW1jBpYDAP9yOt8zFb7G4yPft5+mXzE35aM65Ej6FCAjFRSfdxZEdU6uo82xaJZzXMrd7yA5/gqxelf9nlgciOCBGPuQuYm0HnqHMo+xoqLQWSITOcFcz3CyUvfA4QiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ld2H0vHM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730568171; x=1762104171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNGKGxWAqSn8LnzAKe6C4ocwFgOA/8v5UdCwrk4wPKY=;
  b=Ld2H0vHMb+q08Ggb51JqFw6WBHLaZrtYZC8X7S6z0yf5124TH/Jt6NBe
   e5/WkZsz0Ke7kIFzE/75jD0WnAlq8Pa1Azo3JoCQZQczGitaBQc4Qq8br
   EO/aV9zTyeOKkDB94BlXx9tLjHG8tAvQokdopyTmki8xOanrs3Fiz1fyq
   mpFTGd6npOuX2VNdMoAUMPMvodW6ufusyvgzsw+vZosVGPREKbaQ7/+1N
   op3cO2YvHUbj49JAMB3TR7wWpZtKk6rtft8xRO2Xw3iTy2Xw+FH8HOY9S
   R3P2PWEom0uB6Gh2sNd8hXtEb4qYvGVcmkDTCL7D9A178XehXYgQ//HXl
   w==;
X-CSE-ConnectionGUID: X/Pls0xXQryT+GSXNp0SFQ==
X-CSE-MsgGUID: JLPNfSImR+WHlapQgXElzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30190735"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30190735"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 10:22:50 -0700
X-CSE-ConnectionGUID: 3TLj/OQVQgqqe4ixgpfTPQ==
X-CSE-MsgGUID: slKwWB4qSR6c+S+tnGhm9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="83378580"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Nov 2024 10:22:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7Hpk-000jCb-06;
	Sat, 02 Nov 2024 17:22:44 +0000
Date: Sun, 3 Nov 2024 01:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v2 6/6] mm/truncate: use folio_split() for truncate
 operation.
Message-ID: <202411030124.ZWzXWxPU-lkp@intel.com>
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
config: arc-tb10x_defconfig (https://download.01.org/0day-ci/archive/20241103/202411030124.ZWzXWxPU-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411030124.ZWzXWxPU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411030124.ZWzXWxPU-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/truncate.c: In function 'truncate_inode_partial_folio':
>> mm/truncate.c:214:13: error: implicit declaration of function 'split_folio_at'; did you mean 'split_folio'? [-Werror=implicit-function-declaration]
     214 |         if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
         |             ^~~~~~~~~~~~~~
         |             split_folio
   cc1: some warnings being treated as errors


vim +214 mm/truncate.c

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

