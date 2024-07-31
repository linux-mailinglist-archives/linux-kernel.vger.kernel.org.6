Return-Path: <linux-kernel+bounces-269241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D0942FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2927328640A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65E1AD3E8;
	Wed, 31 Jul 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsLDmyOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJ2snDGR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FA18C91D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431016; cv=none; b=bRBMDcpER0Yc9ULz3RZARb9a46p8SbLnDFBHS8nYNIxCZHIK2HBnYag7J+nJ3TH9ptWkhF4z86L1pMJkc5K9FRy5kqeyD5acCLrwHsTxYOpYpavoDW/daIWDvh4ZD5YT75tU9xp0sCwZWDFR8djK5Mwa6MFXEFqD6XUVJwGvJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431016; c=relaxed/simple;
	bh=79hyaZgFhdopxddRiqdkvRWQuhhsTfFbnx3O/FqeIfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRTcOqjq8l9IuVL3sIKgHYLEiR98onRMDmoDz0dXZYiGuh2tZsWBif2kcXjpvKI9tiey7gsnlAUACJRGASQRO9nUzc12Jz1OLrXQH/m+9LX8b0wpcfvLJ1l0RjbbhNd9DDORiI9q2C4yY7blXXpFlHNlp4xoFlGEWZbMtbvqejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsLDmyOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJ2snDGR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722431013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOOomFVIWYDHnK5sKoYGUc1OYDmDH/5SUlMCKKeUUYQ=;
	b=zsLDmyOrayN+9jT91UPsblR/6XIhAU0WbEpVjjOVy2vhqW7juOQ8TykC85BFZK+Ij/BV1F
	K9m8oMZVMIdWuec011o+DqJecNgpNG5eU+4qOlcScRscFak9d+TD9dwys/5c3fW7HGiO+9
	Rj5EvQ2bNs09giBd9M89mqDQjxWmzbYqceFsDOEMtW9WJmrJRoeJC61b0f87hYhGZxO58h
	SFFoPI/xZ8/FEmirZlhGxnMsDA3JzjAzp58V2PKoyBKruMh/iiv604S8JbFEzkzY4odUe3
	72H/IjV6w1FXxkje0DAvm2ajXXVQVFcAslnWywPAgT2oTSnavJj1KYgMydTwyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722431013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOOomFVIWYDHnK5sKoYGUc1OYDmDH/5SUlMCKKeUUYQ=;
	b=FJ2snDGR4jQj3EVhV3yP6K4SPX64AA6IVQPkIvZo2DgHmrsl33qjlhVoJA1/gcVpM22pR+
	NTh5DrE2oekJMCDA==
To: Peter Zijlstra <peterz@infradead.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers
 <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
In-Reply-To: <20240731122002.GE33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
Date: Wed, 31 Jul 2024 15:03:33 +0200
Message-ID: <87mslx67dm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 14:20, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 01:24:34PM -0700, Guenter Roeck wrote:
>> An interesting bit of information: The problem is seen with many,
>> but not all CPUs. For example, I don't see it with athlon, n270, Dhyana,
>> or EPYC. qemu32 is affected, but qemu64 is fine. But on the other side
>> both kvm32 and kvm64 are affected.
>
> pti=off makes it go away, could be those CPU models don't have meltdown
> and as such don't enable PTI.

The AMD ones don't have meltdown and neither does n270 which is an
in-order atom.

Thanks,

        tglx

