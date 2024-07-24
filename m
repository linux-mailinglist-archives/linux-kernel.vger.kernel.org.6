Return-Path: <linux-kernel+bounces-260685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4493ACFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9217283B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C79B61FD4;
	Wed, 24 Jul 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eOXCl17L"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205044D8C1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804988; cv=none; b=Efv08QBSRPz4eajCedf8h1hDpO+fDD5ginyzHdwW7F6/nQC6lHyF/wRL6KkDhDET/ZC99geyqoZdcekCcovvg8K1lc+xFun72jnJWtsDqT5HuVFmcXriYhNzn0Rc8QXZ9A7UAysWO7h8Xk4ZUEJrD18DkWQIKBjdBoRrIKGWiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804988; c=relaxed/simple;
	bh=/FSCp9MYs7Fjl/w2a2kuAhE78vlHDZzXvzlaAb03DBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WS3GkGsBQcz3JlcaVre0H43rpXESnEsLX/qP0KFfgxCTTjiuo7AdKHFwfz5j1ht0CNVqm24f7zIhaQFH9W5c+IPev4Wn5AEJZEnWZzg4RK5+twQ2XG81n7Wuq2XlSAFQTOWaFemderNU/fuoXyzvuy7muZp4R2IuCklhLqeqYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eOXCl17L; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721804978; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IgdtO0YJm1XtjSUXDNrZ8xElYsmGF7utZpmG/kiJcWg=;
	b=eOXCl17Lur8cOw1XteLn83KcttdQoDxMCd8YMW9IwOccdzL9YIQ9tCOdLG5EfasqJpmEt7d0pQOcWRa6YcwbZGvjpbhlYDmKKf4KumlGvmbNLnpS9eIstEv/rt9qOScg5J5fAsOEUtXEldl6+0OzbbFJmZV9AxW9ynYFsubnNSs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBDDM2T_1721804659;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBDDM2T_1721804659)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 15:04:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm: shmem: add file length arg in shmem_get_folio() path
Date: Wed, 24 Jul 2024 15:03:58 +0800
Message-Id: <70972d294797b377bf24a7290659e9057b978287.1721720891.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
References: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gomez <da.gomez@samsung.com>

In preparation for large folio in the write and fallocate paths, add
file length argument in shmem_get_folio() path to be able to calculate
the folio order based on the file size. Use of order-0 (PAGE_SIZE) for
read, page cache read, and vm fault.

This enables high order folios in the write and fallocate path once the
folio order is calculated based on the length.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 fs/xfs/scrub/xfile.c     |  6 +++---
 fs/xfs/xfs_buf_mem.c     |  3 ++-
 include/linux/shmem_fs.h |  2 +-
 mm/khugepaged.c          |  3 ++-
 mm/shmem.c               | 28 ++++++++++++++++------------
 mm/userfaultfd.c         |  2 +-
 6 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index d848222f802b..d814d9d786d3 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -127,7 +127,7 @@ xfile_load(
 		unsigned int	offset;
 
 		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
-				SGP_READ) < 0)
+				SGP_READ, PAGE_SIZE) < 0)
 			break;
 		if (!folio) {
 			/*
@@ -197,7 +197,7 @@ xfile_store(
 		unsigned int	offset;
 
 		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
-				SGP_CACHE) < 0)
+				SGP_CACHE, PAGE_SIZE) < 0)
 			break;
 		if (filemap_check_wb_err(inode->i_mapping, 0)) {
 			folio_unlock(folio);
@@ -268,7 +268,7 @@ xfile_get_folio(
 
 	pflags = memalloc_nofs_save();
 	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
-			(flags & XFILE_ALLOC) ? SGP_CACHE : SGP_READ);
+			(flags & XFILE_ALLOC) ? SGP_CACHE : SGP_READ, PAGE_SIZE);
 	memalloc_nofs_restore(pflags);
 	if (error)
 		return ERR_PTR(error);
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index 9bb2d24de709..784c81d35a1f 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -149,7 +149,8 @@ xmbuf_map_page(
 		return -ENOMEM;
 	}
 
-	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio, SGP_CACHE);
+	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio, SGP_CACHE,
+				PAGE_SIZE);
 	if (error)
 		return error;
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1564d7d3ca61..34beaca2f853 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -144,7 +144,7 @@ enum sgp_type {
 };
 
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
-		enum sgp_type sgp);
+		enum sgp_type sgp, size_t len);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a5ec03ef8722..3c9dbebbdf38 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1867,7 +1867,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index,
-						&folio, SGP_NOALLOC)) {
+						&folio, SGP_NOALLOC,
+						PAGE_SIZE)) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index db8f74cac1a2..92ed09527682 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -980,7 +980,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	 * (although in some cases this is just a waste of time).
 	 */
 	folio = NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
+	shmem_get_folio(inode, index, &folio, SGP_READ, PAGE_SIZE);
 	return folio;
 }
 
