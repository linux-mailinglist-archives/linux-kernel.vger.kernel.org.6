Return-Path: <linux-kernel+bounces-516387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42646A37079
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D67A40BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266351F1537;
	Sat, 15 Feb 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQgYiMQY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41715696E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739649389; cv=none; b=ZljehuB6MwGrjnmQIKLMPJYaaq4Kkvr+N1JtWU+5nRSJywBBJq0x+87SRO3b+uIsNcFIo1j1b2eEFpBiMMxpBZxbBJ36HSe9D4wBfsDhIBvzENbQx8vT14gTmiPmUPz+8ku4CAyidvYsEgZpZs24H/8oOGvuTdpddtMf/cdZR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739649389; c=relaxed/simple;
	bh=ydU1zNDahgtP6kUc1gFheUqp4Vjx1qtR/ZPWizYZ47k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GH1py9Moipf/WldGqKk9TTlNLB490GGLgomEbz2+uOsAJx1BcnysS5gzfBYYKOPlDxAWxI3HARRWzsl+Xai5kLhLkdv01zH+jb47hJWLD9i+EUlhGTCxbxnF4SHes7MZ1cUF4b60QN1M1pteYVb1jUgx5+WGURajv40pmhzFS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQgYiMQY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739649388; x=1771185388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ydU1zNDahgtP6kUc1gFheUqp4Vjx1qtR/ZPWizYZ47k=;
  b=XQgYiMQYC3EMOe46YM4NuqPyKoKcom11W6G6XM5tVdDa9NZQuKD6nycd
   Ne+i+y6adtNJgAkzHuZHjCvQ1SLa+QbMAyBbNjUgGcbyIgYMVKHML0Vu+
   uyQRqlaausRoPXOJ+sr2m9ZRWZUttyhdYu0McVeBiC1wwtHAND8E/S8Wt
   DKsttcvPeFOwVtnJZIIu990ugIQX9YkicArISJxaKOxhNODMBhagDIzl3
   gCsPh4D/iaaWbiiUNDh7wCXtWoOiczXv/j+8Rb1nzJfA4weXDoWbpMOm0
   4/hTXK+m+XGMqCdJ1CIgg3uLnazsPcAfpfshe7qtH80FaToRxokYMpQgq
   g==;
X-CSE-ConnectionGUID: ffIirmqZRrKlRi/81ZwB7w==
X-CSE-MsgGUID: Hj1nz00IRmyuiiSIy4U8MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="62846549"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="62846549"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 11:56:27 -0800
X-CSE-ConnectionGUID: Ei33MiQuR6WSY/1OfaAoeA==
X-CSE-MsgGUID: YUFMtB6wRSSfz3r6FqwVQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="114384691"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Feb 2025 11:56:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjOH0-001B8N-2C;
	Sat, 15 Feb 2025 19:56:22 +0000
Date: Sun, 16 Feb 2025 03:56:06 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"T.J. Mercier" <tjmercier@google.com>
Subject: mm/workingset.c:621 workingset_update_node() warn: unsigned '_x' is
 never less than zero.
Message-ID: <202502160323.ZLUfooA0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ff71e6d923969d933e1ba7e0db857782d36cd19
commit: 4715c6a753dccd15fd3a8928168f57e349205bd4 mm: cleanup WORKINGSET_NODES in workingset
date:   9 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502160323.ZLUfooA0-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160323.ZLUfooA0-lkp@intel.com/

New smatch warnings:
mm/workingset.c:621 workingset_update_node() warn: unsigned '_x' is never less than zero.
mm/workingset.c:746 shadow_lru_isolate() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
include/linux/mm.h:1306 virt_to_head_page() warn: unsigned '_x' is never less than zero.

