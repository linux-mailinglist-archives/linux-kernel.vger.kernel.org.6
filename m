Return-Path: <linux-kernel+bounces-228540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E059916173
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBED7B242C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2F1487D8;
	Tue, 25 Jun 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GA0roNg8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060618E1F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304659; cv=none; b=YSKccvJ2zCOtI0CvKIxpM5gVuDu316fEJacXD2WEeNZNY1F+b8JsSBqPaLVIBefEXahuJlC6mzY4FmBR4OObs+MBJzvIVT0roBtgxN05ih+UNoTmqzDONWzeaHHhxX4aH1vQgpp1bRMgnCiuMUWf1cCtKn+7ZZP2woXUM2joY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304659; c=relaxed/simple;
	bh=tV2GT3QDzK9iB0iwAs0T8zVD8UI7meEYdTZfJJg0dq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxCgAIzPAADdaJvEYGqmW624BXTFkYm77xtHixNXCr5pEyINOhWxH3BJfiJ0SUt33U9tpCtvSPHRQV6sayLXJw8E2FIsjULaNwKK3H7Xc9nE03YbAxe0Ncg2Udp5pdhk2plx/D5/Go1frzWuwUNR0PMlcu+98wxNjqy0W0fKTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GA0roNg8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uaG3IOWePuJDC7yf32wm42/NJiatG2JbdBrcl9nYUns=; b=GA0roNg8TsLnzlPz9c/QTwYv3O
	OQ/jfAQDn39ZaAfOwnscovZUuG8L2+6HtYzSkNmQFOplOddvqqPlzAZLfXz8kMoNYoIui2m1w7dZI
	DFAHdT1ZvWBRaQmvrJRwraflnohKiBfHrzMoSgidr5H0m+oUa/LJVrAhPuW3pGuX51NV+nDwz1JZ+
	RlbxyjBbjo2wHqugGCrt9W7k1O5hnqAJqsMfM3gQ1UVb0W0dFi7nw2tkzvk48sjNoCYVClQr4Q2IY
	3PYqekhhcZGjT1xkOO6KahNzwaEkPvAWMCCsaA/FHHuRP0uureeDNHNdhoqrtNzueJYaCdRwUvv7Z
	VvJ9rQuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1gA-0000000AxSt-3IYW;
	Tue, 25 Jun 2024 08:37:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4C896300754; Tue, 25 Jun 2024 10:37:30 +0200 (CEST)
Date: Tue, 25 Jun 2024 10:37:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sched/fair: Make sure to try to detach at least
 one movable task"
Message-ID: <20240625083730.GU31592@noisy.programming.kicks-ass.net>
References: <20240620214450.316280-1-joshdon@google.com>
 <CAKfTPtDDSzLi7PEJkBqepx9cRgmbBKy2ZXJuT0h62e3RkQBoYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDDSzLi7PEJkBqepx9cRgmbBKy2ZXJuT0h62e3RkQBoYw@mail.gmail.com>

On Mon, Jun 24, 2024 at 11:18:59AM +0200, Vincent Guittot wrote:
> On Thu, 20 Jun 2024 at 23:45, Josh Don <joshdon@google.com> wrote:
> >
> > This reverts commit b0defa7ae03ecf91b8bfd10ede430cff12fcbd06.
> >
> > b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
> > all tasks examined to that point were pinned. The goal of the patch was
> > to make it more likely to be able to detach a task buried in a long list
> > of pinned tasks. However, this has the unfortunate side effect of
> > creating an O(n) iteration in detach_tasks(), as we now must fully
> > iterate every task on a cpu if all or most are pinned. Since this load
> > balance code is done with rq lock held, and often in softirq context, it
> > is very easy to trigger hard lockups. We observed such hard lockups with
> > a user who affined O(10k) threads to a single cpu.
> >
> > When I discussed this with Vincent he initially suggested that we keep
> > the limit on the number of tasks to detach, but increase the number of
> > tasks we can search. However, after some back and forth on the mailing
> > list, he recommended we instead revert the original patch, as it seems
> > likely no one was actually getting hit by the original issue.
> >
> 
> Maybe add a
> Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
> one movable task")
> 
> > Signed-off-by: Josh Don <joshdon@google.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks guys, queued it for sched/urgent

