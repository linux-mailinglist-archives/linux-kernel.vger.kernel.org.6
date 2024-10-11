Return-Path: <linux-kernel+bounces-361372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45E99A757
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072901C224C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF985656;
	Fri, 11 Oct 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="APqqfxJ0"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88795199BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659843; cv=none; b=qXEzXKK2evLeE58U4mzxlqEymHL/lh3W7mOm+x96B1HRR6TmV2DEfOXBNF660a8KhQJ4qNDPWI+qbbTHTuwD9Azkogi3t0zqtWeh/4HnmC6k/8/9N+IdaC5jQfUSPCmt7bxnYpeR9WZwZC6IMEBrlONqcRWrQpypgsUzB42l7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659843; c=relaxed/simple;
	bh=pr8l274nkptFBJhIfSJgQDYSky5pF05lkT4fh+mtwTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhIK6umS4woqyHM3jiuqWUgJVCYDsQpyd4BveUyNuuNcg4JcnM9n8Beefxv3lIxsLyj2xI0OxaUg8B/+dwBuV1TWwxMM31WORF6G834jRHfGQ554x7rha0KGrt42zsXC6rYM26Ov4wthWhvLVJz7DDMChoEEUo4AjiGIcWItumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=APqqfxJ0; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728659839;
	bh=pr8l274nkptFBJhIfSJgQDYSky5pF05lkT4fh+mtwTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=APqqfxJ0CtdltaOIew8TqJLJz8WH6QoUAYHLnrZ/grjtA7VMIhZDkqsthvsvwSTac
	 m68MML/e21NyY2gZQJ4e3ox7Vab3N/FoLe0TZLVVVII6qvAGyd843md1yi3U32zN1/
	 Ac5F82KhMBuJSmzq0cPYpHLokfVqEjdppa/t54KeiXN/22vnVrnvxS64Ll0rJreUGj
	 spJATd0Za07XvssMu4Z6n244ZiGz6gBVRjXYidLz5QCYvxlPPBlY9THF7S12UQLAYk
	 5K48YncoDNRGILzmPpRZ+QXfZxIrKTxNjS6VI+9od46DArbSQdYGqzc/CU1oL+2SSM
	 8HrXFr/qWsMTw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XQ9GR0mJCz12vc;
	Fri, 11 Oct 2024 11:17:19 -0400 (EDT)
Message-ID: <613e258c-e74b-46dc-970b-de9c78672c76@efficios.com>
Date: Fri, 11 Oct 2024 11:15:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Synchronized Shared Pointers for the Linux kernel
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 paulmck <paulmck@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Maged Michael <maged.michael@gmail.com>
References: <8b944c2b-7f89-4d05-afd8-612de852f5dd@efficios.com>
 <ZwhfPS4yyFx_Qrbu@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZwhfPS4yyFx_Qrbu@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-11 01:11, Boqun Feng wrote:
> On Thu, Oct 10, 2024 at 03:16:25PM -0400, Mathieu Desnoyers wrote:
>> Hi,
>>
>> I've created a new API (sharedptr.h) for the use-case of
>> providing existence object guarantees (e.g. for Rust)
>> when dereferencing pointers which can be concurrently updated.
>> I call this "Synchronized Shared Pointers".
>>
>> This should be an elegant solution to Greg's refcount
>> existence use-case as well.
>>
>> The current implementation can be found here:
>>
>> https://github.com/compudj/linux-dev/commit/64c3756b88776fe534629c70f6a1d27fad27e9ba
>>
>> Patch added inline below for feedback.
>>
>> Thanks!
>>
>> Mathieu
>>

[...]

>> + */
>> +static inline
>> +struct sharedptr sharedptr_copy_from_sync(const struct syncsharedptr *ssp)
>> +{
>> +	struct sharedptr_node *spn, *hp;
>> +	struct hazptr_slot *slot;
>> +	struct sharedptr sp;
>> +
>> +	preempt_disable();
> 
> Disabling preemption acts as an RCU read-side critical section, so I
> guess the immediate question is why (or when) not use RCU ;-)

That's a very relevant question indeed! Why use hazard pointers rather
than RCU in this particular use-case ?

You are right that I could add a rcu_read_lock()/rcu_read_unlock()
around sharedptr_copy_from_sync(), and pair this with a call_rcu()
in node_release, which would effectively replace hazard pointers
by RCU.

Please keep in mind that the current implementation of this API
is minimalist. I mean to extend this, and this is where the benefits
of hazard pointers over RCU should become clearer:

1) With hazard pointers, AFAIU we can modify the sharedptr_delete
    and syncsharedptr_delete to issue hazptr_scan() _before_
    decrementing to 0, e.g.

       unsigned int old, new;

       WRITE_ONCE(sp->spn, NULL);
       old = spn->refcount;
       do {
               new = old - 1;
               if (!new)
                       hazptr_scan(&hazptr_domain_sharedptr, spn, NULL);
       } while (!atomic_try_cmpxchg(&spn->refcount->refs, &old, new);
       if (!new)
               sharedptr_node_release(spn);

    And therefore modify sharedptr_copy_from_sync to use a refcount_inc
    rather than a refcount_inc_not_zero, because the reference count
    can never be 0 while a hazard pointer to the object exists.

    This modification would make hazard pointers act as if they
    *are* holding a reference count on the object.

This improvement brings us to a more important benefit:

2) If we increase the number of available hazptr slots per cpu
    (e.g. to 8 or more), then we can start using hazard pointers as
    reference counter replacement (fast-path).

    This will allow introducing a new type of sharedptr object, which
    could be named "thread sharedptr", meant to hold a reference for a
    relatively short period of time, on a single thread, where the thread
    is still allowed to be preempted or block while holding the thread
    sharedptr.

    The per-cpu hazard pointer slots would point to per-thread sharedptr
    structures, which would hold the protected hazard pointer slot.

    When the application means to keep the reference for longer,
    to store it into a data structure or pass it around to another
    thread, then it should copy the thread-sharedptr to a normal
    sharedptr, which will make sure a reference is taken on the
    object.

    The thread sharedptr is tied to the thread using it. Because the
    hazard pointer context would be in a well-defined per-thread area
    (rather than just on the stack), we can do the following when
    scanning for hazard pointers: force the thread sharedptr to promote
    to a reference counter increment on the object, thus allowing the
    hazard pointer scan to progress. This allows freeing up the per-cpu
    slot immediately.

    If all per-cpu hazard pointer slots are used, the thread sharedptr
    would automatically fall-back to reference counter.

    We could even add a per-cpu timer which would track how old are each
    per-CPU hazard pointer slots, and promote them to a reference counter
    increment based on their age if needed.

This would effectively allow implementing a "per-thread shared pointer"
fast-path, which would scale better than just reference counters on large
multi-core systems.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


