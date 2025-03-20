Return-Path: <linux-kernel+bounces-569385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA40BA6A22E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2753B427AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D63214A74;
	Thu, 20 Mar 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgHIWwOB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97627213245
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461821; cv=none; b=qS2E6IGHu3J2dkEM1UiNnN7bEfGXn7dJIBHLS6UCtPObmdWD2SaI7Osa2nTVZ4euEmZbhTIdOpDwbLy6GKQdzGU+pvh9mpsyb4EmWQfj43M3adJvtjgwZhC7MS+NEaEymOrB38xJ803QmgpLV2E/6oTZ4vLjGW94T+husO8ZJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461821; c=relaxed/simple;
	bh=uHn4xfjqexMZEjTqz5MffRM+J5kHAkfgJsVmCYt8McY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvrYSNrCaz9F6Q3EqGC/lG2P88X+Sev8Kbs2MyCPc/3nuL7fkAVC8FwEPvcJH/hkdpg68oomIN2nCVtiJhmnUBGAoAylTTd2mZwiOqG8/ztlXpUI+8yfGXGnGuiXj6MEa/w/Q8ojTUQg99vpZIJ2HSbHjqrILYT68HVOIY5Y5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgHIWwOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B65C4CEDD;
	Thu, 20 Mar 2025 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461821;
	bh=uHn4xfjqexMZEjTqz5MffRM+J5kHAkfgJsVmCYt8McY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgHIWwOBKAgLUEhhRFDpG/FV4RFxhMYa0wWmK+a5WXm9HpEScO+RWNFcUa8PWC9VK
	 PNiZFZFJoY0spPLiSzX7eyL2HrdhJosP3ASwrfZmtCf15iFSHEqOVOL5yIBVE3Kfc1
	 GROUXEjBkL9xm1IDBFkrXF+iwb+Y1FqEf29ft9DNhJFlEn/Ke4dPeuRj02T17qUcsZ
	 dWyBTuAPOL9cbauCBfROZitGBHtr2KYdGMkWCEOfk6CceeW8OKKm1C7Jx0OGDrJEV4
	 6m8jSmPnSu2UTJmaLFRsVwr9Jj0mHfqqPMtSS0UTCCbFhtczUsJ1ra8Z17r2cq+Qxe
	 AFFFUrM7uoBjg==
Date: Thu, 20 Mar 2025 10:10:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yujun Dong <yujundong@pascal-lab.net>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH] cpuidle, sched: Use smp_mb__after_atomic() in
 current_clr_polling()
Message-ID: <Z9vbeZjG1H2WgKcv@gmail.com>
References: <Z740eIZcK31DQETq@gmail.com>
 <20250306164217.3028977-1-yujundong@pascal-lab.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306164217.3028977-1-yujundong@pascal-lab.net>


* Yujun Dong <yujundong@pascal-lab.net> wrote:

> Hi Ingo, 
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > [ Sorry about the belated reply, found this in my TODO pile ... ]
> >
> > * Yujun Dong <yujundong@pascal-lab.net> wrote:
> >
> >> In architectures that use the polling bit, current_clr_polling() employs
> >> smp_mb() to ensure that the clearing of the polling bit is visible to
> >> other cores before checking TIF_NEED_RESCHED.
> >>
> >> However, smp_mb() can be costly. Given that clear_bit() is an atomic
> >> operation, replacing smp_mb() with smp_mb__after_atomic() is appropriate.
> >>
> >> Many architectures implement smp_mb__after_atomic() as a lighter-weight
> >> barrier compared to smp_mb(), leading to performance improvements.
> >> For instance, on x86, smp_mb__after_atomic() is a no-op. This change
> >> eliminates a smp_mb() instruction in the cpuidle wake-up path, saving
> >> several CPU cycles and thereby reducing wake-up latency.
> >>
> >> Architectures that do not use the polling bit will retain the original
> >> smp_mb() behavior to ensure that existing dependencies remain unaffected.
> >>
> >> Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
> >> ---
> >>  include/linux/sched/idle.h | 23 ++++++++++++++++-------
> >>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> >> index e670ac282333..439f6029d3b9 100644
> >> --- a/include/linux/sched/idle.h
> >> +++ b/include/linux/sched/idle.h
> >> @@ -79,6 +79,21 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
> >>  	return unlikely(tif_need_resched());
> >>  }
> >>  
> >> +static __always_inline void current_clr_polling(void)
> >> +{
> >> +	__current_clr_polling();
> >> +
> >> +	/*
> >> +	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
> >> +	 * Once the bit is cleared, we'll get IPIs with every new
> >> +	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
> >> +	 * fold.
> >> +	 */
> >> +	smp_mb__after_atomic(); /* paired with resched_curr() */
> >> +
> >> +	preempt_fold_need_resched();
> >> +}
> >> +
> >>  #else
> >>  static inline void __current_set_polling(void) { }
> >>  static inline void __current_clr_polling(void) { }
> >> @@ -91,21 +106,15 @@ static inline bool __must_check current_clr_polling_and_test(void)
> >>  {
> >>  	return unlikely(tif_need_resched());
> >>  }
> >> -#endif
> >>  
> >>  static __always_inline void current_clr_polling(void)
> >>  {
> >>  	__current_clr_polling();
> >>  
> >> -	/*
> >> -	 * Ensure we check TIF_NEED_RESCHED after we clear the polling bit.
> >> -	 * Once the bit is cleared, we'll get IPIs with every new
> >> -	 * TIF_NEED_RESCHED and the IPI handler, scheduler_ipi(), will also
> >> -	 * fold.
> >> -	 */
> >>  	smp_mb(); /* paired with resched_curr() */
> >
> > So this part is weird: you remove the comment that justifies the 
> > smp_mb(), but you leave the smp_mb() in place. Why?
> >
> > Thanks,
> >
> > 	Ingo
> 
> Thanks for pointing that out. The comment removal in the non-polling
> branch was intentional, but my original explanation was unclear. Let
> me rephrase:
> 
> Polling architectures (with the TIF_POLLING flag):
> 1. __current_clr_polling() performs atomic ops -> 
> Use smp_mb__after_atomic()
> 2. Keep original "clear polling bit" comment as it directly explains
> the barrier's purpose.
> 
> Non-polling architectures (#else branch):
> 1. __current_clr_polling() is a no-op -> Original comment about
> "clearing the bit" becomes misleading.
> 2. However, the smp_mb() must remain to preserve pre-existing memory
> ordering guarantees. And explicitly documenting it requires new
> wording to avoid confusion.

Thanks for the explanation, on a second reading that makes a lot of 
sense.

> Proposed approaches:
> Option A: Add a comment for non-polling smp_mb() like "Paired with
> resched_curr(), as per pre-existing memory ordering guarantees"
> Option B: Leave code as-is (no comment) and elaborate in the commit
> message: "For non-polling architectures, retain smp_mb() to avoid
> subtle regressions, while intentionally omitting the bit-specific
> comment that no longer applies."
> 
> Which direction would you consider most maintainable? Your insight
> would be greatly appreciated.

No action needed on your side, because it was really just me being 
dense and not understanding that the comment was moved as it didn't 
apply to the original place, it was not eliminated. The 'paired with 
resched_curr()' comment of smp_mb() is operative and remained intact.

I applied your optimization to the scheduler tree and it should go 
upstream in the v6.15 merge window if all goes well in testing.

Thanks,

	Ingo

