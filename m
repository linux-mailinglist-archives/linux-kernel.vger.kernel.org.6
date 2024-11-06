Return-Path: <linux-kernel+bounces-398295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7359BEF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89AE1F24C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D61F9AB3;
	Wed,  6 Nov 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YS1eG0Gt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48601F9AB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900051; cv=none; b=MD0EUcc5x22R3Tp/R+V/Qu6BRUNGR18aJLEOoxDCjVrSuNeTj+UHZHH99OcCxq6P/enuHZVq2Q6oi9Ww70tkfM/rw3vOVqPp6LSuEDlKF6kuZlkbeUPyNSNpzE0B13KXJ1qtspWNVetLkbX3L+G+2vurqyHUGjBWQgIvedFy3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900051; c=relaxed/simple;
	bh=Yoiib6vdS/6XzN748mEm3NNl4q2ZfiIBbJS6Rd27i68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo4lv8LJEePX/PqHr4/KG8hX43Yb9A5QYIIacWUroi5Cz7t/FD9cm8+yy5ZSIXgf1L6ODGFcJmZ8QiW896gq29J/s0aeSY9v+YDHqv+eMwXEHXIhXt+Jd4KP1nHfwABjP4MwewGO0iAh+VVIdRxy6307+kSzvEkLHOqSJ50Nwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YS1eG0Gt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730900047;
	bh=Yoiib6vdS/6XzN748mEm3NNl4q2ZfiIBbJS6Rd27i68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YS1eG0GtUvzbbS4IBnQChLBo/+zO4bierMMTnvDriQBpvvug/5UWq5dPazREfgcMl
	 +zv+tpMZPy8zlxAip5qkEnH2fN5LTWs9aH3oYVBicE/a4lnCG5XjLH6HN3az6dICI2
	 z+KOHQvcw9Fuhlou8fh5HXjLzRtPok2INiS3PWTbyK7UMh+Mq9L+V9okSi+tovJg2Q
	 ssUpboxoL8rqHyGX6KK3WIWYMAxAacU10LQQQyRRVQ8/Gc1VbWLNxUk+No1pBHLP+n
	 RDffxRKkIYgMX1L34oPzpAVhqLie7LEz7z4Jx04SmMNfALXsqjsMFzTkJNDliNTsua
	 KkUfuhT7c5bng==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 63DFA17E3638;
	Wed,  6 Nov 2024 14:34:07 +0100 (CET)
Date: Wed, 6 Nov 2024 14:34:02 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
Message-ID: <20241106143402.4bbaea96@collabora.com>
In-Reply-To: <20d75e2c-c5a5-48c3-ac99-a9e15f19b872@arm.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
	<20d75e2c-c5a5-48c3-ac99-a9e15f19b872@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 13:17:29 +0000
Steven Price <steven.price@arm.com> wrote:

> On 06/11/2024 12:07, Liviu Dudau wrote:
> > Similar to cac075706f29 ("drm/panthor: Fix race when converting
> > group handle to group object") we need to use the XArray's internal
> > locking when retrieving a pointer from there for heap and vm.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
> >  drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> > index 3796a9eb22af2..fe0bcb6837f74 100644
> > --- a/drivers/gpu/drm/panthor/panthor_heap.c
> > +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> > @@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
> >  	return ret;
> >  }
> >  
> > +static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
> > +{
> > +	struct panthor_heap *heap;
> > +
> > +	xa_lock(&pool->xa);
> > +	heap = xa_load(&pool->xa, id);
> > +	xa_unlock(&pool->va);
> > +
> > +	return heap;
> > +}  
> 
> This locking doesn't actually achieve anything - XArray already deals
> with the concurrency (with RCU), and if we're doing nothing more than an
> xa_load() then we don't need (extra) locking (unless using the __
> prefixed functions).
> 
> And, as Boris has pointed out, pool->lock is held. As you mention in
> your email the missing bit might be panthor_heap_pool_release() - if
> it's not holding a lock then the heap could be freed immediately after
> panthor_heap_from_id() returns (even with the above change).

Hm, if we call panthor_heap_from_id(), that means we have a heap pool to
pass, and incidentally, we're supposed to hold a ref on this pool. So I
don't really see how the heap pool can go away, unless someone messed
up with the refcounting in the meantime.

> 
> Steve
> 
> > +
> >  /**
> >   * panthor_heap_return_chunk() - Return an unused heap chunk
> >   * @pool: The pool this heap belongs to.
> > @@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
> >  		return -EINVAL;
> >  
> >  	down_read(&pool->lock);
> > -	heap = xa_load(&pool->xa, heap_id);
> > +	heap = panthor_heap_from_id(pool, heap_id);
> >  	if (!heap) {
> >  		ret = -EINVAL;
> >  		goto out_unlock;
> > @@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
> >  		return -EINVAL;
> >  
> >  	down_read(&pool->lock);
> > -	heap = xa_load(&pool->xa, heap_id);
> > +	heap = panthor_heap_from_id(pool, heap_id);
> >  	if (!heap) {
> >  		ret = -EINVAL;
> >  		goto out_unlock;
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 8ca85526491e6..8b5cda9d21768 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
> >  {
> >  	struct panthor_vm *vm;
> >  
> > +	xa_lock(&pool->xa);
> >  	vm = panthor_vm_get(xa_load(&pool->xa, handle));
> > +	xa_unlock(&pool->va);
> >  
> >  	return vm;
> >  }  
> 


