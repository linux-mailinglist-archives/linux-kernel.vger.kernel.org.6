Return-Path: <linux-kernel+bounces-521454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073EA3BD85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72113AB558
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5721DF25D;
	Wed, 19 Feb 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Szw9r31n"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CC2862AB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966220; cv=none; b=VpJSGBdEwCHd+owOvJcC+F4rgEFHJqlVqcQ0NfpXXEaWBB9klSYIcZ3fzsLZZnMcHZ2UgxzWB3jeTjr/YgiWwYCiqx0sUDgmBlpD76vLSnoidkIVwIGDdnnjDOxnYMPgqdizX1sbvj3hFYy18752fxX+BM6RXJW+eRwqAGCHclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966220; c=relaxed/simple;
	bh=OFl5zYCDn+BC+obPnwoUzo/NkgK1vfKApTzM/4yPedk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTWwQLehBemI8JXUxvFfLunxOcYYr+Qq7OGuewMx198UQSf7W6antUvCNS0+pL9omXF6Deb7i3F01UWiaZmp2ll8vsraQNwhq61Tk2/CUcSgNNdTZDIMEoDkAs3zitIY2Zy7fNxioGcSg5xb7Vrj6S03lF1TQuU4NBOyVbugd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Szw9r31n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0D6B40E0220;
	Wed, 19 Feb 2025 11:56:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DyiDuI06pp0B; Wed, 19 Feb 2025 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739966209; bh=15QSN8fo+MeIxF3IRynj17rKxLBOmTuOswde/QN4K/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Szw9r31npCBjsCs8i8FM3NpOu8hvtevZD+xzMyeBjl78ustxGe4xIVc1FwUtZXYM8
	 6kTdBljvG5d4R/HaId0k48XerJtQxm/2+kwAP2W3tIkZz0S9WVVtgIx2nDHS4ND1RE
	 OVZ21ShLxOwMG3jmGx53Vn794H3F96Q2an9jNgytaXzyQH9SmQj14t0F5TvVuamNg6
	 MGXZkA29XUS1WCqYqIhQad+WDtuvD/xyNPchj2FWymP5aXkXPImegGzcU/qmmtxJaJ
	 2CEWRMHH+4yzDLrHKA/r1V4o9Weg2n8I4bnpsYQg295UBUvO+FdXRqcvZfgI/vgkD7
	 G3h9IeioakfJ+eXelUY57yuaB4NCpRnHBmkt2JeboYHFeiwaqfF9sEsa+yCNrJCxoI
	 rXXpZuDq7LFtG4DcdSSW6xClouIr9sf0pvDQGKuQBCW6bCFXr+4n5kcIpRGds7WoMU
	 1GKPra0df36e4h1Rf6LD4m6OCA926BNGa41gpWEiQxmSoWX/+Z0o13TPYJyVsraa2b
	 2WkFeokfEd3EO6VpdvQpIeh2670IR2uMc208sTIwCgYo3Lm1yg/CBTbjQByH83woWd
	 tRQMUBtKGJD/+7Xl7xx9tQOvPeOUBAXabkZpJZXR+DUK3kItB/zJ4V6VTvTC9bK743
	 LnGFB2Z1ShZXLdCeHwYNeXro=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7092840E0221;
	Wed, 19 Feb 2025 11:56:33 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:56:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 04/12] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250219115626.GMZ7XG6s-5ftg1XLoZ@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213161423.449435-5-riel@surriel.com>

On Thu, Feb 13, 2025 at 11:13:55AM -0500, Rik van Riel wrote:
> The CPU advertises the maximum number of pages that can be shot down
> with one INVLPGB instruction in the CPUID data.
> 
> Save that information for later use.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/Kconfig.cpu               | 5 +++++
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/tlbflush.h    | 7 +++++++
>  arch/x86/kernel/cpu/amd.c          | 8 ++++++++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..abe013a1b076 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -395,6 +395,10 @@ config X86_VMX_FEATURE_NAMES
>  	def_bool y
>  	depends on IA32_FEAT_CTL
>  
> +config X86_BROADCAST_TLB_FLUSH
> +	def_bool y
> +	depends on CPU_SUP_AMD && 64BIT
> +
>  menuconfig PROCESSOR_SELECT
>  	bool "Supported processor vendors" if EXPERT
>  	help
> @@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
>  config CPU_SUP_AMD
>  	default y
>  	bool "Support AMD processors" if PROCESSOR_SELECT
> +	select X86_BROADCAST_TLB_FLUSH

CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD which
selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...

Why do you really need yet another Kconfig symbol? Just whack
X86_BROADCAST_TLB_FLUSH - it'll be enabled by default on everything anyway.

> @@ -1139,6 +1141,12 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
>  		tlb_lli_2m[ENTRIES] = eax & mask;
>  
>  	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
> +
> +	/* Max number of pages INVLPGB can invalidate in one shot */
> +	if (boot_cpu_has(X86_FEATURE_INVLPGB)) {
> +		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> +		invlpgb_count_max = (edx & 0xffff) + 1;
> +	}

get_cpu_cap() already reads that leaf. You don't need to do it here again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

