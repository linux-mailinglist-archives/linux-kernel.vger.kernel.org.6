Return-Path: <linux-kernel+bounces-527557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5DA40C97
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA87189A3B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0535946;
	Sun, 23 Feb 2025 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwK2IVNr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C711BC5C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740279047; cv=none; b=LwToQJ5F2NO+DWaVKzkaOgKQoI1Qmk/TvXoNF70o/HESzxMshIg7ZmTjq0XPJ4oyTBjTrKtGX6S+7CUBJ9z37eYNdFzgB690cGoFL49eyJiQhp3sYa8TaNgFzyufCMur54RdbJJiu7t/kJV5Sluk6Ka+Sd/XdRYXdENIo+G3d2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740279047; c=relaxed/simple;
	bh=o9JI+RqD9lPiFbPUitbIj19813kjveae0uIUnGd5kJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXFZa1f79ofuTh3s91dw9vs9esmbdzuts4KVgZ+aDCdbfN1dZrPwWS7aph2VfxPg6Z9RfJEH9Go4OpnptqKj0GQDemsXB1qUHjf6K3TehFBXmVG3ACvxWkmAbjPXKkT7rcPLD5BFECkjJJVcEIQB0vkHoYBgk4e8EhJNXeIrh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwK2IVNr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740279045; x=1771815045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9JI+RqD9lPiFbPUitbIj19813kjveae0uIUnGd5kJU=;
  b=HwK2IVNri7Se13f5QuMvpq8y2efne+bXVyzB8YatyWfEaTJUXjLhLnEt
   IoxfomShoMcYkmn+fJtgsJ7SPCWaWcx58TImMd44RtgSg1B7meJrGrxc5
   cv5vDh+Wh9GJllNXFg2gBViW+adljCQAGLDkO5enfS24Mu+yXYrs6kR+E
   VINfZ5bu9VYimfMY5yAT6xqE3JDtfn+wtm+wb3qFUI6glznbqOtEgsbXr
   g9mulNHCDHzl6Y2pCPy4yX7bmS+YVLrYsxPhgvdbIEr6qcRTnJBxMRkM4
   86jmBJdcibYvKiTOKR87EBn64tQPHdNY3gshVXysSjlD2urjLtzKpf19Y
   w==;
X-CSE-ConnectionGUID: 1rs5ueU2RemK6SaVnYkKLg==
X-CSE-MsgGUID: NkXtmKS4SB2DgddtcsOqWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="40298013"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="40298013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 18:50:44 -0800
X-CSE-ConnectionGUID: 6G5Hxa/aQTOuJQ6lEqYyoA==
X-CSE-MsgGUID: CO5fbxuCT2Og2fQ5TY0vcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120356647"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Feb 2025 18:50:40 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm24k-000751-1R;
	Sun, 23 Feb 2025 02:50:38 +0000
Date: Sun, 23 Feb 2025 10:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, david@redhat.com,
	kasong@tencent.com, ryan.roberts@arm.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com,
	baohua@kernel.org, hanchuanhua@oppo.com, willy@infradead.org,
	mawupeng1@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
Message-ID: <202502231048.C7L22P7h-lkp@intel.com>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222024617.2790609-1-mawupeng1@huawei.com>

