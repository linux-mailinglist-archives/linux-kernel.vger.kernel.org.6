Return-Path: <linux-kernel+bounces-424531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC79DB570
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855CFB23350
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99E15854A;
	Thu, 28 Nov 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FYGpf2ST"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC2CCC0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788924; cv=none; b=Zx51QHKjLKKA3y/66xGWNywhNnTj2ygaC/PKEsRS+XNYZ/X4IrMi9N04KJHXKlLnzr52pUG7rvZmxeX4JtMpyqtplnHIx5Fiz24alBQd1Aolft4Dk/V8h+9WD5EOQ12wP6YUSDTxw3JtD9Plbf2wJhn/WW78/vGRKy3Q9NFR+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788924; c=relaxed/simple;
	bh=+ZGo99AJ08CeRdgitxDmY/pmD4XSmM7m+gwMSOjNuSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9BRKSp3AGscDqVA2rL1CK25AQzdxhur0fMz0JoXFqOlTln4Zp5nJIdeYzQ/hLjV1fPaseClTwxWqy8K0LsPjk8pp0fggOn1OtHMKUkPCjKeR7BqppRe0uvcXA2yg+ClIqDRTJQwivMoXtwPI13oJWTj8GOl3Q6U2mUXMKApqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FYGpf2ST; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4oJZlgFhMIbafqZmNcsDlk0kK4vBAImcQiNAYox4Fg=; b=FYGpf2STTgIZry6duTRG7jm0a7
	XHQpZPSqgv2nCcC73SwEL7FG0QAivXlLSJRpFeW6qEm9eBwDvfFoDafWnAm8J4re59vfchIxXXYt4
	TKVKe1KqEmi7st9rQfovwgzxKcTHS7nz2lYrby8NnnD7S9Yfm1no02yVV6b8DuvvLFlnU0/uO4Dzz
	NlSOkItLQNLidxiFh6Ikx+1Qt5AUIbooAAO8zqH7EH4ramZ5Uy5qJWqVQCoUKzQaBqHQaW0KZt/YN
	sLWFVBeJQ1mCqlkqFeDhTTiZ3S/rEZm3MH2ed1/xETx4binMrZyo2D46Prk2mkX7pJCELW7sMdHB7
	qQQ1k+Cg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbYL-00000001aNX-2HZ9;
	Thu, 28 Nov 2024 10:15:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DA48300271; Thu, 28 Nov 2024 11:15:17 +0100 (CET)
Date: Thu, 28 Nov 2024 11:15:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 6/9] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Message-ID: <20241128101517.GA12500@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-7-vincent.guittot@linaro.org>
 <20241128100348.GC24400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128100348.GC24400@noisy.programming.kicks-ass.net>

On Thu, Nov 28, 2024 at 11:03:48AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 10:27:47AM +0100, Vincent Guittot wrote:
> > h_nr_delayed is not used anymore. We now have
> > - h_nr_running which tracks tasks ready to run
> > - h_nr_enqueued which tracks enqueued tasks either ready to run or delayed
> >   dequeue
> 
> Oh, now I see where you're going.
> 
> Let me read the lot again, because this sure as hell was a confusing
> swizzle.

So the first patch adds h_nr_delayed.

Then confusion

Then we end up with:

 h_nr_enqueued = h_nr_running + h_nr_delayed

Where h_nr_enqueued is part of rq->nr_running (and somewhere along the
way you rename and remove some idle numbers).

Can't we structure it like:

  - add h_nr_delayed
  - rename h_nr_running to h_nr_queued
  - add h_nr_runnable = h_nr_queued - h_nr_delayed
  - use h_hr_runnable
  - remove h_nr_delayed

  - clean up idle muck


And I'm assuming this ordering is because people want h_nr_delayed
backported. Because the even more sensible order would be something
like:

 - rename h_nr_running into h_nr_queued
 - add h_nr_runnable (being h_nr_queued - h_nr_delayed, without ever
   having had h_nr_delayed).
 - use h_nr_runnable
 
 - clean up idle muck



