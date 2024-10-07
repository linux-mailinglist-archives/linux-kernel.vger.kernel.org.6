Return-Path: <linux-kernel+bounces-353996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164769935E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DF31F25ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578E1DDC18;
	Mon,  7 Oct 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYMWuHFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559F13B58B;
	Mon,  7 Oct 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325095; cv=none; b=My5X1nzzeWUulBY+XeiFFbPYYTOKluJbZstomz4/obbnkSWGo2Cleu2660zCZXVcwTNT3htOuLtXJw8U13ngQKCgX1HdFzTF+ueJxE7i9Y7KEl1lnizosvF1Kq/3eOdtGxaFEsBiUex1Zw9Ey/hKGgqVUOdigSJplRFERlzAJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325095; c=relaxed/simple;
	bh=A0/KfeW8kFe4SaoCo5h9qpqTYsDndvVMYxZSEAiT0ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngiZR02ci1NXZ8BpGQE6GHb1KQBjXgwr5NtSMe6+g3H9syNdZHXxy5c+SEnW6WCsCakEaQDIxrJA3IjD70PtsT1xbFH36rzrgi+2YfuO0tI5zylgQocMFEX1Jf4UokOBp96tpDCrraqfkGQgPADJ5mKoMYzKhfn0anQmayPoWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYMWuHFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B340C4CEC6;
	Mon,  7 Oct 2024 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325095;
	bh=A0/KfeW8kFe4SaoCo5h9qpqTYsDndvVMYxZSEAiT0ZQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eYMWuHFhI1UgHQXm7m0Y33G/ah0+84x42wJKK6E03FtyWiBuW8YLuXtcEvKItewhn
	 xDlIqZvcPbTmPN0a3/OcIOSDz5NGldxTcyg05mgS0MZlJoImpFW998BV1mt5a2pi2j
	 zDsqRUlag2Of03xtyB+ubJQwjPGKUV80//waKG0hYC3vRPvD9ppDasWhlHs6MVB8SD
	 jDeCk1BXHJXDlKVASNBIH/gw96EKdBAcpIokgGvPaEyj2f5p53oA207DooiOdXQk6C
	 6Rn9OVCBfXwcpgvMAWo4VoQnFBd9fyiFVga/b+VKD9fCVtlgOJKw29je5+xIEFaxsZ
	 v4laO9pBCrShA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7BE8CE1594; Mon,  7 Oct 2024 11:18:14 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:18:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
Message-ID: <5d695bdd-afd2-4e9f-ba92-376a4b302566@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
 <20241005160444.GA18071@noisy.programming.kicks-ass.net>
 <df28acef-cf35-49fc-8b40-bc105e3f818f@efficios.com>
 <20241007104030.GB4879@noisy.programming.kicks-ass.net>
 <1de5d6ac-7f44-48d6-a5f3-9839d436891a@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de5d6ac-7f44-48d6-a5f3-9839d436891a@efficios.com>