Hi Wupeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Wupeng-Ma/mm-swap-Avoid-infinite-loop-if-no-valid-swap-entry-found-during-do_swap_page/20250222-105637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250222024617.2790609-1-mawupeng1%40huawei.com
patch subject: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry found during do_swap_page
config: s390-randconfig-002-20250223 (https://download.01.org/0day-ci/archive/20250223/202502231048.C7L22P7h-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231048.C7L22P7h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231048.C7L22P7h-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory.c:4404:17: error: call to undeclared function '_swap_info_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (unlikely(!_swap_info_get(entry)))
                                 ^
   1 error generated.


vim +/_swap_info_get +4404 mm/memory.c

  4322	
  4323	/*
  4324	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  4325	 * but allow concurrent faults), and pte mapped but not yet locked.
  4326	 * We return with pte unmapped and unlocked.
  4327	 *
  4328	 * We return with the mmap_lock locked or unlocked in the same cases
  4329	 * as does filemap_fault().
  4330	 */
  4331	vm_fault_t do_swap_page(struct vm_fault *vmf)
  4332	{
  4333		struct vm_area_struct *vma = vmf->vma;
  4334		struct folio *swapcache, *folio = NULL;
  4335		DECLARE_WAITQUEUE(wait, current);
  4336		struct page *page;
  4337		struct swap_info_struct *si = NULL;
  4338		rmap_t rmap_flags = RMAP_NONE;
  4339		bool need_clear_cache = false;
  4340		bool exclusive = false;
  4341		swp_entry_t entry;
  4342		pte_t pte;
  4343		vm_fault_t ret = 0;
  4344		void *shadow = NULL;
  4345		int nr_pages;
  4346		unsigned long page_idx;
  4347		unsigned long address;
  4348		pte_t *ptep;
  4349	
  4350		if (!pte_unmap_same(vmf))
  4351			goto out;
  4352	
  4353		entry = pte_to_swp_entry(vmf->orig_pte);
  4354		if (unlikely(non_swap_entry(entry))) {
  4355			if (is_migration_entry(entry)) {
  4356				migration_entry_wait(vma->vm_mm, vmf->pmd,
  4357						     vmf->address);
  4358			} else if (is_device_exclusive_entry(entry)) {
  4359				vmf->page = pfn_swap_entry_to_page(entry);
  4360				ret = remove_device_exclusive_entry(vmf);
  4361			} else if (is_device_private_entry(entry)) {
  4362				struct dev_pagemap *pgmap;
  4363				if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
  4364					/*
  4365					 * migrate_to_ram is not yet ready to operate
  4366					 * under VMA lock.
  4367					 */
  4368					vma_end_read(vma);
  4369					ret = VM_FAULT_RETRY;
  4370					goto out;
  4371				}
  4372	
  4373				vmf->page = pfn_swap_entry_to_page(entry);
  4374				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4375						vmf->address, &vmf->ptl);
  4376				if (unlikely(!vmf->pte ||
  4377					     !pte_same(ptep_get(vmf->pte),
  4378								vmf->orig_pte)))
  4379					goto unlock;
  4380	
  4381				/*
  4382				 * Get a page reference while we know the page can't be
  4383				 * freed.
  4384				 */
  4385				get_page(vmf->page);
  4386				pte_unmap_unlock(vmf->pte, vmf->ptl);
  4387				pgmap = page_pgmap(vmf->page);
  4388				ret = pgmap->ops->migrate_to_ram(vmf);
  4389				put_page(vmf->page);
  4390			} else if (is_hwpoison_entry(entry)) {
  4391				ret = VM_FAULT_HWPOISON;
  4392			} else if (is_pte_marker_entry(entry)) {
  4393				ret = handle_pte_marker(vmf);
  4394			} else {
  4395				print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
  4396				ret = VM_FAULT_SIGBUS;
  4397			}
  4398			goto out;
  4399		}
  4400	
  4401		/* Prevent swapoff from happening to us. */
  4402		si = get_swap_device(entry);
  4403		if (unlikely(!si)) {
> 4404			if (unlikely(!_swap_info_get(entry)))
  4405				/*
  4406				 * return VM_FAULT_SIGBUS for invalid swap entry to
  4407				 * avoid infinite #PF.
  4408				 */
  4409				ret = VM_FAULT_SIGBUS;
  4410			goto out;
  4411		}
  4412	
  4413		folio = swap_cache_get_folio(entry, vma, vmf->address);
  4414		if (folio)
  4415			page = folio_file_page(folio, swp_offset(entry));
  4416		swapcache = folio;
  4417	
  4418		if (!folio) {
  4419			if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
  4420			    __swap_count(entry) == 1) {
  4421				/* skip swapcache */
  4422				folio = alloc_swap_folio(vmf);
  4423				if (folio) {
  4424					__folio_set_locked(folio);
  4425					__folio_set_swapbacked(folio);
  4426	
  4427					nr_pages = folio_nr_pages(folio);
  4428					if (folio_test_large(folio))
  4429						entry.val = ALIGN_DOWN(entry.val, nr_pages);
  4430					/*
  4431					 * Prevent parallel swapin from proceeding with
  4432					 * the cache flag. Otherwise, another thread
  4433					 * may finish swapin first, free the entry, and
  4434					 * swapout reusing the same entry. It's
  4435					 * undetectable as pte_same() returns true due
  4436					 * to entry reuse.
  4437					 */
  4438					if (swapcache_prepare(entry, nr_pages)) {
  4439						/*
  4440						 * Relax a bit to prevent rapid
  4441						 * repeated page faults.
  4442						 */
  4443						add_wait_queue(&swapcache_wq, &wait);
  4444						schedule_timeout_uninterruptible(1);
  4445						remove_wait_queue(&swapcache_wq, &wait);
  4446						goto out_page;
  4447					}
  4448					need_clear_cache = true;
  4449	
  4450					memcg1_swapin(entry, nr_pages);
  4451	
  4452					shadow = get_shadow_from_swap_cache(entry);
  4453					if (shadow)
  4454						workingset_refault(folio, shadow);
  4455	
  4456					folio_add_lru(folio);
  4457	
  4458					/* To provide entry to swap_read_folio() */
  4459					folio->swap = entry;
  4460					swap_read_folio(folio, NULL);
  4461					folio->private = NULL;
  4462				}
  4463			} else {
  4464				folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
  4465							vmf);
  4466				swapcache = folio;
  4467			}
  4468	
  4469			if (!folio) {
  4470				/*
  4471				 * Back out if somebody else faulted in this pte
  4472				 * while we released the pte lock.
  4473				 */
  4474				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4475						vmf->address, &vmf->ptl);
  4476				if (likely(vmf->pte &&
  4477					   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  4478					ret = VM_FAULT_OOM;
  4479				goto unlock;
  4480			}
  4481	
  4482			/* Had to read the page from swap area: Major fault */
  4483			ret = VM_FAULT_MAJOR;
  4484			count_vm_event(PGMAJFAULT);
  4485			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
  4486			page = folio_file_page(folio, swp_offset(entry));
  4487		} else if (PageHWPoison(page)) {
  4488			/*
  4489			 * hwpoisoned dirty swapcache pages are kept for killing
  4490			 * owner processes (which may be unknown at hwpoison time)
  4491			 */
  4492			ret = VM_FAULT_HWPOISON;
  4493			goto out_release;
  4494		}
  4495	
  4496		ret |= folio_lock_or_retry(folio, vmf);
  4497		if (ret & VM_FAULT_RETRY)
  4498			goto out_release;
  4499	
  4500		if (swapcache) {
  4501			/*
  4502			 * Make sure folio_free_swap() or swapoff did not release the
  4503			 * swapcache from under us.  The page pin, and pte_same test
  4504			 * below, are not enough to exclude that.  Even if it is still
  4505			 * swapcache, we need to check that the page's swap has not
  4506			 * changed.
  4507			 */
  4508			if (unlikely(!folio_test_swapcache(folio) ||
  4509				     page_swap_entry(page).val != entry.val))
  4510				goto out_page;
  4511	
  4512			/*
  4513			 * KSM sometimes has to copy on read faults, for example, if
  4514			 * page->index of !PageKSM() pages would be nonlinear inside the
  4515			 * anon VMA -- PageKSM() is lost on actual swapout.
  4516			 */
  4517			folio = ksm_might_need_to_copy(folio, vma, vmf->address);
  4518			if (unlikely(!folio)) {
  4519				ret = VM_FAULT_OOM;
  4520				folio = swapcache;
  4521				goto out_page;
  4522			} else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
  4523				ret = VM_FAULT_HWPOISON;
  4524				folio = swapcache;
  4525				goto out_page;
  4526			}
  4527			if (folio != swapcache)
  4528				page = folio_page(folio, 0);
  4529	
  4530			/*
  4531			 * If we want to map a page that's in the swapcache writable, we
  4532			 * have to detect via the refcount if we're really the exclusive
  4533			 * owner. Try removing the extra reference from the local LRU
  4534			 * caches if required.
  4535			 */
  4536			if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
  4537			    !folio_test_ksm(folio) && !folio_test_lru(folio))
  4538				lru_add_drain();
  4539		}
  4540	
  4541		folio_throttle_swaprate(folio, GFP_KERNEL);
  4542	
  4543		/*
  4544		 * Back out if somebody else already faulted in this pte.
  4545		 */
  4546		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
  4547				&vmf->ptl);
  4548		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
  4549			goto out_nomap;
  4550	
  4551		if (unlikely(!folio_test_uptodate(folio))) {
  4552			ret = VM_FAULT_SIGBUS;
  4553			goto out_nomap;
  4554		}
  4555	
  4556		/* allocated large folios for SWP_SYNCHRONOUS_IO */
  4557		if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
  4558			unsigned long nr = folio_nr_pages(folio);
  4559			unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
  4560			unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
  4561			pte_t *folio_ptep = vmf->pte - idx;
  4562			pte_t folio_pte = ptep_get(folio_ptep);
  4563	
  4564			if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
  4565			    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
  4566				goto out_nomap;
  4567	
  4568			page_idx = idx;
  4569			address = folio_start;
  4570			ptep = folio_ptep;
  4571			goto check_folio;
  4572		}
  4573	
  4574		nr_pages = 1;
  4575		page_idx = 0;
  4576		address = vmf->address;
  4577		ptep = vmf->pte;
  4578		if (folio_test_large(folio) && folio_test_swapcache(folio)) {
  4579			int nr = folio_nr_pages(folio);
  4580			unsigned long idx = folio_page_idx(folio, page);
  4581			unsigned long folio_start = address - idx * PAGE_SIZE;
  4582			unsigned long folio_end = folio_start + nr * PAGE_SIZE;
  4583			pte_t *folio_ptep;
  4584			pte_t folio_pte;
  4585	
  4586			if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
  4587				goto check_folio;
  4588			if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
  4589				goto check_folio;
  4590	
  4591			folio_ptep = vmf->pte - idx;
  4592			folio_pte = ptep_get(folio_ptep);
  4593			if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
  4594			    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
  4595				goto check_folio;
  4596	
  4597			page_idx = idx;
  4598			address = folio_start;
  4599			ptep = folio_ptep;
  4600			nr_pages = nr;
  4601			entry = folio->swap;
  4602			page = &folio->page;
  4603		}
  4604	
  4605	check_folio:
  4606		/*
  4607		 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
  4608		 * must never point at an anonymous page in the swapcache that is
  4609		 * PG_anon_exclusive. Sanity check that this holds and especially, that
  4610		 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
  4611		 * check after taking the PT lock and making sure that nobody
  4612		 * concurrently faulted in this page and set PG_anon_exclusive.
  4613		 */
  4614		BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
  4615		BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
  4616	
  4617		/*
  4618		 * Check under PT lock (to protect against concurrent fork() sharing
  4619		 * the swap entry concurrently) for certainly exclusive pages.
  4620		 */
  4621		if (!folio_test_ksm(folio)) {
  4622			exclusive = pte_swp_exclusive(vmf->orig_pte);
  4623			if (folio != swapcache) {
  4624				/*
  4625				 * We have a fresh page that is not exposed to the
  4626				 * swapcache -> certainly exclusive.
  4627				 */
  4628				exclusive = true;
  4629			} else if (exclusive && folio_test_writeback(folio) &&
  4630				  data_race(si->flags & SWP_STABLE_WRITES)) {
  4631				/*
  4632				 * This is tricky: not all swap backends support
  4633				 * concurrent page modifications while under writeback.
  4634				 *
  4635				 * So if we stumble over such a page in the swapcache
  4636				 * we must not set the page exclusive, otherwise we can
  4637				 * map it writable without further checks and modify it
  4638				 * while still under writeback.
  4639				 *
  4640				 * For these problematic swap backends, simply drop the
  4641				 * exclusive marker: this is perfectly fine as we start
  4642				 * writeback only if we fully unmapped the page and
  4643				 * there are no unexpected references on the page after
  4644				 * unmapping succeeded. After fully unmapped, no
  4645				 * further GUP references (FOLL_GET and FOLL_PIN) can
  4646				 * appear, so dropping the exclusive marker and mapping
  4647				 * it only R/O is fine.
  4648				 */
  4649				exclusive = false;
  4650			}
  4651		}
  4652	
  4653		/*
  4654		 * Some architectures may have to restore extra metadata to the page
  4655		 * when reading from swap. This metadata may be indexed by swap entry
  4656		 * so this must be called before swap_free().
  4657		 */
  4658		arch_swap_restore(folio_swap(entry, folio), folio);
  4659	
  4660		/*
  4661		 * Remove the swap entry and conditionally try to free up the swapcache.
  4662		 * We're already holding a reference on the page but haven't mapped it
  4663		 * yet.
  4664		 */
  4665		swap_free_nr(entry, nr_pages);
  4666		if (should_try_to_free_swap(folio, vma, vmf->flags))
  4667			folio_free_swap(folio);
  4668	
  4669		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
  4670		add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
  4671		pte = mk_pte(page, vma->vm_page_prot);
  4672		if (pte_swp_soft_dirty(vmf->orig_pte))
  4673			pte = pte_mksoft_dirty(pte);
  4674		if (pte_swp_uffd_wp(vmf->orig_pte))
  4675			pte = pte_mkuffd_wp(pte);
  4676	
  4677		/*
  4678		 * Same logic as in do_wp_page(); however, optimize for pages that are
  4679		 * certainly not shared either because we just allocated them without
  4680		 * exposing them to the swapcache or because the swap entry indicates
  4681		 * exclusivity.
  4682		 */
  4683		if (!folio_test_ksm(folio) &&
  4684		    (exclusive || folio_ref_count(folio) == 1)) {
  4685			if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
  4686			    !pte_needs_soft_dirty_wp(vma, pte)) {
  4687				pte = pte_mkwrite(pte, vma);
  4688				if (vmf->flags & FAULT_FLAG_WRITE) {
  4689					pte = pte_mkdirty(pte);
  4690					vmf->flags &= ~FAULT_FLAG_WRITE;
  4691				}
  4692			}
  4693			rmap_flags |= RMAP_EXCLUSIVE;
  4694		}
  4695		folio_ref_add(folio, nr_pages - 1);
  4696		flush_icache_pages(vma, page, nr_pages);
  4697		vmf->orig_pte = pte_advance_pfn(pte, page_idx);
  4698	
  4699		/* ksm created a completely new copy */
  4700		if (unlikely(folio != swapcache && swapcache)) {
  4701			folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
  4702			folio_add_lru_vma(folio, vma);
  4703		} else if (!folio_test_anon(folio)) {
  4704			/*
  4705			 * We currently only expect small !anon folios which are either
  4706			 * fully exclusive or fully shared, or new allocated large
  4707			 * folios which are fully exclusive. If we ever get large
  4708			 * folios within swapcache here, we have to be careful.
  4709			 */
  4710			VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
  4711			VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
  4712			folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
  4713		} else {
  4714			folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
  4715						rmap_flags);
  4716		}
  4717	
  4718		VM_BUG_ON(!folio_test_anon(folio) ||
  4719				(pte_write(pte) && !PageAnonExclusive(page)));
  4720		set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
  4721		arch_do_swap_page_nr(vma->vm_mm, vma, address,
  4722				pte, pte, nr_pages);
  4723	
  4724		folio_unlock(folio);
  4725		if (folio != swapcache && swapcache) {
  4726			/*
  4727			 * Hold the lock to avoid the swap entry to be reused
  4728			 * until we take the PT lock for the pte_same() check
  4729			 * (to avoid false positives from pte_same). For
  4730			 * further safety release the lock after the swap_free
  4731			 * so that the swap count won't change under a
  4732			 * parallel locked swapcache.
  4733			 */
  4734			folio_unlock(swapcache);
  4735			folio_put(swapcache);
  4736		}
  4737	
  4738		if (vmf->flags & FAULT_FLAG_WRITE) {
  4739			ret |= do_wp_page(vmf);
  4740			if (ret & VM_FAULT_ERROR)
  4741				ret &= VM_FAULT_ERROR;
  4742			goto out;
  4743		}
  4744	
  4745		/* No need to invalidate - it was non-present before */
  4746		update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
  4747	unlock:
  4748		if (vmf->pte)
  4749			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4750	out:
  4751		/* Clear the swap cache pin for direct swapin after PTL unlock */
  4752		if (need_clear_cache) {
  4753			swapcache_clear(si, entry, nr_pages);
  4754			if (waitqueue_active(&swapcache_wq))
  4755				wake_up(&swapcache_wq);
  4756		}
  4757		if (si)
  4758			put_swap_device(si);
  4759		return ret;
  4760	out_nomap:
  4761		if (vmf->pte)
  4762			pte_unmap_unlock(vmf->pte, vmf->ptl);
  4763	out_page:
  4764		folio_unlock(folio);
  4765	out_release:
  4766		folio_put(folio);
  4767		if (folio != swapcache && swapcache) {
  4768			folio_unlock(swapcache);
  4769			folio_put(swapcache);
  4770		}
  4771		if (need_clear_cache) {
  4772			swapcache_clear(si, entry, nr_pages);
  4773			if (waitqueue_active(&swapcache_wq))
  4774				wake_up(&swapcache_wq);
  4775		}
  4776		if (si)
  4777			put_swap_device(si);
  4778		return ret;
  4779	}
  4780	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

