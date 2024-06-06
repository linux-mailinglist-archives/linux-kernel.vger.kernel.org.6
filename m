Return-Path: <linux-kernel+bounces-204846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6F48FF42B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD721C26CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92442199246;
	Thu,  6 Jun 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6n267QT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC806197A8F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696663; cv=none; b=bfnKHxkkwAdB6ndiLmscxJo9QZ+WXVVllnRak3Bvk9frK4a3zkq9zutm2hfzzTBj6dN4NenNCoC0xf4kDEa/S+J/tYWrQ0QWu1lGU3s6mgMxRcCx6TWv07LvSgLYKxkH/pb1VtZ/NcwipEVYTK18WxqXOhpX39QtaRhGsyP+x4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696663; c=relaxed/simple;
	bh=k1+KgaYVKP7kFpEvtomTLBlsXK+U7dEsMp0LM+tE3Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMZ6quK6qvhKjJ/QVpIUtWASrYxlaJ72/Xlq3VKayJiVm4/y4o2sWi5LEU8Uz8ol9aWcvOxWKFtr5Jfj+pvZygLm6apLX6XhK5O530I5hecb9LTQ1GLSz/KBss18n5Adc3xP5ETqV/+HU5Gap8fiXHOEONNkfo12bKYQDvkbBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6n267QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1CDC2BD10;
	Thu,  6 Jun 2024 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717696663;
	bh=k1+KgaYVKP7kFpEvtomTLBlsXK+U7dEsMp0LM+tE3Bs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b6n267QTuvFz1TVnsdLnPLJ2Kpj4pBEDMF2KpqMGViSROLdKs4K/+WuR0mBa5/AKL
	 hIAQxeWd1hsK09fbqL5z15XQcGjn2Dx8aF0iz6n1ZqCejcv1yd5reJZGEsPxjvquX2
	 CeX/Q/GuXBjZul8KLk5kYalQh7ekV/jI84995PrGyQlfZEuR7gMgCodB4xfME4XWb7
	 nPFi16Y9Gh+LjA3CGcsc1LTYbldXdI848bkhifZhAMbcC7kDBxMuopSAtZqt+AlhuF
	 MO6qTTjYhK/Eh84gK/c4n7z2/Rbt/krPXl+nUc7QFf0ZDn1hQaK5hImnGhiUnK0EsC
	 8d5UE8N2+2tZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB956CE3F34; Thu,  6 Jun 2024 10:57:42 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:57:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <47fe55b3-81af-4397-9769-bda25209e980@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
 <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
 <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>
 <26aa2333-5e54-4dcd-b6df-f8f8545b2672@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26aa2333-5e54-4dcd-b6df-f8f8545b2672@rowland.harvard.edu>

On Thu, Jun 06, 2024 at 01:21:28PM -0400, Alan Stern wrote:
> On Thu, Jun 06, 2024 at 10:07:35AM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 05, 2024 at 02:40:05PM -0400, Alan Stern wrote:
> > > On Wed, Jun 05, 2024 at 11:25:11AM -0700, Paul E. McKenney wrote:
> > > > Thank you both!
> > > > 
> > > > I queued and pushed the following commit, please let me know if it
> > > > needs adjustment.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit fb65813a7a181cd86c50bb03f9df1f6a398fa22b
> > > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > > Date:   Wed Jun 5 11:20:47 2024 -0700
> > > > 
> > > >     manual/locked: Add single-threaded spin_is_locked() test
> > > >     
> > > >     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
> > > >     This bug results in the following output:
> > > >     
> > > >             Test CoWWW+sil-lock-sil-unlock-sil Allowed
> > > >             States 0
> > > >             No
> > > >             Witnesses
> > > >             Positive: 0 Negative: 0
> > > >             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
> > > >             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
> > > >             Time CoWWW+sil-lock-sil-unlock-sil 0.01
> > > >             Hash=cf12d53b4d1afec2e46bf9886af219c8
> > > >     
> > > >     This is consistent with a deadlock.  After the fix, there should be one
> > > >     execution that matches the "exists" clause, hence an "Always" result.
> > > 
> > > The part about being consistent with a deadlock is not very important; 
> > > I'd omit it.  Also, the second sentence is ambiguous; change it to:
> > 
> > Good point, the deadlock is irrelevant.  If I want to make that point,
> > I can add a test that really does deadlock.  ;-)
> > 
> > > 	After the fix, there should be one execution that matches the 
> > > 	"exists" clause and no executions that don't match, hence an 
> > > 	"Always" result.
> > 
> > I ended up with the following:
> > 
> > 	This has no executions.  After the fix, there is one execution
> > 	that matches the "exists" clause and no executions that do not
> > 	match, hence an "Always" result.
> > 
> > The reason for explicitly stating "This has no executions" is that a
> > lot of people never have seen such a thing.
> 
> Okay.  Don't we already have a litmus test in the archive that really 
> does create a deadlock?  Something like: Lock Lock Unlock Unlock, all 
> using the same lock variable?

