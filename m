Return-Path: <linux-kernel+bounces-441518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A39ECF94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30749286680
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C21ABEA8;
	Wed, 11 Dec 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlebgjVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/vWqZ4Ye"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFD19DF9A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930582; cv=none; b=RuuCmQWFjvUQpifHvSmaKYWSjt13LStudaA8UpZwNuvZZKBAHny7/c1zAyH2JZZDd5VAo9Ds2txv13zVaH1jXB5eeHZZg5UbUZB5ikBzfpR3veYswvTwtTr2MUc01GMYLKGjLHK6tSGoG8zqPljQFGWaaD0NIAI6s93F/DysKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930582; c=relaxed/simple;
	bh=Xp6PccpxMZQUauxwhOm7BIJei7X3vj1q21PzzykdJJ0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RxkwUuyl5QViIgf1HKwzbv63v7ogz0KgP1AkNOmVQIt5ue4zg07G3xDsTD64991/lLx66ItiudNQIoSAIZlv5bGcaztmFHxdy0u+6D9MoIO0XIjly+VZW4XO8V8rnlIlQ9+nO8N4t9oh3qwvOCmhztwGrE/q11MT0002w67Eaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FlebgjVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/vWqZ4Ye; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733930579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMH31e7egWYlqfenAL92kUMfEd/6Q+sgk0cDlcwiVHY=;
	b=FlebgjVsO846SbhG0nf5aj6ZJGpHeATss1YoXQ5kyooDl67dFkC0n7fPp+t/pxwpFH7cBI
	STCSGpIbrrIWFGhka19UEfi8lCMQLbW+xbw8Uq9QMSmStxxT086QBzWO9Cg8pT9sIzPYmS
	e6aqMjAa6QL53e8UeMr5MJvAWkt74mcrSwsEFAt5rcEH5mLarvzklSrRyFf0HmWBkckL+N
	cFYdI07h0fDwpWJJPXWyHM5egydqsG4xBIY8QIyK9QU7k/ftO5hIP/mjdi7cu51u6Ja5vi
	ronwhmMTanjbOPBhKvPksfbaHeAnw4TC+Wlc3cTg3hKJ3V8XoXZ8vyyG/iDuVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733930579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMH31e7egWYlqfenAL92kUMfEd/6Q+sgk0cDlcwiVHY=;
	b=/vWqZ4Ye8aqy4COYwZC3aIkaRa5LO7Qy/5dJJkCKQhIyOpSy6xMXgQwelNhz3l/5qUpi5c
	zUE2Q7mdIB2y7GCA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] futex: Allow to re-allocate the private hash
 bucket.
In-Reply-To: <8734ivcgx7.ffs@tglx>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
 <20241203164335.1125381-7-bigeasy@linutronix.de> <8734ivcgx7.ffs@tglx>
Date: Wed, 11 Dec 2024 16:22:58 +0100
Message-ID: <87jzc6b5wt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 10 2024 at 23:27, Thomas Gleixner wrote:
> On Tue, Dec 03 2024 at 17:42, Sebastian Andrzej Siewior wrote:
> realloc_or_restore_hash()

swap_hash()
{
         old_hash = current->mm->futex.hash;
         new_hash = current->mm->futex.new_hash;

         rehash(new_hash, old_hash);
         rcu_assign_pointer(current->mm->futex.hash, new_hash);
         rcu_free(old_hash);
}

> rehash(new_hash, old_hash)
> {
>         // old_hash is marked dead, so new waiters cannot queue
>         // themself and are stuck on the hash_mutex.
>
>         for (i = 0; i < old_hash->size; i++) {
> 		hb1 = &old_hash->queues[i];
>
>                 // Protect the old bucket against unqueue(), as it does
>                 // not try to get a reference on the hash bucket. It
>                 // solely relies on q->lock_ptr.
>                 spin_lock(&hb1->lock);
>
> 		plist_for_each_entry_safe(q, tmp, hb1, list) {
> 			hb2 = hash_bucket(new_hash, &q->key);
> 			// Nesting is safe as this is a one time operation
>                         spin_lock_nested(&hb2->lock);
>
>                         plist_del(&q->list, &hb->chain);
>
>                         // Redirect the lock pointer to the new hash
>                         // bucket. See unqueue().
> 			q->lock_ptr = &hb2->lock;
>
>                         plist_add(&q->list, &hb->chain);
>                 }
>         }
> }
>
> fork()
> {
>         if (hash_needs_resize()) 
>         	hash_putref(mm->futex.hash);

         futex_validate_hash();


futex_validate_hash()
{
         guard(mutex)();
         if (!hash_needs_resize(mm->futex.hash))
         	return;
         if (mm->futex.new_hash && !hash_needs_resize(mm->futex.new_hash))
         	return;

         new = alloc();
         if (!new)
               return;
         current->mm.futex_new_hash = new;
         if (!rcuput_ref(mm->futex.hash->ref))
               return;

         swap_hash();
}

