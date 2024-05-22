Return-Path: <linux-kernel+bounces-186060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929D8CBF55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CB41F21125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897D823CC;
	Wed, 22 May 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUa7dBDq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF181AD0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374248; cv=none; b=YBVLrNiALPOvczuRA6r+qABFHAodMJhg4tLqWtvUnXkPykfTFh2Pz3g1PQwQlXZrrRHR5KbocXQc/xC/DN6ikZDoxTzQdt6pwu7LQ+bg0Ouy7fMFJBJCXMA+hPNnsHZ0Ix95j+UHRDos/nibt/DlpQ5wfcYF3yX9mo1EbTs1Ej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374248; c=relaxed/simple;
	bh=185f0o6YDmbz706gEp2Bii2A0Jvx4E2azYwh4YHvJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfslLp1lHa1vd/aMzUO3Y+v5Hy4Dliv9rmwOgq2inOAE4TixjoHtefSlz2LM+dlb4UJF9VHucb2ieEKYWAXalDcVf6MD1Qg9Lnvwpsb8NCFs1Z2brtTk3jOjTZP9W/lN2Lu3ANgvS2jR+Y1fCq2NdAbiJeurNnnS1tqCag0HxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUa7dBDq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716374246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjwu+eNI3aOAn+mZ1TrRaNTzlfb5xAKe2wZ2Oqksc9A=;
	b=LUa7dBDqq2W2oNuTskBDJz+AVuRriYPKh6O5QIxuc13BJb80okyMyOSToUcld6ObjrbdO/
	4RSYVxlSXbDD2vprI8gPj4yVj+UC57Me5loBsL0U1uG9c9IgF4+0E3sT9+o1LGp9VmHgxw
	9/nikQU0z/LitTX6CJWqs04kpScRDhM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-VfUvVcVxMO2zVkq0ql-odQ-1; Wed,
 22 May 2024 06:37:21 -0400
X-MC-Unique: VfUvVcVxMO2zVkq0ql-odQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 755521C29EA7;
	Wed, 22 May 2024 10:37:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.153])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7D4F2C15BB1;
	Wed, 22 May 2024 10:37:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 22 May 2024 12:35:54 +0200 (CEST)
Date: Wed, 22 May 2024 12:35:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
Message-ID: <20240522103531.GA28435@redhat.com>
References: <20240514175551.297237-1-avagin@google.com>
 <20240514175551.297237-3-avagin@google.com>
 <20240515125113.GC6821@redhat.com>
 <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
 <20240516093427.GA19105@redhat.com>
 <20240516130913.GB19105@redhat.com>
 <CAEWA0a7NGbv32RG3DE=RwuvEUZsjQsfAB=i1f82Rr5oj8drOPA@mail.gmail.com>
 <CAEWA0a6Z+jGKtz1Bdc2tP4YwR6u1zeEhoYY1hYZqdxCZMcgjcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a6Z+jGKtz1Bdc2tP4YwR6u1zeEhoYY1hYZqdxCZMcgjcg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/22, Andrei Vagin wrote:
>
> > On Thu, May 16, 2024 at 6:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 05/16, Oleg Nesterov wrote:
> > > >
> > > > On 05/15, Andrei Vagin wrote:
> > > > >
> > > > > seccomp_sync_threads and seccomp_can_sync_threads should be considered too.
> > > >
> > > > Yes. But we only need to consider them in the multi-thread case, right?
> > > > In this case exit_signals() sets PF_EXITING under ->siglock, so they can't
> > > > miss this flag, seccomp_filter_release() doesn't need to take siglock.
> > >                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> PF_EXITING is set without holding ->siglock if tsk->signal has the
> SIGNAL_GROUP_EXIT flag. I think it can be a case when one thread is in
> seccomp_sync_threads and others are exiting.

Yes, I forgot this.

> > > Hmm. I thought we have something smp_mb__after_unlock(), but it seems we
> > > don't. So we can't add a fast-path
>
> We have smp_mb__after_unlock_lock in include/linux/rcupdate.h.

This is another thing.

But sorry for confusion, this doesn't really matter, we could you a plain mb().
I mean, I was thinking about something like

	seccomp_filter_release:

		smp_mb();
		if (!READ_ONCE(tsk->seccomp.filter))
			return;

		spin_lock_irq(siglock);
		orig = tsk->seccomp.filter;
		...

but then seccomp_sync_threads() should do something like


		orig = READ_ONCE(thread->seccomp.filter);

		smp_store_release(&thread->seccomp.filter,
				  caller->seccomp.filter);

		smp_mb(); // pairs with mb() in seccomp_filter_release()

		if (READ_ONCE(thread->flags) & PF_EXITING) {
			WRITE_ONCE(thread->seccomp.filter, orig);
			continue;
		}
		__seccomp_filter_release(orig);

		...

too subtle even _if_ correct, and I am not sure at all this would be correct.

> > > Cough... Now that I look at seccomp_can_sync_threads() I think it too
> > > doesn't need the PF_EXITING check.
> > >
> > > If it is called before seccomp_filter_release(), this doesn't really
> > > differ from the case when it is called before do_exit/exit_signals.
> > >
> > > If it is called after seccomp_filter_release(), then is_ancestor()
> > > must be true.
> > >
> > > But perhaps I missed something, I won't insist, up to you.
> > >
>
> You are right, this check isn't required in seccomp_can_sync_threads, but
> I decided that it is better to be consistent with seccomp_sync_threads.

OK, agreed.

Oleg.


