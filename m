Return-Path: <linux-kernel+bounces-420775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD19D82F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F521636DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7EB190477;
	Mon, 25 Nov 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eh+wtAl9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8D18F2E2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528876; cv=none; b=H1D/s6VK9Qdjxek7nzAJ/T6h4YDG6BPTLQnOlcQMdhv8cfIC8ThxzAloh1DHlbhV0MLg37jQbK7QQf3xdgTeQ6BpnrT4CgUAAyGL7tiBjTSEBPm36nrXthXWVsDbIRrc5dIfrVBqYNzctJSBMpl1OMsOvSIDCDav+F0pmo3ie6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528876; c=relaxed/simple;
	bh=RLv50rk5T2IaA0hZx77urMG7wQ+XX7bJLOxOM+H3M6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWQnzO1ahD0cKbbQAJnwu/6Hv10Waq5OyDWhoFzv35SmUPO+dt/QeP1/aD/FC3wy40LG9BAS+6LRidYVI8zGIIDm2RaX4lkmdSHDLutQH1ZBw1cMryeJfpUTVoOY9IoOC37xdGX3PWqL9ScZQKb8vieGTc8FHEPFvSRvyQ79AVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eh+wtAl9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/nli3vvLWXJMkxlHsaj+lNRA8hettg01abEzlLrBk1I=; b=eh+wtAl9hmmTysW/nSHtOEP4sY
	MQ7NtpZOpJgHWaWsGPgB6ZJW7L7ilYCMteBiUCl6lUvBNPIYsFPpm+7WLBCxan1twnXEtDK6Orl4k
	6L8xq7gLnwWhtE1zOERUsHgKDJIfE+K3vvCPA4T4cZUEm+S8R3tJfh5roW/apYRiZSwhSO/XJm7jx
	n0AYkREkzgp5/C/3yZBgwFrsWGKZvOA39nWGI4lo6HAn5qDFtPVJD5coozvq3msE2LzPS0LDnLUCd
	G65080BjMjuHmn3aQIJJYk+Q4m47ptCKHmM0l2yGr8tcG3WBWpf+g/LvgmCljuZhpsXsV3GRPsl8J
	iWRH2B8w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVu1-000000014ct-0YAt;
	Mon, 25 Nov 2024 10:01:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7902530026A; Mon, 25 Nov 2024 11:01:08 +0100 (CET)
Date: Mon, 25 Nov 2024 11:01:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: properly serialize the cfs_rq h_load
 calculation
Message-ID: <20241125100108.GH24774@noisy.programming.kicks-ass.net>
References: <20241122152856.3533625-1-neelx@suse.com>
 <20241122154253.GZ24774@noisy.programming.kicks-ass.net>
 <CAPjX3FfDTdUvMCDJCP8tAeNeaYSWj9mSsrMmE=VP0kWAdJTSVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPjX3FfDTdUvMCDJCP8tAeNeaYSWj9mSsrMmE=VP0kWAdJTSVQ@mail.gmail.com>

On Fri, Nov 22, 2024 at 06:33:31PM +0100, Daniel Vacek wrote:
> On Fri, Nov 22, 2024 at 4:42 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 22, 2024 at 04:28:55PM +0100, Daniel Vacek wrote:
> > > Make sure the given cfs_rq's h_load is always correctly updated. This
> > > prevents a race between more CPUs eventually updating the same hierarchy
> > > of h_load_next return pointers.
> >
> > Is there an actual problem observed?
> 
> Well, that depends. Do we care about correct (exact) load calculation
> every time?

The whole load balancer is full of races. And typically it all more or
less works out.

I mean, the worst case is typically a spurious migration, which will get
'fixed' up the next round.

Only if behaviour gets to be really bad/stupid do we tend to try and fix
this.

Now your patch didn't look awful :-), but it would make a stronger case
if you'd done it because you observed it doing stupid and it now no
longer does stupid and your workload improves.



