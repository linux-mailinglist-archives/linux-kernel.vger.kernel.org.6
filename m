Return-Path: <linux-kernel+bounces-174668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54678C1278
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CEC1C21AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5316F84A;
	Thu,  9 May 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcA/iCTu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171D16F827
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271245; cv=none; b=NmZ2Vh1zh1o7+3JbKTPY7GIa/KXHVZV+SIx/OUaWt8D7f0e0LBJjQNnm5K7NFkm/COR1AF7IntWllqwx6C9ps4Q06e/AqETpJma1xw19ah/4rr+8rvXMtdJeQKUvA3hAJGNM5XMJvwumUG+fa6xqTL+77xX16nGRr1gP/+c9gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271245; c=relaxed/simple;
	bh=dZq4MIDenBDIHg1vAXEPozAT1U+JvYCecq7EhpTc+Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXM+2gE2c33z0ULhOkuV3TE/SzDwVukwS3B4VYXWcy9D6jMxNMAoUgQsmodlKmLmWrOvW3QF5NQZtkzKjklkm6Y/Gv+1bfUeTv86Q4k9bp/+t0TmsLcBNwHNhcvpY3cYUpO9E5nbippzhF+c6XwZgDraK0PqRTb4sWaN9GAb3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcA/iCTu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715271243; x=1746807243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZq4MIDenBDIHg1vAXEPozAT1U+JvYCecq7EhpTc+Lk=;
  b=OcA/iCTudWU1aBQsEmnPvgmMWjPMll81cDSmx6DW0J09sSOv/v7GgSHK
   9atra95PgTS6vp0MJyoqmF4xTSlgpLZa2moSyE13q+0losJJBtlXQBMXu
   AbCjeTWvzQrld8U1jDtzMJygMfbYZCUjLKvQ9HJmqyoAEtAWxMJ8lqe7z
   Wycu+49483SSNcMW8QZInb4nR5XdjqQ2y/iAh8HvPW2w7jFk545KyltI7
   RGIzKFAhgekD70t0KYkq1i7NUtIsvW3quWeBssMiaeT68tdB3wVWgPz0c
   OJwpmzTIssFNHc++vwsFoPUGSnzcuu5BQAW+fl1IGgEznFL5vW7EGHmYA
   g==;
X-CSE-ConnectionGUID: L8NL30RaS1uP7dsUQkMwtA==
X-CSE-MsgGUID: EX4DzSfNSDm8Kzh/BvPOmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15014191"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="15014191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 09:14:03 -0700
X-CSE-ConnectionGUID: rWCj0stsRTiUjW1lVuSATQ==
X-CSE-MsgGUID: dFp+mXbrQhGz9ArlRDYWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="33970431"
Received: from epinckar-mobl.amr.corp.intel.com (HELO [10.209.98.74]) ([10.209.98.74])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 09:14:03 -0700
Message-ID: <5b5e597d-7620-4a5a-9bfa-bae26f0b0fa3@intel.com>
Date: Thu, 9 May 2024 09:14:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before CR3 switch
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 antonio.gomez.iglesias@linux.intel.com, daniel.sneddon@linux.intel.com
References: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 16:48, Pawan Gupta wrote:
> As the mitigation for MDS and RFDS, CLEAR_CPU_BUFFERS macro executes VERW
> instruction that is used to clear the CPU buffers before returning to user
> space. Currently, VERW is executed after the user CR3 is restored. This
> leads to vm86() to fault because VERW takes a memory operand that is not
> mapped in user page tables when vm86() syscall returns. This is an issue
> with 32-bit kernels only, as 64-bit kernels do not support vm86().

entry.S has this handy comment:

 /*
  * Define the VERW operand that is disguised as entry code so that
  * it can be referenced with KPTI enabled. This ensure VERW can be
  * used late in exit-to-user path after page tables are switched.
  */

Why isn't that working?

> Move the VERW before the CR3 switch for 32-bit kernels as a workaround.
> This is slightly less secure because there is a possibility that the data
> in the registers may be sensitive, and doesn't get cleared from CPU
> buffers. As 32-bit kernels haven't received some of the other transient
> execution mitigations, this is a reasonable trade-off to ensure that
> vm86() syscall works.
> 
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_32.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d3a814efbff6..1b9c1587f06e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -837,6 +837,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
>  	jz	.Lsyscall_32_done
>  
>  	STACKLEAK_ERASE
> +	CLEAR_CPU_BUFFERS
>  
>  	/* Opportunistic SYSEXIT */
>  
> @@ -881,7 +882,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
>  	BUG_IF_WRONG_CR3 no_user_check=1
>  	popfl
>  	popl	%eax
> -	CLEAR_CPU_BUFFERS

Right now, this code basically does:

	STACKLEAK_ERASE
	/* Restore user registers and segments */
	movl    PT_EIP(%esp), %edx
	...
	SWITCH_TO_USER_CR3 scratch_reg=%eax
	...
	CLEAR_CPU_BUFFERS

The proposed patch is:

	STACKLEAK_ERASE
+	CLEAR_CPU_BUFFERS
	/* Restore user registers and segments */
	movl    PT_EIP(%esp), %edx
	...
	SWITCH_TO_USER_CR3 scratch_reg=%eax
	...
-	CLEAR_CPU_BUFFERS

That's a bit confusing to me.  I would have expected the
CLEAR_CPU_BUFFERS to go _just_ before the SWITCH_TO_USER_CR3 and after
the user register restore.

Is there a reason it can't go there?  I think only %eax is "live" with
kernel state at that point and it's only an entry stack pointer, so not
a secret.

>  	/*
>  	 * Return back to the vDSO, which will pop ecx and edx.
> @@ -941,6 +941,7 @@ SYM_FUNC_START(entry_INT80_32)
>  	STACKLEAK_ERASE
>  
>  restore_all_switch_stack:
> +	CLEAR_CPU_BUFFERS
>  	SWITCH_TO_ENTRY_STACK
>  	CHECK_AND_APPLY_ESPFIX
>  
> @@ -951,7 +952,6 @@ restore_all_switch_stack:
>  
>  	/* Restore user state */
>  	RESTORE_REGS pop=4			# skip orig_eax/error_code
> -	CLEAR_CPU_BUFFERS
>  .Lirq_return:
>  	/*
>  	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization

There is a working stack here, on both sides of the CR3 switch.  It's
annoying to do another push/pop which won't get patched out, but this
_could_ just do:

	RESTORE_REGS pop=4
	CLEAR_CPU_BUFFERS

	pushl %eax
	SWITCH_TO_USER_CR3 scratch_reg=%eax
	popl %eax

right?

That would only expose the CR3 value, which isn't a secret.

