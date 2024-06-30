Return-Path: <linux-kernel+bounces-235339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00F91D420
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1EB2812B2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18BA4F1F8;
	Sun, 30 Jun 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6s+4NXA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvToUXNL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2862AE68
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781913; cv=none; b=H/giRPHzznz9DCbEE4TRghwsABWMyzhkkd4GDBokLap4L3RUEgRlaI2dhOWdYTChyVzfa/gv/uyAjBXFi+bslvcc5nhEGp14oQua/2UYZJ3XevX/2KBA8y70AUSB2HpekGFnWCZpb5uBJC0gJ+/2ajQ0oyZYOWxb770ACNXC2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781913; c=relaxed/simple;
	bh=9IVbg/7h9tWkDj6rjU4NRJb4LI+xMkcd895wr5XWUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBhFCGZcJ3gsWdsDn7teI9KSHOpaxqxZQkPNAoIWNFrpBPMlWxRFovNV+Xd5U0+9zsr5imnrvmHx+tCPgCJngO8tTIGULNW1pjAzr283859glTZodDsOpQL/Hz4wtygGCzc6pcK+Kcxw/1Nywy7Uji9kuSUJZl+lMZ/SsA3/OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6s+4NXA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvToUXNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 30 Jun 2024 23:11:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719781903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LJ97fwBlDVeVlACn6RDQFEjLnnwl6n9BPxelG3QA0=;
	b=b6s+4NXAnpifskUrd/0in6fwOWKf8YqFw8xVYqySjB4p4hXZIgl4QzARv0gLUjRwwsywP9
	rl6vaysw4Sl0LcZ44OKyyGzhtu6HIgY+Ur+JlL3t4UV0ihgM3hKIr6C81CtXrAFZcENPKH
	WaY06V77VaZGFtWYq1yjofpnu9QeJeRGn14WviqcIFO7iH1zEggnpDQTysEWmtuauuhkFw
	UgS+7pAPsLBUVo4TZkOWtRu8PEa/YrHZUpG/EYDGU5qzIjgkKEM1yrkj5kqsj3EUfZG58g
	uOnryichcWhoVRuDeNETU3nbuD77IgX7yW4QivY+QFz4RWm/TJI90+OnR/aggg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719781903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LJ97fwBlDVeVlACn6RDQFEjLnnwl6n9BPxelG3QA0=;
	b=xvToUXNLvO4B/rWJhD30OV3sOIk7mWSejDS/Z4ZfK6rVLW7ob3xVZUz7GZGLQrV2PkL1FB
	XKocILb8fSqX2TAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240630211142.kZAs9f0p@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <20240628094944.QwcHkf8J@linutronix.de>
 <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>
 <20240628195553.G48MpeQ6@linutronix.de>
 <w2qopormdwuh54vropw6sgvadnivjnrgvmpurud2cu6nannfj3@xxrs2r6qt7zi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w2qopormdwuh54vropw6sgvadnivjnrgvmpurud2cu6nannfj3@xxrs2r6qt7zi>

On 2024-06-28 16:20:27 [-0400], Kent Overstreet wrote:
> > Kent, you said you didn't want it where it currently is. Fine. You said
> > you want it at the front next to `flags'. This isn't going to work since
> > there is no space left. You didn't make another suggestion or say how to
> > make room.
> 
> It doesn't need to be on the exact same cacheline, just as near as you
> can get it.

the first possible thing would be somewhere after the scheduler.
However, what difference does it make if it s two cache lines later or
more?  I don't understand the requirement "closer".

Sebastian

