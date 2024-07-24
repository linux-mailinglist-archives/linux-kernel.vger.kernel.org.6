Return-Path: <linux-kernel+bounces-260494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE193AA37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BED0B22841
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45A4C70;
	Wed, 24 Jul 2024 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PDzi1+VL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC9290F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781941; cv=none; b=o7yoKY0aPBwUIcq9U2cmqflV4becdzx6INDCKXJSxZa8gUyoiztTCec5UJbTtWaIaH54xoTx1knSVXcyACU2s2VVoEsQ2EQMTu8egJTLzUV//iT+m3YXbQydNGKGoJRlUr1eNfXYEMrPNfDTeTj9wgn0PA2qif5wvIZpi7SE03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781941; c=relaxed/simple;
	bh=u3uumP4MHFlL3hT8/wvedCGQVg5+0l9gdaNJM+2XbEw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GndxoMZkvgY/Z8+TtJkbzS6RH5h3CK1pL0GdUKFBYXHMoJ9RHpZYXOeeIw1UTca7J0sBJbUv0ePLxJpJ2++1+QZzTM0z4ZRDz+uZLaRrKMTOMv0v9ptTqlAe3z2CCg8Ibts/aBSiC525098+fZs6B5HxAZUWIoh8QF0iN8BNUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PDzi1+VL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8F4C4AF09;
	Wed, 24 Jul 2024 00:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721781940;
	bh=u3uumP4MHFlL3hT8/wvedCGQVg5+0l9gdaNJM+2XbEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDzi1+VLLmSujDjEVon2iNCXriDaRO4DoXcyMUgPLAtiPuzH8pkd9n8uGuyP0n1dG
	 2Z81g5QCxhFDUvds7Vy4GKWqSKyu3WkCekL7OujQUqX1eJf3O4FAxbJsn83WeXjq9a
	 6bQ8IyJB6zWU353RAh1LBnhebEwQPu9RzGP/w38s=
Date: Tue, 23 Jul 2024 17:45:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, muchun.song@linux.dev, nphamcs@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
Message-Id: <20240723174540.18992614c476d77e7d9fb1e6@linux-foundation.org>
In-Reply-To: <20240718083607.42068-1-songmuchun@bytedance.com>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
> lock or cgroup_mutex or others which could prevent returned memcg
> from being freed. Fix it by adding missing rcu read lock.

"or others" is rather vague.  What others?

> @@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
>  
>  bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>  {
> +	bool ret;
>  	int nid = page_to_nid(virt_to_page(item));
> -	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
> -		mem_cgroup_from_slab_obj(item) : NULL;
> +	struct mem_cgroup *memcg;
>  
> -	return list_lru_add(lru, item, nid, memcg);
> +	rcu_read_lock();
> +	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
> +	ret = list_lru_add(lru, item, nid, memcg);
> +	rcu_read_unlock();

We don't need rcu_read_lock() to evaluate NULL.

	memcg = NULL;
	if (list_lru_memcg_aware(lru)) {
		rcu_read_lock();
		memcg = mem_cgroup_from_slab_obj(item);
		rcu_read_unlock();
	}

Seems worthwhile?



