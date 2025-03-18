Return-Path: <linux-kernel+bounces-566298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CEA67636
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F2A19C1B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6D20DD7A;
	Tue, 18 Mar 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9CG9ud3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDB20DD71
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307071; cv=none; b=Sj4hgx+b4i/yO8F96E6bYUVUQQhzXfuP9+mCRyTuX3y9lVRkVeEXJmnB39zRCGKsKDdspLRHVKk+qPaSGJL8lT19tY1dOidPpj4fGbRJfMYErV8WVq439fj4roA4XZ6g+OSgCylyQGxcaIVJvhx8GpHXD6sowtipZsujnylVhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307071; c=relaxed/simple;
	bh=ZrA+3+6C/UaCiwsXY0MO2nFc+lPf1fd2Y+duLBU+5qo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mUe9AM48e4YjlleRqzTDcChn8l1DcwE/rqWG4AvxUA9c7JmxW/6Px98sHpFyKhTsXNK1UBtLozZ5TcivwiJeLpiQ+FnrqhF0Pr7PPsSjTcWvPXg6PFSkGmhz+4hPAmeeFAe2c7hB/8dzHRwyCtaytUgnOt4jjQkRotp8HQxmaio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9CG9ud3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED42EC4CEDD;
	Tue, 18 Mar 2025 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307069;
	bh=ZrA+3+6C/UaCiwsXY0MO2nFc+lPf1fd2Y+duLBU+5qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9CG9ud3mCCNyqu2rRFpV42zakfiQGM1XrL9hS0pc6jXMwLom/5AG/xyE8pciAjKc
	 p16upX+aBsj5XyOcLGbp91m1LNuS7wFRa5KteJLY6HbgbYJ8ceu0r3+iubwovw6YB/
	 KBpBd5kspc/ZBR7hxAWFvn9yCpZtvEPCrYOO05K6MZkdTAQM8Fgj5/HzE+BTQC2Lyh
	 D2zzpIDPiyDIDyScrVYKovTTPYN9tHpRdJ9oCuP2d9AGgF939SB8DMuV3G8fLpBhqj
	 W4gEw9SsNGGg31hHmLf67TFBo7vVTCbb/H2vYizCzSUT2xmBZABjbk4TFKf0L1HHZn
	 Yhgp0Hl5WIIkg==
Date: Tue, 18 Mar 2025 23:11:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel
 Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
 <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, Masami
 Hiramatsu <mhiramat@kernel.org>, Lance Yang <ioworker0@gmail.com>, Suleiman
 Souhlal <suleiman@google.com>, hikalium@google.com
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-Id: <20250318231101.a77dd6de0f5e48cffad5e08a@kernel.org>
In-Reply-To: <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
References: <20250312221147.1865364-1-jstultz@google.com>
	<20250312221147.1865364-3-jstultz@google.com>
	<20250313061351.412bc92e@batman.local.home>
	<CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 13 Mar 2025 23:12:57 -0700
John Stultz <jstultz@google.com> wrote:

> On Thu, Mar 13, 2025 at 3:14 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > FYI, this is useful for Masami's "hung task" work that will show what
> > tasks a hung task is blocked on in a crash report.
> >
> >   https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com/
> >
> 
> Ah. Indeed, we have similar use cases. There's some slight difference
> in when we consider the task blocked, especially in this early patch
> (as waking tasks mark us as unblocked so we can be selected to run).
> But later on in the series (in the portions I've not yet submitted
> here) when the blocked_on_state has been introduced, the blocked_on
> value approximates to about the same spot as used here.

Interesting. Can yo also track tasks which takes other locks like
rwsem/semaphore ? Lance is also working on this to expand it to
support semaphore.

https://lore.kernel.org/all/20250314144300.32542-1-ioworker0@gmail.com/

Please add them for the next version.

> 
> So I should be able to unify these. It looks like Masami's patch is
> close to being queued, so maybe I'll incorporate it into my series and
> rework my set ontop. Any objections to this?

No :) Please Cc to me. 


BTW, I had a chat with Suleiman and he suggested me to expand
this idea to record what locks the task takes. Then we can search
all tasks who is holding the lock. Something like,

struct task_struct {
	unsigned long blocking_on;
	unsigned long holding_locks[HOLDING_LOCK_MAX];
	unsigned int holding_idx;
};

lock(lock_addr) {
	if (succeeded_to_lock) {
		current->holding_locks[current->holding_idx++] = lock_addr;
	} else {
		record_blocking_on(current, lock_addr)
		wait_for_lock();
		clear_blocking_on(current, lock_addr)
	}
}

unlock(lock_addr) {
	current->holding_locks[--current->holding_idx] = 0UL;
}

And when we found a hung task, call dump_blocker() like this;

dump_blocker() {
	lock_addr = hung_task->blocking_on;
	for_each_task(task) {
		if (find_lock(task->holding_locks, lock_addr)) {
			dump_task(task);
			/* semaphore, rwsem will need to dump all holders. */
			if (lock is mutex)
				break;
		}
	}
}

This can be too much but interesting idea to find semaphore type blocker.

Thank you,

> 
> thanks
> -john


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

