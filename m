Return-Path: <linux-kernel+bounces-426614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AF9DF5A9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE48B21196
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4A1C8FAC;
	Sun,  1 Dec 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFEJT0uH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJmRMUwE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1D1C82F0
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058195; cv=none; b=pHsVUVWSfk1nXinKK0IyGxk/RDbdODdZ++cbEzDyqdfcMNotbI+YsojAvjVgSeEr/hPVxMrriNRssxG+ydTWaVX6u7GeGKboL2nOanblBWKBL3tf3vn2UJZ0jPn5PMoxqWi/GFRw4XmuC2Todi0jUa++K700oi4aUiLVfmP9R64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058195; c=relaxed/simple;
	bh=IabiXLrBzOonyNjr8rnK+KVv2wHEXOy1LeY8IS9B2g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJSY9Hm7HYnfhpOSlLC4XSQkhItn96I1ZFQ1++QKHmW5UuBHpg2/INhwUdD4yxEUhG+5rt4gq8W5VZEiGvVCma1dTNt98vbFIRo2MUOwplwG+Zz8QKVv8fyOBRejG63SsF4RbRQsTXft0Ci55S7eQ0JghwS8GGojTvXxi1A7OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFEJT0uH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJmRMUwE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733058192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDx44ggQzhTmObuUgAWgM9i45B0XCKnpQa5KvP5zEcQ=;
	b=iFEJT0uHqnNcnT4yktUa1Csgvlj8SaONP9qcDsgfpSzU5TS1PTWZ0ho0sQKd2Eu0JmXz2g
	55wQGek05D0dIh64cccfE/hXA2h0JRhA2HSJkyDRwoLzQq+1gFu00UsvEOoBa6wMFY1imh
	zSFV9qcFnrftiwtWsbSPOV02LIFCCk9ipVZzoPYG5W9uGl7gRoP1RcyeSZzbvOUCH8DrEk
	8+PgDc67RtjVbHXRrkwCVn0YLhENTM8vqwYnC7E4WGx2AcIoTvfORmSPzyXgGS1ZoWBjli
	rGZOwjLoAfn4T14XmZ6+wQsoka4vLPnN+YKDJTGhx3hNNsYrDdaM7oKpa4HrnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733058192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cDx44ggQzhTmObuUgAWgM9i45B0XCKnpQa5KvP5zEcQ=;
	b=dJmRMUwEPfPtOjkqniROoBQsFgfPyOKngvtpBzuR5LIo4h1o1as8uyBVc6FeERROFnltr7
	7yqG7oZnlMC2zWAA==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip] x86: vdso: Compute timens page offset statically
In-Reply-To: <ZzqkEzxJ69dBSps_@zx2c4.com>
References: <20240906190655.2777023-1-Jason@zx2c4.com>
 <Zt8XxiQrma1R2a70@zx2c4.com> <8734m7btjo.ffs@tglx>
 <ZuA5gaOhJNwDSb4x@zx2c4.com> <ZzqkEzxJ69dBSps_@zx2c4.com>
Date: Sun, 01 Dec 2024 14:03:11 +0100
Message-ID: <874j3nwo6o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 18 2024 at 03:18, Jason A. Donenfeld wrote:
> On Tue, Sep 10, 2024 at 02:20:17PM +0200, Jason A. Donenfeld wrote:
>> On Tue, Sep 10, 2024 at 02:08:11PM +0200, Thomas Gleixner wrote:
>> > On Mon, Sep 09 2024 at 17:44, Jason A. Donenfeld wrote:
>> > > On Fri, Sep 06, 2024 at 09:06:55PM +0200, Jason A. Donenfeld wrote:
>> > >> The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
>> > >> seems harmless, but it actually results in quite a bit of code and two
>> > >> jumps, in a place that's supposed to be somewhat lean on code. The value
>> > >> of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
>> > >> to that results in a more modest cmov instruction being emitted. It also
>> > >> makes it a bit more clear what's happening.
>> > >> 
>> > >> To accomplish this, define offset macros in vvar.h, which can be shared
>> > >> by C code and by the linker script that decides where these pages will
>> > >> actually go.
>> > >
>> > > I noticed we've only got a week left til the merge window opens, so I
>> > > thought I should poke you about this, if you want to take this through
>> > > tip. I can also take it through my random.git tree with your ack, if
>> > > that's easier for you. (Assuming, of course, that this patch is actually
>> > > correct.) Let me know.
>> > 
>> > It's not the end of the world if this does not go in now. It's in my
>> > back log and that VDSO stuff needs more care than this particular thing
>> > as the recent discussion about vdso random on other architectures show.
>> 
>> Okay, that makes sense. And thanks for taking a look.
>
> Thought I'd poke again about this. It looks like this still applies to
> tip.

It's on my radar...

