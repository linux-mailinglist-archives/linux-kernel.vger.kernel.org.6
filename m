Return-Path: <linux-kernel+bounces-353259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A049992B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FDC283E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB61D278B;
	Mon,  7 Oct 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oiZ0Beg4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CrDJK1M0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110061D14EF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303319; cv=none; b=euUiJhw4KiCMZzeRf8tIyjfV3tHbRokrZCTuSsEr1KShnT42u/NZT9KDFJast9mG0GAmURUtNnExTsJR16vRXO4x4H6NGIsdH8/xYAn1tmjxn4yuQKQEoaqVNj60/Zs+hBjV9+26UturUNl1PEcPLUVK4fMnki+qxduvZN0Bkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303319; c=relaxed/simple;
	bh=9iVYFEq1ykxjFt9FNfnm2ItAHCxT85pRANw5sv3iG/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFEPh9dyY4sZa0PsvGqE8a56mxTkfV6VEFOQojAA+6OxiRCyKYZdzarDkDtMbhoHHdAqsqzXVzQEUfL0iS7NGBnIYdQBbnGXpJ/9rdrk8MmYZg4g7pniy47RHKYM7n10q7KhTEMqccxuNHQ42umw+/kA2n0cFggzFTDGPGuYdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oiZ0Beg4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CrDJK1M0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728303315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khy/Vpb3Cpqoid98/sKAjjeRZJEkCQjeQ965viyeid8=;
	b=oiZ0Beg44ouJADTmTIfa1EhUMQXX+7SvIT33gvQNKTqoLvu5WEMGO075qqyZgjlgcUZp8f
	zkiJ4JIP0VyxUa6lztIS0ssGHCcxzbzRTZPbatZPvT5tChurHCu98oSgKO67BApgIX9sT8
	EfZdBW4YIg6yq+BvlP8kofCkBYOiJQG/MzR5jtzFrR3aJautYSHQIV7F/57uYr8Mex4wmJ
	KOPHO4jtJ4Be852tsblyHMXcqe/FT3vbfualPOLA8kA8smgzbLS8VHmNCS4IsmB8SRiyyD
	Z/lCDwiWGiVU3GFLvN1EODApFYp1k8EnAC9DfrUgHaAhbti9YgPx4ywRNENZHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728303315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khy/Vpb3Cpqoid98/sKAjjeRZJEkCQjeQ965viyeid8=;
	b=CrDJK1M0Bmd/nvjoSSlu9+8j+gxZt0IP91jMPzDTdIeRhLFyInKL/WJbjCGJzkk+IaoLmF
	KROOAzCkRmw//WAg==
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>,
 Chunyu Hu <chuhu@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] locking/rtmutex: Always use trylock in
 rt_mutex_trylock()
In-Reply-To: <20241002190108.1115386-1-longman@redhat.com>
References: <20241002190108.1115386-1-longman@redhat.com>
Date: Mon, 07 Oct 2024 14:15:14 +0200
Message-ID: <87y130t8h9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 02 2024 at 15:01, Waiman Long wrote:
> One reason to use a trylock is to avoid a ABBA deadlock in case we need
> to use a locking sequence that is not in the expected locking order. That
> requires the use of trylock all the ways in the abnormal locking
> sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
> it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock.
>
> There are just a few rt_mutex_trylock() call sites in the stock kernel.
> For PREEMPT_RT kernel, however, all the spin_trylock() calls become
> rt_mutex_trylock(). There are a few hundreds of them. So it will be a lot
> easier to trigger a circular locking lockdep splat like the following.
>
> [   63.695668] -> #0 (&lock->wait_lock){-...}-{2:2}:
> [   63.695674]        check_prev_add+0x1bd/0x1310
> [   63.695678]        validate_chain+0x6cf/0x7c0
> [   63.695682]        __lock_acquire+0x879/0xf40
> [   63.695686]        lock_acquire.part.0+0xfa/0x2d0
> [   63.695690]        _raw_spin_lock_irqsave+0x46/0x90
> [   63.695695]        rt_mutex_slowtrylock+0x3f/0xb0
> [   63.695699]        rt_spin_trylock+0x13/0xc0
> [   63.695702]        rmqueue_pcplist+0x5b/0x180
> [   63.695705]        rmqueue+0xb01/0x1040
>      :
> [   63.695840] other info that might help us debug this:
> [   63.695840]
> [   63.695842] Chain exists of:
> [   63.695842]   &lock->wait_lock --> &p->pi_lock --> &rq->__lock
> [   63.695842]
> [   63.695850]  Possible unsafe locking scenario:
> [   63.695850]
> [   63.695851]        CPU0                    CPU1
> [   63.695852]        ----                    ----
> [   63.695854]   lock(&rq->__lock);
> [   63.695857]                                lock(&p->pi_lock);
> [   63.695861]                                lock(&rq->__lock);
> [   63.695864]   lock(&lock->wait_lock);
> [   63.695868]
> [   63.695868]  *** DEADLOCK ***
>
> Fix it by using raw_spin_trylock_irqsave() instead.
>
> Fixes: 23f78d4a03c5 ("[PATCH] pi-futex: rt mutex core")
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

