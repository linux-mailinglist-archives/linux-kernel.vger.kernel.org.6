Return-Path: <linux-kernel+bounces-169668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7588BCC01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA31C213F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A91428F9;
	Mon,  6 May 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhjRFZTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdyrFk5A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D543AA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991366; cv=none; b=b0ighbOUkcP9y+VtVXFz1XxUkDCmjsmPlUCTT3HAU6KPWunvZ48vkfkFvmhty2X5JYuq2FdUaHf2lxh9Ba2/3IB1Y/8HrGF0Y3NY8KiB6wONcTVRUbm8VxWpfHfDWNbfJcrl7LVE5y9tai9x73OO3FhujzFV00807bl0Hv4+K08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991366; c=relaxed/simple;
	bh=zhd7UACo0p+TrDMQIhCGKv6uEm4HA45+hbwsK5Pl2Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3vgJ2EfFSBBLw075iqMNnznx1c7Nl4efdlRUhkcclQbZ57qf4ZbnGyMRjsKpnSrSQbrErSiFz6mRH03y4RQorY7dtYwh3PNfaB780P+HCFzZnoT5Bcslaa3IljOguyYG7StKwkrpkl3GfvjMH3ws1Dowsvd8LZv67yx55aXIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhjRFZTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdyrFk5A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714991363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSG8WTCiJ42OSrw/ZVN2wRnUOYZNdndEtbaFf3OeZr4=;
	b=AhjRFZTXmsC85Rk3iY2zEzhSV41O9Mokk9F6ghuYzE0EnKSwdLLi5iPAK923Thmp+3pTzI
	7PIfEhp6neIxotOO8xofnN++kJ3UTaXD/27+j17sdYILmhL4ACDQdhZSYgp+VQwkSbo+9e
	WN+Q7lcJv6VrUsWtaCy0/XpTZizgrX8M8MX9qhZOPFSqfQt5dfiidkWgFnG/jP8WGsBQy+
	2P58bNaoTNNfnTYj+fcaTjLjFGq7qGpREkkLOWlZgPHaG8854ToJLe5sA2jUpXI/c6c5/J
	0a+NsEvmcOTV1+XAcC3XKHla0HN3XAWBuq6Ag684nIOO0fZf7a9GSX1kA5NGyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714991363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSG8WTCiJ42OSrw/ZVN2wRnUOYZNdndEtbaFf3OeZr4=;
	b=UdyrFk5AC2djoX0ASYfDh345fhYjJV66uyXBfl/SW2m+lRJMSh0XR99irR0VKFv63MLV8J
	7NEEM7rEmsfjckDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 11/30] nbcon: Provide functions for drivers to
 acquire console for non-printing
In-Reply-To: <20240502213839.376636-12-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-12-john.ogness@linutronix.de>
Date: Mon, 06 May 2024 12:35:21 +0206
Message-ID: <87jzk7i67y.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-02, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index dd7c3180b335..b8a7e3e136d3 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -989,3 +991,54 @@ void nbcon_free(struct console *con)
>  
>  	con->pbufs = NULL;
>  }
> +
> +/**
> + * nbcon_driver_try_acquire - Try to acquire nbcon console and enter unsafe
> + *				section
> + * @con:	The nbcon console to acquire
> + *
> + * Context:	Under the locking mechanism implemented in
> + *		@con->device_lock() including disabling migration.

 * Return:	True if the console was acquired. False otherwise.

John

