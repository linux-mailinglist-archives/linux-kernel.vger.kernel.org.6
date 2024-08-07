Return-Path: <linux-kernel+bounces-277155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CA949D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7219D1C2152A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959082209B;
	Wed,  7 Aug 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1vrkJDC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMG2yiA5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDDB661
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993361; cv=none; b=rj5vaZIE7k9/1gPoDyOSN7cw2p76gnR8iJCDEHy1kKHMfZugfHPNPCGbgWJ5OMkMzdlupsRZRBSz2CHPl8Wh30N2CPOGApTdKlT4K4oRdGPlgJ22rJNqRJgVChxlDI969nFro0tR9mgf3bZy7jVeN9KZeXLi2f9hCVXsczfNoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993361; c=relaxed/simple;
	bh=M+x5t48BrVzOp6Lb7zFeOStbW3Sac1grtaNdG5XPMeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmCrr39h7nYJZZHYJ5OAR0C5eFH89Ep65Xdk9PV4LaPCEYf8eWpnQKcqQejTsCGsBFTDkC9mQl+fcY66MBt+rBSRIqomzE/z37beJ5QGWNhpucfJMUc3l0PsyH5SoHQ6mT81FDgv+JGYMm+VN7HFcF6RZoMyXnVg/OrKVZdmkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1vrkJDC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMG2yiA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722993357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHphsQQ/R1uQf4Xo7U2Cx9ePlxGjMUC8aAPGKbwTO8=;
	b=d1vrkJDCW0+KtL/PER9Dcgif53+YT9drz+OkSDoJ+eLOFJ65NwWdSCm/45a3q4t4BWQOUd
	5X1OUCd2cxlbRLStelq8QqNRx++suDPhhB6gOUx5Bv7fpfZLzNtKwlr+QSHgqSlaJAZdt5
	OUg8OgGo/zJaXR4ZdEpMpHb1uDcA/D3W2nT7KUn+4uXnOm0PghsJG/XcudpXZY/Jct+kZv
	1ZfZ3bIcQ/p58bzRknb22yd7Lll3z1oNViQC6T0Vz97rJDPRAusimaN/PqS37xZczc0Upl
	J4QHBcpNMZ9+aAz0/htCaBp2+5R005RlWCRlXae9uppnxb7czMG7CFVr8GkWYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722993357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYHphsQQ/R1uQf4Xo7U2Cx9ePlxGjMUC8aAPGKbwTO8=;
	b=gMG2yiA5syxQ2wavoP87qJwYovVj/3trheF0N8HOWbpeObMzP0JRHz8ZQrlxWTQkGwQsER
	JFglrJ1zYpXfPOAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 24/35] printk: nbcon: Flush new records on
 device_release()
In-Reply-To: <ZrDwZfGriZSxmjnp@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-25-john.ogness@linutronix.de>
 <ZrDwZfGriZSxmjnp@pathway.suse.cz>
Date: Wed, 07 Aug 2024 03:21:57 +0206
Message-ID: <875xsdf7zm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-05, Petr Mladek <pmladek@suse.com> wrote:
>> +	/*
>> +	 * This context must flush any new records added while the console
>> +	 * was locked. The console_srcu_read_lock must be taken to ensure
>> +	 * the console is usable throughout flushing.
>> +	 */
>> +	cookie = console_srcu_read_lock();
>> +	if (console_is_usable(con, console_srcu_read_flags(con)) &&
>> +	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
>> +		if (!have_boot_console) {
>> +			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
>> +		} else if (!is_printk_legacy_deferred()) {
>> +			if (console_trylock())
>> +				console_unlock();
>
> nbcon_device_release() is going to be called in uart_port_unlock*()
> still under the port->lock.
>
> => It smells with a potential deadlock. The console_flush_all() in
>    console_unlock() might want to flush this console under the
>    port->lock as well.
>
>    And it almost happens because nbcon_legacy_emit_next_record()
>    might eventually take con->device_lock() when called in
>    a task context.
>
>    It will not happen here because this code uses console_trylock()
>    which would set @console_may_schedule to false.

Exactly. That is an important point. We must never try to invoke the
write_thread() callback while holding a spinlock.

> Anyway, it would look more safe when the flush was done after releasing
> the port->lock.

Even then we could never invoke the write_thread() callback because the
caller may be holding other spinlocks. If we cannot safely call
console_lock(), we cannot take the device lock. The atomic callback must
be used and that means the port lock cannot be involved in the
console_trylock().

John

