Return-Path: <linux-kernel+bounces-522157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0EA3C6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF947168F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BC2144C2;
	Wed, 19 Feb 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MboJA81K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B51F61C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987714; cv=none; b=ScpY/ZWydqhtAD7AE8sFWt1GjH2541emxyuwuv/ymbwRQcmSJHBVYgUN6LrF0enuW/hFR42d7Be9chIl4UMwDjGkF7sTSsoOW6foDaHKkWbqkX25jP5iP9a+CkZz05Ko32Hkt3sgr9UmiLY6DRa3gDdxxI8r6wC1/tvL7Aqn3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987714; c=relaxed/simple;
	bh=kXadW/dHwTIdTIZrEuYnpWCMkkyj97m63e5oA0Rgb6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uaj/kzIWftu0ihKZ9IzEuitMn8krGFfR+XJxMiXb+iQtDlaMVwwTK4XlAGs1h7EbNS1CkQi0iDlVso43O5deWhQLlzXc456ZSDSs/900WIjcFVYYCldd3XGBrvrphf1qfSuPN5bJoFzwEMM3QraJfoPnr70jxaWqxYeGVS8lrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MboJA81K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAEAC4CED1;
	Wed, 19 Feb 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987714;
	bh=kXadW/dHwTIdTIZrEuYnpWCMkkyj97m63e5oA0Rgb6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MboJA81K5ANnPh9UWaKO0Uw/SSLXWzIkDiIxIjp+AVKY3uA3+7vDm2EQkS0m1SDJW
	 /rfeAN3NMd5jNcPPaglyBA2Pe8sgMmWW8jl3ZBqPkafjQLSP2sDGej5K2PiDJqJK3K
	 H80B6MDhdih1s5yOUHnaJGcm+R+c0tF8n0rzo/2nir7bPdo9BdlNNbbvHeGGoA33/s
	 vFC++1qOIKLshLgUjaYaWF70HrXgqm7dplf7NUXODMsQPhOg2irqQUFwE44cWdt9zI
	 k7hoI2gv+AuwrqbnRTuVK1JctLxqV9qlo5PBlNYWU2H1dxPm6jr5LW/boBmE7lpvTa
	 NWUNQz4jbGsGQ==
Date: Wed, 19 Feb 2025 09:55:10 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 04/10] x86/traps: Allow custom fixups in handle_bug()
Message-ID: <202502190953.53EA878FF@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.688460830@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.688460830@infradead.org>

On Wed, Feb 19, 2025 at 05:21:11PM +0100, Peter Zijlstra wrote:
> The normal fixup in handle_bug() is simply continuing at the next
> instruction. However upcomming patches make this the wrong thing, so
> allow handlers (specifically handle_cfi_failure()) to over-ride
> regs->ip.
> 
> The callchain is such that the fixup needs to be done before it is
> determined if the exception is fatal, as such, revert any changes in
> that case.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/traps.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -287,11 +287,12 @@ static inline void handle_invalid_op(str
>  
>  static noinstr bool handle_bug(struct pt_regs *regs)
>  {
> +	unsigned long addr = regs->ip;
>  	bool handled = false;
>  	int ud_type, ud_len;
>  	s32 ud_imm;
>  
> -	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
> +	ud_type = decode_bug(addr, &ud_imm, &ud_len);
>  	if (ud_type == BUG_NONE)
>  		return handled;
>  
> @@ -315,7 +316,8 @@ static noinstr bool handle_bug(struct pt
>  	switch (ud_type) {
>  	case BUG_EA:
>  		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -			regs->ip += ud_len;
> +			if (regs->ip == addr)
> +				regs->ip += ud_len;
>  			handled = true;
>  		}
>  		break;
> @@ -323,7 +325,8 @@ static noinstr bool handle_bug(struct pt
>  	case BUG_UD2:
>  		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
>  		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -			regs->ip += ud_len;
> +			if (regs->ip == addr)
> +				regs->ip += ud_len;
>  			handled = true;
>  		}
>  		break;
> @@ -340,6 +343,9 @@ static noinstr bool handle_bug(struct pt
>  		break;
>  	}
>  
> +	if (!handled && regs->ip != addr)
> +		regs->ip = addr;

Can you add a comment above this just to help with people scanning
through this code in the future, maybe:

	/* Restore failure location if we're not continuing execution. */


> +
>  	if (regs->flags & X86_EFLAGS_IF)
>  		raw_local_irq_disable();
>  	instrumentation_end();

But yeah, seems fine:

Reviewed-by: Kees Cook <kees@kernel.org>


-- 
Kees Cook

