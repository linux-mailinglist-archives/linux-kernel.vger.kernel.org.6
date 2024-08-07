Return-Path: <linux-kernel+bounces-277788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E794A6B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E6DB2870B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C41E3CA5;
	Wed,  7 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n46nvnPH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB181CFA9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028396; cv=none; b=C6dpxONvpzgHsPVMZdDXDZkhwptd8uPIFiTAHwjUcsF54cnYG0a04Zz5GStPCHE2JiHFhSl1GmT+Xf/IslOaDNK3XAqIhd6/QYOT1kqcNe27eofQZmWl51w4gldNPzBgYaR6Nbima0Iu9EDaBAOjqQz/ebN6esGriS0Rb+wy0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028396; c=relaxed/simple;
	bh=x+KPvuOOccZNAnAyQJ1Z+IlFGN/POLyTHDobSiN+jv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC2ysV3TQLE4cm2+wGaa1eWYt36Tos0OBYhFuzIHtJ8ytgzGmkK4CSQtZirgdtND4wj75GkU1pM4baQWdXJapdbyQFLytDDwC/+WfquotuG4vRuGFyIXiwjlU6BEYalw1pBPBdIeZ0KgrpWSt1O1TNxqaG3hykfqTlmhPQ1cZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n46nvnPH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e36S9ax7QCuO3JFu78g3y3fLVTa9YMnBqiLQxvNRAv0=; b=n46nvnPHj9G4aaaPbaGt5JS7va
	IQF+P5nGJAsSicsBFC4zpIFR2IPFm1xN3nR/eNL6839AksiX+9DOG61KTQn24GzPKtkS0IqWIX+kF
	BRIoyV8JfqCymZNgZgN91aOnSC30VUe9eXflvQgxlFlNet02Zkb3CYhMfojUqMrkb3Adnm9vjApdN
	pdypGGDbFenlDSEoWAg4iTq3jymxCuvTSiTwCCCKK10ZCIhlqugG1MVa64ZNkoJpAPcpBUH8EbWbn
	rlLsYzUdKh33CTt9YrW1SDFzbLNfwMASwJZ2VrKPa2wjjkY3cZpj1KtNrWi/WI+NfCX+I+c2BVSsM
	3BXViegg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbeOQ-000000078Cr-0qZt;
	Wed, 07 Aug 2024 10:59:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 09E9130033D; Wed,  7 Aug 2024 12:59:45 +0200 (CEST)
Date: Wed, 7 Aug 2024 12:59:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] sched/deadline: fixes and improvements
Message-ID: <20240807105944.GA31338@noisy.programming.kicks-ass.net>
References: <20240724142253.27145-1-wander@redhat.com>
 <ZqH-1o9pc062F-hG@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqH-1o9pc062F-hG@jlelli-thinkpadt14gen4.remote.csb>

On Thu, Jul 25, 2024 at 09:29:26AM +0200, Juri Lelli wrote:
> Hi Wander,
> 
> On 24/07/24 11:22, Wander Lairson Costa wrote:
> > Hello,
> > 
> > This patch series addresses specific issues and improvements within
> > the scheduler's deadline (DL) class. The patches aim to fix warnings,
> > remove redundant checks, and consolidate timer cancellation logic for
> > better consistency and code quality.
> > 
> > Patch 1: Fix warning in migrate_enable for boosted tasks
> > 
> > Fix a warning caused by unnecessary calls to setup_new_dl_entity for
> > boosted tasks during CPU migate_enable calls.
> > 
> > Patch 2: sched/deadline: Consolidate Timer Cancellation
> > 
> > Consolidate timer cancellation logic into dedicated functions,
> > ensuring consistent behavior and reducing code duplication.
> > 
> > Changelog
> > ---------
> > 
> > v2:
> > * Drop patch to remove the redundant WARN_ON call.
> > * Change the "Fixes" tag in the patch 1.
> > * Change function names in the patch 2.
> > 
> > Wander Lairson Costa (2):
> >   sched/deadline: Fix warning in migrate_enable for boosted tasks
> >   sched/deadline: Consolidate Timer Cancellation
> > 
> >  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
> >  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> Looks good to me now.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

I stuck this in queue/sched/core, but there was some trivial rejects on
the second patch, which I stomped on. It builds, but please double check
I didn't mess it up.

