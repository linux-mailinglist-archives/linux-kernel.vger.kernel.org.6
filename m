Return-Path: <linux-kernel+bounces-398300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1012F9BEF42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2306B2360C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42D1F9EA7;
	Wed,  6 Nov 2024 13:40:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B138F82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900430; cv=none; b=pYO6qnDv3cXYIFxkdu/Ut9g4VYnce9kvn4yopKmA5WCn09y41YmumH/8P7EZPUeI9i3jADYHEkbkX2qEGbg+DI26oZdTW48cf5MUVm48h6GWgtQQldYTonbxkcFJqjZJLM+wJhGcbAOzHTNR6ngwKNDBXguhvTczuAfZva8MB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900430; c=relaxed/simple;
	bh=K2v6WEkiLImswu3kxx0JbC5b0uCTZfM5kcAOTDLZzmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbqkKw6ETq3nwazECMguZmoAQ1ZO0LYIKwbNhGKlVy283k6KmYgUe4Ztao43uF6zl5W6p/vydagBO+J8lTw4d/ye8PjtPhMzP5aW61BKOaA5gVMv3KPebDNfs6e5zm+R6zDQXw4gyRJuWwczHyJA3MTqL3pPcaITt5B7GzZD3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44AA4497;
	Wed,  6 Nov 2024 05:40:55 -0800 (PST)
Received: from [10.57.91.71] (unknown [10.57.91.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48F823F66E;
	Wed,  6 Nov 2024 05:40:23 -0800 (PST)
Message-ID: <63b14dd5-2049-40e7-b19e-9392efc53ef2@arm.com>
Date: Wed, 6 Nov 2024 13:40:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
 <20d75e2c-c5a5-48c3-ac99-a9e15f19b872@arm.com>
 <20241106143402.4bbaea96@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241106143402.4bbaea96@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2024 13:34, Boris Brezillon wrote:
> On Wed, 6 Nov 2024 13:17:29 +0000
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 06/11/2024 12:07, Liviu Dudau wrote:
>>> Similar to cac075706f29 ("drm/panthor: Fix race when converting
>>> group handle to group object") we need to use the XArray's internal
>>> locking when retrieving a pointer from there for heap and vm.
>>>
>>> Reported-by: Jann Horn <jannh@google.com>
>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>> Cc: Steven Price <steven.price@arm.com>
>>> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
>>>  drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
>>> index 3796a9eb22af2..fe0bcb6837f74 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_heap.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
>>> @@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>>>  	return ret;
>>>  }
>>>  
>>> +static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
>>> +{
>>> +	struct panthor_heap *heap;
>>> +
>>> +	xa_lock(&pool->xa);
>>> +	heap = xa_load(&pool->xa, id);
>>> +	xa_unlock(&pool->va);
>>> +
>>> +	return heap;
>>> +}  
>>
>> This locking doesn't actually achieve anything - XArray already deals
>> with the concurrency (with RCU), and if we're doing nothing more than an
>> xa_load() then we don't need (extra) locking (unless using the __
>> prefixed functions).
>>
>> And, as Boris has pointed out, pool->lock is held. As you mention in
>> your email the missing bit might be panthor_heap_pool_release() - if
>> it's not holding a lock then the heap could be freed immediately after
>> panthor_heap_from_id() returns (even with the above change).
> 
> Hm, if we call panthor_heap_from_id(), that means we have a heap pool to
> pass, and incidentally, we're supposed to hold a ref on this pool. So I
> don't really see how the heap pool can go away, unless someone messed
> up with the refcounting in the meantime.

No I'm not sure how it could happen... ;) Hence the "might" - I'd
assumed Liviu had a good reason for thinking there might be a
race/missing ref.

Really it's panthor_heap_destroy_locked() that we need to consider
racing with - as that can remove (and free) an entry from the XArray. It
might be worth putting an lockdep annotation in there to check that the
lock is indeed held. But the code currently looks correct.

Steve

>>
>> Steve
>>
>>> +
>>>  /**
>>>   * panthor_heap_return_chunk() - Return an unused heap chunk
>>>   * @pool: The pool this heap belongs to.
>>> @@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
>>>  		return -EINVAL;
>>>  
>>>  	down_read(&pool->lock);
>>> -	heap = xa_load(&pool->xa, heap_id);
>>> +	heap = panthor_heap_from_id(pool, heap_id);
>>>  	if (!heap) {
>>>  		ret = -EINVAL;
>>>  		goto out_unlock;
>>> @@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>>>  		return -EINVAL;
>>>  
>>>  	down_read(&pool->lock);
>>> -	heap = xa_load(&pool->xa, heap_id);
>>> +	heap = panthor_heap_from_id(pool, heap_id);
>>>  	if (!heap) {
>>>  		ret = -EINVAL;
>>>  		goto out_unlock;
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> index 8ca85526491e6..8b5cda9d21768 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>>>  {
>>>  	struct panthor_vm *vm;
>>>  
>>> +	xa_lock(&pool->xa);
>>>  	vm = panthor_vm_get(xa_load(&pool->xa, handle));
>>> +	xa_unlock(&pool->va);
>>>  
>>>  	return vm;
>>>  }  
>>
> 


