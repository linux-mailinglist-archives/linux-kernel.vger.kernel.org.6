Return-Path: <linux-kernel+bounces-181091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B04F8C7750
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4206EB2089E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82408146A8A;
	Thu, 16 May 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YelBLipc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98B145B3D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865048; cv=none; b=Mo1So89vjja6CG8LjqyhGnOhvZ5llOSLzfyV17euRpTUhOmorqyIibRkv3L0lSoOuKVPCDVptgpnozZNetynId1qnd5Amr/vt3TNILswd+f1lwEjd9aNLCThe0aSlPZwTMu3+9usAqG5BZJE84qrRvGSlPNQ9FXLUFE7zis6S8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865048; c=relaxed/simple;
	bh=+qN5DxB61g3Rpzjt8cPs2wxxF/2JTkfmz6mnIXDsgT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNaqrwyEXefxt279Hy/9k6qc2YlCqnll9p+nhhIRTtFSauiNdvBstcx+1yrYDPheblsz5vidDRRqjWILtamLjCaqznFpbRVh7ZqriiQRaLCL9UJ3yhdUdx+OXMEAEp2arBTwdL5wF6lMFnBKxgPu/9CaxhT29gfJN+TEXoCwdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YelBLipc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715865045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MzQGMFLfrhhSl6bSyuFe86ROBiqTDOIvxRDFN1T/dk=;
	b=YelBLipcYAjin2YZ0J2tgBxCFB2O25V1d9JywfucH141C2Ke4FZCPuWQ9ULguh18OFDsrB
	psiOcScNLPGwUoOhu8bDINLNDm71YCCcakjyF4jbDdtq7MVnSpjc8p6fAgVIXO86N3Xksc
	40wg23ikzmCvjEE3W5mnMLkQNnDaeEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-x07UT-oNMRe252-Bln2tow-1; Thu, 16 May 2024 09:10:44 -0400
X-MC-Unique: x07UT-oNMRe252-Bln2tow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF3AC800074;
	Thu, 16 May 2024 13:10:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.2])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8DDD4200A0B4;
	Thu, 16 May 2024 13:10:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 May 2024 15:09:17 +0200 (CEST)
Date: Thu, 16 May 2024 15:09:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
Message-ID: <20240516130913.GB19105@redhat.com>
References: <20240514175551.297237-1-avagin@google.com>
 <20240514175551.297237-3-avagin@google.com>
 <20240515125113.GC6821@redhat.com>
 <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
 <20240516093427.GA19105@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516093427.GA19105@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 05/16, Oleg Nesterov wrote:
>
> On 05/15, Andrei Vagin wrote:
> >
> > seccomp_sync_threads and seccomp_can_sync_threads should be considered too.
>
> Yes. But we only need to consider them in the multi-thread case, right?
> In this case exit_signals() sets PF_EXITING under ->siglock, so they can't
> miss this flag, seccomp_filter_release() doesn't need to take siglock.
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ah, no. seccomp_filter_release() does need to take ->siglock even if we
forget about proc_pid_seccomp_cache().

Without siglock

	orig = tsk->seccomp.filter;

can leak into the critical section in exit_signals() (spin_unlock is the
one-way barrier) and this LOAD can be reordered with "flags |= PF_EXITING".

Hmm. I thought we have something smp_mb__after_unlock(), but it seems we
don't. So we can't add a fast-path

	if (!tsk->seccomp.filter)
		return;

check at the start of seccomp_filter_release().


Cough... Now that I look at seccomp_can_sync_threads() I think it too
doesn't need the PF_EXITING check.

If it is called before seccomp_filter_release(), this doesn't really
differ from the case when it is called before do_exit/exit_signals.

If it is called after seccomp_filter_release(), then is_ancestor()
must be true.

But perhaps I missed something, I won't insist, up to you.

> > If we check PF_EXITING in all of them, we don't need to take ->siglock in
> > seccomp_filter_release. Does it sound right?
>
> The problem is a single-threaded exiting task. In this case exit_signals()
> sets PF_EXITING lockless. This means that in this case
>
> 	- proc_pid_seccomp_cache() can't rely on the PF_EXITING check
> 	  but it can be safely removed.
>
> 	- seccomp_filter_release() needs to take ->siglock to avoid the
> 	  race with proc_pid_seccomp_cache().
>
> And this chunk from your patch
>
> 	 static void __seccomp_filter_orphan(struct seccomp_filter *orig)
> 	 {
> 	+       lockdep_assert_held(&current->sighand->siglock);
> 	+
>
> looks unnecessary too, seccomp_filter_release() can just do
>
> 	spin_lock_irq(siglock);
> 	orig = tsk->seccomp.filter;
> 	tsk->seccomp.filter = NULL;
> 	spin_unlock_irq(siglock);
>
> 	__seccomp_filter_release(orig);
>
> Right?
>
> Oleg.


