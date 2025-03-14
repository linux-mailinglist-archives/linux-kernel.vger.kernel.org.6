Return-Path: <linux-kernel+bounces-561307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186CA60FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138DB164569
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA01FCFF2;
	Fri, 14 Mar 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+31LRJn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwwcrMYq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C915D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951693; cv=none; b=aZafhFKm5bvYnuMKVWFRUczhVC5FcNkF9F6paWrJtDGW64NRDLq9QT/zy5J0td0JbdS0Ko+ZX/pyKgoDpEWnlRDx/9QBz74H2txKtGzVszESfPQkuvk+ztBOJzUnSCEBLpRmTWj8RdxLlFme30c4xLJuIK9G8w4zplmU9xZKXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951693; c=relaxed/simple;
	bh=VijPbBQvRH3f8DwcTrpuF3ZMh9hz9TJnwK8Id2VP6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onFC0i/eDm5/pRa1m6AUKGqOmtqoUQW81NszcAptPOLTMz/2JGRJFPiZFXCY6wAMPTsCLkGSSAcobAypIfYq2cPcV374cA2wzb/D0ctnA9ep46OsGgg9iSfo7VWoJWCI9zTXbQlm9omkfxg0kixx3y5ABdM/6se1SQBG55yXKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+31LRJn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwwcrMYq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741951690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2wPlf22XBcrTV7ddhdC02TRmOZbwlazzbyfqm2zjZ8=;
	b=Z+31LRJngHHM9VAkIYgRk8mHbku1QbCAALFr6DLBnvDZGjGF04Ee24VPkvhVrU5+/I80/l
	hZhcmdrEz2t6j4IywIlZiKDLIS+mL7k9eyYfZaQ4Y0511XBAkzAjbkBDPspzroAMFe0kUo
	r2GuQ1SUTw8yTwLelC6K9T/xFih/iFkx11beWEjkrODDanghhm2ciiihxTLsjsqLfDG5Tv
	gLfutZ0NdmVspr5jZIWe4hvcf4gr25DcHLtBy+0b6p49AzNWe/3VJANUEwaBlJwLkzsnzQ
	4WyFSW9Kk3uYcv/sNN+qVUGjDjdMDe8ptDLI8h1CbAgMi+SD9Xu90krzZvilyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741951690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2wPlf22XBcrTV7ddhdC02TRmOZbwlazzbyfqm2zjZ8=;
	b=GwwcrMYqMFwnjlKQRi8s2o0h/oEe39PT5hdTqGGCJWxOf7YJazBNQjjpuXD69fOCsfMh+z
	PTuVcz0q04IrpjBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314112808.-XVssA31@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314105856.GB36322@noisy.programming.kicks-ass.net>

On 2025-03-14 11:58:56 [+0100], Peter Zijlstra wrote:
> On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:
> 
> > @@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
> >  		struct futex_private_hash *free __free(kvfree) = NULL;
> >  		struct futex_private_hash *cur, *new;
> >  
> > -		cur = mm->futex_phash;
> > +		cur = rcu_dereference_protected(mm->futex_phash,
> > +						lockdep_is_held(&mm->futex_hash_lock));
> >  		new = mm->futex_phash_new;
> >  		mm->futex_phash_new = NULL;
> >  
> 
> Same thing again, this makes no sense.

With "mm->futex_phash" sparse complains about direct RCU access. This
makes it obvious that you can access it, it won't change as long as you
have the lock.

Sebastian

