Return-Path: <linux-kernel+bounces-520909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34890A3B0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B17173BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1E1B85D3;
	Wed, 19 Feb 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNbcKA7s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF61B6CF5;
	Wed, 19 Feb 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943554; cv=none; b=J40dKHIV/LPqlNRyg06B36qQA6Jcif9Jh5p0GqkillNHZp13cHhe6LIZROa4fyg7qz0djY3EFTrNHO9H3IBCud4XHpOjTOiPEoavNkLn8kVxjIeUz5g4k73Z5/EhT9qiFNwHmFcKinkEejG+V0N1rm7DxJpY1HrTWyCLUKwwtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943554; c=relaxed/simple;
	bh=oKbdu5vxvrH/+KgQ9L3W4XVVFt99O7X/wIVK3KrLAGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmoNqwFuWGjgLUKHKsBUmeflZ2jy9W8hIT7w3+pvCG8OOYCyftQ4gSi9xpd8X+h32gMc+fUP6IDUP0YcMIZ+TbRv3EKprVwmwbZTIuAszvZ8+CpYb7zCFMV8Xi8By9oBY07eEQ93LEgaRMiSo0FnDm5fdbUz9b7+EhPo9b9XbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gNbcKA7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8595CC4CED1;
	Wed, 19 Feb 2025 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739943553;
	bh=oKbdu5vxvrH/+KgQ9L3W4XVVFt99O7X/wIVK3KrLAGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNbcKA7s/VvC6/xgEwpnwnWIuzUzqFuPUXwfMk2xYhsG6mUQINRicdWA2hJoptEQR
	 ddFyY7xCcUfUDPtT90ZxB1znK+iIVM/ZgFSURS72GtW9bLATp23ha/jOEvU/vWV2vV
	 4r6dRuEPct6WAfqn+ToyhH8uzkXAD2VNNI6jqWWY=
Date: Wed, 19 Feb 2025 06:39:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2025021954-flaccid-pucker-f7d9@gregkh>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7VKW3eul-kGaIT2@Mac.home>

On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> [...]
> > > > David Howells did a patch set in 2018 (I believe) to clean up the C code in the kernel so it could be compiled with either C or C++; the patchset wasn't particularly big and mostly mechanical in nature, something that would be impossible with Rust. Even without moving away from the common subset of C and C++ we would immediately gain things like type safe linkage.
> > > 
> > > That is great, but that does not give you memory safety and everyone
> > > would still need to learn C++.
> > 
> > The point is that C++ is a superset of C, and we would use a subset of C++
> > that is more "C+"-style. That is, most changes would occur in header files,
> > especially early on. Since the kernel uses a *lot* of inlines and macros,
> > the improvements would still affect most of the *existing* kernel code,
> > something you simply can't do with Rust.
> > 
> 
> I don't think that's the point of introducing a new language, the
> problem we are trying to resolve is when writing a driver or some kernel
> component, due to the complexity, memory safety issues (and other
> issues) are likely to happen. So using a language providing type safety
> can help that. Replacing inlines and macros with neat template tricks is
> not the point, at least from what I can tell, inlines and macros are not
> the main source of bugs (or are they any source of bugs in production?).
> Maybe you have an example?

As someone who has seen almost EVERY kernel bugfix and security issue
for the past 15+ years (well hopefully all of them end up in the stable
trees, we do miss some at times when maintainers/developers forget to
mark them as bugfixes), and who sees EVERY kernel CVE issued, I think I
can speak on this topic.

The majority of bugs (quantity, not quality/severity) we have are due to
the stupid little corner cases in C that are totally gone in Rust.
Things like simple overwrites of memory (not that rust can catch all of
these by far), error path cleanups, forgetting to check error values,
and use-after-free mistakes.  That's why I'm wanting to see Rust get
into the kernel, these types of issues just go away, allowing developers
and maintainers more time to focus on the REAL bugs that happen (i.e.
logic issues, race conditions, etc.)

I'm all for moving our C codebase toward making these types of problems
impossible to hit, the work that Kees and Gustavo and others are doing
here is wonderful and totally needed, we have 30 million lines of C code
that isn't going anywhere any year soon.  That's a worthy effort and is
not going to stop and should not stop no matter what.

But for new code / drivers, writing them in rust where these types of
bugs just can't happen (or happen much much less) is a win for all of
us, why wouldn't we do this?  C++ isn't going to give us any of that any
decade soon, and the C++ language committee issues seem to be pointing
out that everyone better be abandoning that language as soon as possible
if they wish to have any codebase that can be maintained for any length
of time.

Rust also gives us the ability to define our in-kernel apis in ways that
make them almost impossible to get wrong when using them.  We have way
too many difficult/tricky apis that require way too much maintainer
review just to "ensure that you got this right" that is a combination of
both how our apis have evolved over the years (how many different ways
can you use a 'struct cdev' in a safe way?) and how C doesn't allow us
to express apis in a way that makes them easier/safer to use.  Forcing
us maintainers of these apis to rethink them is a GOOD thing, as it is
causing us to clean them up for EVERYONE, C users included already,
making Linux better overall.

And yes, the Rust bindings look like magic to me in places, someone with
very little Rust experience, but I'm willing to learn and work with the
developers who have stepped up to help out here.  To not want to learn
and change based on new evidence (see my point about reading every
kernel bug we have.)

Rust isn't a "silver bullet" that will solve all of our problems, but it
sure will help in a huge number of places, so for new stuff going
forward, why wouldn't we want that?

Linux is a tool that everyone else uses to solve their problems, and
here we have developers that are saying "hey, our problem is that we
want to write code for our hardware that just can't have all of these
types of bugs automatically".

Why would we ignore that?

Yes, I understand our overworked maintainer problem (being one of these
people myself), but here we have people actually doing the work!

Yes, mixed language codebases are rough, and hard to maintain, but we
are kernel developers dammit, we've been maintaining and strengthening
Linux for longer than anyone ever thought was going to be possible.
We've turned our development model into a well-oiled engineering marvel
creating something that no one else has ever been able to accomplish.
Adding another language really shouldn't be a problem, we've handled
much worse things in the past and we shouldn't give up now on wanting to
ensure that our project succeeds for the next 20+ years.  We've got to
keep pushing forward when confronted with new good ideas, and embrace
the people offering to join us in actually doing the work to help make
sure that we all succeed together.

thanks,

greg k-h

