Return-Path: <linux-kernel+bounces-351740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67540991587
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5421F23876
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598513D52F;
	Sat,  5 Oct 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5CjAwjJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A4535D8
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728121092; cv=none; b=IMSs+6qMgdJBHnU9a/59H013BArXFeMC/8N4DfrjO5M4/XKd/FOKVtUtBGNGlT6qsUWLf8piY1lYDj2Cw+Nr7jAl4zWk9UOTUfsu9VHI+eUKnsHKzDugoACMBU2qzvvKMEi0DAK+zMZ0+/sYIqneDDl+VcZfKu1OrwomnkwEa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728121092; c=relaxed/simple;
	bh=VtvxZ1CIib2ohtav3R8cFbTtn3kcpJ3m8L5Qcm8GCJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqvdKtkGU1n/2wYMb+KCghKJEM7AqTYH4O1goF9xxi7GvLFoRKZvxywmJAy1Qpnl1aHBZXJOT8+RbSY4Z7jPUpUGBkvteaxVjrKYLeXNckN+qe/S8+F1cR7GhwqjvdXvQTl8iWqZSnVtTD8RtX5N5/nE4vmINn0ftS9ql4HEPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k5CjAwjJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TyvkHeO7bE9pOoTB8qOnfptD4A+JzF0NBxAU5UsKFEU=; b=k5CjAwjJj6MHlPk5mhoxe/vXOQ
	F38z39k/g9t7JHT1Dpf6OLrcPJQJdBLpC4Y40Z0qVnwR1fT7q83EQUWZdkAM0L7IiVcdkVsAr/fDZ
	jNmU+vVPqFlzMGsoY8XJP97+sP3avbOhXJRsMOC91DDraQ3WLz9LHFH/wovh2YQ56CG+WYsY/Q+oK
	MK93DxVpwByMpmyHuXGTVro8OzYL4vARaN8XActsXLoVVTIXhyhr28q90bB8BfufqCiQfud/iXj8p
	oq3Y3M35CXqV+au4q8ZTxSc2W4/3NR8CHwDv4h9z9OASY8UoGi9LSYPV7jdXDmLXDewV2ACSio85x
	9e1dU1qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx1Ej-000000041z3-00Gb;
	Sat, 05 Oct 2024 09:38:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3A53300777; Sat,  5 Oct 2024 11:38:04 +0200 (CEST)
Date: Sat, 5 Oct 2024 11:38:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, mingo@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/3] sched/core: Add ENQUEUE_RQ_SELECTED to indicate
 whether ->select_task_rq() was called
Message-ID: <20241005093804.GY18071@noisy.programming.kicks-ass.net>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-3-tj@kernel.org>
 <ZvxXxT8Lc0u9dTLo@slm.duckdns.org>
 <ZwBMnL55W1qfcjwc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBMnL55W1qfcjwc@slm.duckdns.org>

On Fri, Oct 04, 2024 at 10:14:20AM -1000, Tejun Heo wrote:
> On Tue, Oct 01, 2024 at 10:12:53AM -1000, Tejun Heo wrote:
> > On Fri, Sep 27, 2024 at 01:46:12PM -1000, Tejun Heo wrote:
> > > During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed or
> > > migration is disabled. sched_ext schedulers may perform operations such as
> > > direct dispatch from ->select_task_rq() path and it is useful for them to
> > > know whether ->select_task_rq() was skipped in the ->enqueue_task() path.
> > > 
> > > Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
> > > and end up assuming incorrectly that ->select_task_rq() was called for tasks
> > > that are bound to a single CPU or migration disabled.
> > > 
> > > Make select_task_rq() indicate whether ->select_task_rq() was called by
> > > setting WF_RQ_SELECTED in *wake_flags and make ttwu_do_activate() map that
> > > to ENQUEUE_RQ_SELECTED for ->enqueue_task().
> > > 
> > > This will be used by sched_ext to fix ->select_task_rq() skip detection.
> > 
> > Peter, ping on patches 1-2. If they look okay, I can route them through
> > sched_ext/for-6.12-fixes.
> 
> As the core changes are on the trivial side, I'll wait till early next week
> and route them through sched_ext/for-6.12-fixes. Please holler for any
> concerns.

Right, I've been busy chasing merge window fallout, and this didn't seem
that urgent. I'm not exactly liking it, but it isn't too horrible. So
yeah, you can take it I suppose.

