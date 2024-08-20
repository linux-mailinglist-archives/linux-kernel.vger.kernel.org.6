Return-Path: <linux-kernel+bounces-293022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D56957849
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2966C285659
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD71DF666;
	Mon, 19 Aug 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVi8UaWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199441D6DA5;
	Mon, 19 Aug 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108307; cv=none; b=JfXiEYB5ZTEvn7uI9I96FxuQf3Y2C9l59CTzSj0Q+N7jWD8zSXg2d37z7gOMQbk+gZaZoM1oeloe3UEwuMuVj9t8Y8Z5/K1oJjBGUgNociahlz8Lg2QVpAuqDqvTtyUvk9//t42tSwdcPUNQAZiCvpjrLjisZN0cyIzjhWNRxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108307; c=relaxed/simple;
	bh=GcU+Oh5rWMM0XkADch5PR7AkxkjOlxdeM4M936G2/RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTc2FMOxT/GEWIGbR9+oG+xlqn0pTgx9CbF5whdKpfBAKioo/Yy/LAR4Q6NbaYFiPNmiK6tJsNDhOrRiA/2VOxDvs7Uzc9PwFIhqVKsK31xeZNCxI+HZXuevThVa8kXSY81jZ96nNP6dEZ9UpHQ0TglSNUd+4pPjDXpgxWDGl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVi8UaWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9351FC32782;
	Mon, 19 Aug 2024 22:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108306;
	bh=GcU+Oh5rWMM0XkADch5PR7AkxkjOlxdeM4M936G2/RM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LVi8UaWGdDacCzIX3PsBEUY7OOw9r7r5E2ckRGZnVV0/cL+jmNhtPiNPklGex1u9b
	 S1ZIohNKnDffkJ1KIxjRZ4I2/JuhE3oadVKkXrMORq0NMnGRH6uaSUXBjKnjlVWmaJ
	 lgAVcZRm3OMXWG+MWtKdcLdkabpu2IGzFDQoGGBSRQej+KjaAB3+PIUi46heJP+eLw
	 0xowWHTDmPW3enkNUp4TeJ6GejMCTaAaQms4BAzNBImqop9AMDdcHdvpSFnD2szoDO
	 UEjPOgPO/nGz8BJsOArQ2wor8ac9XKa0pMqeAI45R7BCu9fYHnlVy6nqVvG+Ju3UZU
	 +geBRxNtYczbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AF5CCE0A01; Mon, 19 Aug 2024 15:58:26 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:58:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org, cl@linux.com, mhocko@kernel.org,
	urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165939.745801-7-kent.overstreet@linux.dev>

I still remain quite skeptical of this one, but it has improved since
June's version.

Responses inline.

							Thanx, Paul

In the meantime, thank you for avoiding reaching into RCU's and SRCU's
innards.  This makes it reasonable to have you put this file into your
code, at least initially.  That way, you get what you want *now* and us
RCU guys are not committing to maintain it before it is ready for us to
do so.

On Mon, Aug 19, 2024 at 12:59:32PM -0400, Kent Overstreet wrote:
> Generic data structure for explicitly tracking pending RCU items,
> allowing items to be dequeued (i.e. allocate from items pending
> freeing). Works with conventional RCU and SRCU, and possibly other RCU
> flavors in the future, meaning this can serve as a more generic
> replacement for SLAB_TYPESAFE_BY_RCU.

I added a few of the slab guys on CC for his thoughts on what would be
required to make slabs typesafe by other forms of RCU.

> Pending items are tracked in radix trees; if memory allocation fails, we
> fall back to linked lists.

I still have strong misgivings about radix trees and cache locality.
Poor cache locality on the other side of the grace period can result
in OOMs during callback-flooding events, hence the move of kfree_rcu()
and friends to pages of pointers.  And, as you note below, radix trees
don't merge nicely.

> A rcu_pending is initialized with a callback, which is invoked when
> pending items's grace periods have expired. Two types of callback
> processing are handled specially:
> 
> - RCU_PENDING_KVFREE_FN
> 
>   New backend for kvfree_rcu(). Slightly faster, and eliminates the
>   synchronize_rcu() slowpath in kvfree_rcu_mightsleep() - instead, an
>   rcu_head is allocated if we don't have one and can't use the radix
>   tree

The advantage of synchronize_rcu() is that it can proceed without
memory allocation.  If you block on allocation, even of a 16-byte
rcu_head structure, you can go into OOM-induced deadlock.

