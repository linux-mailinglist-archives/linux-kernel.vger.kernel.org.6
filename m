Return-Path: <linux-kernel+bounces-511604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B955A32D28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C563A92A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5D257AC4;
	Wed, 12 Feb 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XI+Im9U8"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2320F079
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380508; cv=none; b=B7Y7/OKk9D1aJib/2+4MkwEYM6yyj5oaiVfkR4UCCTo7aJdlohQ+pK6Rc+aXmspagxtpaxOrF0CsNi7CoAF1vr6TjbgF/R69uQyGf8gVHao43n059qDd5dmvO4pKKv4yO5qpWMwlDDd7Jk7R7jkXDCSOr1z3JNZrm4hKTGEuJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380508; c=relaxed/simple;
	bh=bfLam+Q8qKNKogYJtPZpio8053eYDKUYXBanDesy2EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoUegQxO4bVWpCfsD8MT4yjfPLRYAelpNfyi7u7C4W0aSCnyQmrPB59Lj5B0z/GewHIjP+wGXIwOWIA76bSrXA4xqR9OJBk9nRrtyWJ9WGvW4Rl+t7deOTzO6VbeKpQTIGo2P71OmiV76tFTBFF6pyjdwug6Qybbf0qgxpI9H4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XI+Im9U8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 17:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739380502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g46047KfJqmOiHfv+2ei90V6CCu3CRN7kNviIAfaHzQ=;
	b=XI+Im9U873IpJzEunWGkApFlVTB2PTXgQFRDwXFYAfurRPkyKyxXpn9Oq3FQWohgS/QNu1
	jtNnMls679eNzJJ+Zu3/vNEtNXow5cZz9hKxCrVH7jcCDMCixUPfKY6gOxPREvByhurclI
	4g1HVI+Y2UNwXIp1hfImNF88yLYa0f4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Message-ID: <Z6zXEktee8OS51hg@google.com>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-13-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212063153.179231-13-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 03:27:10PM +0900, Sergey Senozhatsky wrote:
> Switch over from rwlock_t to a atomic_t variable that takes negative
> value when the page is under migration, or positive values when the
> page is used by zsmalloc users (object map, etc.)   Using a rwsem
> per-zspage is a little too memory heavy, a simple atomic_t should
> suffice.

We should also explain that rwsem cannot be used due to the locking
context (we need to hold it in an atomic context). Basically what you
explained to me before :)

> 
> zspage lock is a leaf lock for zs_map_object(), where it's read-acquired.
> Since this lock now permits preemption extra care needs to be taken when
> it is write-acquired - all writers grab it in atomic context, so they
> cannot spin and wait for (potentially preempted) reader to unlock zspage.
> There are only two writers at this moment - migration and compaction.  In
> both cases we use write-try-lock and bail out if zspage is read locked.
> Writers, on the other hand, never get preempted, so readers can spin
> waiting for the writer to unlock zspage.

The details are important, but I think we want to concisely state the
problem statement either before or after. Basically we want a lock that
we *never* sleep while acquiring but *can* sleep while holding in read
mode. This allows holding the lock from any context, but also being
preemptible if the context allows it.