@@ -2094,7 +2094,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  */
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
-		struct vm_fault *vmf, vm_fault_t *fault_type)
+		struct vm_fault *vmf, vm_fault_t *fault_type, size_t len)
 {
 	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	struct mm_struct *fault_mm;
@@ -2297,10 +2297,10 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * Return: 0 if successful, else a negative error code.
  */
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
-		enum sgp_type sgp)
+		enum sgp_type sgp, size_t len)
 {
 	return shmem_get_folio_gfp(inode, index, foliop, sgp,
-			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
+			mapping_gfp_mask(inode->i_mapping), NULL, NULL, len);
 }
 EXPORT_SYMBOL_GPL(shmem_get_folio);
 
@@ -2395,7 +2395,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 
 	WARN_ON_ONCE(vmf->page != NULL);
 	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
-				  gfp, vmf, &ret);
+				  gfp, vmf, &ret, PAGE_SIZE);
 	if (err)
 		return vmf_error(err);
 	if (folio) {
@@ -2895,6 +2895,9 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio;
 	int ret = 0;
 
+	if (!mapping_large_folio_support(mapping))
+		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
 				   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))) {
@@ -2904,7 +2907,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	ret = shmem_get_folio(inode, index, &folio, SGP_WRITE);
+	ret = shmem_get_folio(inode, index, &folio, SGP_WRITE, len);
 	if (ret)
 		return ret;
 
@@ -2975,7 +2978,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				break;
 		}
 
-		error = shmem_get_folio(inode, index, &folio, SGP_READ);
+		error = shmem_get_folio(inode, index, &folio, SGP_READ, PAGE_SIZE);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -3152,7 +3155,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			break;
 
 		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
-					SGP_READ);
+					SGP_READ, PAGE_SIZE);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -3339,7 +3342,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			error = -ENOMEM;
 		else
 			error = shmem_get_folio(inode, index, &folio,
-						SGP_FALLOC);
+						SGP_FALLOC,
+						(end - index) << PAGE_SHIFT);
 		if (error) {
 			info->fallocend = undo_fallocend;
 			/* Remove the !uptodate folios we added */
@@ -3690,7 +3694,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	} else {
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &shmem_aops;
-		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
+		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE, PAGE_SIZE);
 		if (error)
 			goto out_remove_offset;
 		inode->i_op = &shmem_symlink_inode_operations;
@@ -3736,7 +3740,7 @@ static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error = shmem_get_folio(inode, 0, &folio, SGP_READ);
+		error = shmem_get_folio(inode, 0, &folio, SGP_READ, PAGE_SIZE);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
@@ -5209,7 +5213,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 	int error;
 
 	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
-				    gfp, NULL, NULL);
+				    gfp, NULL, NULL, PAGE_SIZE);
 	if (error)
 		return ERR_PTR(error);
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..c275e34c435a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -391,7 +391,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
+	ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC, PAGE_SIZE);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
 		ret = -EFAULT;
-- 
2.39.3


