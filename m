Return-Path: <linux-kernel+bounces-365615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468999E500
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EF9B25123
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF211D6DC9;
	Tue, 15 Oct 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNTfiIW5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C11D5AA7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990358; cv=none; b=pY8H8lSKb2fUFslaBCJCv7LNFY3OfjPf8RTW5YRtqD84YNkfEigbEGI5sYJasCt3cJv4Io5jTrTllKvPIsS6q8wb0jhlZzXvgrc2zCP3ZasNZMXdWnTX9o/I9JiSYp7JiIMC/FQa7Nb8Rzjod7mrcOvEnyWGtoLgt67yriNpoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990358; c=relaxed/simple;
	bh=AzRRqPDK3ejkGJ1KpgqSIJYMjEzCj0QCSKvVeuJY9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFsR0YMdX1y3pruuRJXZLQ4z74CeaEpG+paAh9PQ7pmaXJAAQBUzOkV3DEaMpHgvcVMFNUCSECpaqUQknYFwXwOD6u0dQ61Qt/+w/CNWCY2lStQijrhGY0id0rs6eEs6wEmeDyG7hXtMcGf8ahMlrwE/M2tUXS+fRIapjM9C1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZNTfiIW5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l33eO8/FI/SCiAplEu+7yzE6KmjybAxtOSv9i13d6lY=; b=ZNTfiIW5Dnz6gLMFAOkXMPFfIQ
	cl4XgEV2ZOi18TDsDd4t/VUmIQtY/FIAG3y62h0tPzNe5SEJ8PByqcpg6S1iaA1W5T2akTyO5PQ9C
	nrdWj+u9ysmJ1Qe7krwW1d34B9823Pxund8ZLVrKj+MD3L+tD3Wh/mxCG9vCSltYRE/ESisVqHasu
	d6dw2XTVu3C9QooAPcHyzprfc1WtJZ7ZGpmCQmJC+wgl0C/ywLj5oGcWcjzhnpBZ8D3i3YRYgo/CI
	JDGD5ZOZnmm4h/QdtHUB5+KMHw1+xa4IdkYYAm8yo/GtCCPBl8ak1V1X/eorRDO+ytOkzcfdVBEw4
	DN9Cb6nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0fN3-00000006XcP-3xF7;
	Tue, 15 Oct 2024 11:05:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AA44300777; Tue, 15 Oct 2024 13:05:45 +0200 (CEST)
Date: Tue, 15 Oct 2024 13:05:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <20241015110544.GQ16066@noisy.programming.kicks-ass.net>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <60473622-e6f9-561b-a269-9da64add4966@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60473622-e6f9-561b-a269-9da64add4966@amd.com>

On Tue, Oct 15, 2024 at 03:50:49PM +0530, K Prateek Nayak wrote:

> > +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> > +	if (!masks)
> > +		return ret;
> 
> That looks like a very large array that seems unnecessary. Instead, is
> it possible to use "tl->mask(id)" down blow to check for equality? (I'll
> elaborate more below)

drive-by comments, haven't got time atm to read this, but
num_possible_cpus() is wrong, this should be nr_cpu_ids.

The CPU mask must not be assumed dense.

