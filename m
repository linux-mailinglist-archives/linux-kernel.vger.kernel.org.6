Return-Path: <linux-kernel+bounces-316756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8496D3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C55B236E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B5197A76;
	Thu,  5 Sep 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+76Tc0p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGc6qLrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B2194A60
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529444; cv=none; b=caXAzLXt0DIo0dXhhQ/EkxV6ddHuIltVy6bTzxB3pKc6WLZVCRgh0Hr+iL3LcjC5wvO62+Jx7M04ifQvuqbZYv53UfvuLTdS26/KClSE9EZOdArlL2kDNCEH+uXAjLCAHLQZhXVlD89MQ4Ii+/J+LOcZvEzUk8LN6q/8yvrK7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529444; c=relaxed/simple;
	bh=/+5Ir2qR7DAHix3vVFkloTNiSLp5hIZ8mPlUOywN+ro=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwG7Nqz+seUopCtG6MevJ2isS9VjkZlL/Oz9r9hSFHHc0yKEsSuSw95dg0HAXqs+RcjvC1MFd8s5bfAIhmbIZOrS5z3aB1W11lEzTN6+DMYoM4T0iGNw+LG89IY+ZNUwJNcfT6pdoIU0BjtZxGHAJTaZXqx4KP+MiZTwiU1veS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j+76Tc0p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGc6qLrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725529441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vySEVyZksmhetz9aJy8k2MADB2njmAgN/TaKQJGQntI=;
	b=j+76Tc0pAAqTn2d3fLNKkcnE3/EiWknw8v0K5Xr5KFzya4Vde36HET+OlthPx3BH1VVd7f
	fGOBBPCwCYNFClkuv0aIpob+euc/b4xWJgg3YyM8Nur7cxj3Vs7UAa3S7u1t+bYiHWmsSb
	2EDkLV93SsGrI2+KwxjkYGGVVrpeNHpoPrdtIN24c3G6g376EPXHvKsnA0rML9mEwde74+
	5O1AbchW1+cp9200J8e5JduQPT0GM+jfR8epcKxL//8JlzVsJ+gvZoEcXEU7i0oRCSt3ZY
	Q1ovLaZArZa3yMf3y1uGKgd3M8H7FGIkvfZ2PfS4h5U9w3Aw9pBa9JGC0UVqrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725529441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vySEVyZksmhetz9aJy8k2MADB2njmAgN/TaKQJGQntI=;
	b=mGc6qLrYMXKxPI4j2flvBp2bMng8WPSnwkTzfTfwyZVSMArgJIR0CMemv+qyNlfPEz931u
	9RqqloIWvxMf86AQ==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>,
 mcgrof@kernel.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
Date: Thu, 05 Sep 2024 11:44:00 +0200
Message-ID: <87a5gm5tb3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 05 2024 at 11:34, Jinjie Ruan wrote:
> On 2024/9/4 16:51, Thomas Gleixner wrote:
>> Can you spot the problem?
>
> It seems that it is not the memory leak source,

That's possible, but the code in there is definitely incorrect when
pci_register_driver() fails. Simply because module->exit() is not
invoked when module->init() fails.

> but with the Link patch, the problem solved and the memory leak missed.

Sure, but the change log of this patch is not really helpful at all and
you sent me a gazillion of leak dumps, but failed to explain what the
actual failure scenario is.

So without a coherent description how to reproduce this issue there is
not much I can do than looking at the code. The amdgpu init() function
was an obvious candidate, but there seems to be some other way to cause
that problem.

Now you at least provided the information that the missing cleanup in
the init() function is not the problem. So the obvious place to look is
in the module core code whether there is a failure path _after_
module->init() returned success.

do_init_module()
        ret = do_one_initcall(mod->init);
        ...
	ret = module_enable_rodata_ro(mod, true);
	if (ret)
		goto fail_mutex_unlock;

and that error path does _not_ invoke module->exit(), which is obviously
not correct. Luis?

I assume that's not the problem when looking at the change log of that:

 https://lore.kernel.org/all/20221112114602.1268989-4-liushixin2@huawei.com/

> Following the rules stated in the comment for kobject_init_and_add():
>  If this function returns an error, kobject_put() must be called to
>  properly clean up the memory associated with the object.
> 
> kobject_put() is more appropriate for error handling after kobject_init().

Why? The rules are exactly the same, no?

> And we can use this function to solve this problem.

Which function and which problem?

> For the cache created early, the related sysfs_slab_add() is called in
> slab_sysfs_init(). Skip free these kmem_cache since they are important
> for system. Keep them working without sysfs.

Let me try to decode this. I assume that sysfs_slab_add() fails after
kobject_init_and_add() or kobject_init_and_add) itself fails.

So the problem is that there are two ways how this can be invoked:

   1) from slab_sysfs_init() for the kmem_cache instances which have
      been allocated during early boot before sysfs was available.

   2) from kmem_cache_create() after early boot

So what Liu tries to avoid is to invoke kobject_put(), because
kobject_put() would not only free the name (which is what the leak
complains about), but also invoke the release callback, which would 
try to destroy the kmem_cache itself.

That's a problem for the mm people to solve, but that does not make my
observations about the amdgpu init() function and the error path in
do_init_module() moot :)

Thanks,

        tglx



