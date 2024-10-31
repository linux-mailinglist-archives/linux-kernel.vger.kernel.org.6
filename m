Return-Path: <linux-kernel+bounces-390335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B819B7887
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66E91C240E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F21991AB;
	Thu, 31 Oct 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RyDYapDX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFE13A25F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369937; cv=none; b=iBL5Q/BWqtJzCu7opE5Jf11JvqJrj+DSS8gb3WOHQNsCXhANcL3HaI+PsdI9yGw8kqz6AeOADXVGPuIi72YkzEEEof0xD6dIwQzqwbzwCk155p93YHSaXo9RAutzLa8y6Jquo8qjOXJwnO6TWROlZKmE90uitvtUhm+ere3IRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369937; c=relaxed/simple;
	bh=DMVNOjJWyJ6qzUD/OpC/GpqXbNgwTDBiVID4NAMcG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8GtNL5h1Y5ugZcyvYuL+YEBbDehBPsbxixtJSmDK6ye7dl32qDjUlsMGxw5YWJEvtZEkUVDY9FO6DXM6KBkGdxyB0Te64CLBpzd8wxNX5iOMpc/UnxU1q0lNXHNk2jYtH/H4XqvGToMaAe7O/IBF7VVOuGHrAVso+DS0X9Maf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RyDYapDX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC22A40E0028;
	Thu, 31 Oct 2024 10:18:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mWzxUZWMTTdQ; Thu, 31 Oct 2024 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730369926; bh=wx99Nhx8DD4hVamni6rdJaJu90grF7S2SAo2L7F/RjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyDYapDXooKT5ha07FlKwhZrKR9Lyh4fIY8/N04EeS/eZ2XRET6bSDv60/CRdooK2
	 8ZsLY85015eRPO4pwnFugLSdscM+v1hqemtUNOF5YumofiIIxJT/gFb5g4pGY6My9e
	 XpphfRftw8xaOAHZqUoivYyPm58UEnMczcuFtQkIPgktlBVWM2hryiMFxZ7R8JQWRd
	 6gK50uqxjzfymCGVJKl8+fYNsel+wFGJPtuA/h9PPKiIDzSYiOD+TSqt51GfF54spt
	 0XVxUVkASYGNARyBp6YuF2/vQCAvzdSyJuiEyEQ8IV61pcog3vIc71itiN6JgJw8+A
	 RGWd8vFEG607wIxf7qK2AKNXu9vSQcDhay7PqHVict7iqP4xdUVRTboOqaGVBdbI64
	 fCl01XqlSQwt8NpYuYCxOqs1U8AllSopfNKkvlFl+LFep5D8sigaHad7u8dhmTijQA
	 DL8ZIBwriTVYQZstWg3/F8EP05U7gTFsVD7YygHg476G7OklpfTtGWOCBm7YqkxnkF
	 JLyaqA75b+gGmw+7qpM1HnOADc91Ov9DV6uSwJFuDhPbOv9d61J01fRM+3ufRA95Rt
	 r1TFo7yZzfqd69kUbAIc9NMol7Ttb1Y9nljZ+SO++pgv1QCXAUkXVDHd9afWbYkMe1
	 Nq7BRfwrci4ODbIxADjY4aZI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF2B440E021C;
	Thu, 31 Oct 2024 10:18:40 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:18:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
Message-ID: <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>

On Wed, Oct 30, 2024 at 02:33:29PM -0700, Dave Hansen wrote:
> diff -puN arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3 arch/x86/include/asm/cpuid.h
> --- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3	2024-10-30 12:26:59.222216332 -0700
> +++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:59.238216364 -0700
> @@ -19,12 +19,12 @@ enum cpuid_regs_idx {
>  	CPUID_EDX,
>  };
>  
> -#define CPUID_MWAIT_LEAF	0x5
> -#define CPUID_DCA_LEAF		0x9
> -#define XSTATE_CPUID		0x0d
> -#define CPUID_TSC_LEAF		0x15
> -#define CPUID_FREQ_LEAF		0x16
> -#define TILE_CPUID		0x1d
> +#define CPUID_LEAF_MWAIT	0x5
> +#define CPUID_LEAF_DCA		0x9
> +#define CPUID_LEAF_XSTATE	0x0d
> +#define CPUID_LEAF_TSC		0x15
> +#define CPUID_LEAF_FREQ		0x16
> +#define CPUID_LEAF_TILE		0x1d

... and just to confuse things even more, there's enum cpuid_leafs too which
start with the "CPUID_" prefix too.

Pfff.

I'd like to unify them and I *think* kvm_cpu_cap_mask() should be able to
stomach that (or fixed if not)...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

