Return-Path: <linux-kernel+bounces-314438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF896B33A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F096B284CF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263F146D7F;
	Wed,  4 Sep 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DCCipH7+"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6B146A79
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436045; cv=none; b=HuhFMuTPoutxC/NydSUDPFAsQy+8GwUswIzDWfH+JDpepiC+ljUtIfel45KR7R/ZV5W1Dy6eQ3A2UbGr3uk0TLTg/UPl/evoxpYX5hBe65ijSfG5S90yZa3005i3EOUwjbO9wA4E/0jMQlSqxc9HzTHpCX9DroHmDd9jKNrN304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436045; c=relaxed/simple;
	bh=/Gzysj5wjdUVuVoG/WhhztGPNqvR7R4P5IvrRDiF1VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT0UiuLjp36+cRyknnyAdcCy22oZ5zN1yvCRR/iyt9MauFIi8gfA4AmL7AWSbX0gQ7zovYyo5PpOr0YFWQ2rvTZJbDDFJRJw1m5WJ1B5mLtwz9lPJrN+hpH4lvLhKbrOK9VhD06KyprbYRZRFUG9IgrzI818ee+OFfwNHfYbmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DCCipH7+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725436036; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CE2dOaVvbIhG/2Kuoqz3wQeM4Nr65F0X99A8Zw3p05w=;
	b=DCCipH7++w3wwvIrTrWdQQ1MXuRzaAbSJ+GvtSmNhNcfHdAryR1ypLZFcWQ8wZXXpa8Qrb/u8BZJy3MUdMGJAmQJUZ+xl4vDzbsoWcK4UeV+14EVyDmbHv+1L+mh5tL0wgOHNbwLwuUUVZC1MS0QClMPaOW65M5qfT6cARV4Pss=
