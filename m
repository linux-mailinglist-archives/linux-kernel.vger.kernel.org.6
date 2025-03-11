Return-Path: <linux-kernel+bounces-555864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7EA5BD90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45171881F66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977222FAC3;
	Tue, 11 Mar 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PwNDCz7Q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3922FF21
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688242; cv=none; b=Pu6oVl9Fzl+GDaQGLroF9fb2o4/VopiUqj+LL+P774qZPO8ivjjXgEAAI3y8ylvKHKnX0zXyt65EkoAc+3pm86dK0nTyKCV1wH43TRa3C3WBhXP7lvwWug1HcyUVosmB2YXjs+3p/6cPnVc9WAXXsxquvOo70F6IZDb9t+WxRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688242; c=relaxed/simple;
	bh=S68F0p9DZTIu/HyAQHubLO+Xj56dmvH0z4g7aDCGnsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxtLTdwaBUfl1MlVDTMbCxGNr3ymBb0MU3MdjMxINahCgrskl0yrZqEx2PIiA4accxOw4VFi3XAg0Ptr0vyri4nblS0jmRTtfWfQIcF9uU16W8BIsyaom/bUycK6qUFE+pCwny7TP2oZp57RDTkzRFv4Tt0yPH3lMwMuHJpE/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PwNDCz7Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/fIuRiwIyFbYOrfo9UeCUcec6cgs2iWB52qR01wSLRQ=; b=PwNDCz7QmRKf2FO+fz5BGttAgY
	ldbfe8VizOpKza1lMKk0u6ZgSEBpRQ6oTmttRstrwqk02refECeBnzn9Qv4Zq5/cKSh/EgCZPJTmL
	hQSQc1yhP2CEkAww3gQbTn1e/ZjLRB6uTC0Il9nw8dBqwJJceJ6+gKjGEdGf01ajpM1lIzYWv8XrD
	FAAuEFxLUVL7FvSJN0/wN6RkpmktXy8Y66ofeRqn5U9ZGPJy6IjtGUB/lcHfLIBUoOx59Lq9UUiTm
	YPTlGiqgTGGFqKle9gUYJWQAg4wX52FRnL7ID9A3Kp9g3GiOGYMrNAf9wtRDeTrKyRIgLmGdzDYhQ
	JBS5rSRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trwfi-000000027qG-3GA3;
	Tue, 11 Mar 2025 10:17:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BD063006C0; Tue, 11 Mar 2025 11:17:14 +0100 (CET)
Date: Tue, 11 Mar 2025 11:17:14 +0100
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
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250311101714.GC19424@noisy.programming.kicks-ass.net>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
 <20250305090237.2Q9GwRA1@linutronix.de>
 <20250310160102.GG19344@noisy.programming.kicks-ass.net>
 <20250310162710.K9WY5tzN@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310162710.K9WY5tzN@linutronix.de>

On Mon, Mar 10, 2025 at 05:27:10PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-10 17:01:02 [+0100], Peter Zijlstra wrote:
> > On Wed, Mar 05, 2025 at 10:02:37AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-03-04 15:58:39 [+0100], To Peter Zijlstra wrote:
> > > > hash. That is why I had the `released' member.
> > > 
> > > The box was still alive this morning so it did survive >12h testing. I
> > > would bring back the `released' member back unless you have other
> > > preferences.
> > 
> > Like I just wrote in that other email; I'm a bit confused as to how this
> > can happen. If rcuref_put() returns success, then the value is DEAD. It must
> > then either be decremented below RELEASED or incremented past NOREF in
> > order for rcuref_read() to no longer return 0.
> 
> We can't rely on 0 to be released as it might become active. We could
> change rcuref_read() to return 0 if it could be obtained and -1 if it
> can not.
> We don't have many users atm so an audit should be quick.

Right, so I failed to understand initially. When DEAD it stays 0, but
there is indeed the one case where it isn't yet DEAD but still returns
0.

Making the DEAD return -1 seems like a good solution.

