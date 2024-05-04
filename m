Return-Path: <linux-kernel+bounces-168779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C558BBD93
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0151C20F16
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8171747;
	Sat,  4 May 2024 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNT9yiUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F35FB9A
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714846725; cv=none; b=N/sOEGyMfUM9sqZsceUU4XxOteQohVvkbe0bWnt0ePyVujJwPy7sy7MGe60f29CUwTGlFePSW9ynJSDh/sZiPZ4LDQGoiQHAHJmp1gOTKHNqi+Zv+K7yqMU6G3AL4O1qeLgMY4DMwsd5CnrHqk6LGP4dpn0NnadMSNvNvoxtdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714846725; c=relaxed/simple;
	bh=ZZwtGJIgqjmUgNmfD8u3kEp9oydtVn0LPqjsXEarNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz0Ug7hYfBNm+8PP27G3fMT4e0w+YuMIelb5T0IVRfN5ZQG4Mk7mjDeuw06GphV+VmcpGJ++QHE16B7fbsx9sUPQR2EHUCjQGEf7/HeKCaul4g/KuNyeMOpy5rnf/xgEHqcvKCzGEx9mjOqCQZwRR1oTrrkp8q7XVWRGOCoyb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNT9yiUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726A9C072AA;
	Sat,  4 May 2024 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714846724;
	bh=ZZwtGJIgqjmUgNmfD8u3kEp9oydtVn0LPqjsXEarNXg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VNT9yiUNCAqaXsyaa2D4OrJyJcYrE6NJDoWeT0AzdV3Bid7BCa8dM98IOSGN00XJY
	 9n5huuFRPJ6Yx1Sh87ysrVRy27y0a5mTHuAba6XDZKcgJiD0vaoC67d98FM4MEyUZs
	 7RwG+S5GqYlObOkEbQ6hJEbV64EXkXemVQjHi8rQm63Jaltvi6SuGTZfNF55Qsn7+p
	 RoHEOSoJMoEubAizhM6CN4LGeLSvODN4g6UwHV05kx/dPq+c7+eKzPcFHqdI4vUT3J
	 x2HQrlz8H+dCaGCcBzaHAOqaR2nhnZTR2MLouAAdRT2+owtY8bEirSY3rHUokrD1Eo
	 X1yVyJ2Qz4N8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 077C3CE0F69; Sat,  4 May 2024 11:18:44 -0700 (PDT)
Date: Sat, 4 May 2024 11:18:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux>
 <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
 <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
 <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>

On Sat, May 04, 2024 at 10:50:29AM -0700, Linus Torvalds wrote:
> On Fri, 3 May 2024 at 22:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > You are right, this is going to need some arch-specific code for a few
> > of the architectures.  Hey, I was hoping!!!
> >
> > The compilers do not currently optimize these things, but things appear
> > to me to be heading in that direction.
> 
> Ok, so it sounds like right now it makes no sense - presumably
> __atomic_load_n() doesn't actually generate better code than
> READ_ONCE() does as-is, and we have the issue with having to make it
> per-architecture anyway.
> 
> But maybe in a couple of years we can revisit this when / if it
> actually generates better code and is more widely applicable.

Completely agreed.

Here is my current thoughts for possible optimizations of non-volatile
memory_order_relaxed atomics:

o	Loads from the same variable that can legitimately be
	reordered to be adjacent to one another can be fused
	into a single load.

o	Stores to the same variable that can legitimately be
	reordered to be adjacent to one another can be replaced
	by the last store in the series.

o	Loads and stores may not be invented.

o	The only way that a computation based on the value from
	a given load can instead use some other load is if the
	two loads are fused into a single load.

Anything that I am missing?

							Thanx, Paul

