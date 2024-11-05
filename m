Return-Path: <linux-kernel+bounces-397179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E102B9BD7B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C84284A18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076C2161ED;
	Tue,  5 Nov 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gf5hU6ZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOCZzTlj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A750383;
	Tue,  5 Nov 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842471; cv=none; b=MvoH77Vdj69RBuAUDcfXzpgwNdva7SdfHW4CrwtIHBTRmoTm4cPBo9iZViJxFsPBH7BsiJU6cd3KjGHZXQ7bvlduWsmIRZhx/j5erGGEo5zn6DS2O2lIjrx/xu0mx5wJRP66UuGU9MVEMWTO6ape3QmOHHWZIjslf5QGhq7noYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842471; c=relaxed/simple;
	bh=LxX6mgPo1+b3r0JP/4TYAfFOCE1dGhelXuP0Q3CeM0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHdz1mB9r7jeg23HyVVHCzIiGlT8gpAdLnm6eSuk8UVNggrI59pwvQD/oYfgpIcbRrjOhx93KAwy3khCWRfPq6HVzB0eNS9Ncq89va1Sj1FpsT6fUOZYePKwWIGNnLp1prvhx2z6Kyk25YFKw45PwwRgvs9SH9lET4VTZQMxCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gf5hU6ZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOCZzTlj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730842467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9JbGTZt/ccShmBUn8QAgHHoVKER+uJdrSePGYFos4c=;
	b=gf5hU6ZHNUCz7mpvyH8lVrzJPBDgksPhsEwbw+t96M3/3nWwvggw8QjonqiSu4BktT0pnu
	XGK32mEov+7TcDcj0JwHdVVQI2kmOzrYsr3nn6/rnBQOlLjgtIn/cwRwpAw5kQcwz2CLqw
	YrqEn/Mp9W/fUGT4PBaIy0RhqvZh4vqdfMUbOJPh8kMxef/UHtmgiLjFCWrFrFf/BbeDS+
	fR7GH0MDOUx4HPbng7S03BYil+a8s5Gd0OEEcpJ5uPhOwl6kE7UJ4Kl0uPagVr7BAWbxKS
	8KNuPYZrZE73TGh+R4mZoI9j/f2uTr6TjTA5zRYvYKWGxZ80kcjtq0LBfJMzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730842467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9JbGTZt/ccShmBUn8QAgHHoVKER+uJdrSePGYFos4c=;
	b=pOCZzTljYdZ/cj+Kc3d9e1uRSiMPQ/aoscHW6W0bDUY1Pyot0UcvauTo5GHfBvXrNL797W
	qrJkhyccY8hkKNBw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Marcos Paulo
 de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v2 1/2] printk: Introduce FORCE_CON flag
In-Reply-To: <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <20241105-printk-loud-con-v2-1-bd3ecdf7b0e4@suse.com>
Date: Tue, 05 Nov 2024 22:40:27 +0106
Message-ID: <84ses5e55o.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-05, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> @@ -2947,6 +2953,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	struct printk_info info;
>  	struct printk_record r;
>  	size_t len = 0;
> +	bool force_con;
>  
>  	/*
>  	 * Formatting extended messages requires a separate buffer, so use the
> @@ -2965,9 +2972,13 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  
>  	pmsg->seq = r.info->seq;
>  	pmsg->dropped = r.info->seq - seq;
> +	force_con = r.info->flags & LOG_FORCE_CON;
>  
> -	/* Skip record that has level above the console loglevel. */
> -	if (may_suppress && suppress_message_printing(r.info->level))
> +	/*
> +	 * Skip records that are not forced to be printed on consoles and that
> +	 * has level above the console loglevel.
> +	 */
> +	if (!force_con && may_suppress && suppress_message_printing(r.info->level))
>  		goto out;

Rather than adding a new local variable, setting it, and expanding the
condition, it might be cleaner to just update @may_suppress before the
condition check?

	/* Records forced to be printed on consoles must not be skipped. */
	may_suppress &= !(r.info->flags & LOG_FORCE_CON);

Feel free to ignore this suggestion if you think having an extra
variable is easier to follow.

With or without suggested change:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

