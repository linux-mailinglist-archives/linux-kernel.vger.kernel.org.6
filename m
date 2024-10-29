Return-Path: <linux-kernel+bounces-387584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5639B533F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D792846BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E72076CB;
	Tue, 29 Oct 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ5m6KKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A32076BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233123; cv=none; b=BRPhGfRrCx/39F3IvXkr2EuDScx4d2ZzSNMNGZXwNDlr8ZOSyeSF8/omzisIv7jUYuJb4fo2t9hpH9I36s6XPYur/yVJplDbj76YYpUgHrF4atIL7iVdkLfVEA6tGrBm1RWx3FbhtyuUDu14wiFK9XVDnw+3iSLgla9SFCff2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233123; c=relaxed/simple;
	bh=mv+FeGti4dvi3rlUVDTc2DR+6xhRY+lgTSfgFPqw6Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+yQEXUg+MPNqrhgtfXeV2WpovVZsIVXpFWBoB5llePXDx/yq1UKLMoTDuq3G/YTTi2r7AqGfXJrATNgdk7cixuDI/HF8qrvNeviJ/2xl7nGu5reuOjq+Dr0UYj/aMFGH426NzMHk/ScosLs3Ffa4YtDgSrv8h2Bcn1Mjr3H1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ5m6KKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0534C4CECD;
	Tue, 29 Oct 2024 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730233123;
	bh=mv+FeGti4dvi3rlUVDTc2DR+6xhRY+lgTSfgFPqw6Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJ5m6KKJczo9HIUe7D7+cB+wl0vGyJYUnZWOhyH1LDZ8jWQdxBUICszsMZihvp9JB
	 tWUozPdQiqe5/R9u2Ipofilh/cMiKbQMmg8U9yPuGPqCQL0NkBwaGhwZTwDkJT6e9K
	 y8HKd2vXxG8ZXwX5mX4vGz6ph8/Mzu3yWLaINmGxicTnNMEd1HIp34DvBNAz5dypyl
	 bcgAIYcU4g6WcF67cDg/Gu1M647ZNfdh5uWoPc6CcOjdiIbGH8EJPmaWTGfixFylR6
	 ZuvhpBdpqC4sac71cU/oI01AbNEImX8SQ3q+at82g7xMQNRV7QnWbRtIxVvMzO0zCx
	 oKbt4spTk5RvA==
Date: Tue, 29 Oct 2024 21:18:40 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
Message-ID: <ZyFDIP_1zeygVxa8@pavilion.home>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
 <ZyEFyV28jcz85V1q@localhost.localdomain>
 <87ttcu281y.ffs@tglx>
 <ZyEOeqkSYWR2XTp_@localhost.localdomain>
 <87jzdq26id.ffs@tglx>
 <ZyEhrrDhDiQ6LwjV@pavilion.home>
 <875xpa1zzo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xpa1zzo.ffs@tglx>

Le Tue, Oct 29, 2024 at 08:16:27PM +0100, Thomas Gleixner a écrit :
> On Tue, Oct 29 2024 at 18:55, Frederic Weisbecker wrote:
> > Le Tue, Oct 29, 2024 at 05:55:38PM +0100, Thomas Gleixner a écrit :
> >> It still happens because SIGQUEUE_PREALLOC is cleared in sigqueue_free()
> >> 
> >> __sigqueue_free() has
> >>        if (q->flags & PREALLOC)
> >>        	     return;
> >> 
> >> So the old code called __sigqueue_free() unconditionally which just
> >> returned. But now we have a condition to that effect already, so why
> >> call into __sigqueue_free() for nothing?
> >
> > 1) Signal is queued
> > 2) Timer is deleted, sigqueue() clears SIGQUEUE_PREALLOC but doesn't go
> >    further because the sigqueue is queued
> > 3) Signal is collected and delivered but it's not calling __sigqueue_free()
> >    so the sigqueue is not released.
> >
> > This is "fixed" on the subsequent patch which uses embedded sigqueue and
> > rcuref but this patch alone breaks.
> >
> > Or am I missing something that prevents it?
> 
> Again:
> 
> > 1) Signal is queued
> > 2) Timer is deleted, sigqueue() clears SIGQUEUE_PREALLOC but doesn't go
> >    further because the sigqueue is queued
> 
>   3)
>   
> void collect_signal(..)
> 
>      if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
> 	*timer_sigq = first;    // Path NOT taken because SIGQUEUE_PREALLOC is not set
>      else
>      	__sigqueue_free(first); // Path taken and frees it
> 
> No?

Duh! Yes of course...

Thanks.

> 
> Thanks,
> 
>         tglx

