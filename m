Return-Path: <linux-kernel+bounces-411329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1969CF64B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68B8282B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C11E261B;
	Fri, 15 Nov 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lfOJ4TEi"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C818A6D4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703387; cv=none; b=ZkrFzcGvY6PDe4j/VD/OFJhIOyt1xpRVHptLnUwxspqWUjiJ1Scpr3XFPxxIQuOsqjzQ3b7ryju1eXbC3YJ3F+ghAKjuYTUlC/lQH7x0XMrr+Dh4mL6SXIofjonhHkVaIqKLpIKdQrR2D1QbmSYuu0kkjylDbMSYtNMwRAov+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703387; c=relaxed/simple;
	bh=AuLk6ZDWnAgHzz1Z5kk82BySN7z3ukRjQTiROtBqJJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD7MHxWGTYh4103M+qhgHe0tbhamx7cEbCRxFUT//PWfrOLlsonzWZSplRN5yk7zoFrLse7Yfikkv8sRmmUegRUxYnvH9sd4bGMsUTMXB3HrjBfiJT8IVZqIUIvNm81cxq+pGT8os4auToYzKQfgTbivtOg1TeWZWoV4ZtgQq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lfOJ4TEi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 15:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731703377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9OO0mPEzvGbr8DN7Ba70sKGPV9LdaZ3PrYb6DUPS+Q=;
	b=lfOJ4TEiwNZHKuEa0y7bvmjr5Po2XwyXnIqEt9YqMGyTdfLFUPjvcdzSzcQXVhDbindsCZ
	1YalySt2XnSFfhrF6rxpjmkc3MD9ZwAlidRhEWe6j/yL9Xp4BvsQG9ojbll62Iv9an+N9c
	Gbc/TbzmRFs2fCdoybwyCXDeJmyap/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florian Schmaus <flo@geekplace.eu>
Subject: Re: [PATCH 2/2] bcachefs: Set rebalance thread to SCHED_BATCH and
 nice 19
Message-ID: <lnk2cwutkjihjie4cdvpitbymdp25pyeurf3pegkvzlvrwdwwq@faeqbabjlwpq>
References: <20241114210649.71377-1-flo@geekplace.eu>
 <20241114210649.71377-2-flo@geekplace.eu>
 <kycrjg4nlgwxb6b6wph3uolmh45t7ivmoi5jpy4pakvh74wnoo@wp7hlbcbtwyw>
 <7a4a39f0-2694-42a0-b26d-b1e337eb3afc@geekplace.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4a39f0-2694-42a0-b26d-b1e337eb3afc@geekplace.eu>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 09:26:56AM +0100, Florian Schmaus wrote:
> On 15/11/2024 06.43, Kent Overstreet wrote:
> > On Thu, Nov 14, 2024 at 10:06:48PM +0100, Florian Schmaus wrote:
> > > Set the rebalance thread's scheduling class to BATCH, which means it
> > > could experience a higher scheduling latency. However, it reduces
> > > preemption events of running threads.
> > > 
> > > And while the rebalance thread is ually not compute bound, it does
> > > cause a considerable amount of I/O. By increasing its nice level from
> > > 0 to 19 we also implicitly reduce the thread's best-effort I/O
> > > scheduling class level from 4 to 7. Therefore, the rebalance thread's
> > > I/O operations will be deprioritized over standard I/O operations.
> > 
> > Is there a patch 1/2?
> 
> Sorry, patch 1/2 was unfortunately not send to linux-bcachefs@. You can find
> it at
> 
> https://lore.kernel.org/lkml/20241114210649.71377-1-flo@geekplace.eu/

2/2: https://lore.kernel.org/lkml/20241114210649.71377-2-flo@geekplace.eu/

Ingo, for sanity could we keep these two patches together? your tree or
mine is fine with me, if patch 1/2 is acceptable to you

Florian also had another idea I wanted to mention for giving userspace
control over sched policy - exposing the pids of our
rebalance/copygc/etc. threads in /sys/fs/bcachefs.

I'm liking it, do we have precedent elsewhere in the kernel for that?

