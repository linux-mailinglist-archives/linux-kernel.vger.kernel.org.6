Return-Path: <linux-kernel+bounces-557844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9711A5DE80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BBA189E359
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4208624BBEF;
	Wed, 12 Mar 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVC17fCw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E61DE4F3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787876; cv=none; b=nGAlytGE+H6Ep1siWvHwecIP9Z9Nwb95b/qvLNyz4ajL3Rv9s3QKom/PV0xvJ64c3+6izUKty4LXQK/4MjZxFZCHHewEhOFbeN6zWh0xrzCLF49UDyg1MZrZ1h08IiKDHiKb139yYkaVvcLYwEk7txS4KxndUUh3aov1qmw87hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787876; c=relaxed/simple;
	bh=CmSI5em6oxIXG2cCcSIgttPPA089g81BOGUtW0LQxvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjOhbCMUtX81dTbc71CQ8AQ5xoc+bnfdMCRHmzv7S7P1XqhQkzN7lm4ryso3HAdo/J/WwTYD3SsX/NQJ7FmSlSe3YWFVH7SGjjeQ3c8gPkMjx9vrU3Wv9uQnagdyCON70OVQgluck9Na6Dzh7FNhcG7y/7VLYqX1AVadyOkM8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EVC17fCw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UC8ja4bi2zkQs9yjpiBbFRplNDLI5Q4FRsFiw1TCd7A=; b=EVC17fCwy+8fUcB1srFwWEzsmL
	78Xe9YBeBGZjFF9bW0VJ4Dzuotm8iunLhhX+cpL9RkRC7/wA8zUaUnBkvEvR8aFKSi8+BvfAujIPM
	dt3lHnJ14XRzrmpxCWw5W0hABJ7wxMXZsT0t7gb+rF9Px+myXx1O8xG4XYPv1CIHxJSTMlLO0SZpj
	p8GG8m0mWmo0V2b3ni2nDBIYzdq2l54efjlWhShmlGVWFlsOdS+H5zInQU5CYh8KpQBN26/nNo+ZV
	7MFcmhfXlbXfleOvmLsQjrrJr9AqKCTjeAG8fVL328JvTfsRxHKPt8yA7hp6EjZ21xdFnea47AE6W
	RoJzoelQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMak-0000000CvGa-0xO6;
	Wed, 12 Mar 2025 13:57:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A6A79300599; Wed, 12 Mar 2025 14:57:49 +0100 (CET)
Date: Wed, 12 Mar 2025 14:57:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V7 1/6] perf: Save PMU specific data in task_struct
Message-ID: <20250312135749.GD9968@noisy.programming.kicks-ass.net>
References: <20250312130424.3863916-1-kan.liang@linux.intel.com>
 <20250312135423.GM19424@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312135423.GM19424@noisy.programming.kicks-ass.net>

On Wed, Mar 12, 2025 at 02:54:23PM +0100, Peter Zijlstra wrote:
> > The whole patch set was posted several years ago. But it's buried in the
> > LKML without merging. I've received several requests recently to fix the
> > LBR issue with system-wide events. Rebase and repost it.
> > 
> > - Rebase on top of Peter's perf/core branch.
> 
> That branch is older than tip/perf/core, as such things don't apply
> anymore :/

I've pushed out a new queue/perf/core, based on tip/perf/core + your
patch from yesterday.