On Mon, Oct 07, 2024 at 10:50:46AM -0400, Mathieu Desnoyers wrote:
> On 2024-10-07 12:40, Peter Zijlstra wrote:
> > On Sat, Oct 05, 2024 at 02:50:17PM -0400, Mathieu Desnoyers wrote:
> > > On 2024-10-05 18:04, Peter Zijlstra wrote:
> > 
> > 
> > > > > +/*
> > > > > + * hp_allocate: Allocate a hazard pointer.
> > > > > + *
> > > > > + * Allocate a hazard pointer slot for @addr. The object existence should
> > > > > + * be guaranteed by the caller. Expects to be called from preempt
> > > > > + * disable context.
> > > > > + *
> > > > > + * Returns a hazard pointer context.
> > > > 
> > > > So you made the WTF'o'meter crack, this here function does not allocate
> > > > nothing. Naming is bad. At best this is something like
> > > > try-set-hazard-pointer or somesuch.
> > > 
> > > I went with the naming from the 2004 paper from Maged Michael, but I
> > > agree it could be clearer.
> > > 
> > > I'm tempted to go for "hp_try_post()" and "hp_remove()", basically
> > > "posting" the intent to use a pointer (as in on a metaphorical billboard),
> > > and removing it when it's done.
> > 
> > For RCU we've taken to using the word: 'publish', no?
> 
> I'm so glad you suggest this, because it turns out that from all
> the possible words you could choose from, 'publish' is probably the
> most actively confusing. I'll explain.
> 
> Let me first do a 10'000 feet comparison of RCU vs Hazard Pointers
> through a simple example:
> 
> [ Note: I've renamed the HP dereference try_post to HP load try_post
>   based on further discussion below. ]
> 
> *** RCU ***
> 
> * Dereference RCU-protected pointer:
>     rcu_read_lock();          // [ Begin read transaction ]
>     l_p = rcu_dereference(p); // [ Load p: @addr or NULL ]
>     if (l_p)
>       [ use *l_p ...]
>     rcu_read_unlock();        // [ End read transaction ]
> 
> * Publish @addr:    addr = kmalloc();
>                     init(addr);
>                     rcu_assign_pointer(p, addr);
> 
> * Reclaim @addr:    rcu_assign_pointer(p, NULL); // [ Unpublish @addr ]
>                     synchronize_rcu();           // Wait for all pre-existing
>                                                  // read transactions to complete.
>                     kfree(addr);
> 
> 
> *** Hazard Pointers ***
> 
> * Load and post a HP-protected pointer:
>     l_p = hp_load_try_post(domain, &p, &slot);
>     if (l_p) {
>       [ use *l_p ...]
>       hp_remove(&slot, l_p);
>     }
> 
> * Publish @addr:    addr = kmalloc();
>                     init(addr);
>                     rcu_assign_pointer(p, addr);
> 
> * Reclaim @addr:    rcu_assign_pointer(p, NULL); // [ Unpublish @addr ]
>                     hp_scan(domain, addr, NULL);
>                     kfree(addr);
> 
> Both HP and RCU have publication guarantees, which can in fact be
> implemented in the same way (e.g. rcu_assign_pointer paired with
> something that respects address dependencies ordering). A stronger
> implementation of this would be pairing a store-release with a
> load-acquire: it works, but it would add needless overhead on
> weakly-ordered CPUs.
> 
> How the two mechanisms differ is in how they track when it is
> safe to reclaim @addr. RCU tracks reader "transactions" begin/end,
> and makes sure that all pre-existing transactions are gone before
> synchronize_rcu() is allowed to complete. HP does this by tracking
> "posted" pointer slots with a HP domain. As long as hp_scan observes
> that HP readers are showing interest in @addr, it will wait.
> 
> One notable difference between RCU and HP is that HP knows exactly
> which pointer is blocking progress, and from which CPU (at least
> with my per-CPU HP domain implementation). Therefore, it is possible
> for HP to issue an IPI and make sure the HP user either completes its
> use of the pointer quickly, or stops using it right away (e.g. making
> the active mm use idle mm instead).
> 
> One strength of RCU is that it can track use of a whole set of RCU
> pointers just by tracking reader transaction begin/end, but this is
> also one of its weaknesses: a long reader transaction can postpone
> completion of grace period for a long time and increase the memory
> footprint. In comparison, HP can immediately complete as soon as the
> pointer it is scanning for is gone. Even better, it can send an IPI
> to the belate CPU and abort use of the pointer using a callback.

Plus, in contrast to hazard pointers, rcu_dereference() cannot say "no".

This all sounds like arguments *for* use of the term "publish" for
hazard pointers rather than against it.  What am I missing here?

							Thanx, Paul

> > > > > +/*
> > > > > + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
> > > > > + *
> > > > > + * Returns a hazard pointer context. Expects to be called from preempt
> > > > > + * disable context.
> > > > > + */
> > > > 
> > > > More terrible naming. Same as above, but additionally, I would expect a
> > > > 'dereference' to actually dereference the pointer and have a return
> > > > value of the dereferenced type.
> > > 
> > > hp_dereference_try_post() ?
> > > 
> > > > 
> > > > This function seems to double check and update the hp_ctx thing. I'm not
> > > > at all sure yet wtf this is doing -- and the total lack of comments
> > > > aren't helping.
> > > 
> > > The hp_ctx contains the outputs.
> > > 
> > > The function loads *addr_p to then try_post it into a HP slot. On success,
> > > it re-reads the *addr_p (with address dependency) and if it still matches,
> > > use that as output address pointer.
> > > 
> > > I'm planning to remove hp_ctx, and just have:
> > > 
> > > /*
> > >   * hp_try_post: Try to post a hazard pointer.
> > >   *
> > >   * Post a hazard pointer slot for @addr. The object existence should
> > >   * be guaranteed by the caller. Expects to be called from preempt
> > >   * disable context.
> > >   *
> > >   * Returns true if post succeeds, false otherwise.
> > >   */
> > > static inline
> > > bool hp_try_post(struct hp_domain *hp_domain, void *addr, struct hp_slot **_slot)
> > > [...]
> > > 
> > > /*
> > >   * hp_dereference_try_post: Dereference and try to post a hazard pointer.
> > >   *
> > >   * Returns a hazard pointer context. Expects to be called from preempt
> > >   * disable context.
> > >   */
> > > static inline
> > > void *__hp_dereference_try_post(struct hp_domain *hp_domain,
> > >                                  void * const * addr_p, struct hp_slot **_slot)
> > > [...]
> > > 
> > > #define hp_dereference_try_post(domain, p, slot_p)              \
> > >          ((__typeof__(*(p))) __hp_dereference_try_post(domain, (void * const *) p, slot_p))
> > 
> > This will compile, but do the wrong thing when p is a regular pointer, no?
> 
> Right, at least in some cases the compiler may not complain, and people used to
> rcu_dereference() will expect that "p" is the pointer to load rather than the
> address of that pointer. This would be unexpected.
> 
> I must admit that passing the address holding the pointer to load rather than
> the pointer to load itself makes it much less troublesome in terms of macro
> layers. But perhaps this is another example where we should wander away from the
> beaten path and use a word different from "dereference" here. E.g.:
> 
> /*
>  * Use a comma expression within typeof: __typeof__((void)**(addr_p), *(addr_p))
>  * to generate a compile error if addr_p is not a pointer to a pointer.
>  */
> #define hp_load_try_post(domain, addr_p, slot_p)                \
>         ((__typeof__((void)**(addr_p), *(addr_p))) __hp_load_try_post(domain, (void * const *) (addr_p), slot_p))
> 
> > 
> > > 
> > > /* Clear the hazard pointer in @slot. */
> > > static inline
> > > void hp_remove(struct hp_slot *slot)
> > > [...]
> > 
> > Differently weird, but better I suppose :-)
> 
> If you find a better word than "remove" to pair with "post", I'm all in :)
> 
> > 
> > 
> > > > > +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> > > > > +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> > > > > +{
> > > > > +	int cpu;
> > > > > +
> > > > > +	/*
> > > > > +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> > > > > +	 * NULL or to a different value), and thus hides it from hazard
> > > > > +	 * pointer readers.
> > > > > +	 */
> > > > > +
> > > > > +	if (!addr)
> > > > > +		return;
> > > > > +	/* Memory ordering: Store A before Load B. */
> > > > > +	smp_mb();
> > > > > +	/* Scan all CPUs slots. */
> > > > > +	for_each_possible_cpu(cpu) {
> > > > > +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
> > > > > +
> > > > > +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
> > > > > +			retire_cb(cpu, slot, addr);
> > > > 
> > > > Is retirce_cb allowed to cmpxchg the thing?
> > > 
> > > It could, but we'd need to make sure the slot is not re-used by another
> > > hp_try_post() before the current user removes its own post. It would
> > > need to synchronize with the current HP user (e.g. with IPI).
> > > 
> > > I've actually renamed retire_cb to "on_match_cb".
> > 
> > Hmm, I think I see. Would it make sense to pass the expected addr to
> > hp_remove() and double check we don't NULL out something unexpected? --
> > maybe just for a DEBUG option.
> > 
> > I'm always seeing the NOHZ_FULL guys hating on this :-)
> 
> That's a fair point. Sure, we can do this as an extra safety net. For now I
> will just make the check always present, we can always move it to a debug
> option later.
> 
> And now I notice that hp_remove is also used for CPU hotplug (grep
> matches for cpuhp_remove_state()). I wonder if we should go for something
> more grep-friendly than "hp_", e.g. "hazptr_" and rename hp.h to hazptr.h ?
> 
> Thanks,
> 
> Mathieu
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 

