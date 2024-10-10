Return-Path: <linux-kernel+bounces-359074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDC99871A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28E61F215A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8281C7B78;
	Thu, 10 Oct 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YzVPMAE/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148E29AF;
	Thu, 10 Oct 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565590; cv=none; b=adRcCW744AJ3C2g2YhC8SHd6MX8dHJtBy2NZnrsfLWHA4dfxvIyhjtTYJbZNJcIJkPyscDJ0mog+gh6REx76CsmAbw8/HXiQWo72LEfi+5TI9p7iHmJtpeqxOi5f1zsLAF++vZmOhTHW13BjcOX95WOUji4mDFA4CBY/vzOxlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565590; c=relaxed/simple;
	bh=XEFVZrXZm4Cl3vtMXbMGdyvNFsHHTtmtGuLNaacUr9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfeaMMOwsyCYWVo4hZnVdt+0P8dPU6CbYqNtZi15IqhyHAt8KewwnROI0G6s1aDT+i/8rw4YGvvGGy3uUeWZe4Oa+/0lBd+/Shru4xF7KfWnsVAaV6+riCtn2xyOXweivqf1KcXihlBAJVPGA5povR92NIV89vIK60PVPHdOL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YzVPMAE/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XEFVZrXZm4Cl3vtMXbMGdyvNFsHHTtmtGuLNaacUr9E=; b=YzVPMAE/ILcI1X9gQr7XAN3JTm
	FedNI+yqpwcmk/+hEELGzSBsz4bM9NW4/cPVVHMpQnAI1qQxvVWU2GwYI1XEW6QXr40KaIe6p0rYb
	utqWiOhiF9D971HKSoec6TYbiH58+vQYaUVmVsGkpUu7ylO8Ozn2stQpYwznK9JKeNZbW8iqOMAxv
	zkc0i2robIMwbRcXKz7ztb+ji/qsYHlFddDJcahxAqiIPITwxTy+2sUrf0OWpDPJBRD8qG0kondtD
	TxwuniRTPs5biqJZslz7MaSN2+dOLxcbqKSAagGC46+Ki0uApPa48ZtIHp+DwnYfLVvLqx7zzrmQE
	jdQ+eKGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syss0-00000007dcS-3lYy;
	Thu, 10 Oct 2024 13:06:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2748B30088D; Thu, 10 Oct 2024 15:06:21 +0200 (CEST)
Date: Thu, 10 Oct 2024 15:06:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Message-ID: <20241010130621.GH17263@noisy.programming.kicks-ass.net>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010130316.GA181795@cmpxchg.org>

On Thu, Oct 10, 2024 at 09:03:16AM -0400, Johannes Weiner wrote:

> I'll try to come up with a suitable solution as well, please don't
> apply this one for now.

I'll make sure it doesn't end up in tip as-is.

