Return-Path: <linux-kernel+bounces-564790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10037A65AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ACA169199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3A195808;
	Mon, 17 Mar 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZIPI0mIx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E417A2EC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232349; cv=none; b=RVdcSzbY0H/szf5IE3wzWbgovCXUyFTCwbqQS2MuaRghfUxuh9zOmDmI2li9rBvyJIaDDrg92oJhz43G37HnaTcp+r4uKrlKfpG0IsAHqf6D2iDAKlo6yuVZLh123CvYeMu/iPzl1yQ2LkRLkfcCVaPRjHVw//hJtBpoP4B1Qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232349; c=relaxed/simple;
	bh=+m2o+1RkSSOS1CRqKraRDIxQJJtaGzOP34fmPu6Y5vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3rm1iU9K7Uurbb68c+paz69quvmd5jMKh/tP3nOlW76SdFcW1lILxAvF58EwClcpVzMY2yXeaurqoBs2t09KcHhC1fxn4ShjYBfYnKuIWw9hHu3fxroUyEfd749x2D4f9nFw0LWxLYiU+NCH6++wLhizfYo8kf3BlXUcVphWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZIPI0mIx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3T7MbICDWLqXG/IN46NNRXZBn6qTa6XHFg3bjRm1Tq0=; b=ZIPI0mIxMkmottMyMF+LBoVDxe
	gx/1COr+rWQvcA708SpcFZeyqRE9Ak1Klk1q+Ji65JX+nG9KDCh3cGPGYfmKOH0YpzLcTG2X9Uoid
	NYI6lfLPTW5COm7cmtLgqjjJNGm1LHpasDm+bWVYC/2niEizCMwB4CF6fhOpSyFURf/r3rN0U5k3E
	KzTnN+xTtUawXnRJTbwMzrPsWjKdhqrPMjlh4AJ9guKcesqEn8i2IWX5HMBPkGsxqsY1FZxV8RJ5H
	TjrfQhDiVaCIkaTsV3tMwzQ0dKhWrTkUvYjP9PXbvJTgHsMTYUvaiJgbXABoWkcMtvCMNrlRGgbPB
	3Q/Bf9MQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEDZ-00000009CqT-2Y8f;
	Mon, 17 Mar 2025 17:25:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CBC3E3004AF; Mon, 17 Mar 2025 18:25:36 +0100 (CET)
Date: Mon, 17 Mar 2025 18:25:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH 0/8] sched/fair: Propagate load balancing stats up
 the sched domain hierarchy
Message-ID: <20250317172536.GF6888@noisy.programming.kicks-ass.net>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313093746.6760-1-kprateek.nayak@amd.com>

On Thu, Mar 13, 2025 at 09:37:38AM +0000, K Prateek Nayak wrote:
> tl;dr
> 
> This prototype is currently limited in the sense that it can only reuse
> statistics for busy load balancing. Reusing stats for newidle load
> balancing specifically ran into issues elaborated below.

Right, it makes sense for busy load balance, newidle I think:

> David had proposed SHARED_RUNQ [4] to improve on the shortcomings of
> newidle balance for Meta's production workloads.

we need to look at this again. Something around the EEVDF merge made the
thing unhappy -- if we figure out what and fix it, I think this makes
more sense than trying to optimize the current scheme for newidle.

newidle really is about getting *any* work fast, which is a totally
different game than the regular busy balancing.

Anyway, I'll try and have a look through the patches.

