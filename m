Return-Path: <linux-kernel+bounces-168521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF68BB983
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78ABEB22D36
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CC4A1C;
	Sat,  4 May 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJfO5Z6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA628EA
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714799321; cv=none; b=I2Gzj28hhS9LyhSaXQp3dG8hQn8XXT/o5YQVR5ANp46/fgGvUCL8Cdb10SANMkLPajMlA/wbp1RXmSoDJ62ttvOzbzBwyE5zYKeaVYRW8Xkk2fgXpr0K+1UDm9xm0VTwlVmb9FzIUtp6AsNG0ZxGA0CyeUgkJs49yWY2orLy39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714799321; c=relaxed/simple;
	bh=fYhGMy9BM+AuBO9/QTYR9umpxdJ7Anyl3osEtMYAJ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF0nqBZfRu8DtadlrN+Nr9YQSAjpb2gqB0VYx+A9wrB9fNlNfa+SSo6gx6IMMH6Vn7vi9vuDsqk5qUbzYaZxYkVB/0CzVRrnSoikGoOPQrMfrEl6tRDWRja67WUZayJbFeEbnALjAi0X9BaOSSdKKpqj6U615PjP5DeDJHTxPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJfO5Z6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DFAC072AA;
	Sat,  4 May 2024 05:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714799321;
	bh=fYhGMy9BM+AuBO9/QTYR9umpxdJ7Anyl3osEtMYAJ5I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PJfO5Z6TA0rEg/ckgHHi/JarXqfuecNTvQ4GzuuWfSGsvYVIi7n4n58g9Co3wbLbl
	 EpEcQad3w8811E1aR3L2DokgyZ/oiOB6OVSoWg6WP5u25AEkEVy/w/P7sQ5cyKbEOk
	 Z5cg47nai0JxCg87tZbFLqtYnsOGAT1DCn3TqTwMwMk7BMWQMIQVwaRkvzfFAYKVYd
	 aVxggQRSWRM3xycGzKb0AOYhYd6dqqUxD9RnvJ8Jg4Od8hEW8BwIM5CivIqC8cquW1
	 JmdVwunnH1Em2/NrAmm8yxXbDh+YSPlDPlVGddRcS5Gkkc/KoHp1+L8viGTaNPSxoR
	 5hDP/51moAlpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8CD4CE0DEA; Fri,  3 May 2024 22:08:40 -0700 (PDT)
Date: Fri, 3 May 2024 22:08:40 -0700
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
Message-ID: <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux>
 <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>

On Fri, May 03, 2024 at 05:14:22PM -0700, Linus Torvalds wrote:
> On Fri, 3 May 2024 at 16:59, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hmmm...  Maybe something like this very lightly tested patch?
> 
> I'm a bit nervous about using the built-in atomics, when it's not
> clear what the compiler will do on various architectures.
> 
> Gcc documentation talks about __atomic_is_lock_free(), which makes me
> think that on various architectures it might end up doing some "fall
> back to helper functions" cases (possibly for odd architectures).

Right now, both GCC and Clang complain if you give __atomic_load_n()
something other than a pointer or a sufficiently small scalar on x86.

Let's see, starting with READ_ONCE()...

ARM7-a Clang complains about even single bytes (ARM7-a GCC is
fine).

ARMv8 works like x86 for both GCC and Clang, 

AVR GCC and M68K Clang generate calls to helper functions, so they
need to implement {READ,WRITE}_ONCE_MERGEABLE() in terms of the
current {READ,WRITE}_ONCE() macros.

M68K GCC works like x86, but generates a call to a helper function
for an 8-byte load.  Which means that the 8-byte case needs to
generate a build error.

Hexagon Clang works like x86.

Loongarch GCC works like x86.  Ditto S390, sh, and xtensa GCC.

MIPS Clang works like x86, but throws a build error for long long,
which might be OK given 32-bit.  MIPS GCC handles long long also.

MIPS64 and MIPS EL GCC and Clang work like x86, as do both compilers
for POWERPC and POWERPC LE.  And for RISC-V 32 and 64 bit.

I based these on this godbolt:  https://godbolt.org/z/rrKnnE8nb
The #ifs on lines select the 8-byte and structure case, respectively,
and you can pick your compiler.  I just used the latest versions
of each compiler for each architecture, so there might well be
a few more surprises.

> IOW: I don't think the patch is wrong, but I do think we need to
> verify that all compilers we support generate the obvious code for
> this, and we don't have some "fall back to function calls".

You are right, this is going to need some arch-specific code for a few
of the architectures.  Hey, I was hoping!!!

The compilers do not currently optimize these things, but things appear
to me to be heading in that direction.

						Thanx, Paul

