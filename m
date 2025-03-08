Return-Path: <linux-kernel+bounces-552454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68967A579F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C4F3AFB42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D61B0F26;
	Sat,  8 Mar 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="baDJzKrv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+SHjGHR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1258374F1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741432761; cv=none; b=fZaVEt9kcNWIjsMZm5FjvkRivi2ugC9GMXLaDzoLG5nO65pPVDiuomslI5YZvBJSHF/f4GmNWttT1OS+Sbvm/7X6TtuQRwH150D+uSz+dw/LqIWx/T2Bl/5OhsAZFJT+3FZOeoVNFB9ogrvVbunoA2aR2YIiq4mvWyG+RPFDwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741432761; c=relaxed/simple;
	bh=gU+UcvRVPrP3417Wwe96TRvmgJhmzMPHUdRgX3HUaho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQwxZpgFJJp0j/2XtNa8I7J+dGiAWgbbxg6KfL8jLXiQsydLNuIghswZRbtrxandJEdKMWwEDTJ6qa21PVtlHOepZgRztrP9Ed3SVL7/52OiBANmugzFyLNXQ9eQi+s7smzZgZr6ZU95a2/7FgusQYpSi7gIdOtv0hB5HBYlp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=baDJzKrv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+SHjGHR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741432757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wwe+Yut1DnOhJnZ/JWqRRJe9rO44j2r7LQI6F1jeF8=;
	b=baDJzKrvbi8MZyhdOsdplpGcFCulGwNDidt2zWWvMHhroOJXhhMOI7sbcbkLqoVF7PIspt
	ohk+mGYjhQ+PCu05XQ1tpHd3QSr3U8sv56zy7xPNAc8nYIb7FEKD6569JsQCclFRzdxmXW
	/lxoNhAtgaMkpvyXrF7xU4PH2B5oZMSntM8Ywb4y8M2CrmeVeJkb3rbonu8UirgJWqstwf
	TUyBJBLp17pXTBqQ54lyeNYVzSl4NLWFL9PtqPE0c20aW0Zay/kZ1KJFkfohH0D3xR5sqf
	3IGO0zNVjivWlv6Zd4gXMlUK65TSuwdb6+RL/LSagym0e0raOVqn0BY/wDkTEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741432757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wwe+Yut1DnOhJnZ/JWqRRJe9rO44j2r7LQI6F1jeF8=;
	b=S+SHjGHRVNAbrSn4vlAlcCUalTnsMY8HyobMiWlhT2I5n5TemkVs4VbcDHnRsN9JCiiNGh
	0F/hL3yx6XjdTzAg==
To: Dmitry Vyukov <dvyukov@google.com>, krisman@collabora.com,
 luto@kernel.org, peterz@infradead.org, keescook@chromium.org,
 gregory.price@memverge.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] syscall_user_dispatch: Allow allowed range
 wrap-around
In-Reply-To: <de940218d0a59fd930ec244d87f2375b16a7815a.1740386567.git.dvyukov@google.com>
References: <cover.1740386567.git.dvyukov@google.com>
 <de940218d0a59fd930ec244d87f2375b16a7815a.1740386567.git.dvyukov@google.com>
Date: Sat, 08 Mar 2025 12:19:17 +0100
Message-ID: <87y0xf3h3e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 09:45, Dmitry Vyukov wrote:
> There are two possible scenarios for syscall filtering:
>  - having a trusted/allowed range of PCs, and intercepting everything else
>  - or the opposite: a single untrusted/intercepted range and allowing
>    everything else
> The current implementation only allows the former use case due to
> allowed range wrap-around check. Allow the latter use case as well
> by removing the wrap-around check.
> The latter use case is relevant for any kind of sandboxing scenario,
> or monitoring behavior of a single library. If a program wants to
> intercept syscalls for PC range [START, END) then it needs to call:
> prctl(..., END, -(END-START), ...);
> which sets a wrap-around range that excludes everything
> besides [START, END).

That's not really intuitive and the implementation changes the prctl()
behaviour in a non backwards compatible way.

Can we please keep the current behaviour and have a new mode. Something
like:

 # define PR_SYS_DISPATCH_OFF            0
 # define PR_SYS_DISPATCH_ON             1
 # define PR_SYS_DISPATCH_EXCLUSIVE_ON   PR_SYS_DISPATCH_ON
 # define PR_SYS_DISPATCH_INCLUSIVE_ON   2

That keeps the current mode backwards compatible and avoids the oddity of

     prctl(..., END, -(END-START), ...);

i.e. this is clearly and obvious distinguishable for user space:

     prctl(..., PR_SYS_DISPATCH_EXCLUSIVE_ON, END, END - START, ...);
     prctl(..., PR_SYS_DISPATCH_INCLUSIVE_ON, END, END - START, ...);

Which makes a lot of sense because these two modes are distinctly
different, no?

PR_SYS_DISPATCH_INCLUSIVE_ON will fail on older kernels and both modes
have a sanity check. PR_SYS_DISPATCH_INCLUSIVE_ON should at least check
for a zero length dispatcher region.

Aside of the better user interface this avoids the in_compat_syscall()
hack. Because then set_syscall_user_dispatch() does the range inversion
and that works completely independent of compat.

> kernel/entry/syscall_user_dispatch.c | 9 +++------
> kernel/sys.c                         | 6 ++++++
> 2 files changed, 9 insertions(+), 6 deletions(-)

This clearly lacks an update of

     Documentation/admin-guide/syscall-user-dispatch.rst

Thanks,

        tglx

