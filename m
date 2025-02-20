Return-Path: <linux-kernel+bounces-524588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3AA3E4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C9E3BD3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03F24BD00;
	Thu, 20 Feb 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2VYRko8"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2115A858
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079131; cv=none; b=r1UzED64jxnT/XwpLjChMA74FRZG8BKP+HGC14ugiPOXCroB0PMZdlIH7bBWted34ilkXHxaxq90QPD0HKlN9biZrhAtfUBfM+3PD6Di11uIZT4xBE+k3nuD1QSXAokyHFghyClZZb1ooTDFciSCG/3u2Dc4B06VDf8oJLZkCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079131; c=relaxed/simple;
	bh=SJGd+oVoLiP7pwewFrj1oA983o4Z5c3b+UWS1r1r+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/BUdRK7J/eyyHi5ssQhfcI62foHTVsg8QbXCwbk3uESo4LA0dgQVxu2OoBfWktkuvmYdV6w8P6x9eM0xXVgAoAyJYZG2I3hH+VchMK8ESh+X1VHio/3s0+uNFF8/2jRaAz+Rhyce/hK6p+4f1M9V3n1KrdLcNJs0F6jSRdCUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2VYRko8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 19:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740079125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTJZmh7yY26uVk6h15hnLF5tyEUJH/rJ9jba2hgemVU=;
	b=a2VYRko85aunYYIDWBd3A1Qw66J2pHDgKO2ffcglYtammcMKPNRPknzC6zplhDY/w5z6KW
	dwJTKKC7yS7OcAMI+25jRRCD6YsGlpaYwHhqdbZNVRlYsSTepBBXE2TzbUZg/R8/k4W5rI
	+fPV9uKRrAxragWGlAmLTmomi7BGceI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <Z7eAEKpZ7VnGsVej@google.com>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
 <20250214045208.1388854-12-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214045208.1388854-12-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 14, 2025 at 01:50:23PM +0900, Sergey Senozhatsky wrote:
> In order to implement preemptible object mapping we need a zspage lock
> that satisfies several preconditions:
> - it should be reader-write type of a lock
> - it should be possible to hold it from any context, but also being
>   preemptible if the context allows it
> - we never sleep while acquiring but can sleep while holding in read
>   mode
> 
> An rwsemaphore doesn't suffice, due to atomicity requirements, rwlock
> doesn't satisfy due to reader-preemptability requirement.  It's also
> worth to mention, that per-zspage rwsem is a little too memory heavy
> (we can easily have double digits megabytes used only on rwsemaphores).
> 
> Switch over from rwlock_t to a atomic_t-based implementation of a
> reader-writer semaphore that satisfies all of the preconditions.
> 
> The spin-lock based zspage_lock is suggested by Hillf Danton.
> 
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 246 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 192 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 2e338cde0d21..bc679a3e1718 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -226,6 +226,9 @@ struct zs_pool {
>  	/* protect zspage migration/compaction */
>  	rwlock_t lock;
>  	atomic_t compaction_in_progress;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lock_class_key lock_class;
> +#endif
>  };
>  
>  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> @@ -257,6 +260,18 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
>  	__free_page(page);
>  }
>  
> +#define ZS_PAGE_UNLOCKED	0
> +#define ZS_PAGE_WRLOCKED	-1
> +
> +struct zspage_lock {
> +	spinlock_t lock;
> +	int cnt;
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map dep_map;
> +#endif
> +};
> +
>  struct zspage {
>  	struct {
>  		unsigned int huge:HUGE_BITS;
> @@ -269,7 +284,7 @@ struct zspage {
>  	struct zpdesc *first_zpdesc;
>  	struct list_head list; /* fullness list */
>  	struct zs_pool *pool;
> -	rwlock_t lock;
> +	struct zspage_lock zsl;
>  };
>  
>  struct mapping_area {
> @@ -279,6 +294,148 @@ struct mapping_area {
>  	enum zs_mapmode vm_mm; /* mapping mode */
>  };
>  
> +static void zspage_lock_init(struct zspage *zspage)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
> +			 &zspage->pool->lock_class, 0);
> +#endif
> +
> +	spin_lock_init(&zspage->zsl.lock);
> +	zspage->zsl.cnt = ZS_PAGE_UNLOCKED;
> +}
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC

Instead of the #ifdef and repeating all the functions, can't we do
something like:

#ifdef CONFIG_DEBUG_LOCK_ALLOC
#define zspage_lock_map(zsl) (&zsl->dep_map)
#else
#define zspage_lock_map(zsl) /* empty or NULL */
#endif

Then we can just have one version of the functions and use
zspage_lock_map() instead of zsl->dep_map, right?

> +static inline void __read_lock(struct zspage *zspage)
> +{
> +	struct zspage_lock *zsl = &zspage->zsl;
> +
> +	rwsem_acquire_read(&zsl->dep_map, 0, 0, _RET_IP_);
> +
> +	spin_lock(&zsl->lock);
> +	zsl->cnt++;

Shouldn't we check if the lock is write locked?

> +	spin_unlock(&zsl->lock);
> +
> +	lock_acquired(&zsl->dep_map, _RET_IP_);
> +}
> +
> +static inline void __read_unlock(struct zspage *zspage)
> +{
> +	struct zspage_lock *zsl = &zspage->zsl;
> +
> +	rwsem_release(&zsl->dep_map, _RET_IP_);
> +
> +	spin_lock(&zsl->lock);
> +	zsl->cnt--;
> +	spin_unlock(&zsl->lock);
> +}

