Return-Path: <linux-kernel+bounces-228876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A491680F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804652819C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8114D712;
	Tue, 25 Jun 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPhemxIz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706914A4C7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318995; cv=none; b=mlPrigdQFMYAbCbbv9RgtUTpnRZYYH5B4fmkQIfTwhWq3BNW+gBMPyKe0XVmjoeOTcyFlB3V3IEbD/ephQnmeEykHszGUYcyJgRTzdJuUxuNFI9Ca4MwaSuCghEABZhfptOKyxW1yO/DMDZfZjSFpRaaUt4SUjOKXzOLxak/ylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318995; c=relaxed/simple;
	bh=qHe9inMVcE1/ishS8K9zyG2tZ+3htvH252MyKdCeOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldxaO29fmX7NsV5HJpcSMCOXFBaw3Zwe/jfQGAMY8S3bIxIGW7lAq7qKCTHNimJquiVcqfk6Opzu57mkpU/IgCdtXX2h7JM139D5O9KBu/R3cFQSF5YLKIWsBtZ9KpBb2hnI2X6wPg7eSy+/qdRfoouejGoGdBj+a46Cu00wKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPhemxIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2R6yRwZK3VpxkW1LarhJtsrFwYHBWj7CO3Zx0NdBpQ=;
	b=RPhemxIzXghN/649UY3/pBWchmtz+UYC9BrtmKzWO+ygR1J/C3y5qnZAzeXCRKhkFHkyZ5
	zEg5AeWvgICdIJznNTV4F67G2nEvbLZJkJDmXZZb1DKnQanroC05d684C3uV9/DIuGoMn/
	dpvHMqnVb/Gy0/wT/nE77jB1Az0KdwY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-s9B8L0S3M-qWQci9nLY83Q-1; Tue,
 25 Jun 2024 08:36:24 -0400
X-MC-Unique: s9B8L0S3M-qWQci9nLY83Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A90119560B2;
	Tue, 25 Jun 2024 12:36:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1AA6E1956050;
	Tue, 25 Jun 2024 12:36:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 14:34:47 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:34:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] coredump: Consolidate the work to allow SIGKILL
 during coredumps
Message-ID: <20240625123444.GB16836@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <877celinkf.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877celinkf.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/18, Eric W. Biederman wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -366,18 +366,17 @@ static int zap_process(struct task_struct *start, int exit_code)
>  	struct task_struct *t;
>  	int nr = 0;
>
> -	/* Allow SIGKILL, see prepare_signal() */
>  	start->signal->flags = SIGNAL_GROUP_EXIT;
>  	start->signal->group_exit_code = exit_code;
>  	start->signal->group_stop_count = 0;
>
>  	for_each_thread(start, t) {
>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> -		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
> +		if (!(t->flags & PF_POSTCOREDUMP)) {
>  			sigaddset(&t->pending.signal, SIGKILL);
>  			signal_wake_up(t, 1);
> -			nr++;
>  		}
> +		nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);
>  	}
>
>  	return nr;
> @@ -393,9 +392,12 @@ static int zap_threads(struct task_struct *tsk,
>  	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
>  		signal->core_state = core_state;
>  		nr = zap_process(tsk, exit_code);
> +		atomic_set(&core_state->nr_threads, nr);
> +
> +		/* Allow SIGKILL, see prepare_signal() */
>  		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
> +		sigdelset(&tsk->pending.signal, SIGKILL);
>  		tsk->flags |= PF_DUMPCORE;
> -		atomic_set(&core_state->nr_threads, nr);
>  	}
>  	spin_unlock_irq(&tsk->sighand->siglock);
>  	return nr;

I fail to understand... Why do we want to add SIGKILL to the current task
in zap_process() and then clear it in the caller?

Perhaps I need to read the next patches to understand the purpose, but this
looks very confusing.

And even if this makes sense after the next patches, to me

	nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);

doesn't look very nice. Say, zap_process() could just do

	for_each_thread(start, t) {
		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
		if (!(t->flags & PF_POSTCOREDUMP)) {
			sigaddset(&t->pending.signal, SIGKILL);
			signal_wake_up(t, 1);
			nr++;
		}
	}

and in zap_threads()

	-	atomic_set(&core_state->nr_threads, nr);
	+	atomic_set(&core_state->nr_threads, nr - 1);




-------------------------------------------------------------------------------
And this reminds me that zap_process() doesn't look very nice after the commit
0258b5fd7c7124b87e18 ("coredump: Limit coredumps to a single thread group"),
I'll send a simple cleanup today...

Oleg.


