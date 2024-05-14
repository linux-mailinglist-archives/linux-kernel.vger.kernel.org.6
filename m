Return-Path: <linux-kernel+bounces-178469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557B8C4E26
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DD71C2185E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2921364;
	Tue, 14 May 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAl9MTv7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4h2nBB2F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D191D54D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676676; cv=none; b=cBCpFW9nFvqgnZyACHPR19HrLqtRhQPV1QTUdK6r7w0nnSE1yW82IwEaCkmkL/wWBlK/CW2FAscyWfHAu31zMAzdVVjYIcDnbRHKvivGtFAaCRNhgEG29yfxsUDzmupzjIAdxoRVk7D3yjLo40XCjYaCQNOhQ422iDtgNIPfRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676676; c=relaxed/simple;
	bh=xuOfDGpcNy6f8HPvxiZX06FnPzvZC0xsPMZwFFxYgZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iszil2X6J06Ggg/zDxn2aUtP+BQyrEp6d+8Lvc4hF3DaAE1GljbE+8MBJcGQ3RAgEYNQJIAwo382bshszG8d23V8MtO3q2qwGy8B0pvFSvn99rdi+NiS0HcGStIdyPcKsApM70me1e0ltj+JvlGIjvjqccCx2808y5LopkK00m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAl9MTv7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4h2nBB2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715676673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VtHy4eod18lFlILaxkSyirZif/DH69UWjz2KgwQkT8=;
	b=xAl9MTv7ncRejsH9tXbyQSRNZkw9ND9Y0IUX9GIVHba4A9bkNRpifUdKuulTFxXOByrOIy
	ugZroXa4ASjxtClkfWKJ2+M5sjk2xymnl/JFD0PDpaUZkdLuEoyrzMCkWnoZ+gtd4NfNlC
	aJU9UZVWnRZCWClg7jvquUw9ENpI6RgrA365syGGD/tN0yZZ8D5gDfcWFFH3s2SnZm/4S4
	ANg0AbAd/eWhrqog0FPqntnZ4szL1iEqlSKhftfX8sgIzt9kvbEkBqWhzAzWGWYnv+dqd6
	XXT48RYD4c0SMqT9gZFbgCF21gitmh9LwqRIvdqNpCSshjbugz3iS+j+nTgUAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715676673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VtHy4eod18lFlILaxkSyirZif/DH69UWjz2KgwQkT8=;
	b=4h2nBB2F51Zo/bq+c20rHtxgqs+BynJtk2jxaaEoITt2z6fN1NPuGO0epxBrIh7tXQ/o/d
	cYW3EIf5UHVZ15DA==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] ntp: safeguard against time_constant overflow case
In-Reply-To: <zhb5dy6ysbdghj3vhnj2s3gd7fhqg3v7xmhonkgfxp33qtc6bw@pqyhntprkwjr>
References: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
 <CANDhNCps8qE1a+Vp2HNgU=-vA5RwhrLd2_D0EMZiNv1j_OOYWA@mail.gmail.com>
 <zhb5dy6ysbdghj3vhnj2s3gd7fhqg3v7xmhonkgfxp33qtc6bw@pqyhntprkwjr>
Date: Tue, 14 May 2024 10:51:12 +0200
Message-ID: <871q64n5dr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 22:03, Justin Stitt wrote:
> On Mon, May 06, 2024 at 11:02:17PM -0700, John Stultz wrote:
>> > @@ -734,10 +737,10 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
>> >
>> >         if (txc->modes & ADJ_TIMECONST) {
>> >                 time_constant = txc->constant;
>> > -               if (!(time_status & STA_NANO))
>> > -                       time_constant += 4;
>> > -               time_constant = min(time_constant, (long)MAXTC);
>> > -               time_constant = max(time_constant, 0l);
>> > +               if (!(time_status & STA_NANO) &&
>> > +                   unlikely(LONG_MAX - time_constant_inc >= time_constant))
>> > +                       time_constant += time_constant_inc;
>> > +               time_constant = clamp_t(long, time_constant, 0, MAXTC);
>> >         }
>> 
>> Overall, this looks fine. Though the time_status conditional is now a
>> little unwieldy.
>> 
>> I wonder if some sort of a helper like:
>>       time_constant = safe_add(time_constant, TIME_CONSTANT_INC, LONG_MAX);
>> 
>> Might make this a little easier to read?
>
> How about something like this:
>
> 	if (txc->modes & ADJ_TIMECONST) {
> 		if (!(time_status & STA_NANO))
> 			time_constant = clamp_t(long, txc->constant,
> 						-TIME_CONSTANT_INC,
> 						MAXTC - TIME_CONSTANT_INC) +
> 						TIME_CONSTANT_INC;
> 		else
> 			time_constant = clamp_t(long, txc->constant, 0, MAXTC);
> 	}
>
> We can remove the initial assignment and use some fancy clamps.

That's unreadable TBH.

