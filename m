Return-Path: <linux-kernel+bounces-561336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B795A61032
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B174188598C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA71FDA99;
	Fri, 14 Mar 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWbXEBcO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633923C6BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952476; cv=none; b=HY3QJjYo+ttHrxuutmrY4SOB/IAiac6g6J0jGd7NDTUhETyb4qzcQeNi5DKVz6OF7QLSNJ9Aqn3wE+vHxXPmr53c7JEShqoZO8BZLkwfyS5mDYNJGVq8d1LGZJzjErUTwUOjEP97v0QCSUjxCL9LStRp/lXNISz3eGTNzBNE0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952476; c=relaxed/simple;
	bh=mGpMQK9vBNZAcu3QbUZ3xRBV7Yu4mpqzLVr7hHabD14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccxpL/EKHJWJEmCm6uExGpV4kIne6I+SmLyZrQ3x33kPj3vmxtS5F6JlTgMOh9heotS5LpoSzR1q/mGb3sHFzmTWi4MlVqrPpKA5xTjWTpePdJcXfURAdJDmF4Y/Xxka3ITypv3hY0e43YiE3g6gIL7/DU6T+xKsg30wnE4jTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tWbXEBcO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WM6QJni32QZqjOwkvpiimTUJhr1ijJEGttqD4uw+t5U=; b=tWbXEBcOH9GRwHaN+gEIPuXAlf
	G5WfIaC8ir8NFXAnx3xuBbJw4i1xMTM37ptXdJGaECAul+0MbU6t2BTNB+I8YYOAnm3OcpzmuqSrg
	xEQzO539O5izVh1WSc+vY2o8yzUjWTfVDfOTkZnyX9bcZMeZWb2N+Ai7ZiZUOKyI4jObNi0UHQNZ9
	059F4E9JUZZB4ttmDg20lk/puKwbl6ZwA0b6xMN6Yija8UxCzqPSnLVVJI0VzTrmr8iqKUwz6KelU
	yOcNNtKqKfZajTxRbvIKx8QCg8Py3oFXuNGcz9nNNggjLLJMGXcWhfs2nG7vAnbx0CDj3WhdCPnfP
	ixHRm7iA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt3PT-000000001tv-3mcS;
	Fri, 14 Mar 2025 11:41:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C38E3006C0; Fri, 14 Mar 2025 12:41:02 +0100 (CET)
Date: Fri, 14 Mar 2025 12:41:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314114102.GY5880@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314112808.-XVssA31@linutronix.de>

On Fri, Mar 14, 2025 at 12:28:08PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 11:58:56 [+0100], Peter Zijlstra wrote:
> > On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:
> > 
> > > @@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
> > >  		struct futex_private_hash *free __free(kvfree) = NULL;
> > >  		struct futex_private_hash *cur, *new;
> > >  
> > > -		cur = mm->futex_phash;
> > > +		cur = rcu_dereference_protected(mm->futex_phash,
> > > +						lockdep_is_held(&mm->futex_hash_lock));
> > >  		new = mm->futex_phash_new;
> > >  		mm->futex_phash_new = NULL;
> > >  
> > 
> > Same thing again, this makes no sense.
> 
> With "mm->futex_phash" sparse complains about direct RCU access.

Yeah, but sparse is stupid.

> This makes it obvious that you can access it, it won't change as long
> as you have the lock.

It's just plain confusing. rcu_dereference() says you care about the
load being single copy atomic and the data dependency, we don't.

If we just want to shut up sparse; can't we write it like:

	cur = unrcu_pointer(mm->futex_phash);

?

