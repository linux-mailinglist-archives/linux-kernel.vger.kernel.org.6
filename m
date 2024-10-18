Return-Path: <linux-kernel+bounces-370794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57449A322B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82604283F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E306F307;
	Fri, 18 Oct 2024 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xlPLJJAJ"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D820E33E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215861; cv=none; b=iH2o5rzQh9ozFYRjZaA6XxndZQxJbum3m9f9Q+5FO7Cjjbeyh4yj8EV8NgYsYDo3Wqaka1mWuUqZ7AQLSgVcButoN5yPb/VeWb54sQR9ayJdz0f1qUmUJO0TTQC93O7VpmaYkm3oFtHjt33q1xdua8j1AlERPmHwkqU8NyHb2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215861; c=relaxed/simple;
	bh=tNqHa2Ma/uXASvXtEVdPdIzricDBuck20Vd7WcVj2ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thMWoJK4+Y6NZuMa2DSIkIXQNg/68/XXZv8F+sLKVA6+5Aif3Pekd19s21ee9DqkePwl5UY+Zey8n/r7fvscvMHKbGEwQSSqQt3L1v5CGXKvLJus7IRf6d91K0WCL/t4cdufwwxRlgovvKpqD1gV4qZ/0zrjI/l7etOMFh/JrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xlPLJJAJ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729215849; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LrQw1Xi9Sb0d6T0yY4LpVBM0HbA4kS8pDDl44szB65E=;
	b=xlPLJJAJlwb6W8OzyHSXGcvNTpQ+vK9yBrVo7+i+3m+V92H5YriUy9nGJJ88NIIdIpC7ahHugkX3LHUtau8XNER+N635sVJfL9DPfsLnTUSkAkeTlFZvXHThFgdDASaJIzC1Vb/6DiPzeZs2TNaufKWgtl3DK8zZTvq+H4OZEbw=
Received: from 30.27.73.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHMCYpl_1729215846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 09:44:08 +0800
Message-ID: <588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com>
Date: Fri, 18 Oct 2024 09:44:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: free pcluster right after decompression if
 possible
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240930140424.4049195-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240930140424.4049195-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunhai,

Thanks for the work!  Please rebase this work on
my "sunset z_erofs_workgroup` series.

On 2024/9/30 22:04, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> pages, its corresponding struct z_erofs_pcluster will be freed. This

Subject: free pclusters if no cached folio attached

cached folios, its corresponding `struct z_erofs_pcluster`...

> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for struct z_erofs_pcluster.
> 
> The tables below show approximately a 95% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for struct
					for `struct z_erofs_pcluster`

> z_erofs_pcluster after applying this patch. The results were obtained by
> performing a test to copy a 2.1 GB partition on ARM64 Android devices
> running the 5.15 kernel with an 8-core CPU and 8GB of memory.

I guess you could try to use more recent kernels for testing instead?

> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   3152    |   160    | -94.92% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 44503200  | 2293760  | -94.84% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/internal.h |  3 ++-
>   fs/erofs/zdata.c    | 14 ++++++++---
>   fs/erofs/zutil.c    | 58 +++++++++++++++++++++++++++++----------------
>   3 files changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..17b04bfd743f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -456,7 +456,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>   void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
> -void erofs_workgroup_put(struct erofs_workgroup *grp);
> +void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
> +		bool can_released);
>   struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>   					     pgoff_t index);
>   struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8936790618c6..656fd65aec33 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -888,7 +888,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>   	 * any longer if the pcluster isn't hosted by ourselves.
>   	 */
>   	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
> -		erofs_workgroup_put(&pcl->obj);
> +		erofs_workgroup_put(EROFS_I_SB(fe->inode), &pcl->obj, false);
>   
>   	fe->pcl = NULL;
>   }
> @@ -1046,6 +1046,9 @@ struct z_erofs_decompress_backend {
>   	struct list_head decompressed_secondary_bvecs;
>   	struct page **pagepool;
>   	unsigned int onstack_used, nr_pages;
> +
> +	/* whether the pcluster can be released after its decompression */
> +	bool try_free;
>   };
>   
>   struct z_erofs_bvec_item {
> @@ -1244,12 +1247,15 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
>   		put_page(page);
>   	} else {
> +		be->try_free = true;
>   		/* managed folios are still left in compressed_bvecs[] */
>   		for (i = 0; i < pclusterpages; ++i) {
>   			page = be->compressed_pages[i];
>   			if (!page ||
> -			    erofs_folio_is_managed(sbi, page_folio(page)))
> +			    erofs_folio_is_managed(sbi, page_folio(page))) {
> +				be->try_free = false;
>   				continue;
> +			}
>   			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
>   			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
>   		}
> @@ -1285,6 +1291,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   	if (be->decompressed_pages != be->onstack_pages)
>   		kvfree(be->decompressed_pages);
>   
> +	be->try_free = be->try_free && !pcl->partial;

