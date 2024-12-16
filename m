Return-Path: <linux-kernel+bounces-446661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0AC9F27B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C699C18864C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED756F9DD;
	Mon, 16 Dec 2024 01:09:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A7E56A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734311390; cv=none; b=AuMSCYdarutIOQFEOYpn3Y3RkwNJJVRIcgYORY3B6HkUBoFjtdsBFkJ2r6geHcQBGOqERCTiQPxIYnuknn+gN24cCXbM8YdtwOszjokF/mGBEj41Yj1Pwv4svBRKrKiqBVKzwrbe5GGY0aX4F0onvjkZ1NJPVRjUcrBnQAQszfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734311390; c=relaxed/simple;
	bh=AI3KSgaav8QYd0mzA+A+8meEjDh2HtmAXZ/qd8sM5Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYL2MQtTT5PUFkdYsQw8gc16WKD4MQX3aPTJ4Ic6Ecr104N1D2JYmxhgnVTGUy37/ZDTsjqDy6SHNGrEw6jLg+GhPCczT5grxjNvMsCAiHdqykSsE+JnClC2ekn1aqSJksalQ5G3lUXyfZvxGKfbErEDTe69JBAxIMKE+ELWVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E634EC4CED4;
	Mon, 16 Dec 2024 01:09:48 +0000 (UTC)
Date: Sun, 15 Dec 2024 20:09:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, Michal
 Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215200950.5cb5c3d9@batman.local.home>
In-Reply-To: <20241215214034.GE2472262@mit.edu>
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
	<20241215214034.GE2472262@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[
  I'm back from a lovely day with my wife and friends visiting the
  Finger Lake wineries which I would love to share with the Linux
  Plumbers attendees if we ever get to have Plumbers at the Ithaca
  Conference center. ;-)
]

On Sun, 15 Dec 2024 16:40:34 -0500
"Theodore Ts'o" <tytso@mit.edu> wrote:

> I'm not convinced that it's worth it in this particular case, so I
> think I side with Linus here; maybe all of this hackery isn't worth
> it?  Steven, what am I missing?  Why did we go down this particular
> path in the first place?  I assume there must have been something that
> seemed like a good reason at the time?

It has nothing to do with performance. It has only to do with debugging
and catching the issue where developers use "%s" in the TP_printk() of
TRACE_EVENT() for a string that can be freed after the trace event was
executed but before it is read from the ring buffer.

I stated in another email that I didn't like this solution when I wrote
it, but it was the only solution I could think of to catch this common
bug. But I also stated in another email that I think there's another
solution that doesn't deal with va_list implementations and should be
acceptable by Linus.

I'm not against ripping out the code. I agree with Linus that it's a
hack, but the hack that caught the bugs early seemed to me worth it at
the time.

-- Steve

