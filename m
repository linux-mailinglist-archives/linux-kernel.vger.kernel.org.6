Return-Path: <linux-kernel+bounces-418777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE059D658F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4DC28204C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992918A6A0;
	Fri, 22 Nov 2024 22:12:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519371DA5E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313565; cv=none; b=dJxTS2QaWcpnTcNGqeeHGb2Ev4Mfybtna6QFeDWGe/Lsp2u9xajT95HyvoirEfNDJtrvj8ttkTDupH7LAwP12Y2tlROe4i2Q05ABZn18hEcV/SZ4vPpnOXexohEhZanwr8MQv3BdFwcHTtziclNUm9Xiybi6f8ipuVF5RKP3Mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313565; c=relaxed/simple;
	bh=Wc5Vj0VWpto2fI5F5wYnTXvKYPCv79RVVyw79IUC4DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaRtAGQV2JSh7d6xXkDRkDbw9hIEHgzBVBCMFPxmpzfbeVWRC3NsbXjVSG7CQIgSVLhH6e0Z9IicccDrWl0wH+0bArPvGF2ALe+rRmYKkJU8TRXOtMI0KxceyLrHmm8858615C0TpZan8UwJyS8TpDBMfIQXnQ/8+q44knbLCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0D5C4CECE;
	Fri, 22 Nov 2024 22:12:42 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:13:23 -0500
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
Message-ID: <20241122171323.1dd0efc9@gandalf.local.home>
In-Reply-To: <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
References: <20241120214531.45d75a60@gandalf.local.home>
	<CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 13:54:49 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And yes, it's a static conditional, but it's *STUPID*. And it makes
> the code just harder to follow, for no good reason. The difference is
> literally this magic
> 
>                         __DO_TRACE(name,                                \
>                                 TP_ARGS(args),                          \
>                                 TP_CONDITION(cond), 0);                 \
> 
> vs
> 
>                         __DO_TRACE(name,                                \
>                                 TP_ARGS(args),                          \
>                                 TP_CONDITION(cond), 1);                 \

Hmm, if we make a __DO_TRACE_SYSCALL(), I don't think it needs to even have
that condition parameter. The TP_CONDITION() is to allow tracepoints to
check a condition within the static_branch() portion of the tracepoint so
the condition does not get called when tracepoints are disabled (and just a
nop).  By default we have:

#define DECLARE_TRACE_SYSCALL(name, proto, args)			\
	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
				cpu_online(raw_smp_processor_id()),	\
				PARAMS(void *__data, proto))


Where the tracepoint has to at least be called when the current CPU is
online. But is there every a case where a CPU is not online when a system
call is entered or exited?

And there isn't any use cases of calling the system call tracepoint with a
condition. Hence, I think the __DO_TRACE_SYSCALL() doesn't even need to
include the condition:

#define __DO_TRACE_SYSCALL(name, args)					\
	do {								\
		int __maybe_unused __idx = 0;				\

Oh, also the __idx isn't used since I removed the SRCU, so we can remove
that too. Maybe make that a separate patch?

		rcu_read_lock_trace();					\
									\
		__DO_TRACE_CALL(name, TP_ARGS(args));			\
									\
		rcu_read_unlock_trace();				\
	} while (0)

-- Steve

