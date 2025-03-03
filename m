Return-Path: <linux-kernel+bounces-542770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49324A4CD75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FBD173DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE01F03D2;
	Mon,  3 Mar 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GO/aIZs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysDSCxIQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3BCA5E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037072; cv=none; b=sbnu8lyimTDVpikOlhxNy2tU35bYmfSTFpV/OfXwO+evXX0JXnsy8Vd94n7IctOZTlgoXkcBlw5BG8fMev8KZzfeNuh2uZTFYmeTTLHRXibJsJos/7BhNEFvtR/CYnc4Hgs0PZvaOBar0Fsvb4IilsBFMjUHZML0CIgMMXpk2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037072; c=relaxed/simple;
	bh=lYXZn2jvFKTTOVMwmNpOIApTh0LKE5mP/65cAYYl5qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnRKk8Lx8OUbFyAxdl2RNHCXYZLKixOosZhcFGyJovqqg0+3WkFgnZw96wGUKwZPJ8uF+fvKp7a5fAZGwt1daR9458Ce8j2J5f91uR2ljcVAz1wNP7tjX+GefiE5iFE/2dOlc+fMJoYUGM8d/peX+46BTvmcc4p6qtcBQC5ES9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GO/aIZs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysDSCxIQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741037069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCamc7Ox3+bIS7tdET+rNZ6nSPMTFdyhNAYb66sxSHg=;
	b=GO/aIZs1x5Z3NkcQ6QHANlNBFdBvrKWzQHuRAFTba2MM3HyRtuQUvY09Eppkkxx03MUnh2
	6g32MOHVG3j+NmYnD0+nBjDb7fuG0vULLNY0qhweACXJAzGeKHZ9sR+ndqyBJrvW5b7T6J
	D/fRZ25qUaAdKmx0pZUWT9pVdNDXzBDEjzgrJ5W3ois+1CDYVy+JVc/AKpQLNlgBny5yuI
	Ntp46kWazLJeP9g+b6Ln9SxxL7yvwNI4fm1iH6vIAMDhBe7Vj94OQgh9fO4Hj+nxXvf+cy
	ItE43/iLrLMXLgvJjbFDuvj7FyraiTktd002grmRO6bwuXdX/Ag1zxgp9lKH3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741037069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCamc7Ox3+bIS7tdET+rNZ6nSPMTFdyhNAYb66sxSHg=;
	b=ysDSCxIQ2lxQMXe4JuE8LS/scaRshoIdoj/dgpqAzNgEdzW7/Wb/X7p6qwIub1Hl+wfkhl
	E5SjFdSVE56M+GCQ==
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
In-Reply-To: <Z8YPQn0UpxucZLJP@grain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.543399558@linutronix.de> <Z8YPQn0UpxucZLJP@grain>
Date: Mon, 03 Mar 2025 22:24:28 +0100
Message-ID: <87sentbyer.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 03 2025 at 23:21, Cyrill Gorcunov wrote:
> On Sun, Mar 02, 2025 at 08:36:59PM +0100, Thomas Gleixner wrote:
>>  static int posix_timer_add(struct k_itimer *timer)
>>  {
> ...
>> +	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
>
> Hi, Thomas! This moment slightly confusing -- are we allowed to declare
> type inside 'for' statement? (c99 allows, just never seen it before inside
> the kernel code).

We're slowly moving towards scope based variables. It's not widely used
yet, but it's coming along.

> Not a big deal though, thanks a huge for fixing this problem with
> timers and criu.

Welcome. Some quick validation with CRIU would be appreciated.

Thanks,

        tglx

