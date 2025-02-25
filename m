Return-Path: <linux-kernel+bounces-532506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A8A44EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C123A3777
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87920C002;
	Tue, 25 Feb 2025 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7TxPtds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665419CD1E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518531; cv=none; b=WTNHqCwLB/nSDOcy8ZIDX9lwchoIcB0FV8Y07dkXdN6/jjlKPNKGQDTJJ1HmwubTazeYID0dz5ZphtiLq9/os6JJXQBXI/6FAf/A4C10/+fBt7uO8yeSRRQFHPkOLxD18HeDJBukfL6rrvFTnXbgbhFCSz50OM8VXZv8iQixMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518531; c=relaxed/simple;
	bh=+Ec/mIumHeFLdpNxbtqhH8+wRQITguW0MhsTNczarSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7IHZ+IPl0Wlz2eRsyaJ7Hzhj4zNnKwpdpJeXM0TfZCWuX1XCPL/6sInduypB6dRxZ5/IyH1f39SYbGB75rYrFNVN7WKpu0hjex7shjtRHtsBjN5QRjzXUe1zk4anJHKPaENwNYoX1cosuKvgrta/tZzf4mq8XJb9f1nf1mOOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7TxPtds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D698C4CEDD;
	Tue, 25 Feb 2025 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740518530;
	bh=+Ec/mIumHeFLdpNxbtqhH8+wRQITguW0MhsTNczarSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7TxPtdsqV6RaGWaDfcEFywZSggTYbaYbm81jgOD5UIUCHb4T1D3mIqJ/aoNWya9L
	 hyQhVewSJWkLVJMvxlAeGJIek7GR+9MEOPaw7Mgs17norTfOCdzTyMjvfsSWfs0Kqv
	 XbdrP0fI1kskWDcFKmd+Bhl7DJKtx51izjwWDPcBQueTue/5AKIQlvDaFB2oxHDibp
	 zYHRPeraGkAt6u0H6ztKlU/gwm7h0Zj2mLpM7YRv2atKxdJhsqiZ2r+RLUu28VRB/F
	 qDh7tS9mf5o9ssfi9h2qG/eP+qJYtHUjK2NXv1K/k4nPncbWwcgelnXtRs2gqVoS4c
	 Eu3d+tDQ4OnWA==
Date: Tue, 25 Feb 2025 22:22:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yujun Dong <yujundong@pascal-lab.net>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle, sched: Use smp_mb__after_atomic() in
 current_clr_polling()
Message-ID: <Z740eIZcK31DQETq@gmail.com>
References: <20241230141624.155356-1-yujundong@pascal-lab.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230141624.155356-1-yujundong@pascal-lab.net>


[ Sorry about the belated reply, found this in my TODO pile ... ]

* Yujun Dong <yujundong@pascal-lab.net> wrote:

> In architectures that use the polling bit, current_clr_polling() employs
> smp_mb() to ensure that the clearing of the polling bit is visible to
> other cores before checking TIF_NEED_RESCHED.
> 
> However, smp_mb() can be costly. Given that clear_bit() is an atomic
> operation, replacing smp_mb() with smp_mb__after_atomic() is appropriate.
> 
> Many architectures implement smp_mb__after_atomic() as a lighter-weight
> barrier compared to smp_mb(), leading to performance improvements.
> For instance, on x86, smp_mb__after_atomic() is a no-op. This change
> eliminates a smp_mb() instruction in the cpuidle wake-up path, saving
> several CPU cycles and thereby reducing wake-up latency.
> 
> Architectures that do not use the polling bit will retain the original
> smp_mb() behavior to ensure that existing dependencies remain unaffected.
> 
> Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
> ---
>  include/linux/sched/idle.h | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index e670ac282333..439f6029d3b9 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -79,6 +79,21 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
>  	return unlikely(tif_need_resched());
>  }
>  
> +static __always_inline void current_clr_polling(void)
> +{
> +	__current_clr_polling();
> +
> +	/*
> +	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
> +	 * Once the bit is cleared, we'll get IPIs with every new
> +	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
> +	 * fold.
> +	 */
> +	smp_mb__after_atomic(); /* paired with resched_curr() */
> +
> +	preempt_fold_need_resched();
> +}
> +
>  #else
>  static inline void __current_set_polling(void) { }
>  static inline void __current_clr_polling(void) { }
> @@ -91,21 +106,15 @@ static inline bool __must_check current_clr_polling_and_test(void)
>  {
>  	return unlikely(tif_need_resched());
>  }
> -#endif
>  
>  static __always_inline void current_clr_polling(void)
>  {
>  	__current_clr_polling();
>  
> -	/*
> -	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
> -	 * Once the bit is cleared, we'll get IPIs with every new
> -	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
> -	 * fold.
> -	 */
>  	smp_mb(); /* paired with resched_curr() */

So this part is weird: you remove the comment that justifies the 
smp_mb(), but you leave the smp_mb() in place. Why?

Thanks,

	Ingo

