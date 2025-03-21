Return-Path: <linux-kernel+bounces-571679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D01A6C0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA08188D397
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2C91D6DC8;
	Fri, 21 Mar 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbVtuNT5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cn3Wb99g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745E18A6CF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575914; cv=none; b=nMP88Upga71cj9FU1CAvjx0cqwL6MxOP4FTuqY+1r6TP/5iyrcZDpYZnBPB75g3RWHQzr88lnGYPvWlQC+FqTkwLtnk9VrbxSJkQDSuI045g4Q4cFszf6k+1mlw2wxpvQ5mscpq72QitRiNMBGxtDTMu7qE0I0yd4Q7gWXjxxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575914; c=relaxed/simple;
	bh=LItW7abAohlNLOW6uCHh9esJqQNbNGbZxPlnD0uDwkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UamNlMKwfeafKjpZopWUtr9ZPhuLL23Xkg+4uCXIbaq2T0s4oB9jtxI0hL03qhOWa5SBOH+G0WaR3/LddUHlkrkRkFQaN5cWL9MvbUESxOiQHmjFrSS3li7rGFsFyA92xmuodoRlzC/FicWnqu6OUeb+EPzsQenJuljplfvyUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YbVtuNT5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cn3Wb99g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742575911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TqgL0EIEnaq60AHfIzTkRxgGWrdabrFLLDMbves6sA=;
	b=YbVtuNT5RVoFigf/y/ty8IFXDmrkFiKSnwihnP0EMWu1vKr7HMHE8reFCkzaNoo6TQJax6
	WecE+kp/jwxWqFpiYYBIwjyuvKpLX8Gw/HSO2tinkGEKOVObFrlICMseWnE9nXf5AebSxq
	5UVTwSUWdHXHohsXVLlccubYAWIzXFyp0JntQHtlI0CUGFBiT0LihIpP+ePr12ytruKuEh
	HYaHKtvxRefThVQSursYzmtrvUShxsVZYPAVBnBg5kKmV61HCLBwgsfKy6lbVGzq7TvL3Z
	mbGvBhr2AUmY8X7+q5zaltksT94Z3Omimv6FdlyGvJ6qk+oIE8p9xl7KBFchWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742575911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TqgL0EIEnaq60AHfIzTkRxgGWrdabrFLLDMbves6sA=;
	b=cn3Wb99gqK4/N362X0nx3hj3wu+4GYi96fDMi3Pg+c3U6U4nezIUHR3RLA5TyclnEwqT+w
	sc85gVEmFW5BnOAA==
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
In-Reply-To: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
Date: Fri, 21 Mar 2025 17:51:50 +0100
Message-ID: <871puq2uop.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 20 2025 at 23:05, Josh Poimboeuf wrote:

> CONFIG_TRACE_BRANCH_PROFILING inserts a call to ftrace_likely_update()
> for each use of likely() or unlikely().  If the caller is noinstr, that
> breaks the noinstr rules.
>
> Disable branch profiling for files which have noinstr functions.  Fixes
> many warnings like the following:
>
>   vmlinux.o: warning: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x33: call to ftrace_likely_update() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: handle_bug.isra.0+0x198: call to ftrace_likely_update() leaves .noinstr.text section
>   ...

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for fixing this!

Though the real fix would be to rip out this likely/unlikely tracer
hackery all together.

        tglx

