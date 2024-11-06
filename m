Return-Path: <linux-kernel+bounces-398183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C59BE7B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AA0283F07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE71DF25B;
	Wed,  6 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="InCqEwsK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC791DE8B4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895410; cv=none; b=URfUblpg6/UVfz5m1VzALg49bl0i587vicp3HOVoHgtOZjX7N6LunGnES2V827kp3mRKCug1cgPxo0J9GkcFpOOF8RxLgmDzTX4Ge1vBuy01BnZT+kw1U12npcdrupvoRTk4EEHLGK3lybOVwEszeMLhXqZEXk6CFp0goK9izoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895410; c=relaxed/simple;
	bh=YcPzdGaKdcvEymYoNrWt7jy2/at2jPjvCWmCyoiUoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcjG2ouMm9TziKaG+fBrEA1RtQ9YeWB7A8O9Hg/JpNoDRth+gi8R0fF+E5PLT3s0yfslFFDtRLHZhkuikzex+bRJ0Ghf9sCOtfZKDbJruXcb6WHSSXl8SrpjR7SW8AFGntu8lpH9OXBOx1T+mMdwFw7gdOMAUEJEUTrZJwzg9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=InCqEwsK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730895405;
	bh=YcPzdGaKdcvEymYoNrWt7jy2/at2jPjvCWmCyoiUoIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InCqEwsK/rdYc8sEiH41VHMK+CnMosqltxkP2dk7/XqgB2rlL2cuiLPnK9SQbgGIl
	 DLUpGEYqTW6WUWsQrwPSUR34bj4UGsOrtwDWfZe8i00yrwu4Lt/ppUm43LXwBU5+eq
	 QnnLZbsThQX7Kre7+pAOh7G/VhKZwvhQTelAUCBBUxsCO2zu9g415CJOtCHdb1u940
	 kCEJFMhjMNTESqjDZ8rFXjTHY2fd1NjS2E8YtTb0eNjzsvUW0yAWfPGC36JHdeI+jN
	 6Q7RHy/h0VyMcjl42leNtnN2gJXkdhEZU8CRrJOdqEz5k5vVur5d0jdqJDs1+K1Z//
	 tGZxVEAMBSC5A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E21E17E3617;
	Wed,  6 Nov 2024 13:16:45 +0100 (CET)
Date: Wed, 6 Nov 2024 13:16:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
Message-ID: <20241106131641.47487624@collabora.com>
In-Reply-To: <20241106120748.290697-1-liviu.dudau@arm.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
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

On Wed,  6 Nov 2024 12:07:48 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Similar to cac075706f29 ("drm/panthor: Fix race when converting
> group handle to group object") we need to use the XArray's internal
> locking when retrieving a pointer from there for heap and vm.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 3796a9eb22af2..fe0bcb6837f74 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>  	return ret;
>  }
>  
> +static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)

struct pathor_heap_pool does not exist :-).

> +{
> +	struct panthor_heap *heap;
> +
> +	xa_lock(&pool->xa);
> +	heap = xa_load(&pool->xa, id);
> +	xa_unlock(&pool->va);

Access to panthor_heap_pool::xa is protected by the external
pathor_heap_pool::lock, so taking the xa lock seems redundant here. How
about adding a lockdep_assert_held(pool->lock) instead?

> +
> +	return heap;
> +}
> +
>  /**
>   * panthor_heap_return_chunk() - Return an unused heap chunk
>   * @pool: The pool this heap belongs to.
> @@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
>  		return -EINVAL;
>  
>  	down_read(&pool->lock);
> -	heap = xa_load(&pool->xa, heap_id);
> +	heap = panthor_heap_from_id(pool, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
>  		goto out_unlock;
> @@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  		return -EINVAL;
>  
>  	down_read(&pool->lock);
> -	heap = xa_load(&pool->xa, heap_id);
> +	heap = panthor_heap_from_id(pool, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
>  		goto out_unlock;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 8ca85526491e6..8b5cda9d21768 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>  {
>  	struct panthor_vm *vm;
>  
> +	xa_lock(&pool->xa);
>  	vm = panthor_vm_get(xa_load(&pool->xa, handle));
> +	xa_unlock(&pool->va);
>  
>  	return vm;
>  }