vim +/_x +621 mm/workingset.c

   617	
   618	void workingset_update_node(struct xa_node *node)
   619	{
   620		struct address_space *mapping;
 > 621		struct page *page = virt_to_page(node);
   622	
   623		/*
   624		 * Track non-empty nodes that contain only shadow entries;
   625		 * unlink those that contain pages or are being freed.
   626		 *
   627		 * Avoid acquiring the list_lru lock when the nodes are
   628		 * already where they should be. The list_empty() test is safe
   629		 * as node->private_list is protected by the i_pages lock.
   630		 */
   631		mapping = container_of(node->array, struct address_space, i_pages);
   632		lockdep_assert_held(&mapping->i_pages.xa_lock);
   633	
   634		if (node->count && node->count == node->nr_values) {
   635			if (list_empty(&node->private_list)) {
   636				list_lru_add_obj(&shadow_nodes, &node->private_list);
   637				__inc_node_page_state(page, WORKINGSET_NODES);
   638			}
   639		} else {
   640			if (!list_empty(&node->private_list)) {
   641				list_lru_del_obj(&shadow_nodes, &node->private_list);
   642				__dec_node_page_state(page, WORKINGSET_NODES);
   643			}
   644		}
   645	}
   646	
   647	static unsigned long count_shadow_nodes(struct shrinker *shrinker,
   648						struct shrink_control *sc)
   649	{
   650		unsigned long max_nodes;
   651		unsigned long nodes;
   652		unsigned long pages;
   653	
   654		nodes = list_lru_shrink_count(&shadow_nodes, sc);
   655		if (!nodes)
   656			return SHRINK_EMPTY;
   657	
   658		/*
   659		 * Approximate a reasonable limit for the nodes
   660		 * containing shadow entries. We don't need to keep more
   661		 * shadow entries than possible pages on the active list,
   662		 * since refault distances bigger than that are dismissed.
   663		 *
   664		 * The size of the active list converges toward 100% of
   665		 * overall page cache as memory grows, with only a tiny
   666		 * inactive list. Assume the total cache size for that.
   667		 *
   668		 * Nodes might be sparsely populated, with only one shadow
   669		 * entry in the extreme case. Obviously, we cannot keep one
   670		 * node for every eligible shadow entry, so compromise on a
   671		 * worst-case density of 1/8th. Below that, not all eligible
   672		 * refaults can be detected anymore.
   673		 *
   674		 * On 64-bit with 7 xa_nodes per page and 64 slots
   675		 * each, this will reclaim shadow entries when they consume
   676		 * ~1.8% of available memory:
   677		 *
   678		 * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
   679		 */
   680	#ifdef CONFIG_MEMCG
   681		if (sc->memcg) {
   682			struct lruvec *lruvec;
   683			int i;
   684	
   685			mem_cgroup_flush_stats_ratelimited(sc->memcg);
   686			lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
   687			for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
   688				pages += lruvec_page_state_local(lruvec,
   689								 NR_LRU_BASE + i);
   690			pages += lruvec_page_state_local(
   691				lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
   692			pages += lruvec_page_state_local(
   693				lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
   694		} else
   695	#endif
   696			pages = node_present_pages(sc->nid);
   697	
   698		max_nodes = pages >> (XA_CHUNK_SHIFT - 3);
   699	
   700		if (nodes <= max_nodes)
   701			return 0;
   702		return nodes - max_nodes;
   703	}
   704	
   705	static enum lru_status shadow_lru_isolate(struct list_head *item,
   706						  struct list_lru_one *lru,
   707						  spinlock_t *lru_lock,
   708						  void *arg) __must_hold(lru_lock)
   709	{
   710		struct xa_node *node = container_of(item, struct xa_node, private_list);
   711		struct address_space *mapping;
   712		int ret;
   713	
   714		/*
   715		 * Page cache insertions and deletions synchronously maintain
   716		 * the shadow node LRU under the i_pages lock and the
   717		 * lru_lock.  Because the page cache tree is emptied before
   718		 * the inode can be destroyed, holding the lru_lock pins any
   719		 * address_space that has nodes on the LRU.
   720		 *
   721		 * We can then safely transition to the i_pages lock to
   722		 * pin only the address_space of the particular node we want
   723		 * to reclaim, take the node off-LRU, and drop the lru_lock.
   724		 */
   725	
   726		mapping = container_of(node->array, struct address_space, i_pages);
   727	
   728		/* Coming from the list, invert the lock order */
   729		if (!xa_trylock(&mapping->i_pages)) {
   730			spin_unlock_irq(lru_lock);
   731			ret = LRU_RETRY;
   732			goto out;
   733		}
   734	
   735		/* For page cache we need to hold i_lock */
   736		if (mapping->host != NULL) {
   737			if (!spin_trylock(&mapping->host->i_lock)) {
   738				xa_unlock(&mapping->i_pages);
   739				spin_unlock_irq(lru_lock);
   740				ret = LRU_RETRY;
   741				goto out;
   742			}
   743		}
   744	
   745		list_lru_isolate(lru, item);
 > 746		__dec_node_page_state(virt_to_page(node), WORKINGSET_NODES);
   747	
   748		spin_unlock(lru_lock);
   749	
   750		/*
   751		 * The nodes should only contain one or more shadow entries,
   752		 * no pages, so we expect to be able to remove them all and
   753		 * delete and free the empty node afterwards.
   754		 */
   755		if (WARN_ON_ONCE(!node->nr_values))
   756			goto out_invalid;
   757		if (WARN_ON_ONCE(node->count != node->nr_values))
   758			goto out_invalid;
   759		xa_delete_node(node, workingset_update_node);
   760		__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
   761	
   762	out_invalid:
   763		xa_unlock_irq(&mapping->i_pages);
   764		if (mapping->host != NULL) {
   765			if (mapping_shrinkable(mapping))
   766				inode_add_lru(mapping->host);
   767			spin_unlock(&mapping->host->i_lock);
   768		}
   769		ret = LRU_REMOVED_RETRY;
   770	out:
   771		cond_resched();
   772		spin_lock_irq(lru_lock);
   773		return ret;
   774	}
   775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

