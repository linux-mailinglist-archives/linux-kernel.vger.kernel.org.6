Return-Path: <linux-kernel+bounces-323036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88129736D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD7F1C21954
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138818E77F;
	Tue, 10 Sep 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UpS3L5it";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mhGF989X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81913E02D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970095; cv=none; b=Xa5nfUyfXTLzzQBwQJWNaAtGDlABMJxtnJ5VIQ0L/JHWkqoOBljC9nrzYjocdfr3CYyx23Q6z8bReK3yp+tWDXe+svsH+xKrptReuPn4gWi0owzDekfJACPykdVtfmmOr+tVk6f+D/ZCuCJoERS8sSif4Trmb3lOPOSjjI1gHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970095; c=relaxed/simple;
	bh=SUZiDYo+wwH+LR6214S9hPkh/BeHJyKncgcFhNIbcQ0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qP/DTRzApW/eShmc4zAxuHDT+on/MhE2AfhiinYzEbt0DSPvAqFMGkQ0NgYsrlFRoC00M/pkeFyuO33rENEi8kNq5G/RuEDDGVHSd2YPQaY/C5utt6hUxGtI4sHjXZa/wmrOXUo5ZT69xPezO5V/hxCMU7zV0m+msj+XBX2EAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UpS3L5it; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhGF989X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725970092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7P43lHWjwoqOkRD7UVjcgQmA5Kg8I85eFFrn2Nw7cc=;
	b=UpS3L5itt3YF6PtRWf6GZml2bfOYNWOQNoZJ4O3zlN358QByaRXYctZB1TqeFUlSZQBze8
	1JsF2mNOLIEYZz3NozTP2zRptq5Hr51tv6nLcX6TZZDYwzm6C/KjdVd7ZZuQK80frz3VuB
	J2tqSN+BtVuv1CHx1Syvt2ZVQ/2I875CdnO+QKyjpU7p+IgMXhYtAwskiZjBmb3ONwywc4
	Y9RaaBpnotxClj/rhD4l57qXVamgmrZo3AgWHPqE0R2NYM2WNwp/RU/DwXPDpXyou/iDi8
	ngbqXmhNAr3lsuY4SvL4hcwD9OD7Yd5QlN7psxsTlxrRv7eTZEL8dLqdqeCP6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725970092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7P43lHWjwoqOkRD7UVjcgQmA5Kg8I85eFFrn2Nw7cc=;
	b=mhGF989XwOWUR7cY/xapYeZ4QFECOQTiQVJ5wpfziQYM8SMMXjfL+ybui3VgdWfh1+6+6z
	C4o3NHIkzMO49xDw==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH tip] x86: vdso: Compute timens page offset statically
In-Reply-To: <Zt8XxiQrma1R2a70@zx2c4.com>
References: <20240906190655.2777023-1-Jason@zx2c4.com>
 <Zt8XxiQrma1R2a70@zx2c4.com>
Date: Tue, 10 Sep 2024 14:08:11 +0200
Message-ID: <8734m7btjo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 17:44, Jason A. Donenfeld wrote:
> On Fri, Sep 06, 2024 at 09:06:55PM +0200, Jason A. Donenfeld wrote:
>> The expression `((void *)&__timens_vdso_data - (void *)&__vdso_data)`
>> seems harmless, but it actually results in quite a bit of code and two
>> jumps, in a place that's supposed to be somewhat lean on code. The value
>> of that calculation is always 3*PAGE_SIZE, as it turns out. Changing it
>> to that results in a more modest cmov instruction being emitted. It also
>> makes it a bit more clear what's happening.
>> 
>> To accomplish this, define offset macros in vvar.h, which can be shared
>> by C code and by the linker script that decides where these pages will
>> actually go.
>
> I noticed we've only got a week left til the merge window opens, so I
> thought I should poke you about this, if you want to take this through
> tip. I can also take it through my random.git tree with your ack, if
> that's easier for you. (Assuming, of course, that this patch is actually
> correct.) Let me know.

It's not the end of the world if this does not go in now. It's in my
back log and that VDSO stuff needs more care than this particular thing
as the recent discussion about vdso random on other architectures show.

Thanks,

        tglx

