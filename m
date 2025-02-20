Return-Path: <linux-kernel+bounces-524803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C8A3E749
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15267A9F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF582638A3;
	Thu, 20 Feb 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e502Hygu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA8192B86;
	Thu, 20 Feb 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089628; cv=none; b=ly9HJnbHTJdwtXGRCwmNrVLh6JVxT4DDng8hZ3DLoy8KH0ntmJPtOQPZrnbnceyYKpEQblFiMJFlA4yvPxmRkM4IKW2X6+qC5xFAcGvoSDKAl+yY2skIHXUHIU72Devte6ll32yMrJRv35fO8lGm0KeGeEk8rqA0mqJUzADgdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089628; c=relaxed/simple;
	bh=5WhmNKJKTY4MBUYOT58g2Lf8JSdI/kfRKK0anqa6xgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O91U/BzCiEpxISypNkML+Z19FWvbcSEYFN8eVT56DNIZ3mJZfBG7jljR7l9ToCR9OtUrHDoWIuBznCKpvlDPqbvnGCSGeSCl9TodTJFiNI7s4qbN5SunAFH1L7Q8nIcxADhadNcuPHoSrqaSqkT6uf+YKb32SawK0owStWPZCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e502Hygu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA6C4CED1;
	Thu, 20 Feb 2025 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089627;
	bh=5WhmNKJKTY4MBUYOT58g2Lf8JSdI/kfRKK0anqa6xgo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e502HygumUm3AXJ4Vb5H84hDcZWfNQfl+7GAaEUoXgyGHAqCreme0ZmyXIZZYQlzx
	 JVKnUM3zK8aeddcY/3EyHfPe7slPuki0NvpBLLRrRngVqDUXV9/fdNUnQQsZO1hN/o
	 G4KUFnN0+zdKt+OGxL35zYr6MprePwGgsfULVsmGtDvejUtt2OwrOcLh0vC0ZUav/F
	 DgyGnOBPUUerUyNDXmXhE7Qhdq1xrHTKeRXxNK7p4oYeuusnGiRxvVA4Eja9K8h1EC
	 Wkbav+UZtF+zZvIv3URLBvcurgqc/FUUGXiP2vFIJ4tUDTDdvSxCvqjeaZ8TrP+tlM
	 8gEFJBwFl6S9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 262CBCE0B34; Thu, 20 Feb 2025 14:13:47 -0800 (PST)
Date: Thu, 20 Feb 2025 14:13:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <d3aef9bf-f90e-4868-b96f-a7a42d04bbbf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021954-flaccid-pucker-f7d9@gregkh>

On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
> On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > [...]
> > > > > David Howells did a patch set in 2018 (I believe) to clean up the C code in the kernel so it could be compiled with either C or C++; the patchset wasn't particularly big and mostly mechanical in nature, something that would be impossible with Rust. Even without moving away from the common subset of C and C++ we would immediately gain things like type safe linkage.
> > > > 
> > > > That is great, but that does not give you memory safety and everyone
> > > > would still need to learn C++.
> > > 
> > > The point is that C++ is a superset of C, and we would use a subset of C++
> > > that is more "C+"-style. That is, most changes would occur in header files,
> > > especially early on. Since the kernel uses a *lot* of inlines and macros,
> > > the improvements would still affect most of the *existing* kernel code,
> > > something you simply can't do with Rust.
> > > 
> > 
> > I don't think that's the point of introducing a new language, the
> > problem we are trying to resolve is when writing a driver or some kernel
> > component, due to the complexity, memory safety issues (and other
> > issues) are likely to happen. So using a language providing type safety
> > can help that. Replacing inlines and macros with neat template tricks is
> > not the point, at least from what I can tell, inlines and macros are not
> > the main source of bugs (or are they any source of bugs in production?).
> > Maybe you have an example?
> 
> As someone who has seen almost EVERY kernel bugfix and security issue
> for the past 15+ years (well hopefully all of them end up in the stable
> trees, we do miss some at times when maintainers/developers forget to
> mark them as bugfixes), and who sees EVERY kernel CVE issued, I think I
> can speak on this topic.
> 
> The majority of bugs (quantity, not quality/severity) we have are due to
> the stupid little corner cases in C that are totally gone in Rust.
> Things like simple overwrites of memory (not that rust can catch all of
> these by far), error path cleanups, forgetting to check error values,
> and use-after-free mistakes.  That's why I'm wanting to see Rust get
> into the kernel, these types of issues just go away, allowing developers
> and maintainers more time to focus on the REAL bugs that happen (i.e.
> logic issues, race conditions, etc.)
> 
> I'm all for moving our C codebase toward making these types of problems
> impossible to hit, the work that Kees and Gustavo and others are doing
> here is wonderful and totally needed, we have 30 million lines of C code
> that isn't going anywhere any year soon.  That's a worthy effort and is
> not going to stop and should not stop no matter what.
> 
> But for new code / drivers, writing them in rust where these types of
> bugs just can't happen (or happen much much less) is a win for all of
> us, why wouldn't we do this?  C++ isn't going to give us any of that any
> decade soon, and the C++ language committee issues seem to be pointing
> out that everyone better be abandoning that language as soon as possible
> if they wish to have any codebase that can be maintained for any length
> of time.

While not in any way pushing back on appropriate use of Rust in the Linux
kernel, it is only fair to note that the C++ folks have been working on
some safety proposals, perhaps most notably "contracts" and "profiles".
Not sure how well either would carry over to C, though.

							Thanx, Paul

