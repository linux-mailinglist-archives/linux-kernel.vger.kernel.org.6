Return-Path: <linux-kernel+bounces-526125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2AA3FA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4FA880973
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F48214A97;
	Fri, 21 Feb 2025 15:59:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B271214814;
	Fri, 21 Feb 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153573; cv=none; b=EBEQMKUeiF1z07REGQ3Udt2Xl0XZ/iNJrJyqs8iqjbEE4dIAsdfz+wnNyKEL+0pEypKWLiE1TLgM2pfvaq9bXYhiTmRwOYqCNT98BpVbPMns0txCmG9mnngBHnqPLJiQ7gPmoFdTY5w3abvXtgpykbe9goWCJyQH44s6Jw6CIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153573; c=relaxed/simple;
	bh=1hlqcRC6YPxthZJkmFYUrMczitlkPHb6ZjAmnP94Iuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTVQBJs9bxDPCx3Wdxv8bxlJSfiTokX/FeFMkF1XZfiff/AoPcjJIT5QD4yvqWSsD5Of/yockZHgDs99XRKRh2UQM2GmVqHyqcg6ys7w9P8f3kN1xYlSHixK5ouyVysr35h7smInkpzkBYYYXEJGRpJS1SP1UwRilBxV5NyGUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777ECC4CEE2;
	Fri, 21 Feb 2025 15:59:31 +0000 (UTC)
Date: Fri, 21 Feb 2025 10:59:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
 <hch@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221105959.071b9504@gandalf.local.home>
In-Reply-To: <Z7hulnJ4fwslRILy@pollux>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<Z7bO1jT2onZFZwgH@infradead.org>
	<CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
	<Z7hulnJ4fwslRILy@pollux>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 13:16:22 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> However, I also want to clarify that I think that maintainers *do* have a veto
> when it comes to how the API they maintain is used in the kernel. For instance,
> when an API is abused for things it has not been designed for, which may hurt
> the kernel as a whole.

I believe that the maintainer should have the right to define what the API
is. And as long as users follow the use cases of the API, it should be
perfectly fine.

This isn't a user space API, where Linus has basically said if you expose
something to user space and user space starts using it in a way you didn't
expect, that's your problem.

But I hope that doesn't go with the kernel. To make things faster, I do
expose internals of the tracing in the header files. If someone starts
using those internals for things that they were not made for, I hope I have
the right as a maintainer to tell them they can't do that.

-- Steve

