Return-Path: <linux-kernel+bounces-429338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B79E1AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C930E166BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DF1E04A1;
	Tue,  3 Dec 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0pAeoNp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E941B5336
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224715; cv=none; b=Bq5mJ2NVFpyvH3tTNgJIX0WJbNczRolgOiHHbE2HZjgbwy8uNfv6SVq04ID1LbNG8dSz+ihBxnoTFptFUDzGo9B1J6KAD2yW04b+xU+4jtCrVGCEx2U7i3A3VynmTQAUCqYwAx/ciCLHbd/8Db5gcEhsdk7Fms5f/oSzVNwk00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224715; c=relaxed/simple;
	bh=xMss30K+ASZJqwblf69ujNiIbHOjRHzduYVJFMpisbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAj9ay9LkZlrUKjVmDb7Bzo+xNFtEx9cPlFrTN9BYbCxy837ygMDVmRQPG4fNHkRPNcL2dz3bfUWRARqHoWJssH3ut7yvjMOJ9FhqCFlHKMNWbCkh84uJ3pJKENJCn6uk8rasTEuJFnYjC8rEzwtzQOXn9szLOhGNvFaP4swFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C0pAeoNp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HPB5UqRjTnI62WOj3PY6WZkIwtx93UQ8PDPkwmlZBnY=; b=C0pAeoNpX+qJAyVfeqip3U9V8U
	6A6yJAfzINcmvHKwckYi0g4IsH3VS8biIYHEVf6ltiM8kZGKMNwiccy1Q8jzRrtxV57dAW9zxA7dR
	BhKFOe9RQoihW6XKJHZd1toxUefA1XSjR7NaKcMaI9Rxkqu9w7SEwpFiAJv3z8zRs5uu9SsOYhpvC
	mNslu9kJxD0LYCztVVjPTn0C99rkQss8u4JlFBuWlVJH6a7aaMVerr/qDWoJCxUF+AP5cmG1Ofsqj
	olPQPx0EgHI/MWBXbywgZGNoz74XSA5exGn/mNYR8tqzOv3DfKu5pe5sGZ6CFiRiE/nDdE0SvxDou
	zPlkZXxw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQv5-00000009XIH-3Yj6;
	Tue, 03 Dec 2024 11:18:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC1EC3004AF; Tue,  3 Dec 2024 12:18:19 +0100 (CET)
Date: Tue, 3 Dec 2024 12:18:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com, tj@kernel.org, void@manifault.com
Subject: Re: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
Message-ID: <20241203111819.GB21636@noisy.programming.kicks-ass.net>
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
 <95b655c2-dd60-488e-ab07-c7b958da1457@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b655c2-dd60-488e-ab07-c7b958da1457@arm.com>

On Tue, Dec 03, 2024 at 11:41:47AM +0100, Dietmar Eggemann wrote:

> with the following nits:
> 
> (1) 01/11
> 
>     Proposed 'Fixes:' missing:
>     https://lkml.kernel.org/r/c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com
> 
> (2) 08/11
> 
>     Would be helpful to point out that we lost the only use case for 
>     'cfs_rq->idle_nr_running' with the advent of EEVDF with:
> 
>     5e963f2bd465 - sched/fair: Commit to EEVDF

Done.

> (3) Using nr_running on rq/rt_rq/dl_rq and nr_queued 
>     for cfs_rq might look strange to the untrained eye.

Yes, but keeping nr_running with new semantics would not be less
confusing and potentially more dangerous.

> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!

