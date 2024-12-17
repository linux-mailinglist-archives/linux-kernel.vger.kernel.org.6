Return-Path: <linux-kernel+bounces-449588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A09F5115
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DC316B774
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB381F7598;
	Tue, 17 Dec 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1Zsc4zA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5F146A79
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453131; cv=none; b=nb+YqULWAEBgexUyo+IQ+Hepc4W8yiHrS7MgL/dIGnqTiq5N2xYxY+ff5Md4z7nA44xYRMylRhKkFdikGjCBltlA5b2kFyYTZMBGaUfyEGLWqcfljf2rPzOQvpEAFeQzdyJfboExYmewIYERHXGD+zpi6HV1HAVvqCTjKcAKb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453131; c=relaxed/simple;
	bh=cWl+NCae3g8dvXXxX8WAtTTOFXpTLR4ZRewmOj/yAn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAH+/FUF08vGBZK2ShsVuyVH2z2AeIQnXoR8kSa7RBIKFMK8i8qtX5Mrnk62MPsnKu+XsuuZnep1kdRn7HdiPZJG4xyJ/cqD5OwNs7x+zyMpKjNngHO21wvz8Dnsnig4GE+6Duje3PfwVksyN7kV5AiJe3dyxlImV7JGiNL8ZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1Zsc4zA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734453128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAQ2JLwsNJYB3wY8Gxo9g4g7L/yusZW+HJpjwGvFPmE=;
	b=G1Zsc4zA7F1RgjZn/ayN79q+UhOHUQd7SUUeakPxsrdIs5LrU0uTIfCPkNmb+OSwGjyZxS
	/JoE5eOcKSMGi8Ma+yDZShK9SHt0lRwm1/rxWG1ln1ph2ogKpyoC3m/vDbVeK7XVmJUXmx
	1kc3ETqFFNX3q9OlteKBHHTkbbUYOSk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Dl-Fr7DDMSe-VCc6_YVXrQ-1; Tue,
 17 Dec 2024 11:32:05 -0500
X-MC-Unique: Dl-Fr7DDMSe-VCc6_YVXrQ-1
X-Mimecast-MFC-AGG-ID: Dl-Fr7DDMSe-VCc6_YVXrQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8E851956077;
	Tue, 17 Dec 2024 16:32:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8A0D30044C1;
	Tue, 17 Dec 2024 16:32:02 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-mm@kvack.org,
	mgorman@techsingularity.net,
	willy@infradead.org
Cc: david@redhat.com,
	linux-kernel@vger.kernel.org,
	lcapitulino@gmail.com
Subject: [PATCH 2/2] mm: alloc_pages_bulk: rename API
Date: Tue, 17 Dec 2024 11:31:28 -0500
Message-ID: <c0ca588a54915bc058574c052fd12ef710fb5446.1734453061.git.luizcap@redhat.com>
In-Reply-To: <cover.1734453061.git.luizcap@redhat.com>
References: <cover.1734453061.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The previous commit removed the page_list argument from
alloc_pages_bulk_noprof() along with the alloc_pages_bulk_list() function.

Now that only the *_array() flavour of the API remains, we can do the
following renaming (along with the _noprof() ones):

  alloc_pages_bulk_array -> alloc_pages_bulk
  alloc_pages_bulk_array_mempolicy -> alloc_pages_bulk_mempolicy
  alloc_pages_bulk_array_node -> alloc_pages_bulk_node

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c | 12 ++++++------
 drivers/vfio/pci/mlx5/cmd.c                    | 14 +++++++-------
 drivers/vfio/pci/virtio/migrate.c              |  6 +++---
 fs/btrfs/extent_io.c                           |  2 +-
 fs/erofs/zutil.c                               |  4 ++--
 fs/splice.c                                    |  2 +-
 fs/xfs/xfs_buf.c                               |  4 ++--
 include/linux/gfp.h                            | 14 +++++++-------
 kernel/bpf/arena.c                             |  2 +-
 lib/alloc_tag.c                                |  4 ++--
 lib/kunit_iov_iter.c                           |  2 +-
 lib/test_vmalloc.c                             |  2 +-
 mm/mempolicy.c                                 | 14 +++++++-------
 mm/vmalloc.c                                   |  4 ++--
 net/core/page_pool.c                           |  7 +++----
 net/sunrpc/svc.c                               |  4 ++--
 net/sunrpc/svc_xprt.c                          |  3 +--
 17 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
