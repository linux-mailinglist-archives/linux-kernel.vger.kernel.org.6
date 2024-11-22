Return-Path: <linux-kernel+bounces-418255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033729D5F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33EB1F21EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B11DE89D;
	Fri, 22 Nov 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCkll6ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166D79FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280291; cv=none; b=sCMQfseP3RNFfLMlVFP9NfkL36/7D5gIzJduIct/+t8kfW0EVHE9a72p2JGLvlz55fQ+NV+1QwiI7BHo29JMTH+kCCzELRsjLdUfIdudWerFvYRjvBy8v0Wi+QkvOgWQNIjmVKk/Iz/Cq5K3xj7fJ1O4BP/KZ+P0a7PBYvZLWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280291; c=relaxed/simple;
	bh=Eo0FhijScfV4cmBS+StI0U3QI2rHdiu02UBI14GlSJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4mBwjay/tNW5YMOLGnrPfp8JSjplNJClIxWbF5gVlTMgVak7sxGhjDC4Sd9GSlCNXzzDGqbtCx2wWtYgZldFiTM0i6dksKyvFSnxirPmzDmPOlu8TzEGrxcIGu3QyeSdz9wWZvQDMG25b5KekWmCSDSw/Fuv5xu1zJ61VrMLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCkll6ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CAC4CECE;
	Fri, 22 Nov 2024 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732280290;
	bh=Eo0FhijScfV4cmBS+StI0U3QI2rHdiu02UBI14GlSJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCkll6chHbfdZVcPn/856qoNT6uGQfrso5L5HLfn3dnakva1AdfhzewXpRwT2/Bxi
	 GSnvQBkIWuAVDwKtN9Ehfso4rwD7yxH5pm9OLM4/N7HC2TGGwaFfZf88YhvqJUcWIC
	 qadWaYPIpDGdbq4gavVIoMd5e1pFD+bdmeAH38LIWxSZQFRANBsReOG4JXoJr1EzJy
	 v64a9FauFlhVMhKJX4h9c0+p+ZNxSDcOsyJ0dC+WxzRtTjRS4JjItac6KHafURxDve
	 2Xrn7Cg/BcY392XkCWO2gWe04Cp9Ucttke/WRGit7QY1rT4Ektft3jtXeuoTYf4cp9
	 Kam4MiBaIhyqg==
Date: Fri, 22 Nov 2024 13:58:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <Z0B_38aWqStmhN24@pavilion.home>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
 <20241122082407.GA14342@redhat.com>
 <Z0BliWkMHHzohMt3@pavilion.home>
 <20241122114949.GA24815@redhat.com>
 <Z0BylnuVaxwCNP9n@pavilion.home>
 <20241122123817.GC24815@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122123817.GC24815@redhat.com>

Le Fri, Nov 22, 2024 at 01:38:17PM +0100, Oleg Nesterov a écrit :
> On 11/22, Frederic Weisbecker wrote:
> >
> > Le Fri, Nov 22, 2024 at 12:49:50PM +0100, Oleg Nesterov a écrit :
> > > On 11/22, Frederic Weisbecker wrote:
> > > >
> > > >
> > > > Right, I don't mind either way,
> > >
> > > Me too, so feel free to ignore,
> > >
> > > > though if it's past PF_EXITING,
> > > > complete_signal() -> wants_signal() will defer to another thread anyway, right?
> > >
> > > Right. So I think it would be better to rely on complete_signal() in this
> > > case even if the current logic is very simple and dumb.
> >
> > Just to make sure I understand correctly, this means you'd prefer to keep
> > the PF_EXITING test?
> 
> No, sorry for confusion ;)
> 
> I'd prefer to check t->exit_state in send_sigqueue() and let complete_signal()
> pick another thread if "t->flags & PF_EXITING" is already set.
> 
> But I am fine either way, up to you.

Ok I'm good with t->exit_state, I'm cooking that.

> 
> I guess we can even avoid the additional check altogether, something like below.
> Again, up to you. Your approach looks simpler and doesn't need more comments.
> 
> Oleg.
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1966,7 +1966,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  {
>  	int sig = q->info.si_signo;
>  	struct sigpending *pending;
> -	struct task_struct *t;
> +	struct task_struct *g, *t;
>  	unsigned long flags;
>  	int ret, result;
>  
> @@ -1989,12 +1989,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	 * the same thread group as the target process, which avoids
>  	 * unnecessarily waking up a potentially idle task.
>  	 */
> -	t = pid_task(pid, type);
> -	if (!t)
> +	g = t = pid_task(pid, type);
> +	if (!g)
>  		goto ret;
>  	if (type != PIDTYPE_PID && same_thread_group(t, current))
>  		t = current;
> -	if (!likely(lock_task_sighand(t, &flags)))
> +	if (!likely(lock_task_sighand(g, &flags)))
>  		goto ret;
>  
>  	ret = 1; /* the signal is ignored */
> @@ -2022,7 +2022,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	result = TRACE_SIGNAL_DELIVERED;
>  out:
>  	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
> -	unlock_task_sighand(t, &flags);
> +	unlock_task_sighand(g, &flags);
>  ret:
>  	rcu_read_unlock();
>  	return ret;
> 

That's nice! But with the recent changes in this area, the target pick-up
logic has moved to a separate function posixtimer_get_target() which makes
this trick a bit more difficult.

I'll stick to exit_state for now.

Thanks a lot for your insight!

