Return-Path: <linux-kernel+bounces-534519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B02A467E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB52E16181A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AFF224AF3;
	Wed, 26 Feb 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T1MzDpO2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E913A88A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590386; cv=none; b=fmmUNcesWZG/VLFmMf88UyWxcKs/5EPnMXpEsyx5yD4/GFON1IdQ+hBRB75zN9LKHLDxqhL/3fq0xjnnd5pguSj8eaNEqok4nwmga2gHXfMdWIY47iDhzjBp8Fp+Z68buWUVTegq+UXpktiUfFD4jCqdGekTJSnoJhmXw+TGnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590386; c=relaxed/simple;
	bh=jfreow4x4peu5cltRiRpdgIJnVcxQOyP3FAB1RGICvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMe4Qs8m1fsBO+nGOW4kLLrRfxChjkSryN2eQYKoxIYzPybm35YzRkVTuWzUeZOdvxk0PvsOFoSm+d8XBiURH7XAG5xnDiXXHzjj+IvlrOkIrBT3NMxod2C6v8n3IgNDu22OwW0uy1ZW4y+VYYEyiB4YmqwIWgI9SH5InH1OoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T1MzDpO2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC1D140E0224;
	Wed, 26 Feb 2025 17:19:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AKe35hxtWvpx; Wed, 26 Feb 2025 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740590375; bh=NEE8Kn/mXStByvmlnAYapclr15vFcQm13cLONep5OQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1MzDpO2/me2DtJ+WAGYeVDieFu9IJDNYqPUknQyNop+x04uIsH2QwguRh8jxtJ7H
	 lDt8b2eHSOhMSTdUlAnFdtdY1T3o25PtLQQ8yy5SByCgXrEwccp8e51caCLlKDIPHD
	 3TyDxdOpar7c9ZxjNM9c4hbjK1CCfaG+ov26fiPurQ6WMZlu9GNqKsE/vTVic3nGlq
	 pwBBG8RrmGysDBHI0mU5mOLv+GkLqTJe0TJc7GwTxQfGXKvmpD4RItLQDa9Ob3w0AV
	 EAHJV3y4+eQ4ACcgRRGHCj0/N87olN9Ft5RqpgKJ6svKlL4X77SA1Hlqua7c0ahbaO
	 wCUekQW9UHIDwYEpvh5YoMPT0ECfUJpbkTWeewSm45YFw23rGE6T1D4q/KWZILhFBw
	 WLbOg4D9PSQXNxfUePJgIAA/WLO6n5sOPmrpQD80UpCnqfwg0TEcs4mLhCksZ9RKYG
	 hO4JARhH4zptniy0StlX1YhOaCmvpQrUAcTCyuwmsrjuejqMsQNC3DfhufeVKcYXVt
	 lzw8zswNHlax1DtMpHoR6QsEFKoSS93EB2nCsXLpVY5tNc9lsbzsRYnKBH/PKUhIME
	 Hv9mQv337NSFw3/9Cb6CsoO7FOV73TWeSmEH5mGIJX5M0inpMdycsVMLD6hn5GcCGd
	 vafWt+Pllb+52zdt+SIrLu6o=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD02440E0212;
	Wed, 26 Feb 2025 17:19:29 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:19:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 2/6] x86/msr-index: Define MSR index and bit for the
 microcode staging feature
Message-ID: <20250226171923.GMZ79NG_8wDtZ8vyWH@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211014213.3671-3-chang.seok.bae@intel.com>

On Tue, Dec 10, 2024 at 05:42:08PM -0800, Chang S. Bae wrote:
> The microcode staging feature involves two key MSR entities, the
> presence of which is indicated by bit 16 of IA32_ARCH_CAPABILITIES:
> 
> * Bit 4 in IA32_MCU_ENUMERATION shows the availability of the microcode
>   staging feature.
> 
> * Staging is managed through MMIO registers, with
>   IA32_MCU_STAGING_MBOX_ADDR MSR specifying the physical address of the
>   first MMIO register.
> 
> Define the MSR index and bit assignments, helping the upcoming staging
> code to make use of the hardware feature.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Merge this patch with the patch where those MSR bits are used - no need for
a separate one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

