Return-Path: <linux-kernel+bounces-278370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5394AF60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45CFB2186D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08C13DBA5;
	Wed,  7 Aug 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6GT7qQu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/SGIeV8/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FB1F937
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054136; cv=none; b=ug7EwQ7SQej1oVhE/kpheOQi3Ty4jOFdA5sT7swfvsWqbVXhZ/l+xawXnG1mxLEZSWrVZtIuoNSybIJO2hhKsIZFXX4TXOUGRL8GwKhtJ9B1gSATyhlG4Yoa2C0P7cfeOejTJgi2VpRPHYguLTZACNj2CzmKSs5lsaeV5y3FpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054136; c=relaxed/simple;
	bh=tJxLYMgeXaae1CrKf3/hbcFVoITqRkwHQ3SDCrNJIZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLuwlMt3vlanw8wW7o/z3V/eLtGeuuwuclJMSf1ru3iFUvnedyzVEepJalxRFdE/BfanwZjyOa2QS1QxjPCY/GQ+SgpUtQIABHOU4jP0HRapyq6fKlFH3PktIzoro3aggAKDniJRKV0TOZvOo8iuRmLCcvNd1LPnCh/UeUazR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6GT7qQu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/SGIeV8/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723054133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpx7Wwzc5zdURKqfONuxHfdzWyoMvFbpaaS6bn27M1s=;
	b=z6GT7qQu63wNfjQotqao9LHHw9C9BOToyQ48F76ocmAKGh9mlr4cnOoTqXpja93qr+WoPt
	WQC1Cg+TZtPMlO5EO5UiRhQ6DVnnQe0PrMF9l7zpFYam4p/gKKFfyAkuxerxbRLKkZ/jDA
	4SxZCYK1eoiyDog1E78d/7x5r4+7wFZLcusM+dIqeMS9sYFlFMQz3E1v9ldv/4ZjoVMspc
	zR/jAm5NOc1y3r0u8Pus/V3lT8hFwqxXOtG7WbfBryJZ3R2fn0s5VFMuThK5Vw2ay9f5H0
	f+N9GbsrpGr7pamcB20cRtuCpjZMlx+5aAyqz0ZaoMUP7rXEbBIq/nGj1BYE3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723054133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpx7Wwzc5zdURKqfONuxHfdzWyoMvFbpaaS6bn27M1s=;
	b=/SGIeV8/U8NxPkse00I9i8NPNK2y2RqHp84YN7L+GmfK0XisNLKYcfh9oeFThQGU8xZApF
	mhZe/If6Dvk/T9Dg==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 andrew.cooper3@citrix.com, seanjc@google.com
Subject: Re: [PATCH v1 1/3] x86/entry: Test ti_work for zero before
 processing individual bits
In-Reply-To: <20240807054722.682375-2-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-2-xin@zytor.com>
Date: Wed, 07 Aug 2024 20:08:53 +0200
Message-ID: <874j7w2oju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 22:47, Xin Li wrote:
> In most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
> are zeros, e.g., 99% in kernel build tests.  So an obvious optimization
> is to test ti_work for zero before processing individual bits in it.
>
> In addition, Intel 0day tests find no perf regression with this change.
>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/include/asm/entry-common.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index fb2809b20b0a..4c78b99060b5 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -47,15 +47,17 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  						  unsigned long ti_work)
>  {
> -	if (ti_work & _TIF_USER_RETURN_NOTIFY)
> -		fire_user_return_notifiers();
> +	if (unlikely(ti_work)) {
> +		if (ti_work & _TIF_USER_RETURN_NOTIFY)
> +			fire_user_return_notifiers();
>  
> -	if (unlikely(ti_work & _TIF_IO_BITMAP))
> -		tss_update_io_bitmap();
> +		if (unlikely(ti_work & _TIF_IO_BITMAP))
> +			tss_update_io_bitmap();
>  
> -	fpregs_assert_state_consistent();

Please keep this unconditional and independent of ti_work. It's a debug
feature and you kill coverage with making it conditional on ti_work.

Thanks,

        tglx

