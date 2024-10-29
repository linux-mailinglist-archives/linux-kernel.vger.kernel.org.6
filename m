Return-Path: <linux-kernel+bounces-386478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D099B43FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FFE1F236A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5464202F77;
	Tue, 29 Oct 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YR7pEPrM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5TwJJjYX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81805201027
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189743; cv=none; b=J0114hynqf/V7ebi0LKIhOPvjmG7afwzRwpKx0JCBw4IjrjCyrhMJNg06x4XqtyIAcDNKLlZYyQ/uCWqKRwmdKojBNEw6bx13eLV2Zypm5wL5Ez+f5U010uxtxlS3SAGoR6741EJXPXScKp5qXAvPlLpI8TtJW/gcZotXoNH884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189743; c=relaxed/simple;
	bh=2LoAkEMmMIOgT6dS27RLEXvKdBZnp7l3zPNbr0HyJLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lyuxk5rX4MAbtCDusVGA1/4nQ454lVQAVuVIRbexj06JMKIS9z3i5QUYC1yuasaqrGpCcoI9bknfTS+jq8sT59KlyxzSgsjFXjl9tQHguvSVLQO+TU/GMQcOd24pjqvSUXl0YxyTOsgr8nLk+w30cqAJHFNVpu46POhyenLeCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YR7pEPrM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5TwJJjYX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730189739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Chz53onyGXnawZI5oBTcPsbWgh0zf5233Unf5kXlAA=;
	b=YR7pEPrMrq9xxPt4AEXfGfH7PjFFDgHaddQCyg3umOtctRdxr/RJusiR3HJNLhdWYmwlpC
	1dXpiUxTrNDDh/wAqI28ZlZwgGyb56/IhifAt/S1E8iqkdP0Yf67mBxkENUkai3IvycNvM
	HFnMFF8dkrKng8/c/GtGN44dhCxlWCR/mXahIULhhcJ2p4VhhAAsEw9ivz9yOhN0vfDg1h
	8W3ZFGz4KmaPkgKtODJIhmI54jclHV86JzicPBea3yvA7RHyqdaBRa3d7puHawKimhPRF2
	LbFvka68yScaAOQ9hvWQ8oIAXxvKmSb4V1jgM5Qtr4lnitp6UALQLui7dg8J/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730189739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Chz53onyGXnawZI5oBTcPsbWgh0zf5233Unf5kXlAA=;
	b=5TwJJjYXsMYAwUAKrtmNB4n9EdPqWwgSXXJ5MxTar3zSew9N1IuO1xAxTXH61PCr6Ch5wN
	fG1/dMVvZ1CC4hBQ==
To: Sean Christopherson <seanjc@google.com>, Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org, Jani Nikula
 <jani.nikula@linux.intel.com>, intel-gfx@lists.freedesktop.org, Paolo
 Bonzini <pbonzini@redhat.com>, x86@kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Kalle Valo
 <kvalo@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
 <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz
 <jstultz@google.com>
Subject: Re: [PATCH 00/21] hrtimers: Switch to new hrtimer interface
 functions (1/5)
In-Reply-To: <Zx-2VV9rRnHOgtvG@google.com>
References: <cover.1729864615.git.namcao@linutronix.de>
 <Zx-2VV9rRnHOgtvG@google.com>
Date: Tue, 29 Oct 2024 09:15:39 +0100
Message-ID: <875xpb2ul0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 09:05, Sean Christopherson wrote:
> On Mon, Oct 28, 2024, Nam Cao wrote:
>> This is the first part of a 5-part series (split for convenience). All 5
>> parts are:
>> 
>> Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix.de
>> Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix.de
>> Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix.de
>> Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix.de
>> Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix.de
>
> How do y'all anticipate landing these patches?  Is the plan/desire to get acks
> from subsystems?  Land the new helpers and then let subsystems grab their relevant
> patches?  Option C?

Ideally I can just collect acks and route them through my tree. Last
time we did this helper first and subsystems grab it took ages and lots
of chasing to get it done.

Thanks,

        tglx

