Return-Path: <linux-kernel+bounces-413999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509599D21AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A24280F14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC2198833;
	Tue, 19 Nov 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A44/rjAh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9D158874
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005429; cv=none; b=IbDqA37lmf4VvcxHscWZ4t/ERO1J230kVqXDsOZMeVPQwP1FBrbB8kUgih3KRXyS6nzRA2icMFkVjnXpSSTa5uD4lGEg6txVbkNZuUyHciwifv9K05COPo6SRbUmEsgYqfXEUp9aAc7fr6Xh5Mk6DktsHuQ2EVlY0VNQ58OCmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005429; c=relaxed/simple;
	bh=1AGgWDBY+5gJZhIndEpCiCqqv41fP4txqj5GXtPlS+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo4y/3zQH2/G9M0l5BewEYjCr7wnKFv+mqJx1TBl2GNXFTxSyL7XXupCembHOpWSKheEJN/gdt3UPkNveLHWNK44T4+xVUUSFLcbtuxKCYzTDuQ7V9rBg5kNS21VV30wOI2HhsafLzRbbPi/vnTPWIp4m6xV2/idPJUdAW+QCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A44/rjAh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z5E0sPwW7vBDvH51jA0wK2kw8BEhSh1FAmm8TxMANb4=; b=A44/rjAhn5muR/iwvuB+kDNuf4
	qt2r9DNA9OmD6AHI1HQHu/n+XAhbB34cznpSRjQEbgnJKz6J0PXrCZTEV8ehKD3nz9opdf6TsTleG
	0VbzIAH8yT4ca9Ddn9srEpjcdxZ2J+DzOspcACj16MhwjTk9E9TYX3YvqAirQRJNRo/OZnYUF9cml
	y1EUr3CnHq1tXF3eHNJiz/al9G5EvNfmSA1Cosxido+8MvhqkKjyDUPhZtxUztOEy3YfXXLQDTB3v
	nAewvkom7z4edKaMlPdSNnNecbg/VZLqxlX/KNOIR4bg4j2ig41xA48oucJEkYYetchNZeHECzVh0
	7r02Y0AQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDJj9-00000000KJh-3Uxs;
	Tue, 19 Nov 2024 08:36:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D14B33006AB; Tue, 19 Nov 2024 09:36:50 +0100 (CET)
Date: Tue, 19 Nov 2024 09:36:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH sched-next] sched/cputime: Fix unused value issue
Message-ID: <20241119083650.GD11903@noisy.programming.kicks-ass.net>
References: <20241118111314.58481-1-dheeraj.linuxdev@gmail.com>
 <20241118153047.7e90015f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118153047.7e90015f@gandalf.local.home>

On Mon, Nov 18, 2024 at 03:30:47PM -0500, Steven Rostedt wrote:
> On Mon, 18 Nov 2024 16:43:14 +0530
> Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:
> 
> > This commit fixes an unused value issue detected by Coverity
> > (CID 1357987). The value of utime is updated but has no use as it is
> > updated later on without using the stored value.
> > 
> > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> > ---
> >  kernel/sched/cputime.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 0bed0fa1acd9..3dea3636a260 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -571,13 +571,9 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
> >  	 * Once a task gets some ticks, the monotonicity code at 'update:'
> >  	 * will ensure things converge to the observed ratio.
> >  	 */
> > -	if (stime == 0) {
> > -		utime = rtime;
> > -		goto update;
> > -	}
> > -
> > -	if (utime == 0) {
> > -		stime = rtime;
> > +	if (stime == 0 || utime == 0) {
> > +		if (utime == 0)
> > +			stime = rtime;
> >  		goto update;
> >  	}
> >  
> 
> The above adds more branches than just having:
> 
> 	if (stime == 0)
> 		goto update;
> 
> 	if (utime == 0) {
> 		stime = rtime;
> 		goto update;
> 	}
> 
> (or's "||" are branches)
> 
> And the latter is much easier to read!
> 
> Just fix the issue. Don't try to be clever about it.

There is nothing to fix. Yes there is an unused assignment, but the
compiler is free to elide it (and it does).

Keep the code as is, it is simple and straight-forward.

