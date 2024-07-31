Return-Path: <linux-kernel+bounces-269617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A89434E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D13328B340
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF52288B1;
	Wed, 31 Jul 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QyscAsDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lplMER6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919051396
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446355; cv=none; b=r1dAzW1XpgdQGbIULUrsl1e6I6rNYA97rRSo0M+/1lGZlfJJfIqehI3RLEuioIuPUY4vlimHkrZcvliwvFhQqpUerd9n9luZELTod0PsPJq7H/WJyEK3ALB5KVh0jS/sSTvSojMXGhHDfNl6ME21SaDNpZx4ObfrsxY969X6Av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446355; c=relaxed/simple;
	bh=aAYN4XVdY/xXNWoLzErd5v6Ghdi1P37i1NcaBiVxXcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRjHaXtGqtw3C+akaz9khDdPc15aSMX7whP9CaH1hWbDBSVLSNu/oLnUSO2hE1u31HQK08OjUn38zDj7U0UHbrkCh5uCA2/X0WVEcyZYH6lR5ZM88NoUlOP0KokH/6JzLeOIEb3ydoKLXzVEl8709zaMnOWTUnUNbV+fk6AFnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QyscAsDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lplMER6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722446351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qnz9Y9f7dtpMbGVd6K7R/Ho2G6jnfASeqd/f3clPPM=;
	b=QyscAsDYYsrH6OF3Xd1NwqUyULaXB/JyVm1ZV7BRXTKetBwpJJsOryRvIHVhtsFKfWrMO0
	MGIOv+lzzEOsNdYjpay78fOpSwHaNDZIj67OYdlnDiaeWiGnrOM0tPUc42hpsX9uuHHWvP
	+KzvI9DuXMECOfgob8r1gsQKsIys6KcBJ431XbxSKBzRG+kdA9I/C9XAZjqO0gprfSRzWp
	eWhdzv7PtNhWMfG69PeX+n4Dlb5+iQXzZlZCRuPHTCJP9ZXf6TQBVdCKmwa9EaHUEqd6WS
	3lb1rfEIY37GLWfUACK36yFnSQoZexnMkty4biJiYlJNIYYiirAq6Odu0cOhGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722446351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qnz9Y9f7dtpMbGVd6K7R/Ho2G6jnfASeqd/f3clPPM=;
	b=3lplMER6zbp7wkr2InJBxfWZor5GAKz2TbWLkjdxYWR2yeqG8SfIzj2gWTQXQ8fZm9xSho
	a+pyb7/6BbGtehDw==
To: Guenter Roeck <linux@roeck-us.net>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andy Lutomirski <luto@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers
 <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
In-Reply-To: <e15a45c4-77a0-4eec-84b3-d09ba1e8b681@roeck-us.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <e15a45c4-77a0-4eec-84b3-d09ba1e8b681@roeck-us.net>
Date: Wed, 31 Jul 2024 19:19:11 +0200
Message-ID: <87ed795vjk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 09:49, Guenter Roeck wrote:
> On 7/31/24 09:17, Linus Torvalds wrote:
> I guess there is at least one user - me with my annoying boot tests ;-).
>
> But seriously the question is: How likely is it for that code to find
> potential problems in the 64-bit code ? pti_clone_pgtable() doesn't
> seem to be 32-bit specific.

64-bit does not have the problem because everything is PMD aligned.

Thanks,

        tglx

