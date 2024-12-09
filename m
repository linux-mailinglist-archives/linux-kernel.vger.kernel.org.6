Return-Path: <linux-kernel+bounces-437188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFEF9E9023
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F01885E29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE116216E18;
	Mon,  9 Dec 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xoiz57BE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0842165F5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740191; cv=none; b=J7h1LZthLCypRzZ3Q2/9Ws1c6VCWjGS1Vucowv46MtUL07T3GFXV8wiSxTDVJRexkqw2Nbhx6pzLXjvKBLMGzqTJLHtb5Nda+vecKhSkS4T8syIezrbpsq0HVR56ieMT6k4hpK0YqNw1sKqQu3Geup0pTEitvPHANkF5Ay9Mn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740191; c=relaxed/simple;
	bh=5LTKHiJcbw4YCBJ9KIJqbEaRIOfOH6Fmu/Rvj76jvkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhwtnJLZjoAtKXDp+Q04IhLgWSpscO55ueOA8NHjoogzkl1aht0eKGpTEIUoGqfjpQC6cmuBwVMNITFCc/X0oCXJ8dcb+6IJCuW3ueGNLgou56Hd3y1zCzUSPqHGaux6+ErrJOP7doMjiD8Hw/yGmsOQ1m9MXMRIrtw6Hn2vxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xoiz57BE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 218EE40E0289;
	Mon,  9 Dec 2024 10:29:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BHNiTCjfdaca; Mon,  9 Dec 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733740184; bh=hQLRlqibdiMr9SiNfFVGO6Bc7oaZfVzNdqvOBbRU7kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xoiz57BEuY4jh+7r5Cl+Ar6t2L3895N/P+jwFeE1iKw2aR9z9II+NOd6NzgvjXEh1
	 o20J9UCWR9zddf4MrbaZeWrEq/SE5FRnaqumwnKzP+h37Jul20/stGUVBD8+jPgteZ
	 HORzrBKWLnWZ/NgiU2LmmSwEMkqVOwWQc1VWYOehm7TrrlWsRnrvLgwe8WIlkmcyoT
	 u/cXpDGC083reyhBDoiFIKwvEK0+DfDbNFLAngTsIN5mLnE/IJC7ykrPfAkDXDa9rV
	 H97+oZdtdALUKwgTCvT+qlWWDc7NGl+4iFkFoeDVnBCTAjFDDMQd5udRUjIV34st+A
	 AJvQ5/6P+gRqwQTBE5r7cbpG5Gluplxe90Q44dhEtLSgEwmNU5EIAR+KWTlMFNLzhC
	 ewnAHiX8jQZ9eV2iyglck/e5z+n4O76QmFnbZZpdqq7epvJtq0WN3/iiTDz5rHK9AP
	 H4LJyQt96fAG4Ais9rTHir/aMX3uGfkb7VO21lIDBRwtGTFv1HbgR2z/kGw9YUasbY
	 pviDhPnOgVr6QLi2Ih192/ZdzMdrAsS4YQa8S4+BgGxWJ+fXgQ2CVEJpeMTS2rOJfu
	 FXO6Tq9AbmNCQ+StsPJLJRsP7Vch/cipE+A2FkGY6RXm/lVpd2cq1JNotbojkLt/qI
	 qz7Jh+7hKjJ9Qtws9LztOwWE=
Received: from zn.tnic (p200300ea971f9346329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9346:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4A8B40E015E;
	Mon,  9 Dec 2024 10:29:36 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:29:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix build regression with CONFIG_KEXEC_JUMP enabled
Message-ID: <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241208235332.479460-1-dlemoal@kernel.org>

On Mon, Dec 09, 2024 at 08:53:32AM +0900, Damien Le Moal wrote:
> Build 6.13-rc12 for x86_64 with gcc 14.2.1 fails with the error:
> 
> ld: vmlinux.o: in function `virtual_mapped':
> linux/arch/x86/kernel/relocate_kernel_64.S:249:(.text+0x5915b): undefined reference to `saved_context_gdt_desc'
> 
> when CONFIG_KEXEC_JUMP is enabled.

Hmm, how do you trigger this? Care to share your .config?

Because I can't trigger it with my gcc13 and CONFIG_KEXEC_JUMP=y

It would be good to know how the 0day bot didn't catch it either...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