It might well make sense to do an rcu_head allocation with GFP flags
that try reasonably hard, but still allow failure before falling all
the way back to synchronize_rcu().  (And for all I know, this might have
been tested and found wanting, but Uladzislau Rezki (CCed) would know.)
But a hard wait on that allocation is asking for trouble.

>   TODO:
>   - add a shrinker (as in the existing kvfree_rcu implementation) so that
>     memory reclaim can free expired objects if callback processing isn't
>     keeping up, and to expedite a grace period if we're under memory
>     pressure and too much memory is stranded by RCU

There is work underway to make the current callback lists take advantage
of expedited grace periods, transparent to the caller.  This allows
the shrinker (or whatever) to speed up everything by simply invoking
synchronize_rcu_expedited().  This speedup includes callback processing
because it avoids "bubbles" in the callback processing that can occur
when the next grace period has not yet completed, but all callbacks from
earlier grace periods have been invoked.

>   - add a counter for amount of memory pending

As noted earlier, for things like call_rcu() and synchronize_rcu(),
this needs help from the callers of those functions.

> - RCU_PENDING_CALL_RCU_FN
> 
>   Accelerated backend for call_rcu() - pending callbacks are tracked in
>   a radix tree to eliminate linked list overhead.

But to add radix-tree overhead.  And to eliminate the ability to do O(1)
list merges.  Is this really a win?

> to serve as replacement backends for kvfree_rcu() and call_rcu(); these
> may be of interest to other uses (e.g. SLAB_TYPESAFE_BY_RCU users).
> 
> Note:
> 
> Internally, we're using a single rearming call_rcu() callback for
> notifications from the core RCU subsystem for notifications when objects
> are ready to be processed.
> 
> Ideally we would be getting a callback every time a grace period
> completes for which we have objects, but that would require multiple
> rcu_heads in flight, and since the number of gp sequence numbers with
> uncompleted callbacks is not bounded, we can't do that yet.

Doesn't the call from __rcu_pending_enqueue() to process_finished_items()
serve this purpose?  After all, the case that causes trouble is the one
where lots of things are being very frequently queued.

> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/rcu_pending.h |  25 ++
>  kernel/rcu/Makefile         |   2 +-
>  kernel/rcu/pending.c        | 603 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 629 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/rcu_pending.h
>  create mode 100644 kernel/rcu/pending.c
> 
> diff --git a/include/linux/rcu_pending.h b/include/linux/rcu_pending.h
> new file mode 100644
> index 000000000000..a875c640da8d
> --- /dev/null
> +++ b/include/linux/rcu_pending.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RCU_PENDING_H
> +#define _LINUX_RCU_PENDING_H
> +
> +struct rcu_pending;
> +typedef void (*rcu_pending_process_fn)(struct rcu_pending *, struct rcu_head *);
> +
> +struct rcu_pending_pcpu;
> +
> +struct rcu_pending {
> +	struct rcu_pending_pcpu __percpu *p;
> +	struct srcu_struct		*srcu;
> +	rcu_pending_process_fn		process;
> +};
> +
> +void rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *obj);
> +struct rcu_head *rcu_pending_dequeue(struct rcu_pending *pending);
> +struct rcu_head *rcu_pending_dequeue_from_all(struct rcu_pending *pending);
> +
> +void rcu_pending_exit(struct rcu_pending *pending);
> +int rcu_pending_init(struct rcu_pending *pending,
> +		     struct srcu_struct *srcu,
> +		     rcu_pending_process_fn process);
> +
> +#endif /* _LINUX_RCU_PENDING_H */
> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> index 0cfb009a99b9..2582f0324a11 100644
> --- a/kernel/rcu/Makefile
> +++ b/kernel/rcu/Makefile
> @@ -7,7 +7,7 @@ ifeq ($(CONFIG_KCSAN),y)
>  KBUILD_CFLAGS += -g -fno-omit-frame-pointer
>  endif
>  
> -obj-y += update.o sync.o
> +obj-y += update.o sync.o pending.o
>  obj-$(CONFIG_TREE_SRCU) += srcutree.o
>  obj-$(CONFIG_TINY_SRCU) += srcutiny.o
>  obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
> diff --git a/kernel/rcu/pending.c b/kernel/rcu/pending.c
> new file mode 100644
> index 000000000000..c0e2351ba198
> --- /dev/null
> +++ b/kernel/rcu/pending.c
> @@ -0,0 +1,603 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define pr_fmt(fmt) "%s() " fmt "\n", __func__
> +
> +#include <linux/darray.h>
> +#include <linux/generic-radix-tree.h>
> +#include <linux/mm.h>
> +#include <linux/percpu.h>
> +#include <linux/rcu_pending.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +#include <linux/vmalloc.h>
> +
> +#include "rcu.h"
> +
> +#define static_array_for_each(_a, _i)			\
> +	for (typeof(&(_a)[0]) _i = _a;			\
> +	     _i < (_a) + ARRAY_SIZE(_a);		\
> +	     _i++)
> +
> +enum rcu_pending_special {
> +	RCU_PENDING_KVFREE	= 1,
> +	RCU_PENDING_CALL_RCU	= 2,
> +};
> +
> +#define RCU_PENDING_KVFREE_FN		((rcu_pending_process_fn) (ulong) RCU_PENDING_KVFREE)
> +#define RCU_PENDING_CALL_RCU_FN		((rcu_pending_process_fn) (ulong) RCU_PENDING_CALL_RCU)
> +
> +static inline unsigned long __get_state_synchronize_rcu(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? get_state_synchronize_srcu(ssp)
> +		: get_state_synchronize_rcu();
> +}
> +
> +static inline unsigned long __start_poll_synchronize_rcu(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? start_poll_synchronize_srcu(ssp)
> +		: start_poll_synchronize_rcu();
> +}
> +
> +static inline bool __poll_state_synchronize_rcu(struct srcu_struct *ssp, unsigned long cookie)
> +{
> +	return ssp
> +		? poll_state_synchronize_srcu(ssp, cookie)
> +		: poll_state_synchronize_rcu(cookie);
> +}
> +
> +static inline void __rcu_barrier(struct srcu_struct *ssp)
> +{
> +	return ssp
> +		? srcu_barrier(ssp)
> +		: rcu_barrier();
> +}
> +
> +static inline void __call_rcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> +			      rcu_callback_t func)
> +{
> +	if (ssp)
> +		call_srcu(ssp, rhp, func);
> +	else
> +		call_rcu(rhp, func);
> +}

I do sympathize with the desire to provide RCU-variant-oblivious API
members, and maybe SRCU and RCU will be all that is required.  You might
need call_rcu_hurry()?

> +struct rcu_pending_seq {
> +	/*
> +	 * We're using a radix tree like a vector - we're just pushing elements
> +	 * onto the end; we're using a radix tree instead of an actual vector to
> +	 * avoid reallocation overhead
> +	 */
> +	GENRADIX(struct rcu_head *)	objs;

OK, I will bite...  Why not a doubly-linked list of pages of pointers?

Are you encountering situations where page-sized allocations fail,
but smaller allocations proceed nicely?  But that should be rare, and
also should be handledd by your fallback to linked list of rcu_head
structures, right?

> +	size_t				nr;
> +	struct rcu_head			**cursor;
> +	unsigned long			seq;
> +};
> +
> +struct rcu_pending_list {
> +	struct rcu_head			*head;
> +	struct rcu_head			*tail;
> +	unsigned long			seq;
> +};
> +
> +struct rcu_pending_pcpu {
> +	struct rcu_pending		*parent;
> +	spinlock_t			lock;
> +	int				cpu;
> +
> +	/*
> +	 * We can't bound the number of unprocessed gp sequence numbers, and we
> +	 * can't efficiently merge radix trees for expired grace periods, so we
> +	 * need darray/vector:
> +	 */
> +	DARRAY_PREALLOCATED(struct rcu_pending_seq, 4) objs;

This is a big strength of the current linked list of pages: Merging is
trivial.  Then there need only be one list for everything for which a
grace period has completed.

I ran out of time at this point.  I do have additional comments further
down due to searching for things, but this is where I will continue my
review before the end of this week.

> +	/* Third entry is for expired objects: */
> +	struct rcu_pending_list		lists[NUM_ACTIVE_RCU_POLL_OLDSTATE + 1];
> +
> +	struct rcu_head			cb;
> +	bool				cb_armed;
> +	struct work_struct		work;
> +};
> +
> +static bool __rcu_pending_has_pending(struct rcu_pending_pcpu *p)
> +{
> +	if (p->objs.nr)
> +		return true;
> +
> +	static_array_for_each(p->lists, i)
> +		if (i->head)
> +			return true;
> +
> +	return false;
> +}
> +
> +static void rcu_pending_list_merge(struct rcu_pending_list *l1,
> +				   struct rcu_pending_list *l2)
> +{
> +	if (!l1->head)
> +		l1->head = l2->head;
> +	else
> +		l1->tail->next = l2->head;
> +	l1->tail = l2->tail;
> +
> +	l2->head = l2->tail = NULL;
> +}

