Return-Path: <linux-kernel+bounces-521466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660CA3BDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EF916D2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188D1DED57;
	Wed, 19 Feb 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KIvsZxZP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60A1CF5E2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966709; cv=none; b=jLLqHnZy/rQN7Z4BscJVYzSxn4hKSkXY33r4e46ixrK9xQmGnK3DMMLzgxgY8SZ9QpIjTJRwxrO32at4Wtgzcn2QNlwZ6B9ybRxg5/L1Cj1lGNEf07dv1oQWag333THt3GbowErT2PqyFtywGBoE5EzgaiOah5lcvQW7TjEHV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966709; c=relaxed/simple;
	bh=5s/ZgHzBUDq1mtrGfLxwMGn2ZXY2/6NZLF5GPClAWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVQyBtTJv6doc2sdTrX2+eEbd3iUKsrEEplNZXqKThgDuBAW7XsLilBLCzrAR+xf0+wnyhilfxX+cgWLRvVYAEyaqslku6IJf0C4WBeZkjS4PvEnpnK0rPa1Dg5jChWJwwjGdC0QctTF9v9sdpRbFrj4ssaV7sLJlBWj8IsYaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KIvsZxZP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 819F340E0221;
	Wed, 19 Feb 2025 12:05:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bh14lVrcUpQq; Wed, 19 Feb 2025 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739966698; bh=IlEwYGsWU+HgFJw77Yn9NIdwvzcfp45kelarRrAI4mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIvsZxZPY0a6o6WJhwtxdezGe4Uiy20yMdMpxP6FYqbu44KgSczMiKnruyzFqfnyA
	 l7dan9nOmgIU7dhqKXLfNQRfNyHAticSbZ3LBesmKQBj4v9HQ19rVBwyutUI0663Qr
	 SYiPeamIYDYzGNdtHN7bp1lOLERAcOljOW7nGDP/o/s2PwSLmC4OvL81bqfzNO5362
	 r7c+MKBNtvO10r5kEyRu7CXChvkgDOuUhtPaDHAa3LI/tks/kV6rOfOHsEezgT15Gc
	 mDUDiBV/EeOBXFufVwa7rcMb5C8VtQezwTNSz/Efl/9cs+IBBj8f2451mhGhVPJ4cU
	 KATPfUuMjtxwgKkFIdoMqhOK229JrYQvfFm43ihq+X8bmmJZD61mN0gtdjRwcrrfk8
	 4oXK8tn6sH1oM443FikbakoCj0Q42dQyHgg4bSd7dKwOyJHhJAirlSwBb2bcbPjdUW
	 UQVmf2BIDcxwH82Y0uDhAImbgCuvtL4CNHg4YIRshYmqgrITZpQF8RwPqcOgEQhX6h
	 bwsQ0+L2Jz2/syfPQ9eKKqmWjs/nsW0MRFLrWssUWCN3O3hWwTpJnnNa0etsURyM0k
	 5g6XcQjATVT/CV8dbHEpdBZFe+SH4jAp6+ttVs1SmekDC3LaWLRAdkH2anBJgPu9W/
	 o0Mweqmc3Hwp/wyn4a3rzpBk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FC2240E0220;
	Wed, 19 Feb 2025 12:04:42 +0000 (UTC)
Date: Wed, 19 Feb 2025 13:04:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 05/12] x86/mm: add INVLPGB support code
Message-ID: <20250219120441.GNZ7XI2aWWUmXh2H2m@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-6-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213161423.449435-6-riel@surriel.com>

On Thu, Feb 13, 2025 at 11:13:56AM -0500, Rik van Riel wrote:
> Add invlpgb.h with the helper functions and definitions needed to use
> broadcast TLB invalidation on AMD EPYC 3 and newer CPUs.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/include/asm/disabled-features.h |   8 +-
>  arch/x86/include/asm/invlpgb.h           | 101 +++++++++++++++++++++++
>  arch/x86/include/asm/tlbflush.h          |   1 +
>  3 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/invlpgb.h
> 
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b05..625a89259968 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -129,6 +129,12 @@
>  #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +#define DISABLE_INVLPGB		0
> +#else
> +#define DISABLE_INVLPGB		(1 << (X86_FEATURE_INVLPGB & 31))
> +#endif
> +

What does that bring you really in savings?

>  /*
>   * Make sure to add features to the correct mask
>   */
> @@ -146,7 +152,7 @@
>  #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
>  			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
>  #define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
> -#define DISABLED_MASK13	0
> +#define DISABLED_MASK13	(DISABLE_INVLPGB)
>  #define DISABLED_MASK14	0
>  #define DISABLED_MASK15	0
>  #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
> diff --git a/arch/x86/include/asm/invlpgb.h b/arch/x86/include/asm/invlpgb.h
> new file mode 100644
> index 000000000000..a1d5dedd5217
> --- /dev/null
> +++ b/arch/x86/include/asm/invlpgb.h

I remember asking you to add all that gunk to arch/x86/include/asm/tlb.h.
Please do so.

> +#define INVLPGB_VA			BIT(0)
> +#define INVLPGB_PCID			BIT(1)
> +#define INVLPGB_ASID			BIT(2)
> +#define INVLPGB_INCLUDE_GLOBAL		BIT(3)
> +#define INVLPGB_FINAL_ONLY		BIT(4)
> +#define INVLPGB_INCLUDE_NESTED		BIT(5)
> +
> +/* Flush all mappings for a given pcid and addr, not including globals. */
> +static inline void invlpgb_flush_user(unsigned long pcid,
> +				      unsigned long addr)

Please drop this unused function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

