Return-Path: <linux-kernel+bounces-398428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435639BF128
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82695B24009
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595262036F5;
	Wed,  6 Nov 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9Oc6fuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334281E0480;
	Wed,  6 Nov 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905498; cv=none; b=dbdVMb4kYiUc3aPpupu2G28bavD5M58HboEur8zpmohqxjhK1fuaLbjDe1SqVVy1Jmzel1xPPNcvRz0CNJFRsnbFg+NdZEheoYt75YCh9xapbA9uzBeNxV/Cmln+VfjMTho100E2McdQLqcvPqZ0TDdtRAOmktBzE/Pw1K6PCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905498; c=relaxed/simple;
	bh=IfaawjWn1fbALvXJKQNwn06rrvAuiZb0NAT5paFbuDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpwrcH7oh/7vQxiUodVCkbLAUJZoi24mwlO6ppezDSOLBP9l60f8aU8S3oTjIFzQuXFyoqf/6N+FTStHjt9oyttJRYDp6rpkj2toBKD1OuEiR+0wpw9lPyDc3xKvMqW9ICarB5s1o3YCbKwRcKJEz1595tacbAbVKXcGQcNGKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9Oc6fuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D91C4CEC6;
	Wed,  6 Nov 2024 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905497;
	bh=IfaawjWn1fbALvXJKQNwn06rrvAuiZb0NAT5paFbuDc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r9Oc6fuKEKXhdm6WNri85FdcLcxISNcjYXgLhf7eDyPfQGIzJhavy3Rbs176Lnq9x
	 lqTO+DOqGWSHLizTe6RIO+Oqj6FdhOCK2OwD+VTfUwSH4enz5okcoJkhBeA5VrOp64
	 jyL6p5XEEAtXSdstKHHJgtC+7TGMIP4IWakOXQP/KI6ksWlTiNNwqCB26yALlTjK5u
	 05yv8ji4uDIa/p3k7Pwh+bDNEIMQjwSR2R8lumntegr+4L/2Y+lSYloDzM/pM5Qtde
	 3SoxTt8jEk0NXtkMV7WRxJIx2xv4ecAhRn1XhnucDIpg/qGKJo06SnKLIkn0hxMUf2
	 dk8Ustx1mdJWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4EBD7CE0876; Wed,  6 Nov 2024 07:04:57 -0800 (PST)
Date: Wed, 6 Nov 2024 07:04:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
	joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
	frederic@kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <36c93729-8d3c-4ede-8f5d-3074d6ea7e64@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
 <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
 <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
 <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
 <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>
 <7b755586-79ee-4344-bf50-27ef6e99e7bf@paulmck-laptop>
 <a06ed5e4-37a2-4295-986f-10977878c65b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06ed5e4-37a2-4295-986f-10977878c65b@huaweicloud.com>

On Wed, Nov 06, 2024 at 11:28:28AM +0100, Jonas Oberhauser wrote:
> 
> 
> Am 11/5/2024 um 9:21 PM schrieb Paul E. McKenney:
> > On Wed, Oct 30, 2024 at 07:34:45AM -0700, Boqun Feng wrote:
> > > On Wed, Oct 30, 2024 at 12:38:26PM +0100, Jonas Oberhauser wrote:
> > > > 
> > > > 
> > > > Am 10/30/2024 um 12:41 AM schrieb Paul E. McKenney:
> > > > > On Mon, Oct 28, 2024 at 05:15:46PM -0700, Boqun Feng wrote:
> > > > > > On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
> > > > > > > Not all tags that are always there syntactically also provide semantic
> > > > > > > membership in the corresponding set. For example, an 'acquire tag on a
> > > > > > 
> > > > > > Maybe:
> > > > > > 
> > > > > > Not all annotated accesses provide the same semantic as their syntactic
> > > > > > tags...
> > > > > > 
> > > > > > ?
> > > > > 
> > > > > Jonas, are you OK with this change?  If so, I can apply it on my next
> > > > > rebase.
> > > > > 
> > > > 
> > > > I'm ok with an extra s after semantics and a minor rephrase:
> > > > 
> > > > Not all annotated accesses provide the semantics their syntactic
> > > > tags would imply
> > > > 
> > > > What do you think @Boqun ?
> > > 
> > > Yes, of course! This looks good to me.
> > 
> > Please see below for what I currently have.  If there are no objections
> > in a day or so, I will set up these five commits for the upcoming v6.13
> > merge window.
> > 
> > The additional bit pointed out by Boqun [1] can be addressed by a
> > separate commit.
> > 
> > 							Thanx, Paul
> > 
> > [1] https://lore.kernel.org/all/ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local/
> 
> I'm confused, did I forget to add the fix to the capitalization issue
> discovered by Boqun to the fixed commit? I vividly remember typing git
> commit add ...

