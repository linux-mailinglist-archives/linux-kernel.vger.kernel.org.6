Return-Path: <linux-kernel+bounces-416892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAB9D4C14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86AAB24500
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA51D174C;
	Thu, 21 Nov 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bql3r4NW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAD1E52D;
	Thu, 21 Nov 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189000; cv=none; b=eL6lFaxmxvRoDeGgJEq5s3ad8nqFo7RTgZZRIDRAPwIppR6quMC4Kg6qGWvGobEevP0e239hmdGL5/VkTxq0NfmeRU63W7+/IWFHzPBRJYojxU9zz5W7TsYke7Sv8Cvs9ValFJhu4vqzFZ2KCQddzblwvpQnwN8v95Zb+y/MDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189000; c=relaxed/simple;
	bh=LbZQYk84BXacNPIxR5ZjcaQUtezDv/lcCXofOdgV4Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcVN5faXo01dGgt6rhSBR0IIdp2PBd6z82vchWFczWj/eiFQW7QDLATbF5s4asbPr9VESC+pWOt54HBJgrb/dhWHjkCvtzbuz6CJ7GM+MUrD1sMVNU2FkPSQfv5UTOnjTah4aJTdlyDvpTokAzfi9jMyNAP4l/Vh8GTLzf24PIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bql3r4NW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LS6+dcL7H0Nwp8T0TKzgyearEgOQ/YIKFVEH6/AJ1c0=; b=Bql3r4NW/oN5F/KLQZCbdU8C7c
	5yTQugrq9Mc1Jlbtb5Y/umQYQpvy4CE6HpJ/dYffqERxcycWdMkORlR+8eBYSL/5UMUSlHMA26wch
	e2Trg5Ze9RgmmdqSZzEzI5k9Tn/OO7XQPYo3mmBz9yJztkYB3z19SrlVhXp0cH/hP3hn4raqBOXAY
	/znOOqKox9jTJw3DIMfVLn0GCYfD7vtCzo3qt+Uj7s/qbxVR/Fp5OcA0akpXS/97dLf7IfTiIuhIT
	y63ZdlMWHJAF0IqLzyWX9Lu3gvpAmc/ggAged4re91TWxasJB4puDBYST2YRKFjUeLRlTeboDdCqI
	BPPGSoug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5U5-00000000ZlQ-3pmS;
	Thu, 21 Nov 2024 11:36:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AB5430068B; Thu, 21 Nov 2024 12:36:29 +0100 (CET)
Date: Thu, 21 Nov 2024 12:36:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Davidlohr Bueso <dave@stgolabs.net>, regressions@lists.linux.dev,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND][PATCH] locking: rtmutex: Fix wake_q logic in
 task_blocks_on_rt_mutex
Message-ID: <20241121113629.GH24774@noisy.programming.kicks-ass.net>
References: <20241120184625.3835422-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120184625.3835422-1-jstultz@google.com>

On Wed, Nov 20, 2024 at 10:46:15AM -0800, John Stultz wrote:
> Anders had bisected a crash using PREEMPT_RT with linux-next and
> isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
> wakeups from under mutex::wait_lock"), where it seemed the
> wake_q structure was somehow getting corrupted causing a null
> pointer traversal.
> 
> I was able to easily repoduce this with PREEMPT_RT and managed
> to isolate down that through various call stacks we were
> actually calling wake_up_q() twice on the same wake_q.
> 
> I found that in the problematic commit, I had added the
> wake_up_q() call in task_blocks_on_rt_mutex() around
> __ww_mutex_add_waiter(), following a similar pattern in
> __mutex_lock_common().
> 
> However, its just wrong. We haven't dropped the lock->wait_lock,
> so its contrary to the point of the original patch. And it
> didn't match the __mutex_lock_common() logic of re-initializing
> the wake_q after calling it midway in the stack.
> 
> Looking at it now, the wake_up_q() call is incorrect and should
> just be removed. So drop the erronious logic I had added.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Benjamin Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: kernel-team@android.com
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: regressions@lists.linux.dev
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> Apologies for being noisy, I recognize its only been a week, but
> I wanted to resend this now as the problematic commit just
> landed in Linus' tree and I've not seen this get queued yet.

Right, I picked up the old one a few days ago, but will not be sticking
it in any git tree until -rc1.


