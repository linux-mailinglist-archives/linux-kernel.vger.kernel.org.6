Return-Path: <linux-kernel+bounces-239883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96E926663
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28705286ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689E18307B;
	Wed,  3 Jul 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEugcn0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931717E907
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025425; cv=none; b=QXoWNDNaJMgSWrsB5GJgxJXJwR9M0GHFCdk+sFALn9k1LRn5IWyG+Q9x8qVx7rrPkI907DAxPRqacg1YxygoldFdVXDlq8FIM/xET+BqrjRPgAKQRHi/LNmhsrVZb0FWWpAv3LL1L7CuBIChtAoCzFDzH4JFZbFu8ARFXZbtadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025425; c=relaxed/simple;
	bh=FksarHfzCXE3ZGplhNTLL7fVfA0DNWVG3ObNYiQDLec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjLPn8t0doRhdu64b21IMF576qof0R1glU0tANtt1J6mNfijJAdG9moXg4EKLwxi2867m2cv1hTdmbccnyrzBlVtQgzWCgrdPoMvB4fQKlvDlish5ML9JpVn/mwN8SBG7XKl0YqqstLSDbgdiDqHqif/xRObQWsZzWUKa/ec5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEugcn0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720025422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FksarHfzCXE3ZGplhNTLL7fVfA0DNWVG3ObNYiQDLec=;
	b=gEugcn0uOpSHV9x9tFCUymqPfxDpMTqDN4cRSZG0BO42yJt1DkGuKt+IMmKt45q83AlbTd
	NmIYqStVpMhGi1XcXvSmDxBY8aWt0fj+VgChcDyNjQMe5DDQ1QdEf5JdLfUJw4DOdIkWLT
	NxUX0jNTMWWy1C+Xcha3xSiocKqnlVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-amOs3dJENqSJBEfC8pbPDg-1; Wed,
 03 Jul 2024 12:50:19 -0400
X-MC-Unique: amOs3dJENqSJBEfC8pbPDg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFBC319560AD;
	Wed,  3 Jul 2024 16:50:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B06D030000DD;
	Wed,  3 Jul 2024 16:50:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Jul 2024 18:48:41 +0200 (CEST)
Date: Wed, 3 Jul 2024 18:48:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, brauner@kernel.org,
	tandersen@netflix.com, bigeasy@linutronix.de,
	vincent.whitchurch@axis.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, Martin Liu <liumartin@google.com>,
	Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/1] signal: on exit skip waiting for an ack from the
 tracer if it is frozen
Message-ID: <20240703164836.GC28444@redhat.com>
References: <20240628173247.3507846-1-surenb@google.com>
 <20240629131247.GA6138@redhat.com>
 <CAJuCfpGh9EBqij+Ru_D4ieEHTVx7_a0N8odaOLCPYt3g0iVCQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGh9EBqij+Ru_D4ieEHTVx7_a0N8odaOLCPYt3g0iVCQA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Suren, I am sorry for the late reply,

On 06/30, Suren Baghdasaryan wrote:
>
> > I think it would better to simply change ptrace_stop() to check TIF_MEMDIE
> > along with __fatal_signal_pending() and return in this case.
>
> I think this would not fix the case we are experiencing. In our case
> the tracee is killed from the userspace (TIF_MEMDIE is not set yet),

OK, I misunderstood the problem.

> gets stuck in ptrace_stop() waiting for an ack from the tracer and
> then is picked up by OOM-killer with the abovementioned consequences.

and __task_will_free_mem() returns true if SIGNAL_GROUP_EXIT is set...
Nevermind.

> > Of course, this won't fix all problems.
>
> As I mentioned, I'm not an expert in ptrace, so I'll gladly try any
> better solution if one is proposed.

I do not see any solution, sorry.

ptrace doesn't allow to intercept/nack SIGKILL, but at the same time it
happily allows the killed tracee to sleep in PTRACE_EVENT_EXIT. And even
another SIGKILL/whatever can't wake the tracee up.

This is historical behaviour, I do not see how can we change it. Any
change will break something.

Oleg.


