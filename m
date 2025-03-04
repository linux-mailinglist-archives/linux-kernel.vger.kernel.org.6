Return-Path: <linux-kernel+bounces-544320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E48A4E010
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A46E3B6428
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CDC204C11;
	Tue,  4 Mar 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EY3yfec7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oi3kjdkT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5932036E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096796; cv=none; b=NTydMWZLdbgGSOpSqiT1zy4s6qLtG97GxJ8GtEeJmXu+/Mkvt4CpXKCFPJlvDqJJJjciGY3eHjWI5rKzr6msZ9EsuO1i9Egcjmrc4YQUkUpY/MWgrouez9P7qhPQNa/D7J/MaAz5xIqtRXxM2pTbGXTM+5b1Po1lM6KtbpD6Rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096796; c=relaxed/simple;
	bh=QKqzclx7vyvEXdb8FIs/X9WNp7zoMBpg2QvGJE5UpqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAN9M6nth3uZ22Vo43/gM2arbzYqQGLhgubRoWXOEMFu2F4fl5jKWIXUcUZI6lmadCdy8OqzZxD0BxXvpYn6v+NYi/m9VpDyh4+4bEmkEcUjKDnN17QliTyOdAFjKPQYnY8FQwZBZwnobdFNCDuJ8pnusUUm3Zf2CQodlKSUpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EY3yfec7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oi3kjdkT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741096792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPEg1gU8jsF4TvlTeMBD+//bwSjW/iMFwJE56K1FiQ4=;
	b=EY3yfec7C5Scw3xNRLzIXZl70LOI1yPCk4M7epZMRyegeZ107RFeeqvtq3QhXr7eh3KWVV
	HDD6K71KnhKX4TR/zGgMRJZljgpk9w0bPTc8370op4jH1YRoMkNmt8jt9i+UonUrGdqRlC
	Bw5n3fx3dNuXduHaHh/QMV+x0fK+tC3Q/g0d8CpVlQh+gxhCgfua5+3ITTSvffEhcUFafN
	gwmPJzHkoHPEQY7vNozgmEfJCVoOdqbriKUkIvhNpajfDSJ3//RbzSa1bib4i7gMMzgL68
	5h2xP+ZInWbX3mMocXfFklK5aEfTvK6vdaKAeHH+shmdMSXzvjYkrddu8rf9qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741096792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPEg1gU8jsF4TvlTeMBD+//bwSjW/iMFwJE56K1FiQ4=;
	b=Oi3kjdkTYmO/gSv59d+h7n70S/Ifb80Z5w3X55Dd9oQXA8A3OtXuoOSxfGTeEer6pInghk
	8J0Tr29xzL8zIKAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Donghyeok Choe <d7271.choe@samsung.com>, linux-kernel@vger.kernel.org,
 takakura@valinux.co.jp, youngmin.nam@samsung.com, hajun.sung@samsung.com,
 seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
In-Reply-To: <Z8b-ljGnw57GpJb0@pathway>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany> <84ikoxxrfy.fsf@jogness.linutronix.de>
 <Z78eGNIuG_-CVOGl@pathway.suse.cz> <8434fytakt.fsf@jogness.linutronix.de>
 <Z8b-ljGnw57GpJb0@pathway>
Date: Tue, 04 Mar 2025 15:05:52 +0106
Message-ID: <84ikoorj53.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-03-04, Petr Mladek <pmladek@suse.com> wrote:
> I mean something like:
>
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
>  			 * But it would have the sequence number returned
>  			 * by "prb_next_reserve_seq() - 1".
>  			 */
> -			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
> +			if (this_cpu_in_panic() &&
> +			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
> +			    ((*seq + 1) < prb_next_reserve_seq(rb)))
>  				(*seq)++;
>  			else
>  				return false;

Ah, OK. Thanks for the clarification

> OK, I propose the following changes:
>
>   + rename the option to "printk_debug_non_panic_cpus"
>
>   + do not skip the messages in _prb_read_valid() when this option
>     is used before the non-panic CPUs are stopped.

And of course:

    + allow non-panic CPUs in panic to store messages when this option
      is set

I would also keep the dump_stack_lvl() implementation as it is, even if
it could lead to interweaving of backtraces. Anyone using
printk_debug_non_panic_cpus should have CONFIG_PRINTK_CALLER enabled.

John

