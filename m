Return-Path: <linux-kernel+bounces-385011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F99B315F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4115B21F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F21DACBF;
	Mon, 28 Oct 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bXKI0SnL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E6EDE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121049; cv=none; b=oe/JS44jYPv/JaBEopKn0R0lYkUPaKtzObo/st8vijCpIyi29c0pJgaG7qbeEcktlNGPrQ9wWkSUAighH9EMxIYJaJwdxuzsi8vo5lEqKbogSrdM8VQq8RiKXtF4D3AwxaCJsOAeG3crEr3g9Jb8IAXsZprXwwFHjZO1Knkzq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121049; c=relaxed/simple;
	bh=dL1SJrGZQ3D6lWB7/Wyjb/bBXGMBAdqEk7Evxm5pNAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z17uiTdOTzWT1Qckqrr/TZLCeooZ06hWHJvGl9RZ9Xr6jNIDLqnACIza5sQ6o8SO2R8iGTdklljXBCOvurr2DTBRW79zi2bCRE1Uf5mZlhpdM8XCFmIzkk7TpRb6JkvgtpC5PTA/tE6kUy2rzAneEVwl7Bc45XLIBNtEqOhf4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bXKI0SnL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R8Dd+hjRXMeDXiIrfyLDS2ZFM1n3uCxyFjkAA3L4QU4=; b=bXKI0SnLh0Qe+ZLp56MxjgknWE
	YkSij99o5z/F/Ojudl6uXGazbkQfOf6ayvfGpe0Ew6toZs3E34rPmrxvJDhlPolAGAK5Ns6VgZXnK
	U6keLUwtMX0CWkMC3WoPFsd+KPAAbJ2SOJX7dET0YGC4i3Sgns+miQZL+hcPIKeRJh4md22kV++x3
	Zufysd/7MuYWnF6pWm9r0rAXh8tKutLoXuTsd+q1dNENx1Bc2mn8FdXUaPNSEUuSpvKT/eg0vgLfE
	MfG+Zulm5BWiHg21c0PYROemYMYLuEAe6CKbRu4SxzsKaG0ik9+ho8BLAfMuTMgKMSQSuFTQ+15KY
	DGJxytyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5PW6-00000008WfT-0NU9;
	Mon, 28 Oct 2024 13:10:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D35E030083E; Mon, 28 Oct 2024 14:10:41 +0100 (CET)
Date: Mon, 28 Oct 2024 14:10:41 +0100
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
Message-ID: <20241028131041.GT33184@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
 <20241028101633.GM9767@noisy.programming.kicks-ass.net>
 <20241028102408.GbFgnLMF@linutronix.de>
 <20241028104639.GO9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028104639.GO9767@noisy.programming.kicks-ass.net>

On Mon, Oct 28, 2024 at 11:46:39AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 11:24:08AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2024-10-28 11:16:33 [+0100], Peter Zijlstra wrote:
> > > On Sun, Oct 27, 2024 at 12:34:51AM +0200, Sebastian Andrzej Siewior wrote:
> > > 
> > > > Introduce a task local hash map. The hashmap can be allocated via
> > > > 	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_ALLOCATE, 0)
> > > 
> > > Per process, per task is useless and will make things malfunction.
> > > 
> > > Things missing in this patch are CLONE_THREAD / CLONE_VM, and create
> > > must be absolutely forbidden once mm_users != 1.
> > 
> > I moved this to struct signal_struct and limited it for now to the
> > group leader.
> 
> That works I suppose.
> 
> 'process' is a really dodgy thing in Linux anyway :/
> 
> So CLONE_THREAD implies CLONE_SIGHAND, and CLONE_SIGHAND in turn implies
> CLONE_VM -- however, you can do CLONE_VM without either SIGHAND or
> THREAD, (or SIGHAND|VM without THREAD).
> 
> And it all quickly becomes a real mess.
> 
> 'Sane' userspace doesn't play such games, and insane userspace gets to
> keep the pieces I suppose.

Bah, I now remember there used to be (or maybe there still are, who
knows) a JVM that used a 'naked' CLONE_VM. And JVMs are also known to
use futex.

That would suggest putting the hash in mm_struct *or* make sure to
disallow / warn about these private hash when !CLONE_THREAD.


