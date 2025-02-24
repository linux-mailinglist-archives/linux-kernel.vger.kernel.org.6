Return-Path: <linux-kernel+bounces-529951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7998A42CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA2B7A3393
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C391204C30;
	Mon, 24 Feb 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw5Tv01n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9xdi3MC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8F2B9BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425934; cv=none; b=Z52pm12uCBSybKUleHKByV8AVDcmXRDYJYZFk5a8GP7vdLMtf7rcsKWICFInEKbJlhhTFoVxXLPPI+TDnwca/YoITXzPQ6vxUBjib3eg1XwDITcx61TwidgcgiXUKuU6xBH65vc8qymMHjCpbbonIt3DvVM1H7XCV/7u5fcrF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425934; c=relaxed/simple;
	bh=Y3kxFDFlW7Ggyq4o0bfhkXAx4e4gs/s2asK2+3IX/NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9l+Hmu99LqkhI02kBEaYSTC50T0H/bihoA0XksfvSXijw315sbBCeHxJxsx4+c14/1U4Ltjjr7VtJv+moh/02iRrXyYGym56QZMLfM1S1EarZQKqZIzhiO47pdfkeumH5S0HZZWlHRTZTCpDo4hpHrJks9AA5qVcT2qDV5t0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nw5Tv01n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9xdi3MC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740425931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmduyFz+15osV+0lShB9kFpmXf7Nt0e9sq4QMn8YHlU=;
	b=nw5Tv01n+x/uPyds1DYMECFYm7oz5LhYJTkabQyDN5Qc6l0XqtBapg8YHz1orohgqjSVJu
	TddaGnG4nWGQYrWroDds7ZkUt6JU7HOkkw3nyVHVWZC+ntPOW5Y2gCveiSbKyC5RSNSxiy
	2Owhjp2XrIjBtWvHnYyfxvKAkFBnoDWVUG5+okovtNzjxiEJiQBx7JLI8mqYG3saU1v6nK
	p3DqfqAsEliO6NdyZh1mbxIP/N6kpt1znwYt9a7okYfvXdX3LvgCQ8zremZlzFh6Kx/enP
	IcDndOn+aNnp0689Qj64Hh61CCbv6PaRb6viE1aRKnN3RM0Mlbdu2Sh/sJnMYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740425931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmduyFz+15osV+0lShB9kFpmXf7Nt0e9sq4QMn8YHlU=;
	b=K9xdi3MC3AQJaPUR/uxMRVGL6hNgZC0D95bG5HGnooIXLEpc24oUvURNjKYaBS3hfaX5Pc
	/koKrLU5ECc6tZAg==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>
Subject: Re: [patch 06/11] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
In-Reply-To: <20250224132047.GA34233@noisy.programming.kicks-ass.net>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.344168498@linutronix.de>
 <20250224132047.GA34233@noisy.programming.kicks-ass.net>
Date: Mon, 24 Feb 2025 20:38:50 +0100
Message-ID: <87plj7f7zp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 14:20, Peter Zijlstra wrote:
> On Mon, Feb 24, 2025 at 11:15:32AM +0100, Thomas Gleixner wrote:
>
>> +		unsigned int id = (atomic_inc_return(&sig->next_posix_timer_id) - 1) & INT_MAX;
>
> How about:
>
> 	unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;

Duh. Yes.