We do have these guys:

auto/C-RR-GR+RR-R+RR-R.litmus
auto/C-RR-GR+RR-R.litmus
auto/C-RW-GR+RW-R+RW-R.litmus
auto/C-RW-GR+RW-R.litmus
auto/C-WR-GR+WR-R+WR-R.litmus
auto/C-WR-GR+WR-R.litmus
auto/C-WW-GR+WW-R+WW-R.litmus
auto/C-WW-GR+WW-R.litmus
	A synchronize_rcu() in an RCU read-side critical section.

I added a manual/locked/self-deadlock.litmus, which is shown at the
end of this email.  Omitting the nested self-deadlocking acquisition
and release gives one state with blank line.  ;-)

Or should I add a spin_is_locked() in order to get a non-empty
state line?

> > > > diff --git a/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > > > new file mode 100644
> > > > index 00000000..cee5abf4
> > > > --- /dev/null
> > > > +++ b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> > > > @@ -0,0 +1,24 @@
> > > > +C CoWWW+sil-lock-sil-unlock-sil.litmus
> > > 
> > > Where does the "CoWWW" part of the name come from?  If it refers to 
> > > coherence order and three writes, I'll point out that the litmus test 
> > > contains only two writes -- which would better be described as a lock 
> > > and an unlock.  (Or are you counting the "write" that sets the lock's 
> > > initial value?)
> > 
> > The CoWWW comes from me having been confused.  The new filename is
> > CoWW+sil-lock-sil-unlock-sil.litmus.  Thank you for spotting this!
> 
> All right, but what does the "CoWW" part stand for?

"Coherence, Write-Write".

> > > > +
> > > > +(*
> > > > + * Result: Always
> > > > + *
> > > > + * This tests the memory model's implementation of spin_is_locked().
> > > > + *)
> > > > +
> > > > +{}
> > > > +
> > > > +P0(spinlock_t *x)
> > > > +{
> > > > +        int r0;
> > > 
> > > Oops!  Apparently I managed not to convert the spaces on that line to a 
> > > tab.  Can you take care of that?
> > 
> > Done!  Please see below for the updated commit.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit d4d216a08b4bedb8cdb0f57a224a4e331b35b931
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Wed Jun 5 11:20:47 2024 -0700
> > 
> >     manual/locked: Add single-threaded spin_is_locked() test
> >     
> >     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
> >     This bug results in the following output:
> >     
> >             Test CoWW+sil-lock-sil-unlock-sil Allowed
> >             States 0
> >             No
> >             Witnesses
> >             Positive: 0 Negative: 0
> >             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
> >             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
> >             Time CoWWW+sil-lock-sil-unlock-sil 0.01
> 
> Maybe you better re-run this with the updated litmus test file.  Those 
> two lines aren't right.

Hah!  I forgot to update the name of the test within the file.  Fixed
now, again, thank you.

							Thanx, Paul

------------------------------------------------------------------------

C self-deadlock
(*
 * Result: DEADLOCK
 * 
 * Locking self-deadlock on process 0.
 *)
{
}

P0(spinlock_t *sl)
{
	spin_lock(sl);
	spin_lock(sl);
	spin_unlock(sl);
	spin_unlock(sl);
}

