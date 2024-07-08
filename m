Return-Path: <linux-kernel+bounces-244139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB22929FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCBD1C212FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272967603F;
	Mon,  8 Jul 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mdO0h3ql"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74A74076
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432528; cv=none; b=MNxDGlOLKpOi6gzjlu9buh0Vr9RRfRDXpTwpDgD1Y8iPXzJ8BfTNxS7iIG6pKTDkVRm9ZbSmPjEEOZ96d+2xno7mGOBQgDERX/yobhsYT3yVenvgpPcjsIgPHG1dwO75UzI5gKvSG2d6aKweO1f1TksAS9wbEi8XBBbblR84DRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432528; c=relaxed/simple;
	bh=jde/grl5A+5PHxKti4gHxQ9Vqj2LMrWdSMaC6OZaxGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHz57HkjUUE6pW3xynWc5tA9m0dsSlee6OdtD576jQAGDkT5m1hamdtvBG9CPUX/tqzgjZWocIjOitu6hmHARwAJvH/3R+AElnpR5i1XXrcDrYsCyTIbw5PMji1/uHQIj+LQvKanQ8QseJuKxkCin3rLNoxsjqrIcNCZKLYZfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mdO0h3ql; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LnVsUsli9cGl9o0UNlqKa/vfbovyOjfyvezGvaTuK2M=; b=mdO0h3qlnMwaQAaS2orJDpGisT
	E+4RpjOWQhHUjMXTQMndLN7DpQz1jBTSFpDDE0+xvB8/Ztbq96AHSaNgWXXAEm02XH/petLh140Ve
	+8Xqa91PUfTfkFtZCrbag2mKB5Z8wyTwIIg+P7TNSFmZEN4KvrtkbflmkK9bd5zGP6W8mGEqRD+DK
	vmKqyKgfq8f17L4at6H2l9uhVryoPU5BsprHMp/NDn7lS5yrZlGsgfQuJJd7PDM5MDGrUCrN6sh9G
	SMKg5Ir0uUA603KnttXAeniNSXqGxNtdcis2sEVu1+uOQErCIENPNwWycCWEwKkrpOgCCjmhKnZx3
	i7LSsESg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQl5c-00000006iYi-37BX;
	Mon, 08 Jul 2024 09:55:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BAC5300694; Mon,  8 Jul 2024 11:55:20 +0200 (CEST)
Date: Mon, 8 Jul 2024 11:55:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ingo Molnar <mingo@kernel.org>, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: sched: Update MAINTAINERS
Message-ID: <20240708095520.GI11386@noisy.programming.kicks-ass.net>
References: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.21.2407081038350.38148@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2407081038350.38148@angie.orcam.me.uk>

On Mon, Jul 08, 2024 at 10:47:18AM +0100, Maciej W. Rozycki wrote:
> On Mon, 8 Jul 2024, Peter Zijlstra wrote:
> 
> >   Thank you for having been our friend!
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19929,7 +19929,6 @@ R:	Dietmar Eggemann <dietmar.eggemann@ar
> >  R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
> >  R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
> >  R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> > -R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
> 
>  I think perhaps a CREDITS entry would be due rather than just dropping 
> from MAINTAINERS.

Ah, I was not aware of that file. Yes we can add a few lines there.

Thank you for the suggestion.

---
diff --git a/CREDITS b/CREDITS
index 1a1a54555e11..a58066be6d73 100644
--- a/CREDITS
+++ b/CREDITS
@@ -271,6 +271,9 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
 D: Various bugfixes and changes to sound drivers
 S: USA
 
+N: Daniel Bristot de Oliveira
+D: Scheduler contributions, notably: SCHED_DEADLINE
+
 N: Carlos Henrique Bauer
 E: chbauer@acm.org
 E: bauer@atlas.unisinos.br

