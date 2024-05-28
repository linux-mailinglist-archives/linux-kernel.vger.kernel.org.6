Return-Path: <linux-kernel+bounces-192329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C08D1B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8475A1F22A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23116D33F;
	Tue, 28 May 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiGbJC2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D497316E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900474; cv=none; b=EXlrroNVTAcK9rPspoF44noYwu1LDha2GyAuWOanio8DKr+Zx406quTIM1teY470nQXuTuRepSXtIpl46qHIb/P/i5gXksgdzTcbb7QtUjMDtX1+dX5hqnFjB6Y7ESYFsGsEAiavpWDavdy7b8zJDoHcUZuWl4JRTetT01XyMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900474; c=relaxed/simple;
	bh=RCCujihDmtcxfjM967k0N/kduY9TNazk02dOqNj4JR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbDYa4jz3sr+joklbc2cD97wD8P7y+3NagVLd7y2YGpCWZIaFhpzqoLbnWOK9v6co0mgjoFdjDb8RSiQRb+CYTNWCKVOm7DqOXmSxsJ9Fh3otBxopoj7QltuOGQ/h/4l4lgU1PsPMBtNlhDJeM3NEl33MT5pCYDDoaG7K84hadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiGbJC2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F82C3277B;
	Tue, 28 May 2024 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716900473;
	bh=RCCujihDmtcxfjM967k0N/kduY9TNazk02dOqNj4JR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiGbJC2mJADhEr+9eReKQ7DAtNBW5dm1ap89TAIA6JAosLCZ/JUg3PXdUhZDINO55
	 V3MLrvgjtZnBcBsqKU0EdXbPgI7GU7S/lfEbMdk1ruWqeRUf1fL7OtupG1kHdAFL5K
	 8d+b2cBcqKHY8muSnidgffTtMe0lrWDrDzV0Lr4Q=
Date: Tue, 28 May 2024 14:47:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	x86@kernel.org, jpoimboe@kernel.org, vlovejoy@redhat.com,
	oleg@redhat.com, linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] linux-4.19.y/printk: Avoid logbuf_lock deadlock in
 oops_end()
Message-ID: <2024052839-tipped-fragility-2799@gregkh>
References: <20240528101957.7277-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528101957.7277-1-TonyWWang-oc@zhaoxin.com>

On Tue, May 28, 2024 at 06:19:57PM +0800, Tony W Wang-oc wrote:
> A CPU executing vprintk_emit might be interrupted by #PF exception,
> this may leads to logbuf_lock deadlock:
> 
> CPU x:                            CPU x:
> ----                              ----
> vprintk_emit()
>   logbuf_lock_irqsave()
>     printk_safe_enter_irqsave()
> A:  raw_spin_lock(&logbuf_lock)
>   vprintk_store()                 #PF
>                                   do_page_fault
>                                     ...
>                                     oops_end
>                                       bust_spinlocks(0)
>                                         console_unlock()
>                                           ...
>                                           printk_safe_enter_irqsave()
> B:                                        raw_spin_lock(&logbuf_lock)
> 
> logbuf_lock is taken at A and the deadlock happends at B.
> 
> Pass 1 to bust_spinlocks() in the oops_end() to avoid this deadlock.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/dumpstack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 7e698c45760c..b4c145ee9536 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -336,7 +336,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	if (regs && kexec_should_crash(current))
>  		crash_kexec(regs);
>  
> -	bust_spinlocks(0);
> +	bust_spinlocks(1);
>  	die_owner = -1;
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>  	die_nest_count--;
> -- 
> 2.25.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

