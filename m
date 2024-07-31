Return-Path: <linux-kernel+bounces-269364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EE94320A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0DC1F2607D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962AE1BBBC8;
	Wed, 31 Jul 2024 14:32:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049726AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436327; cv=none; b=m8Ng0xG5zxa/9ogwyU7PDRBtDRg8+FXqhc/BYeeDpfw5BccNlpVdr/iLPQ4wjlhCFdtpVKJJP+F7aHlDWsIIAFWLG+e5bYzzlnT6L55ZXocZte6YmhfXWC5mhofgWyz/6lRb2hrYrZj4G8SQ1Dizf5Q1T7yZrGi5vBaw8CVjVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436327; c=relaxed/simple;
	bh=ivIdlhDxXFAiWN+qR5VlOoRpbc+tYvoa+/Y+qz9Fd6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5DmLq3RagsbsVNQtJTI7WrMg2YGon/Ni2/2cWai5eA/Wtxmbn1PyBi9sk9m0keideRSStFnxdaqpguGQA0xI60MdBkWsk+Ftx+9cTmlvuZwCDuotTMqUuw5qAwMZUo6i/ab9cqglOkvEVZEevqAuurMycBp/qFkduObDx91L2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D32C116B1;
	Wed, 31 Jul 2024 14:32:04 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:32:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, John Stultz <jstultz@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Youssef
 Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan
 <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Metin
 Kaya <Metin.Kaya@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, Connor
 O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240731103238.5e45e343@gandalf.local.home>
In-Reply-To: <20240731113720.GB33588@noisy.programming.kicks-ass.net>
References: <20240709203213.799070-1-jstultz@google.com>
	<20240709203213.799070-8-jstultz@google.com>
	<20240712150158.GM27299@noisy.programming.kicks-ass.net>
	<CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
	<Zqn_0XIcxTpHxswZ@jlelli-thinkpadt14gen4.remote.csb>
	<20240731113720.GB33588@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 13:37:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > I don't think I have strong preferences either way, but I actually
> > considered the proxy to be the blocked donor (the one picked by the
> > scheduler to run), as it makes the owner use its properties, acting as a
> > proxy for the owner.  
> 
> This. But I suspect we both suffer from not being native English
> speakers.

Has nothing to do with being a native English speaker or not. "proxy" is
not a commonly used word and can easily be misused.

> 
> Would 'donor' work in this case?
> 
> Then the donor gets all the accounting done on it, while we execute
> curr.

I agree that "donor" is a bit easier to understand.

-- Steve

