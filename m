Return-Path: <linux-kernel+bounces-386666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB19B46A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FC01F23F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D41204946;
	Tue, 29 Oct 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTsLbfZe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxXcrcvh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C7204034
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197328; cv=none; b=n5eo4o40irWgZnyOtik4H/M2NRnAeDLfWObz12KVWtOQpEOjqirxy0xGh2l21tPnAcaHxbp2wHexxTHU8QTIWqJugtBgMZDzak8Fn62SpW8ZheqUCxA2xNT6x4OiSqJ/tA1cvaqak6v6ZM2mYuD62HSidCcFlEhfey0+iRPhfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197328; c=relaxed/simple;
	bh=86FMfjGXBUG5YdIt3g7Oth+7z4r05+GvjSHohYI7dJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eH+U7X5PWOIE/W8Ohy8k+5GfkI33bHCRu+joUL3MnXMKQHZt+pPtbwHUt7IsDhK1SXOoOsybfr8xdMOHIggsZJSKqUdEnEMS87kYUpqMb+EYA3auLywDE+q2uGGcASnDvWOsi0FgyuZ6GIqrjfsoCNOA6ZGL9ydIpYy8GGEMx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTsLbfZe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxXcrcvh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730197324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rvAuiUKy9EdAAkDT/ldjMWesALTEbax6NRj6a3rdO6U=;
	b=aTsLbfZeAZAlVE8kgBvufhIwogO7dRqT+0tXUQHI+36NaxYnrb9SL322maFJBayG4PlOMh
	HK/21AGsgwTrMwvi/l7zr671g5ESrrflqe8YlHuaSl9cukEV/sHZNBropGNuYbXyQzrG9a
	9mT3XMsLSsNNifqj5Svj4csiE5QZnj7H4J7fsVpYPQ5hBRC8z2ptWqxko7c7kRI+jQfAZl
	IrvV30PhOS3bYCwf79+5fXMA8jcwPseAPkivumA5Yn6evdGtAYMN0o10gZo1LH5liNXg5d
	GitUC5lBzP1eunZDc72O4+xmDhppJa0rUINB5Q96PrOF6kSAixAuf4Bulg80yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730197324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rvAuiUKy9EdAAkDT/ldjMWesALTEbax6NRj6a3rdO6U=;
	b=YxXcrcvhkSXLH9+zWyY/hIOHxoLmruE5XAcIs6nZM2SKaYJvwIpGfN4AxTfhGjhPlI4OxG
	As7v+qCE0fQftKBw==
To: Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, jirislaby@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: Deadlock?: console_waiter/serial8250_ports/low_water_lock with
 6.12-rc
In-Reply-To: <ZyAJD5IPWRoXhd_B@Boquns-Mac-mini.local>
References: <CANDhNCo8NRm4meR7vHqvP8vVZ-_GXVPuUKSO1wUQkKdfjvy20w@mail.gmail.com>
 <CANDhNCpaJ85EvMvjs+Qpgnohpo_cy96PGXJ7Y3S6SOZ2iaG9aA@mail.gmail.com>
 <ZyAJD5IPWRoXhd_B@Boquns-Mac-mini.local>
Date: Tue, 29 Oct 2024 11:28:03 +0106
Message-ID: <84h68vnr90.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-28, Boqun Feng <boqun.feng@gmail.com> wrote:
> I think the cause of the issue is:
>
> 	CPU X					CPU Y
> 	=====					=====
> 	uart_write():				console_unlock(): // console lock is held by Y.
> 	  uart_port_lock();			  __console_flush_and_unlock():
> 	  __uart_start():			    __console_flush_all():
> 	    pm_runtime_get():			      console_emit_next_record():
> 	      __pm_runtime_resume():		        con->write(); <- serial8250_console_write() // will try to acquire uart_port_lock();
> 	        spin_lock_irqsave(&dev->power.lock, flags):
> 		  <this triggers the lockdep splats, probably because
> 		   PM has done some print under "&dev->power.lock">
> 		  lock_acquire():
> 		    printk():

It is a known problem that calling printk() while holding the
uart_port_lock for non-printing purposes (such as pm) will deadlock the
system. You don't even need CPU-Y to be involved. CPU-X will deadlock
itself after acquiring the console_lock.

One possible solution would be to enable deferred_printk if the
uart_port_lock of a console is taken for non-printing purposes. The
correct solution is to convert the console driver to the new nbcon
model.

The reasons why nbcon avoids this issue:

1. It does not use the BKL-like console lock.

2. It is aware that something else is using the driver and will instead
just write to the lockless ringbuffer rather than endlessly spinning on
the lock (that it itself is already holding).

@jstultz: Is it possible that you could run your tests using the latest
version [0] of the proposed nbcon-based 8250 driver? This will not have
the issue and should cleanly apply to any recent kernel.

John Ogness

[0] https://lore.kernel.org/lkml/20241025105728.602310-1-john.ogness@linutronix.de

