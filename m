Return-Path: <linux-kernel+bounces-169680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7D8BCC27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DED1C21F81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A127142E6B;
	Mon,  6 May 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yG404n4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6dk+ZJ+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3F142913
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992005; cv=none; b=gTabGua/SMsa+o9OsTuPhI/Z5IBRWu+gT4On/1reNkAc0wJ2OHnuFsmiLVWTLQdcFJ1fLhxfiynD6yJTpvB5LwjdzIO0Y9jtXfHa5fKNGwpo4lr1k1i3GfijfffoqGr8bRLOCKiXRibMHRX7qPB6pvK6xKow41DjYrcbHkv+/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992005; c=relaxed/simple;
	bh=PFYRBJVdKIlX8jpIvhQMvmMNe5z4lNbr0aMG03AZ910=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cXclgFTUjbgO18gwlJI0qhcoeytVwtMXHGElhqwarz/26jL++AOjAX94/+p/ZFnslJQWPDK+yLmN4XPtPihel80IXBjr+uZ+QzpQFiAXTL/GLKqBBm+bnnMCtw326yhkVJFG5g4zWymoLRHYc73NZO7VTzaV4kFy7ugdPa5fCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yG404n4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6dk+ZJ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714992001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91zkeCbfa1jWnMFSvS20euLs2WEg/Lbwy7C8g7bXacM=;
	b=yG404n4S6ofPWh32VhwYTn2J/WwKJgFyzKVMHqiwSwGFLbWquwUpSAchHcfLqlJqx1tWoA
	bNswR0rra1ijLMquEv3WfMuLe8Lv64uSNt5gvOUrbLoRdsAVircpHqNGQJkmCaAeMypNcd
	v7o/NfK9PRSYfSaatDl7gD1R1Q5qj25kI49MM1gTbCaBwYF4KM4r1Y+2TlvbuxNCKiRcvc
	ds8Vkg5KyK0+kkZpm40p50uLv9Gz/wZoSlcVmO3XKinPhPlhxPzc8Sm684mIGFyoxVmMqF
	rv698NExKqE0WzZw3lYYQvuTyHHm36AkN028OSA6661v4o0QLTtBBQRl0WB1Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714992001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91zkeCbfa1jWnMFSvS20euLs2WEg/Lbwy7C8g7bXacM=;
	b=j6dk+ZJ+hJ4I2dpgtRTfKRXxjtVrpYPgvPgZCOwaLrKC8SSbOSFrGIIgIPDQ0ZMzH9wjyx
	wrIVz94/k6JYsrDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 26/30] printk: nbcon: Implement emergency
 sections
In-Reply-To: <20240502213839.376636-27-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-27-john.ogness@linutronix.de>
Date: Mon, 06 May 2024 12:45:59 +0206
Message-ID: <87h6fbi5q8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-02, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 8f6b3858ab27..991e2702915c 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> +void nbcon_cpu_emergency_exit(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +	bool do_trigger_flush = false;
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +
> +	/*
> +	 * Flush the messages before enabling preemtion to see them ASAP.
> +	 *
> +	 * Reduce the risk of potential softlockup by using the
> +	 * flush_pending() variant which ignores messages added later. It is
> +	 * called before decrementing the counter so that the printing context
> +	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
> +	 */
> +	if (*cpu_emergency_nesting == 1) {
> +		nbcon_atomic_flush_pending();
> +		do_trigger_flush = true;
> +	}
> +
> +	(*cpu_emergency_nesting)--;
> +
> +	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
> +		*cpu_emergency_nesting = 0;

I see two issues here. First, this is unsigned. kernel test robot
reported:

> kernel/printk/nbcon.c:1540 nbcon_cpu_emergency_exit() warn: unsigned
> '*cpu_emergency_nesting' is never less than zero.

Also, in this situation, we are allowing a brief window of activated
emergency mode by allowing it to become !0 before correcting
it. Instead, we should avoid illegally decrementing. I suggest:

void nbcon_cpu_emergency_exit(void)
{
	unsigned int *cpu_emergency_nesting;
	bool do_trigger_flush = false;

	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();

	/*
	 * Flush the messages before enabling preemtion to see them ASAP.
	 *
	 * Reduce the risk of potential softlockup by using the
	 * flush_pending() variant which ignores messages added later. It is
	 * called before decrementing the counter so that the printing context
	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
	 */
	if (*cpu_emergency_nesting == 1) {
		nbcon_atomic_flush_pending();
		do_trigger_flush = true;
	}

	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
		(*cpu_emergency_nesting)--;

	preempt_enable();

	if (do_trigger_flush)
		printk_trigger_flush();
}

John

