Return-Path: <linux-kernel+bounces-538902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8780A49EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9D3BA879
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC289274264;
	Fri, 28 Feb 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ipE7YCAF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBC274253
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759706; cv=none; b=hJVOJIZQ4mdfzQA29tRtb/2eqYkpk6p+zXarnwvWGunVH2vMEctRLc9/w+oVqb5oelfa1FUQneCrBw6sNpY9ymQgPaf00vSc00IeI4gzL+MCmfudyysnndvjq2G583xl7IpyEcksuK/ozXTYJcoEhpd8M4jd0Coj+IWtLm4kjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759706; c=relaxed/simple;
	bh=1FAQORxONHUgFlOsVNXR/6UEXfqzylDArK5bH8U//aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufQB4YCNjVGTmilvhhMcrXz/qwYnKPZthJwZimx+es+tv04LuYDVVXmiN9LTK+GPOV0JGd75BezgLwls1BJooQKNqUTRd4LDgvoPGVodc/YkBxwHMZYBJeM6KtCeqbsm6QtX5qqknvz/HFqNToocKIImDv5gtrJPl4iAFnzpobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ipE7YCAF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 777E540E01AE;
	Fri, 28 Feb 2025 16:21:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZYzTotK-1T7L; Fri, 28 Feb 2025 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740759697; bh=4hiEodTIpOmuJ8vfIFQijFMswHXDQSYENIDtnab/Kdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipE7YCAFjk5cfaw6WeoHw2lVk7Fn97RoqLBxrkPgO0Ijh2q89I0LqCTNuVXUoXRX5
	 JypU7ab8057PMwrz0T/yds2nsmTezlEvPdrwvp2RrDfFy7t3kZA6UrTVp3lxm/JYCl
	 Icii/svJuKMZoeKFsV+DC5wafEMe4baMqGqedw0EyaEdEQpeejO0/y3E27IJOvUznS
	 g3+CLD+1CXg2pjv6xyE2VviykBw/dip8AXX6eeV5DH1N6M18Q7WxgF7wZJcw5fv33I
	 zJaoIx2vZGEjSeX1iFgmw7/2mC72Ja/BbGFCKRZSDRsy4HlTBVaxNja1moFN876SEl
	 KSduva/5Mr9vvXKVcy2uM1pAR+nM3l+cK4yan55zJuGgoQQqKohuuzWr8s1yVD29fS
	 HcQ1IxHFNmMV7m0l41r324ZWrKG5znLu0CKT1XUTqnmOuT1sJW0TUn+GPDv4Mcul/z
	 901ny9/+YY8CxOevlKEYeuzBe5nnatLAfjYiwdZsAmqXtfJWBiQUj7/myxhG/PoHx4
	 DTp5Dpv4yLfMwXq0XCHguxZpeplQYAEMr1flPLlykdymc7TedN4lqJj4c/u3SxaxR/
	 SDfJ8KCrwiaaF3Pl6YsroueEDNlCbvWFqrbioLHDUwTKTZQHP3K8RBZs9UuUudoisw
	 cPdlArekptvQbS8tvYvfmCWs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED27040E0173;
	Fri, 28 Feb 2025 16:21:18 +0000 (UTC)
Date: Fri, 28 Feb 2025 17:21:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 02/13] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250228162112.GDZ8HieAio1EVer94Q@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-3-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:37PM -0500, Rik van Riel wrote:
> @@ -1139,6 +1141,10 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
>  		tlb_lli_2m[ENTRIES] = eax & mask;
>  
>  	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
> +
> +	/* Max number of pages INVLPGB can invalidate in one shot */
> +	if (boot_cpu_has(X86_FEATURE_INVLPGB))
	    ^^^^^^^^^^^^^

I even sent you an *actual* hunk which you could've merged ontop of yours!

https://lore.kernel.org/r/20250224120029.GDZ7xfXV3jMjnbdbGl@fat_crate.local

What is the best way to convey to you what needs to be done?

Next diff ontop:

---
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9f48596da4f0..0e2e9af18cef 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1143,7 +1143,7 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
 
 	/* Max number of pages INVLPGB can invalidate in one shot */
-	if (boot_cpu_has(X86_FEATURE_INVLPGB))
+	if (cpu_has(c, X86_FEATURE_INVLPGB))
 		invlpgb_count_max = (cpuid_edx(0x80000008) & 0xffff) + 1;
 }
 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

