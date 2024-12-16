Return-Path: <linux-kernel+bounces-447951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD49F391D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72EC188723D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC62206F19;
	Mon, 16 Dec 2024 18:38:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506C43AA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374335; cv=none; b=rEB7Z8hcH113BU9RMnnx8LZ5OT5nZX9VCp87nEZJa1O01Ri7YsRqGC9nPE/XbqKgI0A0HYdyl2yzugSDgu9ZmbyduO3DrfdPI2PynjjpXiEncwpdkgXMA4BduCi32GevO2ikM2ZEojMRoK5e+dS4f/oNvj+Hlqjp4ZF2MZwLXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374335; c=relaxed/simple;
	bh=too/Fpdv59fiOFAXJ4ktr7/TnnQa/Xo5MyNCybQRvFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLxV4pjXt+5DV2rB/PzTus+iq42Fmf2NY8E0TBM9nuNt9GPDRR+hRZGtlpLuQooAfpT3ZI42o7enKd4c03vC+lLBirSXka6N48Jb1ZTixO6aSyLTuxqHTItoGzcZRuZETDlChyrK/DgYHX/fraU8r9q8/o3mW2HWIIKqKAIAp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FACC4CED0;
	Mon, 16 Dec 2024 18:38:53 +0000 (UTC)
Date: Mon, 16 Dec 2024 13:39:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241216133926.1662f2a4@gandalf.local.home>
In-Reply-To: <CAHk-=wi-7D-9Lp+bMGyw6nt7y-KBQj4-utWE=8nfLSbs4G-o7A@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
	<CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
	<20241215202404.06f7be8f@batman.local.home>
	<CAHk-=wi-7D-9Lp+bMGyw6nt7y-KBQj4-utWE=8nfLSbs4G-o7A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 09:59:35 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That said, honestly, looking at the resulting diff, I really think a
> lot of those %p users are mindless drivel in the first place, and I am
> not convinced that the real address is even wanted or needed. I think
> people have completely mindlessly added "print out address" without
> any actual reason for it.
> 
> I'm seeing things like just random usb_request pointers being printed
> out, and I'm not convinced that is ever really useful or a situation
> where a '%px' is *any* different from a plain '%p' (ie the main thing
> I suspect you can do with that value is just say "it's the same
> request", and the hashed value works just fine for that).
> 
> So I am not convinced that the original reason for the mindless
> (runtime) conversion of '%p' to '%px' was really even well-motivated.
> I think it was a bad idea, and implemented badly.
> 
> End result: instead of doing that automated sed-script (which is
> certainly easy, but noisy), I actually think it might be much better
> to just remove the runtime '%p' -> '%px' conversion entirely, and see
> if anybody even notices - and then when somebody has a good reason for
> actually caring about a random kernel data structure address, change
> it at *THAT* point.

Masami was the one that implemented this for debugging reasons.

Masami, what was the motivation behind using %px? I know you needed that to
debug crashes to compare some event pointers with where they exist in the
crash dump.

But perhaps for those events that you used for crashes, we can just change
the TP_printk() over to use "%px" and remove the full conversion of all
events that you have.

Thoughts?

-- Steve

