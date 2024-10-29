Return-Path: <linux-kernel+bounces-386834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E149B4871
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58320B22FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168320515D;
	Tue, 29 Oct 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TPEdzcIw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3A205151;
	Tue, 29 Oct 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201849; cv=none; b=iZrf6BbCHjJPQCSN2WzOoEIT2TPC0TR4n98yaZsUmyENTg1+pY6ydTkvbxkVeIQdhKxawbVKyzfYoxX++ROTk0YsJGJHioIsZk2sr18bFk2IP3A87GAbnCyrXw7WpsZ1RdIqU4Hw6JBO/DhRI1P1rF44zztibZPdZyy109VM2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201849; c=relaxed/simple;
	bh=57Sx9PTEFK++KLP+ahxoeTLSm5WWbmfZd6tVyMNFZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCHJenx84w3Y7SVLcwzqTqekVQmbxaD/VBl5uQ+PBqT3iXlBuuuV0yE1ebEr6UL14NTv37Q8v7Ebrm1pSdU3S/1W56DrQMa13RLr2gU8+XGkH94rjjwiotzmuEPxVDYO21hrx/fLP8+nOBSbutML67nYveLywNcz2Co73ij6wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TPEdzcIw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 27BBD40E0219;
	Tue, 29 Oct 2024 11:37:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IZhXHwRFY4rV; Tue, 29 Oct 2024 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730201840; bh=eCpAktyIiVGESsEQ9DG1nf4m9PsJ6IeL20ZQjcotDag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPEdzcIwfFmui8gc2r+UzPwHtc6nudE5/aRg29rRgK1yCrCcOshIINfBXh4qllYyy
	 LmRO2JzKVQHFOrSWYh7iGRceAzJMbnrMKI35jjl61CxmopGVT9miZ4pDB+T+PpCf+q
	 dx7EYxnl+aEt3q5ngNf9caM1HDbpciCS1FNVApeKakOyNlm2j8ie3qDUMjevtpgiDr
	 9sCVealnm2UTDZtzd7NmhHml8C5e9O8CThA7dtIInFTEhtcRPnTpTMICF3ZbVXVZ6A
	 KUk2JXJnbAPdqSAXZB7wcDmrMb6XC9hKvvhpqs77wfBBcd0nyZ3idONU4Rb2WLeLqs
	 28Az8MIleGVXNOW89iSV2WhgWSUKsh3ZKJ5Np24SMdkeATrF6GK2tchJzwg76MZ/Cr
	 4I/AmE31gu1TNeyKuaMKd/mVD/+8juOl/Dc3rONgwBPvWOQdARYbW/QEQxe5sfKEJD
	 T6yRfYcbWwXXiYsM9Y58YhxeraM8DLVIPeosYhaG1t779kPGb7bdHsU7utUMZhh4wU
	 WKrCkxAIa1mNlPD9MP1ygxWyy/ITOy3p91UnOxP4pVBiGozb0GI1nXYW/BqWWvOBP8
	 ViXOA1/CIM3cL1V1m5GoMnUgJf90yVvlXTMewKa9TD5fHHR95G3zhtIFyVuhwS/Ma9
	 yFwWiCYdEukAAMISkCsc1VLA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2BBB40E0198;
	Tue, 29 Oct 2024 11:37:07 +0000 (UTC)
Date: Tue, 29 Oct 2024 12:37:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
Message-ID: <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>

On Mon, Oct 28, 2024 at 04:50:35PM -0700, Daniel Sneddon wrote:
> @@ -599,20 +503,70 @@ static void __init verw_mitigations_check(void)
>  	}
>  }
>  
> -static void __init md_clear_select_mitigation(void)
> +static bool __init verw_mitigations_disabled(void)
>  {
>  	verw_mitigations_check();
> +	/*
> +	 * TODO: Create a single mitigation variable that will allow for setting

A patch which introduces a TODO is basically telling me, it is not ready to go
anywhere yet...

> +	 * the location of the mitigation, i.e.:
> +	 *
> +	 * kernel->user
> +	 * kvm->guest
> +	 * kvm->guest if device passthrough
> +	 * kernel->idle
> +	 */
> +	return (mds_mitigation == MDS_MITIGATION_OFF &&
> +		taa_mitigation == TAA_MITIGATION_OFF &&
> +		mmio_mitigation == MMIO_MITIGATION_OFF &&
> +		rfds_mitigation == RFDS_MITIGATION_OFF);

This should be used inside verw_mitigations_check() instead of repeated here,
no?

Also, pls call verw_mitigations_check() "check_verw_mitigations" - the name
should start with a verb.

Actually, you can merge verw_mitigations_check() and
verw_mitigations_disabled(). Please do a *minimal* patch when cleaning this up
- bugs.c is horrible. It should not get worse.

What could also help is splitting this patch - it is hard to review as it
is...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

