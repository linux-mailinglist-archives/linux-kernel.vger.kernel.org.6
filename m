Return-Path: <linux-kernel+bounces-313641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0E96A807
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7D1B21579
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620019046D;
	Tue,  3 Sep 2024 20:06:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BF1DC725
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394014; cv=none; b=QiMgV15xN0vEA0qU8c90tKmE4rIcbPnYkQ26HvjR7e/vJMBkBwzbp5Sjn1DZ5M7+od436vWwtBELKiyvlnLVpmaUo8ybAZMmiKf8OZUDD/cLCjpbZPPpDf7/BcVmVNj6YwjlPhG6h8mUG8mY6Iz1MDElKoc+Dh4ZUJz5Z0Hcxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394014; c=relaxed/simple;
	bh=D0+c87Yqn2sBG0Jo+Q0gpZga3ZjfI9dOtX0Tfwuo7ME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTqnN7py3Ld+33xf2tH7tVTrmYpo1/I0gjTNsntyoTxoeCO4kvB4KxB274FsmR6Nf7uBctOXaCDC7/cWmQcE/eyoT7zrgU9EM1EATN0KJkiBq9DUUv4JVz/YuX6kP+urwUpulzM5h+Dm2OXaKCsjw/EtxvKZMgJvAub+lRb0mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C8C4CEC5;
	Tue,  3 Sep 2024 20:06:53 +0000 (UTC)
Date: Tue, 3 Sep 2024 16:07:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "Madhavan T. Venkataraman"
 <madvenka@linux.microsoft.com>, Kalesh Singh <kaleshsingh@google.com>,
 chenqiwu <qiwuchen55@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240903160751.702f1f91@gandalf.local.home>
In-Reply-To: <ZtCz2IiskUTVu6Xu@J2N7QTR9R3>
References: <20240618162342.28275-1-puranjay@kernel.org>
	<ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
	<20240619124318.GA3410@willie-the-truck>
	<20240624161741.2a16d904@gandalf.local.home>
	<ZtCz2IiskUTVu6Xu@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 18:54:01 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Steve,
> 
> On Mon, Jun 24, 2024 at 04:17:41PM -0400, Steven Rostedt wrote:
> > On Wed, 19 Jun 2024 13:43:18 +0100
> > Will Deacon <will@kernel.org> wrote:
> >   
> > > > Catalin, Will, do you have any preference?    
> > > 
> > > I think it makes most sense if this patch travels together with
> > > 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()"), so that
> > > would be via Steve's tree. In which case:  
> > 
> > That makes sense to me. I'll go around pulling in all the updates to the
> > arch code here (with the respective acks).  
> 
> Are you still planning to pick this up? On next-20240829 the ftrace
> tests blow up (as below) due to having the core ftrace change to
> ftrace_graph_ret_addr() but lacking the arm64 fix.
> 
> Splat on next-20240829:

Ah, I didn't check to see if it was sent to linux-trace-kernel, so it
wasn't in patchwork, hence I forgot :-p

I can add it this week.

-- Steve


> 
>   [2] Basic test for tracers
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 198 at arch/arm64/kernel/stacktrace.c:112 arch_stack_walk+0x1d0/0x350
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 198 Comm: ftracetest Not tainted 6.11.0-rc5-next-20240829 #1
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : arch_stack_walk+0x1d0/0x350
>   lr : arch_stack_walk+0x1c4/0x350
>   sp : ffff800080003e10
>   x29: ffff800080003e10 x28: ffff800080003fe0 x27: ffff800080003eb8
>   x26: ffff000003813600 x25: ffff800080004000 x24: ffff80008002ebd8
>   x23: ffff800080003ed8 x22: ffff800080023c78 x21: ffff80008002ebd8
>   x20: ffff800080003f40 x19: ffff800080003f30 x18: 0000000082000000
>   x17: 0000000000000000 x16: ffff800080000000 x15: 00003d0900000000
>   x14: 00000000000c3500 x13: 0000000000000000 x12: 0001f4e457e39c1c
>   x11: ffff800082f06ca8 x10: ffff800080003f30 x9 : ffff80008002ebd8
>   x8 : ffff800080003db8 x7 : 7fffffffffffffff x6 : 0000000006dd7418
>   x5 : 0000000000000023 x4 : ffff800080003e88 x3 : ffff800080003fe0
>   x2 : ffff80008002ebd8 x1 : 0000000000000000 x0 : ffff80008002ebd8
>   Call trace:
>    arch_stack_walk+0x1d0/0x350
>    return_address+0x40/0x80
>    trace_hardirqs_on+0x8c/0x190
>    handle_softirqs+0xf0/0x400
>   ---[ end trace 0000000000000000 ]---
> 
> Mark.


