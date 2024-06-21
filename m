Return-Path: <linux-kernel+bounces-225202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7D912D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED39C283D25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006317B4F1;
	Fri, 21 Jun 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZOGXZBI"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95B17B4E0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995774; cv=none; b=ro4bY/Dzk5FKkuRwwq+kjdMwCRbn07i9XeD2gO2b8F5mXvrXmgCQeDN5NG78p6qLoLN0aAEw84YAi8y8Rht4Za/lHDHBiCs5vhTrolR3IstJQvHakcCdg0iV9RlgnycdWhrGh4VkyLc3CD1WIv6WVp1uDw2ZQsD6zkJL6W+t644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995774; c=relaxed/simple;
	bh=QRTORQ/0DoOLG1yNW8IPMhgycaamXyx1JY+2e9e2Y6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itDtIDmwrF0iWqaXeibOsYKRcYTUTTUarKnAH6QzlyYEwaDWuwykc710y8GHpQk/dPvynbYsoQshsJA/6+9SUSNA4e3HEEsWFb+i7YoLv4e7rlYWCTm2zU3TucBkzWB42gyTGSXcqRrRkfK2i9fwsk4cVZo2t3wEkQ1M+2/ZvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZOGXZBI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718995768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHJknr1Kh6sJOLsH2IP+cFLpzyH2B34V41eCDDbfWkI=;
	b=cZOGXZBIibyvtHsa5CUU9TdJ1JsoZidCPU84ZzhP2e4/l0BX2drx3q4Lg6mBdM8JaYSsCd
	YcK55Ng9v7TBfYHclvAVdGA1cj7R035M9zyciY0V6sVW16GzwSlMkNPQsOwIFayzdmA6+G
	VlZYsveC+tDjmv4BVd3T2jvSlSczCvw=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: bristot@redhat.com
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: klarasmodin@gmail.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: peterz@infradead.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: surenb@google.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
Date: Fri, 21 Jun 2024 14:49:23 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <yjkte7jz6meaon4tvtwrefvhegwthnxorj3vrz5so6h6kftukv@azvug3smbd3p>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
 <20240621182915.S-ULWn0O@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621182915.S-ULWn0O@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 08:29:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-06-21 10:20:58 [-0400], Kent Overstreet wrote:
> > On Fri, Jun 21, 2024 at 12:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> > > The alloc_tag member has been added to task_struct at the very
> > > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > > padding after `ptrace' and then forcing another another 4 byte padding
> > > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > > due to struct sched_avg resulting in 52 hole before `se'.
> > > 
> > > This is the case on 64bit-SMP architectures.
> > > The 52 byte hole can be avoided by moving alloc_tag away where it
> > > currently resides.
> > > 
> > > Move alloc_tag to the end of task_struct. There is likely a hole before
> > > `thread' due to its alignment requirement and the previous members are
> > > likely to be already pointer-aligned.
> > 
> > We sure we want it at the end? we do want it on a hot cacheline
> 
> Well, the front is bad.
> Looking at pgalloc_tag_add() and its callers, there is no task_struct
> touching. alloc_tag_save()/restore might be the critical one. This is
> random code… Puh. So if the end is too cold, what about around the mm
> pointer?

Not there, that's not actually that hot. It needs to be by
task_struct->flags; that's used in the same paths.

