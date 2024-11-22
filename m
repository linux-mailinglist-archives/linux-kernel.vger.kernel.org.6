Return-Path: <linux-kernel+bounces-417934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91319D5AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A054AB21A85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6508184101;
	Fri, 22 Nov 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHnl0mFR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC2230999
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263882; cv=none; b=L1JNCy5DGvCyGsBz8RpxHiOE/rcFue3xtIpvfUAtOahIj2GVfYJhytSw/UDNrbuUeE0t4SpFLK+lqtmcwIsgjRyF+qhi3wMuvxIypWWM6hD0bvak5zgyXhvLkuazXnZ1DqrrNPr680nS9LVVxlj3wCForBEZOvoI3QFZY3hqm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263882; c=relaxed/simple;
	bh=a47GwaaT2beViZTRYMzqpwIyUCybmRG226bUXKWdmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmVzs85qjxkSmZDknu5Pfq6JH725j6BuyNR+T5C2nhdZvcl2fa385znwpinpouGWdyA2Aovp8uNBMisufGDL00IgUAZrueLvGlNh2zRzMCo6ig9EEZhkf8d8ePp3z7mVOsTbjS73oz8bWnd6Enp5z9IdmohzEUn9VJFwNKPJqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHnl0mFR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732263879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1TvUlWmmYfrnCt340tIw2MR+AXpPBApGQYt8iCkmZXU=;
	b=gHnl0mFRfx9MiV2/r6U8iIOYyp+xu4MVfZUObqikv8+wPe1s1LLAV7PYRsY1kkRIsS+bwm
	yrKsszCdJcKCKha8SmjlOPLstG0k15VwFz4ACrH8hcy6JWghhmo7AqJtEjxdub8PXfmPB5
	xyrvUDNr0iiwy2gD7xgYqoIai3cv+k0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-KXvDlU8BPgKEqLcahjL3Ig-1; Fri,
 22 Nov 2024 03:24:34 -0500
X-MC-Unique: KXvDlU8BPgKEqLcahjL3Ig-1
X-Mimecast-MFC-AGG-ID: KXvDlU8BPgKEqLcahjL3Ig
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C65E919560A6;
	Fri, 22 Nov 2024 08:24:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C90DF195607C;
	Fri, 22 Nov 2024 08:24:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Nov 2024 09:24:12 +0100 (CET)
Date: Fri, 22 Nov 2024 09:24:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <20241122082407.GA14342@redhat.com>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz95qDPU2wcEp26r@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/21, Frederic Weisbecker wrote:
>
> I think this started with commit:
>
> bcb7ee79029d (posix-timers: Prefer delivery of signals to the current thread)
>
> The problem is that if the current task is exiting and has already been reaped,
> its sighand pointer isn't there anymore.

Thanks...

This can only happen if the exiting task has already passed exit_notify() which
sets exit_state. So I'd suggest to check current->exit_state instead of PF_EXITING
in the patch below.

Oleg.

> And so the signal is ignored even
> though it should be queued to and handled by the thread group that has other
> live threads to take care of it.
>
> Can you test the following patch? I'm cooking another patch with changelog for
> upstream that has seen recent changes in this area.
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..4cadee618d4b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1984,7 +1984,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	t = pid_task(pid, type);
>  	if (!t)
>  		goto ret;
> -	if (type != PIDTYPE_PID && same_thread_group(t, current))
> +	if (type != PIDTYPE_PID && same_thread_group(t, current) &&
> +	    !(current->flags & PF_EXITING))
>  		t = current;
>  	if (!likely(lock_task_sighand(t, &flags)))
>  		goto ret;
>
>


