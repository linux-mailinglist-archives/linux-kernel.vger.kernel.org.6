Return-Path: <linux-kernel+bounces-312694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F699699EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A0E2836DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E0619F431;
	Tue,  3 Sep 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1c1pdGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ViFdWnou"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3861A0BC7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358692; cv=none; b=Wb/YqdKABolccEtmQTwDFSkaVaMwZghOXz0ybkBBluYWCSsS8K1/spORB6eVOOYvqFwblU8FGTzu10sEJTSgat+Cco/xAzkIux6ERgdRLSuLCveQ/sCoNJR78LJWgd54VaO/934WGGTyvHY4SggyVpt7lev70UsVzIOQ5OoN8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358692; c=relaxed/simple;
	bh=7LcEoF3vhZ6dRAERtO8hx1+eK9KYSjJmLzlz8yKLUwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2OFh3xUJYk7TtcTz1d7q2+cDAQS+Pde0tRo4ADUxOh56/uK/77KlqidoaLPpWJkHX8dAvCTl9mKwO+iVyTxRGNlpQkfB7FMIyjMqLFFmrNtjRUX10cRoGDIvXf5+MsnUnMcZVbXMZb1HgMg2yPm5ykLHzkbs85XnpvuDVlq3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1c1pdGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ViFdWnou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725358689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNVIqcDLxz61SVBVBrBMf8gNYwUrcDD4lBZuIAOFBsw=;
	b=m1c1pdGKmmiKr/nLNpMHM2+cMw0nCX5sG87ZuQlHfIGpPiwWmWjim2UljimOqZ06o3xZSt
	hTWT5fIlZYPYksZqvK8XQuSocfSqiZY3EkPH3Rc7KhgZ0e+4oe6HaJntdXUpdj5Y5TtfHO
	s9ax7XmDK+U256hCDzkHhzOpfBTeNuHFuXHWgvswF8Lk/oJJTHtHQC8tprF2jjJJHYa6GG
	A3WPunWHX++BTFv3oftzxCyz+f/+7yiQF0/ZwWqLspm7IH5t5BojqSZu4YB2i0iY4UCS/v
	4bAi3XtDQFWlPdnHJQftOYKw1VGlhZjGjbtyxuT6A1N5XlcJkgkmxov1cxs/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725358689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNVIqcDLxz61SVBVBrBMf8gNYwUrcDD4lBZuIAOFBsw=;
	b=ViFdWnouOKy9ULcbcnaH/vJcYEV5dl8YNUnR9/1pmq4YsWPeCDf8gxrFb42g8s/XuCmeod
	T/c51yb5MdDdSSCg==
To: Richard Clark <richard.xnu.clark@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
In-Reply-To: <ZtbA5Adh2acTExYq@den-build>
References: <ZtUuYXSq8g2Mphuq@den-build> <87r0a27blv.ffs@tglx>
 <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
 <877cbu7596.ffs@tglx>
 <CAJNi4rPooS82fB+6FditywXTga00JbGoFM6MR8P7U3s7mdbJCg@mail.gmail.com>
 <87y14a5dcq.ffs@tglx> <ZtbA5Adh2acTExYq@den-build>
Date: Tue, 03 Sep 2024 12:18:08 +0200
Message-ID: <87frqh82hr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Richard!

On Tue, Sep 03 2024 at 15:55, Richard Clark wrote:
> On Mon, Sep 02, 2024 at 04:39:33PM +0200, Thomas Gleixner wrote:
>> So the mapping and the interrupt allocation persist even if nothing uses
>> them. What a waste.
>>
> I checked the code and found that it's not the kernel to create the mapping,
> it's by the driver calling platform_get_irq(...)/of_irq_get(...) to
> create.

:)
 
> Ah, the mapping is created from of_irq_get(...) by driver, the kernel also
> provides the mapping teardown interface - irq_dispose_mapping.
> IMO, the right way for the driver is:
> 	1) driver calls of_irq_get() to get the irq and create the mapping
> 	2) driver *should* call irq_dispose_mapping() as the teardown of step 1.
> 	3) free_irq is the teardown of the request_irq to free the irq and
> 	   its action.

Correct.

Thanks,

        tglx

