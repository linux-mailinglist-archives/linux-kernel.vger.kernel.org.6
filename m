Return-Path: <linux-kernel+bounces-418188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941EC9D5E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE5281803
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404D1CB329;
	Fri, 22 Nov 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRIrofwc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD21A0726
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276222; cv=none; b=Q9k9ojWN+LIoHlGmczSVPD4QEFARrzBJXhaReQzjLK9ukCSDS8k11PG3FVBSVKGxm7yjjyksoejz17zaFPgQ95dQtmZIL6yfBHQUNNeQUOwtlOvod1aVobgrQbY2vKHPGlKmplr6LRgTdXSqOOOReI60+PB5Rjqo2hCGAjaWYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276222; c=relaxed/simple;
	bh=psmtJePHQOvZfNKGNIAfEoILSWKFcZRtdDn1wyFvj0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnYOsPPQ6BlhnBzm6m5+/SF1T0xy0rJKgr8t3f1qJKQO/jI9JmNzX9VG8GP1DBsJ6SDACU6CXfEDOZZh4i5+Irrt83zhTS+LBP8d+QAaB/U+/bKVSy8bIW9l3/dQMRPf3DyvPPN1sW3IIDVHMnrL5MZwCgu1/eqTK5hjS+C/tLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRIrofwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732276219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psmtJePHQOvZfNKGNIAfEoILSWKFcZRtdDn1wyFvj0w=;
	b=ZRIrofwcXUlMykkFpjkvSZyEpl0srStA5w432KykAkwVy2nrFYdJ2Gfah8e1pgirIhByR7
	/ymJmJr2oyUdb0lCqIVw0/9M88+iDzlPY6tYC/X8LwcX/Pna4Zlb0KpjWKvEMPQcEB8RuX
	/HPOdPuNR7LYMjfKWsNrGwje1rD2WHI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-GFa6ftCbNSm-4Vhfxrnn6A-1; Fri,
 22 Nov 2024 06:50:15 -0500
X-MC-Unique: GFa6ftCbNSm-4Vhfxrnn6A-1
X-Mimecast-MFC-AGG-ID: GFa6ftCbNSm-4Vhfxrnn6A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 675C41955F67;
	Fri, 22 Nov 2024 11:50:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7245B1956086;
	Fri, 22 Nov 2024 11:50:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Nov 2024 12:49:54 +0100 (CET)
Date: Fri, 22 Nov 2024 12:49:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <20241122114949.GA24815@redhat.com>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
 <20241122082407.GA14342@redhat.com>
 <Z0BliWkMHHzohMt3@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0BliWkMHHzohMt3@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/22, Frederic Weisbecker wrote:
>
> Le Fri, Nov 22, 2024 at 09:24:07AM +0100, Oleg Nesterov a écrit :
> > On 11/21, Frederic Weisbecker wrote:
> > >
> > > I think this started with commit:
> > >
> > > bcb7ee79029d (posix-timers: Prefer delivery of signals to the current thread)
> > >
> > > The problem is that if the current task is exiting and has already been reaped,
> > > its sighand pointer isn't there anymore.
> >
> > Thanks...
> >
> > This can only happen if the exiting task has already passed exit_notify() which
> > sets exit_state. So I'd suggest to check current->exit_state instead of PF_EXITING
> > in the patch below.
> >
> > Oleg.
>
> Right, I don't mind either way,

Me too, so feel free to ignore,

> though if it's past PF_EXITING,
> complete_signal() -> wants_signal() will defer to another thread anyway, right?

Right. So I think it would be better to rely on complete_signal() in this
case even if the current logic is very simple and dumb.

> Due to retarget_shared_pending() being called after the flag being set...

Yes. Whatever we do send_sigqueue/complete_signal can choose an exiting thread
which doesn't have PF_EXITING yet, in this case retarget_shared_pending() from
that thread will pick another target for signal_wake_up/TIF_SIGPENDING.

Thanks!

Oleg.