index 07ed33464d711..b191953eaa941 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
@@ -604,7 +604,7 @@ struct hmm_buffer_object *hmm_bo_device_search_vmap_start(
 	return bo;
 }
 
-static void free_pages_bulk_array(unsigned long nr_pages, struct page **page_array)
+static void free_pages_bulk(unsigned long nr_pages, struct page **page_array)
 {
 	unsigned long i;
 
@@ -615,7 +615,7 @@ static void free_pages_bulk_array(unsigned long nr_pages, struct page **page_arr
 static void free_private_bo_pages(struct hmm_buffer_object *bo)
 {
 	set_pages_array_wb(bo->pages, bo->pgnr);
-	free_pages_bulk_array(bo->pgnr, bo->pages);
+	free_pages_bulk(bo->pgnr, bo->pages);
 }
 
 /*Allocate pages which will be used only by ISP*/
@@ -624,17 +624,17 @@ static int alloc_private_pages(struct hmm_buffer_object *bo)
 	const gfp_t gfp = __GFP_NOWARN | __GFP_RECLAIM | __GFP_FS;
 	int ret;
 
-	ret = alloc_pages_bulk_array(gfp, bo->pgnr, bo->pages);
+	ret = alloc_pages_bulk(gfp, bo->pgnr, bo->pages);
 	if (ret != bo->pgnr) {
-		free_pages_bulk_array(ret, bo->pages);
-		dev_err(atomisp_dev, "alloc_pages_bulk_array() failed\n");
+		free_pages_bulk(ret, bo->pages);
+		dev_err(atomisp_dev, "alloc_pages_bulk() failed\n");
 		return -ENOMEM;
 	}
 
 	ret = set_pages_array_uc(bo->pages, bo->pgnr);
 	if (ret) {
 		dev_err(atomisp_dev, "set pages uncacheable failed.\n");
-		free_pages_bulk_array(bo->pgnr, bo->pages);
+		free_pages_bulk(bo->pgnr, bo->pages);
 		return ret;
 	}
 
diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index eb7387ee6ebd1..11eda6b207f13 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -408,7 +408,7 @@ void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 				  buf->dma_dir, 0);
 	}
 
-	/* Undo alloc_pages_bulk_array() */
+	/* Undo alloc_pages_bulk() */
 	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
 		__free_page(sg_page_iter_page(&sg_iter));
 	sg_free_append_table(&buf->table);
