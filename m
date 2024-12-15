Return-Path: <linux-kernel+bounces-446266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA19F2203
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AF3163CA2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74B8F5C;
	Sun, 15 Dec 2024 03:11:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE279F6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734232304; cv=none; b=euVXg3WDlYg5Wwws2DuhjBGG0h5RnJnHEqyMlKpFjf9Q9NMtJwBVpW4fM7p9GP8emuBt4jlWJ/LUcXMG5UKVSG5FCz/iXPKD0b4x0t0q6TlcWZVRKpZ4Sst/81x27HyujnATPujRNF5K8BJPNKKAOAfu2+4USMDMf1jZfjvmOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734232304; c=relaxed/simple;
	bh=4gu1MuWZDq4FUbv+DOzfx+xfBuPONuAZqE8YTZgyqwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1D9ZgoIvyBE04AbkKe6E+tR9y2PC1cRkazrLzMQPWoX5XaCdXHviK+NgHXRqkz0Iktsk0Y0ue39hKg2ountvKSd5synJk6Pb0D+tf6jDdcadzA7qJJlIszXwAfBWXdEf4aJjdUjRPSugQUTWv3elyv59QCXV2LFsJPgIZR0tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85998C4CECE;
	Sun, 15 Dec 2024 03:11:43 +0000 (UTC)
Date: Sat, 14 Dec 2024 22:12:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214221212.38cc22c3@gandalf.local.home>
In-Reply-To: <20241214220403.03a8f5d0@gandalf.local.home>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 22:04:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> With the check, instead it doesn't crash the kernel, but issues a nasty
> WARN_ON() (as it is a bug in the kernel) and then reads the value using
> safe mechanisms and injects into the trace "[UNSAFE-MEMORY]" by the pointer.

I will also point out that the check triggers even if the pointer is still
around (hasn't been freed). That is, it makes sure that the contents of the
pointer is in the ring buffer event that is being printed, or if a %s, it
is also OK to point to static strings (as the RCU trace points all do that).

That is, even though:

  TP_fast_assign(
      __entry->ipv6 = ptr_to_ipv6;
  )

  TP_printk("ipv6=%pI6", __entry->ipv6)

is buggy, and the check will report it immediately even if the contents of
that ptr_to_ipv6 hasn't been freed yet. But it is perfectly fine with:

  TP_fast_assign(
      memcpy(__entry->ipv6, ptr_to_ipv6, 16);
  )

  TP_printk("ipv6=%pI6", &__entry->ipv6)

As the content of the ipv6 lives in the ring buffer itself and will not be
freed at the time the event is printed.

-- Steve