> 
> With this we can implement a preemptible object mapping.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  mm/zsmalloc.c | 183 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 128 insertions(+), 55 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index c82c24b8e6a4..80261bb78cf8 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -226,6 +226,9 @@ struct zs_pool {
>  	/* protect page/zspage migration */
>  	rwlock_t lock;
>  	atomic_t compaction_in_progress;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lock_class_key lockdep_key;
> +#endif
>  };
>  
>  static void pool_write_unlock(struct zs_pool *pool)
> @@ -292,6 +295,9 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
>  	__free_page(page);
>  }
>  
> +#define ZS_PAGE_UNLOCKED	0
> +#define ZS_PAGE_WRLOCKED	-1
> +
>  struct zspage {
>  	struct {
>  		unsigned int huge:HUGE_BITS;
> @@ -304,7 +310,11 @@ struct zspage {
>  	struct zpdesc *first_zpdesc;
>  	struct list_head list; /* fullness list */
>  	struct zs_pool *pool;
> -	rwlock_t lock;
> +	atomic_t lock;
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map lockdep_map;
> +#endif
>  };
>  
>  struct mapping_area {
> @@ -314,6 +324,88 @@ struct mapping_area {
>  	enum zs_mapmode vm_mm; /* mapping mode */
>  };
>  
> +static void zspage_lock_init(struct zspage *zspage)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_init_map(&zspage->lockdep_map, "zsmalloc-page",
> +			 &zspage->pool->lockdep_key, 0);
> +#endif
> +
> +	atomic_set(&zspage->lock, ZS_PAGE_UNLOCKED);
> +}
> +
> +/*
> + * zspage locking rules:

Also here we need to state our key rule:
Never sleep while acquiring, preemtible while holding (if possible). The
following rules are basically how we make sure we keep this true.

> + *
> + * 1) writer-lock is exclusive
> + *
> + * 2) writer-lock owner cannot sleep
> + *
> + * 3) writer-lock owner cannot spin waiting for the lock
> + *   - caller (e.g. compaction and migration) must check return value and
> + *     handle locking failures
> + *   - there is only TRY variant of writer-lock function
> + *
> + * 4) reader-lock owners (multiple) can sleep
> + *
> + * 5) reader-lock owners can spin waiting for the lock, in any context
> + *   - existing readers (even preempted ones) don't block new readers
> + *   - writer-lock owners never sleep, always unlock at some point


May I suggest something more concise and to the point?

/*
 * The zspage lock can be held from atomic contexts, but it needs to remain
 * preemptible when held for reading because it remains held outside of those
 * atomic contexts, otherwise we unnecessarily lose preemptibility.
 *
 * To achieve this, the following rules are enforced on readers and writers:
 *
 * - Writers are blocked by both writers and readers, while readers are only
 *   blocked by writers (i.e. normal rwlock semantics).
 *
 * - Writers are always atomic (to allow readers to spin waiting for them).
 *
 * - Writers always use trylock (as the lock may be held be sleeping readers).
 *
 * - Readers may spin on the lock (as they can only wait for atomic writers).
 *
 * - Readers may sleep while holding the lock (as writes only use trylock).
 */

> + */
> +static void zspage_read_lock(struct zspage *zspage)
> +{
> +	atomic_t *lock = &zspage->lock;
> +	int old = atomic_read_acquire(lock);
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	rwsem_acquire_read(&zspage->lockdep_map, 0, 0, _RET_IP_);
> +#endif
> +
> +	do {
> +		if (old == ZS_PAGE_WRLOCKED) {
> +			cpu_relax();
> +			old = atomic_read_acquire(lock);
> +			continue;
> +		}
> +	} while (!atomic_try_cmpxchg_acquire(lock, &old, old + 1));
> +}
> +
> +static void zspage_read_unlock(struct zspage *zspage)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	rwsem_release(&zspage->lockdep_map, _RET_IP_);
> +#endif
> +	atomic_dec_return_release(&zspage->lock);
> +}
> +
> +static __must_check bool zspage_try_write_lock(struct zspage *zspage)

I believe zspage_write_trylock() would be closer to the normal rwlock
naming.

> +{
> +	atomic_t *lock = &zspage->lock;
> +	int old = ZS_PAGE_UNLOCKED;
> +
> +	WARN_ON_ONCE(preemptible());

Hmm I know I may have been the one suggesting this, but do we actually
need it? We disable preemption explicitly anyway before holding the
lock.

> +
> +	preempt_disable();
> +	if (atomic_try_cmpxchg_acquire(lock, &old, ZS_PAGE_WRLOCKED)) {
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +		rwsem_acquire(&zspage->lockdep_map, 0, 1, _RET_IP_);
> +#endif
> +		return true;
> +	}
> +
> +	preempt_enable();
> +	return false;
> +}
> +
> +static void zspage_write_unlock(struct zspage *zspage)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	rwsem_release(&zspage->lockdep_map, _RET_IP_);
> +#endif
> +	atomic_set_release(&zspage->lock, ZS_PAGE_UNLOCKED);
> +	preempt_enable();
> +}
> +
>  /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
>  static void SetZsHugePage(struct zspage *zspage)
>  {
> @@ -325,12 +417,6 @@ static bool ZsHugePage(struct zspage *zspage)
>  	return zspage->huge;
>  }
>  
> -static void migrate_lock_init(struct zspage *zspage);
> -static void migrate_read_lock(struct zspage *zspage);
> -static void migrate_read_unlock(struct zspage *zspage);
> -static void migrate_write_lock(struct zspage *zspage);
> -static void migrate_write_unlock(struct zspage *zspage);
> -
>  #ifdef CONFIG_COMPACTION
>  static void kick_deferred_free(struct zs_pool *pool);
>  static void init_deferred_free(struct zs_pool *pool);
> @@ -1026,7 +1112,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  		return NULL;
>  
>  	zspage->magic = ZSPAGE_MAGIC;
> -	migrate_lock_init(zspage);
> +	zspage->pool = pool;
> +	zspage->class = class->index;
> +	zspage_lock_init(zspage);
>  
>  	for (i = 0; i < class->pages_per_zspage; i++) {
>  		struct zpdesc *zpdesc;
> @@ -1049,8 +1137,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  
>  	create_page_chain(class, zspage, zpdescs);
>  	init_zspage(class, zspage);
> -	zspage->pool = pool;
> -	zspage->class = class->index;
>  
>  	return zspage;
>  }
> @@ -1251,7 +1337,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>  	 * zs_unmap_object API so delegate the locking from class to zspage
>  	 * which is smaller granularity.
>  	 */
> -	migrate_read_lock(zspage);
> +	zspage_read_lock(zspage);
>  	pool_read_unlock(pool);
>  
>  	class = zspage_class(pool, zspage);
> @@ -1311,7 +1397,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
>  	}
>  	local_unlock(&zs_map_area.lock);
>  
> -	migrate_read_unlock(zspage);
> +	zspage_read_unlock(zspage);
>  }
>  EXPORT_SYMBOL_GPL(zs_unmap_object);
>  
> @@ -1705,18 +1791,18 @@ static void lock_zspage(struct zspage *zspage)
>  	/*
>  	 * Pages we haven't locked yet can be migrated off the list while we're
>  	 * trying to lock them, so we need to be careful and only attempt to
> -	 * lock each page under migrate_read_lock(). Otherwise, the page we lock
> +	 * lock each page under zspage_read_lock(). Otherwise, the page we lock
>  	 * may no longer belong to the zspage. This means that we may wait for
>  	 * the wrong page to unlock, so we must take a reference to the page
> -	 * prior to waiting for it to unlock outside migrate_read_lock().
> +	 * prior to waiting for it to unlock outside zspage_read_lock().
>  	 */
>  	while (1) {
> -		migrate_read_lock(zspage);
> +		zspage_read_lock(zspage);
>  		zpdesc = get_first_zpdesc(zspage);
>  		if (zpdesc_trylock(zpdesc))
>  			break;
>  		zpdesc_get(zpdesc);
> -		migrate_read_unlock(zspage);
> +		zspage_read_unlock(zspage);
>  		zpdesc_wait_locked(zpdesc);
>  		zpdesc_put(zpdesc);
>  	}
> @@ -1727,41 +1813,16 @@ static void lock_zspage(struct zspage *zspage)
>  			curr_zpdesc = zpdesc;
>  		} else {
>  			zpdesc_get(zpdesc);
> -			migrate_read_unlock(zspage);
> +			zspage_read_unlock(zspage);
>  			zpdesc_wait_locked(zpdesc);
>  			zpdesc_put(zpdesc);
> -			migrate_read_lock(zspage);
> +			zspage_read_lock(zspage);
>  		}
>  	}
> -	migrate_read_unlock(zspage);
> +	zspage_read_unlock(zspage);
>  }
>  #endif /* CONFIG_COMPACTION */
>  
> -static void migrate_lock_init(struct zspage *zspage)
> -{
> -	rwlock_init(&zspage->lock);
> -}
> -
> -static void migrate_read_lock(struct zspage *zspage) __acquires(&zspage->lock)
> -{
> -	read_lock(&zspage->lock);
> -}
> -
> -static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
> -{
> -	read_unlock(&zspage->lock);
> -}
> -
> -static void migrate_write_lock(struct zspage *zspage)
> -{
> -	write_lock(&zspage->lock);
> -}
> -
> -static void migrate_write_unlock(struct zspage *zspage)
> -{
> -	write_unlock(&zspage->lock);
> -}
> -
>  #ifdef CONFIG_COMPACTION
>  
>  static const struct movable_operations zsmalloc_mops;
> @@ -1803,7 +1864,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
>  }
>  
>  static int zs_page_migrate(struct page *newpage, struct page *page,
> -		enum migrate_mode mode)
> +			   enum migrate_mode mode)
>  {
>  	struct zs_pool *pool;
>  	struct size_class *class;
> @@ -1819,15 +1880,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  
>  	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
>  
> -	/* We're committed, tell the world that this is a Zsmalloc page. */
> -	__zpdesc_set_zsmalloc(newzpdesc);
> -
>  	/* The page is locked, so this pointer must remain valid */
>  	zspage = get_zspage(zpdesc);
>  	pool = zspage->pool;
>  
>  	/*
> -	 * The pool lock protects the race between zpage migration
> +	 * The pool->lock protects the race between zpage migration
>  	 * and zs_free.
>  	 */
>  	pool_write_lock(pool);
> @@ -1837,8 +1895,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	 * the class lock protects zpage alloc/free in the zspage.
>  	 */
>  	size_class_lock(class);
> -	/* the migrate_write_lock protects zpage access via zs_map_object */
> -	migrate_write_lock(zspage);
> +	/* the zspage write_lock protects zpage access via zs_map_object */
> +	if (!zspage_try_write_lock(zspage)) {
> +		size_class_unlock(class);
> +		pool_write_unlock(pool);
> +		return -EINVAL;
> +	}
> +
> +	/* We're committed, tell the world that this is a Zsmalloc page. */
> +	__zpdesc_set_zsmalloc(newzpdesc);

We used to do this earlier on, before any locks are held. Why is it
moved here?

>  
>  	offset = get_first_obj_offset(zpdesc);
>  	s_addr = kmap_local_zpdesc(zpdesc);
> @@ -1869,7 +1934,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	 */
>  	pool_write_unlock(pool);
>  	size_class_unlock(class);
> -	migrate_write_unlock(zspage);
> +	zspage_write_unlock(zspage);
>  
>  	zpdesc_get(newzpdesc);
>  	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
> @@ -2005,9 +2070,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  		if (!src_zspage)
>  			break;
>  
> -		migrate_write_lock(src_zspage);
> +		if (!zspage_try_write_lock(src_zspage))
> +			break;
> +
>  		migrate_zspage(pool, src_zspage, dst_zspage);
> -		migrate_write_unlock(src_zspage);
> +		zspage_write_unlock(src_zspage);
>  
>  		fg = putback_zspage(class, src_zspage);
>  		if (fg == ZS_INUSE_RATIO_0) {
> @@ -2267,7 +2334,9 @@ struct zs_pool *zs_create_pool(const char *name)
>  	 * trigger compaction manually. Thus, ignore return code.
>  	 */
>  	zs_register_shrinker(pool);
> -
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_register_key(&pool->lockdep_key);
> +#endif
>  	return pool;
>  
>  err:
> @@ -2304,6 +2373,10 @@ void zs_destroy_pool(struct zs_pool *pool)
>  		kfree(class);
>  	}
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_unregister_key(&pool->lockdep_key);
> +#endif
> +
>  	destroy_cache(pool);
>  	kfree(pool->name);
>  	kfree(pool);
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

