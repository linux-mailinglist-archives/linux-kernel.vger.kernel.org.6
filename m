Return-Path: <linux-kernel+bounces-278411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53F94AFED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB32B2180F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F513F012;
	Wed,  7 Aug 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nTXkSS5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swe+683R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0424653A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055989; cv=none; b=MFp6NU9eA0vcwH1pxUed4cd3aezcouURe9xLudSPGNilBu7pEojB4EZ/H2slImI4o6/dMyvQI76eo8OGrqdeoQqet0OECaWdBlPh8VAJ74ARRu1uQ2NBysxqAFwwntCDvub+v2khZKAJoMyhwqOL1L7HhSQLl2Li1JcTyUPFfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055989; c=relaxed/simple;
	bh=mzZ8eB9DM7DM2woamiaRVomM1QkAFWCz32qPuT0Pbr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXaV9amYH5mHOROr2osqKFSLkkpPkWMco4Qfv5f25KQdOxoQjr08gLo8OvYjrVFwMdo6nOj7af7wp0q1bxafgsqiKnZRnfJr0w6cXXBpkFLgB0kcwcnxjv0CgXczkwPqfe3H38bBTcKdo40p2HZBLL4F3ax7Yv8rfp4iTgpaqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nTXkSS5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swe+683R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723055985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qEv5fSZ6dMpM7M/nalrplojfsS0XUIrpv8BCSarjvQ=;
	b=0nTXkSS5ISUTQDCYSG/zTH3vPUFlWQctHY1i7fPWFGxNAGvy4X3gSce+FZ+FTRo/NocQG6
	c/5ZI4hqGmbB6KnoAFUBkH/ON3e0mZQZX80eGBf11iGJyW8mX1xIw3qjR042yUGQw6er5J
	KswCA+R8Hnd+desj+MNK/e0dsjlDhtUGD1803H4H5v/2UlMk1GgOBkg8XMDPI5NEUYu6Am
	An+fuVtY1c5fktRweYIzlRJJ2FEUkuhgrRNZIq3FnSNBDhlqtIork3dkPAph0Da6GrsJTz
	lu26IuT3JVNtgHDAUAQ6Q+dMWD9dh5eaFDxPQOPMV5lw7Q/B6PYNrkzl8EGYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723055985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qEv5fSZ6dMpM7M/nalrplojfsS0XUIrpv8BCSarjvQ=;
	b=swe+683RtNxZKQI8GPfAVkot+r0dVao9BYOVQDCr+HzQ+rdj/ssuIrxGYVfrYeDKR8BxZC
	otWJDUA4w5G++VAQ==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 andrew.cooper3@citrix.com, seanjc@google.com
Subject: Re: [PATCH v1 3/3] x86/entry: Set FRED RSP0 on return to userspace
 instead of context switch
In-Reply-To: <20240807054722.682375-4-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-4-xin@zytor.com>
Date: Wed, 07 Aug 2024 20:39:45 +0200
Message-ID: <87ttfw18jy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 22:47, Xin Li wrote:
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -51,6 +51,11 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  		if (ti_work & _TIF_USER_RETURN_NOTIFY)
>  			fire_user_return_notifiers();
>  
> +		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +		    (ti_work & _TIF_LOAD_USER_STATES))
> +			wrmsrns(MSR_IA32_FRED_RSP0,
> +				(unsigned long)task_stack_page(current) + THREAD_SIZE);

Eyes are bleeding. If you do the inline in patch 1 then this becomes

	if (cpu_feature_enabled(X86_FEATURE_FRED) && (ti_work & _TIF_LOAD_USER_STATES))
		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(current) + THREAD_SIZE);

which is in the 100 character limit and readable.

Though I wonder if this should not have a per CPU cache for that.

        if (cpu_feature_enabled(X86_FEATURE_FRED) {
        	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;

		if (__this_cpu_read(cpu_fred_rsp0) != rsp0) {
			wrmsrns(MSR_IA32_FRED_RSP0, fred_rsp0);
                        this_cpu_write(cpu_fred_rsp0, rsp0);
                }
        }	

Hmm?

>  		if (unlikely(ti_work & _TIF_IO_BITMAP))
>  			tss_update_io_bitmap();
>  
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index c3bd0c0758c9..a31ea544cc0e 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -71,8 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
>  	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
>  #else
>  	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> -		/* WRMSRNS is a baseline feature for FRED. */

This comment is wrong when using the alternative WRMSR fallback and
should be remove by the alternatives patch.

> -		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
> +		set_thread_flag(TIF_LOAD_USER_STATES);

Thanks,

        tglx

