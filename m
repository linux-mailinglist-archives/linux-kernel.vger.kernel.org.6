Return-Path: <linux-kernel+bounces-525070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF06A3EA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC5189F0E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BF1C5F39;
	Fri, 21 Feb 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fWmbGxN+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AE70807
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103118; cv=none; b=eBnMNTiEqIQTClgJELfklMb1qsPWVA4CYN16+gE9x2sOetAhIFTy1euqdvH18NbG6fMHI9KHE2E21D3UBKg2ZE2B0HVztZ2q7y73bOqQfgupR3DyWCGlHnyQVNGyz/oFn+5fFkrDnZAYnJOdcCW6W87lTR1w/T1Y8RvPVBEpFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103118; c=relaxed/simple;
	bh=/riqiRMoWV7AJ4n4S0gjpVmQgAOIKoR3sJopGzAHVI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwTVxjiKI4WzT+HMXsCUrymIeB8HNINrmetez6ob60yAsrDnSPjK7QRbBGUKN4tjrxizekn/9PFEUbVm02kpC1cPCjqKN4c2lXjX4av8Br6PfpnEubENYlbgXII+XzxqbY3dEW/aE3GzkwA+6/W9vW/kS05hoaXGxS8tFpDNrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fWmbGxN+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 025BF40E01A0;
	Fri, 21 Feb 2025 01:58:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KlF8eqA3UIG5; Fri, 21 Feb 2025 01:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740103105; bh=9pl8mc1+LryrdBQUYpnpwMJchQlk3HW4nhPbnRy/OnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWmbGxN+1yA8Ht7WT08Or9Rv113NVICpFGmCyrTzNE2u2AoYcTsLA6ivYjXD+6bkx
	 RJriWPB+DlKI/Dd1ivBp57HMScPqs+f6bfCzGpXeX4uW3/zEv+9TiQ8DHX96Yg9qAi
	 fH70I3VmTM0hT2J+FgsgThJJKf891P+12ioxculXYZEVp9sYMRfIBy0aR/JRr2rYob
	 DgzX56dU9tFnmYDc8+4szqlqoMgQohRourYM2W3pW/qM1I8Puj0B1BhmEK11Br5dy/
	 8YF5Y98m8NS4ncbJ2hbhRdB/V9aNf+lRhCU7Y7pKfqzbrJ6kERc3oyJK93qfVzhUSW
	 BQt217wZRlgaIVcuvgtOsNluiLv4Etn2/5WU8NAkaKkVCuW0bSORizETQscSXLYAjU
	 qHom5jDorBsjfgbITli88oCx1w0Jnl2d7aOWLFqktSHMXUIpGci+YIoOFuRUGR4JmX
	 Ol0XDhH4sYSqN50oXDL/mkoLPn1B986rts6F8zpQvQ0MH7wfR4Z656oQy7RAQDN88Z
	 xrfVzUkgP+b/5a9h90yZgL86Wj9eg1fDiEpm3bsgTUa0bURmYw3wqAI09o0Y5wvK6l
	 MX+ho7hIDHiuir9D/U0mYA6wU17XRdACM+3DzwBSzq2HHbK9qrTXEDGj0EZ5OQFJWc
	 wUjnXXLNXhPKmZfQfR6SW7s8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CEDB40E0176;
	Fri, 21 Feb 2025 01:58:08 +0000 (UTC)
Date: Fri, 21 Feb 2025 02:58:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 04/16] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250221015801.GHZ7fdqaGFEvsG6qW1@fat_crate.local>
References: <20250221005345.2156760-1-riel@surriel.com>
 <20250221005345.2156760-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221005345.2156760-5-riel@surriel.com>

On Thu, Feb 20, 2025 at 07:53:03PM -0500, Rik van Riel wrote:
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..bb6943c21b7f 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
>  	  This lets you choose what x86 vendor support code your kernel
>  	  will include.
>  
> +config X86_BROADCAST_TLB_FLUSH
> +	def_bool y
> +	depends on CPU_SUP_AMD && 64BIT
> +
>  config CPU_SUP_INTEL
>  	default y
>  	bool "Support Intel processors" if PROCESSOR_SELECT
> @@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
>  config CPU_SUP_AMD
>  	default y
>  	bool "Support AMD processors" if PROCESSOR_SELECT
> +	select X86_BROADCAST_TLB_FLUSH
>  	help
>  	  This enables detection, tunings and quirks for AMD processors

You missed my comment again. How about you read review feedback more carefully
please?

CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD which
selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...

You need to make up your mind in which way the dependency should be. Certainly
not circular.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

