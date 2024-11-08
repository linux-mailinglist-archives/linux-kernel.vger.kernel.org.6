Return-Path: <linux-kernel+bounces-401301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FC9C187E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2055287194
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AD1DFE3F;
	Fri,  8 Nov 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNyUQPoR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AD47F69
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056070; cv=none; b=H1GN7NP8HmXTZfCOVxnIK0fgFNFoeuwMxXcoQNs4J7edlm7qP/G8XAs3wtPm6VldVyIaAwp8K3zCU9r9JnWdgQ1Qi02HYDwrKchxIJRDCkTznECk5Rb1niGUSnGf+m9OuAlDoPqq8K2TCu9gWaibMLP7hPT2n/D+7/Q4Xnw3yZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056070; c=relaxed/simple;
	bh=VjgEl5vpmDA3y62ssYmWmMIvrNTkWWqVk4IascRENPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaIwXgkI8jTckQLhwmIfO5DQyG1Du+KomyPgdca7UCRXGe0ma8jfmLQb4xac1vwpJ6bg022uHFSaITe/g7cFt+nPjjtd8fyRFIJwK0ybgYp3Du3v/uPJTXhwo3DtQ8F0ZUrcQksCp4NANhNLWyVyOQyq4fbtLk8oVfLe81zQO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNyUQPoR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yf79FXHfTGJLW0g+hLI9OmeHJl+edRD1p43y6vF5eX8=; b=fNyUQPoRE67PhTOM5dhcVHZTaU
	sLDp1NstM8NGXLTSj9HO1hcqsu4rqGCdFJXTmFfTXErdtRCj0eFAKL/l1vasW3JWu4aAtwKwSBPec
	YmVPyM7u0W4GMdoWFjv9AUSf8BJTe0z5sD15eClhTnaLmXqgTWMWfHxOYmCifYUlx143Tn7y0/RH6
	1Q4wUUxcOyETTUFyuI+W4V9kxDQMg5DvroytgBS/4Avi5oqEzAFaJNyFaE0iIRpo12m2tPtLP6I06
	gqzn4sh2ozSpPB21UEaDABtbnQTksqNBSt/jGR32KDtsGVcmNhzo9l11MSjOo1tsolsMYMsS0YcIM
	bk9nkxcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Kl2-0000000CH3e-07gY;
	Fri, 08 Nov 2024 08:54:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E13D30049D; Fri,  8 Nov 2024 09:54:19 +0100 (CET)
Date: Fri, 8 Nov 2024 09:54:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	John Garry <john.g.garry@oracle.com>, tj@kernel.org,
	jiangshanlai@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
	jack@suse.cz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: workqueue lockup debug
Message-ID: <20241108085419.GA6497@noisy.programming.kicks-ass.net>
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>
 <Zy1F4n9KoNybBmoD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy1F4n9KoNybBmoD@dread.disaster.area>

On Fri, Nov 08, 2024 at 09:57:38AM +1100, Dave Chinner wrote:
> On Thu, Nov 07, 2024 at 01:39:39PM +0100, Thorsten Leemhuis wrote:
> > On 24.10.24 17:49, John Garry wrote:
> > > Hi workqueue and scheduler maintainers,
> > > 
> > > As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-
> > > ab6d-7ed9a4f1f9c0@oracle.com/T/
> > > #m506b9edb1340cdddd87c6d14d20222ca8d7e8796, I am experiencing a
> > > workqueue lockup for v6.12-rcX.
> > 
> > John, what this resolved in between? This and the other thread[1] look
> > stalled, but I might be missing something. Asking, because I have this
> > on my list of tracked regressions and wonder if this is something that
> > better should be solved one way or another before 6.12.
> > 
> > [1]
> > https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/
> 
> I'm still seeing the scheduler bug in -rc6.

But that WARN you reported earlier isn't there anymore. So what exactly
are you seeing now?

