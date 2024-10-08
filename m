Return-Path: <linux-kernel+bounces-355426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF499520C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8047728772B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8191DF74F;
	Tue,  8 Oct 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVWSGBvi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F1DDC06
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398419; cv=none; b=OePRUhQqm5Js55968nAiuAtmIGT11FWDNKxk2E6yZeDUPXiQmh75NiylRUeQzGo3P+jPRG9rjMHNSbQcPO8Fx2HO0vz3UcSREtQj2AnUu4BK1dL0RhwoBhztYr+UoO1kEC/hOJDjrCBJYOnkj5y9dWp5nqHDF+AM/tQF1wlU7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398419; c=relaxed/simple;
	bh=KSa+Htif7D8W1ofiVoyQYbozJ7rBbB491hmGrraEtv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9GCIuBYdt/Qh2OSrzUKvl4xKuwhqX9cusHkPlER1j8HS7z3uJpwmkOcbPepwmOjyB2oH6Bm0hX+MeJj365s7dVHsV9O048A+4xWIMXYNIHruGRBbj7Wz6mDqlrGUqE06cXm1pRaNKims9ldA8Nxz/X8lckTj5/7lyO6fAW0q/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVWSGBvi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IRk7aB98URQob2gIEwpN+sXWoMo/G4yD2aImdLcMbBc=; b=GVWSGBviHvlAOhGVvqaMgbZy+i
	HqDvHgoc/AamYg12BHmE3eld9uOvYfE0UVax2HqaUlomGUkDhBe+7qMTcSOuceVl3N1aFJOh8sdGO
	m+6e5NRRVLICOZnHwY/4o5aCS6N0HOcCdZCPpYhDqlOKoolmUv++SA8WN0GxkMbu+K2NM2aXh3SES
	DQVdQXoAD3QA3ufHWXbWWFSuNfRCMoEDmp4VPNStkG7etfpqONa5Awxxkcf0u8CKsiy5ZjM/JBHFA
	Uo34E1JEalSfUF3lOxmgp/2G6YFX+zenQ2eBl5/bQ9MtUVEDgQiiW3magnGbo/L0UkXht0e7Df5Xq
	QNz5t9Xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syBNa-00000004dKz-2ulS;
	Tue, 08 Oct 2024 14:40:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1284300599; Tue,  8 Oct 2024 16:40:00 +0200 (CEST)
Date: Tue, 8 Oct 2024 16:40:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/5] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
Message-ID: <20241008144000.GE14587@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.441622332@infradead.org>
 <20241008132416.9cVldCGG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008132416.9cVldCGG@linutronix.de>

On Tue, Oct 08, 2024 at 03:24:16PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-07 09:46:12 [+0200], Peter Zijlstra wrote:
> > In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
> > from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
> > not a change in how preemption works, but rather it makes a ton more
> > code preemptible.
> > 
> > Notably, take away NONE and VOLATILE options for PREEMPT_RT, they make

As I think Mike already noted, typing is hard and this should of course
have been Voluntary :-)

> > no sense (but are techincally possible).
> 
> So this is what we do. Okay. This means we can enable the DYNAMIC mode
> on PREEMPT_RT enabled kernels and switch between "full" and the "lazy"
> mode(s).

Right.

> On PREEMPT_RT enabled kernels with PREEMPT_DYNAMIC the UTS_VERSION
> string is set to PREEMPT_RT and PREEMPT_DYNAMIC is not exposed. Is this
> on purpose or just happened?

I noticed it, didn't care and promptly forgot about it again :-)

> Clark was asking for a file to expose whether or not PREEMPT_RT is
> enabled and I was pointing him to UTS_VERSION but then suggested that it
> might be possible if we expose the current setting of the preemption
> model and use this. 
> But with this it won't work.
> I am not sure if PREEMPT_DYNAMIC is needed to be exposed and if
> everybody is happy parsing UTS_VERSION (we used to have a
> /sys/kernel/realtime file in the RT queue).

Yeah, IDK. This is all just pick a colour :-)

