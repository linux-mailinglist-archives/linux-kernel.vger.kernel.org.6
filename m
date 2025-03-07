Return-Path: <linux-kernel+bounces-552094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5661A575B2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A55D3AA8BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7699258CE9;
	Fri,  7 Mar 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf17KF7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DA1EBFE6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388628; cv=none; b=Fb4QVOoykQV43D2jbrf7ACej7QG3nN0j2ELmCAbbLQm4G5U9hzJHroFCwLSoBQ/nF2eFVvb6JFsSdhwxR3aGBQvthlieR/Z0hmF1+MkpYXv9y+7tlMhQ4/KDIEQhsPqDFuJ9FMSAdu5lRjbLLvjRiv7rWR6Vp652FJ2m+/n8rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388628; c=relaxed/simple;
	bh=eOeoPHHhOecDDOaLcxlv3LqvTCf2AZDIMmiBVHjkJ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt29RcUAt5ZIbQq4pB8UIiFckvPjAJq1UIpg3qv0wWQsW8QUmkZ3WYAZ8fvRUMfd0+EuisiAEFMGpIsAHRNULkfTBCzUQ9hfkhuNy+kZBnImd4A4kmZZ0HDV7dBZeZW0Wfd/t2uDJuPX2xdoLZGSLxUeyFDwOE+BVUMcqB4DAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf17KF7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F571C4CEE5;
	Fri,  7 Mar 2025 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388627;
	bh=eOeoPHHhOecDDOaLcxlv3LqvTCf2AZDIMmiBVHjkJ10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kf17KF7cfebveOhha6ljUmsdmxK7riPcLcAxEbmN9dErUst1LwSQZWgBiMmFeUmJP
	 Zrtca0saI2d2cDaZGu2P2SWBTLRRUgVPcUVk4UdTRzkenOLZje58+F6YUzWSdxiPxQ
	 CwkklJ1axuRDVVIub/yL8tBy1gUOtftIrqUPRtO4lvkKqwPubwacLYhdEYKWynUQfs
	 FGGpezoPDbtRKwKI1BU+5LHkXaylxs7l/1aLlbBVfTFcdRg6Fa+oWfsguaYoAryra8
	 nPau4YIY0FfmhiYrsw/BXBtpRW9i48iYaBl1j4fTkia8URDOlExnumouV7gVpcrjAi
	 Jr2PQ3ZMHbziA==
Date: Sat, 8 Mar 2025 00:03:44 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
Message-ID: <Z8t7UJUd9SLT0Ytj@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.416552300@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:56PM +0100, Thomas Gleixner a écrit :
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -240,6 +240,13 @@ static inline void posixtimer_sigqueue_p
>  
>  	posixtimer_putref(tmr);
>  }
> +
> +static inline bool posixtimer_valid(const struct k_itimer *timer)
> +{
> +	unsigned long val = (unsigned long)timer->it_signal;
> +
> +	return !(val & 0x1UL);
> +}
>  #else  /* CONFIG_POSIX_TIMERS */
>  static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
>  static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore
>  	 * from a non-periodic timer, then just drop the reference
>  	 * count. Otherwise queue it on the ignored list.
>  	 */
> -	if (tmr->it_signal && tmr->it_sig_periodic)
> +	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
>  		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
>  	else
>  		posixtimer_putref(tmr);
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(
>  	 * since the signal was queued. In either case, don't rearm and
>  	 * drop the signal.
>  	 */
> -	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
> +	if (timr->it_signal_seq != timr->it_sigqueue_seq || !posixtimer_valid(timr))

Hmm, should it still warn here? ie: WARN_ON_ONCE(!posixtimer_valid(timr)) ?

Thanks.

