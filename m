Return-Path: <linux-kernel+bounces-180852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F78C73ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5510E1C23625
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F81143756;
	Thu, 16 May 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFZblfy3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049014206C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852169; cv=none; b=BwB2HgKkvJguS0ipfSGHueheFfdiTpbx+iVjwdecWom2qclDHjinuLZkSl23oc44yUSMw7oVlS9YUOEsr1utEpvjtQr29VNBUaGJrm+Jf2DF0dAmkY51ql69UsjDw+aiWmocd8QaqdA/fiUhUcCsP4FFa1Fqc0oE8JKbTExUp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852169; c=relaxed/simple;
	bh=uCfkLZC4W23IMhkNSt5UjZZOZ8zoEycyPFMgOcCJxr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqAKrK2dTLo7vs8kO+suyWPAENA3HodzXunTQwWy9SGOsWJ0E5alsCd+JUefXHDF8K3fDMXbCVaaMzCrgEvFYkqaCymF1cXnR1Anwg13M1rIDqpbEHTFfJPhAm7ssLGpqDY/TTFIuevxrd2DthFsJND7sTrLC2R58N8BE/1wY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFZblfy3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715852166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UByR8P9Oho2soPbcOv2VtbjmixfuIwy3VhsBVqvGng=;
	b=NFZblfy3xW+/05G+9hMuP8Cdjzo8SeNPw43FWvnTNs9gqa/mB8wnLHly1UMXB+suDQO/TB
	GTTxIDJLX3kiJC/D2VaLBIVQpWJ3iatAhn9bFj96cxwnlTTPMVPGRqd/mOD8v/jYhFwwOU
	PlT3GIvGFuqbCCH+YQKGhjyDs1Olpd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-GgKswWIXM-OD4SoPgGOvQA-1; Thu, 16 May 2024 05:35:56 -0400
X-MC-Unique: GgKswWIXM-OD4SoPgGOvQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10F98857A83;
	Thu, 16 May 2024 09:35:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.2])
	by smtp.corp.redhat.com (Postfix) with SMTP id 02C76100046D;
	Thu, 16 May 2024 09:35:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 May 2024 11:34:30 +0200 (CEST)
Date: Thu, 16 May 2024 11:34:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
Message-ID: <20240516093427.GA19105@redhat.com>
References: <20240514175551.297237-1-avagin@google.com>
 <20240514175551.297237-3-avagin@google.com>
 <20240515125113.GC6821@redhat.com>
 <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

(add lkml)

On 05/15, Andrei Vagin wrote:
>
> On Wed, May 15, 2024 at 5:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Let me repeat I forgot everything about seccomp, but let me ask
> > a couple of questions...
>
> It seems you still remember something:). Thank you for the feedback.

Just I am still remember how to use grep ;)

> > > @@ -2126,6 +2137,11 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
> > >        */
> > >       spin_lock_irq(&task->sighand->siglock);
> > >
> > > +     if (task->flags & PF_EXITING) {
> > > +             spin_unlock_irq(&task->sighand->siglock);
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> >
> > Why do we need the PF_EXITING check here?
> >
> > This looks unnecessary even if get_nth_filter() could race with the
> > exiting task, but this doesn't matter.
> >
> > This race is not possible, get_nth_filter() is only called from ptrace()
> > paths, but the tracee can't stop in TASK_TRACED after exit_signals() which
> > sets PF_EXITING.
>
> If we rely on using seccomp_get_filter only from ptrace, you are right.

Plus it too does __get_seccomp_filter/__get_seccomp_filter, so I guess it
should be safe without this check even if it could be used outside of ptrace.
Just like proc_pid_seccomp_cache(), see below.

> > > @@ -2494,6 +2510,11 @@ int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
> > >       if (!lock_task_sighand(task, &flags))
> > >               return -ESRCH;
> > >
> > > +     if (thread->flags & PF_EXITING) {
> > > +             unlock_task_sighand(task, &flags);
> > > +             return 0;
> >
> > Again, do we really need this check?
> >
> > It can race with the exiting task and (without this check) do
> > __get_seccomp_filter(f) right before seccomp_filter_release()
> > takes sighand->siglock. But why is it bad?
>
> I think you are right, this check isn't required.
>
> >
> > OTOH. I guess proc_pid_seccomp_cache() is the only reason why
> > seccomp_filter_release() takes ->siglock with your patch?
>
> seccomp_sync_threads and seccomp_can_sync_threads should be considered too.

Yes. But we only need to consider them in the multi-thread case, right?
In this case exit_signals() sets PF_EXITING under ->siglock, so they can't
miss this flag, seccomp_filter_release() doesn't need to take siglock.

> If we check PF_EXITING in all of them, we don't need to take ->siglock in
> seccomp_filter_release. Does it sound right?

The problem is a single-threaded exiting task. In this case exit_signals()
sets PF_EXITING lockless. This means that in this case

	- proc_pid_seccomp_cache() can't rely on the PF_EXITING check
	  but it can be safely removed.

	- seccomp_filter_release() needs to take ->siglock to avoid the
	  race with proc_pid_seccomp_cache().

And this chunk from your patch

	 static void __seccomp_filter_orphan(struct seccomp_filter *orig)
	 {
	+       lockdep_assert_held(&current->sighand->siglock);
	+

looks unnecessary too, seccomp_filter_release() can just do

	spin_lock_irq(siglock);
	orig = tsk->seccomp.filter;
	tsk->seccomp.filter = NULL;
	spin_unlock_irq(siglock);

	__seccomp_filter_release(orig);

Right?

Oleg.


