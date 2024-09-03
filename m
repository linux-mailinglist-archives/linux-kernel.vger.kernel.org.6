Return-Path: <linux-kernel+bounces-312666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D096998A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D91C232F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40341A3036;
	Tue,  3 Sep 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwfzR2SJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9vagBQZ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720F1A0BF9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357176; cv=none; b=Txk14ChrSXAnhro18yjYAJ683pHHYOAWknUBAGQ4Mg54Bq/F94Qj+rdrXZx6QNxYFfrx9I5tkwOWAPU5eKRQtu+gMo9kdGLUCuqs3jUy74ieq234Ohx6zpJ73Cc9km7P8IDlqCEr+hAqHXnoUV84+6GY7T6bVGBmkfVHkomcGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357176; c=relaxed/simple;
	bh=gtayTF3sA8wEN49SEHOYJZvrQsGyFRuWxNuVYbjx7CI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=JGPXvGmz/Iikw7rAwB/7qUBE7+MY/c1xxc0v5M7dSX6Vtx3vQMv+MaMfwbszzwdt5cKGX5IvXi3/lbNymT5ngCRmsL9r1Wfy7QiNPkSvX5yKS0g4Q3Pwm+wg2zmYVUWQyaFvkHYQ7RhnsfDy6xuPt9VkgrUBOyy+cseuXSj4DW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwfzR2SJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9vagBQZ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725357173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Kk1WtdfF/T6Yblr31h6m+g/ge61PN6u9qopwOXRrloo=;
	b=ZwfzR2SJV/v5pRy5VOnBEh/5TRcTBmKrlBRTVRLeuxBLHAyhwwhswlJaX4iNMNh2kNl31e
	J7j4uuQKrLT7yIrwQ7SAVToJDxBdaQcy+BtvuI80j/wMd38V9SvZcWPIs73J3o6oDE1S8K
	+XOOm/gm8kHzDj1miFcLMkAy8soJU5I3UwUr/6N78axu2YXXmYq+WM9q4ohOX9DzrRIoCu
	DflSLeNmCNmAGRXTYdmdBr7dF7ZC8n+17Xybe2f6htJsGtJvkZHxMLi1MXjhjqhighXJ+S
	RekTo+LQGTxfm/c3d5rMXxgDbHeu75YLVIe9deQgISLjMyvyeh7thasXo26ocQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725357173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Kk1WtdfF/T6Yblr31h6m+g/ge61PN6u9qopwOXRrloo=;
	b=9vagBQZ4gEVvFfk4ddSqjl7pBq/NL8+0mlMZYRy8PytOU21dOWWwkZnrgOqzk/ECQW5F/2
	LamD+MtAJwRoA2CQ==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 3/5] debugobjects: Don't start fill if there are
 remaining nodes locally
In-Reply-To: <20240902140532.2028-4-thunder.leizhen@huawei.com>
Date: Tue, 03 Sep 2024 11:52:52 +0200
Message-ID: <87o75583nv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:

> If the conditions for starting fill are met, it means that all cores that
> call fill() later are blocked until the first core completes the fill
> operation. But obviously, for a core that has free nodes locally, it does
> not need to be blocked. This is good in stress situations.

Sure it's good, but is it correct? You need to explain why this can't
cause a pool depletion. The pool is filled opportunistically.

Aside of that the lock contention in fill_pool() is minimal. The heavy
lifting is the allocation of objects.

> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index aba3e62a4315f51..fc8224f9f0eda8f 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -130,10 +130,15 @@ static void fill_pool(void)
>  	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	struct debug_percpu_free *percpu_pool;

Please keep variables in reverse fir tree order.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
  
>  	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
>  		return;
>  
> +	percpu_pool = this_cpu_ptr(&percpu_obj_pool);

You don't need the pointer

> +	if (likely(obj_cache) && percpu_pool->obj_free > 0)

	if (likely(obj_cache) && this_cpu_read(percpu_pool.obj_free) > 0)

This lacks a comment explaining the rationale of this check.

Thanks,

        tglx



