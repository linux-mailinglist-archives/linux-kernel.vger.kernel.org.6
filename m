Return-Path: <linux-kernel+bounces-420899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5429D841F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1193163F24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974C1957F4;
	Mon, 25 Nov 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdIJybL3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79A192589
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533206; cv=none; b=VA5HdAsEd7cE1V7PsHDTxhvTet531t5Vs0AbYE9mi4dZfMHNQbNPKkU2Ssp+u2eN3iXLQMRKtoI/u4/iDmg6VTNP4TqxRmdlJ9v5Kf10hLIYvIIj1gxTpx45L7DQk3Yc20y7HzwgJu07hxA54DoJh6MFLqq6BgcqTmR4LzmY1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533206; c=relaxed/simple;
	bh=UBA5pWAXJXjiPjQfLbZewotmmeYaWwUO6H+GsspPZ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2KxutKRsPIjbFDV65aK3gtTo7ChgsKifDEesfIQ5XpXaj/kfUzcU81GJsT0QLEbcKJJ0DWFbdsLrtlVTnkiPPtpzwe3SzsDIhw+8UJCr5YFauyLs4S5VrfpnlzoaQv097aH+dKfcNii1GZE6sAJ7T8GaOhVRh9l2IiS30vLa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdIJybL3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732533202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZkZA5pwjwFqi/eSkNb/emSlu1fA+t1L7liPWLVhFnM=;
	b=cdIJybL3gJvdhPxZqcJSBkZS41NjTAVLTMFro2vOdRi92E0vBigNAjPC5v+jeS6vO3sBHG
	9gHu8BcE6CLRl2U5tMsWhiPrgsDonvWoJb9pPOVIuzPqRKsBuafe4gQxWTmmStrtsrerbI
	FBtEZSKxF5tZVMQXYBSBFFtgxFx8JgY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-2dqHrVn3NHO-zPInN1wgWA-1; Mon,
 25 Nov 2024 06:13:20 -0500
X-MC-Unique: 2dqHrVn3NHO-zPInN1wgWA-1
X-Mimecast-MFC-AGG-ID: 2dqHrVn3NHO-zPInN1wgWA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C50C3195FE06;
	Mon, 25 Nov 2024 11:13:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE4061956086;
	Mon, 25 Nov 2024 11:13:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 25 Nov 2024 12:12:59 +0100 (CET)
Date: Mon, 25 Nov 2024 12:12:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anthony Mallet <anthony.mallet@laas.fr>
Subject: Re: [PATCH] posix-timers: Target group sigqueue to current task only
 if not exiting
Message-ID: <20241125111254.GB20402@redhat.com>
References: <20241122234811.60455-1-frederic@kernel.org>
 <20241123101312.GA12843@redhat.com>
 <CACT4Y+YQGLtD0673Oxm2=0mHy9cSx1wTPtVCyxjORSv47M+vUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YQGLtD0673Oxm2=0mHy9cSx1wTPtVCyxjORSv47M+vUw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/25, Dmitry Vyukov wrote:
>
> On Sat, 23 Nov 2024 at 11:13, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 11/23, Frederic Weisbecker wrote:
> > >
> > > - * the same thread group as the target process, which avoids
> > > - * unnecessarily waking up a potentially idle task.
> > > + * the same thread group as the target process and its sighand is
> > > + * stable, which avoids unnecessarily waking up a potentially idle task.
> > >   */
> > >  static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
> > >  {
> > >       struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
> > >
> > > -     if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
> > > +     if (t && tmr->it_pid_type != PIDTYPE_PID &&
> > > +         same_thread_group(t, current) && !current->exit_state)
> > >               t = current;
> >
> > Thanks!
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
>
> Can't the group leader be exiting as well?

It can. It is even possible that the group leader is already a zombie.

But this is fine. release_task(zombie-or-exiting-leader) (which does __exit_signal()
and clears ->sighand) won't be called until all the sub-threads have exited.

And. If all the sub-threads (and the group leader) have exited, then send_sigqueue()
makes no sense, the whole process is dead. so we do not care if lock_task_sighand()
fails in this case.

> Though, that's still an
> improvements. People usually don't do that (exiting from main w/o
> killing the process).

See above. Nothing to improve, AFAICS.

> So thanks for the fix.

Yes, thank you Anthony and Frederic!

Oleg.


