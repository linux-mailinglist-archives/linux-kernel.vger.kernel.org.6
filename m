Return-Path: <linux-kernel+bounces-523867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB4A3DC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A443116B927
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE31EFF8D;
	Thu, 20 Feb 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgAojoQM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y49ISZ7+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C060433BE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060799; cv=none; b=UDmfiwdejnVATgxR/R2mFnT0tIGbcfWcN4hiTLBEz8uUF1EtpSEmZi1+whcfUbGW0KMp1pZRDrVcxgvBGsa8j+kPxL80QFszws0Fy9N1RkpGFDq7082KEpaUHmckdvs/30sghQwP71lzX5qJnxoO6HxJ/S586A3leC146TMr6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060799; c=relaxed/simple;
	bh=kbByHq2PDdIX1qdJYEkBYyjnloFpLOyQh9aukGf5fAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3EHG9aMMkFGBfJNNVLbPRGeXk9ZLfaz9jPs1WGlEkjydnUjDBBX62W2vUh0e+IohqhSvHvl7dvwfKYFb16GY7GF8Lp7rV1/zFXxtFeiv0f0m9IThsAkF+8qyo5FageGh9Qb9V3Hf0JCT8MPZtf69m/2tMUJCGXxS3+jepoXg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgAojoQM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y49ISZ7+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740060794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9pj6jjBEr5BnUCHZ9k7ZDBSaz2lWUx2dmnpfiugUrU=;
	b=VgAojoQMzMmbJjyrER/8si5TAfNx1nyJCAkx/QtCYYapLKQOKlKFpgXLnYQCBM/smohyna
	JnVbXq5mBLBreL3uAVqFG1buNY7beDST6DloHkIxYzGwoc+Gv0dIyGJxOfMZE+jnOoYajk
	BUKxQUJIef9qFmTHP5UuZMJ2i1c7LpYpdHb86estGU51+MsLX2QHnVuSJymwpVfSwvMVjL
	tlo8SVHrzcXlyN8sxoANYT3OUgRNa3zng1G5JYLgCUFDBfKZgyty4iX0rkC+NYVk61roPs
	+RYJt6/Mp4ac+mnqLsfM5RFqMCQazy7XL3s+U0eLtm3IVubMjWNx1tG7aT60Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740060794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9pj6jjBEr5BnUCHZ9k7ZDBSaz2lWUx2dmnpfiugUrU=;
	b=y49ISZ7+OOOGDjIdokrOL/7AvVwgkq4GgMYApSoKQq5NEymD3VupABpsJbFPYmmB+PNKOp
	lRb0wokLXqvHa6Ag==
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 3/4] posix-timers: Initialise timer->it_signal in
 posix_timer_add()
In-Reply-To: <CANn89iKyxncwVioEHDqRBOTOrgnYoMcq+KAKqCzTadt68UP6yA@mail.gmail.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-4-edumazet@google.com> <87r03thvu7.ffs@tglx>
 <CANn89iKyxncwVioEHDqRBOTOrgnYoMcq+KAKqCzTadt68UP6yA@mail.gmail.com>
Date: Thu, 20 Feb 2025 15:13:14 +0100
Message-ID: <87bjuwiu11.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025 at 09:44, Eric Dumazet wrote:
> On Thu, Feb 20, 2025 at 9:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > This fixes a potential race, in the unlikely case a thread
>> > was preempted long enough that other threads created more than
>> > 2^31 itimers.
>>
>> and then what happens?
>
> Two threads might get the same timer_id given back.

I know that, but how will someone who reads that changelog without the
knowledge and background information know?

That's the whole point of change logs to explain it for the uninformed
reader, no?

>> >
>> >       spin_lock_irq(&current->sighand->siglock);
>> > -     /* This makes the timer valid in the hash table */
>> > +     /* This makes the timer valid in the hash table, clearing low or=
der bit. */
>>
>> Clearing the low order bit of what? This is a full write and not a clear
>> low order bit operation.
>>
>
> Prior value was (sig | 1L)
>
> New value is (sig)
>
> -> low order bit is cleared.

Right I know, but again it's not obvious without figuring out from some
other place what the logic behind this is.

Thanks,

        tglx

