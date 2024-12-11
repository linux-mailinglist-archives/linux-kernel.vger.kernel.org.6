Return-Path: <linux-kernel+bounces-440822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5E9EC4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81652285117
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881A1C3F27;
	Wed, 11 Dec 2024 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PppvmsIR"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF81C1F2F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898438; cv=none; b=sEkaBTWT2K5/NvTPBx6OQf0v/rjwLt1XquKGxCba38p+B3nd6l9X4yw5sq7wn7dZxt0156ASYbCzHEPSOPf99xYAA/jRwge6+LrhZXLsLPi+QUzgtHqbB+qHkhx6tAWyJ2o3Zkms/To09WLBCrhEWn28gzqc2BzXuMQrZmvay0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898438; c=relaxed/simple;
	bh=qY7+nIk/RUbz/taCzZUapsFP78VxHgVGrb3eSFCF2oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPugwt11vhr7a5WcuR3ZqaXBGbrJqiWC8a/GsO/xHsX78tAbatJ/Xmh7MiEz1HeQXHrku/G7AurNWhZEJflE9iX4/GmoGpI3YRKFt/oYIFDpI+ck1KHs8CONLS7vAWe2PnwmBSOeyEgSTOX7M1DXJgbOCnH7PMrZba7Fv5vWqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PppvmsIR; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733898427; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rVVoZx7AwEDV4Z9iTlK+a+Fddq+8GT10d2eCCYoPtQQ=;
	b=PppvmsIREfv6v3yt+T5zvkY3J4HPvyLgHsYeJzNHDo+kzTeIjQjfe+MgSrTfsd5Wcu4uXEdi+aswf38MiXYg5HfHrUIfEtun65Mmz/aXfZIz/0YSdNM85Wi57h2uEDISu8Bpwk1lyaxEHBxbs6YEpizWRuNaZScFaVuh0z2Q/7E=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLHBLZA_1733898425 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 14:27:06 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	kasong@tencent.com,
	ying.huang@linux.alibaba.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: skip swapcache for swapin of synchronous swap device
Date: Wed, 11 Dec 2024 14:26:54 +0800
Message-Id: <8c40d045dc1ea46cc0983c0188b566615d9eb490.1733897892.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fast swap devices (such as zram), swapin latency is crucial to applications.
For shmem swapin, similar to anonymous memory swapin, we can skip the swapcache
operation to improve swapin latency. Testing 1G shmem sequential swapin without
THP enabled, I observed approximately a 6% performance improvement:
(Note: I repeated 5 times and took the mean data for each test)

w/o patch	w/ patch	changes
534.8ms		501ms		+6.3%

In addition, currently, we always split the large swap entry stored in the
shmem mapping during shmem large folio swapin, which is not perfect, especially
with a fast swap device. We can swap in the whole large folio instead of
splitting the precious large folios to take advantage of the large folios
and improve the swapin latency if the swap device is synchronous device,
which is also similar to anonymous memory mTHP swapin. Testing 1G shmem
sequential swapin with 64K mTHP and 2M mTHP, I observed obvious performance
improvement:

mTHP=64K
w/o patch	w/ patch	changes
550.4ms		169.6ms		+69%

mTHP=2M
w/o patch	w/ patch	changes
542.8ms		126.8ms		+77%

Note that skipping swapcache requires attention to concurrent swapin scenarios.
Fortunately the swapcache_prepare() and shmem_add_to_page_cache() can help
identify concurrent swapin and large swap entry split scenarios, and return
-EEXIST for retry.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 41d7a181ed89..a110f973dec0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1966,6 +1966,66 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	return ERR_PTR(error);
 }
 
