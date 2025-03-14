Return-Path: <linux-kernel+bounces-560672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA44A607F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BFB189FC68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64813633F;
	Fri, 14 Mar 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ52ARFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694F2E3368
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924626; cv=none; b=ZTbZpuwWG/jmDeLljhSne1inkP7lenuWRswJoQeENWDLgWTcXB2h0sU+njZ6j8dzyEioow9/5nm0CedkzFnft1upUgNmHIE7HmUgZWIF2V7ERftWFpuIeG64No1wXcQ8AjLGUoBsEoj5Ieq2MQq4mcliJfydCaAvhB0P4C7swec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924626; c=relaxed/simple;
	bh=eVhz0dM8Si2LGrbI7U3eIT1DLlq6q4vu/1VKwbyzC5Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hdafxVejVI5zoBAs8rB+v3268tROGTQbWP2BbWHHU+NQhLXS4ej5VJQL4NoXvXwkcfiAu5yFQubg7OMrf7MgsdZOysBrrUxVM/gnCZ0Uix3aCKL9Yk3uuqqEWNh9eA0dQnWGPJPlaug/ue2LkMJHF5aIMNxWJozh9Q3KYzE0hkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ52ARFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F27C4CEE3;
	Fri, 14 Mar 2025 03:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741924625;
	bh=eVhz0dM8Si2LGrbI7U3eIT1DLlq6q4vu/1VKwbyzC5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQ52ARFw6VqENt98nbVJEzuB/zTC+MaDWcEhokGJPuv8mEw1wk/da73g4tVJ1uKRB
	 QmYaAT9ZikJ4XgP6BvB3UqdtUcku0csiWM4Hv81lgxj7qBtR7tpyu87sWfw2vWdTrH
	 Kt7ygVVt1FeFHQNAidtch5HYiMTW0hvn7kQyhC2fsKYvoeXCRD+gE68Z+DkWzTQ2Ii
	 oUhYa8P7wwkfukz/Ef3AVgonYOMtBsTsOyulM3tMc/NVrdXdnQ6p9LDeo1x39i8ADj
	 8t0abdI4BBXUnfhVZqNbHSkUC2CRw70YY/DV1tj5ikr2P67NLNVGC0XcqGNV8NegGN
	 7ZZdg2D+xdOaQ==
Date: Fri, 14 Mar 2025 12:57:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman
 Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250314125700.86cc80f6cc51af636f453056@kernel.org>
In-Reply-To: <20250313152946.69f209c76a6f479c46584ef0@linux-foundation.org>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
	<20250313152946.69f209c76a6f479c46584ef0@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 15:29:46 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 25 Feb 2025 16:02:34 +0900 "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > The "hung_task" shows a long-time uninterruptible slept task, but most
> > often, it's blocked on a mutex acquired by another task. Without
> > dumping such a task, investigating the root cause of the hung task
> > problem is very difficult.
> > 
> > This introduce task_struct::blocker_mutex to point the mutex lock
> > which this task is waiting for. Since the mutex has "owner"
> > information, we can find the owner task and dump it with hung tasks.
> > 
> > Note: the owner can be changed while dumping the owner task, so
> > this is "likely" the owner of the mutex.
> > 
> > With this change, the hung task shows blocker task's info like below;
> 
> Seems useful.
> 
> > ...
> >
> > +static void debug_show_blocker(struct task_struct *task)
> > +{
> >
> > ...
> >
> > +}
> > +#else
> > +#define debug_show_blocker(t)	do {} while (0)
> > +#endif
> > +
> 
> Nit. It's unpleasing to have one side a C function and the other a
> macro.  Plus C functions are simply better - only use a macro if one
> has to!

Ah, that's nice to know. Thanks for the fix!

> 
> So,
> 
> --- a/kernel/hung_task.c~hung_task-show-the-blocker-task-if-the-task-is-hung-on-mutex-fix
> +++ a/kernel/hung_task.c
> @@ -125,7 +125,9 @@ static void debug_show_blocker(struct ta
>  	}
>  }
>  #else
> -#define debug_show_blocker(t)	do {} while (0)
> +static inline void debug_show_blocker(struct task_struct *task)
> +{
> +}
>  #endif
>  
>  static void check_hung_task(struct task_struct *t, unsigned long timeout)
> _
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