It is quite possible that I have queued an old version of the patch.
Could you please check this commit on -rcu, shown below?

c53d54ed7e40 ("tools/memory-model: Distinguish between syntactic and semantic tags")

If this is the wrong one, please point me to the right one.

							Thanx, Paul

------------------------------------------------------------------------

commit c53d54ed7e40255ea0ea66dd121672fd22423326
Author: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Date:   Mon Sep 30 12:57:10 2024 +0200

    tools/memory-model: Distinguish between syntactic and semantic tags
    
    Not all annotated accesses provide the semantics their syntactic tags
    would imply. For example, an 'acquire tag on a write does not imply that
    the write is finally in the Acquire set and provides acquire ordering.
    
    To distinguish in those cases between the syntactic tags and actual
    sets, we capitalize the former, so 'ACQUIRE tags may be present on both
    reads and writes, but only reads will appear in the Acquire set.
    
    For tags where the two concepts are the same we do not use specific
    capitalization to make this distinction.
    
    Reported-by: Boqun Feng <boqun.feng@gmail.com>
    Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
    Tested-by: Boqun Feng <boqun.feng@gmail.com>

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 8ae47545df978..fe65998002b99 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,18 +13,18 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
-		'release (*smp_store_release*) ||
-		'acquire (*smp_load_acquire*) ||
-		'noreturn (* R of non-return RMW *) ||
-		'mb (*xchg(),cmpxchg(),...*)
+enum Accesses = 'ONCE (*READ_ONCE,WRITE_ONCE*) ||
+		'RELEASE (*smp_store_release*) ||
+		'ACQUIRE (*smp_load_acquire*) ||
+		'NORETURN (* R of non-return RMW *) ||
+		'MB (*xchg(),cmpxchg(),...*)
 instructions R[Accesses]
 instructions W[Accesses]
 instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-		'mb (*smp_mb*) ||
+		'MB (*smp_mb*) ||
 		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
@@ -42,10 +42,10 @@ instructions F[Barriers]
  * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
  *)
 let FailedRMW = RMW \ (domain(rmw) | range(rmw))
-let Acquire = Acquire \ W \ FailedRMW
-let Release = Release \ R \ FailedRMW
-let Mb = Mb \ FailedRMW
-let Noreturn = Noreturn \ W
+let Acquire = ACQUIRE \ W \ FailedRMW
+let Release = RELEASE \ R \ FailedRMW
+let Mb = MB \ FailedRMW
+let Noreturn = NORETURN \ W
 
 (* SRCU *)
 enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
@@ -85,7 +85,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
-let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | RMW |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index d7279a357cba0..49e402782e49c 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -6,18 +6,18 @@
 // which appeared in ASPLOS 2018.
 
 // ONCE
-READ_ONCE(X) __load{once}(X)
-WRITE_ONCE(X,V) { __store{once}(X,V); }
+READ_ONCE(X) __load{ONCE}(X)
+WRITE_ONCE(X,V) { __store{ONCE}(X,V); }
 
 // Release Acquire and friends
-smp_store_release(X,V) { __store{release}(*X,V); }
-smp_load_acquire(X) __load{acquire}(*X)
-rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{once}(X)
-smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
+smp_store_release(X,V) { __store{RELEASE}(*X,V); }
+smp_load_acquire(X) __load{ACQUIRE}(*X)
+rcu_assign_pointer(X,V) { __store{RELEASE}(X,V); }
+rcu_dereference(X) __load{ONCE}(X)
+smp_store_mb(X,V) { __store{ONCE}(X,V); __fence{MB}; }
 
 // Fences
