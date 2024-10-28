Return-Path: <linux-kernel+bounces-384690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F69B2D40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063BF1C21A32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6591D2F73;
	Mon, 28 Oct 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tEaP/Jro"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24E192580
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112408; cv=none; b=qMKG3PlZ7yybK0V224HOLjGmTmCWUUJN2IWFttO7622u/0spiXiC20Fg7a1WNEsdVFisuCZSgaVZIE2lZYYmTljJb4gZ7kEiVSTsp6iXdm+Y/XH0+EfIuhaMVHnfKsSC3Qe6auFJou9aaULKqwS7gx9SRL7eaNyf8jzykzdRPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112408; c=relaxed/simple;
	bh=uqGd+5K0IS/guLWphRp8p0UNHM8STaKdQNsrlDdqgzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSO9X9jKIAy0bhfIOugyEQUmFuyK3guqDAXXg6OboEW+FDkieT48sAvJMDFsHq9H95OwnPXxx1dSUcFm4Xutq6dNK2r+9XG2fK72XhtxzRBqm/0SaZFzs0K6y1KNj5LnCK7gdxgFMjAyQDmuVcFfOK4a8KEUwElzKmz2/cNVa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tEaP/Jro; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNBVnpnxclIi2HMW+gqI4liCLPIUUouhrXh4IESKQEk=; b=tEaP/JrogOSGYT/n7wYKCBaFJW
	MK3RHTold6i6rBJV+/CfwbThE8T3PYHbL+UKWyHYRMmkotZTmv6ge+CURmjJeiyBbHc6rUW9MNeFh
	ZnN2I5wsZRsgkm5P9N2UzkGC86uyUclz4E7PmeVg4Bp+Ub3Uds1fwAONyrTQ/KCCh3gROLhD7FFRW
	8zOWY6uNsxZWVrOPQoD8/qMr48NKvQqOemGgLE4jwH0EjkDMK8rcnZsb8MfnD03lZNe+94fpisg8d
	b8dVvUL336ZGrrv/kRf5zwsFESAMj/RsdwRnH7GXscBPO3VIuzJRoXirV9dRC/CNS1i9fzOU6hLJR
	CFxGE4lg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NGh-00000008IHC-2H5A;
	Mon, 28 Oct 2024 10:46:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7155030083E; Mon, 28 Oct 2024 11:46:39 +0100 (CET)
Date: Mon, 28 Oct 2024 11:46:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241028104639.GO9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <20241028101633.GM9767@noisy.programming.kicks-ass.net>
 <20241028102408.GbFgnLMF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028102408.GbFgnLMF@linutronix.de>

On Mon, Oct 28, 2024 at 11:24:08AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-10-28 11:16:33 [+0100], Peter Zijlstra wrote:
> > On Sun, Oct 27, 2024 at 12:34:51AM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > > Introduce a task local hash map. The hashmap can be allocated via
> > > 	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_ALLOCATE, 0)
> > 
> > Per process, per task is useless and will make things malfunction.
> > 
> > Things missing in this patch are CLONE_THREAD / CLONE_VM, and create
> > must be absolutely forbidden once mm_users != 1.
> 
> I moved this to struct signal_struct and limited it for now to the
> group leader.

That works I suppose.

'process' is a really dodgy thing in Linux anyway :/

So CLONE_THREAD implies CLONE_SIGHAND, and CLONE_SIGHAND in turn implies
CLONE_VM -- however, you can do CLONE_VM without either SIGHAND or
THREAD, (or SIGHAND|VM without THREAD).

And it all quickly becomes a real mess.

'Sane' userspace doesn't play such games, and insane userspace gets to
keep the pieces I suppose.

