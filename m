Return-Path: <linux-kernel+bounces-563055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB11A63664
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32367A2269
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD212C544;
	Sun, 16 Mar 2025 16:33:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DE1A5B94
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742142830; cv=none; b=ZyYdDaRIFcnKpQLYj6k16Y//7H9jk9vYVS/6ua12mWTBb1LhUx+8tJZTlT/E2xhgr8axvAsZrI50do0O7TpfWDhXYb9Fi6m2tibkqkakpemOpfaztoqguV84vsiMUu6y16fPWqpgwee6jvHui0X8K7oOrPriBaoBYa0Tew6HPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742142830; c=relaxed/simple;
	bh=PjjCIxS9H52/ckt5mEfBen7AEpSKbUDZKpGW8dAY/0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o92ipEhe4KamywF+UZpP65QQ1NRlGM3iTBieZPUox/aRbyqoMiSvkfPNekoUdGL/FySeP+ENZBepMMELvM8Ptiwe6rxhGytplCVuxxhAV+xXXGXc+wWsqK+c6QaHnAJ216IOsBbN5v6EJO1rG5qlAtBmuIAYMicO7EWg6q83AG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BBBC4CEDD;
	Sun, 16 Mar 2025 16:33:43 +0000 (UTC)
Date: Sun, 16 Mar 2025 12:33:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef
 <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
 <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
 <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
 <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal
 <suleiman@google.com>, kernel-team@android.com, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20250316123343.1a03d5a0@batman.local.home>
In-Reply-To: <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
References: <20250312221147.1865364-1-jstultz@google.com>
	<20250312221147.1865364-3-jstultz@google.com>
	<20250313061351.412bc92e@batman.local.home>
	<CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 23:12:57 -0700
John Stultz <jstultz@google.com> wrote:

> So I should be able to unify these. It looks like Masami's patch is
> close to being queued, so maybe I'll incorporate it into my series and
> rework my set ontop. Any objections to this?

None by me.

-- Steve

