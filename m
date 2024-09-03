Return-Path: <linux-kernel+bounces-313105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD596A058
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3028285D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66913D530;
	Tue,  3 Sep 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzrGD4Ae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMKb5UXR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3F78C60
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373501; cv=none; b=SG/s2KWpbr4I/A88l7dXkbWLBkGD9H7nwor0NkKBnQQ40CKRvY3x4kbGaesrsEhaNahTM30plNgMou8bDG+PKPX9tOJ57QKb6xsuIOuy45nOp8xIdSaTr3McRFwrg3p64MMu8zxiiXl2wx3pch+kswVVyTFhrV0lowQdkQ+rk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373501; c=relaxed/simple;
	bh=Ux5Du97AxSg5cCnUVFRG69fPFca+6Lsy6eT4h2FYd/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALLMzQmgSVTPws+A/QsMBLJmC4qL+ZxRspXFORBeS+4/bmjYedXCH4FuJ69Nx6gKzOK2qouk6GQxjvxeh951YH7Izso4EYPBrOv2q+gIJji4I+aZX7w/Jnl8t3qJL8GfKpOHKrZyp2/CDTijWi/wGvjjgYZ0l9Z1mISR1UkHkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzrGD4Ae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMKb5UXR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725373498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zL9Ag0sgGMvI3K+P301EW3cTcgRJ7pGmcu/kNGaq94=;
	b=VzrGD4Ae8n8Q33TN45PbV6zIlg2xP4+rfXnv0F9vuH9i2P6KPv2vQaqDzkyvahJhdcfEla
	+RUr1yfNxdA18nN7SNe0OOXPvtMcgvzQlkMwLy3URkGpQ6q3gykh5bUQWtFQ74wCHbHFhX
	p3kkj5LEQKEkLOm7QgrSSsz+iruCId621+wJIjm1hB1bIMnmgMdkfv6lwPLRwbV2tIDmDC
	gOuaxrez/rqx2KqtKM6Bsn0QdlCf3FPE7uFH/5GTT9AW7zxOGEUjjkmNrzZilt48PyPg2C
	YQmZG75ZHEaiKGY7oZB2DkNC9wzenVcXXEDWMuqHVL5PGzDck0lYQnKmy0dp7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725373498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zL9Ag0sgGMvI3K+P301EW3cTcgRJ7pGmcu/kNGaq94=;
	b=bMKb5UXRr58j/O5vNod21m0rlAsQd/JK+67tZUrcfWme2Y47UmvCq88gSTXwTRJ7nkOUQw
	wQAu8k3WBwpPpYDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 15/17] printk: Implement legacy printer
 kthread for PREEMPT_RT
In-Reply-To: <ZtcRZpLjCjWeC4nG@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-16-john.ogness@linutronix.de>
 <ZtcRZpLjCjWeC4nG@pathway.suse.cz>
Date: Tue, 03 Sep 2024 16:30:57 +0206
Message-ID: <874j6wke6e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-03, Petr Mladek <pmladek@suse.com> wrote:
>> +static bool legacy_kthread_should_wakeup(void)
>> +{
>> +	struct console_flush_type ft;
>> +	struct console *con;
>> +	bool ret = false;
>> +	int cookie;
>> +
>> +	if (kthread_should_stop())
>> +		return true;
>> +
>> +	printk_get_console_flush_type(&ft);
>> +
>> +	cookie = console_srcu_read_lock();
>> +	for_each_console_srcu(con) {
>> +		short flags = console_srcu_read_flags(con);
>> +		u64 printk_seq;
>> +
>> +		/*
>> +		 * The legacy printer thread is only for legacy consoles when
>> +		 * the nbcon consoles have their printer threads.
>> +		 */
>> +		if ((flags & CON_NBCON) && ft.nbcon_offload)
>> +			continue;
>
> I am still scratching my head about the fact that the legacy loop
> probably should not handle the nbcon consoles also when
> printk_get_console_flush_type() returns ft.nbcon_atomic().

The legacy loop kthread should never handle nbcon consoles unless a boot
console is registered. So it really needs to be:

if ((flags & CON_NBCON) && (ft.nbcon_offload || ft.nbcon_atomic))

> We probably does not have to take care of it here because this
> code is called only when the legacy kthread is running.
> It means that nbcon consoles should have their kthreads as well
> when they can be handled outside the legacy loop. I mean
> that we should never see ft.nbcon_atomic set here.

Remember that the nbcon kthreads are stopped on shutdown/reboot. For
those final messages, ft.nbcon_atomic=1. The legacy loop kthread should
not handled those printings.

> Sigh, the logic is so complicated.

It takes some getting used to. But I feel like the responsibilities and
transitions are clearer now than ever before.

>> --- a/kernel/printk/printk_safe.c
>> +++ b/kernel/printk/printk_safe.c
>> @@ -44,7 +44,9 @@ bool is_printk_legacy_deferred(void)
>>  	 * The per-CPU variable @printk_context can be read safely in any
>>  	 * context. CPU migration is always disabled when set.
>>  	 */
>> -	return (this_cpu_read(printk_context) || in_nmi());
>> +	return (force_legacy_kthread() ||
>
> This is not correct when used in panic(). force_legacy_kthread()
> is not a reason for offload in that case.

If force_legacy_kthread() is true, legacy printing is _ALWAYS_ offloaded
except as a "hope and pray" last attempt via
console_flush_on_panic(). That is a requirement of PREEMPT_RT.

John

