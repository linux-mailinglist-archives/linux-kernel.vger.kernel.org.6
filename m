Return-Path: <linux-kernel+bounces-399269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583689BFCDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AC028144A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054DB12FF70;
	Thu,  7 Nov 2024 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stla8fnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537646FBF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948997; cv=none; b=n44naOLM7Wm0ExBJFHyR/dOSDVg6yC4AdfH++Fv0dgnKOrShOGzKWWSNj+TXBaMifiQqdAXSwvP7NXFGUwgxwnA2358VhMBQrmsj4HU0bVaEgUk2ZCj4B4tmMk34ujIl3BPJUeeNbtUOyAzjfazbo+m2GJrAoPTiZQVr3eKi8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948997; c=relaxed/simple;
	bh=e0vKZNZg96eKyHN35H46M8rNrJ4JpDnQIfwWaNgFNSM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q+k8zaeATCalXC6skpJUrYKICBuo3w+YENhIFdJvJE3n17sX5uExw4CjtJyUkryPhZBxZQVY86t3s1pm8CAbC1nMSedlLIVSlXBjcYPE6X0m+22QzrazM/GIeBs8tXWCVDrp4MC0Z7S37LO8U3dD6Y5Tc9hdqAhAXKh96zR1uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stla8fnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92749C4CECC;
	Thu,  7 Nov 2024 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730948996;
	bh=e0vKZNZg96eKyHN35H46M8rNrJ4JpDnQIfwWaNgFNSM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Stla8fnfAqeR3fYoNbhbmpleU2Jt6utTnRNG1KVi5Y7rjPe/F6Ruop7BfLrVVXqXU
	 qQ6E64Y+Heq5byXrKEempi6EwLt2RuIOpcE+qTIhGqbWSvRQ/l39L3avYFtkyMqeo9
	 uaHY9UOSLAidaDlY9Wx+r/3Ba+rckNwx1Vf6T31gUr81fm7pioFi6eRYDIVFofaKy7
	 D4dki02gdCA6AWf3iuEi/AwoNiXwGMO67CnqUccYuyFE4GLUTunqifS3e0xdDwt9zD
	 3Faac0kjlGjLubLOKgCcVd7WPl45LYVqNRm4zOOe9TOAJs9BYyYEJQftskqGvxLP55
	 xx4b+C+QuehrQ==
Message-ID: <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
Date: Thu, 7 Nov 2024 11:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 11:53, Gao Xiang wrote:
> Just fold them into the only two callers since
> they are simple enough.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
> change since v1:
>   - !grp case should be handled properly mentioned by Chunhai;
> 
>   fs/erofs/internal.h |  5 +----
>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>   3 files changed, 30 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..8081ee43cd83 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   void erofs_workgroup_put(struct erofs_workgroup *grp);
> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
> -					     pgoff_t index);
> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> -					       struct erofs_workgroup *grp);
> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>   void erofs_shrinker_register(struct super_block *sb);
>   void erofs_shrinker_unregister(struct super_block *sb);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index a569ff9dfd04..bb1b73d99d07 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>   {
>   	struct erofs_map_blocks *map = &fe->map;
>   	struct super_block *sb = fe->inode->i_sb;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	bool ztailpacking = map->m_flags & EROFS_MAP_META;
>   	struct z_erofs_pcluster *pcl;
> -	struct erofs_workgroup *grp;
> +	struct erofs_workgroup *grp, *pre;
>   	int err;
>   
>   	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>   		pcl->obj.index = 0;	/* which indicates ztailpacking */
>   	} else {
>   		pcl->obj.index = erofs_blknr(sb, map->m_pa);
> -
> -		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
> -		if (IS_ERR(grp)) {
> -			err = PTR_ERR(grp);
> -			goto err_out;
> +		while (1) {
> +			xa_lock(&sbi->managed_pslots);
> +			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> +					   NULL, grp, GFP_KERNEL);
> +			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
> +				xa_unlock(&sbi->managed_pslots);
> +				break;
> +			}
> +			/* try to legitimize the current in-tree one */
> +			xa_unlock(&sbi->managed_pslots);
> +			cond_resched();
>   		}
> -
> -		if (grp != &pcl->obj) {

Do we need to keep this logic?

Thanks,

> -			fe->pcl = container_of(grp,
> +		if (xa_is_err(pre)) {
> +			err = xa_err(pre);
> +			goto err_out;
> +		} else if (pre) {
> +			fe->pcl = container_of(pre,
>   					struct z_erofs_pcluster, obj);
>   			err = -EEXIST;
>   			goto err_out;
> @@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>   
>   	if (!(map->m_flags & EROFS_MAP_META)) {
> -		grp = erofs_find_workgroup(sb, blknr);
> +		while (1) {
> +			rcu_read_lock();
> +			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
> +			if (!grp || erofs_workgroup_get(grp)) {
> +				DBG_BUGON(grp && blknr != grp->index);
> +				rcu_read_unlock();
> +				break;
> +			}
> +			rcu_read_unlock();
> +		}
>   	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 37afe2024840..218b0249a482 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -214,7 +214,7 @@ void erofs_release_pages(struct page **pagepool)
>   	}
>   }
>   
> -static bool erofs_workgroup_get(struct erofs_workgroup *grp)
> +bool erofs_workgroup_get(struct erofs_workgroup *grp)
>   {
>   	if (lockref_get_not_zero(&grp->lockref))
>   		return true;
> @@ -231,54 +231,6 @@ static bool erofs_workgroup_get(struct erofs_workgroup *grp)
>   	return true;
>   }
>   
> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
> -					     pgoff_t index)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_workgroup *grp;
> -
> -repeat:
> -	rcu_read_lock();
> -	grp = xa_load(&sbi->managed_pslots, index);
> -	if (grp) {
> -		if (!erofs_workgroup_get(grp)) {
> -			/* prefer to relax rcu read side */
> -			rcu_read_unlock();
> -			goto repeat;
> -		}
> -
> -		DBG_BUGON(index != grp->index);
> -	}
> -	rcu_read_unlock();
> -	return grp;
> -}
> -
> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> -					       struct erofs_workgroup *grp)
> -{
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> -	struct erofs_workgroup *pre;
> -
> -	DBG_BUGON(grp->lockref.count < 1);
> -repeat:
> -	xa_lock(&sbi->managed_pslots);
> -	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> -			   NULL, grp, GFP_KERNEL);
> -	if (pre) {
> -		if (xa_is_err(pre)) {
> -			pre = ERR_PTR(xa_err(pre));
> -		} else if (!erofs_workgroup_get(pre)) {
> -			/* try to legitimize the current in-tree one */
> -			xa_unlock(&sbi->managed_pslots);
> -			cond_resched();
> -			goto repeat;
> -		}
> -		grp = pre;
> -	}
> -	xa_unlock(&sbi->managed_pslots);
> -	return grp;
> -}
> -
>   static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>   {
>   	atomic_long_dec(&erofs_global_shrink_cnt);


