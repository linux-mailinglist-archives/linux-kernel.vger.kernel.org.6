Return-Path: <linux-kernel+bounces-384872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567989B2FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127F3283A47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7E1DD0D4;
	Mon, 28 Oct 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EknHbNqn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gP4HL/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF91DCB31
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116959; cv=none; b=ja/q1eQsfvgvRP+cpi3LFjJHUI9CNpyVQSfOcINSs3a+9L9lSBrALt9BAeaLKu/ZMQvenu5zZmrncj7X0IrqLrpD0kUgIZsa6AkWyRg/bHiz2UM8sF04wlX/ib0eckWecvpxFVYm/6yV5bDBzsng8rYVf6jxROd6goYSr0Hq7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116959; c=relaxed/simple;
	bh=k3olxv1tNh+MggceAkYKS681qjKtbDa2M3Xznyfncwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dQ9lMOg5Hn1y3WyXqn1IlWy8ZEcwaHWCDRoQlBhPMTEQDk5dIJ4M6uBR/GtLf3blzdTc/ijhpIzYDHAhQ2VU6D19Nl1MbfeYp11lupTq57WzhChQQhxk3NOILHt0z/JhjyyWwj4yUHQBU896jFZTNyIs1JHPC5pIgue+NXl6bJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EknHbNqn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gP4HL/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730116955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/ASPJ/e9WpdqXmRwc5Z0H41G8F06EXGHTsc/4MbIzQ=;
	b=EknHbNqnFlGWNW+Cs7RiJY/4lTeW/aXxzTPCA8vRA9JlFdGBWrDpb0o1Aop+B9sFk140h2
	vp6z5y2GMfBgdwVa1sxHjr6zEeW6ozdXsuY/0p8bFoaN5emKgARwUYJ+nQbVeqW4OMTyXn
	jwhvbcjX4zZGo16WD524LTgh5r95Eo1Srlm+EgCssfHgjryvEVr6C7FnZzCokwPFScTTBd
	cY06vNlyOpdsmBlF6prapHK3EC5b3SrTIdorIl2d/ypPA2Qll07BNt3hidnenDRDh2Uz1e
	jmrUUbcs3DL90e9KWWvl38CgbCZpa2zpeTjPcPI9rFv6b9nZDcP2ELVe8mvYhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730116955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/ASPJ/e9WpdqXmRwc5Z0H41G8F06EXGHTsc/4MbIzQ=;
	b=0gP4HL/nj5I67GwZVXOSUjmUtulwYx2RLMAWlXCo0voSWiIdYW3UuzBLgr8CjdkEdhiiCB
	Pa0UbN6mKER3xhDQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
In-Reply-To: <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de> <87cyjl4u1h.ffs@tglx>
 <20241028103058.tERYBWZu@linutronix.de> <87y128335h.ffs@tglx>
 <20241028110035.GQ9767@noisy.programming.kicks-ass.net>
Date: Mon, 28 Oct 2024 13:02:34 +0100
Message-ID: <87r080306d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 12:00, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 11:58:18AM +0100, Thomas Gleixner wrote:
>> > Let me post v2 the signal_struct and then think about auto ON.
>> 
>> It only affects actual futex users. A lot of executables never use
>> them. For ease of testing, can you please make this automatic so there
>> is no need to modify a test case?
>> 
>> Aside of that for RT we really want it automatically enabled and as
>> Linus suggested back then probably for NUMA too.
>> 
>> Stick a trace point or a debugfs counter into the allocation so you can
>> observe how many of those are actually allocated and used concurrently.
>
> Ideally it would re-hash and auto-scale to something like 4*nr_threads,
> but I realize that's probably a pain in the arse to make happen.

That's what we did with the original series, but with this model it's
daft. What we maybe could do there is:

private_hash()
   scoped_guard(rcu) {
      hash = rcu_dereference(current->signal->futex_hash);
      if (hash && rcuref_get(&hash->ref))
         return hash;
   }

   guard(spinlock_irq)(&task->sighand->siglock);
   hash = current->signal->futex_hash;
   if (hash && rcuref_get(&hash->ref))
       return hash;
   // Let alloc scale according to signal->nr_threads
   // alloc acquires a reference count
   ....

And on fork do the following:

   scoped_guard(spinlock_irq, &task->sighand->siglock) {
      hash = current->signal->futex_hash;
      if (!hash || hash_size_ok())
   	return hash;

      // Drop the initial reference, which forces the last
      // user and subsequent new users into the respective
      // slow paths, where they get stuck on sighand lock.
      if (!rcuref_put(&hash->ref))
        return;

      // rcuref_put() dropped the last reference
      old_hash = realloc_hash(hash);
      hash = current->signal->futex_hash;
   }
   kfree_rcu(old_hash);
   return hash;

A similar logic is required when putting the last reference

futex_hash_put()
{
   if (!rcuref_put(&hash->ref))
      return;

   scoped_guard(spinlock_irq, &task->sighand->siglock) {
      // Fork might have raced with this
      if (hash != current->signal->futex_hash)
      	 return;
      old_hash = realloc_hash(hash);
   }
   kfree_rcu(old_hash);  
}

realloc_hash(old_hash)
{
   new_hash = alloc():
   if (!new_hash) {
      // Make the old hash alive again
      rcuref_init(&old_hash->ref);
      return NULL;
   }
   rehash(old_hash, new_hash);
   rcu_assign_pointer(current->signal->new_hash);
   return old_hash;
}

Or something like that. On the usage site this needs

   // Takes a reference count on the hash
   hb = futex_hash(key);

   lock(hb);
   queue();
   unlock(hb);
   futex_hash_put(hb);

which means, after the put @hb is not longer valid as the rehashing
might happen right in the put or afterwards. That needs some auditing of
the usage sites, but that should work. Whether it's worth it is a
different question.

Thanks,

        tglx

