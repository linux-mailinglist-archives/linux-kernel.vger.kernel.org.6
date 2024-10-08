Return-Path: <linux-kernel+bounces-355429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D699522B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FC3B273CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014A1DFD98;
	Tue,  8 Oct 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RqbfCQqA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0631DDA15
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398461; cv=none; b=laKrcoJU8I5IVjgtKa8/j2NvltEeOH1GsjScbokvgwXqtLP3EGnT4J/v6rj+p6s9qiJMuQCmOBotbe1wV46+7HImUxNlMyKqqea2SAmmWw7gaOBJMawdxuODykGe+cj7WuuNyVZ2PAHXjcfzpwSPqnQTLmH2d7BVdCFbPKhH3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398461; c=relaxed/simple;
	bh=t2oL6Zc4nPX4Z1p19OYK0tVi2LFLXNIyQHCgv6pxgqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfcIX0HWeFWlYbgxGQJP6w6oErOk7g0DkXj/Budakd7d2roILQaffydgFyIBOAyxE/lWBb7ASwB2Xp/KvLUaUYrKdzEyzEjZXUjmtBHCdpmbAIKKqyrZmkfDN1WXYYYnSRwh6qfz+HGKj9ylbSDlkeHePWvmZwYrpo2ocXXoVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RqbfCQqA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bUAt1o+OtYHVtE/msqDP5in/OvzMArEV0Xq62EXzpGo=; b=RqbfCQqA8gzYTR6dzfmCbwT4Qf
	hCvzGuDZTKi6FkvTIp+r+CVaWryJ/jl9FSiTazFOGjyFYan745rLKFP2KOEVw+YnKCEUFVWljbUGb
	ZjDm1GM75jo0Yewllo5LqJxmrPCK0lK0/y308zg21ek0pWLgs7bw7ybcdUIrHs0S7ivIjcXCOpe0W
	mrg4NRnHbj/CyAyiF2cADl4U+DB8oykpdv0N/vVYoptwYeSbDGkhNzaTs3bTr1koDfJKuQcHTt2/0
	5r7mWqDssC5mQjV5mW9XH9kCgkW2l8/3v5cqyCkGnqMThQPagJP0WUpPcQtFiRLDAdoZI/T2fIiQj
	98BQz3Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syBOM-00000002X6c-1Qgh;
	Tue, 08 Oct 2024 14:40:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13C03300599; Tue,  8 Oct 2024 16:40:50 +0200 (CEST)
Date: Tue, 8 Oct 2024 16:40:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: bigeasy@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 5/5] sched: Add laziest preempt model
Message-ID: <20241008144049.GF14587@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.671722644@infradead.org>
 <87ed4qu107.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed4qu107.ffs@tglx>

On Tue, Oct 08, 2024 at 04:23:36PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 07 2024 at 09:46, Peter Zijlstra wrote:
> > Much like LAZY, except lazier still. It will not promote LAZY to full
> > preempt on tick and compete with None for suckage.
> >
> > (do we really wants this?)
> 
> Just to prove how bad NONE is without cond_resched() ?
> 
> I'm sure we can do without that experiment.

There's a reason this is the very last patch :-)

