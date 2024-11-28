Return-Path: <linux-kernel+bounces-424571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA59DB615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC332816BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C5197A7A;
	Thu, 28 Nov 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W94x4K+0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I9aoYZW3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C7194C96
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791298; cv=none; b=pkNHtpkP/k9jDvFkjoqgcnPqj8ryRycnYRvVBsB4PwFLlzQHjz5FLF6vNQQ1gi0C35yJIfrYLluRF5EFlXAJ4pkpXy9HzYOfnbdCAD16iE421/okesXlYi5RjoY1h0dN7CZe9RhQAER2F5kWQVLPWCNfUMc8akFT2DSW4FCdWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791298; c=relaxed/simple;
	bh=viK4i2GchOONZO7PtKbBJDVtUbWwqLbwxOOc12W0b0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTSSKnN4xeMQGfbbP8+tVke0cFvyYF9MIkEqDnHmjPjq0Fwkysnnyp888ZXs57unsDnGIEV534N8cwLIvtydB8XUDFbrMb2/LawR4ra4pmOfx2ozi/8Khk8qveChNGXn+ieFK4TSrURf5+Tbq9mHUwcKVClKzQdCgrD5TjUmbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W94x4K+0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I9aoYZW3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732791295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Zm09wCCx+6S1qQF+CTECMolfgOWU3ldUEZ0/vhHyw=;
	b=W94x4K+059Q83GOIiHQBagSXl4mxtOotc2OS7VHq0v9ctPfuXbS2w6RfuG4tgyRZvTmjLm
	8TP5V7k3FMnN8oswrWX25iQXJDyHHeHbPEf8XpFRdsT1ArF61Gr0aRwreNX96mJB4eppNM
	fmcmPpnVLQI6Ucbf/gs4/YYU9KHN94QN1ZrqC3+Q4fESS/Fi/b8Gj6E4erAPtPmK/OSOxc
	zDbs5ccezjwYqixAuJL5NeikDeaiV5awwrj6+azPSiFiAp4pGauPUbbk9VX93xKuZZFGtI
	mvRhTC34qTp38DRgE5pfOchO45A4SeW0ScQshvUVlwiGbEWxQEPm66gcIhDHkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732791295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Zm09wCCx+6S1qQF+CTECMolfgOWU3ldUEZ0/vhHyw=;
	b=I9aoYZW3Y/U9g2wCJhkAL1Jn5jTyhOAXbrOPCHQHBIgH+BaLAWPWkgDNWWVBH/9GyBIuPv
	uz1BRi+zQYgP4OCw==
To: Richard Cochran <richardcochran@gmail.com>
Cc: "Dalmas, Marcelo (GE Vernova)" <marcelo.dalmas@ge.com>,
 "jstultz@google.com" <jstultz@google.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ntp: fix bug in adjtimex reading time offset
In-Reply-To: <87r06wy3sf.ffs@tglx>
References: <SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM>
 <87zflkydgp.ffs@tglx> <Z0dDOje96uI_t9sd@hoboy.vegasvil.org>
 <87ttbsy3zd.ffs@tglx> <87r06wy3sf.ffs@tglx>
Date: Thu, 28 Nov 2024 11:54:55 +0100
Message-ID: <87iks7y6f4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 18:39, Thomas Gleixner wrote:
> On Wed, Nov 27 2024 at 18:35, Thomas Gleixner wrote:
>> On Wed, Nov 27 2024 at 08:05, Richard Cochran wrote:
>>> On Wed, Nov 27, 2024 at 03:10:30PM +0100, Thomas Gleixner wrote:
>>>     The patch was generated by the following coccinelle script:
>>>
>>>     ...
>>>
>>> So I guess combining random other manual fixes into a patch that
>>> claims to be generated is a bad idea?
>>
>> Indeed. I just figured out why the cast is there. txc::time_offset is of
>> type 'long long', so the division triggers a build fail on 32-bit.
>>
>> It want's to be:
>>
>>    txc->time_offset = div_s64(txc->time_offset, NSEC_PER_USEC);
>
> Or simpler by using a (s32) cast instead, which is sufficient as
> time_offset must be in the range of [INT_MIN ... INT_MAX] because
> NTP_SCALE_SHIFT is 32.

But that requires a comment while div_s64() is self explaining and it
does not matter performance wise as the 32bit implementations reduce it
to a 32bit/32bit division.

Thanks,

        tglx


