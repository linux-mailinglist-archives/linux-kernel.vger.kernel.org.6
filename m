Return-Path: <linux-kernel+bounces-214242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C89081C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4881C21B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190E183095;
	Fri, 14 Jun 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kxcz1kUS"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A46138495
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332867; cv=none; b=uqIpJHgD/HfZdVqov8zTRDbpG3b7T7NmS24WgNKDCkkDicR9wvrDga61EoGIAKk6s4sa8z0G7k2RQDQjcY783n774yEtLMAjGGXCoknWi+i/1aEXhGV05PA9nmVm5ZH+158HE87K1KcGTRLprcT4kMlxopD6p2jlbdA3/sKjqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332867; c=relaxed/simple;
	bh=vT26/j4Dd1UFI9cgKQZMZ4EcZwVL3PZb7gj+N1FRie8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu6DzlNm+3IzScVi8VL42nLVYYH/UQpzKBteuXT0CUUKngds7aL+kuqVDTd9koQ0klKhr4v0Mfdg9j/xtFqHr7GJnW/JZpFXEvc3ctp87WnhC/SI4Z4aU+1DDGCm98a3Gio3nREfpj6oE7YCKq6ym0/gN+p1qZ7gcZJ+QduRu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kxcz1kUS; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: cl@linux.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718332861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDP8QkqOpKi3HPcns5zN8G1TVuK/krfhjPMkmuwufGs=;
	b=Kxcz1kUS0fkwCaOceMft90t1ewiDpACo6h3YKW/j2WAPP4avGFQG2OkaglRdqa/jFHNobI
	z76GooYflJxxh9rp2IAusp2D/S57X9JjZSraBbNMKscpVHnLRui1/cAI7XxhCr6e8AGWRO
	rS7PePNf4/dLfNEwwcj44dqEWZWza9s=
X-Envelope-To: vbabka@suse.cz
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
Message-ID: <e655405f-92b2-46e4-830e-013586bd0022@linux.dev>
Date: Fri, 14 Jun 2024 10:40:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
 Vlastimil Babka <vbabka@suse.cz>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/12 06:52, Christoph Lameter (Ampere) wrote:
> On Mon, 10 Jun 2024, Vlastimil Babka wrote:
> 
>> Even if some security people enable parts of slub debugging for security
>> people it is my impression they would rather panic/reboot or have memory
>> leaked than trying to salvage the slab page? (CC Kees)
> 
> In the past these resilience features have been used to allow the continued operation of a broken kernel.
> 
> So first the Kernel crashed with some obscure oops in the allocator due to metadata corruption.
> 
> One can then put a slub_debug option on the kernel command line which will result in detailed error reports on what caused the corruption. It will also activate resilience measures that will often allow the continued operation until a fix becomes available.

This reminds me that we can't toggle slub_debug options for kmem_cache in runtime,
I'm wondering is it useful to be able to enable/disable debug options in runtime?
We can implement this feature by using per-slab debug options, so per-slab has
independent execution path, in which some slabs with debug options enabled go
the slow path, while others can still go fast path.

No sure if it's useful in some cases? Maybe KFENCE is enough? Just my random thoughts.

Thanks.

