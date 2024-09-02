Return-Path: <linux-kernel+bounces-310932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8D968300
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2131C22252
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8E1C2DBD;
	Mon,  2 Sep 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDzoTJ3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvDkMwI6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E327187355
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268875; cv=none; b=qmnC+awVK0a5rwNPU6yssLCMcunYA1/fHzUH5mbbZINHVcp49gQYgG1w3QKb1kuZENzax8ANo9eQAIlqPMMIrQd6Ye8wSHVA/MX9OiwFazQfS8mHYok1jIRjHkmNl2LlhnNhtRs7gn8pDY0VEYpph91M1Ls20kqCrZDA1kGdPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268875; c=relaxed/simple;
	bh=P3RFR3w9OGKb7/aT/u9MBYytXXSbIUzoU/rnrYfruag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMwqmYRJFdMmdktI94RPOB9fPIyijR63wbm9lT/LxfH6r26ocwD6D0UaBFDP1f5vcxucgazQmEAd7MUwDgZHous7iZCY8wEcF2Tg779t7WDQsUAKfW3y6V4+u/3C5EV5JSt28wTSZQ/KKN3Ji/jnQSyRf9iwvCmwYhOx8dZNtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KDzoTJ3F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvDkMwI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725268872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJ86gMHAl9kksvHdXlVMp+lrI2MsRBPUc3qEVfL37o=;
	b=KDzoTJ3FNcFB3d3MAotEbymvq/O70JY1KKTQv4NKvjyG9v+kxY/hyAV5UWWSaQnUs/JwiV
	ph7HwtT/0UgfPAm5ATCFt7jV6Ouska+u1r1TrFCjBiuMxPJ1uyTVXDJ//is6tfd4TBiazz
	yyBojNtQDiCCC9sTHvu00CQEv10CUwKLFUjdi/7FzXb6l6Te/JR7/zLL5wR/V5Q/yYCv+r
	iWZShThdkM0AgXJ4nXqSUb09QTQuuObVAAuY3hhHXonGIU3s8Ubt9ZxLlQajNkSJoDwqIQ
	a3n9t2JkabQm/cUhCZLbk6hIa5UoMAZcvQd8DMl5Yqj27vQXZaHc/VgbAxcfQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725268872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJ86gMHAl9kksvHdXlVMp+lrI2MsRBPUc3qEVfL37o=;
	b=GvDkMwI6i5ETQ35y27uKoJdpLQsmdPxSSwCiNfFTkoBp7h/iQgVd0Ayu1t6M8Xtx/cEd5s
	hp2WFo2A6vOR48BQ==
To: Xingyu Li <xli399@ucr.edu>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in __free_object
In-Reply-To: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
References: <CALAgD-7TsMdA7rjxfpheXc=MNqikEXY9TZNxJt4z9vm6Yfs5qQ@mail.gmail.com>
Date: Mon, 02 Sep 2024 11:21:11 +0200
Message-ID: <87frqi76ns.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 28 2024 at 16:27, Xingyu Li wrote:
> We found a bug in Linux 6.10 using syzkaller. It is possibly a null
> pointer dereference  bug.
> The reproducer is
> https://gist.github.com/freexxxyyy/5aefd53c6567415e9fe8c76cc2ad390c

Reproducer alone is not really helpful. This needs the corresponding
kernel config, the exact kernel version and a description of the
reproduction environment (compiler, qemu command line ....)

It does not reproduce here at all.

Also if it really reproduces, then have you checked against current
mainline as well?

> RIP: 0010:hlist_add_head include/linux/list.h:1032 [inline]
> RIP: 0010:__free_object+0x903/0xaa0 lib/debugobjects.c:396
>  __debug_check_no_obj_freed lib/debugobjects.c:994 [inline]
>  debug_check_no_obj_freed+0x135/0x530 lib/debugobjects.c:1019
>  slab_free_hook mm/slub.c:2163 [inline]
>  slab_free_freelist_hook mm/slub.c:2225 [inline]
>  slab_free_bulk mm/slub.c:4462 [inline]
>  kmem_cache_free_bulk+0x1bf/0x360 mm/slub.c:4676

The code in question is serialized against objpool modifications with
pool_lock. So nothing can change any of the related data.

    if (obj_pool_free > debug_objects_pool_size &&
        obj_nr_tofree < ODEBUG_FREE_WORK_MAX) {

	for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
		obj = __alloc_object(&obj_pool);
		hlist_add_head(&obj->node, &obj_to_free); <- fail

debug_objects_pool_size is initialized to:

        ODEBUG_POOL_SIZE + num_possible_cpus() * ODEBUG_BATCH_SIZE;
=
        1024 + num_possible_cpus() * 16

The minimum size is 1040, so there are at least 1040 objects in
obj_pool. The loop allocates at max 16 objects, which means

             __alloc_object(&obj_pool);

is guaranteed to return an object and cannot return NULL.

So the only reason why this can result in a NULL pointer dereference is
that the obj_to_free list is corrupted. No idea how that should happen.

Maybe some proper reproducer instructions shed some light to it.

Thanks,

        tglx





