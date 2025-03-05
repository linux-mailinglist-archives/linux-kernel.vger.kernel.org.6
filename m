Return-Path: <linux-kernel+bounces-546734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE4A4FE23
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465003AEA1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23B241674;
	Wed,  5 Mar 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VtH57fDq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB6230BC6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176127; cv=none; b=cMynHjylMTqajup4q+eBAxLuFvSzTmgjxUimr0Mi1pmfUbM5F7tal0z7zhMrq5t6TAH272SacD/HDQbhAsrqbyauoeTBmHibUd2i2QqPQ2IDtl8oUtZtaapnA7JCe3+7ysgTuSuIhDl4UjC0ZZaJSkevkh0HPdcCMhSRny3Qv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176127; c=relaxed/simple;
	bh=nFPnaMHDPpXRP0GD6zsxomEleF9ThWjpr/AsEJBGYZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5dnnY4ggVYvzGzvWjLO7zuzvpZ5CCEmAZ6KDwpBpLMo4JwZmK8XwCtuIeAcHXWhcuPq/faWmGUDjNlSjcEn8hIp17zJVfHhsjtzYGidCVvYxyHEDVFu9FSQqe/G2SBdJH33YjgCAZaCdRn//KKc74oGwQAVfV0A0uT5XB91+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VtH57fDq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 40D7140E0215;
	Wed,  5 Mar 2025 12:02:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LK1hFBB4uqau; Wed,  5 Mar 2025 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741176118; bh=w3jS644WhTQzdSpL+ORCFYYqv5biKaCzH+wq3LEiueQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtH57fDqtkt3keBi/TuvJfg/qrgU7xf6qhQK2IF6dd+1rJIMNOwMUELAwnsQ0+sKY
	 uta0LZFwrnh/+2ecNk4U4+TWtvdZPvAzQ/0MQrnpuBqRMeioNkQTPlS67nXxSc25++
	 2cy/TSo3BRlfg9l6VfkAodr8RlAE8rzYqihKLSn0/nFQgbkTTNShCKpiDqLXYtZQ4e
	 VaXo84MQK2MeiCIwYR7Grxoo/Ij7Xl0SLyTmMh26AtgTutxbt/7lcPk0gXI96We0EA
	 U4ax4k024BdZ96vyW+oOVuE+M6WtoSX50z1gEweESaakwSuvAZEU7obD/3Nw5F4gCi
	 UOyJGPoTGKo6CMDhqkovnlxRSS9m44hdUhGTJIh5wT2Qz9EwWTGea9fi1YOR2Vt6UL
	 /RSqhXXQs+b3IG8e02uxwYCWCXLdxch8l16V9g6s0BiWjOfhTA/HuDzNLgQl+Prgpl
	 XaM/eHsAqiDTJJ5OuXyFZcStXGUBQKWRRFwS/dvMT1OpJf746mtz0ZoYjf4Zq9vKRx
	 4hAVPLK9ANKyPFEqB2Z870H6eH1U8Ykk/DSkBixu+r3ZoFsc4GWLy6996yIYbN67a0
	 KgsSqV/5SI5j+S2HKRnLw+5T4flmD1hKE2bft/vg88sCICfksfRZdm8nvKrSKThm44
	 NZbKzQ9X2QfTZUs2Nxqo7LLE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01FD740E016E;
	Wed,  5 Mar 2025 12:01:42 +0000 (UTC)
Date: Wed, 5 Mar 2025 13:01:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Manali.Shukla@amd.com, thomas.lendacky@amd.com
Cc: Borislav Petkov <bp@kernel.org>, riel@surriel.com,
	akpm@linux-foundation.org, andrew.cooper3@citrix.com,
	jackmanb@google.com, jannh@google.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mhklinux@outlook.com, nadav.amit@gmail.com, x86@kernel.org,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v15 02/11] x86/mm: Add INVLPGB feature and Kconfig entry
Message-ID: <20250305120141.GGZ8g9JU-IaaNNgTRb@fat_crate.local>
References: <20250304135816.12356-1-bp@kernel.org>
 <20250304135816.12356-3-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304135816.12356-3-bp@kernel.org>

On Tue, Mar 04, 2025 at 02:58:07PM +0100, Borislav Petkov wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 508c0dad116b..8770dc185fe9 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -338,6 +338,7 @@
>  #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
>  #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
>  #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
> +#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instructions supported */
>  #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
>  #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
>  #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index c492bdc97b05..625a89259968 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -129,6 +129,12 @@
>  #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH

Manali caught this: I forgot this one place yesterday when converting because
of the tip patch zapping and branch rebasing tetris...

With that fixed, Tom's patch with the guest ASID valid bit set works too:

https://lore.kernel.org/r/20250304120449.GHZ8bsYYyEBOKQIxBm@fat_crate.local

I'll push a new branch soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

