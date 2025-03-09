Return-Path: <linux-kernel+bounces-553415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6898CA58927
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914A2169E05
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E21B87D7;
	Sun,  9 Mar 2025 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLfifXPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4919CC33
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741562282; cv=none; b=OTkA+x5qXkedf9HRnJiSMvYr+MJP2gudYlwRbmgi++kUVyXVz365FHy57/B48z3SUWafiJ4fXg+RVNjbRNxEgPyXwUYHh+2AdyXMO1xGxIxOCB7YyxEsG+63N+8kQShTYdwt0PZJteTHCQbXewd+6Nps1AfkRoNGMAWJyzX+gSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741562282; c=relaxed/simple;
	bh=soNJeVMQhsiNYQOx6tSlRwotz/IUlzEQcyYV0CzqnC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQkO1DFzY8zrzrtMJHBpCdTPBX92BkRAdZHkn0WBszO4gyvdN/Da9wJPUiYSauezU8l1Y58YzourlprCMNGaY4OglZHJwJaZ+326ohNtw/G0Yok4n28ybiRo/5nEdpAfJBJDyZqjNb58k2py6ixV6fqkKrUGoL69xHg1elU5YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLfifXPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BECC4CEE3;
	Sun,  9 Mar 2025 23:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741562281;
	bh=soNJeVMQhsiNYQOx6tSlRwotz/IUlzEQcyYV0CzqnC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLfifXPF4ctKF/iohMGNNhYwJbI+IvPP03glhfeSXLYB9klFpDtc9VJmR2+8Y5gUj
	 uAsbOwPC6gxWlHjmBAr4Hcd5KtVxtncrtxyjYOfEVVpgZ+HWSc4KOhVSWr5HtuyTWV
	 JkrUD16SuDcZsYlt9KJnbobro1MM6kRhNpGFmmnPm84s3TXv1/Xl51yZp6MMvWxUOs
	 qiMO/fG2LbzoM1GyHXaLb7WOfJn3/QQ75Frpgs4blTaEGj2lYQ8UJiGU2AsSZFCDWU
	 55HMz+2lSoSuni0LQ9OYzeaRwrNRrj7AHRaT+woyPmYdk5yJrIjUrjbkfcfbAPXRI3
	 83EZuRMguFOdQ==
Date: Mon, 10 Mar 2025 00:17:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 09/18] posix-timers: Rework timer removal
Message-ID: <Z84hpurQ6Co2jqV1@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.024143438@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.024143438@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:32PM +0100, Thomas Gleixner a écrit :
> @@ -988,90 +988,56 @@ static inline void posix_timer_cleanup_i
>  	}
>  }
>  
> -/* Delete a POSIX.1b interval timer. */
> -SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
> +static void posix_timer_delete(struct k_itimer *timer)
>  {
> -	struct k_itimer *timer = lock_timer(timer_id);
> -
> -retry_delete:
> -	if (!timer)
> -		return -EINVAL;
> -
> -	/* Prevent signal delivery and rearming. */
> +	/*
> +	 * Invalidate the timer, remove it from the linked list and remove
> +	 * it from the ignored list if pending.
> +	 *
> +	 * The invalidation must be written with siglock held so that the
> +	 * signal code observes timer->it_valid == false in do_sigaction(),

I guess it_valid is a leftover from previous attempts?
Aside that and the lost WARN_ON in signal delivery:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