I think no need to check `pcl->partial`.

>   	pcl->length = 0;
>   	pcl->partial = true;
>   	pcl->multibases = false;
> @@ -1320,7 +1327,8 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>   		if (z_erofs_is_inline_pcluster(be.pcl))
>   			z_erofs_free_pcluster(be.pcl);
>   		else
> -			erofs_workgroup_put(&be.pcl->obj);
> +			erofs_workgroup_put(EROFS_SB(io->sb), &be.pcl->obj,
> +					be.try_free);

We could just move

if (z_erofs_is_inline_pcluster(be.pcl))
	z_erofs_free_pcluster(be.pcl);
else
	z_erofs_put_pcluster(be.pcl);

into the end of z_erofs_decompress_pcluster() and
get rid of `be->try_free`;



>   	}
>   	return err;
>   }
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 37afe2024840..cf59ba6a2322 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -285,26 +285,11 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>   	erofs_workgroup_free_rcu(grp);
>   }
>   
> -void erofs_workgroup_put(struct erofs_workgroup *grp)
> -{
> -	if (lockref_put_or_lock(&grp->lockref))
> -		return;
> -
> -	DBG_BUGON(__lockref_is_dead(&grp->lockref));
> -	if (grp->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--grp->lockref.count;
> -	spin_unlock(&grp->lockref.lock);
> -}
> -
> -static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +static bool erofs_prepare_to_release_workgroup(struct erofs_sb_info *sbi,
>   					   struct erofs_workgroup *grp)
>   {
> -	int free = false;
> -
> -	spin_lock(&grp->lockref.lock);
>   	if (grp->lockref.count)
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * Note that all cached pages should be detached before deleted from
> @@ -312,7 +297,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>   	 * the orphan old workgroup when the new one is available in the tree.
>   	 */
>   	if (erofs_try_to_free_all_cached_folios(sbi, grp))
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * It's impossible to fail after the workgroup is freezed,
> @@ -322,14 +307,47 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>   	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
>   
>   	lockref_mark_dead(&grp->lockref);
> -	free = true;
> -out:
> +	return true;
> +}
> +
> +static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +					   struct erofs_workgroup *grp)
> +{
> +	bool free = false;
> +
> +	/* Using trylock to avoid deadlock with erofs_workgroup_put() */
> +	if (!spin_trylock(&grp->lockref.lock))
> +		return free;
> +	free = erofs_prepare_to_release_workgroup(sbi, grp);
>   	spin_unlock(&grp->lockref.lock);
>   	if (free)
>   		__erofs_workgroup_free(grp);
>   	return free;
>   }
>   
> +void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
> +		bool try_free)
> +{
> +	bool free = false;
> +
> +	if (lockref_put_or_lock(&grp->lockref))
> +		return;
> +
> +	DBG_BUGON(__lockref_is_dead(&grp->lockref));
> +	if (--grp->lockref.count == 0) {
> +		atomic_long_inc(&erofs_global_shrink_cnt);
> +
> +		if (try_free) {
> +			xa_lock(&sbi->managed_pslots);
> +			free = erofs_prepare_to_release_workgroup(sbi, grp);
> +			xa_unlock(&sbi->managed_pslots);
> +		}
> +	}
> +	spin_unlock(&grp->lockref.lock);
> +	if (free)
> +		__erofs_workgroup_free(grp);

need to wait for a RCU grace period.

Thanks,
Gao Xiang

