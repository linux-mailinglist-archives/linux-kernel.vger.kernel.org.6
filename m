Return-Path: <linux-kernel+bounces-410469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053AC9CDBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAEF1F223E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A524192D8B;
	Fri, 15 Nov 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KB5fmgGO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8018C332
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664739; cv=none; b=rkwpl9ysROU3cCShcyb3x8uNVcOzjStxAt+Toyy1czxc0mZlxkGb8pWXqPChTcxi1y8ZfvayQAFdB4yU5Bv8gS7w6ZE8zJjzfb545OpcYQLFBuXDJOzIG8iFazO9pmoxOXDj86UJXPphGFpudG+96Rw9ELZloPPu8jj4SIGUAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664739; c=relaxed/simple;
	bh=G73iQpDiWeQ7xhsGEavDA1r+16LDSvVblsG/yj4oiPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3ulhmHX1ua2dUmhZ/VwKdHvKUf7B5isBlTI2W9aDI5liVmkedWrUAhSY3yLAWqBiz3F8FlGsFMINe5H6sSdg5cNyVnbcj9k1cbVrVoobJ7fDtvKcMRMpSZyqSYJtqer/jlBTaiPZETKPlcVf+04yAaXyhOHIPxEXd/MD0o3GKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KB5fmgGO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8NkXEpID0JPQnOTUEaJmZRqqzsJTZpzdAGLfJBOOSuA=; b=KB5fmgGOilnZcUfAhTjxBvN8th
	0G4o7Nbm7W9espH1dQyxxUv+9fEqj/wUy9o+hOuGGAm6psAPI0g+HQaOxRJQLWZnpqwT0wMHSVELO
	1aL6Jy8MNaolXeL3vr4NDk9NXdbH5idfF+St7YHunsupQX0XotXKTz/bTv4/mWvxtiI6iLHt6z61j
	IJb/oCBFHqtAT37jGHt0zXSaH5DcMsC5vpzU9UCwFAJWUApPYatDhOEe9uZGy4gZSi+OOf4W22bw4
	k4Vqg3BH4d6m+NHebu5f68QbV3PNfhcCn1bv+f7iVUc/2i3f57YgKyAjOZrwNjnpWPV9i6Pk+jgWU
	XoFHMzFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBt6H-00000001D5V-0eVt;
	Fri, 15 Nov 2024 09:58:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D911B30066A; Fri, 15 Nov 2024 10:58:47 +0100 (CET)
Date: Fri, 15 Nov 2024 10:58:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: hoist ASSERT_EXCLUSIVE_WRITER(p->on_rq) above
 WRITE_ONCE
Message-ID: <20241115095847.GV22801@noisy.programming.kicks-ass.net>
References: <20241114165352.1824956-1-jon@nutanix.com>
 <20241114185755.GG471026@pauld.westford.csb>
 <0C4B7BAD-04EA-4F60-B6D2-A7B2C14E52B7@nutanix.com>
 <20241114192056.GI471026@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114192056.GI471026@pauld.westford.csb>

On Thu, Nov 14, 2024 at 02:20:56PM -0500, Phil Auld wrote:

> I don't know. I don't think it matters much since the assert is really
> independent of the actual write. Like I said it makes sense to have it
> first to me but others may see it as just moving code around for no strong
> reason.  Peter may or may not decide to pick this one up. Other "mis-ordered"
> uses are in code maintained by different folks.
> 
> You can see if anyone else weighs in...

So I'm not entirely about this patch... :-)

Per commit b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
we can see that this placement is not equivalent.

Placing it before the store means that nobody else will store to it
until you've done your store.

Placing it after means that nobody else will attempt the store,
irrespective of the store you just did.

That is, the ASSERT after the store is a stronger assert.

In case of activate_task(), we mark the task as on_rq, and this state is
protected by rq->lock (which we hold), so there must not be any stores
for as long as we hold that lock. So after is the right place.

In case of deactivate_task(), this is a hand-off, but the handoff
doesn't happen until after dequeue_task() and set_task_cpu(). So at this
point, again, nobody should be modifying it.



