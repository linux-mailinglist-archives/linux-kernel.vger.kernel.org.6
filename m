Return-Path: <linux-kernel+bounces-511461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE50A32B57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801EE3A3EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40320F08B;
	Wed, 12 Feb 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJDcyJht"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC31271838
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377103; cv=none; b=juNRlMRpVOqRZhmwfm5mlRPfiV69pp3IF8AWCBuPrDC2ccLiKiN8y4az3emWczYPvY+u+ogKU14dCudDc5bi+Er5DK1e+eR+6Scb7Xy0nVJDHcQ+gM9NVHx0dEsv1WVm0EwzmaeCQ6vv8DDTBu8odTkbICUVS4uoA5sH/kyRQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377103; c=relaxed/simple;
	bh=FqD0mJejr8NNmIXd9wk8XEQVYpTrD0Yl9WNLvbJBuys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc/Jx77TBbWXlmnDwwjanaFK6jyXMu5fqUFJNDJuHulWdMc4EQ5Jk7gu2rbY7VIzHbhtM7BrBEdKWA/Hqb34gw4IWZD97uu7hVsZNNMT2F20sc0YGDIFJacHupL5R+dFrxRWbVvcAW2AKVV/jA+03HwBL/NDXSgXF4xnncxpr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJDcyJht; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 16:18:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739377099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8sbZGIrU5ceW1xiKOedooUcjCQRIvPjuNItFFd09wtg=;
	b=NJDcyJht7AeI00TfUWJEpc2hJhV354L8qmqv/6HzUweMk/x7EIPRjW3crYfABZYrwsLjpQ
	67Lx5lBG53DcezBuXvk6LKLVIvMFqWPi7OtIh/t8Z6no1UtUZ3CrPDsmAqkK8EA7HxIRkB
	8NQC68RVipcjk2EDOVuni+N93c8vVvA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/18] zsmalloc: factor out pool locking helpers
Message-ID: <Z6zJxvLbRQ6pKtue@google.com>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-11-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212063153.179231-11-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 03:27:08PM +0900, Sergey Senozhatsky wrote:
> We currently have a mix of migrate_{read,write}_lock() helpers
> that lock zspages, but it's zs_pool that actually has a ->migrate_lock
> access to which is opene-coded.  Factor out pool migrate locking
> into helpers, zspage migration locking API will be renamed to
> reduce confusion.
> 
> It's worth mentioning that zsmalloc locks sync not only migration,
> but also compaction.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

FWIW I don't see a lot of value in the helpers (renaming the lock is
useful tho). We open-code other locks like the class lock anyway, and
the helpers obscure the underlying lock type without adding much value
in terms of readability/conciseness.

