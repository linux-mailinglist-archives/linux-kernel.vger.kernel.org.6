Return-Path: <linux-kernel+bounces-535136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF6A46F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064CE16D5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319C25DD10;
	Wed, 26 Feb 2025 23:27:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919302702A5;
	Wed, 26 Feb 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612450; cv=none; b=Uv527h16oaFJe1hN07rdOTQ7rCty56yF+4SOiJK+xAzCZQ47qkXOslCHJhZVm7vARaIVU19HtfOTOhGxxGkGaXejOuSEXvRt7HrTeukb6W3DM0k4vxohLePgbEINSW8vFcuQhVmndNSwgZGxfoOTZAXygJheWjMzqgN83n2EFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612450; c=relaxed/simple;
	bh=O7fkIbVRqnEDap4P4hV7eLRp89K93Tv8+ydQW8Z5c38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbteOrEqWzEn/XUTjqbfJMcu17+TX7ckrcY2n9OvFqVL3gHglLhVjw5H6ybrZfO7xKCw8qHPNlsjjssmc3sbfE5tHDgsWQTJWxVh53Ch6neoiZVfm00EKWngwa0IntfChcYGg/5T7iLaK6c6FEAnCnq1lF2vdgdhEzNd67lJZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E38CC4CED6;
	Wed, 26 Feb 2025 23:27:27 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:28:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Ventura
 Jack <venturajack85@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226182809.5027e483@gandalf.local.home>
In-Reply-To: <CAHk-=whvzK6ugXhCdrTfXnkFR+u_+sCtwz4aDODJ_h-RJ3kOKw@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	<CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	<ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	<CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	<20250226162655.65ba4b51@gandalf.local.home>
	<CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
	<20250226165619.64998576@gandalf.local.home>
	<20250226171321.714f3b75@gandalf.local.home>
	<CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
	<20250226173534.44b42190@gandalf.local.home>
	<CAHk-=whvzK6ugXhCdrTfXnkFR+u_+sCtwz4aDODJ_h-RJ3kOKw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:18:48 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 26 Feb 2025 at 14:34, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Correct, but if the variable had some other protection, like a lock held
> > when this function was called, it is fine to do and the compiler may
> > optimize it or not and still have the same result.  
> 
> Sure.
> 
> But locking isn't always there. And shouldn't always be there. Lots of
> lockless algorithms exist, and some of them are very simple indeed ("I
> set a flag, you read a flag, you get one or the other value")

Yes, for the case of:

	r = READ_ONCE(global);
	if (r > 1000)
		goto out;
	x = r;

As I've done that in my code without locks, as I just need a consistent
value not necessarily the "current" value.

I was talking for the case the code has (not the compiler creating):

	if (global > 1000)
		goto out;
	x = global;

Because without a lock or some other protection, that's likely a bug.

My point is that the compiler is free to turn that into:

	r = READ_ONCE(global);
	if (r > 1000)
		goto out;
	x = r;

and not change the expected result.

-- Steve