Received: from 30.74.144.210(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEGnEsL_1725436034)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 15:47:15 +0800
Message-ID: <d52dc882-efdf-42d7-a477-46580650cf80@linux.alibaba.com>
Date: Wed, 4 Sep 2024 15:47:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm,tmpfs: consider end of file write in shmem_is_huge
To: Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240903111928.7171e60c@imladris.surriel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240903111928.7171e60c@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/3 23:19, Rik van Riel wrote:
> Take the end of a file write into consideration when deciding whether
> or not to use huge pages for tmpfs files when the tmpfs filesystem is
> mounted with huge=within_size
> 
> This allows large writes that append to the end of a file to automatically
> use large pages.
> 
> Doing 4MB squential writes without fallocate to a 16GB tmpfs file
> with fio. The numbers without THP or with huge=always stay the same,
> but the performance with huge=within_size now matches that of huge=always.
> 
> huge		before		after
> 4kB pages	1560 MB/s	1560 MB/s
> within_size	1560 MB/s	4720 MB/s
> always:		4720 MB/s	4720 MB/s
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> v2: rebased on mm-unstable, fixed up changelog as suggested by Andrew Morton
> 
>   fs/xfs/scrub/xfile.c     |  6 ++--
>   fs/xfs/xfs_buf_mem.c     |  2 +-
>   include/linux/shmem_fs.h |  8 +++---
>   mm/huge_memory.c         |  2 +-
>   mm/khugepaged.c          |  2 +-
>   mm/shmem.c               | 59 +++++++++++++++++++++-------------------
>   mm/userfaultfd.c         |  2 +-
>   7 files changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index 9b5d98fe1f8a..c753c79df203 100644
> --- a/fs/xfs/scrub/xfile.c
> +++ b/fs/xfs/scrub/xfile.c
> @@ -126,7 +126,7 @@ xfile_load(
>   		unsigned int	len;
>   		unsigned int	offset;
>   
> -		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> +		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
>   				SGP_READ) < 0)
>   			break;
>   		if (!folio) {
> @@ -196,7 +196,7 @@ xfile_store(
>   		unsigned int	len;
>   		unsigned int	offset;
>   
> -		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> +		if (shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
>   				SGP_CACHE) < 0)
>   			break;
>   		if (filemap_check_wb_err(inode->i_mapping, 0)) {
> @@ -267,7 +267,7 @@ xfile_get_folio(
>   		i_size_write(inode, pos + len);
>   
>   	pflags = memalloc_nofs_save();
> -	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio,
> +	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio,
>   			(flags & XFILE_ALLOC) ? SGP_CACHE : SGP_READ);
>   	memalloc_nofs_restore(pflags);
>   	if (error)
> diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> index 9bb2d24de709..07bebbfb16ee 100644
> --- a/fs/xfs/xfs_buf_mem.c
> +++ b/fs/xfs/xfs_buf_mem.c
> @@ -149,7 +149,7 @@ xmbuf_map_page(
>   		return -ENOMEM;
>   	}
>   
> -	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, &folio, SGP_CACHE);
> +	error = shmem_get_folio(inode, pos >> PAGE_SHIFT, 0, &folio, SGP_CACHE);
>   	if (error)
>   		return error;
>   
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1564d7d3ca61..515a9a6a3c6f 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -113,11 +113,11 @@ int shmem_unuse(unsigned int type);
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   				struct vm_area_struct *vma, pgoff_t index,
> -				bool shmem_huge_force);
> +				loff_t write_end, bool shmem_huge_force);
>   #else
>   static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   				struct vm_area_struct *vma, pgoff_t index,
> -				bool shmem_huge_force)
> +				loff_t write_end, bool shmem_huge_force)
>   {
>   	return 0;
>   }
> @@ -143,8 +143,8 @@ enum sgp_type {
>   	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
>   };
>   
> -int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
> -		enum sgp_type sgp);
> +int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
> +		struct folio **foliop, enum sgp_type sgp);
>   struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>   		pgoff_t index, gfp_t gfp);
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0993dfe9ae94..382938e46f96 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -164,7 +164,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	 */
>   	if (!in_pf && shmem_file(vma->vm_file))
>   		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
> -						   vma, vma->vm_pgoff,
> +						   vma, vma->vm_pgoff, 0,
>   						   !enforce_sysfs);
>   
>   	if (!vma_is_anonymous(vma)) {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 32100041aef3..f9c39898eaff 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1870,7 +1870,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   			if (xa_is_value(folio) || !folio_test_uptodate(folio)) {
>   				xas_unlock_irq(&xas);
>   				/* swap in or instantiate fallocated page */
> -				if (shmem_get_folio(mapping->host, index,
> +				if (shmem_get_folio(mapping->host, index, 0,
>   						&folio, SGP_NOALLOC)) {
>   					result = SCAN_FAIL;
>   					goto xa_unlocked;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 553b99cb265e..375ae3f170a3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -549,7 +549,8 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>   
>   static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> -					bool shmem_huge_force, struct vm_area_struct *vma,
> +					loff_t write_end, bool shmem_huge_force,
> +					struct vm_area_struct *vma,
>   					unsigned long vm_flags)
>   {
>   	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
> @@ -569,7 +570,8 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>   		return true;
>   	case SHMEM_HUGE_WITHIN_SIZE:
>   		index = round_up(index + 1, HPAGE_PMD_NR);
> -		i_size = round_up(i_size_read(inode), PAGE_SIZE);
> +		i_size = max(write_end, i_size_read(inode));
> +		i_size = round_up(i_size, PAGE_SIZE);
>   		if (i_size >> PAGE_SHIFT >= index)
>   			return true;
>   		fallthrough;
> @@ -583,14 +585,14 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>   }
>   
>   static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> -		   bool shmem_huge_force, struct vm_area_struct *vma,
> -		   unsigned long vm_flags)
> +		   loff_t write_end, bool shmem_huge_force,
> +		   struct vm_area_struct *vma, unsigned long vm_flags)
>   {
>   	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
>   		return false;
>   
> -	return __shmem_huge_global_enabled(inode, index, shmem_huge_force,
> -					   vma, vm_flags);
> +	return __shmem_huge_global_enabled(inode, index, write_end,
> +					   shmem_huge_force, vma, vm_flags);
>   }
>   
>   #if defined(CONFIG_SYSFS)
> @@ -770,8 +772,8 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>   }
>   
>   static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> -		bool shmem_huge_force, struct vm_area_struct *vma,
> -		unsigned long vm_flags)
> +		loff_t write_end, bool shmem_huge_force,
> +		struct vm_area_struct *vma, unsigned long vm_flags)
>   {
>   	return false;
>   }
> @@ -978,7 +980,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>   	 * (although in some cases this is just a waste of time).
>   	 */
>   	folio = NULL;
> -	shmem_get_folio(inode, index, &folio, SGP_READ);
> +	shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>   	return folio;
>   }
>   
> @@ -1166,7 +1168,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>   			STATX_ATTR_NODUMP);
>   	generic_fillattr(idmap, request_mask, inode, stat);
>   
> -	if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
> +	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>   		stat->blksize = HPAGE_PMD_SIZE;
>   
>   	if (request_mask & STATX_BTIME) {
> @@ -1653,7 +1655,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   				struct vm_area_struct *vma, pgoff_t index,
> -				bool shmem_huge_force)
> +				loff_t write_end, bool shmem_huge_force)
>   {
>   	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>   	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
> @@ -1670,8 +1672,8 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>   		return 0;
>   
> -	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
> -						vma, vm_flags);
> +	global_huge = shmem_huge_global_enabled(inode, index, write_end,
> +		       				shmem_huge_force, vma, vm_flags);
>   	if (!vma || !vma_is_anon_shmem(vma)) {
>   		/*
>   		 * For tmpfs, we now only support PMD sized THP if huge page
> @@ -2231,8 +2233,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>    * vmf and fault_type are only supplied by shmem_fault: otherwise they are NULL.
>    */
>   static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
> -		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
> -		struct vm_fault *vmf, vm_fault_t *fault_type)
> +		loff_t write_end, struct folio **foliop, enum sgp_type sgp,
> +		gfp_t gfp, struct vm_fault *vmf, vm_fault_t *fault_type)
>   {
>   	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>   	struct mm_struct *fault_mm;
> @@ -2312,7 +2314,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   	}
>   
>   	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
> -	orders = shmem_allowable_huge_orders(inode, vma, index, false);
> +	orders = shmem_allowable_huge_orders(inode, vma, index, write_end, false);
>   	if (orders > 0) {
>   		gfp_t huge_gfp;
>   
> @@ -2413,6 +2415,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>    * shmem_get_folio - find, and lock a shmem folio.
>    * @inode:	inode to search
>    * @index:	the page index.
> + * @write_end:	end of a write, could extend inode size
>    * @foliop:	pointer to the folio if found
>    * @sgp:	SGP_* flags to control behavior
>    *
> @@ -2432,10 +2435,10 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>    * Context: May sleep.
>    * Return: 0 if successful, else a negative error code.
>    */
> -int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
> -		enum sgp_type sgp)
> +int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
> +	       	struct folio **foliop, enum sgp_type sgp)
>   {
> -	return shmem_get_folio_gfp(inode, index, foliop, sgp,
> +	return shmem_get_folio_gfp(inode, index, write_end, foliop, sgp,
>   			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
>   }
>   EXPORT_SYMBOL_GPL(shmem_get_folio);
> @@ -2530,7 +2533,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>   	}
>   
>   	WARN_ON_ONCE(vmf->page != NULL);
> -	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
> +	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, SGP_CACHE,
>   				  gfp, vmf, &ret);
>   	if (err)
>   		return vmf_error(err);
> @@ -3040,7 +3043,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>   			return -EPERM;
>   	}
>   
> -	ret = shmem_get_folio(inode, index, &folio, SGP_WRITE);
> +	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
>   	if (ret)
>   		return ret;
>   
> @@ -3111,7 +3114,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   				break;
>   		}
>   
> -		error = shmem_get_folio(inode, index, &folio, SGP_READ);
> +		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>   		if (error) {
>   			if (error == -EINVAL)
>   				error = 0;
> @@ -3287,7 +3290,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>   		if (*ppos >= i_size_read(inode))
>   			break;
>   
> -		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
> +		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, 0, &folio,
>   					SGP_READ);
>   		if (error) {
>   			if (error == -EINVAL)
> @@ -3477,8 +3480,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>   		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
>   			error = -ENOMEM;
>   		else
> -			error = shmem_get_folio(inode, index, &folio,
> -						SGP_FALLOC);
> +			error = shmem_get_folio(inode, index, offset + len,
> +						&folio, SGP_FALLOC);
>   		if (error) {
>   			info->fallocend = undo_fallocend;
>   			/* Remove the !uptodate folios we added */
> @@ -3829,7 +3832,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	} else {
>   		inode_nohighmem(inode);
>   		inode->i_mapping->a_ops = &shmem_aops;
> -		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
> +		error = shmem_get_folio(inode, 0, 0, &folio, SGP_WRITE);
>   		if (error)
>   			goto out_remove_offset;
>   		inode->i_op = &shmem_symlink_inode_operations;
> @@ -3875,7 +3878,7 @@ static const char *shmem_get_link(struct dentry *dentry, struct inode *inode,
>   			return ERR_PTR(-ECHILD);
>   		}
>   	} else {
> -		error = shmem_get_folio(inode, 0, &folio, SGP_READ);
> +		error = shmem_get_folio(inode, 0, 0, &folio, SGP_READ);
>   		if (error)
>   			return ERR_PTR(error);
>   		if (!folio)
> @@ -5343,7 +5346,7 @@ struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>   	struct folio *folio;
>   	int error;
>   
> -	error = shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
> +	error = shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
>   				    gfp, NULL, NULL);
>   	if (error)
>   		return ERR_PTR(error);
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 6ef42d9cd482..ce13c4062647 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -391,7 +391,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>   	struct page *page;
>   	int ret;
>   
> -	ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
> +	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
>   	/* Our caller expects us to return -EFAULT if we failed to find folio */
>   	if (ret == -ENOENT)
>   		ret = -EFAULT;

