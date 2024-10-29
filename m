Return-Path: <linux-kernel+bounces-386850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB29B489E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032AF283BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE44205138;
	Tue, 29 Oct 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpLCuFOC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3611EE014
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202586; cv=none; b=DkO6Y8jI/8k3Sswxo8PK2sWCRlvycx98P+K5tDF0Wk8qlZJxBxOgkFs8CJStYNntGbX7jX0TLz1DEwa7BntbiED5E8fN6pIplLqFNxsmlX59YKFTTiPccJUNYX/CvTYL+BUbz9HJu0N0icYIdV7klIQybVhI9i65LUWVTjNPIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202586; c=relaxed/simple;
	bh=5b7XxUdgn/9oRgKttvOGpLtfsNAWaF/FpVf58RYBQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlgKw0RIU2Ucmi7JjXUBhVxCZjRdbMJhOcm9HH0GJownmdPyhVVmq7ssIR4hcS3C4NutMTKAG95GoW2kQH/MMOgfrITXK2JHndVl+SmHHPo9dAeB+w+z7xgSReWV5RUYNtD7ZQSoDmybavY9OWEH8MCg6XYGlk2el/msaEyOuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HpLCuFOC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cAU3cKOmIcgayaZwMEuWmWzKdhGtdQEk6QwyUpbPf3w=; b=HpLCuFOCnHKxYMR5d+7lUYhXMR
	Im+IcicH1uY2neiedw0H2Mea8w2gu1sqO8JUUCqEcRN6t0vSdRJQ7Y2pNbvJe9qsO96r3vaBWhYLW
	NCOPJaec2Yj/zI2aJYsV8XE+zs1MjZ+6cekPI3CygWbrqp9garO0vPFi7NUpFlnPKl/w9de6rd0pg
	cqTidH6zdhmPB30HnOdW+yR8I7kg/kW7m79zK5Bu+hL4+Rv8aFXWYdnjdW8zMZP8A2SyYZQCXBtxZ
	QX9/UlCVl0n+GasRTYE4MiOOgEe776j8/w+Tr7EhUpVnDG2NXvZYBrfbbKraFD7I4E7Plgo6Bt16t
	a8Q/bGAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5kjB-00000009eiw-0XRn;
	Tue, 29 Oct 2024 11:49:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 478AF30073F; Tue, 29 Oct 2024 12:49:37 +0100 (CET)
Date: Tue, 29 Oct 2024 12:49:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
Message-ID: <20241029114937.GT14555@noisy.programming.kicks-ass.net>
References: <20241029083658.1096492-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029083658.1096492-1-elver@google.com>

On Tue, Oct 29, 2024 at 09:36:29AM +0100, Marco Elver wrote:
> Reviewing current raw_write_seqcount_latch() callers, the most common
> patterns involve only few memory accesses, either a single plain C
> assignment, or memcpy;

Then I assume you've encountered latch_tree_{insert,erase}() in your
travels, right?

Also, I note that update_clock_read_data() seems to do things
'backwards' and will completely elide your proposed annotation.

> therefore, the value of 8 memory accesses after
> raw_write_seqcount_latch() is chosen to (a) avoid most false positives,
> and (b) avoid excessive number of false negatives (due to inadvertently
> declaring most accesses in the proximity of update_fast_timekeeper() as
> "atomic").

The above latch'ed RB-trees can certainly exceed this magical number 8.

> Reported-by: Alexander Potapenko <glider@google.com>
> Tested-by: Alexander Potapenko <glider@google.com>
> Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/seqlock.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index fffeb754880f..e24cf144276e 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -614,6 +614,7 @@ typedef struct {
>   */
>  static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
>  {
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	/*
>  	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
>  	 * Due to the dependent load, a full smp_rmb() is not needed.
> @@ -631,6 +632,7 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
>  static __always_inline int
>  raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
>  {
> +	kcsan_atomic_next(0);
>  	smp_rmb();
>  	return unlikely(READ_ONCE(s->seqcount.sequence) != start);
>  }
> @@ -721,6 +723,13 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
>  	smp_wmb();	/* prior stores before incrementing "sequence" */
>  	s->seqcount.sequence++;
>  	smp_wmb();      /* increment "sequence" before following stores */
> +
> +	/*
> +	 * Latch writers do not have a well-defined critical section, but to
> +	 * avoid most false positives, at the cost of false negatives, assume
> +	 * the next few memory accesses belong to the latch writer.
> +	 */
> +	kcsan_atomic_next(8);
>  }

Given there are so very few latch users, would it make sense to
introduce a raw_write_seqcount_latch_end() callback that does
kcsan_atomic_next(0) ? -- or something along those lines? Then you won't
have to assume such a small number.

