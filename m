Return-Path: <linux-kernel+bounces-385982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905439B3DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B361B21896
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC71DE2DB;
	Mon, 28 Oct 2024 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwXTf0nK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hljkOoDJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1518FDC2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154836; cv=none; b=nYj03z8SSSraJATwX90IbAQ+EkqoaFhm3k31hzWCjAqGfMoAUhvOJKGdHiDbaDtBhjAEVcMtxeziByRAmli5ScwYfyWKPIBquxs/zYdQVi+HZuBnkf2XrPEWeBLkJWEjb3+0qj1QbQa6Bkh2OCzyPkiuw6/iJm08AGtktfhJpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154836; c=relaxed/simple;
	bh=6/OWvlMLqJtRP1LVF+QMNpyPimpbHt9iHR3SAFNwbNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JX4hmeUYQ4atALw6JSXlR/F0k3qUvlMrwposfW4rOlPuBz0KMyPUMhlhCSwEb5eFzIQJsJhWoxxKRa1kwlhF9W0XwrzGf7FdN1+KQdHGQ0lFeq1Tzt18514LdzOMGLgYI9IbZMngFJYznEwAWoEBLGu2TWaJmsEMy1n4q1axCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwXTf0nK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hljkOoDJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730154832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZA8azp+Qe+q0dHqI2INMcT9e7W1NVWI9C+ay3F+StI=;
	b=pwXTf0nKt982axzcI1qCGWAd8WWUvGZ4+q/4TpL/eG/3jE+fAXDAyGng1rd0/oKZo08xXL
	6HGVNCGl5lEyc9eDylUqX+S/otxEnjSgAqSpVNcnok/0uZnmJEsnjlFRhaMFnxzYDScju+
	sjaTE1C6mvvqXZSJ3jtzJ1+k6b90p2Nib1kT721P4CFXq5y/zegkn9v8sG/1ea2wvUD2+6
	n0xwXkwKfEaq4eAdZf+yiCiYgJbjoypdXCyq4Skx2A0NdvJi045cRhxi1SwPqPNZeP3b6v
	jgJxjUZ2nh15lhxucdgcYE1HUEN4qZiZGm6+jw5yXLbZaKoaumA19MJGsu7bZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730154832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZA8azp+Qe+q0dHqI2INMcT9e7W1NVWI9C+ay3F+StI=;
	b=hljkOoDJj+m6q8c7nqmthMPIt7udzcHU5DyrLC+HbuePUPZds8jNzw9BjcYnpLHmGCKIdU
	plM8jzanKrNC3HBQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nam Cao <namcao@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] sched/idle: Switch to use hrtimer_setup_on_stack()
In-Reply-To: <20241028105850.GP9767@noisy.programming.kicks-ass.net>
References: <cover.1729864615.git.namcao@linutronix.de>
 <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>
 <20241028090927.GI9767@noisy.programming.kicks-ass.net>
 <871q004i2j.ffs@tglx>
 <20241028105850.GP9767@noisy.programming.kicks-ass.net>
Date: Mon, 28 Oct 2024 23:33:52 +0100
Message-ID: <87frof26y7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 11:58, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 11:50:44AM +0100, Thomas Gleixner wrote:
>> > Do NOT send partial series. How the hell am I supposed to review things
>> > if I don't even get to see the implementation of things,eh?
>> 
>> Can you tone down a bit? This was an oversight and I did not notice when
>> going over it. The full thread is in your LKML inbox, so can you just
>> move on?
>
> *sigh*.. how am I supposed to know it's an over-sight? Some people are
> actively pushing for this broken arse 'model' of posting.
>
> Yes, I can dig out the remaining patches, but that's more work for me.
> As you well know, I don't really need more work.

Nobody needs more work. But as we (as a community) can't agree on how to
post a 150+ patch series with a potential cc list of 200+ people and a
gazillion of mailing lists, there are only a few options left. And yes,
any model will annoy some people...

You at least got the cover letter, no?

I'm tired of posting a "Add new API/infrastructure" patch and then
finally 5 years later having the last newly added offender converted
over. I rather inflict the pain once, but obviously there is no way to
please everyone.

> I suppose I'll see a new posting eventually or not, who knows.

I'm happy to personally bounce you the pile if you insist or
alternatively annoy everyone with a resend of the full glory as well.

Not sure what that buys, but one thing is sure that we both wasted 10
times more time debating this nonsense than what it would have cost you
to look at the full mail thread which is in your LKML folder anyway.

Seriously?

Thanks,

        tglx






