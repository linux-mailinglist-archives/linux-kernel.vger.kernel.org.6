Return-Path: <linux-kernel+bounces-423562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57B9DA9BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D543163543
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDB1FCFE8;
	Wed, 27 Nov 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWkjXyoe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuMO64ya"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD921FCF41
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716640; cv=none; b=LeUEUbJV8snTi4D8TfSn/odFC5IkREuTL/TueDmn6f2JYsYA/iNkMSLpRs47I8tQjXCiKgVlxucGkbVyhEDokidHVQ5TXqU8YHwQHhrqba1cyfq7QNQq0DooXwD1aqWLXVDY52SqKTrNm2aqXkfq8A/vFglfV5CQVRzWzAw/TCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716640; c=relaxed/simple;
	bh=86gMFMx1kzpedqbdzsi7oPFsZy7Jyx0FTYSEk362hVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elWi41zuEA+e1/RxEgtzu/DUxnQ21m5U9sGw24NzB9TS9OJMcvlt9laQq/5ozJeX/xNodg99VRM28/mdvHxD4+XPe8bHxOCU0f290sUYJvrCo8hUTtGPjqzaZMIAMVwJwNDLPb0APpc20ZLJynkgNBfXRXKdhjBtvhr50TmfGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWkjXyoe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuMO64ya; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732716631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxMqILyVOKvRWXKtcGX0dFZmJjb9f53AOFeUNIulrsI=;
	b=VWkjXyoe9bJs3jBh3GcCTSTClVZmPOvzVY4rQ7yCxan4+tibQCCnTQ6Y1Ys7GtPTKEq/De
	C3wHHIJ12k0T1STYnYaDNRqMhXQ2JcjJG4BoADVkpZ45ri6h/f0UwJD1xKjO9GLoX0Pw/i
	sxLP4fkD3MJxZVjw4xIsi/gdXD4K4md7m84nTweGB9jEAz7oCgoRhEASXiRWE4hPMNwr+r
	7fbRvC/LplE5kE4Og1gXsuPPbMYDhxXwAz7wBFlytFTdoZziBRmayAo32voypx8yIbrHBp
	WL/r2UM/GsVhit9TRUyrKxANPARY4/yBvKq5/eBoYVebDOL9UwzN9lm60aZhLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732716631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxMqILyVOKvRWXKtcGX0dFZmJjb9f53AOFeUNIulrsI=;
	b=vuMO64yaCVMoVbFuPVuRa16PAEzFTLMV4KOGMn9O/XUVobUOee0pLs25dH3Qj0aTwWb5hZ
	3z7gmS74WdcrLKCQ==
To: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>,
 "jstultz@google.com" <jstultz@google.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>
Subject: Re: [PATCH] ntp: fix bug in adjtimex reading time offset
In-Reply-To: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
References: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
Date: Wed, 27 Nov 2024 15:10:30 +0100
Message-ID: <87zflkydgp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 25 2024 at 12:16, Marcelo Dalmas wrote:
> Due to an unsigned cast, adjtimex returns wrong offest when using ADJ_MICRO and the offset is negative.
> In this case a small negative offset return approximately 4.29 seconds (~ 2^32/1000 milliseconds).

Nice find. Please format the changelog to be within ~72 characters per
line next time.

> Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
> ---
>  kernel/time/ntp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index b550ebe0f03b..02e7fe6a0afa 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -798,7 +798,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
>
>                 txc->offset = shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_SCALE_SHIFT);
>                 if (!(ntpdata->time_status & STA_NANO))
> -                       txc->offset = (u32)txc->offset / NSEC_PER_USEC;
> +                       txc->offset /= NSEC_PER_USEC;

This patch is white space damaged. (tabs are replaced with spaces).

I fixed it up to you this time. Please send your next patch to yourself
first and verify that it applies cleanly.

Thanks,

        tglx

