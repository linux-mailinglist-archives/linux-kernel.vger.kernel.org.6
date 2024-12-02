Return-Path: <linux-kernel+bounces-428074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473EB9E0AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF9AB36A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294841DA2F6;
	Mon,  2 Dec 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgLiaC1W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6932A1B8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160524; cv=none; b=HNsnM6mEKVL+GYVQgBQDhX5OWM0E/zLKeS7+bdxG8SztboStZCnCx+vfaLNqAkD5eIkxgbnPuweYBCInzdO/iZ/Kx1UWNU00TPQtFGyj8mz3QhahZ5HkVoGS7z3H1kmRph5cYCGK/fKTVVNMvY5Tu7szCQ+zia1xfI4UiFpNlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160524; c=relaxed/simple;
	bh=yYkNA5yCQcdde4t36VrFC80CKA1lrGzV1+ifVHWOYxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwP5GS5Ky4pNRn2J92Zys+1xmt2vgRM76CeZrK33jY+1EKM7+VftG5AF01+WyEWyPWPOe4Ts71p9oMuz4I3R75ZFRr7Cm6ljEZVIKlmwKpIj1UFkk/2bOeD9tXCzcmkk/5INeUUQrUuNCWEe7kz3X2iamu4lmRt3B6RZRdfE7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgLiaC1W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733160521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxfp1abLy7kOsuhY8PeGfZ76sqjzx7AkHSAlPBpNEag=;
	b=MgLiaC1WPRhL4vEnnQvMBvKoKz4Hfjp44gD5IyQN2I3rGxBpCy5pPLGgeOOg4yR3o+zqZV
	1rSGmYDLAHbddxCiUlSgfgQYi95CKuLjREXpb0AFDfjcLDy8kDeNf2SGIWbdcIr30IjdHV
	pU18MR2V9ivfMjKxiDu7D1W6cqVUt3U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-OMPu84ACM5OVvCgs4CKPdA-1; Mon,
 02 Dec 2024 12:28:36 -0500
X-MC-Unique: OMPu84ACM5OVvCgs4CKPdA-1
X-Mimecast-MFC-AGG-ID: OMPu84ACM5OVvCgs4CKPdA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FF541956088;
	Mon,  2 Dec 2024 17:28:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 242A530001A0;
	Mon,  2 Dec 2024 17:28:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Dec 2024 18:28:13 +0100 (CET)
Date: Mon, 2 Dec 2024 18:28:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] posix-timers: Fix a race with __exit_signal()
Message-ID: <20241202172808.GA9551@redhat.com>
References: <20241202155547.8214-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202155547.8214-1-iii@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ilya,

I hope this was already fixed by Frederic, please see
https://lore.kernel.org/all/20241122234811.60455-1-frederic@kernel.org/

Oleg.

On 12/02, Ilya Leoshkevich wrote:
>
> If a thread exit happens simultaneously with a POSIX timer signal, this
> POSIX timer may end up being erroneously stopped. This problem may be
> reproduced with a small C program that creates a POSIX timer and
> constantly respawns threads, e.g. [1].
>
> When posixtimer_send_sigqueue() races against __exit_signal(), the
> latter may clear the selected task's sighand, causing
> lock_task_sighand() to fail. This is possible because __exit_signal()
> clears the task's sighand under the sighand lock, but
> lock_task_sighand() needs to first load it without taking this lock.
>
> The it_sigqueue_seq update needs to happen under the sighand lock;
> failure to take this lock means that it is not possible to make that
> update. And if it_sigqueue_seq is not updated, then
> __posixtimer_deliver_signal() does not rearm the timer, effectively
> stopping it.
>
> Fix by choosing another thread if the one chosen by
> posixtimer_get_target() is exiting. This requires taking tasklist_lock,
> which is ordered before the sighand lock, as can be seen in, e.g.,
> release_task(). tasklist_lock may be released immediately after the
> sighand lock is successfully taken, which will look nicer, but will
> create uncertainty w.r.t. restoring the irq flags, so release it
> at the end of posixtimer_send_sigqueue().
>
> There is another user of posixtimer_get_target(), which may potentially
> be affected as well: posixtimer_sig_unignore(). But it is called with
> the sighand lock taken, so the race with __exit_signal() is fortunately
> not possible there.
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/v9.1.1/tests/tcg/multiarch/signals.c?ref_type=tags
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/signal.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 989b1cc9116a..ff1608997301 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1974,10 +1974,11 @@ static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
>
>  void posixtimer_send_sigqueue(struct k_itimer *tmr)
>  {
> +	unsigned long flags, tasklist_flags;
>  	struct sigqueue *q = &tmr->sigq;
> +	bool tasklist_locked = false;
>  	int sig = q->info.si_signo;
>  	struct task_struct *t;
> -	unsigned long flags;
>  	int result;
>
>  	guard(rcu)();
> @@ -1986,8 +1987,25 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
>  	if (!t)
>  		return;
>
> -	if (!likely(lock_task_sighand(t, &flags)))
> -		return;
> +	if (!likely(lock_task_sighand(t, &flags))) {
> +		/*
> +		 * The target is exiting, pick another one. This ensures that
> +		 * it_sigqueue_seq is updated, otherwise
> +		 * posixtimer_deliver_signal() will not rearm the timer.
> +		 */
> +		bool found = false;
> +
> +		read_lock_irqsave(&tasklist_lock, tasklist_flags);
> +		tasklist_locked = true;
> +		do_each_pid_task(tmr->it_pid, tmr->it_pid_type, t) {
> +			if (likely(lock_task_sighand(t, &flags))) {
> +				found = true;
> +				break;
> +			}
> +		} while_each_pid_task(tmr->it_pid, tmr->it_pid_type, t);
> +		if (!likely(found))
> +			goto out_tasklist;
> +	}
>
>  	/*
>  	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
> @@ -2062,6 +2080,9 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
>  out:
>  	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
>  	unlock_task_sighand(t, &flags);
> +out_tasklist:
> +	if (tasklist_locked)
> +		read_unlock_irqrestore(&tasklist_lock, tasklist_flags);
>  }
>
>  static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
> --
> 2.47.0
>


