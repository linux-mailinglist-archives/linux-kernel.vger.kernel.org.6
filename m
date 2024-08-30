Return-Path: <linux-kernel+bounces-307997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874F965603
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B031F23C93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C44145FE5;
	Fri, 30 Aug 2024 03:54:54 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375513049E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990093; cv=none; b=JI3V11lTlcyXNUWvjWoxzFl6JIxnYymXT8kV/vzyR1ridrqB9/w8GqlyuZx7QDbDwuit6c8CyfOQmcjlz1xEY7KURNFpuUFWd7+XWjSFO36RbrYrQ6sYxslPfm1eFQedknnm0R979H3mnvbtTVsexkKU8YT+NyRrt3pjTavuHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990093; c=relaxed/simple;
	bh=5GGl4grnqsq6jjldCQF4uzRw0WDj7ZEwcMheymfexec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IEDIVcAeKW1syV2ZsJHwI4A9wOfUp448I5eYInNPwffCIrQ99GXtbLQhpHdbm3oO10uGtPnQgWKc6yK386JxAN7benlLQEF842/C6eEPQpx0upf55W0DjdqYYFxU3dPAgAIdauj2yQ8kOdW8dbyrqv6AirowbuexD2ijHICMkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sjsiF-000000004XN-2JIY;
	Thu, 29 Aug 2024 23:54:15 -0400
Date: Thu, 29 Aug 2024 23:54:15 -0400
From: Rik van Riel <riel@surriel.com>
To: Hugh Dickins <hughd@google.com>
Cc: kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dave Chinner
 <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Vlastimil
 Babka <vbabka@suse.cz>
Subject: [PATCH] mm,tmpfs: consider end of file write in shmem_is_huge
Message-ID: <20240829235415.57374fc3@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Take the end of a file write into consideration when deciding whether
or not to use huge folios for tmpfs files when the tmpfs filesystem is
mounted with huge=within_size

This allows large writes that append to the end of a file to automatically
use large folios.

Doing 4MB squential writes without fallocate to a 16GB tmpfs file:
- 4kB pages:       1560 MB/s
- huge=within_size 4720 MB/s
- huge=always:     4720 MB/s

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 fs/xfs/scrub/xfile.c     |  6 +++---
 fs/xfs/xfs_buf_mem.c     |  2 +-
 include/linux/shmem_fs.h | 12 ++++++-----
 mm/huge_memory.c         |  2 +-
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 44 +++++++++++++++++++++-------------------
 mm/userfaultfd.c         |  2 +-
 7 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index d848222f802b..e6e1c1fd23cb 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -126,7 +126,7 @@ xfile_load(
 		unsigned int	len;
 		unsigned int	offset;
 
-		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
+		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
 				SGP_READ) < 0)
 			break;
 		if (!folio) {
@@ -196,7 +196,7 @@ xfile_store(
 		unsigned int	len;
 		unsigned int	offset;
 
-		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
+		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
 				SGP_CACHE) < 0)
 			break;
 		if (filemap_check_wb_err(inode->i_mapping, 0)) {
@@ -267,7 +267,7 @@ xfile_get_folio(
 		i_size_write(inode, pos + len);
 
 	pflags = memalloc_nofs_save();
-	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
+	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
 			(flags & XFILE_ALLOC) ? SGP_CACHE : SGP_READ);
 	memalloc_nofs_restore(pflags);
 	if (error)
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index 9bb2d24de709..07bebbfb16ee 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -149,7 +149,7 @@ xmbuf_map_page(
 		return -ENOMEM;
 	}
 
-	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio, SGP_CACHE);
+	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio, SGP_CACHE);
 	if (error)
 		return error;
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1d06b1e5408a..846c1ea91f50 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -111,13 +111,15 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-			  struct mm_struct *mm, unsigned long vm_flags);
+extern bool shmem_is_huge(struct inode *inode, pgoff_t index, loff_t write_end,
+	       		  bool shmem_huge_force, struct mm_struct *mm,
+			  unsigned long vm_flags);
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				bool global_huge);
 #else
