Return-Path: <linux-kernel+bounces-564067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB116A64D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F5A1894BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306D2376E7;
	Mon, 17 Mar 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2poXIRh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC021A42C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211877; cv=none; b=nsRo7ioO0Av3NDBY/fZr4/Q9mlBoXuTjLxcqEmMgmjehbA4kQYQuMV6Nl324L65OOcVSPB6DU5zcSuj6MFdZ9Xt46BOKtPtLblSFiDBOqWFM6mdlknAL7S9l9tLTeqRrkJjZPEsMnaGmuLmNlRW7bYGp/DymnCovYatqdbzNknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211877; c=relaxed/simple;
	bh=QyYFRxfvyvi/bupKRx3kX9/G+GyhRz3wyKQ6R52ZjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkFHaO88LYIgdpy9/3Wb233YsHWvCr65ZOmERSWypjQLmgxcEIYFVvRIh39AiuZboaMb6SWwVfEjIXc6cpeDCIgIYPbCS/KsTqMiNGezSoCnFikepJTiskr0dkFhQ05Ed5j8qtfP4FSUkSp045EJ3nQvn0Jm8FKUuhDfb2OGNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K2poXIRh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D9FtNtoMUf3n11DpseLS4Iblhw8bfIkmo1Ru9I6bARU=; b=K2poXIRheASwJFkLe23w8wnhtf
	s9rZC83eQOsI5eg6Cfl6/BY0+M/2L1fMek56oTEm8mtJc3StObfrHW5cy/Hz4sGz0VcREttOcc68+
	pZwWBV8Y+XmD6zCGvOG5ptD8XAJXVZvVSYdIzWb1jmp5EANwr8cDIGtRLj+MaB80PMXVEsapq0Z21
	pSkqnGIcda+AyQwtdJSCtlNb2xpyju9CoY75j5g9+Xftzo1E+J/fBYUBNj6YFKz74DbgHhcf2DQO+
	ZT+DggY9YjsSSEiRGT9Dy8kyd9+B3cEK/CJ+ke9xs1Ho6sJVwKCWaMO/Irw82S6uh0nVZA4gN0DrZ
	3jvQ9a0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu8tK-00000008cqo-1UdS;
	Mon, 17 Mar 2025 11:44:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A9D61300783; Mon, 17 Mar 2025 12:44:21 +0100 (CET)
Date: Mon, 17 Mar 2025 12:44:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
Message-ID: <20250317114421.GB36386@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-3-jstultz@google.com>
 <20250313061351.412bc92e@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313061351.412bc92e@batman.local.home>

On Thu, Mar 13, 2025 at 06:13:51AM -0400, Steven Rostedt wrote:
> 
> FYI, this is useful for Masami's "hung task" work that will show what
> tasks a hung task is blocked on in a crash report.

Yeah, but I would really rather not have that interfere.

