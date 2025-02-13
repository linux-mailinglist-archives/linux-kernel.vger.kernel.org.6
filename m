Return-Path: <linux-kernel+bounces-512825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9644FA33E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D663A3A7D46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EE227EAC;
	Thu, 13 Feb 2025 11:33:12 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881E227E81
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446392; cv=none; b=O4God259LhuxvAxOHUJRZCt1O+ij4/NSZ3EuN2PMwgdzvM86jelVIdwux9CllLOOtRoqjiCjOBJ+7C2ckHbbg8iM6pZGjv3miPjPf/N8axgmgX1gvK+MqD1QBzIla8AceM8RheJjSKZcKOFYv+F92/BUen1owotjxZRj2ijC7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446392; c=relaxed/simple;
	bh=V+AwE1QTUtYA/EUX82SaIWilcGuAgp0jbcMZ/79Lpz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgYoUU7n+D6p5pWJhAjBXm2dIrQ1334gmMLG3NWEmCbWB1kvcrI2rvhnGpoGd5qypt9CcMZnsTVwAyghtOhm56Vj0TXQ9rxXPSbleYfxId2Bt0SWiHYPiyRd27FH0NSO2Wizn+ylAo2WMAj9juyL3ZoVU+Jyk6BQK/jhIEVhC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.117])
	by sina.com (10.185.250.23) with ESMTP
	id 67ADD86700000167; Thu, 13 Feb 2025 19:32:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6767338913384
X-SMAIL-UIID: CE2940338DB543F5879DFA9EB4FAB75B-20250213-193257-1
From: Hillf Danton <hdanton@sina.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Date: Thu, 13 Feb 2025 19:32:47 +0800
Message-ID: <20250213113248.2225-1-hdanton@sina.com>
In-Reply-To: <20250212063153.179231-13-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 15:27:10 +0900 Sergey Senozhatsky
> Switch over from rwlock_t to a atomic_t variable that takes negative
> value when the page is under migration, or positive values when the
> page is used by zsmalloc users (object map, etc.)   Using a rwsem
> per-zspage is a little too memory heavy, a simple atomic_t should
> suffice.
> 
> zspage lock is a leaf lock for zs_map_object(), where it's read-acquired.
> Since this lock now permits preemption extra care needs to be taken when
> it is write-acquired - all writers grab it in atomic context, so they
> cannot spin and wait for (potentially preempted) reader to unlock zspage.
> There are only two writers at this moment - migration and compaction.  In
> both cases we use write-try-lock and bail out if zspage is read locked.
> Writers, on the other hand, never get preempted, so readers can spin
> waiting for the writer to unlock zspage.
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

Given mcs_spinlock, inventing spinlock in 2025 sounds no good.
See below for the spinlock version.
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
> +{
> +	atomic_t *lock = &zspage->lock;
> +	int old = ZS_PAGE_UNLOCKED;
> +
> +	WARN_ON_ONCE(preemptible());
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

struct zspage_lock {
	spinlock_t	lock;
	int		cnt;
	struct lockdep_map lockdep_map;
};

static __must_check bool zspage_write_trylock(struct zspage_lock *zl)
{
	spin_lock(&zl->lock);
	if (zl->cnt == ZS_PAGE_UNLOCKED) {
		// zl->cnt = ZS_PAGE_WRLOCKED;
		rwsem_acquire(&zl->lockdep_map, 0, 1, _RET_IP_);
		return true;
	}
	spin_unlock(&zl->lock);
	return false;
}

static void zspage_write_unlock(struct zspage_lock *zl)
{
	rwsem_release(&zl->lockdep_map, _RET_IP_);
	spin_unlock(&zl->lock);
}

static void zspage_read_lock(struct zspage_lock *zl)
{
	rwsem_acquire_read(&zl->lockdep_map, 0, 0, _RET_IP_);

	spin_lock(&zl->lock);
	zl->cnt++;
	spin_unlock(&zl->lock);
}

static void zspage_read_unlock(struct zspage_lock *zl)
{
	rwsem_release(&zl->lockdep_map, _RET_IP_);

	spin_lock(&zl->lock);
	zl->cnt--;
	spin_unlock(&zl->lock);
}

