Return-Path: <linux-kernel+bounces-426634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42C9DF5DF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CB516304B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C711D27B7;
	Sun,  1 Dec 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LnokxOUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etF8dYKl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C01D1F40
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733061387; cv=none; b=r9CGJo3JsGaBWcPTkqm8PeUVeLxd8Qz++BBHDbS6p7KZlN+qLowImsyQWVfX+jl1d29mgjFan9EIJJIwXYqJsvPH798ZNkanlJuQ8aKtnU7k2uOJyz+WGPocgAPrpZOfnFIb5BK7PdQUDrADDkol+1IniR2vaPvj5BXlf0M6kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733061387; c=relaxed/simple;
	bh=tAMOpniDyLK/aGqGCaKUF56D475GacuXV21DXQ9j38k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fxq4Tg5zLPqqxMqHvoU5R4PLR6kqxiTCHE+YUp/pWSFTon2tJKt/cXt5ZFrI1HKLaw3WEzg28IcUKjjYDgS4m2Mg0C5DkAnydUEPjs1EPm4gx3XJZg4gdv/g1n/IwyGq+rMaHoIxOOaXJ6sPVfYNjeSEmHuwMOkZ/cFy4A0iUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LnokxOUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etF8dYKl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733061384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZqL2Qk15dTfpaJRDY85XnmgP2js/2QSTvcgS82NqO8=;
	b=LnokxOUntG2/WZ6YyZj73BWP5G2ldHYBEDcNNGTaBF2AY2w9d1YvmTJyMH0evdU9UKvwJh
	L34pap5fH8xIjPsU2JTZVjIX+D98QT7/U8amC6E9phnDm7u6CcAhveGQIYLydJ7LDVDJlO
	LfUM7ag45XbOkH2GXE4o58mXY8lMbL5u+LLLvLzSP2CI0fCJP9Pf4iO9l8/JwE8R2/1czo
	GA/nOWx0wE09ffJzg3ex5d9K7O03vVkL+FwKBOK+uWA0QJ8Ch1OlCZr63e7kiiJnzHU+1y
	z/BUu2S0pudCr/zay/rKNJUaSQ4J5ptIemIJl7VCDMbTzyNgRKZxfeaiq+Id3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733061384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZqL2Qk15dTfpaJRDY85XnmgP2js/2QSTvcgS82NqO8=;
	b=etF8dYKlwGL8xmeRb7vy+/8VUnPMiubH/GxkRPQZeWZ3gfU1ygv2F1MWF2Ve2ARgxh5PFE
	AkzC3nHDQcxpUkBw==
To: Fernando Fernandez Mancera <ffmancera@riseup.net>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: [PATCH RESEND] x86/cpu/topology: remove limit of CPUs due to
 noapic on x86_64
In-Reply-To: <20241124174510.2561-1-ffmancera@riseup.net>
References: <20241124174510.2561-1-ffmancera@riseup.net>
Date: Sun, 01 Dec 2024 14:56:24 +0100
Message-ID: <87ttbnv75j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 24 2024 at 18:45, Fernando Fernandez Mancera wrote:
> On x86_64 the command line parameter "noapic" should not limit the
> number of possible CPUs, as it only limits the use of IRQ sharing or
> device IRQ remapping. Only on x86_32 the command line parameter
> "nolapic" limits the number of possible CPUs to one. This restores the
> behavior previous to the rework of possible CPU management.
>
> Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
> RESEND: original patch https://lkml.org/lkml/2024/9/7/160

Please use https://lore.kernel.org/all/$MSGID references.

> ---
>  arch/x86/kernel/cpu/topology.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 621a151ccf7d..5f10a010e35a 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -428,10 +428,16 @@ void __init topology_apply_cmdline_limits_early(void)
>  {
>  	unsigned int possible = nr_cpu_ids;
>  
> -	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
> -	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
> +	/* 'maxcpus=0' 'nosmp' */
> +	if (!setup_max_cpus)

That's wrong. If the local APIC is disabled, SMP is not possible.

>  		possible = 1;
>  
> +#if defined(CONFIG_X86_32)
> +	/* 'nolapic' 'disableapic' 'noapic' */
> +	if (apic_is_disabled || ioapic_is_disabled)

I double checked the original behaviour. A disabled IOAPIC did not
prevent SMP on 32bit either.

> +		possible = 1;
> +#endif

So the condition wants to be:

	if (!setup_max_cpus || apic_is_disabled)


>  	/* 'possible_cpus=N' */
>  	possible = min_t(unsigned int, max_possible_cpus, possible);
>  
> @@ -443,8 +449,14 @@ void __init topology_apply_cmdline_limits_early(void)
>  
>  static __init bool restrict_to_up(void)
>  {
> -	if (!smp_found_config || ioapic_is_disabled)
> +	if (!smp_found_config)
>  		return true;
> +
> +#if defined(CONFIG_X86_32)
> +	if (ioapic_is_disabled)
> +		return true;
> +#endif

That wants to go away too.

Thanks,

        tglx

