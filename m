Return-Path: <linux-kernel+bounces-575837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66DA707CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4966F3AC12D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35125FA0E;
	Tue, 25 Mar 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XsT9JRS8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5F1A0712
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922718; cv=none; b=MtUIPARsdXwqC+0q7KrsD7BvH0HN+KXULbTbMKqH9Z5lcN2e4UzRVivZzugP5G82DoSy90s37+oCZolG44R1Bbx1J1lsjfGJiibxmkcqawgy4jVNWzAQLo75kX/4/4y/1seWuoDQE1IDZgGVa3kSNOamZdBgem+ocNhWsCn/4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922718; c=relaxed/simple;
	bh=fWCaxP701fGaI+6q8qxw0cGClVOtYSlMZsXQMmE+gVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIGeaitfZf/qj0xBdfd4kdPZXtn9jZ2d4AczPClF1+bqUh7yG6vS8PYiY4WdUqW5yRB9k0QWk8uxyE5WNI5+sDPYC0MoMZkro5XQu0tTHHBeTPtIa7PQfeSZ8IO2M6z/s6+R2cBRmj4bsJITiJcpg65IaUVgB/OmrWD2Lf/EcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XsT9JRS8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B62440E021F;
	Tue, 25 Mar 2025 17:11:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tI_nW5umq9Cx; Tue, 25 Mar 2025 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742922710; bh=Bdjf872K/W2kIK8ecmzSm5sDEE6fjWUc4s3o6FpYq6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsT9JRS8WWiRhsBpzVynhyd4ie0djlbgnrZ/lm5WRHE8BzdS8M3KI61UVKPIA1AxF
	 J2r9dnqi9KiVjS+uVFFGfceadj7jGVgATVZS9Anqfrsh36McUTXAoYLDHTAZ0Mm7jT
	 8PsD152WGGQPKdwTYKNuG4VfFDpRl6MN4m3quqc+q4+s0L6EOsQvDSFSrtFUlvRN89
	 hWJXEzBz52Uw5U9tGyCcEWEMfQMniR848XzuK3TWDfprQFbNDyB/lz2FB32oZyGbe/
	 Qmejgo+rkDGKCATgAmfY8q6/yRuxFvm8czEqmeMyWuby75gaunQ9RTqkR+Ud0zlFiV
	 A1Gmbr6wDyVlxgCZZexI0PA91TMZRLkYWYlKA2RyO3w0WjZfpkmwlkXrLn47GcbIOt
	 iXo97tQMffxJYH/DAtl8307A3kCSgc0iZBObQtu1N5Xwg77Ki/GYcTzqumdkljtb9c
	 /FpEsBP0+TEyA+GFta52AcJ3PBa/gg0ClF1l89VPMv1xWEr10iCLP96iejNv6r+bdp
	 C4gcAT4k0wrqZg0fO9Te4dpBJUOATww16CAXuBamLQRdlHvo/XCfGQC9fBzEkfmc0H
	 5WSmvekcAxvJUrcrYkHMKuoRw/1RRDiVmAd0EloM0s0sNA89YxXRbj8sog2zN0s+qG
	 D+eMYw/+PGlf8NuXyWPQUO1U=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAFFE40E0214;
	Tue, 25 Mar 2025 17:11:42 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:11:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip 2/2] x86/hweight: Use POPCNT when available with
 X86_NATIVE_CPU option
Message-ID: <20250325171141.GDZ-LjzaPbAG1MwjZi@fat_crate.local>
References: <20250325164854.199420-1-ubizjak@gmail.com>
 <20250325164854.199420-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325164854.199420-2-ubizjak@gmail.com>

On Tue, Mar 25, 2025 at 05:48:38PM +0100, Uros Bizjak wrote:
> +#ifdef __POPCNT__
> +	asm_inline (ASM_FORCE_CLR "popcntl %[val], %[cnt]"
> +		    : [cnt] "=&r" (res)
> +		    : [val] ASM_INPUT_RM (w));
> +#else
>  	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
>  				"call __sw_hweight32",
>  				ASM_CLR "popcntl %[val], %[cnt]",
>  				X86_FEATURE_POPCNT)
>  			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
>  			 : [val] REG_IN (w));
> -
> +#endif

A whopping 599 bytes which makes the asm more ugly.

Not worth the effort IMO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

