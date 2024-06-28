Return-Path: <linux-kernel+bounces-233859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C93F91BE66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DE428451F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994915572B;
	Fri, 28 Jun 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdPcUVHT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEfSwj+Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6C1E898
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577378; cv=none; b=X7Ao07cLA+TfGIZUZZyEwsZ6ImkX1+6t2oyKQogN7I0JElHpQkYa8A4ftIaxTNqk7OCHgAWvO3z0Xh/Y76yN3UJHcU1a82OZmuTfkOKYz/LHIiqoF6Olqx1FWNvIW9uNKXiE4Py6c3tIiGztEvrdGx08DYQ9xlVcrnAObDEQxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577378; c=relaxed/simple;
	bh=cdJCwDpcnY1a8rtaKZM8HaM8wOIKR7tayEP39PrvcQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isz0Ra/0cQnOQDkY6FmjOjW9FEGIXU+caM2JyuvfC+2hZLOgi8MsDsvUUM98GfTxm5isKkcLShNwEDth7maioToyiz4TIpzYGjn/GdsoJm4aztVdlV/CXcgQ7yUhtXY9uTnu/H/32dqdSVBpBIfGXi5qrNB0iyZjIsNCnTWhjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdPcUVHT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEfSwj+Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719577368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29YEusRkRmx8HvZ1qIs0UY+0GdHgWaLCPM53YndXTqo=;
	b=TdPcUVHTKbTJRf/qElPS5VkdX0SR/s62PhdpKNH/Qod2HZASTpppZCbNKMPEiFw3k1A4S7
	O4U7K0eQGnzfEtQfs6nNPTv3evFv2r1QnZUaWkqP5kyO2QYhMA79lwwKBIH6T6mnQ9q6tw
	9c0zav6iIRQXwf3rBqB0QyPpgsPXqMzGfCpdZaDOGLM8EjjtCvovlcNCo9knFo8L4Yq9Ug
	YMhHezHCpy//7U1PKJu2ILXi9PG6BHFk9Hoh/+MX0Z14m3onBHMqB2sxfCr9ckZj3uWfao
	AOX92ybH5jZokg3Lei6Oe+9PVnlnv6JjMWvimCsiZJ7dGIESxJ1vCO9kfpKBpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719577368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29YEusRkRmx8HvZ1qIs0UY+0GdHgWaLCPM53YndXTqo=;
	b=NEfSwj+ZXXspY76ATNNiQW3jXr991vP9nCX0U/BC9sg76og2T1CY7GPJwX/NQf1AnJxs/L
	r1T4A9HBP/rgesDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
In-Reply-To: <Zn6iq3n2ggL138Gs@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
Date: Fri, 28 Jun 2024 14:28:47 +0206
Message-ID: <87cyo1xnmw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
>>  		 * to handle it.
>>  		 */
>>  		do_trigger_flush = true;
>> -		if (printing_via_unlock && !is_printk_deferred()) {
>> +		if (!force_printkthreads() &&
>
> Is this correct? We still need to flush the messages directly
> when the legacy kthread is not ready yet.

No! If force_printkthreads() is set, messages will never flush directly
except for console_flush_on_panic().

I see that I implemented get_init_console_seq() to flush since it is
known to be in task state. But that is wrong. Also there it should not
flush directly. It is not about whether or not printing is safe. It is
about deferring to the thread 100% of the time except for panic.

>> +void nbcon_legacy_kthread_create(void)
>> +{
>> +	struct task_struct *kt;
>> +
>> +	lockdep_assert_held(&console_mutex);
>> +
>> +	if (!force_printkthreads())
>> +		return;
>> +
>> +	if (!printk_threads_enabled || nbcon_legacy_kthread)
>> +		return;
>> +
>> +	kt = kthread_run(nbcon_legacy_kthread_func, NULL, "pr/legacy");
>> +	if (IS_ERR(kt)) {
>> +		pr_err("unable to start legacy printing thread\n");
>> +		return;
>
> Is this acceptable for RT, please?

It is not acceptable for mainline. For the next version, any failed
thread creation leads to unregistering the console. In the case of the
legacy thread, it will mean unregistering all legacy consoles on
failure.

John

