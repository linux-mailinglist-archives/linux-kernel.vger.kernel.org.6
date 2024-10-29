Return-Path: <linux-kernel+bounces-387876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA619B5716
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC421C20A74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A320BB5B;
	Tue, 29 Oct 2024 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWqyES66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035B20B211;
	Tue, 29 Oct 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245321; cv=none; b=IcMOjmtwUeajSEnzDUgS4dj0kbha0x7zZQVDmx3WT03WfOybXmemoF2EDgd6+2xR85gYVN9bJI0oUTrOgNsBKpfiXvnKHS2VjYRQ/mke5F9V5OV6L98WLnfQrkhSxQlhwoUeDQJeMvJJo5726iTdlx5Ecd2j5ircFqfjKIkA/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245321; c=relaxed/simple;
	bh=CvmkETPxv0MWjCrCLZUXOtbYzwBXnMlUmhyB5wBQeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGzMlZV8QuRID4UJ6MglHjy8IjJEjWWNEIwd6Fx2SZtN/SR5afOMb7U0zMxEMnhOZVvNrc9P1Dwg+CedNkqjm/DpjGvJ5/Q0XtsmkxGYw+Kh0zX+0PGf56M597+b+/b+ErC9LT8pRbYPL8hax1pxUCN3vVKj9i1wWG/lCpaDdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWqyES66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDD2C4AF0D;
	Tue, 29 Oct 2024 23:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245320;
	bh=CvmkETPxv0MWjCrCLZUXOtbYzwBXnMlUmhyB5wBQeJE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fWqyES66Ens8uIw92DAzIbIzvZKt/+C8rYongoqbYaSRzAcUMgPWBjl8PikmzMLIw
	 H4YZcHhGBdCNfmet/suAE+0fMX0D1oiT+4w1q+wNgKA3NhfxhzzamMN8eCbvXpydcq
	 5/aOp4DI8mfmRIKmJoqY90flZa+7TwiXW63bdfhxOYmKj6/cA83T75SIRA1WfNDlPx
	 rpX850tyigvKG1sM2FEklC9jErLCdCq+mnijP25FFOyG23QlFkyKimZTdXBjS+pb/I
	 7dMtPWkEca6zneYILUNHHcFCeHh/e0n/63wl/kZUBM+a0YjEeyBBxYNroSFJDSOdP9
	 U1uEI2RhAA+Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CFD4CE0B68; Tue, 29 Oct 2024 16:42:00 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:42:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
	quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 4/5] tools/memory-model: Switch to softcoded herd7 tags
Message-ID: <b5df91f5-4b48-440b-9445-b8de0bd3260f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-5-jonas.oberhauser@huaweicloud.com>
 <ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyAmlh5GDBsqY0sZ@Boquns-Mac-mini.local>

On Mon, Oct 28, 2024 at 05:04:38PM -0700, Boqun Feng wrote:
> On Mon, Sep 30, 2024 at 12:57:09PM +0200, Jonas Oberhauser wrote:
> > A new version of herd7 provides a -lkmmv2 switch which overrides the old herd7
> > behavior of simply ignoring any softcoded tags in the .def and .bell files. We
> > port LKMM to this version of herd7 by providing the switch in linux-kernel.cfg
> > and reporting an error if the LKMM is used without this switch.
> > 
> > To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
> > RMW which do not return a value and define atomic_add_unless with an Mb tag in
> > linux-kernel.def.
> > 
> > We update the herd-representation.txt accordingly and clarify some of the
> > resulting combinations.
> > 
> > (To be) Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> One bit below:

Jonas, if you agree, please feel free to send this as an updated patch
5/5 or as a separate patch.  Either way, just let me know!

							Thanx, Paul

