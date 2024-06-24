Return-Path: <linux-kernel+bounces-227262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB361914E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC16C1C20901
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537013D8A1;
	Mon, 24 Jun 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2zdx745";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqOxUKcl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB513B58C;
	Mon, 24 Jun 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235170; cv=none; b=t1d3MD+9vaBgymzkJYzC+e1L0hAC9pn89eqC8h17mGLfe8qgMkkbJlpw+//2m3JaUCuj62RYrkTDSR5vmBGXKAQFhTjGx+jsGtG4jFHENdJdJYug+rw1o0dm4X1oiHaR9AbvE6XhuzOzqL6S0Vciyek/V+vSnlERLWmL7WM4JvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235170; c=relaxed/simple;
	bh=Jo7FN8PZZfU3wYqvnE4Sde5fBlaTUIlJtITuXHbLVMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ph2ak+q/xdmb66o0/PM8AYajhZvNkvLURfYbKlXdMDhYrzUnwMPpHWfLq/QGJtrH4lnabvII8dyOaT1sdPYKQ5+E9DJEwUqw0y1TOc/F8mLK+/t052OCL6fD8p8nPM1YukcD28BRtOZPVnwoDAAeeRSLfHWiTjO1QDzV2oscGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2zdx745; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqOxUKcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719235164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN+LBb66eM8b0W3aoSlv/AXVA+hQdwSwIferK2dDOUE=;
	b=M2zdx745yT9xzMJKUkHwvgZIpZEQ7Ivblrav1JJmkg0WkEwwv3KFA5ujlyxicR/Ikn5IX6
	l1kTLKN/RxUErfxqds4tcpcOaLsgGAHC7yWsEKal0oL8SVPA4Jcnt15qHcaOpyinkZs9nP
	3vKHjxAUWf3BF6ve6jhCByt2/1A+dFn2GaCdeJV6UmJjMxR6N38DDR2IhR5ahdJfF5KOz+
	jr9EMx7sm3mLTg+EVmZFeZPE/K0J7NiwaCulXT5rshCC9ve4+P4Vw327kuw2I9ZM7mCOsD
	VqAOzX4Na5sRwzsQT27Vfe56ihSm/YHodjtiYrYDFd83T/4y6RFRi5vzBvIsog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719235164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN+LBb66eM8b0W3aoSlv/AXVA+hQdwSwIferK2dDOUE=;
	b=EqOxUKclsl840xyR1Zx+ZDj2r+Volbz8vJgiqTQJSEwAweHSWqHWHIZJp2Y00Zvk6xToLU
	1VuheovmJWWHefBg==
To: Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, x86@kernel.org,
 syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com,
 syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com,
 oe-lkp@lists.linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 syzkaller-bugs@googlegroups.com
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Uwe
 Kleine-Koenig <u.kleine-koenig@pengutronix.de>, gregkh@linuxfoundation.org,
 hpa@zytor.com, mingo@redhat.com, stern@rowland.harvard.edu, Alan Stern
 <stern@rowland.harvard.edu>, Matthias Stoeckl
 <matthias.stoeckl@secunet.com>
Subject: Re: Needed help: dummy_hcd: Fix stalls/inconsistent_lock_state due
 to hrtimer migration
In-Reply-To: <0eee9b08bf1f1889b3455099a68f9eed7f71c50e.camel@9elements.com>
References: <000000000000f8112e0618995e6e@google.com>
 <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>
 <0eee9b08bf1f1889b3455099a68f9eed7f71c50e.camel@9elements.com>
Date: Mon, 24 Jun 2024 15:19:23 +0200
Message-ID: <87y16u8omc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 24 2024 at 12:25, Marcello Sylvester Bauer wrote:
> I need some help evaluating and fixing a regression due to migration to
> hztimer scheduler in dummy_hcd.
>
> About two months ago I was investigating poor performance for the mass
> storage gadget (g_mass_storage) due to slow timings in the loopback hcd
> driver (dummy_hcd). One of the reasons was that dummy_hcd used the old
> timer API, where the interval is tied to the internal kernel timer
> frequency. So I submitted the patch to migrate to the hrtimer API[^1],
> which was quickly approved.
>
> Since then, syzbot[^2][^3] and intel's kernel test bot[^4] are
> detecting rcu stalls/inconsistent_lock_state due to my patch, and I'm
> trying to figure out how to fix it.
>
> Both bots indicate that the problem is around the usb_hcd_giveback_urb
> function call and it's locking mechanism. 
>
> My patch just replaces the timer API calls without changing anything
> else in the code, so I'm not sure if my patch is actually the root
> cause here. And following the instructions to reproduce syzbot
> regressions[^5] even with the provided assets (bzImage, disk image,
> repro.c) it is quite inconsistent to cause this stall. I have also
> tried to follow Alex Stern's advice, but have not been able to cause a
> stall manually.
>
> So I don't know what to do next. Can someone with more expertise in
> timers look into this?
> Any hints or help in investigating or fixing this regression would be
> greatly appreciated.

The main difference between the timer list timer and the hrtimer is that
the timer list timer callback runs in soft interrupt context, but the
hrtimer callback runs in hard interrupt context.

I really don't know whether it matters, but you can make the hrtimer
expire in soft interrupt context with HRTIMER_MODE_REL_SOFT instead of
HRTIMER_MODE_REL. If you have a reproducer then that should tell you
quickly.

Thanks,

        tglx



