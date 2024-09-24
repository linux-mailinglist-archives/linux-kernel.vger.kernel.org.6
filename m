Return-Path: <linux-kernel+bounces-337800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB68984F22
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402671F23FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C22146A7B;
	Tue, 24 Sep 2024 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDzVV7tl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612E155A47
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221854; cv=none; b=prQ7+qF+xgb1xmutb0obKQBXJleOeGeSr6AXWyJ+J05woeVRLehCH9zfMAIF1GL2DLyUN2SuACWF59EUoGe9GvHMCLMjtdmcR3FlQ2RgpdDTi+QJnAseh8Im+KdKCi062w9UhDSxFNGzpi5SEgrfN7jBygTlf2c5jpYLOYlb+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221854; c=relaxed/simple;
	bh=xzUJ3zukvZfElPbt2Z5quXr4jMyCuiOFAFWEOwXh75w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzjk33vBLsX4IGSzDN48u9yUiJF88B5mbr8urmrGrXdfHtAAu/kGOnihzFfhwZ5rWcrc4oX0lI502D7Djp6EK+LZ2A4ha8zRDGLgP5hUEFKp0Y7nqn5qEFkTEq1llVsGyo8itMLidpAAlVgZexGmWm5pc1QlbSnDc+0K2kpJP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDzVV7tl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727221852; x=1758757852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzUJ3zukvZfElPbt2Z5quXr4jMyCuiOFAFWEOwXh75w=;
  b=oDzVV7tlqZRXR3wu2/khEtvDb1D/janTj5xVn8L5gnqSBToP8S4vf6N1
   c20bi5o9w3Q3+IT9Iq3J6oyqvGkmY6pdyPD1qiPVr71yD+iXpENSnC/Ck
   baaV9lN19cODI2X1+/D/uW+Bd+d3vybam6/mRhv/nfdlvV+cGpbPu7Ju5
   6lSGWRuIOKPpSmiopx4gw+H5B/or4kFQAhhfaZJ02wlhmceLpnaFFnJgY
   VLiPTI5kah0Sd+/77DRotIX+R4NLP8O3eLOpUZAWf+qjNY3WTiQDLEovg
   SWxPCbIPDa4/ymzjt9fI1OsVLiwsZ4KLgEXsDdAEjjs283sY72IXY4qQh
   w==;
X-CSE-ConnectionGUID: bVSG9LlMRrCI9YrQRIOgdA==
X-CSE-MsgGUID: 0SrnApUDTey3kPUFlhGfAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30036210"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="30036210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:50:51 -0700
X-CSE-ConnectionGUID: d1btZrH1TpSwXxRkNnra0A==
X-CSE-MsgGUID: Fp3EfMN5TiWW+D80qaF9sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72419029"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Sep 2024 16:50:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stFIr-000Ix1-03;
	Tue, 24 Sep 2024 23:50:45 +0000
Date: Wed, 25 Sep 2024 07:50:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jeongjun Park <aha310510@gmail.com>, dennis@kernel.org, tj@kernel.org,
	cl@linux.com
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] mm: percpu: fix typo to pcpu_alloc_noprof() description
Message-ID: <202409250728.jWiBpk6e-lkp@intel.com>
References: <20240924152412.118487-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924152412.118487-1-aha310510@gmail.com>

Hi Jeongjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/mm-percpu-fix-typo-to-pcpu_alloc_noprof-description/20240924-232509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240924152412.118487-1-aha310510%40gmail.com
patch subject: [PATCH] mm: percpu: fix typo to pcpu_alloc_noprof() description
config: arc-randconfig-001-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250728.jWiBpk6e-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250728.jWiBpk6e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250728.jWiBpk6e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/percpu.c:1745: warning: expecting prototype for pcpu_alloc_noprof(). Prototype was for pcpu_alloc() instead


vim +1745 mm/percpu.c

