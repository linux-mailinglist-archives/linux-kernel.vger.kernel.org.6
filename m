Return-Path: <linux-kernel+bounces-310860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F234796821D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C46E1F23189
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C8185B78;
	Mon,  2 Sep 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tSZYq9Pm"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB3161310
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266176; cv=none; b=KSkn9vyBArwPe1AgBJNAYhAIV7daCNNnY8sDweuL0VZe7qD/rrk6Yt/fFpKz57cjMV9216B9uJ10T15VQgUmYuJJ5UWLVxFtB1o4W1hQu9YhaxSTXJHoQWVkWNf2NGEchMeXVk05epmNPZ01+If9RA1W/yUy4lbLs41mFl+LU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266176; c=relaxed/simple;
	bh=onUFYEuHZVIJfx464Mcn7n8IFtixASHc9Jb6IJYCcVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHJUKhJH7LZeL4EDWyYbNtqp/xwluKyqK3Dq1mwuC1h/qDIG1JpHRn730uAIbI4sE1kh2ATS723FABsyDGt0fTnwKxbOk6v9XBvxZX/zdLD6YCLKwpmIUYGO74hkT2PDc8ay0xuJjy59YZb4KHsGotlRvj84g1oI6wSyMIQx/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tSZYq9Pm; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725266169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gqogtgI3FS2H6sxfDkFSml13NwueUA6Yx4J8h4K0pCc=;
	b=tSZYq9PmmE+wA165aeCMMQilBy8W35c+DFwrmFrsUjVdpOQrIuuLhtPX3SWUbNOp1s64rC9gOC54gFVrN+fh1yVdSnKt1WiqO0Z3rHlag4fCM9oLQm480YzgqNnGJIBGL1tF4ZcqD0jA7mOlS8DWmYonYQmSGXwSPrWpfi0Fids=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WE63r6B_1725266168)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 16:36:09 +0800
Message-ID: <fdd5a942-6382-49c7-90d9-5b2b1fea9671@linux.alibaba.com>
Date: Mon, 2 Sep 2024 16:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,tmpfs: consider end of file write in shmem_is_huge
To: Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>
Cc: kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20240829235415.57374fc3@imladris.surriel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240829235415.57374fc3@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/30 11:54, Rik van Riel wrote:
> Take the end of a file write into consideration when deciding whether
> or not to use huge folios for tmpfs files when the tmpfs filesystem is
> mounted with huge=within_size
> 
> This allows large writes that append to the end of a file to automatically
> use large folios.

Make sense to me.

> 
> Doing 4MB squential writes without fallocate to a 16GB tmpfs file:
> - 4kB pages:       1560 MB/s
> - huge=within_size 4720 MB/s
> - huge=always:     4720 MB/s
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>   fs/xfs/scrub/xfile.c     |  6 +++---
>   fs/xfs/xfs_buf_mem.c     |  2 +-
>   include/linux/shmem_fs.h | 12 ++++++-----
>   mm/huge_memory.c         |  2 +-
>   mm/khugepaged.c          |  2 +-
>   mm/shmem.c               | 44 +++++++++++++++++++++-------------------
>   mm/userfaultfd.c         |  2 +-
>   7 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
> index d848222f802b..e6e1c1fd23cb 100644

[snip]

> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1d06b1e5408a..846c1ea91f50 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -111,13 +111,15 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>   int shmem_unuse(unsigned int type);
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> -			  struct mm_struct *mm, unsigned long vm_flags);
> +extern bool shmem_is_huge(struct inode *inode, pgoff_t index, loff_t write_end,
> +	       		  bool shmem_huge_force, struct mm_struct *mm,
> +			  unsigned long vm_flags);
>   unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   				struct vm_area_struct *vma, pgoff_t index,
>   				bool global_huge);
>   #else
> -static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> +static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index,
> +					  loff_t write_end, bool shmem_huge_force,
>   					  struct mm_struct *mm, unsigned long vm_flags)
>   {
>   	return false;
> @@ -150,8 +152,8 @@ enum sgp_type {
>   	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
>   };
>   
> -int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
> -		enum sgp_type sgp);
> +int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
> +		    struct folio **foliop, enum sgp_type sgp);
>   struct folio *shmem_read_folio_gfp(struct address_space *mapping,
>   		pgoff_t index, gfp_t gfp);
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 67c86a5d64a6..8c09071e78cd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -160,7 +160,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>   	 * own flags.
>   	 */
>   	if (!in_pf && shmem_file(vma->vm_file)) {
> -		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> +		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff, 0,
>   							!enforce_sysfs, vma->vm_mm, vm_flags);
>   
>   		if (!vma_is_anon_shmem(vma))
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdd1d8655a76..0ebabff10f97 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1866,7 +1866,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   			if (xa_is_value(folio) || !folio_test_uptodate(folio)) {
>   				xas_unlock_irq(&xas);
>   				/* swap in or instantiate fallocated page */
> -				if (shmem_get_folio(mapping->host, index,
> +				if (shmem_get_folio(mapping->host, index, 0,
>   						&folio, SGP_NOALLOC)) {
>   					result = SCAN_FAIL;
>   					goto xa_unlocked;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5a77acf6ac6a..964c24fc480f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -548,7 +548,7 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>   
>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>   
> -static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
> +static bool __shmem_is_huge(struct inode *inode, pgoff_t index, loff_t write_end,
>   			    bool shmem_huge_force, struct mm_struct *mm,
>   			    unsigned long vm_flags)
>   {
> @@ -568,7 +568,8 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
>   		return true;
>   	case SHMEM_HUGE_WITHIN_SIZE:
>   		index = round_up(index + 1, HPAGE_PMD_NR);
> -		i_size = round_up(i_size_read(inode), PAGE_SIZE);
> +		i_size = max(write_end, i_size_read(inode));
> +		i_size = round_up(i_size, PAGE_SIZE);
>   		if (i_size >> PAGE_SHIFT >= index)
>   			return true;
>   		fallthrough;

The shmem_is_huge() is no longer exported and has been renamed to 
shmem_huge_global_enabled() by the series[1]. So you need rebase on the 
latest mm-unstable branch.

[1] 
https://lore.kernel.org/all/cover.1721626645.git.baolin.wang@linux.alibaba.com/T/#md2580130f990af0b1428010bfb4cc789bb865136 


