Return-Path: <linux-kernel+bounces-418144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775B9D5DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DCB254A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDED1DDC2B;
	Fri, 22 Nov 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFDqSxIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9718FDB4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273549; cv=none; b=K4nKT9eS5Z07HbtG6cbzL2L/phf2cAXhmU0Po1J26vNfQKZbASDiQZXVBenv4l0uBKc/x560ZxzTntZZdXfUioh9AD/jR4qug41isF8n+tQP3RHmUA7wFoLTmsYo5oCEwNyP6luJHVFE3ANVCUBBZZZBINEf0AqhpFaR6sjPc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273549; c=relaxed/simple;
	bh=97OFr52T+2zclV5kEKwGrhQyXDAWRvs3IsvLsUTDp9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZhA/J9i+bgI6U/ipIQ1wA0eeeoOTG9qgzNM+6HUlCZimj14qXlYfDU+OL/g++eqbwjZUuIL6we8xELTEE7BlPAH163Fxn+X4QKIXQ4RdaN9avMQsiDQOSOJvHI0LwwGjQ3LJKwpCr/5iKQK78jDfcUhVn1oB9x28AGNJT1Q6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFDqSxIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D42DC4CECE;
	Fri, 22 Nov 2024 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732273548;
	bh=97OFr52T+2zclV5kEKwGrhQyXDAWRvs3IsvLsUTDp9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFDqSxIKxOKQXpvyw6uCVVxymNd/EPsimBcaRh7127dzvE3nVqxGshFOjp7HINIJX
	 mCqb1vQ3JJHd5oyuxfi60JN1XNKtYlI+FF9G4ZrrCv9kRSqnLUn3dmVhHr45DtY89t
	 9ueStAoVTpLvUItnmoqfkxPRFTikY7EOCm31+CvstXntuxc/97vF2fxRrrZMljS4mr
	 H5lUWqqyLTWBWKUezgEVYm3lBQuMLkHIU3BN5yJY8MdKH7/KCvt7X7nHpq2u29duFi
	 llvXCExuxtyJV6e4RjgtZBu9VKKg8Ac+gq1qncHFpTGWjKBfGE7j/2p/4YTRc+pv5r
	 cJLju+1NETsIA==
Date: Fri, 22 Nov 2024 12:05:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <Z0BliWkMHHzohMt3@pavilion.home>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
 <20241122082407.GA14342@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122082407.GA14342@redhat.com>

Le Fri, Nov 22, 2024 at 09:24:07AM +0100, Oleg Nesterov a écrit :
> On 11/21, Frederic Weisbecker wrote:
> >
> > I think this started with commit:
> >
> > bcb7ee79029d (posix-timers: Prefer delivery of signals to the current thread)
> >
> > The problem is that if the current task is exiting and has already been reaped,
> > its sighand pointer isn't there anymore.
> 
> Thanks...
> 
> This can only happen if the exiting task has already passed exit_notify() which
> sets exit_state. So I'd suggest to check current->exit_state instead of PF_EXITING
> in the patch below.
> 
> Oleg.

Right, I don't mind either way, though if it's past PF_EXITING,
complete_signal() -> wants_signal() will defer to another thread anyway, right?
Due to retarget_shared_pending() being called after the flag being set...

Thanks.

> 
> > And so the signal is ignored even
> > though it should be queued to and handled by the thread group that has other
> > live threads to take care of it.
> >
> > Can you test the following patch? I'm cooking another patch with changelog for
> > upstream that has seen recent changes in this area.
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 8f6330f0e9ca..4cadee618d4b 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1984,7 +1984,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
> >  	t = pid_task(pid, type);
> >  	if (!t)
> >  		goto ret;
> > -	if (type != PIDTYPE_PID && same_thread_group(t, current))
> > +	if (type != PIDTYPE_PID && same_thread_group(t, current) &&
> > +	    !(current->flags & PF_EXITING))
> >  		t = current;
> >  	if (!likely(lock_task_sighand(t, &flags)))
> >  		goto ret;
> >
> >
> 

