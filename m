Return-Path: <linux-kernel+bounces-441465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8B9ECEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B032B188477F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4011165F09;
	Wed, 11 Dec 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfUvfzl8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3w8yVhU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D1246339
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927550; cv=none; b=Mkkowj2ciedW42kM7UTdY6jE44EnABj/LVTZ+zBkKwKNAHARFlQwr13uV+3Icyg5IaZcIBUreYiQx2YX1SUf/jIJavNwggSgN82rZkeyRRmkbUu8zILadSho21qDq0oYeLvgz7Sik5eoCa0DbkiCARbzE1n4r0VZSmNxG3p1k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927550; c=relaxed/simple;
	bh=ubreD6o75Obi0At7rCfZ4l8LMVxOvAQSAIrvhbl1NRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSHVc7yE//+vBrafwhWxjHXVqE/r4DeTXvD5YdTGLK0x5UE5ROdhglrdDYsKGAhAcAHWrEz9CCoeGkYfMrgodlE+W9z+TBRqLrzIfkdereEERgpuPrgCiGrqwjV20RURTlVpbWiOoIjP6bKDOZjqIewhX7AnVeSsOh7PViZS7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfUvfzl8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3w8yVhU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733927546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLHi+wfBxGcNACtF1+k3uQkS3DPsMTWdU1cqHleTHL0=;
	b=XfUvfzl8yNaRGytn0DqIltlPD8ctn8VecYapVoFON5dzqoSSYfGipZUaZ4RDVkz0GpE2K1
	cTFu6L73ZHwJXKOC2Yx5Yov1fyWzGuOKCpEGpPDmY9oFuByi+VjbX6tWRDlXWucxJDDbEH
	spo9so76xq+K3ghYmVa5yV9JfiSazy2fL0dm5k3ruPsfeu+uRrN4NO6J78la7JdfLZZu8L
	qR6KsmizgyZxbDaHEjCvQhWjy+ROPZH0Mz012bhxVuL3BKXN4UuVMdKM5Y8wveBYjQkJZv
	6AtnCFwp+g4z8lcQqAT4EGhRhECuuHMNERu08Z7QbtqCPrUBVCEX92lZPE26hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733927546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLHi+wfBxGcNACtF1+k3uQkS3DPsMTWdU1cqHleTHL0=;
	b=i3w8yVhUpNSg9CiWOqr/7BejEAQ9R0Iu5kGsoh2x/Bsq/o74owcZ4lmSF7ri1CYKIIVCXu
	Y+CVpfGIdp2JvlAQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 06/11] futex: Allow to re-allocate the private hash
 bucket.
In-Reply-To: <8734ivcgx7.ffs@tglx>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-7-bigeasy@linutronix.de> <8734ivcgx7.ffs@tglx>
Date: Wed, 11 Dec 2024 15:32:26 +0100
Message-ID: <87msh2b891.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 10 2024 at 23:27, Thomas Gleixner wrote:
> Why does unqueue() work w/o a hash bucket reference?
>
> unqueue(q)
> {

This actually needs a

        guard(rcu);

to protect against a concurrent rehashing.

> retry:
> 	lock_ptr = READ_ONCE(q->lock_ptr);
>         // Wake up ?
>         if (!lock_ptr)
>                 return 0;
>
>         spin_lock(lock_ptr);
>
>         // This covers both requeue and rehash operations
>         if (lock_ptr != q->lock_ptr) {
>         	spin_unlock(lock_ptr);
>                 goto retry;
>         }
>
>         __unqueue(q);
>         spin_unlock(lock_ptr);
> }
>
> Nothing in unqueue() requires a reference on the hash. The lock pointer
> logic covers both requeue and rehash operations. They are equivalent,
> no?
>
> wake() is not really different. It needs to change the way how the
> private retry works:
>
> wake_op()
> {
> retry:
>         get_key(key1);
>         get_ket(key2);
>
> retry_private:
>         double_get_and_lock(&hb1, &hb2, &key1, &key2);
>         .....
>         double_unlock_and_put(&hb1, &hb2);
>         .....
> }
>
> Moving retry private before the point where the hash bucket is retrieved
> and locked is required in some other place too. And some places use
> q.lock_ptr under the assumption that it can't change, which probably
> needs reevaluation of the hash bucket. Other stuff like lock_pi() needs
> a seperation of unlocking the hash bucket and dropping the reference.
>
> But that are all minor changes.
>
> All of them can be done on a per function basis before adding the actual
> private hash muck, which makes the whole thing reviewable. This patch
> definitely does not qualify for reviewable.
>
> All you need are implementations for hb_get_and_lock/unlock_and_put()
> plus the double variants and a hash_put() helper. Those implementations
> use the global hash until all places are mopped up and then you can add
> the private magic in exatly those places
>
> There is not a single place where you need magic state fixups in the
> middle of the functions or conditional locking, which turns out to be
> not sufficient.
>
> The required helpers are:
>
> hb_get_and_lock(key)
> {
>         if (private(key))
>         	hb = private_hash(key);		// Gets a reference
>         else
>                 hb = hash_bucket(global_hash, key);
>         hb_lock(hb);
>         return hb;
> }
>
> hb_unlock_and_put(hb)
> {
>         hb_unlock(hb);
>         if (private(hb))
>         	hb_private_put(hb);
> }
>
> The double lock/unlock variants are equivalent.
>
> private_hash(key)
> {
>         scoped_guard(rcu) {
>  	       hash = rcu_deref(current->mm->futex.hash);

This actually requires:

     if (!hash)
                return global_hash;

otherwise this results in a NULL pointer dereference, aka. unpriviledged
DoS when a single threaded process invokes sys_futex(...) directly.

That begs the question whether current->mm->futex.hash should be
initialized with &global_hash in the first place and &global_hash having
a reference count too, which never can go to zero. That would simplify
the whole logic there.

Thanks,

        tglx

