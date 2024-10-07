Return-Path: <linux-kernel+bounces-352973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF189926B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741382816C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABF1885B7;
	Mon,  7 Oct 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3IJUX7w"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6F187332
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288622; cv=none; b=g40G//ukak441EdT+k4MbRfv1T3A+9ZmI8nQe7fwvQyp0ix4P1U6DpVPsfBaLIbu4vXgClx8ksXQu4VWVkdcFnSoUL2yRUlsdyyJ+2HGiL7KKyxnMZXE7SaxgFDaLoUVfRwAe48uwJGufcF33m1Ji/qFL/0O09lELy/1OdJhQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288622; c=relaxed/simple;
	bh=8OGIDHax1KXeVAAUYRU7IFMAKHZqyH5jQOxedo9bECA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj4ccIhXtFH3eM0BWFJCjDR6rcN+XsjFN5qufiHsSfzehv4TPfF0pcBL/NsCbSURzZ4kCX/fEebROujKdDw5nJgWxVWEvnUJUpR6ok9z9fEeUHhGZ5P56RUEabr6LpdarcOue8E7IMOz96vkrMT4FVBZJ8pJ4IS+eoErMr0w79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3IJUX7w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=76DW6ZA1eJLyPIZ3Ff65SazzP572eJ8HTZ6/x+IBeLw=; b=M3IJUX7wAaRR4wjy0mXImxvbUL
	y98kzdGFQstyyubDPtnotEujaBWEeCMqJH5VhD7Qh4NRJoGDFkvOTCEdWplhKYRUVPSFOLad3HKr5
	MJcle/c8frz6tPVp+HBBULEhbI4vFLbaKIg8GgiBP3nb+k7GpQeAiHvLQSoHR0N+6RhhlA/0w6Xc0
	rgDgW4TmY9/vmhIFV7wAZyvXCYqkLo5FxgAAl60XIHYHM/TvGrBvf50TAFkCir+xlscsTUjmmdYEN
	PUiZ7Fj15OyvCYzvySDXoFTPhbWLDyL5P7DrzuQL6XYd9h2iIPueBUhQR9IOtFbCARQfwHzRkLca6
	ggGXX+6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiop-0000000Gxpz-2g67;
	Mon, 07 Oct 2024 08:10:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C97CA30088D; Mon,  7 Oct 2024 10:10:15 +0200 (CEST)
Date: Mon, 7 Oct 2024 10:10:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, linux-kernel@vger.kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com
Subject: Re: [PATCH] sched: Fix typo of head comment of ___update_load_avg
Message-ID: <20241007081015.GF18071@noisy.programming.kicks-ass.net>
References: <20241005005245.829133-1-zhouzhouyi@gmail.com>
 <CAKfTPtD7TPYcPcwHxC_n8PObZMgqxU+9=U-F6yJbP0=cLAB8hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD7TPYcPcwHxC_n8PObZMgqxU+9=U-F6yJbP0=cLAB8hQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 08:42:14AM +0200, Vincent Guittot wrote:
> On Sat, 5 Oct 2024 at 02:53, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > The head comment of ___update_load_avg illustrates the principle of
> > PELT divider. "unwanted oscillation in the range [1002..1024[" should
> > be "unwanted oscillation in the range [1002..1024]".
> >
> > Fix above typo.
> 
> This is not a typo as 1024 is an excluded endpoint of the interval.
> Some may use [1002..1024) but both [1002..1024[ and [1002..1024) can
> be used

Because I'm weird, I googled this, and the [a,b[ notation is from
Bourbaki and hence popular in the French speaking world :-)

We don't have many intervals specified in comments and hence we can't
make the inconsistent style argument either.

So yeah, let it be.. at best its a trigger to get people to better look
at the code. At worst its one of those triggers that people keep trying
to mindlessly 'fix', like my use of borken :-)

