Return-Path: <linux-kernel+bounces-446287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 739979F222E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4407A1053
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FAC8FE;
	Sun, 15 Dec 2024 04:38:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768D8F40
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734237508; cv=none; b=T+tqnYhFGLoakv9DsFiSSd1p1bsuUbD+9P4OqtJtQaR5jlBO3OtBNU4aBgAl9Dtdk+lDpy62dXkeiA64vAIGWItWivjNlZp5wWsuQQlwSzUQZX9KBAmjzw3wmteXr86Jy6yINuV03g5XCUX6RK8YRHLNPamfxa860Wk8TRv4nZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734237508; c=relaxed/simple;
	bh=4BpIWSjrX9gSVv91KXgQLQ2xZhih4lDULHvQfImW/bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+9KYrLQ0hqI5D5Vz/apXak+8Y8wyyNqu9sxDmq6NwBGnY3d0PvMDjSn+9KATiC5f4hHSSRhCunGP6r1Z0EiMVVqNKa/zRBwLJ4Q/9Im23WWlvTaw1m8yxtgbI4ay7jElQF0ovuYNsfAmZgvF5lvMFtuC9jkRpgBycmwff7OYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD05C4CECE;
	Sun, 15 Dec 2024 04:38:26 +0000 (UTC)
Date: Sat, 14 Dec 2024 23:38:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214233855.46ad80e0@gandalf.local.home>
In-Reply-To: <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:11:50 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> No, that vsprintf code wouldn't deal with any tracing-specific sanity
> checks that say "the pointer is in the trace ring buffer", but as
> mentioned, *that* code is entirely separate from the thing I'm
> objecting to anyway.

So what are you objecting to?

The current change, or the code that's already been there?

I'm also mistaken to what caused the bug and the Fixes tag is incorrect. I
thought the trace_check_vprintk() came before the code that added the
"%px", but it did come after. The "%px" code was added in 2020 and the
trace_check_vprintk() was added in 2021. The mistake was that it missed the
"hash-ptr" off case that then passes the iter->fmt as the "fmt" and the
trace_check_printk() was expecting the TP_printk() format to be the format
passed in. Which is the default case. The bug only happens when we clear
the hash-ptr option (which is on by default).

It should say:

 Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers for trace events")

-- Steve


