Return-Path: <linux-kernel+bounces-526542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48CA40004
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAFD3A56C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4411FF1BD;
	Fri, 21 Feb 2025 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KpaA9G3t"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527081EBA0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167319; cv=none; b=cnEYCfpvkK4fhRK8lMW/gaDtnL5MCFdRgqezxggeHL6LStwK4hfPoGQKSXvQKkRuVxW6g8a58Vb6LikxoFH8zAHYBOGb+q3ZLYJTHzirfrZJNXxu8eLejNlImoDF05NO/eDXDTMN5hSqE2fOKtbT1HJAyILydFNpw6Vffc6K+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167319; c=relaxed/simple;
	bh=O0Po619OpYyzpk8/XnhnMJwk/n2w/BAvxZG83BWThjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXCGJJjwaoBDJGaDvjjgZ79hcyVV8U48UhAzhqT9gEM8zvTdAvWAAoayQQMmU0vMsVSzaaTEiPNn4T6RAf8bWJnVz6hwHreyK/Nn0YG1yFAB2Gypbzouv4XkAuL8WX/Y0fPRej4Na+HEjNj6XtVmpUbKVGcwstk9qsLIGipdLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KpaA9G3t; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 19:48:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740167315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VZV/clnvNXCz5Ztd7ewh3k3BEU+6K426UzXxiKS+RA=;
	b=KpaA9G3tPgI53Nlrkx0rhqzAYErPi7LAdYZIFFGKgwgboAnE6zJ/lmM7EpjeHsaGW8MCy8
	J1L4SCipHVFQoJ9iP8pCPaFOgOxZFHCJp6Hr1JEBCZao63oIERsBzPGhWy1J17DLcZCbVg
	YLdYh04tYH1ag6dUSBOeTvqJ/JrI41I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <Z7jYiuRlC7_8_wzD@google.com>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
 <20250221093832.1949691-12-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221093832.1949691-12-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 06:38:04PM +0900, Sergey Senozhatsky wrote:
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
>  mm/zsmalloc.c | 189 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 135 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1424ee73cbb5..250f1fddaf34 100644
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
> @@ -279,6 +294,91 @@ struct mapping_area {
>  	enum zs_mapmode vm_mm; /* mapping mode */
>  };
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#define zsl_dep_map(zsl) (&(zsl)->dep_map)
> +#else
> +#define zsl_dep_map(zsl) NULL
> +#endif
> +
> +static void zspage_lock_init(struct zspage *zspage)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
> +			 &zspage->pool->lock_class, 0);

Can't we remove this #ifdef as well by adding a similar macro? (e.g.
zsl_lock_class())

