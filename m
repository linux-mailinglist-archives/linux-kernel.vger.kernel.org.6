Return-Path: <linux-kernel+bounces-518769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383DA3942A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5161714CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181611FDE20;
	Tue, 18 Feb 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSW6bGui"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E711FDA8E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865199; cv=none; b=btilGlnBCXWxEB80cv8/pUMG3yDj1nue0oRSKsa5xzrudXaT7AFPSjvg5xWz2EX0dnPqp7VGj6HYHFutVh0Af9TpYfzzUrngjAcv7+4mtoTSp61fUlHBI3WfdTacatPHk4es0YzYXpPsdgkLAppaG0dC/xePGQKjmvF297HyF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865199; c=relaxed/simple;
	bh=14SjyQj0J0h0LLIodo+I4vIpRgcWKFFEzlyyvCGd5CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ/Z69hf679Cr7d03f9n47YnKw3YKA4t+CYxy+qhXNrZeWBm4HWlEj9Hiv3u1FpCX6wbi8EcxtpPoiY6vzmevlIP34ScUQCIemcJ3ioFGCFvU1BFwsiYzUQA31uU6DnGEbmXH98upNbMjstl/Gtn1AN+Ekj5eP7qbREDFlrYxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSW6bGui; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lRTgzk7U5exQhL27roLir4jadtle87xBozzMwXsau9M=; b=lSW6bGuiBIP4THfiqb/KlVO+tD
	rKeIwhUH7ve6inwTYEPV7ROu5ZxdED+lQ7W2UHppOJS5hWg4RPUXJ6KX5M4sqFfKnOFAFaygVg9R0
	dIUH4nJxeeShzAdIDKAnAtHWgOd5phhXSVYD0gjv74XLaLD5eqJpPL8lfw+Xd1jOUh37zPzMudZHL
	dmGZcpOX6D744LYTl/C/tVdvp9ZX9ebmfoB8RnHiNS8+HmdpVYdLtCbE6GvgyAcvRbeYzWa+H3gyK
	/9XVvogbLAENZOcn8plMB6lLSVwjNdQtywBa8SmnWoMRaEOq67mdAtK//GN6UQOaInRN+tb2hN/Jz
	5R78HYSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIPh-00000001xAM-1QUU;
	Tue, 18 Feb 2025 07:53:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60A5F300677; Tue, 18 Feb 2025 08:53:04 +0100 (CET)
Date: Tue, 18 Feb 2025 08:53:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
	Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 1/3] sched: Compact RSEQ concurrency IDs with reduced
 threads and affinity
Message-ID: <20250218075304.GA34567@noisy.programming.kicks-ass.net>
References: <20250210153253.460471-1-gmonaco@redhat.com>
 <20250210153253.460471-2-gmonaco@redhat.com>
 <fe1858c9-0cbd-4f76-aa2a-b30b2a3f3cbd@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1858c9-0cbd-4f76-aa2a-b30b2a3f3cbd@efficios.com>

On Thu, Feb 13, 2025 at 09:56:17AM -0500, Mathieu Desnoyers wrote:
> On 2025-02-10 10:32, Gabriele Monaco wrote:
> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> 
> Peter, Ingo, this patch has been ready for inclusion for a while. The
> rest of this series does not seem to be quite ready yet, but can we at
> least merge this patch into tip ?

Done; stuck it in queue/sched/urgent for the robots. If that passes
I'll push it to tip.