+static struct folio *shmem_swap_alloc_folio(struct inode *inode, struct vm_area_struct *vma,
+					    pgoff_t index, swp_entry_t entry, int order, gfp_t gfp)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct folio *new;
+	void *shadow;
+	int nr_pages;
+
+	/*
+	 * We have arrived here because our zones are constrained, so don't
+	 * limit chance of success by further cpuset and node constraints.
+	 */
+	gfp &= ~GFP_CONSTRAINT_MASK;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (order > 0) {
+		gfp_t huge_gfp = vma_thp_gfp_mask(vma);
+
+		gfp = limit_gfp_mask(huge_gfp, gfp);
+	}
+#endif
+
+	new = shmem_alloc_folio(gfp, order, info, index);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	nr_pages = folio_nr_pages(new);
+	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
+					   gfp, entry)) {
+		folio_put(new);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Prevent parallel swapin from proceeding with the swap cache flag.
+	 *
+	 * Of course there is another possible concurrent scenario as well,
+	 * that is to say, the swap cache flag of a large folio has already
+	 * been set by swapcache_prepare(), while another thread may have
+	 * already split the large swap entry stored in the shmem mapping.
+	 * In this case, shmem_add_to_page_cache() will help identify the
+	 * concurrent swapin and return -EEXIST.
+	 */
+	if (swapcache_prepare(entry, nr_pages)) {
+		folio_put(new);
+		return ERR_PTR(-EEXIST);
+	}
+
+	__folio_set_locked(new);
+	__folio_set_swapbacked(new);
+	new->swap = entry;
+
+	mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
+	shadow = get_shadow_from_swap_cache(entry);
+	if (shadow)
+		workingset_refault(new, shadow);
+	folio_add_lru(new);
+	swap_read_folio(new, NULL);
+	return new;
+}
+
 /*
  * When a page is moved from swapcache to shmem filecache (either by the
  * usual swapin of shmem_get_folio_gfp(), or by the less common swapoff of
@@ -2189,6 +2249,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
+	bool skip_swapcache = false;
 	swp_entry_t swap;
 	int error, nr_pages;
 
@@ -2210,6 +2271,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
+		int order = xa_get_order(&mapping->i_pages, index);
+		bool fallback_order0 = false;
 		int split_order;
 
 		/* Or update major stats only when swapin succeeds?? */
@@ -2219,6 +2282,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 
+		/*
+		 * If uffd is active for the vma, we need per-page fault
+		 * fidelity to maintain the uffd semantics, then fallback
+		 * to swapin order-0 folio, as well as for zswap case.
+		 */
+		if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma))) ||
+				  !zswap_never_enabled()))
+			fallback_order0 = true;
+
+		/* Skip swapcache for synchronous device. */
+		if (!fallback_order0 && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
+			if (!IS_ERR(folio)) {
+				skip_swapcache = true;
+				goto alloced;
+			}
+
+			/*
+			 * Fallback to swapin order-0 folio unless the swap entry
+			 * already exists.
+			 */
+			error = PTR_ERR(folio);
+			folio = NULL;
+			if (error == -EEXIST)
+				goto failed;
+		}
+
 		/*
 		 * Now swap device can only swap in order 0 folio, then we
 		 * should split the large swap entry stored in the pagecache
@@ -2249,9 +2339,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		}
 	}
 
+alloced:
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
-	if (!folio_test_swapcache(folio) ||
+	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
 	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap)) {
 		error = -EEXIST;
@@ -2287,7 +2378,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
-	delete_from_swap_cache(folio);
+	if (skip_swapcache) {
+		folio->swap.val = 0;
+		swapcache_clear(si, swap, nr_pages);
+	} else {
+		delete_from_swap_cache(folio);
+	}
 	folio_mark_dirty(folio);
 	swap_free_nr(swap, nr_pages);
 	put_swap_device(si);
@@ -2300,6 +2396,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (error == -EIO)
 		shmem_set_folio_swapin_error(inode, index, folio, swap);
 unlock:
+	if (skip_swapcache)
+		swapcache_clear(si, swap, folio_nr_pages(folio));
 	if (folio) {
 		folio_unlock(folio);
 		folio_put(folio);
-- 
2.39.3


