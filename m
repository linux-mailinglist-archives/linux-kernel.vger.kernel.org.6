Return-Path: <linux-kernel+bounces-403497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9169C3683
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F184CB217AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556731F931;
	Mon, 11 Nov 2024 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VmFzjfb4"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583917F7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291942; cv=none; b=PoBSgeb6ZOHPSTlJ3SM1EauLr9sio7sCDSflduUdGmdEDNkNa6poORAcVxg1T/1kFl53s1F+2PGh5AZNEKGiWhUC2bWwv4eAEaRs78WjaUzsqctkubxBoKyEH284G5C8iLxKkLHOblQE+0qV1ti18jics1PXl7kUUgS6B80DFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291942; c=relaxed/simple;
	bh=VMjBwW+2LOcMQILgv06ITF9jWjyqw9ZZlwpx5k11UFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPVTlZ2zzsTYv4qUVz6yuZ4rHtP4PLjPr7UwFWSYPnZX1rSS5NiHXgZjFHaAh5ApVDY6SxsBU0zXWW0L7TGcx7n/vNV9uuO8YL4xbN6cCy/t4khOCKtfjvlTAP1fSwyggOePTKbYnBsSf4NW6GZkIxkcmDriDJz9zmudkG+VZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VmFzjfb4; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731291930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J7nJT3kT/1BIUWoxqyiSR8GeWtZCte2Tm+Vp1zGFxtQ=;
	b=VmFzjfb4wB+gvXS+zYuywK/KZ7YtJFDSQhs+axpUD+Bw01W7uO0/EpTUErfiw/dLtVJzX3dHrBhymin1JhOsHGakgjvkZK5VbupFhp3E3ijFlGck7zryouq5Vrs3v0p3iB5Dz6fgL35S/6/JRenwPzRpzeAyvSbYufSvZtJKZG8=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3wSZr_1731291929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:25:30 +0800
Message-ID: <f0fb91d9-6809-4efa-a5ab-b8d38fe5dbdc@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:25:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: free pclusters if no cached folio attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241101063821.3021559-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241101063821.3021559-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunhai,

On 2024/11/1 14:38, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
> change since v1:
>   - rebase this patch on "sunset z_erofs_workgroup` series
>   - remove check on pcl->partial and get rid of `be->try_free`
>   - update test results base on 6.6 kernel
> ---
>   fs/erofs/zdata.c | 59 +++++++++++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 4558e6a98336..1a7f56259f45 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -896,14 +896,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
>   			struct z_erofs_pcluster, rcu));
>   }
>   
> -static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
> +static bool erofs_prepare_to_release_pcluster(struct erofs_sb_info *sbi,
>   					  struct z_erofs_pcluster *pcl)
>   {
> -	int free = false;
> -
> -	spin_lock(&pcl->lockref.lock);
>   	if (pcl->lockref.count)
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * Note that all cached folios should be detached before deleted from
> @@ -911,7 +908,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>   	 * orphan old pcluster when the new one is available in the tree.
>   	 */
>   	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * It's impossible to fail after the pcluster is freezed, but in order
> @@ -920,8 +917,18 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>   	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
>   
>   	lockref_mark_dead(&pcl->lockref);
> -	free = true;
> -out:
> +	return true;
> +}
> +
> +static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
> +					  struct z_erofs_pcluster *pcl)
> +{
> +	bool free = false;
> +
> +	/* Using trylock to avoid deadlock with z_erofs_put_pcluster() */
> +	if (!spin_trylock(&pcl->lockref.lock))
> +		return free;

Thanks for the patch!

I think no need to move the common shrink path into trylock,
instead

> +	free = erofs_prepare_to_release_pcluster(sbi, pcl);
>   	spin_unlock(&pcl->lockref.lock);
>   	if (free) {
>   		atomic_long_dec(&erofs_global_shrink_cnt);
> @@ -953,16 +960,27 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
>   	return freed;
>   }
>   
> -static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
> +static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
> +		struct z_erofs_pcluster *pcl, bool try_free)
>   {
> +	bool free = false;
> +
>   	if (lockref_put_or_lock(&pcl->lockref))
>   		return;
>   
>   	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
> -	if (pcl->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--pcl->lockref.count;
> +	if (--pcl->lockref.count == 0) {
> +		if (try_free) {

I think here since we are really doing _try free_, so just

			spin_unlock(&pcl->lockref.lock);

			xa_lock(&sbi->managed_pslots);
			free = erofs_try_to_release_pcluster(sbi, pcl);
			xa_unlock(&sbi->managed_pslots);

is enough. IOWs, if other users race with it, I think the other user
will be responsible for this.

Thanks,
Gao Xiang

> +			xa_lock(&sbi->managed_pslots);
> +			free = erofs_prepare_to_release_pcluster(sbi, pcl);
> +			xa_unlock(&sbi->managed_pslots);
> +		}
> +		if (!free)
> +			atomic_long_inc(&erofs_global_shrink_cnt);
> +	}
>   	spin_unlock(&pcl->lockref.lock);
> +	if (free)
> +		call_rcu(&pcl->rcu, z_erofs_rcu_callback);

