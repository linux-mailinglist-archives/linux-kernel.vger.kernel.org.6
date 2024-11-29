Return-Path: <linux-kernel+bounces-425514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC69DC313
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8176B22AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAB1991D2;
	Fri, 29 Nov 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7C9Mhsr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D133C5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880717; cv=none; b=iwREIf4SN2fQola+rVtawbFx6LoFL1+/9+nGZg2+/3mdP0xFGHM18LZfpdLqL+n5ghKgZfi5nv8/UVMPDU9oxZzmzF3xCIThStlMS9+UViUEFHT6PTU5HvetM9+6Zbaucoo8Ga0RLLaviAcDqZSSbLKCp7bc3YDNzKl5k9+4Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880717; c=relaxed/simple;
	bh=ftiXB3jOP6XF8e64KgAMA9vOhqudVSWnRN13BHURnwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUovqA8mcfmmcUdASclwm97SmTIVhxu+x+KCvdIm2DpyPn6WfJDlajss51XGyw7rUgU4PDlpAn03woZVsbZz8QOKbdNBNMWPWFPwVc9VWz/Q78TMzA13xV4x7PhdNKQY9PU9ZOOvjw1TiTQEnRqb/678eCuQzFvWQprGca7MHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A7C9Mhsr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y3rjtBGvseE+YdsoJOAyZcfF61v3ibzC1TTU07gBudw=; b=A7C9MhsrIYXjamrDFpwvOHTDGc
	YIQ13G+NHuFVPMS0CGLn5+oZN5Nw7ngmBz2zCvMvSI80sP2OgkJbUcFNqT5Bjon8WqtFJZPmTP6hY
	/kPEpDBT2XaAGCWlDxoME9Mp33Yv67IV2QshaJ3Md5PAuJWV84rrbbKMRoD+aDrNho18kwEJ+Ayt2
	7VGMzk7uVVuL3z9FgOPtcdMF90aFcm6JaVnRt0IgklU8El+DTVnxad4tIzQ6ND6Am+eoVwLuFREzJ
	RVNwL9k3QVjD+xaja1bJi1I52KkWRGskeO1OIxJ+UHZj4mT5Fdxexfiya42oJr0MgMlSr/aXBVaPd
	8Us/CS4g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGzQm-00000003xns-1JJN;
	Fri, 29 Nov 2024 11:45:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3F8F30026A; Fri, 29 Nov 2024 12:45:04 +0100 (CET)
Date: Fri, 29 Nov 2024 12:45:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: Re: [PATCH] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
Message-ID: <20241129114504.GF35539@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
 <20241129101541.GA33464@noisy.programming.kicks-ass.net>
 <20241129101849.GB33464@noisy.programming.kicks-ass.net>
 <95afbe5a-89a2-492b-9440-f7ec8e423a6a@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95afbe5a-89a2-492b-9440-f7ec8e423a6a@os.amperecomputing.com>

On Fri, Nov 29, 2024 at 06:37:06PM +0800, Adam Li wrote:
> On 11/29/2024 6:18 PM, Peter Zijlstra wrote:
> > On Fri, Nov 29, 2024 at 11:15:41AM +0100, Peter Zijlstra wrote:
> >> On Fri, Nov 29, 2024 at 10:55:00AM +0100, Peter Zijlstra wrote:
> >>
> >>> Anyway..  I'm sure I started a patch series cleaning up the whole next
> >>> buddy thing months ago (there's more problems here), but I can't seem to
> >>> find it in a hurry :/
> >>
> >> There was this..
> > 
> > And this I think.
> > 
> > Adam, what was the reason you were enabling NEXT_BUDDY in the first
> > place?
> > 
> Hi Peter,
> 
> I am tuning Specjbb critical-jOPS, which is latency sensitive.

There is a lot to latency, sometimes it's best to not preempt. I think
Prateek has found a fair number of workloads where SCHED_BATCH has been
helpful.

> NEXT_BUDDY affects schedule latency so I tried to enable NEXT_BUDDY.
> However Specjbb critical-jOPS drops with NEXT_BUDDY enabled (after my patch fixing panic).

Yes, picking outside of the EEVDF policy can make worse decisions for
latency.

The yield_to_task() can help performance for KVM (the only user AFAIK
-- oh DMA fences seem to also use it these days).

And the CGROUP_BUDDY thing can sometimes help when using cgroups.

But the wakeup thing is very situational -- it's disabled for a reason.
Unfortunately it seems to also have disabled the other users, which
wasn't intended.
	
> I will test your new NEXT_BUDDY patches.

We still need Prateek's fix. That ensures a delayed task will ever end
up being ->next.

