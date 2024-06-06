Return-Path: <linux-kernel+bounces-204790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243738FF39A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5EF1F2770B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11131990DE;
	Thu,  6 Jun 2024 17:21:37 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6F204266AB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694497; cv=none; b=eSLn5CTnCqTv9/k7+4fjXeI2TNrzgaYelx0FiqKDOiRPY7am9MOBJB/cOwqYM7W0LsZHfpEa2q0PMTQVGuzGOv6sFST5gUDB2uG+zaDMcg/DOikbgMYiR7qELWeTnZypiSl4MRWrPdBSaR97U1eZdKNSd2lj8Y3os/jWHiOi36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694497; c=relaxed/simple;
	bh=frS/UngMOUTMkvobfMhI/dDnG5z34IDT7+8i/Wni88Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxskTRQpfEJbl6HlHY+iQRqJgHOjlJC3t0a8UvHn1KGDz3eOKZRvTTVU2B59E5brDahjWCTv0ZNnoMXAZLobDon7Llnf4U2ZMbTIUUwFdI2uk0wRGlqRZShMwtNqlb7to/U15k+5o9lz+d2O4cLSKeQNuEWp/FJFWiN9itXbhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 13406 invoked by uid 1000); 6 Jun 2024 13:21:28 -0400
Date: Thu, 6 Jun 2024 13:21:28 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <26aa2333-5e54-4dcd-b6df-f8f8545b2672@rowland.harvard.edu>
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
 <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
 <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>

On Thu, Jun 06, 2024 at 10:07:35AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 05, 2024 at 02:40:05PM -0400, Alan Stern wrote:
> > On Wed, Jun 05, 2024 at 11:25:11AM -0700, Paul E. McKenney wrote:
> > > Thank you both!
> > > 
> > > I queued and pushed the following commit, please let me know if it
> > > needs adjustment.
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > commit fb65813a7a181cd86c50bb03f9df1f6a398fa22b
> > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > Date:   Wed Jun 5 11:20:47 2024 -0700
> > > 
> > >     manual/locked: Add single-threaded spin_is_locked() test
> > >     
> > >     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
> > >     This bug results in the following output:
> > >     
> > >             Test CoWWW+sil-lock-sil-unlock-sil Allowed
> > >             States 0
> > >             No
> > >             Witnesses
> > >             Positive: 0 Negative: 0
> > >             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
> > >             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
> > >             Time CoWWW+sil-lock-sil-unlock-sil 0.01
> > >             Hash=cf12d53b4d1afec2e46bf9886af219c8
> > >     
> > >     This is consistent with a deadlock.  After the fix, there should be one
> > >     execution that matches the "exists" clause, hence an "Always" result.
> > 
> > The part about being consistent with a deadlock is not very important; 
> > I'd omit it.  Also, the second sentence is ambiguous; change it to:
> 
> Good point, the deadlock is irrelevant.  If I want to make that point,
> I can add a test that really does deadlock.  ;-)
> 
> > 	After the fix, there should be one execution that matches the 
> > 	"exists" clause and no executions that don't match, hence an 
> > 	"Always" result.
> 
> I ended up with the following:
> 
> 	This has no executions.  After the fix, there is one execution
> 	that matches the "exists" clause and no executions that do not
> 	match, hence an "Always" result.
> 
> The reason for explicitly stating "This has no executions" is that a
> lot of people never have seen such a thing.

Okay.  Don't we already have a litmus test in the archive that really 
does create a deadlock?  Something like: Lock Lock Unlock Unlock, all 
using the same lock variable?

> > > diff --git a/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > > new file mode 100644
> > > index 00000000..cee5abf4
> > > --- /dev/null
> > > +++ b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > > @@ -0,0 +1,24 @@
> > > +C CoWWW+sil-lock-sil-unlock-sil.litmus
> > 
> > Where does the "CoWWW" part of the name come from?  If it refers to 
> > coherence order and three writes, I'll point out that the litmus test 
> > contains only two writes -- which would better be described as a lock 
> > and an unlock.  (Or are you counting the "write" that sets the lock's 
> > initial value?)
> 
> The CoWWW comes from me having been confused.  The new filename is
> CoWW+sil-lock-sil-unlock-sil.litmus.  Thank you for spotting this!

All right, but what does the "CoWW" part stand for?

> > > +
> > > +(*
> > > + * Result: Always
> > > + *
> > > + * This tests the memory model's implementation of spin_is_locked().
> > > + *)
> > > +
> > > +{}
> > > +
> > > +P0(spinlock_t *x)
> > > +{
> > > +        int r0;
> > 
> > Oops!  Apparently I managed not to convert the spaces on that line to a 
> > tab.  Can you take care of that?
> 
> Done!  Please see below for the updated commit.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit d4d216a08b4bedb8cdb0f57a224a4e331b35b931
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Jun 5 11:20:47 2024 -0700
> 
>     manual/locked: Add single-threaded spin_is_locked() test
>     
>     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
>     This bug results in the following output:
>     
>             Test CoWW+sil-lock-sil-unlock-sil Allowed
>             States 0
>             No
>             Witnesses
>             Positive: 0 Negative: 0
>             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
>             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
>             Time CoWWW+sil-lock-sil-unlock-sil 0.01

Maybe you better re-run this with the updated litmus test file.  Those 
two lines aren't right.

Alan

