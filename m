Return-Path: <linux-kernel+bounces-426633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292C9DF5DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FEE281A80
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C831D1E63;
	Sun,  1 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ey+YIPgZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GD5LQ7KS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8471D151C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060976; cv=none; b=Kr2saYzgvwjYy3/RJV4oQMGFH6DBrNuqDr10J+8BfGinxptJMu9FWanGeOBtzHcTV/eFRd/V6wtkabeho1L7NwP2g8TdmL25CW8TrM0XPdzK7pn3OJOzfUhvVs8iQq9bTLROqTVoORgYjZLi/d9Jif0O1/u2MyqZELPm5ijTjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060976; c=relaxed/simple;
	bh=36ZrdaPh8g60/A8AB9clQTa/734ji2fJsJvyjYkm6A8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IzTz1tYEvYdYCxm2YQF/N+01Btle5D7ZCTE4C43UQ2GMmHJtDFokpxwoEYuNtlAOr5cU8jxllXpBpFjMfd1rL76+48LXjegB5fAg8ugWr3EgmCPyTpdCAVguZHPZhrMyDS9S/TWzwnU6QxfKYyE1iFPuKZ2BAo34jALlv/bz7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ey+YIPgZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GD5LQ7KS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733060972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLD2x/ibgZuizBObR+khuTfOy8eDSTEoKLl10c8njAo=;
	b=ey+YIPgZXVWHAPKTwFOqolw4sehC0/uHgPoCpDkPmurgZHvOgnIJyA/Sq6CEwkC7kIMyIS
	YpB8aLZF389ZefbVEsqzJw4JQv8munGY/VpHerfHrPWGvKNA0WD+aVy1TsySGuZON4LryY
	G5Mx06HoZHdd7FxsCb2YuRYldKQehsFdEqWWbQuDEdM2a+2E5MTN/GA9oUHEWV/jfgULpv
	5agxXjCQY2wamR5UkRHeSYeomJOfcm+zzMGBDZXQd5d2E52B15U0YSNk2hDqINbSyanDpm
	TX6zu2+W5b+hd0R3GhosfVZhoJrN2MoyxR73/Jsris/WNud4ssm9tNhasy0GVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733060972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLD2x/ibgZuizBObR+khuTfOy8eDSTEoKLl10c8njAo=;
	b=GD5LQ7KSYzh9zc5e4N1XZJVLgCbPF7PdNu/jRBrQrOeoY6BAunKAODFJJGMA+WqYP2KhDu
	K3Mlc8TUe+Ut3NDQ==
To: "Fernando F. Mancera" <ffmancera@riseup.net>, Ingo Molnar
 <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND] x86/cpu/topology: remove limit of CPUs due to
 noapic on x86_64
In-Reply-To: <8e7f8783-5745-46fd-9a95-a5ed36065f77@riseup.net>
References: <20241124174510.2561-1-ffmancera@riseup.net>
 <Z0Q3ZNoQsoiCAiiA@gmail.com>
 <8e7f8783-5745-46fd-9a95-a5ed36065f77@riseup.net>
Date: Sun, 01 Dec 2024 14:49:32 +0100
Message-ID: <87wmgjv7gz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 25 2024 at 16:13, Fernando F. Mancera wrote:
> On 25/11/2024 09:37, Ingo Molnar wrote:
>> So what's the motivation? Arguably the x86-64 boot option behavior was
>> weird: a working local APIC is very much needed to have an SMP system.
>> 
>
> Sorry if I am wrong here but I am not an expert on the matter. I 
> believed that "noapic" disables I/O APIC which handles external 
> interrupts while the local APICs are still enabled as they are managed 
> by "nolapic". If that is the case, SMP should still be possible.
>
> If both I/O APIC and Local APICs are disabled then the kernel should 
> fallback to a single CPU mode. That is the behavior that kernel has with 
> my patch.
>
> The motivation is to fix multiple users with systems that requires 
> "noapic" to work and after the rework their systems are using a single CPU.

Sorry, my bad. I messed up the "noapic" option handling.