-smp_mb() { __fence{mb}; }
+smp_mb() { __fence{MB}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
@@ -28,14 +28,14 @@ smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
 barrier() { __fence{barrier}; }
 
 // Exchange
-xchg(X,V)  __xchg{mb}(X,V)
-xchg_relaxed(X,V) __xchg{once}(X,V)
-xchg_release(X,V) __xchg{release}(X,V)
-xchg_acquire(X,V) __xchg{acquire}(X,V)
-cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
+xchg(X,V)  __xchg{MB}(X,V)
+xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+xchg_release(X,V) __xchg{RELEASE}(X,V)
+xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
 
 // Spinlocks
 spin_lock(X) { __lock(X); }
@@ -63,86 +63,86 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
-atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
-atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
-atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
-atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
-atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
-atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
-atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
-
-atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
-atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
-atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)
-atomic_add_return_release(V,X) __atomic_op_return{release}(X,+,V)
-atomic_fetch_add(V,X) __atomic_fetch_op{mb}(X,+,V)
-atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
-atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
-atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
-
-atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
-atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
-atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
-atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
-
-atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
-atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
-atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
-atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
-
-atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
-atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
-atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
-atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
-
-atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
-atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
-atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
-atomic_inc_return_release(X) __atomic_op_return{release}(X,+,1)
-atomic_fetch_inc(X) __atomic_fetch_op{mb}(X,+,1)
-atomic_fetch_inc_relaxed(X) __atomic_fetch_op{once}(X,+,1)
-atomic_fetch_inc_acquire(X) __atomic_fetch_op{acquire}(X,+,1)
-atomic_fetch_inc_release(X) __atomic_fetch_op{release}(X,+,1)
-
-atomic_sub_return(V,X) __atomic_op_return{mb}(X,-,V)
-atomic_sub_return_relaxed(V,X) __atomic_op_return{once}(X,-,V)
-atomic_sub_return_acquire(V,X) __atomic_op_return{acquire}(X,-,V)
-atomic_sub_return_release(V,X) __atomic_op_return{release}(X,-,V)
-atomic_fetch_sub(V,X) __atomic_fetch_op{mb}(X,-,V)
-atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{once}(X,-,V)
-atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{acquire}(X,-,V)
-atomic_fetch_sub_release(V,X) __atomic_fetch_op{release}(X,-,V)
-
-atomic_dec_return(X) __atomic_op_return{mb}(X,-,1)
-atomic_dec_return_relaxed(X) __atomic_op_return{once}(X,-,1)
-atomic_dec_return_acquire(X) __atomic_op_return{acquire}(X,-,1)
-atomic_dec_return_release(X) __atomic_op_return{release}(X,-,1)
-atomic_fetch_dec(X) __atomic_fetch_op{mb}(X,-,1)
-atomic_fetch_dec_relaxed(X) __atomic_fetch_op{once}(X,-,1)
-atomic_fetch_dec_acquire(X) __atomic_fetch_op{acquire}(X,-,1)
-atomic_fetch_dec_release(X) __atomic_fetch_op{release}(X,-,1)
-
-atomic_xchg(X,V) __xchg{mb}(X,V)
-atomic_xchg_relaxed(X,V) __xchg{once}(X,V)
-atomic_xchg_release(X,V) __xchg{release}(X,V)
-atomic_xchg_acquire(X,V) __xchg{acquire}(X,V)
-atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
-
-atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
-atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
-atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
-atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
-atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
-atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
-atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
-
-atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
-atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
-atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
-atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
-
-atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
+atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
+atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
+atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
+atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }
+
+atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
+atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
+atomic_add_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V)
+atomic_add_return_release(V,X) __atomic_op_return{RELEASE}(X,+,V)
+atomic_fetch_add(V,X) __atomic_fetch_op{MB}(X,+,V)
+atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{ONCE}(X,+,V)
+atomic_fetch_add_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,+,V)
+atomic_fetch_add_release(V,X) __atomic_fetch_op{RELEASE}(X,+,V)
+
+atomic_fetch_and(V,X) __atomic_fetch_op{MB}(X,&,V)
+atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&,V)
+atomic_fetch_and_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&,V)
+atomic_fetch_and_release(V,X) __atomic_fetch_op{RELEASE}(X,&,V)
+
+atomic_fetch_or(V,X) __atomic_fetch_op{MB}(X,|,V)
+atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{ONCE}(X,|,V)
+atomic_fetch_or_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,|,V)
+atomic_fetch_or_release(V,X) __atomic_fetch_op{RELEASE}(X,|,V)
+
+atomic_fetch_xor(V,X) __atomic_fetch_op{MB}(X,^,V)
+atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{ONCE}(X,^,V)
+atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,^,V)
+atomic_fetch_xor_release(V,X) __atomic_fetch_op{RELEASE}(X,^,V)
+
+atomic_inc_return(X) __atomic_op_return{MB}(X,+,1)
+atomic_inc_return_relaxed(X) __atomic_op_return{ONCE}(X,+,1)
+atomic_inc_return_acquire(X) __atomic_op_return{ACQUIRE}(X,+,1)
+atomic_inc_return_release(X) __atomic_op_return{RELEASE}(X,+,1)
+atomic_fetch_inc(X) __atomic_fetch_op{MB}(X,+,1)
+atomic_fetch_inc_relaxed(X) __atomic_fetch_op{ONCE}(X,+,1)
+atomic_fetch_inc_acquire(X) __atomic_fetch_op{ACQUIRE}(X,+,1)
+atomic_fetch_inc_release(X) __atomic_fetch_op{RELEASE}(X,+,1)
+
+atomic_sub_return(V,X) __atomic_op_return{MB}(X,-,V)
+atomic_sub_return_relaxed(V,X) __atomic_op_return{ONCE}(X,-,V)
+atomic_sub_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,-,V)
+atomic_sub_return_release(V,X) __atomic_op_return{RELEASE}(X,-,V)
+atomic_fetch_sub(V,X) __atomic_fetch_op{MB}(X,-,V)
+atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{ONCE}(X,-,V)
+atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,-,V)
+atomic_fetch_sub_release(V,X) __atomic_fetch_op{RELEASE}(X,-,V)
+
+atomic_dec_return(X) __atomic_op_return{MB}(X,-,1)
+atomic_dec_return_relaxed(X) __atomic_op_return{ONCE}(X,-,1)
+atomic_dec_return_acquire(X) __atomic_op_return{ACQUIRE}(X,-,1)
+atomic_dec_return_release(X) __atomic_op_return{RELEASE}(X,-,1)
+atomic_fetch_dec(X) __atomic_fetch_op{MB}(X,-,1)
+atomic_fetch_dec_relaxed(X) __atomic_fetch_op{ONCE}(X,-,1)
+atomic_fetch_dec_acquire(X) __atomic_fetch_op{ACQUIRE}(X,-,1)
+atomic_fetch_dec_release(X) __atomic_fetch_op{RELEASE}(X,-,1)
+
+atomic_xchg(X,V) __xchg{MB}(X,V)
+atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
+atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
+
+atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
+atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0
+atomic_inc_and_test(X)  __atomic_op_return{MB}(X,+,1) == 0
+atomic_add_negative(V,X) __atomic_op_return{MB}(X,+,V) < 0
+atomic_add_negative_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V) < 0
+atomic_add_negative_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V) < 0
+atomic_add_negative_release(V,X) __atomic_op_return{RELEASE}(X,+,V) < 0
+
+atomic_fetch_andnot(V,X) __atomic_fetch_op{MB}(X,&~,V)
+atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&~,V)
+atomic_fetch_andnot_release(V,X) __atomic_fetch_op{RELEASE}(X,&~,V)
+atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&~,V)
+
+atomic_add_unless(X,V,W) __atomic_add_unless{MB}(X,V,W)

