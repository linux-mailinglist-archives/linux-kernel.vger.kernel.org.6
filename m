Return-Path: <linux-kernel+bounces-217120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77990AB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9041C241E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03E1946DD;
	Mon, 17 Jun 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ioKneBWz"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1F194147
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620162; cv=none; b=K2OEsvcMh/XeMO0rHayLKboasCxh+XIcQRwy3m2ImoJVSESxIenSixOfA775N7Wm8Gl0IjXfxdHsLaeErosWc4idwP/5gOdP5lKnpf+Cf9lnhAp/PpoFfZQxO6lfZPpkZYzKid8L6qHRA//uroR8qC3J5htMMFFrVLGgy9cyDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620162; c=relaxed/simple;
	bh=mGcaPXqQXuv1XnNzd0WIwHXgF7gtjZdPRxWV1FQafIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj3J8OBSmuB8ZLEQbG6CrFLc344ycucIbyRk2PTpbd8kaVvpauyGnGhhZ7hYV4DN3s29o/Tz+4mOulIgqONnH2mECvsYY1Vek4AJ8HmURo0CjBcJJ9i52xeLGTJwGj3MEjnBmqimN/5NhZn4Oxt+jUdjdodMLKik+Z3dPe3rX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ioKneBWz; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718620156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMMkLXHJEJk5ByM0Fas8t3kBq83vm0c2mSUgof1iK64=;
	b=ioKneBWzylxwpk627whO+6QXjE/SbQubI1siMnUW4JkarSj0eqGHvbfZv2yNT6yC/5oHCl
	39e3TGkZvKonEld+Wv8+oSt750ULINO0OoLGNwiktA6Bqt8fRwJJqdwDTOxM9AKr/M49wk
	FOcbTDh2yTgKyZMT9lCEftT2PCyny+A=
X-Envelope-To: cl@linux.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: keescook@chromium.org
Message-ID: <0c0e0892-8410-4a7a-9f12-23b9cc2ef544@linux.dev>
Date: Mon, 17 Jun 2024 18:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Kees Cook <keescook@chromium.org>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
 <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
 <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
 <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz>
 <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
 <e655405f-92b2-46e4-830e-013586bd0022@linux.dev>
 <7eaee8ce-ad5b-41ea-9eb5-83195f83fd24@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <7eaee8ce-ad5b-41ea-9eb5-83195f83fd24@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/17 17:51, Vlastimil Babka wrote:
> On 6/14/24 4:40 AM, Chengming Zhou wrote:
>> On 2024/6/12 06:52, Christoph Lameter (Ampere) wrote:
>>> On Mon, 10 Jun 2024, Vlastimil Babka wrote:
>>>
>>>> Even if some security people enable parts of slub debugging for security
>>>> people it is my impression they would rather panic/reboot or have memory
>>>> leaked than trying to salvage the slab page? (CC Kees)
>>>
>>> In the past these resilience features have been used to allow the continued operation of a broken kernel.
>>>
>>> So first the Kernel crashed with some obscure oops in the allocator due to metadata corruption.
>>>
>>> One can then put a slub_debug option on the kernel command line which will result in detailed error reports on what caused the corruption. It will also activate resilience measures that will often allow the continued operation until a fix becomes available.
>>
>> This reminds me that we can't toggle slub_debug options for kmem_cache in runtime,
>> I'm wondering is it useful to be able to enable/disable debug options in runtime?
>> We can implement this feature by using per-slab debug options, so per-slab has
>> independent execution path, in which some slabs with debug options enabled go
>> the slow path, while others can still go fast path.
> 
> Many of the debug options change the layout of objects in slabs (i.e. affect
> calculate_sizes()) so it would be very complicated to change things in
Yeah, so each slab in the same kmem_cache can have different layout (caused by
different debug_options enabled), we use these different information to decide
which path each slab should go.

Then the problem is saving these different layout information for each slab,
which has an unused _mapcount to reuse, can be used as index to find its layout
information in the kmem_cache.

I haven't thought too much about this, so must be missing something.

Thanks.

> runtime. Also the cache might be merged with other ones if it boots without
> debug... I don't think it would be feasible at all.
> 
>> No sure if it's useful in some cases? Maybe KFENCE is enough? Just my random thoughts.
>>
>> Thanks.
> 