> > ---
> >  .../Documentation/herd-representation.txt     | 27 ++++++++++---------
> >  tools/memory-model/README                     |  2 +-
> >  tools/memory-model/linux-kernel.bell          |  3 +++
> >  tools/memory-model/linux-kernel.cfg           |  1 +
> >  tools/memory-model/linux-kernel.def           | 18 +++++++------
> >  5 files changed, 30 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> > index ed988906f2b7..7ae1ff3d3769 100644
> > --- a/tools/memory-model/Documentation/herd-representation.txt
> > +++ b/tools/memory-model/Documentation/herd-representation.txt
> > @@ -18,6 +18,11 @@
> >  #
> >  # By convention, a blank line in a cell means "same as the preceding line".
> >  #
> > +# Note that the syntactic representation does not always match the sets and
> > +# relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
> > +# lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
> > +# link, and W[acquire] are not included in the Acquire set.
> > +#
> >  # Disclaimer.  The table includes representations of "add" and "and" operations;
> >  # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
> >  # "andnot" operations are omitted.
> > @@ -60,14 +65,13 @@
> >      ------------------------------------------------------------------------------
> >      |       RMW ops w/o return value |                                           |
> >      ------------------------------------------------------------------------------
> > -    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
> > +    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
> 
> Not in this patch, but don't you need to update this again to all cap
> to match your changes in patch #5? ;-)
> 
> Regards,
> Boqun
> 
> >      |                     atomic_and |                                           |
> >      |                      spin_lock | LKR ->po LKW                              |
> >      ------------------------------------------------------------------------------
> >      |        RMW ops w/ return value |                                           |
> >      ------------------------------------------------------------------------------
> > -    |              atomic_add_return | F[mb] ->po R*[once]                       |
> > -    |                                |     ->rmw W*[once] ->po F[mb]             |
> > +    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
> >      |               atomic_fetch_add |                                           |
> >      |               atomic_fetch_and |                                           |
> >      |                    atomic_xchg |                                           |
> > @@ -79,13 +83,13 @@
> >      |            atomic_xchg_relaxed |                                           |
> >      |                   xchg_relaxed |                                           |
> >      |    atomic_add_negative_relaxed |                                           |
> > -    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
> > +    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
> >      |       atomic_fetch_add_acquire |                                           |
> >      |       atomic_fetch_and_acquire |                                           |
> >      |            atomic_xchg_acquire |                                           |
> >      |                   xchg_acquire |                                           |
> >      |    atomic_add_negative_acquire |                                           |
> > -    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
> > +    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
> >      |       atomic_fetch_add_release |                                           |
> >      |       atomic_fetch_and_release |                                           |
> >      |            atomic_xchg_release |                                           |
> > @@ -94,17 +98,16 @@
> >      ------------------------------------------------------------------------------
> >      |            Conditional RMW ops |                                           |
> >      ------------------------------------------------------------------------------
> > -    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
> > -    |                                |                 ->rmw W*[once] ->po F[mb] |
> > -    |                                | On failure: R*[once]                      |
> > +    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
> > +    |                                | On failure: R*[mb]                        |
> >      |                        cmpxchg |                                           |
> >      |              atomic_add_unless |                                           |
> >      |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
> >      |                                | On failure: R*[once]                      |
> > -    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
> > -    |                                | On failure: R*[once]                      |
> > -    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
> > -    |                                | On failure: R*[once]                      |
> > +    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
> > +    |                                | On failure: R*[acquire]                   |
> > +    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
> > +    |                                | On failure: R*[release]                   |
> >      |                   spin_trylock | On success: LKR ->po LKW                  |
> >      |                                | On failure: LF                            |
> >      ------------------------------------------------------------------------------
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index dab38904206a..59bc15edeb8a 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -20,7 +20,7 @@ that litmus test to be exercised within the Linux kernel.
> >  REQUIREMENTS
> >  ============
> >  
> > -Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> > +Version 7.58 or higher of the "herd7" and "klitmus7" tools must be
> >  downloaded separately:
> >  
> >    https://github.com/herd/herdtools7
> > diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> > index 7c9ae48b9437..8ae47545df97 100644
> > --- a/tools/memory-model/linux-kernel.bell
> > +++ b/tools/memory-model/linux-kernel.bell
> > @@ -94,3 +94,6 @@ let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
> >  let addr = carry-dep ; addr
> >  let ctrl = carry-dep ; ctrl
> >  let data = carry-dep ; data
> > +
> > +flag ~empty (if "lkmmv2" then 0 else _)
> > +  as this-model-requires-variant-higher-than-lkmmv1
> > diff --git a/tools/memory-model/linux-kernel.cfg b/tools/memory-model/linux-kernel.cfg
> > index 3c8098e99f41..69b04f3aad73 100644
> > --- a/tools/memory-model/linux-kernel.cfg
> > +++ b/tools/memory-model/linux-kernel.cfg
> > @@ -1,6 +1,7 @@
> >  macros linux-kernel.def
> >  bell linux-kernel.bell
> >  model linux-kernel.cat
> > +variant lkmmv2
> >  graph columns
> >  squished true
> >  showevents noregs
> > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > index a12b96c547b7..d7279a357cba 100644
> > --- a/tools/memory-model/linux-kernel.def
> > +++ b/tools/memory-model/linux-kernel.def
> > @@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
> >  atomic_read_acquire(X) smp_load_acquire(X)
> >  atomic_set_release(X,V) { smp_store_release(X,V); }
> >  
> > -atomic_add(V,X) { __atomic_op(X,+,V); }
> > -atomic_sub(V,X) { __atomic_op(X,-,V); }
> > -atomic_and(V,X) { __atomic_op(X,&,V); }
> > -atomic_or(V,X)  { __atomic_op(X,|,V); }
> > -atomic_xor(V,X) { __atomic_op(X,^,V); }
> > -atomic_inc(X)   { __atomic_op(X,+,1); }
> > -atomic_dec(X)   { __atomic_op(X,-,1); }
> > -atomic_andnot(V,X) { __atomic_op(X,&~,V); }
> > +atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
> > +atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
> > +atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
> > +atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
> > +atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
> > +atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
> > +atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
> > +atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
> >  
> >  atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
> >  atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
> > @@ -144,3 +144,5 @@ atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
> >  atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
> >  atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
> >  atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
> > +
> > +atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
> > -- 
> > 2.34.1
> > 
> > 

