Return-Path: <linux-kernel+bounces-561411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA3A6114B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402543BC66E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996111FDE00;
	Fri, 14 Mar 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGPJkhsG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0C1EB36
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955471; cv=none; b=bEag6LaTI21MF+mPjqRjDaOXnvxnVMDM2OS7H19l/FyT5nULvmsuFsRka+MxYC7qeihsvwYPiwJWAzYQUsbiiFVotnULMLkH7SSEUvV6t8CYeoCaxitv2bu1d0od2fK4reHnBksnL4MSEmy2+zM1BwSEfuA6ipqbeA0Zk7gUy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955471; c=relaxed/simple;
	bh=n9vrKA7KIAZ3OhvZBuzNyNFnCkabPGC9jOn4nou+aTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBslLQVtD1lngKKh0vahYb+02+/aN2b6SMQC8SWfXp7hjTAsU5McxbqM9/khPmhictwkQ6gP3N+q4hCiIusCMeVbOBo9dRDbsn5ppXkRGGXFo0Rml+zyNA3Pc7MApAvYzmopIOrGA82ifey2/YJx04HeXiviyMCxXRPb1LtWMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HGPJkhsG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=74LXG6fqE7Yzr6n+DClMisIrspCPDo2X8rd2xzILxR8=; b=HGPJkhsGTaQ03EFBJtJZ3/ITAh
	D13Znc65EwQbW7C72l9YgzqGwYSQLMjZifVe1N3JeIv0JHjgLoBoEGDxEd6e+P8h+vNVVaRK5OE6p
	H/nbQfxWPYRudWz+d4qe6RcneWmwNVKIf8f8s9WbyPunRhnKQF+ePjdmkGRquApVolxx+FJTXQQl6
	eXkXC/u3qHpKTs364qfe5SEEaKL3ybtHkreG6vQ8sXdAgYECiGWUWzStVJ2er9KzQDMI5CrBksq+b
	g81S86jgSPoYMm3JFczJ3bsP84HtpjtWEYVBLTvFCF/mW4tzUjBeLpSgpjYjMeNBR8QBq+WAom28N
	liEa5uLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt4Bn-00000002tWq-0pEN;
	Fri, 14 Mar 2025 12:30:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17153300599; Fri, 14 Mar 2025 13:30:58 +0100 (CET)
Date: Fri, 14 Mar 2025 13:30:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314123058.GZ5880@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
 <20250314114102.GY5880@noisy.programming.kicks-ass.net>
 <20250314120057.NcjcFp3K@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314120057.NcjcFp3K@linutronix.de>

On Fri, Mar 14, 2025 at 01:00:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 12:41:02 [+0100], Peter Zijlstra wrote:
> > On Fri, Mar 14, 2025 at 12:28:08PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-03-14 11:58:56 [+0100], Peter Zijlstra wrote:
> > > > On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:
> > > > 
> > > > > @@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
> > > > >  		struct futex_private_hash *free __free(kvfree) = NULL;
> > > > >  		struct futex_private_hash *cur, *new;
> > > > >  
> > > > > -		cur = mm->futex_phash;
> > > > > +		cur = rcu_dereference_protected(mm->futex_phash,
> > > > > +						lockdep_is_held(&mm->futex_hash_lock));
> > > > >  		new = mm->futex_phash_new;
> > > > >  		mm->futex_phash_new = NULL;
> > > > >  
> > > > 
> > > > Same thing again, this makes no sense.
> > > 
> > > With "mm->futex_phash" sparse complains about direct RCU access.
> > 
> > Yeah, but sparse is stupid.
> 
> I though we like sparse.

I always ignore it, too much noise.

> > > This makes it obvious that you can access it, it won't change as long
> > > as you have the lock.
> > 
> > It's just plain confusing. rcu_dereference() says you care about the
> > load being single copy atomic and the data dependency, we don't.
> > 
> > If we just want to shut up sparse; can't we write it like:
> > 
> > 	cur = unrcu_pointer(mm->futex_phash);
> > 
> > ?
> 
> But isn't rcu_dereference_protected() doing exactly this? It only
> verifies that lockdep_is_held() thingy and it performs a plain read, no
> READ_ONCE() or anything. And the reader understands why it is safe to
> access the pointer as-is.

Urgh, so we have a rcu_dereference_*() function that does not in fact
imply rcu_dereference() ? WTF kind of insane naming it that?

But yes, it appears you are correct :-(

