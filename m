Return-Path: <linux-kernel+bounces-185366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E318CB409
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73831F23508
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8714901C;
	Tue, 21 May 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4AX6Tf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1SblpWy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AF142916
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318451; cv=none; b=lxqXiclB8uZnhX3PrXOUMVfAEyIiKBjSVRfPhzucsJjQC72RK5b+kHpiRZUMNZT97fXGOC/kHoGZk4idShZPnzUQai1HFuL1XnMoMp8NTZsimG4XYT/43CWHJ0sirrkVQJFIDPQyeFf7jz7enjtSR+cs16Xzi9/uI5muUTWxWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318451; c=relaxed/simple;
	bh=UV1GwPjRYKJek6MZ689XDfh23nHLwYeqapg2ckKYh4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7OBEbTCigrmPMwKDu1+6hV2OLeUhYITrahXDtygloj156O7s28uyiPp58Qwv3xGN9mxv555n7YAhl/t1PK9GnUpiqHb2Pf4DQC8vWT8D4F01dabcWO+1rSdOPvcnBXFZqMgug//ky2lRjzhDloB3KMJT9/DWGBTXu2jM+dtXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4AX6Tf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1SblpWy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716318441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppUtLbpu54U428XjsLiaEeb2s73JCEqX0+Mtd4NH/l4=;
	b=P4AX6Tf6BLCdrGmVzfVNnL/DZbUvT94AtZ1pnnkQm16sBcxjFh3wNoXsyAlUXnLkPxt8Wd
	VKLcpGmezk0/Gb8gmC+Xd7UwTLrbDZyadlR6ZoclMyCx5JiQ1T54BHh5zFCfsYwBlzNHE0
	QmRt0Yu2jbBOQlE3utCug9u7ZeSJAQDg5DKSwK2US/9FnGH2qiiROAK6X5IcT9BPCB5xqE
	ZDE/lVdoHQpW1O/HTsKlLpSdyAI371U2MRAF5wMeEP3uYVZ0z7CLWT7NcS9iqoHyKwGGY/
	tmrVVU+An2oYyL0PPNvpNcOnyzZQrcJ3RZbyg5VQ67VIg1dnKVUi0u3thCjFxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716318441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppUtLbpu54U428XjsLiaEeb2s73JCEqX0+Mtd4NH/l4=;
	b=c1SblpWybs74zN6Oz72KDKlAkV0vsDrQTMsk4T38lilQNpKnvyYRJFVWrk7FjkvndUoYpg
	00wT8M5ncyGfwJDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 19/30] printk: nbcon: Provide function to
 flush using write_atomic()
In-Reply-To: <ZktmhL2hos8-IrNb@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-20-john.ogness@linutronix.de>
 <ZktmhL2hos8-IrNb@pathway.suse.cz>
Date: Tue, 21 May 2024 21:13:09 +0206
Message-ID: <87seybdlwi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-20, Petr Mladek <pmladek@suse.com> wrote:
> What about reshufling the code a bit?
>
> <proposal>
  [...]
> </proposal>

Your proposal is fine and is easier to follow. Thanks.

>> +	/*
>> +	 * This context must flush any new records added while the console
>> +	 * was locked. The console_srcu_read_lock must be taken to ensure
>> +	 * the console is usable throughout flushing.
>> +	 */
>> +	cookie = console_srcu_read_lock();
>
> In principle, this should not be needed because the console is
> added/removed under con->device_lock() in
> register_console()/unregister_console().  And this function
> nbcon_driver_release() should be called under the same lock.

I added a comment here to make it clear why it is needed. It is about
making sure the console is _usable_ during the flushing, i.e. it
prevents console_suspend() and console_stop() from exiting while the
flush is in progress.

I will leave this as is for v6.

John

