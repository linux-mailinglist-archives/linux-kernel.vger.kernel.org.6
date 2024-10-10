Return-Path: <linux-kernel+bounces-359196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BD99888F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9780A1C226A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B261C9ED7;
	Thu, 10 Oct 2024 14:00:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12861C7B6A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568841; cv=none; b=HRyGgWQjD0BSoqD+sRM4JrDsLqGuFwvc/vjogxhaA0UydSsNTtPhtcdvI5bLn9f6XBPbY9wTu49LIjPuUVQgLHrTZp0KhlJBoUdjY+1k2muZnAxQ/Am1yg1giKqg3hQMEBIuQC8d4PrRLTO2TDRtQ1U819vz2lViiPdBG+q1LZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568841; c=relaxed/simple;
	bh=CiGZGLwYsbk/iUsU1x/Vsf8vYRz6274TdEw5k66F23A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6lc0G95mbmcOlL2l2HqfzphltDrEJ759Mv6c3LUrNNdpiUwklDBW4nIVRkPZiZbY0zh1Zq+WJC1G7vKPr1sQO0i5wLat2voYoJ7WPHL1VnmKi42FnIUWnOI+uROnNz/ktchSp0oBmieEL9vcjvXaCPC6OS79S8o62lDjgTWT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C90C4CEC5;
	Thu, 10 Oct 2024 14:00:38 +0000 (UTC)
Date: Thu, 10 Oct 2024 10:00:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel
 Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
 <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
Subject: Re: [RESEND x3][PATCH v12 2/7] locking/mutex: Make mutex::wait_lock
 irq safe
Message-ID: <20241010100045.321ca4de@gandalf.local.home>
In-Reply-To: <20241009235352.1614323-3-jstultz@google.com>
References: <20241009235352.1614323-1-jstultz@google.com>
	<20241009235352.1614323-3-jstultz@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 16:53:35 -0700
John Stultz <jstultz@google.com> wrote:

> From: Juri Lelli <juri.lelli@redhat.com>
> 
> mutex::wait_lock might be nested under rq->lock.
> 
> Make it irq safe then.

Can you expand on this please?

If the mutex:wait_lock might be taken under an rq->lock, doesn't that mean
a mutex was taken under rq->lock? Or is it something internal?

This change log needs to be more explicit.

-- Steve

