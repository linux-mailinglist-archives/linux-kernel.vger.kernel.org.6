Return-Path: <linux-kernel+bounces-417317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05D9D526B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9573FB238C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36E1C07D3;
	Thu, 21 Nov 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oURekfLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB11BBBC1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213163; cv=none; b=vBcwTivUM3LWQluSW658qTTJB7Bovq8qy2/emXWntb4uUBfVLRmwRHhkX0djJlqXVfIZWcF3G4CQAav3XXsY+w3mj6XIs9xD4r9HkRHICAuzZ6W+8mbF4sie95UpTEhhQeWbbyCp8wLdVw7+mEJosLsCdTjy7cneGxFFtSR8Lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213163; c=relaxed/simple;
	bh=D73rZpO2680a1HkIjf2lGKEQl+lbZBxYLaHmMkeCa/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdb9z7iR7bdjF+v46cep4maOY+HyOXHoKUzRGjvbdacaFTibHIzjfWucZNP/UJO1gp6N/kEwySXh/GHvDVRZZ0Gk/fkvDR32dKdblxWbFVfGeNpBzA9ed8Xmepb2dJp2s+Ym/QlNLb1qOXUt/Mg7yFSK7r9oDNhMa4Qr+XmwaMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oURekfLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B6DC4CECC;
	Thu, 21 Nov 2024 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732213163;
	bh=D73rZpO2680a1HkIjf2lGKEQl+lbZBxYLaHmMkeCa/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oURekfLVhOOUBz9nV57zv/shfFs9DyOftOxk25lilJRrbGdnrnia7w5IkeevVdr3M
	 u4mVupEgDESVB7QtBRq82Ag5+2UtN+oqc3KulAPOW+DKXPQYiYoLLOkzeJnX/MkF4p
	 zWN0AvPyVjFc+aC7J23XCt804NkZyeF1kbejfjMM784UzgkMKfmh1PoLsZgDNA9Gm1
	 qJ1BaYKdvUA4qoT8cUCFu59V/XK9aFKoxHBH/0YJAk/P4g3yfzBEMBt8gKRvBem4i7
	 4RmJEH4sjpATP/2FXWSygPDydA5DjfZ3lsYfh2kdHdqCrijwzFJO+Bb/13v3+cDXPr
	 lVp+815UKt6Lg==
Date: Thu, 21 Nov 2024 19:19:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anthony Mallet <anthony.mallet@laas.fr>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <Zz95qDPU2wcEp26r@localhost.localdomain>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26411.57288.238690.681680@gargle.gargle.HOWL>

Hi Anthony,

Le Wed, Nov 06, 2024 at 10:29:44PM +0100, Anthony Mallet a écrit :
> Hi,
> 
> I'm facing an issue with posix timers configured to send SIGALRM
> signal upon expiry. The symptom is that the timer randomly freezes
> (the signal handler not triggered anymore). After analysis, this happens
> in combination with pthreads creation / destruction.
> 
> I have attached a test case that can reliably reproduce my issue on
> affected kernels. It involves creating a timer that increments a
> global counter at each tick, while the main thread is spawning and
> destroying other threads. At some point, the counter gets stalled. In
> the context of this test case, I do heavy thread creation and
> destruction, so that the issue triggers almost immediately. Regarding
> the real-world issue, it happens in the context of aio(7) work, which
> also involves thread creation and destruction but presumably at a much
> lower rate, and the issue consequently triggers much less often.
> 
> I could reproduce the issue reliably with mainline kernels from 6.4
> to 6.11 (included), and on several distributions, different hardware
> and glibc versions. Kernels earlier than 6.3 (included) do not exhibit
> the problem at all.
> 
> Once the issue triggers, simply resetting the timer (with
> timer_settime(2)) makes it work again, until next
> stall. timer_gettime(2) does not show garbage and the values are still
> as expected. Only the signal handler is not called. Manually sending
> SIGALRM with raise(SIGALRM) also works and invokes the signal handler
> as expected.
> 
> Also note that using setitimer(2) instead of a posix timer does not
> show any problem with the same test program.
> 
> Before filling a proper bug report, I wanted to have your opinion
> about this. This e-mail is already probably too long for an
> introduction, but I can of course provide you with any missing detail
> that you would deem necessary.
> 
> Thanks for you attention,
> Anthony Mallet

Thanks a lot for your report and the very helpful reliable reproducer.

I think this started with commit:

bcb7ee79029d (posix-timers: Prefer delivery of signals to the current thread)

The problem is that if the current task is exiting and has already been reaped,
its sighand pointer isn't there anymore. And so the signal is ignored even
though it should be queued to and handled by the thread group that has other
live threads to take care of it.

Can you test the following patch? I'm cooking another patch with changelog for
upstream that has seen recent changes in this area.

diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..4cadee618d4b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1984,7 +1984,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	t = pid_task(pid, type);
 	if (!t)
 		goto ret;
-	if (type != PIDTYPE_PID && same_thread_group(t, current))
+	if (type != PIDTYPE_PID && same_thread_group(t, current) &&
+	    !(current->flags & PF_EXITING))
 		t = current;
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;



