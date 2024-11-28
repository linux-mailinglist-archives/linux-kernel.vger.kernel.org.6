Return-Path: <linux-kernel+bounces-425065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD39DBD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59D3281E73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57871C304A;
	Thu, 28 Nov 2024 20:51:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EA9463;
	Thu, 28 Nov 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827085; cv=none; b=FqQ08s2GE6rSnyy3KANpzYUVeQ6P5cWMnRGaHa2mvj7Xok2bNKKt1wiW9hNQCLE+7Q58tb4iVXQ4/awFPYbUF/djvR6zaog0WqShRMVfGruvFiAR6tftdxSH9HPr0ZepRQvpD3zMmC/50yNhPYij0LBR8e2R9IxdRsaUQegNEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827085; c=relaxed/simple;
	bh=0Gcd8UtTepboHbc9GxWCCJOyY/oF2/mm+u3mSoVwcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRv2RwT8hqGlSW6mh6j7zXzaoqM8gzc7IdyCW9QZwC/bWevJABQQATcmiVqmQNPEbyX+igKT2q9cHor7BYI5kR5Hd9c0UJyx6K8PfFvCHZxnLQ/ySvlZd2L0pVN03S4aG/SOUr6e9irbk4BZM8eY+QgUJkRLaCyctSXxXC4fYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A43BC4CECE;
	Thu, 28 Nov 2024 20:51:22 +0000 (UTC)
Date: Thu, 28 Nov 2024 15:51:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda
 <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tracing: More updates for 6.13
Message-ID: <20241128155120.6e6cd300@rorschach.local.home>
In-Reply-To: <CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
References: <20241127131941.3444fbd9@gandalf.local.home>
	<CAHk-=wgwQ5gDdHgN54n8hsm566x5bauNPsdZPXm6uOCFvPA1+Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:55:34 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> I checked my resolution against yours, and I don't think your
> resolution is right.
> 
> You didn't check 'cond' on regular rust tracepoints, and you didn't do
> any locking on either kind.

Bah, you're right. The cond is only needed if they utilize it, which
I'm not sure they do, but the locking is definitely needed. My brain
was off when doing the merge conflict. I was thinking more of "what
makes this compile" than how it actually works.

> 
> I've pushed out my resolution, and hopefully rust people can actually
> test it. I might just be full of it.

Looks better than what I had. I'll kick my tests on it just as a sanity
check.

> 
> That said, I also think that the "__rust_do_trace_##name" inline
> helper should just be renamed to "__trace_##name", and then the
> regular trace_##name() helper could use that inside the
> static_branch_unlikely() check. Because that seems to be the only real
> thing the "rust" version wants - avoiding the static branch
> infrastructure in favor of whatever rust infrastructure.

Hmm, I think that could be done.

> 
> But hey, I do basic sanity build testing of the rust code, I don't
> actually _know_ it. Again, I might be missing something.

I need to spend some time understanding the rust code, so I can at least
review it better.

-- Steve

