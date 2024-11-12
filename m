Return-Path: <linux-kernel+bounces-406089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3670A9C5ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF36285A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530FD13F435;
	Tue, 12 Nov 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a2EVLYG2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5D157A6B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422873; cv=none; b=exnpdySMsIypDRf72su3g54HTbPEb0YboJd23yhRYl9bLPn+o7hOlXeAyLoB1uMHnZZxc4h120fvziyLL0nMQTtbNJScI+OBqnNnh6sqUz10w/2eEWvz6U9POZ/zeVJnWO0PJyTh6WCCEJOdJaPreyDOz3bUoLoSRMN8smUUDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422873; c=relaxed/simple;
	bh=Yoyeqsapt7tklSCZi4/ywJyrsJEUWuKuj94vvJBIHHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ/NRyPqW26d2V30KpmnY8gLWF2S+IuP2hen60hIWKvrZnwnf0rHrJ6KeK/B+/l5DBRrPhd8AKqYWmIe57j9sY/A11iihvznNTSdOADk03l3TnAqsXZh5kYeszDURDMNXZibRYC50uMCcF+L0V0f5Jg8M3mzd2Er8juAL2qu3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a2EVLYG2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PU64mmPnOvKd4KVuD1fcvIJcn8tA4pUYomyjVH/x1fo=; b=a2EVLYG2uzn1ArpiCRcaN4q0db
	o+C9v1SGk9SU0mWtq9IWWTJRgmgtqZqRLaPBZQgwmao4eH7EZmqOUWuAJoKJHO7IbYmPZMPCqZ9dI
	KvPP3tQKnH3vtW/tJ+6l0LpMOyKbsT9jvqH6yFSjumWPMBRAi/tzLlRSnyIhecFqrCWE5JGE3DjEF
	ztzNnr2pJcKK8MPBL1/jKJUF6098HJU2aC5XrvZNN3qKd3c5FPFpE9OyPub6+y61vThW4ZTWX9fxm
	8VlzOxvypzIT4FRjLaTy05bGwXxgQY0Mj6D57MXiSIs+25yYkZdpsTbgJkccWv9S7k1MrN7kDj5zm
	EVmQPcJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAsBA-0000000EX16-20UP;
	Tue, 12 Nov 2024 14:47:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2D84300478; Tue, 12 Nov 2024 15:47:39 +0100 (CET)
Date: Tue, 12 Nov 2024 15:47:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Florian Weimer <fweimer@redhat.com>,
	Carlos O'Donell <carlos@redhat.com>, DJ Delorie <dj@redhat.com>,
	libc-alpha@sourceware.org
Subject: Re: [PATCH v1 1/1] rseq: Validate read-only fields under DEBUG_RSEQ
 config
Message-ID: <20241112144739.GJ6497@noisy.programming.kicks-ass.net>
References: <20241111192214.1988000-1-mathieu.desnoyers@efficios.com>
 <20241112100419.GN22801@noisy.programming.kicks-ass.net>
 <f76b79c0-070a-44d6-ac8b-71d063f2357a@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76b79c0-070a-44d6-ac8b-71d063f2357a@efficios.com>

On Tue, Nov 12, 2024 at 09:27:23AM -0500, Mathieu Desnoyers wrote:

> Your approach looks indeed better than mine, I'll steal it with your
> permission. :)

Ofc.


> > > +#ifdef CONFIG_DEBUG_RSEQ
> > > +	/*
> > > +	 * Initialize the in-kernel rseq fields copy for validation of
> > > +	 * read-only fields.
> > > +	 */
> > > +	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
> > > +	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
> > > +	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
> > > +	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
> > > +		return -EFAULT;
> > > +#endif
> > 
> > So I didn't change the above, but wouldn't it make more sense to do
> > rseq_reset_rseq_cpu_node_id() here, but without the validation?
> 
> Indeed we could do this (for both DEBUG_RSEQ={y,n}), but it would add extra
> useless stores to those userspace fields on rseq registration, which is
> performed on every thread creation starting from glibc 2.35. The
> rseq_set_notify_resume() invoked at the end of registration ensures that
> those fields get populated before return to userspace.
> 
> So I am not against a more robust approach, but I'm reluctant to add redundant
> work on thread creation.

Ah, indeed. Oh well..