> ---
>  mm/zsmalloc.c | 63 +++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 6d0e47f7ae33..47c638df47c5 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -18,7 +18,7 @@
>  /*
>   * lock ordering:
>   *	page_lock
> - *	pool->migrate_lock
> + *	pool->lock
>   *	class->lock
>   *	zspage->lock
>   */
> @@ -224,10 +224,35 @@ struct zs_pool {
>  	struct work_struct free_work;
>  #endif
>  	/* protect page/zspage migration */
> -	rwlock_t migrate_lock;
> +	rwlock_t lock;
>  	atomic_t compaction_in_progress;
>  };
>  
> +static void pool_write_unlock(struct zs_pool *pool)
> +{
> +	write_unlock(&pool->lock);
> +}
> +
> +static void pool_write_lock(struct zs_pool *pool)
> +{
> +	write_lock(&pool->lock);
> +}
> +
> +static void pool_read_unlock(struct zs_pool *pool)
> +{
> +	read_unlock(&pool->lock);
> +}
> +
> +static void pool_read_lock(struct zs_pool *pool)
> +{
> +	read_lock(&pool->lock);
> +}
> +
> +static bool pool_lock_is_contended(struct zs_pool *pool)
> +{
> +	return rwlock_is_contended(&pool->lock);
> +}
> +
>  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
>  {
>  	SetPagePrivate(zpdesc_page(zpdesc));
> @@ -1206,7 +1231,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>  	BUG_ON(in_interrupt());
>  
>  	/* It guarantees it can get zspage from handle safely */
> -	read_lock(&pool->migrate_lock);
> +	pool_read_lock(pool);
>  	obj = handle_to_obj(handle);
>  	obj_to_location(obj, &zpdesc, &obj_idx);
>  	zspage = get_zspage(zpdesc);
> @@ -1218,7 +1243,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>  	 * which is smaller granularity.
>  	 */
>  	migrate_read_lock(zspage);
> -	read_unlock(&pool->migrate_lock);
> +	pool_read_unlock(pool);
>  
>  	class = zspage_class(pool, zspage);
>  	off = offset_in_page(class->size * obj_idx);
> @@ -1450,16 +1475,16 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
>  		return;
>  
>  	/*
> -	 * The pool->migrate_lock protects the race with zpage's migration
> +	 * The pool->lock protects the race with zpage's migration
>  	 * so it's safe to get the page from handle.
>  	 */
> -	read_lock(&pool->migrate_lock);
> +	pool_read_lock(pool);
>  	obj = handle_to_obj(handle);
>  	obj_to_zpdesc(obj, &f_zpdesc);
>  	zspage = get_zspage(f_zpdesc);
>  	class = zspage_class(pool, zspage);
>  	spin_lock(&class->lock);
> -	read_unlock(&pool->migrate_lock);
> +	pool_read_unlock(pool);
>  
>  	class_stat_sub(class, ZS_OBJS_INUSE, 1);
>  	obj_free(class->size, obj);
> @@ -1793,10 +1818,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	pool = zspage->pool;
>  
>  	/*
> -	 * The pool migrate_lock protects the race between zpage migration
> +	 * The pool lock protects the race between zpage migration
>  	 * and zs_free.
>  	 */
> -	write_lock(&pool->migrate_lock);
> +	pool_write_lock(pool);
>  	class = zspage_class(pool, zspage);
>  
>  	/*
> @@ -1833,7 +1858,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	 * Since we complete the data copy and set up new zspage structure,
>  	 * it's okay to release migration_lock.
>  	 */
> -	write_unlock(&pool->migrate_lock);
> +	pool_write_unlock(pool);
>  	spin_unlock(&class->lock);
>  	migrate_write_unlock(zspage);
>  
> @@ -1956,7 +1981,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  	 * protect the race between zpage migration and zs_free
>  	 * as well as zpage allocation/free
>  	 */
> -	write_lock(&pool->migrate_lock);
> +	pool_write_lock(pool);
>  	spin_lock(&class->lock);
>  	while (zs_can_compact(class)) {
>  		int fg;
> @@ -1983,14 +2008,14 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  		src_zspage = NULL;
>  
>  		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
> -		    || rwlock_is_contended(&pool->migrate_lock)) {
> +		    || pool_lock_is_contended(pool)) {
>  			putback_zspage(class, dst_zspage);
>  			dst_zspage = NULL;
>  
>  			spin_unlock(&class->lock);
> -			write_unlock(&pool->migrate_lock);
> +			pool_write_unlock(pool);
>  			cond_resched();
> -			write_lock(&pool->migrate_lock);
> +			pool_write_lock(pool);
>  			spin_lock(&class->lock);
>  		}
>  	}
> @@ -2002,7 +2027,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  		putback_zspage(class, dst_zspage);
>  
>  	spin_unlock(&class->lock);
> -	write_unlock(&pool->migrate_lock);
> +	pool_write_unlock(pool);
>  
>  	return pages_freed;
>  }
> @@ -2014,10 +2039,10 @@ unsigned long zs_compact(struct zs_pool *pool)
>  	unsigned long pages_freed = 0;
>  
>  	/*
> -	 * Pool compaction is performed under pool->migrate_lock so it is basically
> +	 * Pool compaction is performed under pool->lock so it is basically
>  	 * single-threaded. Having more than one thread in __zs_compact()
> -	 * will increase pool->migrate_lock contention, which will impact other
> -	 * zsmalloc operations that need pool->migrate_lock.
> +	 * will increase pool->lock contention, which will impact other
> +	 * zsmalloc operations that need pool->lock.
>  	 */
>  	if (atomic_xchg(&pool->compaction_in_progress, 1))
>  		return 0;
> @@ -2139,7 +2164,7 @@ struct zs_pool *zs_create_pool(const char *name)
>  		return NULL;
>  
>  	init_deferred_free(pool);
> -	rwlock_init(&pool->migrate_lock);
> +	rwlock_init(&pool->lock);
>  	atomic_set(&pool->compaction_in_progress, 0);
>  
>  	pool->name = kstrdup(name, GFP_KERNEL);
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

