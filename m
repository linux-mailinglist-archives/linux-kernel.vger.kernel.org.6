Return-Path: <linux-kernel+bounces-285595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4C951005
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201381C22DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971841AB530;
	Tue, 13 Aug 2024 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GNydaZ+b"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6F1A4F05
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589967; cv=none; b=oyuW7Rb8ilXisuyqz7geSI2JDvk34NhUrYMFVp+EKWSKqAzRaAi80DD6PpHkGhNsA3PMdEV48PEONClCbKfHgix+Jw6VgoYPcR1jc4mqLwJ6zRvJGXREiXooxDTsZmhlR8vy69c6P8rj4mzpr2DjyXfmcu+v65yK7CWhi8YPk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589967; c=relaxed/simple;
	bh=jgUDEty7LKjIHhFFlcgErHOFi+C34JrOzRTHH1bVjyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjFoPWoWFAdDej55JhKibDV/26TDiPSb/Gv0Yrpx0U6FIBkjOr7w/3wnxGWMo6nUKyEZ6k4tPZkKjwXbiO9KytAYsyBvkmitkcH5xZxB2D9elfaANopQj7WbNx0w0ifiTMDvSEH7SzWn930HNzfuUyUT5MK4Vo7omKM3gPd5Wvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GNydaZ+b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y+T7pQonNAmg77CxsszPTkezHmAFPGnTP2iJQMbDKRs=; b=GNydaZ+bC/V3dYvwrbmnLYbdbO
	6Ms11eMz6i3wIFaSG/9fOQIAa81J7D+JQM2LYBlTEHkxlmVQBeYELUnbjrSRNcrnyl2TZGA7EZVm1
	7Ze1UDTgfWnYRBjpRBWzjb/AVqTwfpWpT+G1E35UyV7se16oY0Q2gl1ctMG7wh2vcdS4SvN834fn4
	JUB97QQNNlh0GG7M5pBE8jU/bdzflP8KbFGCgF+SlKDNqCcdDeQr9R24PQk5BIobtiKoYsPy6luM4
	KDfhqWpsvwBQRfUjTM5FfhnKbxpcmmLXzouOjn6/lEJdoYcTmFqHtKp85GuTV/jGYbIis+Iw2lpww
	R/tNfFfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0U1-0000000HA3m-2pyH;
	Tue, 13 Aug 2024 22:59:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38C1030074E; Wed, 14 Aug 2024 00:59:17 +0200 (CEST)
Date: Wed, 14 Aug 2024 00:59:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, tj@kernel.org, void@manifault.com
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	joelaf@google.com
Subject: Re: [PATCH 9/9] sched: Add pick_task(.core)
Message-ID: <20240813225917.GD10328@noisy.programming.kicks-ass.net>
References: <20240813222548.049744955@infradead.org>
 <20240813224016.471745809@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813224016.471745809@infradead.org>

On Wed, Aug 14, 2024 at 12:25:57AM +0200, Peter Zijlstra wrote:
> In order to distinguish between a regular vs a core pick_task()
> invocation, add a boolean argument.
> 
> Notably SCX seems to need this, since its core pick

... and clearly I never finished that sentence. But mostly it has extra
bits on for sched_core that are not needed in the normal case, and since
we now use pick_task() per default, it needs to know.

