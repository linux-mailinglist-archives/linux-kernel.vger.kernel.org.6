Return-Path: <linux-kernel+bounces-405149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACF9C4D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757D8B225BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797C205E08;
	Tue, 12 Nov 2024 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rzwSYY2D"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B71DFE4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384200; cv=none; b=piJwEPpuyB6S6aFYgrELO+PX6zQjwEUmnsB4c4bQSSxNkcwWrUpaiscT7WdMeXNb8eK/pe0xPbJ6FzuYens7+g+YCOqjhzroWMD9kTuV908ms20ITPWMNLPj+a/91/xa6RoZwcTzRWKCk6xfw/eh/o1XJ2A1jKey9rW/PqXKccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384200; c=relaxed/simple;
	bh=AmystDOCWU9Gy9nkcnXSuFUTc46boQFhfNNb53UmWDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDNUJLU7gAcTJ9uC2EdGclzV+4lsqKh2tj85tDJIEo/WFZb7bSfAF7dhq90TOBA+8Tg1GvI/+W3LpVMT0gv+jjSaNPjEvmyiI/ffr+4+uGVDSDZUM+nx6SoLp1/nTwfBzP+hiKzYlRQwoyS9XPzNG2aKrsGP56fjVz/BzTw56Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rzwSYY2D; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731384195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WvbGuu5qZxiTcUXoqyvrii6MYDsHms+3eRcUahSrvSc=;
	b=rzwSYY2DzyjDdi9Ef4lhGTgGzDxSqnS347i6zkNYbL1Sf17uMcXbBpdIOiXRvOYgml5kbfAdsgG5HQokyJDzCA6MpOGQut5F3Jpi2SCDh62RMnyatEOdyFI9flSvjQVirzlWaFXSK5Rocafda4rUM3U7Tkc7/p/4a0DWGkxWm8E=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFTf3q_1731384193 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 12:03:15 +0800
Message-ID: <0f525b1e-820c-4bbd-b8ba-59a16fd73ade@linux.alibaba.com>
Date: Tue, 12 Nov 2024 12:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: free pclusters if no cached folio is attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241112041129.541307-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112041129.541307-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 12:11, Chunhai Guo wrote:
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
> v4 -> v5:
>   - modify subject to be more formal
>   - `--pcl->lockref.count == 0` --> `!--pcl->lockref.count`
> 
> v3 -> v4:
>   - modify the patch as Gao Xiang suggested in v3.
> 
> v2 -> v3:
>   - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
>   - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()
> 
> v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
> change since v1:
>   - rebase this patch on "sunset z_erofs_workgroup` series
>   - remove check on pcl->partial and get rid of `be->try_free`
>   - update test results base on 6.6 kernel
> ---
>   fs/erofs/zdata.c | 54 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6b73a2307460..737f33d28c40 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
>   			struct z_erofs_pcluster, rcu));
>   }
>   
> -static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
> +static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
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
> @@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>   	 * orphan old pcluster when the new one is available in the tree.
>   	 */
>   	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * It's impossible to fail after the pcluster is freezed, but in order
> @@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
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
> +	bool free;
> +
> +	spin_lock(&pcl->lockref.lock);
> +	free = __erofs_try_to_release_pcluster(sbi, pcl);
>   	spin_unlock(&pcl->lockref.lock);
>   	if (free) {
>   		atomic_long_dec(&erofs_global_shrink_cnt);
> @@ -942,16 +947,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
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
> +	if (!--pcl->lockref.count) {
> +		if (try_free && xa_trylock(&sbi->managed_pslots)) {
> +			free = __erofs_try_to_release_pcluster(sbi, pcl);
> +			xa_unlock(&sbi->managed_pslots);
> +		}
> +		atomic_long_add(!free, &erofs_global_shrink_cnt);
> +	}
>   	spin_unlock(&pcl->lockref.lock);
> +	if (free)
> +		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
>   }
>   
>   static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
> @@ -972,7 +986,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>   	 * any longer if the pcluster isn't hosted by ourselves.
>   	 */
>   	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
> -		z_erofs_put_pcluster(pcl);
> +		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
>   
>   	fe->pcl = NULL;
>   }
> @@ -1274,6 +1288,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   	int i, j, jtop, err2;
>   	struct page *page;
>   	bool overlapped;
> +	bool try_free = true;
>   
>   	mutex_lock(&pcl->lock);
>   	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
> @@ -1332,8 +1347,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   		for (i = 0; i < pclusterpages; ++i) {
>   			page = be->compressed_pages[i];
>   			if (!page ||
> -			    erofs_folio_is_managed(sbi, page_folio(page)))
> +			    erofs_folio_is_managed(sbi, page_folio(page))) {

another issue:

			if (!page)
				continue;
			if (erofs_folio_is_managed(sbi, page_folio(page)) {
				try_free = false;
				continue;
			}

!page could happen if some memory allocation is failed and
we need to bail out.

Thanks,
Gao Xiang