@@ -431,8 +431,8 @@ static int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
 		return -ENOMEM;
 
 	do {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
-						page_list);
+		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT, to_fill,
+					  page_list);
 		if (!filled) {
 			ret = -ENOMEM;
 			goto err;
@@ -1342,7 +1342,7 @@ static void free_recv_pages(struct mlx5_vhca_recv_buf *recv_buf)
 {
 	int i;
 
-	/* Undo alloc_pages_bulk_array() */
+	/* Undo alloc_pages_bulk() */
 	for (i = 0; i < recv_buf->npages; i++)
 		__free_page(recv_buf->page_list[i]);
 
@@ -1361,9 +1361,9 @@ static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
 		return -ENOMEM;
 
 	for (;;) {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT,
-						npages - done,
-						recv_buf->page_list + done);
+		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT,
+					  npages - done,
+					  recv_buf->page_list + done);
 		if (!filled)
 			goto err;
 
diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index ee54f4c178577..ba92bb4e9af94 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -77,8 +77,8 @@ static int virtiovf_add_migration_pages(struct virtiovf_data_buffer *buf,
 		return -ENOMEM;
 
 	do {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
-						page_list);
+		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT, to_fill,
+					  page_list);
 		if (!filled) {
 			ret = -ENOMEM;
 			goto err;
@@ -112,7 +112,7 @@ static void virtiovf_free_data_buffer(struct virtiovf_data_buffer *buf)
 {
 	struct sg_page_iter sg_iter;
 
-	/* Undo alloc_pages_bulk_array() */
+	/* Undo alloc_pages_bulk() */
 	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
 		__free_page(sg_page_iter_page(&sg_iter));
 	sg_free_append_table(&buf->table);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b923d0cec61c7..d70e9461fea86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -632,7 +632,7 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 	for (allocated = 0; allocated < nr_pages;) {
 		unsigned int last = allocated;
 
-		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
+		allocated = alloc_pages_bulk(gfp, nr_pages, page_array);
 		if (unlikely(allocated == last)) {
 			/* No progress, fail and do cleanup. */
 			for (int i = 0; i < allocated; i++) {
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 75704f58ecfa9..a71add9b7012b 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -87,8 +87,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 			tmp_pages[j] = gbuf->pages[j];
 		do {
 			last = j;
-			j = alloc_pages_bulk_array(GFP_KERNEL, nrpages,
-						   tmp_pages);
+			j = alloc_pages_bulk(GFP_KERNEL, nrpages,
+					     tmp_pages);
 			if (last == j)
 				goto out;
 		} while (j != nrpages);
diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e638..28cfa63aa2364 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -342,7 +342,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 		return -ENOMEM;
 
 	pages = (struct page **)(bv + npages);
-	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
+	npages = alloc_pages_bulk(GFP_USER, npages, pages);
 	if (!npages) {
 		kfree(bv);
 		return -ENOMEM;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa63b8efd7822..82db3ab0e8b40 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -395,8 +395,8 @@ xfs_buf_alloc_pages(
 	for (;;) {
 		long	last = filled;
 
-		filled = alloc_pages_bulk_array(gfp_mask, bp->b_page_count,
-						bp->b_pages);
+		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
+					  bp->b_pages);
 		if (filled == bp->b_page_count) {
 			XFS_STATS_INC(bp->b_mount, xb_page_found);
 			break;
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index eebed36443b35..64c3f0729bdc6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -215,18 +215,18 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 				struct page **page_array);
 #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(__VA_ARGS__))
 
-unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
+unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
 				unsigned long nr_pages,
 				struct page **page_array);
-#define  alloc_pages_bulk_array_mempolicy(...)				\
-	alloc_hooks(alloc_pages_bulk_array_mempolicy_noprof(__VA_ARGS__))
+#define  alloc_pages_bulk_mempolicy(...)				\
+	alloc_hooks(alloc_pages_bulk_mempolicy_noprof(__VA_ARGS__))
 
 /* Bulk allocate order-0 pages */
-#define alloc_pages_bulk_array(_gfp, _nr_pages, _page_array)		\
+#define alloc_pages_bulk(_gfp, _nr_pages, _page_array)		\
 	__alloc_pages_bulk(_gfp, numa_mem_id(), NULL, _nr_pages, _page_array)
 
 static inline unsigned long
-alloc_pages_bulk_array_node_noprof(gfp_t gfp, int nid, unsigned long nr_pages,
+alloc_pages_bulk_node_noprof(gfp_t gfp, int nid, unsigned long nr_pages,
 				   struct page **page_array)
 {
 	if (nid == NUMA_NO_NODE)
@@ -235,8 +235,8 @@ alloc_pages_bulk_array_node_noprof(gfp_t gfp, int nid, unsigned long nr_pages,
 	return alloc_pages_bulk_noprof(gfp, nid, NULL, nr_pages, page_array);
 }
 
-#define alloc_pages_bulk_array_node(...)				\
-	alloc_hooks(alloc_pages_bulk_array_node_noprof(__VA_ARGS__))
+#define alloc_pages_bulk_node(...)				\
+	alloc_hooks(alloc_pages_bulk_node_noprof(__VA_ARGS__))
 
 static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 {
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 945a5680f6a54..9927cd4c9e0ea 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -443,7 +443,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			return 0;
 	}
 
-	/* zeroing is needed, since alloc_pages_bulk_array() only fills in non-zero entries */
+	/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
 	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return 0;
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 35f7560a309a4..f419763a743c2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -410,8 +410,8 @@ static int vm_module_tags_populate(void)
 		unsigned long nr;
 
 		more_pages = ALIGN(module_tags.size - phys_size, PAGE_SIZE) >> PAGE_SHIFT;
-		nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
-						 NUMA_NO_NODE, more_pages, next_page);
+		nr = alloc_pages_bulk_node(GFP_KERNEL | __GFP_NOWARN,
+				           NUMA_NO_NODE, more_pages, next_page);
 		if (nr < more_pages ||
 		    vmap_pages_range(addr, addr + (nr << PAGE_SHIFT), PAGE_KERNEL,
 				     next_page, PAGE_SHIFT) < 0) {
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 13e15687675a8..830bf3eca4c2e 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -57,7 +57,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
 	*ppages = pages;
 
-	got = alloc_pages_bulk_array(GFP_KERNEL, npages, pages);
+	got = alloc_pages_bulk(GFP_KERNEL, npages, pages);
 	if (got != npages) {
 		release_pages(pages, got);
 		KUNIT_ASSERT_EQ(test, got, npages);
diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 4ddf769861ff7..f585949ff696e 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -373,7 +373,7 @@ vm_map_ram_test(void)
 	if (!pages)
 		return -1;
 
-	nr_allocated = alloc_pages_bulk_array(GFP_KERNEL, map_nr_pages, pages);
+	nr_allocated = alloc_pages_bulk(GFP_KERNEL, map_nr_pages, pages);
 	if (nr_allocated != map_nr_pages)
 		goto cleanup;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42a7b07ccc15a..69bc9019368e4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2356,7 +2356,7 @@ struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
 }
 EXPORT_SYMBOL(folio_alloc_noprof);
 
-static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
+static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
@@ -2391,7 +2391,7 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
-static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
+static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
@@ -2506,7 +2506,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
-static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
+static unsigned long alloc_pages_bulk_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
@@ -2532,7 +2532,7 @@ static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
  * It can accelerate memory allocation especially interleaving
  * allocate memory.
  */
-unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
+unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
 		unsigned long nr_pages, struct page **page_array)
 {
 	struct mempolicy *pol = &default_policy;
@@ -2543,15 +2543,15 @@ unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
 		pol = get_task_policy(current);
 
 	if (pol->mode == MPOL_INTERLEAVE)
-		return alloc_pages_bulk_array_interleave(gfp, pol,
+		return alloc_pages_bulk_interleave(gfp, pol,
 							 nr_pages, page_array);
 
 	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
-		return alloc_pages_bulk_array_weighted_interleave(
+		return alloc_pages_bulk_weighted_interleave(
 				  gfp, pol, nr_pages, page_array);
 
 	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_bulk_array_preferred_many(gfp,
+		return alloc_pages_bulk_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
 
 	nid = numa_node_id();
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f009b21705c16..0ca555f688812 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3560,11 +3560,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
+				nr = alloc_pages_bulk_mempolicy_noprof(gfp,
 							nr_pages_request,
 							pages + nr_allocated);
 			else
-				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
+				nr = alloc_pages_bulk_node_noprof(gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f89cf93f6eb45..8a91c1972dc50 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -532,12 +532,11 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	if (unlikely(pool->alloc.count > 0))
 		return pool->alloc.cache[--pool->alloc.count];
 
-	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
+	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
 
-	nr_pages = alloc_pages_bulk_array_node(gfp,
-					       pool->p.nid, bulk,
-					       (struct page **)pool->alloc.cache);
+	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
+					 (struct page **)pool->alloc.cache);
 	if (unlikely(!nr_pages))
 		return 0;
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 79879b7d39cb4..e7f9c295d13c0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -651,8 +651,8 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
 	if (pages > RPCSVC_MAXPAGES)
 		pages = RPCSVC_MAXPAGES;
 
-	ret = alloc_pages_bulk_array_node(GFP_KERNEL, node, pages,
-					  rqstp->rq_pages);
+	ret = alloc_pages_bulk_node(GFP_KERNEL, node, pages,
+				    rqstp->rq_pages);
 	return ret == pages;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 43c57124de52f..aebc0d8ddff5c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -671,8 +671,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 	}
 
 	for (filled = 0; filled < pages; filled = ret) {
-		ret = alloc_pages_bulk_array(GFP_KERNEL, pages,
-					     rqstp->rq_pages);
+		ret = alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
 		if (ret > filled)
 			/* Made progress, don't sleep yet */
 			continue;
-- 
2.47.1