60fa4a9e232317 Kent Overstreet        2024-03-21  1727  
fbf59bc9d74d1f Tejun Heo              2009-02-20  1728  /**
f63f9cc5b5d1ea Jeongjun Park          2024-09-25  1729   * pcpu_alloc_noprof - the percpu allocator
cae3aeb83fef5a Tejun Heo              2009-02-21  1730   * @size: size of area to allocate in bytes
fbf59bc9d74d1f Tejun Heo              2009-02-20  1731   * @align: alignment of area (max PAGE_SIZE)
edcb463997ed7b Tejun Heo              2009-03-06  1732   * @reserved: allocate from the reserved chunk if available
5835d96e9ce4ef Tejun Heo              2014-09-02  1733   * @gfp: allocation flags
fbf59bc9d74d1f Tejun Heo              2009-02-20  1734   *
5835d96e9ce4ef Tejun Heo              2014-09-02  1735   * Allocate percpu area of @size bytes aligned at @align.  If @gfp doesn't
0ea7eeec24be5f Daniel Borkmann        2017-10-17  1736   * contain %GFP_KERNEL, the allocation is atomic. If @gfp has __GFP_NOWARN
0ea7eeec24be5f Daniel Borkmann        2017-10-17  1737   * then no warning will be triggered on invalid or failed allocation
0ea7eeec24be5f Daniel Borkmann        2017-10-17  1738   * requests.
fbf59bc9d74d1f Tejun Heo              2009-02-20  1739   *
fbf59bc9d74d1f Tejun Heo              2009-02-20  1740   * RETURNS:
fbf59bc9d74d1f Tejun Heo              2009-02-20  1741   * Percpu pointer to the allocated area on success, NULL on failure.
fbf59bc9d74d1f Tejun Heo              2009-02-20  1742   */
24e44cc22aa311 Suren Baghdasaryan     2024-03-21  1743  void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
5835d96e9ce4ef Tejun Heo              2014-09-02  1744  				 gfp_t gfp)
fbf59bc9d74d1f Tejun Heo              2009-02-20 @1745  {
28307d938fb2e4 Filipe Manana          2020-05-07  1746  	gfp_t pcpu_gfp;
28307d938fb2e4 Filipe Manana          2020-05-07  1747  	bool is_atomic;
28307d938fb2e4 Filipe Manana          2020-05-07  1748  	bool do_warn;
3c7be18ac9a06b Roman Gushchin         2020-08-11  1749  	struct obj_cgroup *objcg = NULL;
f2badb0c950ed3 Tejun Heo              2009-09-29  1750  	static int warn_limit = 10;
8744d859427c61 Dennis Zhou            2019-02-25  1751  	struct pcpu_chunk *chunk, *next;
f2badb0c950ed3 Tejun Heo              2009-09-29  1752  	const char *err;
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1753) 	int slot, off, cpu, ret;
403a91b1659cb1 Jiri Kosina            2009-10-29  1754  	unsigned long flags;
f528f0b8e53d73 Catalin Marinas        2011-09-26  1755  	void __percpu *ptr;
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1756) 	size_t bits, bit_align;
fbf59bc9d74d1f Tejun Heo              2009-02-20  1757  
28307d938fb2e4 Filipe Manana          2020-05-07  1758  	gfp = current_gfp_context(gfp);
28307d938fb2e4 Filipe Manana          2020-05-07  1759  	/* whitelisted flags that can be passed to the backing allocators */
28307d938fb2e4 Filipe Manana          2020-05-07  1760  	pcpu_gfp = gfp & (GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
28307d938fb2e4 Filipe Manana          2020-05-07  1761  	is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
28307d938fb2e4 Filipe Manana          2020-05-07  1762  	do_warn = !(gfp & __GFP_NOWARN);
28307d938fb2e4 Filipe Manana          2020-05-07  1763  
723ad1d90b5663 Al Viro                2014-03-06  1764  	/*
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1765) 	 * There is now a minimum allocation size of PCPU_MIN_ALLOC_SIZE,
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1766) 	 * therefore alignment must be a minimum of that many bytes.
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1767) 	 * An allocation may have internal fragmentation from rounding up
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1768) 	 * of up to PCPU_MIN_ALLOC_SIZE - 1 bytes.
723ad1d90b5663 Al Viro                2014-03-06  1769  	 */
d2f3c3849461ba Dennis Zhou (Facebook  2017-07-24  1770) 	if (unlikely(align < PCPU_MIN_ALLOC_SIZE))
d2f3c3849461ba Dennis Zhou (Facebook  2017-07-24  1771) 		align = PCPU_MIN_ALLOC_SIZE;
723ad1d90b5663 Al Viro                2014-03-06  1772  
d2f3c3849461ba Dennis Zhou (Facebook  2017-07-24  1773) 	size = ALIGN(size, PCPU_MIN_ALLOC_SIZE);
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1774) 	bits = size >> PCPU_MIN_ALLOC_SHIFT;
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1775) 	bit_align = align >> PCPU_MIN_ALLOC_SHIFT;
2f69fa829cb4ca Al Viro                2014-03-17  1776  
3ca45a46f8af8c zijun_hu               2016-10-14  1777  	if (unlikely(!size || size > PCPU_MIN_UNIT_SIZE || align > PAGE_SIZE ||
3ca45a46f8af8c zijun_hu               2016-10-14  1778  		     !is_power_of_2(align))) {
0ea7eeec24be5f Daniel Borkmann        2017-10-17  1779  		WARN(do_warn, "illegal size (%zu) or align (%zu) for percpu allocation\n",
756a025f000919 Joe Perches            2016-03-17  1780  		     size, align);
fbf59bc9d74d1f Tejun Heo              2009-02-20  1781  		return NULL;
fbf59bc9d74d1f Tejun Heo              2009-02-20  1782  	}
fbf59bc9d74d1f Tejun Heo              2009-02-20  1783  
faf65dde844aff Roman Gushchin         2021-06-02  1784  	if (unlikely(!pcpu_memcg_pre_alloc_hook(size, gfp, &objcg)))
3c7be18ac9a06b Roman Gushchin         2020-08-11  1785  		return NULL;
3c7be18ac9a06b Roman Gushchin         2020-08-11  1786  
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1787  	if (!is_atomic) {
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1788  		/*
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1789  		 * pcpu_balance_workfn() allocates memory under this mutex,
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1790  		 * and it may wait for memory reclaim. Allow current task
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1791  		 * to become OOM victim, in case of memory pressure.
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1792  		 */
3c7be18ac9a06b Roman Gushchin         2020-08-11  1793  		if (gfp & __GFP_NOFAIL) {
6710e594f71cca Tejun Heo              2016-05-25  1794  			mutex_lock(&pcpu_alloc_mutex);
3c7be18ac9a06b Roman Gushchin         2020-08-11  1795  		} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
3c7be18ac9a06b Roman Gushchin         2020-08-11  1796  			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1797  			return NULL;
f52ba1fef7b92e Kirill Tkhai           2018-03-19  1798  		}
3c7be18ac9a06b Roman Gushchin         2020-08-11  1799  	}
6710e594f71cca Tejun Heo              2016-05-25  1800  
403a91b1659cb1 Jiri Kosina            2009-10-29  1801  	spin_lock_irqsave(&pcpu_lock, flags);
fbf59bc9d74d1f Tejun Heo              2009-02-20  1802  
edcb463997ed7b Tejun Heo              2009-03-06  1803  	/* serve reserved allocations from the reserved chunk if available */
edcb463997ed7b Tejun Heo              2009-03-06  1804  	if (reserved && pcpu_reserved_chunk) {
edcb463997ed7b Tejun Heo              2009-03-06  1805  		chunk = pcpu_reserved_chunk;
833af8427be4b2 Tejun Heo              2009-11-11  1806  
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1807) 		off = pcpu_find_block_fit(chunk, bits, bit_align, is_atomic);
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1808) 		if (off < 0) {
833af8427be4b2 Tejun Heo              2009-11-11  1809  			err = "alloc from reserved chunk failed";
ccea34b5d0fbab Tejun Heo              2009-03-07  1810  			goto fail_unlock;
f2badb0c950ed3 Tejun Heo              2009-09-29  1811  		}
833af8427be4b2 Tejun Heo              2009-11-11  1812  
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1813) 		off = pcpu_alloc_area(chunk, bits, bit_align, off);
edcb463997ed7b Tejun Heo              2009-03-06  1814  		if (off >= 0)
edcb463997ed7b Tejun Heo              2009-03-06  1815  			goto area_found;
833af8427be4b2 Tejun Heo              2009-11-11  1816  
f2badb0c950ed3 Tejun Heo              2009-09-29  1817  		err = "alloc from reserved chunk failed";
ccea34b5d0fbab Tejun Heo              2009-03-07  1818  		goto fail_unlock;
edcb463997ed7b Tejun Heo              2009-03-06  1819  	}
edcb463997ed7b Tejun Heo              2009-03-06  1820  
ccea34b5d0fbab Tejun Heo              2009-03-07  1821  restart:
edcb463997ed7b Tejun Heo              2009-03-06  1822  	/* search through normal chunks */
f183324133ea53 Roman Gushchin         2021-04-07  1823  	for (slot = pcpu_size_to_slot(size); slot <= pcpu_free_slot; slot++) {
faf65dde844aff Roman Gushchin         2021-06-02  1824  		list_for_each_entry_safe(chunk, next, &pcpu_chunk_lists[slot],
faf65dde844aff Roman Gushchin         2021-06-02  1825  					 list) {
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1826) 			off = pcpu_find_block_fit(chunk, bits, bit_align,
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1827) 						  is_atomic);
8744d859427c61 Dennis Zhou            2019-02-25  1828  			if (off < 0) {
8744d859427c61 Dennis Zhou            2019-02-25  1829  				if (slot < PCPU_SLOT_FAIL_THRESHOLD)
8744d859427c61 Dennis Zhou            2019-02-25  1830  					pcpu_chunk_move(chunk, 0);
5835d96e9ce4ef Tejun Heo              2014-09-02  1831  				continue;
8744d859427c61 Dennis Zhou            2019-02-25  1832  			}
ccea34b5d0fbab Tejun Heo              2009-03-07  1833  
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1834) 			off = pcpu_alloc_area(chunk, bits, bit_align, off);
f183324133ea53 Roman Gushchin         2021-04-07  1835  			if (off >= 0) {
f183324133ea53 Roman Gushchin         2021-04-07  1836  				pcpu_reintegrate_chunk(chunk);
fbf59bc9d74d1f Tejun Heo              2009-02-20  1837  				goto area_found;
f183324133ea53 Roman Gushchin         2021-04-07  1838  			}
fbf59bc9d74d1f Tejun Heo              2009-02-20  1839  		}
fbf59bc9d74d1f Tejun Heo              2009-02-20  1840  	}
fbf59bc9d74d1f Tejun Heo              2009-02-20  1841  
403a91b1659cb1 Jiri Kosina            2009-10-29  1842  	spin_unlock_irqrestore(&pcpu_lock, flags);
ccea34b5d0fbab Tejun Heo              2009-03-07  1843  
11df02bf9bc1f6 Dennis Zhou            2017-06-21  1844  	if (is_atomic) {
11df02bf9bc1f6 Dennis Zhou            2017-06-21  1845  		err = "atomic alloc failed, no space left";
5835d96e9ce4ef Tejun Heo              2014-09-02  1846  		goto fail;
11df02bf9bc1f6 Dennis Zhou            2017-06-21  1847  	}
5835d96e9ce4ef Tejun Heo              2014-09-02  1848  
e04cb6976340d5 Baoquan He             2022-10-24  1849  	/* No space left.  Create a new chunk. */
faf65dde844aff Roman Gushchin         2021-06-02  1850  	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
faf65dde844aff Roman Gushchin         2021-06-02  1851  		chunk = pcpu_create_chunk(pcpu_gfp);
f2badb0c950ed3 Tejun Heo              2009-09-29  1852  		if (!chunk) {
f2badb0c950ed3 Tejun Heo              2009-09-29  1853  			err = "failed to allocate new chunk";
b38d08f3181c50 Tejun Heo              2014-09-02  1854  			goto fail;
f2badb0c950ed3 Tejun Heo              2009-09-29  1855  		}
ccea34b5d0fbab Tejun Heo              2009-03-07  1856  
403a91b1659cb1 Jiri Kosina            2009-10-29  1857  		spin_lock_irqsave(&pcpu_lock, flags);
fbf59bc9d74d1f Tejun Heo              2009-02-20  1858  		pcpu_chunk_relocate(chunk, -1);
b38d08f3181c50 Tejun Heo              2014-09-02  1859  	} else {
b38d08f3181c50 Tejun Heo              2014-09-02  1860  		spin_lock_irqsave(&pcpu_lock, flags);
b38d08f3181c50 Tejun Heo              2014-09-02  1861  	}
b38d08f3181c50 Tejun Heo              2014-09-02  1862  
ccea34b5d0fbab Tejun Heo              2009-03-07  1863  	goto restart;
fbf59bc9d74d1f Tejun Heo              2009-02-20  1864  
fbf59bc9d74d1f Tejun Heo              2009-02-20  1865  area_found:
30a5b5367ef9d5 Dennis Zhou            2017-06-19  1866  	pcpu_stats_area_alloc(chunk, size);
403a91b1659cb1 Jiri Kosina            2009-10-29  1867  	spin_unlock_irqrestore(&pcpu_lock, flags);
ccea34b5d0fbab Tejun Heo              2009-03-07  1868  
dca496451bddea Tejun Heo              2014-09-02  1869  	/* populate if not all pages are already there */
5835d96e9ce4ef Tejun Heo              2014-09-02  1870  	if (!is_atomic) {
ec288a2cf7ca40 Yury Norov             2021-08-14  1871  		unsigned int page_end, rs, re;
e04d320838f573 Tejun Heo              2014-09-02  1872  
ec288a2cf7ca40 Yury Norov             2021-08-14  1873  		rs = PFN_DOWN(off);
dca496451bddea Tejun Heo              2014-09-02  1874  		page_end = PFN_UP(off + size);
dca496451bddea Tejun Heo              2014-09-02  1875  
ec288a2cf7ca40 Yury Norov             2021-08-14  1876  		for_each_clear_bitrange_from(rs, re, chunk->populated, page_end) {
dca496451bddea Tejun Heo              2014-09-02  1877  			WARN_ON(chunk->immutable);
dca496451bddea Tejun Heo              2014-09-02  1878  
554fef1c39ee14 Dennis Zhou            2018-02-16  1879  			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
b38d08f3181c50 Tejun Heo              2014-09-02  1880  
403a91b1659cb1 Jiri Kosina            2009-10-29  1881  			spin_lock_irqsave(&pcpu_lock, flags);
b38d08f3181c50 Tejun Heo              2014-09-02  1882  			if (ret) {
40064aeca35c5c Dennis Zhou (Facebook  2017-07-12  1883) 				pcpu_free_area(chunk, off);
f2badb0c950ed3 Tejun Heo              2009-09-29  1884  				err = "failed to populate";
ccea34b5d0fbab Tejun Heo              2009-03-07  1885  				goto fail_unlock;
fbf59bc9d74d1f Tejun Heo              2009-02-20  1886  			}
b239f7daf5530f Dennis Zhou            2019-02-13  1887  			pcpu_chunk_populated(chunk, rs, re);
b38d08f3181c50 Tejun Heo              2014-09-02  1888  			spin_unlock_irqrestore(&pcpu_lock, flags);
dca496451bddea Tejun Heo              2014-09-02  1889  		}
dca496451bddea Tejun Heo              2014-09-02  1890  
ccea34b5d0fbab Tejun Heo              2009-03-07  1891  		mutex_unlock(&pcpu_alloc_mutex);
e04d320838f573 Tejun Heo              2014-09-02  1892  	}
ccea34b5d0fbab Tejun Heo              2009-03-07  1893  
faf65dde844aff Roman Gushchin         2021-06-02  1894  	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
1a4d76076cda69 Tejun Heo              2014-09-02  1895  		pcpu_schedule_balance_work();
1a4d76076cda69 Tejun Heo              2014-09-02  1896  
dca496451bddea Tejun Heo              2014-09-02  1897  	/* clear the areas and return address relative to base address */
dca496451bddea Tejun Heo              2014-09-02  1898  	for_each_possible_cpu(cpu)
dca496451bddea Tejun Heo              2014-09-02  1899  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
dca496451bddea Tejun Heo              2014-09-02  1900  
f528f0b8e53d73 Catalin Marinas        2011-09-26  1901  	ptr = __addr_to_pcpu_ptr(chunk->base_addr + off);
8a8c35fadfaf55 Larry Finger           2015-06-24  1902  	kmemleak_alloc_percpu(ptr, size, gfp);
df95e795a72289 Dennis Zhou            2017-06-19  1903  
f67bed134a0536 Vasily Averin          2022-05-12  1904  	trace_percpu_alloc_percpu(_RET_IP_, reserved, is_atomic, size, align,
f67bed134a0536 Vasily Averin          2022-05-12  1905  				  chunk->base_addr, off, ptr,
f67bed134a0536 Vasily Averin          2022-05-12  1906  				  pcpu_obj_full_size(size), gfp);
df95e795a72289 Dennis Zhou            2017-06-19  1907  
3c7be18ac9a06b Roman Gushchin         2020-08-11  1908  	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
3c7be18ac9a06b Roman Gushchin         2020-08-11  1909  
24e44cc22aa311 Suren Baghdasaryan     2024-03-21  1910  	pcpu_alloc_tag_alloc_hook(chunk, off, size);
24e44cc22aa311 Suren Baghdasaryan     2024-03-21  1911  
f528f0b8e53d73 Catalin Marinas        2011-09-26  1912  	return ptr;
ccea34b5d0fbab Tejun Heo              2009-03-07  1913  
ccea34b5d0fbab Tejun Heo              2009-03-07  1914  fail_unlock:
403a91b1659cb1 Jiri Kosina            2009-10-29  1915  	spin_unlock_irqrestore(&pcpu_lock, flags);
b38d08f3181c50 Tejun Heo              2014-09-02  1916  fail:
df95e795a72289 Dennis Zhou            2017-06-19  1917  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
df95e795a72289 Dennis Zhou            2017-06-19  1918  
f7d77dfc91f747 Baoquan He             2023-07-28  1919  	if (do_warn && warn_limit) {
870d4b12ad15d2 Joe Perches            2016-03-17  1920  		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
5835d96e9ce4ef Tejun Heo              2014-09-02  1921  			size, align, is_atomic, err);
f7d77dfc91f747 Baoquan He             2023-07-28  1922  		if (!is_atomic)
f2badb0c950ed3 Tejun Heo              2009-09-29  1923  			dump_stack();
f2badb0c950ed3 Tejun Heo              2009-09-29  1924  		if (!--warn_limit)
870d4b12ad15d2 Joe Perches            2016-03-17  1925  			pr_info("limit reached, disable warning\n");
f2badb0c950ed3 Tejun Heo              2009-09-29  1926  	}
f7d77dfc91f747 Baoquan He             2023-07-28  1927  
1a4d76076cda69 Tejun Heo              2014-09-02  1928  	if (is_atomic) {
f0953a1bbaca71 Ingo Molnar            2021-05-06  1929  		/* see the flag handling in pcpu_balance_workfn() */
1a4d76076cda69 Tejun Heo              2014-09-02  1930  		pcpu_atomic_alloc_failed = true;
1a4d76076cda69 Tejun Heo              2014-09-02  1931  		pcpu_schedule_balance_work();
6710e594f71cca Tejun Heo              2016-05-25  1932  	} else {
6710e594f71cca Tejun Heo              2016-05-25  1933  		mutex_unlock(&pcpu_alloc_mutex);
1a4d76076cda69 Tejun Heo              2014-09-02  1934  	}
3c7be18ac9a06b Roman Gushchin         2020-08-11  1935  
3c7be18ac9a06b Roman Gushchin         2020-08-11  1936  	pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
3c7be18ac9a06b Roman Gushchin         2020-08-11  1937  
ccea34b5d0fbab Tejun Heo              2009-03-07  1938  	return NULL;
fbf59bc9d74d1f Tejun Heo              2009-02-20  1939  }
24e44cc22aa311 Suren Baghdasaryan     2024-03-21  1940  EXPORT_SYMBOL_GPL(pcpu_alloc_noprof);
edcb463997ed7b Tejun Heo              2009-03-06  1941  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

