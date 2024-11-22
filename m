Return-Path: <linux-kernel+bounces-418816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8829D65D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7459B210FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1918C002;
	Fri, 22 Nov 2024 22:40:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EAB176FD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315258; cv=none; b=Fr6rx4PY8BBjNZFM864wLidyjJ6YdrqtXF9MlYgrhzzOSZJRvN7xze1CdRzzgOufeeMlOusqebcPBMKVhyDHHxA3EBaQlQUaUArPbPGN1weg68QGxJ3DdzdqQN2WoClAgi6LFOE2oJa0aaP4PILH1+MhPJwyn3mleGrxm5gDPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315258; c=relaxed/simple;
	bh=MizD7KFsZZVqpitCs1S/DOAZGxYwMEWpEHjxQOxHJLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDoqkDnsU3wYmIZr59gHaqG3TM1RBBIqjzQRTVgBkmhBvo4S7JcJdQE5ZdxgEqFgVd20I5JRbrXgUsaXjV3HAREi+3tBWMSATOnM36Hdvaw0HHcGVMRCZYjXXXTGwOfI6kyy2Ewc7ZMe0BSOBzdOPZlS5mMa//LvMG9NEFR/R3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF3C4CECE;
	Fri, 22 Nov 2024 22:40:55 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:41:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Colin Ian King
 <colin.i.king@gmail.com>, Jeff Xie <jeff.xie@linux.dev>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt
 <justinstitt@google.com>, Levi Yun <yeoreum.yun@arm.com>, Li Chen
 <chenl311@chinatelecom.cn>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tatsuya S
 <tatsuya.s2862@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, guoweikang <guoweikang.kernel@gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.13
Message-ID: <20241122174136.18f97fb6@gandalf.local.home>
In-Reply-To: <CAHk-=wh+bbO9nYxCz5CPf6oGB0upCFH4jx9Bx36f1f3+_DcDUQ@mail.gmail.com>
References: <20241120214531.45d75a60@gandalf.local.home>
	<CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
	<20241122171323.1dd0efc9@gandalf.local.home>
	<CAHk-=wh+bbO9nYxCz5CPf6oGB0upCFH4jx9Bx36f1f3+_DcDUQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 14:30:10 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 22 Nov 2024 at 14:12, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Hmm, if we make a __DO_TRACE_SYSCALL(), I don't think it needs to even have
> > that condition parameter.  
> 
> That was my point. The whole conditional - and the parameter - seems
> to be completely pointless as far as I can tell.
> 
> That said, I think you can actually simplify things even further: if
> you move the TO_CONDITION() checking into the caller, you could move
> the locking there too.
> 
> IOW, instead of this pattern:
> 
>                 if (static_branch_unlikely(&__tracepoint_##name.key))   \
>                         __DO_TRACE(name,                                \
>                                 TP_ARGS(args),                          \
>                                 TP_CONDITION(cond), 0);                 \
> 
> you could make it be something like this instead:
> 
>                 if (static_branch_unlikely(&__tracepoint_##name.key)) \
>                         if (TP_CONDITION(cond)) \
>                                 scoped_guard(preempt_notrace) \
>                                         __DO_TRACE(name, TP_ARGS(args)); \

Hmm, I wonder why I didn't do that in the first place :-/

But doing a little git forensics, I added that with:

  287050d390264 ("tracing: Add TRACE_EVENT_CONDITIONAL()")

Which goes back to December of 2010!

I have no idea what I was thinking back then :-p

> 
> where __DO_TRACE() would get neither the "cond" argument _nor_ that
> locking argument, because both are just done by the two users (the
> other one would use "scoped_guard(rcu_read_trace)" of course.

IOW, remove __DO_TRACE() and just call __DO_TRACE_CALL() directly.

> 
> And look, this is another reason why unconditional locking is a good
> thing: now you can use the "guard()" model for the lock, and don't
> need an explicit unlock, simplifying the code more.
> 
> Of course, you want "guard(rcu_read_trace)" (for system call events)
> and "guard(preempt_notrace)" (for the regular trace event case), and
> we don't have the "notrace" versions of those guard classes yet.
> 
> But adding those would literally be trivial, ie something like
> 
>   DEFINE_LOCK_GUARD_0(rcu_notrace,
>         rcu_read_lock_notrace(), rcu_read_unlock_notrace())
> 
> wouldn't that make it all look really nice?
> 
> NOTE NOTE NOTE! I didn't actually try any of the above in real life,
> so I might be missing some important detail. I'm just pointing out
> that making this all unconditional and not based on random flags has
> the potential for even more cleanups.
> 
> And I might have gotten the different lock names confused too.

Thanks for the analysis.

-- Steve

