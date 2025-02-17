Return-Path: <linux-kernel+bounces-517451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA5A38118
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C94A1895008
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90D192B71;
	Mon, 17 Feb 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dLkmnCY2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4C8BE8;
	Mon, 17 Feb 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790012; cv=none; b=XgZu+nhlTFo4sc5bLO4GsEF+1x4LW4G9WFFu5sGI/UyzRkoJEe0MIGAYtRj6m7gZZdhqwTy67OTY2VwYUbcDF7X9r7eIuJCkQBy9C893tMo/HeXXBedg3QquupISL4IsR/Ab9rEvjjhFLYBH+pPkGltkE96jZKz0uo7akSAINrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790012; c=relaxed/simple;
	bh=ZNHUleisOdHmYgANtMeSyIY1VUuxlx4cRdm40fYq/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eydOhJis/SbtykondvUhIA0TwV25eg1clex3WepiRSzxKXOj3AcYoQ8wGYZkCPCEZhOw3mqKalXP6AYWOt1r0d6J5QlbnltXtAX/7buPoILg6QcsxYdJO2IrgM3q1Byq2y2hUxSyEc4dLBGRXvyyPLIpKwsqLseZu1lWXzpebUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dLkmnCY2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BCC7240E01A1;
	Mon, 17 Feb 2025 10:59:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Eg6h8LvNyXZ6; Mon, 17 Feb 2025 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739789993; bh=4mcW+ftRRHHKwN2CsGFMs2T5+lHfpSf2xypFj9o/BQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLkmnCY2DFgr6nl3bV6xDkdAKoKSqK32yJR7932Px4Ps9OcFhbVypQSU7Ii0C/cV2
	 u3U4L8PHI/pVA7lMJmcDVNShl8l72rA3VEYCi0ikAGHoFAXQLNoEOxFG4GDtIYSh8u
	 fh4dyarpzp+u/c/+nSJfEhIQY2pkrwTwuWWVSY8IZ2DXlFk4e9pLjhkQN20BPl3KIW
	 3RbUpl5wB6UQBc+jt9SH6dC90WzWH5P3HGu0+8ETlDAJqONSCi95NDlrcBlcbWPF2D
	 894Ux2CUX+mWmxUF23dWNVwXm9npUkze9r8Yue5cGl7nKnxK1GjcKbCc1k46/qvTmE
	 iOt5HvgbgrvwC3z/zIR1IWJA2tTZY86rTSnlRadlAf5orGSifYOic2dPmfiiklMTS4
	 D0DR/jC68gStN7EavqSvc4vEMA/0g4iB4jshaAuHrZrZxhxXzyiWE2x75ZdIiiv3ax
	 9bZyFBEM2KtXbR07M/n4aW8NuHXLaQJJD9G8snEn+igPSa9AxODLzav+9JillEitZi
	 JMKE4jZJ6oLGAvi6dBtkdciaFkTZ99KBQZ8Iu37nFsIP1m8sPCrQc7HjwueBNw8DAl
	 TW3wQtLqhiU8nlO4SNoD6j0wNHhSrYmrg5Cw1IXdbdjYWoRCBg6SeYWIsoYr7FYVFE
	 hl4bn4qXJ1S+w49qUDhdb/0A=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BCD940E0176;
	Mon, 17 Feb 2025 10:59:43 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:59:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/3] x86/cpu: Create helper to parse clearcpuid
 param
Message-ID: <20250217105937.GGZ7MWmb4eTtRaN72e@fat_crate.local>
References: <20250129-force-cpu-bug-v2-0-5637b337b443@google.com>
 <20250129-force-cpu-bug-v2-1-5637b337b443@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129-force-cpu-bug-v2-1-5637b337b443@google.com>

On Wed, Jan 29, 2025 at 03:35:39PM +0000, Brendan Jackman wrote:
> +/*
> + * We parse cpu parameters early because fpu__init_system() is executed

While at it:

s/We parse cpu parameters/Parse CPU parameters/

> + * before parse_early_param().
> + */
> +static void __init cpu_parse_early_param(void)
> +{
> +	char arg[128];
> +	int arglen;
> +
> +#ifdef CONFIG_X86_32
> +	if (cmdline_find_option_bool(boot_command_line, "no387"))
> +#ifdef CONFIG_MATH_EMULATION
> +		setup_clear_cpu_cap(X86_FEATURE_FPU);
> +#else
> +		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
> +#endif
> +
> +	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
> +		setup_clear_cpu_cap(X86_FEATURE_FXSR);
> +#endif
> +
> +	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
> +		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
> +
> +	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
> +		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
> +
> +	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
> +		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
> +
> +	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
> +		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
> +
> +	/* Minimize the gap between FRED is available and available but disabled. */
> +	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
> +	if (arglen != 2 || strncmp(arg, "on", 2))
> +		setup_clear_cpu_cap(X86_FEATURE_FRED);
> +
> +	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
> +	if (arglen <= 0)
> +		return;

Newline here.

> +	parse_clearcpuid(arg);
>  }
>  
>  /*
> 
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

