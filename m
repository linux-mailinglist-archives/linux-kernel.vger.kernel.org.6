Return-Path: <linux-kernel+bounces-527990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED302A41210
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FA91723FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07A205AAF;
	Sun, 23 Feb 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W23+HYN7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F710A3E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740350458; cv=none; b=gErVqmYlIz6+WKGqox0BKjkPIjYJfu6Q0cNMBt87k0LP7Lso2TxiZubVMaJaFjmb+StFlHiLz1ps55ZDnJk8UnutX7+2miwOilSj3T/OFT8bUms2OHcSHnWxULOFDDu2Uhb41T6b6FLvT/euXFJ2tM6JDzsYZVD1V0B3fukTi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740350458; c=relaxed/simple;
	bh=0nuSDhuzFLm64k3Idwk2BhZz2ij8tq5LOr86gPWatK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILg3MuzKApN7HopYz1ODw5ay+zBmS4mvoz5+hb6a0nKPpKBfoM1qbT9+jmstZIpg8HsRT4vDD4eJzwI6xmZLQHNp93SX3jkRDPjPDauIsigsN4VbUZbR8JIcG+pig0A8U/2encsRVMwb3hqn7WbulCI5H2qBzU9HX/iARZ4BQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W23+HYN7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740350454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfK2feKYUeIxgFLS+BzcteAF/4eQOCID9AREDiJXLHU=;
	b=W23+HYN7NGVUhDiLDaGR4Smkcb84aQ5mXQeomBDUXwWUQ1+pTPqmFl9Re1nWVQksMA6rRf
	ibOoI5QtSMQp9ypMmcD+ukviWmVgpT8opKyWFkIwBIjvf5YBjGLnbjngZK7D2MMCcKFW1e
	K051oU7spDEw1YVAjw8/EDnCSjTokZ4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-LcYiULkSP7qmVnFgDhgLBw-1; Sun,
 23 Feb 2025 17:40:51 -0500
X-MC-Unique: LcYiULkSP7qmVnFgDhgLBw-1
X-Mimecast-MFC-AGG-ID: LcYiULkSP7qmVnFgDhgLBw_1740350450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF43F18EB2C6;
	Sun, 23 Feb 2025 22:40:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3569A1800877;
	Sun, 23 Feb 2025 22:40:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Feb 2025 23:40:20 +0100 (CET)
Date: Sun, 23 Feb 2025 23:40:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250223224014.GC23282@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170530.L3yMvO0i@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Well... I won't really argue because I can't suggest a better fix at
least right now. Most probably never.

However, let me say that this patch doesn't make me happy ;) See below.

On 02/21, Sebastian Andrzej Siewior wrote:
>
> Oleg pointed out that this might be problematic if one closes 2.000.000
> files at once. While testing this scenario by opening that many files
> following by exit() to ensure that all files are closed at once, I did
> not observe anything outside of noise.

and this probably means that we can revert c82199061009 ("task_work: remove
fifo ordering guarantee") and restore the fifo ordering which IMO makes much
more sense.

But:

> Fixes: c5d93d23a2601 ("perf: Enqueue SIGTRAP always via task_work.")

Yes. So, to fix this specific problem in perf this patch changes task_work.c

And after this change we can never enforce a "clear" ordering, fifo or even lifo.
The ordering is simply "unpredictable/random".

I'll try to find and read the previous discussions tomorrow, but iirc Frederic
had another solution?

Oleg.

> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -194,7 +194,7 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
>  void task_work_run(void)
>  {
>  	struct task_struct *task = current;
> -	struct callback_head *work, *head, *next;
> +	struct callback_head *work, *head;
>
>  	for (;;) {
>  		/*
> @@ -202,17 +202,7 @@ void task_work_run(void)
>  		 * work_exited unless the list is empty.
>  		 */
>  		work = READ_ONCE(task->task_works);
> -		do {
> -			head = NULL;
> -			if (!work) {
> -				if (task->flags & PF_EXITING)
> -					head = &work_exited;
> -				else
> -					break;
> -			}
> -		} while (!try_cmpxchg(&task->task_works, &work, head));
> -
> -		if (!work)
> +		if (!work && !(task->flags & PF_EXITING))
>  			break;
>  		/*
>  		 * Synchronize with task_work_cancel_match(). It can not remove
> @@ -220,13 +210,24 @@ void task_work_run(void)
>  		 * But it can remove another entry from the ->next list.
>  		 */
>  		raw_spin_lock_irq(&task->pi_lock);
> +		do {
> +			head = NULL;
> +			if (work) {
> +				head = READ_ONCE(work->next);
> +			} else {
> +				if (task->flags & PF_EXITING)
> +					head = &work_exited;
> +				else
> +					break;
> +			}
> +		} while (!try_cmpxchg(&task->task_works, &work, head));
>  		raw_spin_unlock_irq(&task->pi_lock);
>
> -		do {
> -			next = work->next;
> -			work->func(work);
> -			work = next;
> +		if (!work)
> +			break;
> +		work->func(work);
> +
> +		if (head)
>  			cond_resched();
> -		} while (work);
>  	}
>  }
> --
> 2.47.2
>


