Return-Path: <linux-kernel+bounces-554632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784AA59AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02B418917D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AED22F39F;
	Mon, 10 Mar 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZjjD7aK+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929C22DFED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622999; cv=none; b=B1ta2LWk9eY7aiZ3ukDyfkkdeLHJlheO91FTHPJFXIXqvrSnJoHtQY8CIMBiZsEGDvL6dAoPz5qMZ8bvo1CC+xN+vtnnm400M5/JTwwcizARnJbwIEVhwAbu9jpmqe41zTXk8OAog7aBpVZO6nnJ6r4mt3edETkUqjif0NIzihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622999; c=relaxed/simple;
	bh=RGbEOYg5EIYVE583Aym3kwacUWvpgLSgkDgTcItvahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdSVMZIL0tTVJNXOAMBbOwqkzRPll7zQARXfCB8dUU501T70PHgRbZLUlt33kL0MN8cg5X4g/UV0Ecg76DCA3ZzQ+wlV8/xQ76x8qwkKCnjaog95wqVV0hoLC1eqsaz9qqBbs/2fkrghtum3L99E8z+WdUQrQszL+SwWbet1MYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZjjD7aK+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J6F1S2cZ9UkcPfKFsoptQ0OTp4oA8A+WUNl2JYbbT/Q=; b=ZjjD7aK+pJhkISCZD/ilNaY/so
	Osk/f267yv8me9B/AwDu6l/1wqnEvs/RndrNrlUZYNYAOXL7QoIrdDC6wLkWj0oIaQ/59SX0bg2Rd
	d5kYROu0yXENkBXLgcic5x23ZG4qtA1NNM1vMVh0K8YxZ/i/cVOKR4vI92Rmgdy+ZPt6zX2bPhSUN
	RufYboRN8prgP9niB6QVMgu+b6fNj2LdBnOH449aT580bjdp27BLLQtk4h3D7Y7xP9uHkwJ25ZuHj
	4sUIhJT4Nbd67vEihSnTqFaQSr35IFUngplDRxuuKtG5PX5yORJH8t5OGXXnUMCItENEsCegx6yOA
	O316VMbA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfYt-000000078Vp-0RMm;
	Mon, 10 Mar 2025 16:02:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 543643006C0; Mon, 10 Mar 2025 17:01:02 +0100 (CET)
Date: Mon, 10 Mar 2025 17:01:02 +0100
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
Message-ID: <20250310160102.GG19344@noisy.programming.kicks-ass.net>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
 <20250305090237.2Q9GwRA1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305090237.2Q9GwRA1@linutronix.de>

On Wed, Mar 05, 2025 at 10:02:37AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-04 15:58:39 [+0100], To Peter Zijlstra wrote:
> > hash. That is why I had the `released' member.
> 
> The box was still alive this morning so it did survive >12h testing. I
> would bring back the `released' member back unless you have other
> preferences.

Like I just wrote in that other email; I'm a bit confused as to how this
can happen. If rcuref_put() returns success, then the value is DEAD. It must
then either be decremented below RELEASED or incremented past NOREF in
order for rcuref_read() to no longer return 0.

> Depending on those I could fold the fixes directly into the patches and
> repost the whole thing or prepare you patches that can be folded back
> and send those.

Please, it appears I don't have as much time as I would like :/

