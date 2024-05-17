Return-Path: <linux-kernel+bounces-182168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6F08C87AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4131C20F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3F56742;
	Fri, 17 May 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bkOxqJIf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9LyTOl7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A52F36
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954441; cv=none; b=DhV81pLMX901qr6eUUwUuC1lN2c/jyckOJi6dMjo6BdOFvmz4ap5JrDImrl3FsG0Z8uAUVu0JvdtxfcjK5LCSDniDjRzPqmIVXHi3nOUs57fMGMrWlkhMi9wR/erkSUXOpXH20fYTmejc8V+Q21J2R9+UdxI0tVtGcc+DCQR5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954441; c=relaxed/simple;
	bh=ytdeAf0glZLyve4PWQhSbfcQygB6RzOA8XdVccE6Tew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZr03wTkKd79IJPLEYiyjK/a2nj9/mS8SDFkVhtwVw06EHOy9VIsFa/QdtMjPu3c0yKMO04XKyXxxBG7ySFLxEb0cW9Uj/uftAC//swgRuIXdItWFfdICuLVD2r35N2DgPck74c7kV0yX4bVyzbxpIZmSNwQBD/+54Hc2Vr9CQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bkOxqJIf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9LyTOl7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715954432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4wyyBXc4N3xqeEACKaiHFG8PL3HToOEG4cld2DUxs4=;
	b=bkOxqJIfaFocP7nbNqpXGe85oC/EjKmt+gi9SRcXpA84N3hFlMe9i2k7MV8l43oWCn1SSJ
	jQM9uZGN7IwKG9rkNJOgevJM86Q1oiiYNecndQrjqo+pxGbspd4DmVfLditlKVNtv+i/WC
	lIdiKdRdO7/DQclXA7CJjkaD20bEJK5ZQshImv9wn9UeRuZWnWC4a6FyWLT7Yvbx0ek2YP
	gjwAAxdyJIxDtsLAjYzrYdPNQgTdyNkTGjh11fLbpzB9Qrf0PzunBS/TNhA2uSpCsf4SOX
	PxvmfSyFGn0EiZSHMf+4PIGrqYbZcFffQF2TKFg+gW9gzqsBQxqNxoacPkEjOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715954432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4wyyBXc4N3xqeEACKaiHFG8PL3HToOEG4cld2DUxs4=;
	b=J9LyTOl7z2P9OQ2yEuZLxu9UAKPramcI31ENF2utUPm04FeNNOS1mzfmi2UwYru/NGQW1b
	gDEHiNideqBQbpAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 06/30] printk: nbcon: Add callbacks to
 synchronize with driver
In-Reply-To: <ZkdcFxW-e9LVmMd8@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-7-john.ogness@linutronix.de>
 <ZkdcFxW-e9LVmMd8@pathway.suse.cz>
Date: Fri, 17 May 2024 16:06:30 +0206
Message-ID: <87bk54y1vl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-17, Petr Mladek <pmladek@suse.com> wrote:
> BTW: I wonder if you use AI for generating the commit message.
>      My experience is that AI produces longer fancy sentences
>      which might be good for a novel but they sometimes hide
>      the important details.

I do not know if that is a compliment or an insult.

For the record, I do not use AI. The "long fancy sentences hiding
important details" are coming from a sober brain... mine.

> My attempt of a more strightforwward explanation:

[...]

Your version does not mention why the generic code now needs to use the
driver-specific locking, but I suppose that does not matter (and only
adds confusion instead of explanation).

I will use your version.

> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

John