-static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index,
+					  loff_t write_end, bool shmem_huge_force,
 					  struct mm_struct *mm, unsigned long vm_flags)
 {
 	return false;
@@ -150,8 +152,8 @@ enum sgp_type {
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
 };
 
-int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
-		enum sgp_type sgp);
+int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
+		    struct folio **foliop, enum sgp_type sgp);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67c86a5d64a6..8c09071e78cd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -160,7 +160,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * own flags.
 	 */
 	if (!in_pf && shmem_file(vma->vm_file)) {
-		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
+		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff, 0,
 							!enforce_sysfs, vma->vm_mm, vm_flags);
 
 		if (!vma_is_anon_shmem(vma))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76..0ebabff10f97 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1866,7 +1866,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			if (xa_is_value(folio) || !folio_test_uptodate(folio)) {
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
-				if (shmem_get_folio(mapping->host, index,
+				if (shmem_get_folio(mapping->host, index, 0,
 						&folio, SGP_NOALLOC)) {
 					result = SCAN_FAIL;
 					goto xa_unlocked;
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..964c24fc480f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -548,7 +548,7 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
+static bool __shmem_is_huge(struct inode *inode, pgoff_t index, loff_t write_end,
 			    bool shmem_huge_force, struct mm_struct *mm,
 			    unsigned long vm_flags)
 {
@@ -568,7 +568,8 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
 		return true;
 	case SHMEM_HUGE_WITHIN_SIZE:
 		index = round_up(index + 1, HPAGE_PMD_NR);
-		i_size = round_up(i_size_read(inode), PAGE_SIZE);
+		i_size = max(write_end, i_size_read(inode));
+		i_size = round_up(i_size, PAGE_SIZE);
 		if (i_size >> PAGE_SHIFT >= index)
 			return true;
 		fallthrough;
@@ -581,14 +582,14 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
 	}
 }
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index,
+bool shmem_is_huge(struct inode *inode, pgoff_t index, loff_t write_end,
 		   bool shmem_huge_force, struct mm_struct *mm,
 		   unsigned long vm_flags)
 {
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
 		return false;
 
-	return __shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags);
+	return __shmem_is_huge(inode, index, write_end, shmem_huge_force, mm, vm_flags);
 }
 
 #if defined(CONFIG_SYSFS)
@@ -971,7 +972,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
 	 * (although in some cases this is just a waste of time).
 	 */
 	folio = NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
+	shmem_get_folio(inode, index, 0, &folio, SGP_READ);
 	return folio;
 }
 
@@ -1156,7 +1157,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(idmap, request_mask, inode, stat);
 
-	if (shmem_is_huge(inode, 0, false, NULL, 0))
+	if (shmem_is_huge(inode, 0, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -2078,8 +2079,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  * vmf and fault_type are only supplied by shmem_fault: otherwise they are NULL.
  */
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
-		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
-		struct vm_fault *vmf, vm_fault_t *fault_type)
+	       	loff_t write_end, struct folio **foliop, enum sgp_type sgp,
+		gfp_t gfp, struct vm_fault *vmf, vm_fault_t *fault_type)
 {
 	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	struct mm_struct *fault_mm;
@@ -2158,7 +2159,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	huge = shmem_is_huge(inode, index, false, fault_mm,
+	huge = shmem_is_huge(inode, index, write_end, false, fault_mm,
 			     vma ? vma->vm_flags : 0);
 	/* Find hugepage orders that are allowed for anonymous shmem. */
 	if (vma && vma_is_anon_shmem(vma))
@@ -2268,6 +2269,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * shmem_get_folio - find, and lock a shmem folio.
  * @inode:	inode to search
  * @index:	the page index.
+ * @write_end:	end of a write, could extend inode size.
  * @foliop:	pointer to the folio if found
  * @sgp:	SGP_* flags to control behavior
  *
@@ -2287,10 +2289,10 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
  * Context: May sleep.
  * Return: 0 if successful, else a negative error code.
  */
-int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
-		enum sgp_type sgp)
+int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
+		struct folio **foliop, enum sgp_type sgp)
 {
-	return shmem_get_folio_gfp(inode, index, foliop, sgp,
+	return shmem_get_folio_gfp(inode, index, write_end, foliop, sgp,
 			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(shmem_get_folio);
@@ -2385,7 +2387,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	}
 
 	WARN_ON_ONCE(vmf->page != NULL);
-	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
+	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, SGP_CACHE,
 				  gfp, vmf, &ret);
 	if (err)
 		return vmf_error(err);
@@ -2895,7 +2897,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
-	ret = shmem_get_folio(inode, index, &folio, SGP_WRITE);
+	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
 
@@ -2966,7 +2968,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				break;
 		}
 
-		error = shmem_get_folio(inode, index, &folio, SGP_READ);
+		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -3142,7 +3144,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (*ppos >= i_size_read(inode))
 			break;
 
-		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, 0, &folio,
 					SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
@@ -3332,8 +3334,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
 			error = -ENOMEM;
 		else
-			error = shmem_get_folio(inode, index, &folio,
-						SGP_FALLOC);
+			error = shmem_get_folio(inode, index, offset + len,
+						&folio, SGP_FALLOC);
 		if (error) {
 			info->fallocend = undo_fallocend;
 			/* Remove the !uptodate folios we added */
@@ -3684,7 +3686,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	} else {
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &shmem_aops;
-		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
+		error = shmem_get_folio(inode, 0, 0, &folio, SGP_WRITE);
 		if (error)
 			goto out_remove_offset;
 		inode->i_op = &shmem_symlink_inode_operations;
@@ -3730,7 +3732,7 @@ static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error = shmem_get_folio(inode, 0, &folio, SGP_READ);
+		error = shmem_get_folio(inode, 0, 0, &folio, SGP_READ);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
@@ -5198,7 +5200,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
+	error = shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
 				    gfp, NULL, NULL);
 	if (error)
 		return ERR_PTR(error);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..cb8c76f8f118 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -391,7 +391,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
+	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
 		ret = -EFAULT;
-- 
2.45.2


