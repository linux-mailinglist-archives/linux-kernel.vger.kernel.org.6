Return-Path: <linux-kernel+bounces-528954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BAA41E61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E88420B27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD223BCF8;
	Mon, 24 Feb 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VE37eNQo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DEA23BCF3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398465; cv=none; b=PaFT9GGIR+8mSVxbzpFr1LW9QEvQM9YEuf/PTM2RPHt8pfwbJv42GQYgUPKWXGwbx1ovW2u98/Y8ZTxP5l2skomZAxpINkjt40ErP7l23Q1ZP9xX9LYcpf4s9cBzzSlgfOW2V8nv5xYCFHKA2Op5BF2XSRalczKRTz5HoOUqAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398465; c=relaxed/simple;
	bh=9PajL9JaTSC2oVML6eslzA/s/lRg2Nn/yBntv9KIARA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3qDFp7ZmTfCI2vn2eOuRpTiHvLBCqaokiO+BYh9UJbFuW3YcMYkoLxUHekVapDrZjTb6L4r3BDh7HLXwBf/Ch2eO89UyVoBhazl+5Q9f9VvR7hDFDeGPi6UV4DTdBHfLGHHHcU2lcl7fasosgTPGGYM3lL/mFtBV6IyZ52TN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VE37eNQo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D441240E01AE;
	Mon, 24 Feb 2025 12:01:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U99NsmQKFJ-z; Mon, 24 Feb 2025 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740398453; bh=WOShKx94UTiVDUhBh2Fmaq1YAYEq4dRJi/kTFuV7oi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE37eNQo0dNHsN/toHyi+qm/3i73IZEMBqKYzbvizWx1jn2hHSxO8BbjKOOuHhbSj
	 ZL+ry2+XkcQXr31ymsBSufPkIa06eEtagvzpBoe3XO6LCNSNw4Nj6EtSI8aypuapyX
	 euoAXc8zkvgrVUHMy908qMU2dhqA9ARFqfYUqT4iusRvRV0AC9t9b55CoGgnF08EQa
	 k7x9Xeh72eZ3UUPRI9o+rpYdSqdaGckE6HbmEHba3wsNqqdUsGPJSDTJ+FxV6PJBA7
	 +sIM7QUSpWHK50DsrjsVEqw02xPXrb0b5w+nVQ7YbVeaaGxX6X2kcZG1X7Ck7Sd/4u
	 Vp/WmqKNxZMjmXjy2HSTXcZVAbR5dyboSsLesVZ6XFzfAXMnreLGySOHNX0JHjhm3S
	 WR3I3TqdwQ8P+Ts5csT1Z5vz3dLWHF95BjWgATYaMIhhiqm3vtt3fOPX6J/wV1hXEJ
	 W76MSfKQvvpkXyCE+T3esCk9ZOK3cuSuKbB6Ufg8Wstrd+syHcpF10NVdWlxFZ8i9r
	 D+ROesREUtLp22T06FAM7rT1V/jpJ5DQXzN9Mfx3IzZrxvsxZ7ri+7BFlNHqCEhojW
	 sCX1lGwmZydMm+5KUn61er5llFYlaAImOiPGA78ikAhnDnuxfepZ1rh1tITnUcCTFw
	 SbVKfnvnw2JbTHhCZxQhX90o=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EFA740E0184;
	Mon, 24 Feb 2025 12:00:35 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:00:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v13 02/14] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250224120029.GDZ7xfXV3jMjnbdbGl@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-3-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:52PM -0500, Rik van Riel wrote:
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 3da645139748..09463a2fb05f 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -183,6 +183,9 @@ static inline void cr4_init_shadow(void)
>  extern unsigned long mmu_cr4_features;
>  extern u32 *trampoline_cr4_features;
>  
> +/* How many pages can we invalidate with one INVLPGB. */

"... can be invalidated... "

Please use passive voice in your text: no "we" or "I", etc,
and describe your changes in imperative mood.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

Please check all your text.

> +extern u16 invlpgb_count_max;
> +
>  extern void initialize_tlbstate_and_flush(void);
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 54194f5995de..3e8180354303 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -29,6 +29,8 @@
>  
>  #include "cpu.h"
>  
> +u16 invlpgb_count_max __ro_after_init;
> +
>  static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
>  {
>  	u32 gprs[8] = { 0 };
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
>  }

Ontop:

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3e8180354303..7a72ef47a983 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1143,10 +1143,8 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
 
 	/* Max number of pages INVLPGB can invalidate in one shot */
-	if (boot_cpu_has(X86_FEATURE_INVLPGB)) {
-		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-		invlpgb_count_max = (edx & 0xffff) + 1;
-	}
+	if (cpu_has(c, X86_FEATURE_INVLPGB))
+		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

