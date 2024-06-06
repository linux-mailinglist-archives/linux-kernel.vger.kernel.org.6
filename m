Return-Path: <linux-kernel+bounces-204769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F58FF355
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F21F28C109
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5362198E87;
	Thu,  6 Jun 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAeVzddM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001B197A65
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693656; cv=none; b=HF5KVdYyIDdaa8vZ2Aw+Kgz9jMKdsouwzywMk3GJlDaa0ZmzdUbzSpLxykrRlss+9a4GyKr24rhK99XMkZJSBqAvq2SAzAG+hkwurcDk0/AkmjRlxNT9jT8Pe1+7ebUKAUOjMGyjPeojIBO5ub/W7JrwsipZXOvvA9XeRvqk99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693656; c=relaxed/simple;
	bh=rnxZ0Vr8B1WHr2j8vKiyhdo52e1nn+9bFC48qwBjGHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S76b/8nLiR/8rVESOlCK1Uq/Itw52drNppVFp3sZS+ESM+0bVag4IU2+6adOTAG6UECy6qx+6xtsumTq7RKEwL8ltgN7vLV0qtv2KTODr9gysvy03zN3xQtFUjuJI4JGIUj4eEwaU0HnDFIPMM7KfZc4/Qu64ngQUk4WAf+XoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAeVzddM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7925CC2BD10;
	Thu,  6 Jun 2024 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693655;
	bh=rnxZ0Vr8B1WHr2j8vKiyhdo52e1nn+9bFC48qwBjGHY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LAeVzddMwEr6BhZRSGxQn6Ivb/mVmHpO08XeXSYMykqhYmO4ceIejY7urgvEzqdUG
	 oJn7y8S76JARjbHCgjLrj0AcoCH+605KtDPSQfnlHqpwZsVOQewSqq+IGEWP7rb2sY
	 A3olXglV+rfctm72BmpWMeL4o1axETDGX8QKICzezJEoJBjjPd1nbVlvyZqRlpN1As
	 E8K+2D6j23z3c6qpS9XoeVbAOK2wjnNnEzRU6Q4M0eAfuolqH8z92zkhHPc9LO1Aih
	 eiZRrNEY9fb1ZxYBdKofOmSHimAu8Qp3whvUW4rpdygxfD8lpAj5owHsZc0bupQXYd
	 4FJUF+xRyUM9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1E783CE3F34; Thu,  6 Jun 2024 10:07:35 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:07:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
 <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>

On Wed, Jun 05, 2024 at 02:40:05PM -0400, Alan Stern wrote:
> On Wed, Jun 05, 2024 at 11:25:11AM -0700, Paul E. McKenney wrote:
> > Thank you both!
> > 
> > I queued and pushed the following commit, please let me know if it
> > needs adjustment.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit fb65813a7a181cd86c50bb03f9df1f6a398fa22b
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Wed Jun 5 11:20:47 2024 -0700
> > 
> >     manual/locked: Add single-threaded spin_is_locked() test
> >     
> >     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
> >     This bug results in the following output:
> >     
> >             Test CoWWW+sil-lock-sil-unlock-sil Allowed
> >             States 0
> >             No
> >             Witnesses
> >             Positive: 0 Negative: 0
> >             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
> >             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
> >             Time CoWWW+sil-lock-sil-unlock-sil 0.01
> >             Hash=cf12d53b4d1afec2e46bf9886af219c8
> >     
> >     This is consistent with a deadlock.  After the fix, there should be one
> >     execution that matches the "exists" clause, hence an "Always" result.
> 
> The part about being consistent with a deadlock is not very important; 
> I'd omit it.  Also, the second sentence is ambiguous; change it to:

Good point, the deadlock is irrelevant.  If I want to make that point,
I can add a test that really does deadlock.  ;-)

> 	After the fix, there should be one execution that matches the 
> 	"exists" clause and no executions that don't match, hence an 
> 	"Always" result.

I ended up with the following:

	This has no executions.  After the fix, there is one execution
	that matches the "exists" clause and no executions that do not
	match, hence an "Always" result.

The reason for explicitly stating "This has no executions" is that a
lot of people never have seen such a thing.

> > diff --git a/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > new file mode 100644
> > index 00000000..cee5abf4
> > --- /dev/null
> > +++ b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > @@ -0,0 +1,24 @@
> > +C CoWWW+sil-lock-sil-unlock-sil.litmus
> 
> Where does the "CoWWW" part of the name come from?  If it refers to 
> coherence order and three writes, I'll point out that the litmus test 
> contains only two writes -- which would better be described as a lock 
> and an unlock.  (Or are you counting the "write" that sets the lock's 
> initial value?)

The CoWWW comes from me having been confused.  The new filename is
CoWW+sil-lock-sil-unlock-sil.litmus.  Thank you for spotting this!

> > +
> > +(*
> > + * Result: Always
> > + *
> > + * This tests the memory model's implementation of spin_is_locked().
> > + *)
> > +
> > +{}
> > +
> > +P0(spinlock_t *x)
> > +{
> > +        int r0;
> 
> Oops!  Apparently I managed not to convert the spaces on that line to a 
> tab.  Can you take care of that?

Done!  Please see below for the updated commit.

							Thanx, Paul

------------------------------------------------------------------------

commit d4d216a08b4bedb8cdb0f57a224a4e331b35b931
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Jun 5 11:20:47 2024 -0700

    manual/locked: Add single-threaded spin_is_locked() test
    
    This new litmus test demonstrates a bug in the current LKMM lock.cat file.
    This bug results in the following output:
    
            Test CoWW+sil-lock-sil-unlock-sil Allowed
            States 0
            No
            Witnesses
            Positive: 0 Negative: 0
            Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
            Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
            Time CoWWW+sil-lock-sil-unlock-sil 0.01
            Hash=cf12d53b4d1afec2e46bf9886af219c8
    
    This has no executions.  After the fix, there is one execution that
    matches the "exists" clause and no executions that do not match, hence an
    "Always" result.
    
    Suggested-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/manual/locked/CoWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWW+sil-lock-sil-unlock-sil.litmus
new file mode 100644
index 00000000..aadc4ceb
--- /dev/null
+++ b/manual/locked/CoWW+sil-lock-sil-unlock-sil.litmus
@@ -0,0 +1,24 @@
+C CoWWW+sil-lock-sil-unlock-sil.litmus
+
+(*
+ * Result: Always
+ *
+ * This tests the memory model's implementation of spin_is_locked().
+ *)
+
+{}
+
+P0(spinlock_t *x)
+{
+	int r0;
+	int r1;
+	int r2;
+
+	r0 = spin_is_locked(x);
+	spin_lock(x);
+	r1 = spin_is_locked(x);
+	spin_unlock(x);
+	r2 = spin_is_locked(x);
+}
+
+exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)

