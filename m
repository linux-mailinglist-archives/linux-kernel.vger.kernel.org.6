Return-Path: <linux-kernel+bounces-278208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EAB94AD79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D966281EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177FC12F398;
	Wed,  7 Aug 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34P6oPEJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fn0vvCEK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F076046
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046264; cv=none; b=hzP9KEw4F0OQ44F41N3UWq9bRqFSYYHsTCIR/lRyzbL++0h+TiKQsFr3dNGnpJlwxL6qQhvs9zXZCloXGyHDDyBdQ05sEWchGmASpyYth5inc8Qwzfqpi04uh//fTPCVsiI4q6p1Z9NWtyUAV2gVZfYFFVrMFfUgxkd0Pf0NAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046264; c=relaxed/simple;
	bh=vo4Y62noYDQAMlgK1HvtAdufWVwrChn8gJry0xkV/fA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SY9FBE4q4xpwrerjWbYBfrUWHin8qcgQegE7kcRlUhxjYnpl8k0Fl5KsK5mbzh9G42hk+u34p3XE5G/r6xgHCZVqX1AqJuGSPuGPjxGCHuC6Fx++gKrblOUbmCZrHXK48cpedKjMYFn6XL/Mqyo6iqaj3px/WN6n3wDbg5Tj8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34P6oPEJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fn0vvCEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723046261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHX3b7rcMUHBsGLoSF7J1KsjokwlF2RkXxN8vtgWpCM=;
	b=34P6oPEJC1A8RN3s77z11bcplCDDJz/dDAtvXSLInFDRzvFmJYK5/FLnJWPItHJLUzTEad
	XroGAw/vgOqX2oC/pmU6K7p4eOmMO8cl/QhWCXTQ4qSrVVC+KjA/RWIX1XFj9DYijOSPyH
	p6buHIUxxkxniFizuSy2fpvf6Vv8oUngGjElP3iLL2xso+kM1xzX4dcvuQGAK1upcsrW/F
	MvV/ruhnkrgrvr7oj3QhXtruHYC/8YBBmw1lQajXOPA+wyxOtLGMIgot5AYgP6zNDIPu/o
	rr8pmQHPxVf5HTPdYT07N7l97D/iNfO+yXnrwcaS/OVJ8JZQt5ilr2i8S1INtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723046261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHX3b7rcMUHBsGLoSF7J1KsjokwlF2RkXxN8vtgWpCM=;
	b=fn0vvCEK9UIzG/sqCieRakUJVbbBw7X6AfvFu6SYfVMquKuziEQMFt2SfG9mDEHD7NIEXP
	YsLyNQeLZHvgo8Bw==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <87a5ho4hb6.ffs@tglx>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx> <2eb39a8f-cc58-4774-836c-e6293300a4d9@gmail.com>
 <87a5ho4hb6.ffs@tglx>
Date: Wed, 07 Aug 2024 17:57:40 +0200
Message-ID: <87r0b02umj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matti!

On Wed, Aug 07 2024 at 15:02, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 14:51, Matti Vaittinen wrote:
>> Hence I'd rather learn from a small explanation (what is the 
>> expected .size) than by fixing this after I see regression reports from 
>> real users of the irq_domain_create_legacy() :)
>
> So the size of the domain is sum of the parameters @size and
> @first_hwirq. That's so that the hardware interrupt is zero indexed for
> an array based lookup.
>
> The association obviously wants only the @size parameter because that's
> what the caller wants interrupts for as it obviously can't provide
> interrupts below @first_hwirq.

For more background.

The legacy domain is for configurations which have fixed interrupt
numbers either in general or for parts of the interrupt space.

The trivial case is that there is a single interrupt domain with
interrupt numbers from 0 to $MAX.

But there are cases which have the interrupt space devided into chunks:

hwirq	virq        domain
0-15    0-15        A
16-31   16-31       B
...

To support such configurations in the irq domain world, the legacy
domain was added. Similar to that is the simple domain which allows the
caller to specify a linux interrupt number from which the domain should
start. See

1bc04f2cf8c2 ("irq_domain: Add support for base irq and hwirq in legacy mappings")
781d0f46d81e ("irq_domain: Standardise legacy/linear domain selection")

for further enlightment.

Thanks,

        tglx


