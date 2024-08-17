Return-Path: <linux-kernel+bounces-290872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C63955A29
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5271C20B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682C155C8F;
	Sat, 17 Aug 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNpYZg2D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E34149018
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723936025; cv=none; b=P099i5SV8CqswK6XsNBwmukMyEMWMeTJXTIjh7MhexzspO2sp+XO4GzkRFOWlCEZkQxmelHcYgZdw+4j5c5hQJxadKGbUWQOzQv1+EYhIYUYSjarXe34rRdWeHeHCm1s3QeUwV63qWBeZN+WNVVWqcOLhp71ouaBtkKnD9s5kKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723936025; c=relaxed/simple;
	bh=UuCaKBlTxePsFkys14JaLzrfdXnMXRAS1STarqX/H3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTCQzBkSQPElPHL5X5AX6HFBOTmZvPZfOrxM0RqaV7YdRYocwMs3lPRk209U/UMH42Vho/jRtO22/j6Rs39J63X3U5aIiNU6/wCvx1CYvWIodunlS+NslGDwpTqvtgcHlB0gBTXK5QulX29fHzOteiEyE675flaRYralGnSehB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eNpYZg2D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nXyS2sUo1n0Mw1n5ITMhmlne7GDtRzGJn7gmD/Y/8P0=; b=eNpYZg2Dfk8WK7soZM3/ImEnOl
	lUHkXGZpJZV/h4A8dHxcxcxd5KnSza9q06TuRSplfLjYhtR8qi2Pj3LSz3L8TDKd2Ae7mnLApoN4b
	gL/OXJ/egK7je1mbGsMrjwxKatMMTB7gtlye8iPheaZV8h2H/kRhY456Mp9RLpjXWHlLBdJ7tfmlI
	SngrxIDGZuC3e35EXKpTV5iy+4B6++ATG86YBEApkgd2SBKrx0T42uXb/KRI/nObhsqoA24oZwERE
	eKcK890leicSiFBO4KR0q8opL5bo/tgRzx6c2MQQ/OMOCGrvPf5hfdOUYxl745YWt8IIVPKW9Erl7
	zGdzQBFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfSVI-00000005AjH-3mnL;
	Sat, 17 Aug 2024 23:06:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8798C300848; Sun, 18 Aug 2024 01:06:36 +0200 (CEST)
Date: Sun, 18 Aug 2024 01:06:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
Message-ID: <20240817230636.GB20319@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813221806.GB10328@noisy.programming.kicks-ass.net>
 <CAKfTPtBD3iyR3XSssQDAU=vkPs70tZLukvbwPYpnSv63ra_-Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBD3iyR3XSssQDAU=vkPs70tZLukvbwPYpnSv63ra_-Ew@mail.gmail.com>

On Wed, Aug 14, 2024 at 02:59:00PM +0200, Vincent Guittot wrote:

> > So the whole reason to keep then enqueued is so that they can continue
> > to compete for vruntime, and vruntime is load based. So it would be very
> > weird to remove them from load.
> 
> We only use the weight to update vruntime, not the load. The load is
> used to balance tasks between cpus and if we keep a "delayed" dequeued
> task in the load, we will artificially inflate the load_avg on this rq

So far load has been a direct sum of all weight. Additionally, we delay
until a task gets picked again, migrating tasks to other CPUs will
expedite this condition.

Anyway, at the moment I don't have strong evidence either which way, and
the above argument seem to suggest not changing things for now.

We can always re-evaluate.

