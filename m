Return-Path: <linux-kernel+bounces-181422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 678AD8C7BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D1EB23077
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FD156238;
	Thu, 16 May 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvSuQdES"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2014D457
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882008; cv=none; b=uD5ihQCcjwMOibIAtOerhBg0wAL+knvaTYJmTd6QupmGyFoyCixzIXma162V+7Tea7OChc36WuacMlXJHhvUD4z3m8FUTYfqU9AWjHU0wgHg3BfzAaXuwvDXu9VErJJTh9v3XNcStGfBJ3Mm2mntD0qKcbF7Pxlh1OTDWL3vSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882008; c=relaxed/simple;
	bh=PXXsy1vuFtGyoNlHHSR8xTWBE0S55BXma7bKe4Je6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UPUbWvezM5uytA66SYGAqybkGM/Dyd0V5RFxS5tma0wBN9y00y874udKIpkKrX1zwbsjcfqE4BEAWlK5Voa0Mw5taqD6u/xN7wOcqKwCGEryFwsLQBsHepvFbv/kIwhZzYElQHBPofElveGg++0bLJ5ADDNkSQyX2aIbvByQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UvSuQdES; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JZ8dIVPdliawbwUcKrUeitOAz8xKG5PgkXSZmGQa9D4=; b=UvSuQdESm81j8qVqZLrsfFXdHd
	gRs10BA65Kv8cpXTTmuh9WepRZTt9KxErvu0Jqi5m8suw4U/j8GgY0DIRRqk8+5hlZ352vEG0AVSD
	G5LEIE0poHMWnIcdczG6gJUV2K3DG0o8kJNQdRefrW+PIHcogEhguQZaMaZXe5hY/jgr/4nLIWPvL
	Zg/DpFA04icWBk0qt1bS2umQr7HwLIeOx436DhKlpFxQ2D92KlHpfZpq+Q/hOXYaVVbMGmDlMpAiM
	YoMPNfQ4T2JdfeY/stDro9hPEDSwTckQ3I5nhG3PYIVmgG4K4ZuoAIIQKQPJd+4bMn12stg85TEXk
	GASg3Mfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7fIA-0000000C3mA-2EHl;
	Thu, 16 May 2024 17:53:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFC3630068B; Thu, 16 May 2024 19:53:21 +0200 (CEST)
Date: Thu, 16 May 2024 19:53:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516175321.GN22557@noisy.programming.kicks-ass.net>
References: <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net>
 <ZkYgG9KYMpUPeJsM@lothringen>
 <20240516151953.GM22557@noisy.programming.kicks-ass.net>
 <ZkYnKAd1Qy+yvjDY@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkYnKAd1Qy+yvjDY@lothringen>

On Thu, May 16, 2024 at 05:32:56PM +0200, Frederic Weisbecker wrote:
> On Thu, May 16, 2024 at 05:19:53PM +0200, Peter Zijlstra wrote:

> > Yes, but stronger, as long as the CPU is part of a load-balance domain,
> > it must not disable the tick while running anything.
> > 
> > that is, NOHZ_FULL must not become active unless it's running on a
> > single CPU partition.
> 
> I like the idea but I'm afraid to introduce regressions while doing so,
> with people currently using nohz_full without proper partionning...

There is no regression, if this is possible today it is utterly broken.

This should never have been possible.

