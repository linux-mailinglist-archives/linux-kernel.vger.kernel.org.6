Return-Path: <linux-kernel+bounces-292782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B684957451
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E51C23575
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B413E1D54C4;
	Mon, 19 Aug 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHd049/5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByLpgSbW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586474438B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095399; cv=none; b=mqyqEX1YHUJ06xNM/+Yey/GdOK8KYhvQu/rHYtbbgNNR54dzO/q70+Qq6uJ/m7WhyY/Aq3JmscZAjcXcz4VTZd+5P1a259hnr7DFL7VVV7aPpHa/I7rXhrUZQkyAky4A2NuN+th7XsGBOIC9hpp/hlQ0DwEsAbE38EGLD4QCHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095399; c=relaxed/simple;
	bh=W6WoE9R/tdk2wsQggdsp1NX6C01qnbzE7y5N3Z5FJIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTj4/yZwzVBV47cY2C8sVWHln+wu4g1aQqvposfWkD7C8HEcd36TIot/JjzGwUNfxjRItjdWxuMPtyeL/wHijwqONAROaVYfCh3eqSkBgclW1A9UMslqlrz0GauSXAr8a7Q/nex3xmlIJotK9Kk73pi/K9wYfOfaQdUnOhrVNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHd049/5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByLpgSbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724095395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ7Awp8jlfo+IRT/QjM/los97UHko8NLNXkxPXn2rYY=;
	b=tHd049/5cf8ggWsgnTWl9mNyLJc79tEfcmFjlNg8hjzHU1zMb85ZK1nAOyF0JktzUHz2IU
	dRO4zUnvpwPFQK6jNSv4/K+Qo6ixQ8zgGN2hVkBML4UOW54aQujnsxLkbfCDHXL3lfR8oT
	tANlPolwYwr3lEdauRQyo3iNkVRVH2L85oX5+yH9iu6XR1slO92Uzk3LqpvQ4Ve47T0klC
	xT8tTl6SnxPc1mFkclpHnCKeKR95UVkJL59bKvNWTRcl1zCGocuh07vXEgAJmlVmeXLyQp
	rDyZJda2QmhVUGUAMXyenYoBAXmstg99L3L9OhYxKfvSJ74rsAnLQ2/XlhSi7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724095395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ7Awp8jlfo+IRT/QjM/los97UHko8NLNXkxPXn2rYY=;
	b=ByLpgSbWqK9kFdsbcWR3GIS9N8k1XBpf0L0RQatoPi1tDe4DHo8UpgL+GvfdEU5Ck99z/a
	3nuAAmMgzVy5XbAQ==
To: Petr Mladek <pmladek@suse.com>, takakura@valinux.co.jp
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
 wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
 j.granados@samsung.com, stephen.s.brennan@oracle.com,
 linux-kernel@vger.kernel.org, nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v3 2/2] Handle flushing of CPU backtraces during panic
In-Reply-To: <ZrtjXChY_0wnFXsS@pathway.suse.cz>
References: <20240812072137.339644-1-takakura@valinux.co.jp>
 <20240812072931.339735-1-takakura@valinux.co.jp>
 <ZrtjXChY_0wnFXsS@pathway.suse.cz>
Date: Mon, 19 Aug 2024 21:29:14 +0206
Message-ID: <87y14sjp0d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-13, Petr Mladek <pmladek@suse.com> wrote:
> I would do something like:
>
> /**
>  * console_try_or_trigger_flush - try to flush consoles directly when
>  *	safe or the trigger deferred flush.
>  *
>  * Context: Any
>  */
> void console_try_or_trigger_flush(void)
> {
> 	if (!is_printk_legacy_deferred() && console_trylock())
> 		console_unlock();
> 	else
> 		defer_console_output();
> }
>
> and use it instead of printk_trigger_flush() in
> nmi_trigger_cpumask_backtrace().

Just to be clear, you are talking about removing printk_trigger_flush()
entirely and instead provide the new console_try_or_trigger_flush()?
Which then also involves updating the call sites:

lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace()
arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt()

> Well, I would postpone this patch after we finalize the patchset
> adding con->write_atomic() callback. This patch depends on it anyway
> via is_printk_legacy_deferred(). The patchset might also add
> other wrappers for flushing consoles and we have to choose some
> reasonable names.

I agree. Let's finish up the atomic series and then we can worry about
this.

John