The rcu_segcblist structure handles this sort of thing straightforwardly.

> +static void rcu_pending_list_add(struct rcu_pending_list *l,
> +				 struct rcu_head *n)
> +{
> +	if (!l->head)
> +		l->head = n;
> +	else
> +		l->tail->next = n;
> +	l->tail = n;
> +	n->next = NULL;
> +}
> +
> +static void merge_expired_lists(struct rcu_pending_pcpu *p)
> +{
> +	struct rcu_pending_list *expired = &p->lists[NUM_ACTIVE_RCU_POLL_OLDSTATE];
> +
> +	for (struct rcu_pending_list *i = p->lists; i < expired; i++)
> +		if (i->head && __poll_state_synchronize_rcu(p->parent->srcu, i->seq))
> +			rcu_pending_list_merge(expired, i);
> +}
> +
> +static noinline void __process_finished_items(struct rcu_pending *pending,
> +					      struct rcu_pending_pcpu *p,
> +					      unsigned long flags)
> +{
> +	struct rcu_pending_list *expired = &p->lists[NUM_ACTIVE_RCU_POLL_OLDSTATE];
> +	struct rcu_pending_seq objs = {};
> +	struct rcu_head *list = NULL;
> +
> +	if (p->objs.nr &&
> +	    __poll_state_synchronize_rcu(pending->srcu, p->objs.data[0].seq)) {
> +		objs = p->objs.data[0];
> +		darray_remove_item(&p->objs, p->objs.data);
> +	}
> +
> +	merge_expired_lists(p);
> +
> +	list = expired->head;
> +	expired->head = expired->tail = NULL;
> +
> +	spin_unlock_irqrestore(&p->lock, flags);
> +
> +	switch ((ulong) pending->process) {
> +	case RCU_PENDING_KVFREE:
> +		for (size_t i = 0; i < objs.nr; ) {
> +			size_t nr_this_node = min(GENRADIX_NODE_SIZE / sizeof(void *), objs.nr - i);
> +
> +			kfree_bulk(nr_this_node, (void **) genradix_ptr(&objs.objs, i));
> +			i += nr_this_node;
> +		}
> +		genradix_free(&objs.objs);
> +
> +		while (list) {
> +			struct rcu_head *obj = list;
> +			list = obj->next;
> +
> +			/*
> +			 * low bit of pointer indicates whether rcu_head needs
> +			 * to be freed - kvfree_rcu_mightsleep()
> +			 */
> +			BUILD_BUG_ON(ARCH_SLAB_MINALIGN == 0);
> +
> +			void *ptr = (void *)(((unsigned long) obj->func) & ~1UL);
> +			kvfree(ptr);
> +
> +			bool free_head = ((unsigned long) obj->func) & 1UL;
> +			if (free_head)
> +				kfree(obj);
> +		}
> +
> +		break;
> +
> +	case RCU_PENDING_CALL_RCU:
> +		for (size_t i = 0; i < objs.nr; i++) {
> +			struct rcu_head *obj = *genradix_ptr(&objs.objs, i);
> +			obj->func(obj);
> +		}
> +		genradix_free(&objs.objs);
> +
> +		while (list) {
> +			struct rcu_head *obj = list;
> +			list = obj->next;
> +			obj->func(obj);
> +		}
> +		break;
> +
> +	default:
> +		for (size_t i = 0; i < objs.nr; i++)
> +			pending->process(pending, *genradix_ptr(&objs.objs, i));
> +		genradix_free(&objs.objs);
> +
> +		while (list) {
> +			struct rcu_head *obj = list;
> +			list = obj->next;
> +			pending->process(pending, obj);
> +		}
> +		break;
> +	}
> +}
> +
> +static bool process_finished_items(struct rcu_pending *pending,
> +				   struct rcu_pending_pcpu *p,
> +				   unsigned long flags)
> +{
> +	/*
> +	 * XXX: we should grab the gp seq once and avoid multiple function
> +	 * calls, this is called from __rcu_pending_enqueue() fastpath in
> +	 * may_sleep==true mode
> +	 */
> +	if ((p->objs.nr && __poll_state_synchronize_rcu(pending->srcu, p->objs.data[0].seq)) ||
> +	    (p->lists[0].head && __poll_state_synchronize_rcu(pending->srcu, p->lists[0].seq)) ||
> +	    (p->lists[1].head && __poll_state_synchronize_rcu(pending->srcu, p->lists[1].seq)) ||

One approach would be to create a variant of poll_state_synchronize_rcu()
that takes multiple cookies, and returns the index of the first one that
has expired.  Would that help?

> +	    p->lists[2].head) {
> +		__process_finished_items(pending, p, flags);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void rcu_pending_work(struct work_struct *work)
> +{
> +	struct rcu_pending_pcpu *p =
> +		container_of(work, struct rcu_pending_pcpu, work);
> +	struct rcu_pending *pending = p->parent;
> +	unsigned long flags;
> +
> +	do {
> +		spin_lock_irqsave(&p->lock, flags);
> +	} while (process_finished_items(pending, p, flags));
> +
> +	spin_unlock_irqrestore(&p->lock, flags);
> +}
> +
> +static void rcu_pending_rcu_cb(struct rcu_head *rcu)
> +{
> +	struct rcu_pending_pcpu *p = container_of(rcu, struct rcu_pending_pcpu, cb);
> +
> +	schedule_work_on(p->cpu, &p->work);
> +
> +	unsigned long flags;
> +	spin_lock_irqsave(&p->lock, flags);
> +	if (__rcu_pending_has_pending(p))
> +		__call_rcu(p->parent->srcu, &p->cb, rcu_pending_rcu_cb);
> +	else
> +		p->cb_armed = false;
> +	spin_unlock_irqrestore(&p->lock, flags);
> +}
> +
> +static __always_inline struct rcu_pending_seq *
> +get_object_radix(struct rcu_pending_pcpu *p, unsigned long seq)
> +{
> +	darray_for_each_reverse(p->objs, objs)
> +		if (objs->seq == seq)
> +			return objs;
> +
> +	if (darray_push_gfp(&p->objs, ((struct rcu_pending_seq) { .seq = seq }), GFP_ATOMIC))
> +		return NULL;
> +
> +	return &darray_last(p->objs);
> +}
> +
> +static noinline bool
> +rcu_pending_enqueue_list(struct rcu_pending_pcpu *p, unsigned long seq,
> +			 struct rcu_head *head, void *ptr,
> +			 unsigned long *flags)
> +{
> +	if (ptr) {
> +		if (!head) {
> +			/*
> +			 * kvfree_rcu_mightsleep(): we weren't passed an
> +			 * rcu_head, but we need one: use the low bit of the
> +			 * ponter to free to flag that the head needs to be
> +			 * freed as well:
> +			 */
> +			ptr = (void *)(((unsigned long) ptr)|1UL);
> +			head = kmalloc(sizeof(*head), __GFP_NOWARN);
> +			if (!head) {
> +				spin_unlock_irqrestore(&p->lock, *flags);
> +				head = kmalloc(sizeof(*head), GFP_KERNEL|__GFP_NOFAIL);
> +				/*
> +				 * dropped lock, did GFP_KERNEL allocation,
> +				 * check for gp expiration
> +				 */
> +				if (unlikely(__poll_state_synchronize_rcu(p->parent->srcu, seq))) {
> +					kvfree(--ptr);
> +					kfree(head);
> +					spin_lock_irqsave(&p->lock, *flags);
> +					return false;
> +				}
> +			}
> +		}
> +
> +		head->func = ptr;
> +	}
> +again:
> +	for (struct rcu_pending_list *i = p->lists;
> +	     i < p->lists + NUM_ACTIVE_RCU_POLL_OLDSTATE; i++) {
> +		if (i->seq == seq) {
> +			rcu_pending_list_add(i, head);
> +			return false;
> +		}
> +	}
> +
> +	for (struct rcu_pending_list *i = p->lists;
> +	     i < p->lists + NUM_ACTIVE_RCU_POLL_OLDSTATE; i++) {
> +		if (!i->head) {
> +			i->seq = seq;
> +			rcu_pending_list_add(i, head);
> +			return true;
> +		}
> +	}
> +
> +	merge_expired_lists(p);
> +	goto again;
> +}
> +
> +/*
> + * __rcu_pending_enqueue: enqueue a pending RCU item, to be processed (via
> + * pending->pracess) once grace period elapses.
> + *
> + * Attempt to enqueue items onto a radix tree; if memory allocation fails, fall
> + * back to a linked list.
> + *
> + * - If @ptr is NULL, we're enqueuing an item for a generic @pending with a
> + *   process callback
> + *
> + * - If @ptr and @head are both not NULL, we're kvfree_rcu()
> + *
> + * - If @ptr is not NULL and @head is, we're kvfree_rcu_mightsleep()
> + *
> + * - If @may_sleep is true, will do GFP_KERNEL memory allocations and process
> + *   expired items.
> + */
> +static __always_inline void
> +__rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *head,
> +		      void *ptr, bool may_sleep)
> +{
> +
> +	struct rcu_pending_pcpu *p;
> +	struct rcu_pending_seq *objs;
> +	struct genradix_node *new_node = NULL;
> +	unsigned long seq, flags;
> +	bool start_gp = false;
> +
> +	BUG_ON((ptr != NULL) != (pending->process == RCU_PENDING_KVFREE_FN));
> +
> +	local_irq_save(flags);
> +	p = this_cpu_ptr(pending->p);
> +	spin_lock(&p->lock);
> +	seq = __get_state_synchronize_rcu(pending->srcu);
> +restart:
> +	if (may_sleep &&
> +	    unlikely(process_finished_items(pending, p, flags)))
> +		goto check_expired;
> +
> +	/*
> +	 * In kvfree_rcu() mode, the radix tree is only for slab pointers so
> +	 * that we can do kfree_bulk() - vmalloc pointers always use the linked
> +	 * list:
> +	 */
> +	if (ptr && unlikely(is_vmalloc_addr_inlined(ptr)))
> +		goto list_add;
> +
> +	objs = get_object_radix(p, seq);
> +	if (unlikely(!objs))
> +		goto list_add;
> +
> +	if (unlikely(!objs->cursor)) {
> +		/*
> +		 * New radix tree nodes must be added under @p->lock because the
> +		 * tree root is in a darray that can be resized (typically,
> +		 * genradix supports concurrent unlocked allocation of new
> +		 * nodes) - hence preallocation and the retry loop:
> +		 */
> +		objs->cursor = genradix_ptr_alloc_preallocated_inlined(&objs->objs,
> +						objs->nr, &new_node, GFP_ATOMIC|__GFP_NOWARN);
> +		if (unlikely(!objs->cursor)) {
> +			if (may_sleep) {
> +				spin_unlock_irqrestore(&p->lock, flags);
> +
> +				gfp_t gfp = GFP_KERNEL;
> +				if (!head)
> +					gfp |= __GFP_NOFAIL;
> +
> +				new_node = genradix_alloc_node(gfp);
> +				if (!new_node)
> +					may_sleep = false;
> +				goto check_expired;
> +			}
> +list_add:
> +			start_gp = rcu_pending_enqueue_list(p, seq, head, ptr, &flags);
> +			goto start_gp;
> +		}
> +	}
> +
> +	*objs->cursor++ = ptr ?: head;
> +	/* zero cursor if we hit the end of a radix tree node: */
> +	if (!(((ulong) objs->cursor) & (GENRADIX_NODE_SIZE - 1)))
> +		objs->cursor = NULL;
> +	start_gp = !objs->nr;
> +	objs->nr++;
> +start_gp:
> +	if (unlikely(start_gp)) {
> +		/*
> +		 * We only have one callback (ideally, we would have one for
> +		 * every outstanding graceperiod) - so if our callback is
> +		 * already in flight, we may still have to start a grace period
> +		 * (since we used get_state() above, not start_poll())
> +		 */
> +		if (!p->cb_armed) {
> +			p->cb_armed = true;
> +			__call_rcu(pending->srcu, &p->cb, rcu_pending_rcu_cb);
> +		} else {
> +			__start_poll_synchronize_rcu(pending->srcu);
> +		}
> +	}
> +	spin_unlock_irqrestore(&p->lock, flags);
> +free_node:
> +	if (new_node)
> +		genradix_free_node(new_node);
> +	return;
> +check_expired:
> +	if (unlikely(__poll_state_synchronize_rcu(pending->srcu, seq))) {
> +		switch ((ulong) pending->process) {
> +		case RCU_PENDING_KVFREE:
> +			kvfree(ptr);
> +			break;
> +		case RCU_PENDING_CALL_RCU:
> +			head->func(head);
> +			break;
> +		default:
> +			pending->process(pending, head);
> +			break;
> +		}
> +		goto free_node;
> +	}
> +
> +	local_irq_save(flags);
> +	p = this_cpu_ptr(pending->p);
> +	spin_lock(&p->lock);
> +	goto restart;
> +}
> +
> +void rcu_pending_enqueue(struct rcu_pending *pending, struct rcu_head *obj)
> +{
> +	__rcu_pending_enqueue(pending, obj, NULL, true);
> +}
> +
> +static struct rcu_head *rcu_pending_pcpu_dequeue(struct rcu_pending_pcpu *p)
> +{
> +	struct rcu_head *ret = NULL;
> +
> +	spin_lock_irq(&p->lock);
> +	darray_for_each(p->objs, objs)
> +		if (objs->nr) {
> +			ret = *genradix_ptr(&objs->objs, --objs->nr);
> +			objs->cursor = NULL;
> +			if (!objs->nr)
> +				genradix_free(&objs->objs);
> +			goto out;
> +		}
> +
> +	static_array_for_each(p->lists, i)
> +		if (i->head) {
> +			ret = i->head;
> +			i->head = ret->next;
> +			if (!i->head)
> +				i->tail = NULL;
> +			goto out;
> +		}
> +out:
> +	spin_unlock_irq(&p->lock);
> +
> +	return ret;
> +}
> +
> +struct rcu_head *rcu_pending_dequeue(struct rcu_pending *pending)
> +{
> +	return rcu_pending_pcpu_dequeue(raw_cpu_ptr(pending->p));
> +}
> +
> +struct rcu_head *rcu_pending_dequeue_from_all(struct rcu_pending *pending)
> +{
> +	struct rcu_head *ret = rcu_pending_dequeue(pending);
> +
> +	if (ret)
> +		return ret;
> +
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		ret = rcu_pending_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static bool rcu_pending_has_pending_or_armed(struct rcu_pending *pending)
> +{
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +		spin_lock_irq(&p->lock);
> +		if (__rcu_pending_has_pending(p) || p->cb_armed) {
> +			spin_unlock_irq(&p->lock);
> +			return true;
> +		}
> +		spin_unlock_irq(&p->lock);
> +	}
> +
> +	return false;
> +}
> +
> +void rcu_pending_exit(struct rcu_pending *pending)
> +{
> +	int cpu;
> +
> +	if (!pending->p)
> +		return;
> +
> +	while (rcu_pending_has_pending_or_armed(pending)) {
> +		__rcu_barrier(pending->srcu);
> +
> +		for_each_possible_cpu(cpu) {
> +			struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +			flush_work(&p->work);
> +		}
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +		flush_work(&p->work);
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +
> +		static_array_for_each(p->lists, i)
> +			WARN_ON(i->head);
> +		WARN_ON(p->objs.nr);
> +		darray_exit(&p->objs);
> +	}
> +	free_percpu(pending->p);
> +}
> +
> +/**
> + * rcu_pending_init: - initialize a rcu_pending
> + *
> + * @pending:	Object to init
> + * @srcu:	May optionally be used with an srcu_struct; if NULL, uses normal
> + *		RCU flavor
> + * @process:	Callback function invoked on objects once their RCU barriers
> + *		have completed; if NULL, kvfree() is used.
> + */
> +int rcu_pending_init(struct rcu_pending *pending,
> +		     struct srcu_struct *srcu,
> +		     rcu_pending_process_fn process)
> +{
> +	pending->p = alloc_percpu(struct rcu_pending_pcpu);
> +	if (!pending->p)
> +		return -ENOMEM;
> +
> +	int cpu;
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_pending_pcpu *p = per_cpu_ptr(pending->p, cpu);
> +		p->parent	= pending;
> +		p->cpu		= cpu;
> +		spin_lock_init(&p->lock);
> +		darray_init(&p->objs);
> +		INIT_WORK(&p->work, rcu_pending_work);
> +	}
> +
> +	pending->srcu = srcu;
> +	pending->process = process;
> +
> +	return 0;
> +}
> -- 
> 2.45.2
> 

