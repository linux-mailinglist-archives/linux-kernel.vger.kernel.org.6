Return-Path: <linux-kernel+bounces-356454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50645996156
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A8F281CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD4183CA9;
	Wed,  9 Oct 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kJuqB30I"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA813AD39
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460003; cv=none; b=BQTPfCsUUBci92amsB+IcSjt/83hKR5SdAs7uffsMvNykGNov4llDTVqtfnkBPe8mwoRlErYL4Qegh84Jj3rd/xlizn4YK088POQK6rwoUN2aqzOkbHMNy/14NyaEjv0OHqGWk2mFpNDXgvj5v3oLfAECYHASNRgDCtUC3Glqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460003; c=relaxed/simple;
	bh=XKGLlwuyR6hvEiEme9fvHIZlvi29l5uKSygjd8b++mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifzvzqLOkhybNYjoNhyjJ2E4oZ2T7YlrDeypFllatjOCOK9agOZokU9OlcTBTjwHhD5iayjoxIZveb5k70V6ThcbnhMkN8fdN+Dum88/zX8T/J9bMnhxh5ty17DgVmucaNQvBEOW1sgA/sLc4C6aqMiwBBUT+qda9NakTDGp8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kJuqB30I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sfkUiuUQCBes7lyHfSgw745IZcall00Bgy4nOGwsxAQ=; b=kJuqB30IZfNqmKXKUIgdLdXOi8
	9KbCThWuNQ83tVidW16pX9WLdHCYGDx3r+RZD0Z51hKnLObTYHGi9WsKjmO8XwrMFTxRt0F1AdlA2
	o144Ln39hHQcu8aUvsDdMyBnPq/64CC0F4mADAGXOM0FvF9H8BYE2WA3OYtHzCSUCpstb9ivLHdG8
	UtwdnyhY0s8jAyxh81JVNRxNNO/tow5emkMKnJwUSmTFnJFJk49OxALrFSE30t5UqYQSnAE0Qf26L
	n5hCxJqjhBqgWZ1Q+QQx6HdE7PnxbOqWClaB0xuB/Yjh+HjW+3JuZKGuOGMMfuHlqlZG4YHbQZKrT
	fOg1C0wQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syROy-00000004qFv-2eTY;
	Wed, 09 Oct 2024 07:46:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1B423004AF; Wed,  9 Oct 2024 09:46:31 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:46:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009074631.GH17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008153232.YwZfzF0r@linutronix.de>

On Tue, Oct 08, 2024 at 05:32:32PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
> > Hi!
> > 
> > During LPC Thomas reminded me that the lazy preemption stuff was not there yet.
> > 
> > So here goes, robot says it builds, and I checked both a regular and PREEMPT_RT
> > build boots and can change the mode.
> > 
> > Please have a poke.
> 
> While comparing this vs what I have:
> - need_resched()
>   It checked both (tif_need_resched_lazy() || tif_need_resched()) while
>   now it only looks at tif_need_resched().
>   Also ensured that raw_irqentry_exit_cond_resched() does not trigger on
>   lazy. 
>   I guess you can argue both ways what makes sense, just noting…

Right, changing need_resched() would mean auditing all existing users,
and there's *MANY* of them.

> - __account_cfs_rq_runtime() and hrtick_start_fair()
>   Both have a resched_curr() instead of resched_curr_lazy(). Is this on
>   purpose?

Sorta, so __account_cfs_rq_runtime() is bandwidth enforcement, and I
figured that since bandwidth is like resource isolation it should be as
accurate as possible.

hrtick is disabled by default (because expensive) and so it doesn't
matter much, but it's purpose is to increase accuracy and hence I left
it untouched for now.

