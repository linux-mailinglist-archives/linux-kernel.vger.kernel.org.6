Return-Path: <linux-kernel+bounces-229688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592599172CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F94285D43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A817F390;
	Tue, 25 Jun 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ue1e8mTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MInE0JmQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BC17F38D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348818; cv=none; b=fvmjyjE0DelKaifEFIK4VWmzCpqio6fk4jAzHRibifyd0PxpOqe1YzKgcFeOxK/ocxceELGUATzYhqbc0lEiuIN6NKJxN96KxoTQzapuC7VHTsVi7U+ZnqdO4RMZhSunswLGvq5bkwzXBSAYpre/h4jXo/WpVJb1QU9buBrwBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348818; c=relaxed/simple;
	bh=IA+8Ubq8tQ1H71S7Wyod19mMfYg+EnachGBTUC6PneM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXx0u12RT9wE19iXCWgyFaz1OKsoaiAWecvSotwrPoEldHkriJuAk2MWLLVGi8j0wmkmLeVmH6OzWaGZ/gQObtR5f5FULeb1409jpZ2MmP5s+n/kolO7ZA+dqLOX3//IICfHj/P7mQlQSoCEWVph+XG68GGDBTT6gvtAIFrYOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ue1e8mTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MInE0JmQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719348815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iATZO/xTur8zZ6Io4R95fUE6HyNP5Gfo4QNHzZ9qfDA=;
	b=Ue1e8mTXT1e0vusDRb+V066eAbelalVZLLw4F88nKJOWGqPK6/gyyrRxaXxVauz1zzXr3M
	lb0fqBXAEQY3A3XI/azgFPry7+w8CG6gWM/nS32p7OCSRCuKeqRdQQzNSoouYwBymShi0t
	GDvcLN4C9A8r0EkHft+3g2E4SC/F+sXi5laM0B2yL3Ac0/rm0zdKE5tUjEhpk5e/GCWOwo
	sLBPhj3AYh9THlMbUeO6kqPCVqn7SqPr0whU6Hy4Ujqsb2H4Xy6UpE2fy+cOLyZ+XUCL5V
	U4lqFLgkzfJdVq70DcpbTcWSsyMselPThN/LkSkhAwwp0MOWWGOOM8sZUvQw5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719348815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iATZO/xTur8zZ6Io4R95fUE6HyNP5Gfo4QNHzZ9qfDA=;
	b=MInE0JmQ9E9njT4p4vIXHKmCzBmtA4P3EyG9JV7kuyH57wrMRRLv+4e0rMlQTckezMejQP
	8I71HrZ1ElR1rRAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: nbcon_atomic_flush_pending() is safe only when
 there is no boot console
In-Reply-To: <ZmrrhCf5GRUdGwh9@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
 <ZmrpxWxUb8k4swrA@pathway.suse.cz> <ZmrrhCf5GRUdGwh9@pathway.suse.cz>
Date: Tue, 25 Jun 2024 22:59:34 +0206
Message-ID: <8734p0yca9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-13, Petr Mladek <pmladek@suse.com> wrote:
> Boot consoles are not serialized with the nbcon consoles via the nbcon
> console context or con->device_lock(). The serialization is possible only
> via the legacy console_lock().
>
> The decision whether nbcon_atomic_flush_pending() should and can be
> called safely is similar and closely related to the decision
> whether the legacy loop should be used.
>
> Define printing_via_context_safe symmetrically with printing_via_unlock.
> Allow to call nbcon_atomic_flush_pending() only when it is needed and safe.

This patch, along with other comments you made about the many different
checks to see when it is allowed to do what, forced me to take a step
back and look at the big picture. Indeed, by the end of this series we
have many boolean variables that influence decisions about how to handle
threads and how to print.

I am thinking it makes more sense to incorporate these booleans into a
single variable (printk_state?). The variable would only be changed
under the console_list_lock, which could allow lockless users to
leverage the console_srcu_read_lock for consistency.

The different orthogonal bits of the variable would be:


* have_boot_console - true if a boot console is registered

* have_legacy_console - true if a non-nbcon console is registered

* have_nbcon_console - true if an nbcon console is registered

* printk_threads_allowed - true when it is OK to have threads
  (set/cleared by notifiers, and more or less represents
  "system_state == SYSTEM_SCHEDULING || system_state == SYSTEM_RUNNING")

* printk_threads_available - true while all printing threads are running
  (and implies at least 1 thread is running)


We could provide macros to interpret this multi-flag value for various
scenarios:

#define nbcon_may_create_threads()
  (printk_threads_allowed)

#define nbcon_may_rely_on_threads()
  (have_nbcon_console && !have_boot_console && printk_threads_available)

#define nbcon_may_flush_atomic()
  (have_nbcon_console && !have_boot_console)

#define nbcon_must_flush_atomic()
  (have_nbcon_console && !have_boot_console && !printk_threads_available)

#define nbcon_must_flush_via_unlock()
  (have_nbcon_console && have_boot_console)

#define printing_via_unlock()
  (have_legacy_console || have_boot_console)

Of course, the exact naming of these macros gives us a big shed to
paint. But I think this could help to simplify/unify the checks for the
various scenarios.

John Ogness

