Return-Path: <linux-kernel+bounces-245648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F592B577
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949481C22EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814D15699E;
	Tue,  9 Jul 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmPYlK9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A08156886
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521489; cv=none; b=lXChu/phECvbUuAfzK4+Bk9sTf/Tq95z/VvobOcQkubpkZtCItVYh4XaWlap+3cjAcpyQGSFiv7/YKJj0IEQaPUMeEdEramjCMBqnsv0+xjitDMvFxAm/gckVFqn0MykQIk9mJF3iCXq8XxF9dCQKD3CdR7eygXdnj7JqHQHR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521489; c=relaxed/simple;
	bh=+Yg+eVlThgGe+Ezn1IKSJ8acnNeAxN74NrgtjZ6Y/SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1ma6AFgYWM9zMrU79o/W1dOYr57WzqKY8v5wxcBUEeP1owisK4gQCB9kO54VRDLsav0Ovdm19qM3E8TXbG69IUmnX1NxlRZxTIdlhNcm5CnCeVbOb+rguKse2HdMSZKDJYb2HaXlHAZXRZxGbGAHNgZYEkuKtS3YrVHqqsuSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmPYlK9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720521486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CpfpBe3XbRncb4MRj2ZX3Mauur6N0OMiF3CsST2eABo=;
	b=BmPYlK9a/kIMecOvqMx09W7BxjLDa0a2tNXxxCDtRr0P4VGuzjk4SB1CSQfE9rL8VIKqfK
	ZSKegk7ZZGoLt0f0OPDrEBZd6dwBYCCgGhB731vlEG075pFoS2ohaZ4koLVqbye3DWCdEZ
	hUd7ZedgQd6j/W1IZnQ48BUfxtmheHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-U8EFPwJmNkqlKDEVFNRMzw-1; Tue,
 09 Jul 2024 06:38:02 -0400
X-MC-Unique: U8EFPwJmNkqlKDEVFNRMzw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 367951955BC5;
	Tue,  9 Jul 2024 10:38:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6DA1419560AE;
	Tue,  9 Jul 2024 10:37:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 12:36:23 +0200 (CEST)
Date: Tue, 9 Jul 2024 12:36:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>, Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] kernel: rerun task_work while freezing in
 get_signal()
Message-ID: <20240709103617.GB28495@redhat.com>
References: <cover.1720368770.git.asml.silence@gmail.com>
 <1d935e9d87fd8672ef3e8a9a0db340d355ea08b4.1720368770.git.asml.silence@gmail.com>
 <20240708104221.GA18761@redhat.com>
 <62c11b59-c909-4c60-8370-77729544ec0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c11b59-c909-4c60-8370-77729544ec0a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/08, Pavel Begunkov wrote:
>
> On 7/8/24 11:42, Oleg Nesterov wrote:
> >I don't think we should blame io_uring even if so far it is the only user
> >of TWA_SIGNAL.
>
> And it's not entirely correct even for backporting purposes,
> I'll pin it to when freezing was introduced then.

This is another problem introduced by 12db8b690010 ("entry: Add support for
TIF_NOTIFY_SIGNAL")

We need much more changes. Say, zap_threads() does the same and assumes
that only SIGKILL or freezeing can make dump_interrupted() true.

There are more similar problems. I'll try to think, so far I do not see
a simple solution...

As for this particular problem, I agree it needs a simple/backportable fix.

> >>  relock:
> >>+	clear_notify_signal();
> >>+	if (unlikely(task_work_pending(current)))
> >>+		task_work_run();
> >>+
> >>  	spin_lock_irq(&sighand->siglock);
> >
> >Well, but can't we kill the same code at the start of get_signal() then?
> >Of course, in this case get_signal() should check signal_pending(), not
> >task_sigpending().
>
> Should be fine,

Well, not really at least performance-wise... get_signal() should return
asap if TIF_NOTIFY_SIGNAL was the only reason to call get_signal().

> but I didn't want to change the
> try_to_freeze() -> __refrigerator() path, which also reschedules.

Could you spell please?

> >Or perhaps something like the patch below makes more sense? I dunno...
>
> It needs a far backporting, I'd really prefer to keep it
> lean and without more side effects if possible, unless
> there is a strong opinion on that.

Well, I don't think my patch is really worse in this sense. Just it
is buggy ;) it needs another recalc_sigpending() before goto start,
so lets forget it.

So I am starting to agree with your change as a workaround until we
find a clean solution (if ever ;).

But can I ask you to add this additional clear_notify_signal() +
task_work_run() to the end of do_freezer_trap() ? get_signal() is
already a mess...


-----------------------------------------------------------------------
Either way I have no idea whether a cgroup_task_frozen() task should
react to task_work_add(TWA_SIGNAL) or not.

Documentation/admin-guide/cgroup-v2.rst says

	Writing "1" to the file causes freezing of the cgroup and all
	descendant cgroups. This means that all belonging processes will
	be stopped and will not run until the cgroup will be explicitly
	unfrozen.

AFAICS this is not accurate, they can run but can't return to user-mode.
So I guess task_work_run() is fine.

Oleg.


