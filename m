Return-Path: <linux-kernel+bounces-438104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC59E9CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A89A18878D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3614AD38;
	Mon,  9 Dec 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i+M//xNh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6B1292CE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764722; cv=none; b=sYFAwkzmHFiYz/EXbMvLFcA7J2NPvzEL40yKAoLxfzYa7kRF4kySUBGRRG5A4TtTL9vPI+LNZa9aBANEVjph+FhNhTrKoQ0ieI5PE7Cf00kAKb1qWbHI9+lveTNx4DBEonZTz7obtiMoeQtUmFGGSkXvYpqTTifv3ybdt7IuVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764722; c=relaxed/simple;
	bh=W9xOuGjtz6OhICNl1Rszge6eEGebpP0k6W7H6Z1JwN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By4ixYdDiIimypU/YGnKhHd4DEaxORDkxHOOtRnqmJqascuhaL1tIe46Qv27k8S//farFRYddLehEmemFro8f7cRnoln23F2YtAy58uDPvlciHNk5QZLxT4LKqLrW3hRVeOirXLfUveFfPHQPIdVlhucowF9orD1FT05ee8tXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i+M//xNh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7BFEB40E019C;
	Mon,  9 Dec 2024 17:18:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HJ1TuwYhqtGc; Mon,  9 Dec 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733764711; bh=koq6fwkQDNYMURaDovGaV0+9wFT+IziBEnjnJBarjTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+M//xNhYnRaMNd6hVuuQee1UqmSdU1jUKY08UMFpd0DaXjW1Sfwzz258PWKavj05
	 jkRUlLVy+5RyMIzjxQ8XLSYmrjIq0mFN2RCxu0BLZbIbBeVeaEW7ljtVUxMAJvDROY
	 HyR1xpr22sq5cNykUoDt57RsX5VkuuGAjWJVMjh2NzvQfakJT0NQwpqNvLDhA2I/bJ
	 Aif/lAu9CAZuSV756h9PexQXWUtNq9YITZoBazr2y9jBv7ReLX/Aoy3UW/NgZOGlMZ
	 FB+BTdPVNm1eV2VnBxl0hTGsUja1Nz7eJK2ZHpV9VZdpJjTSVIkpyQYEPmTYqyuIrZ
	 ysqOxkbLiQnB3hf4tvRHk5FbF58OGxwRS8R5W6DgvSDHFgFSgqbM+bJgawhAx82Jd8
	 oD/ttHAOLLLqFJ+DwcPiCRdV/k9MUsbdlqRxTsU2o+DsSqMiGAna2/SLGn8umLSKJ+
	 /u+6h/QxbkUtWHjMpgFc6FHObN4PCGw7cYKpLNKu17tk9zzFkiP4iKdexik9H/v6U+
	 ny9AnDxgs37f11rOXVF7L9m1D0x/kiHx7cVOPotTjUef69hyY76kwlaiqEeOhKMdP8
	 WJkSdQ8dy68MjyyxYZXwbk8uzgURTrDW/TKn3essAajj7ku2bWjgFmFm2B2XN/EzZw
	 1jRa+4aoctwkmtQQ5s7houTQ=
Received: from zn.tnic (p200300EA971f9307329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41BBD40E0288;
	Mon,  9 Dec 2024 17:18:24 +0000 (UTC)
Date: Mon, 9 Dec 2024 18:18:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] [PATCH] x86: Fix build regression with
 CONFIG_KEXEC_JUMP enabled
Message-ID: <20241209171818.GGZ1cmWjBZJJE-mg-o@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org>
 <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local>
 <7ee6d1aff2da6f79e08c9a3134bc8519e991f0f4.camel@infradead.org>
 <20241209162247.GFZ1cZVycGCYJwnMxw@fat_crate.local>
 <9b8f82c0c38093f0092f1015b641c30f2f478e17.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b8f82c0c38093f0092f1015b641c30f2f478e17.camel@infradead.org>

On Mon, Dec 09, 2024 at 05:07:06PM +0000, David Woodhouse wrote:
> I suspect it would be less ugly overall if we #ifdef out the whole of
> the preserve_context code path when CONFIG_KEXEC_JUMP isn't enabled,
> rather than only the various parts of it that actually cause compile
> failures, leaving a very confusing set of nonsense dead code actually
> being compiled in.

$ git grep CONFIG_KEXEC_JUMP *.[chS] | wc -l
10

That's mostly C code. You want to push the ifdeffery into the asm?

> But that's a potential cleanup for later; I'm standing in a massive pile of
> yak hair already...

You too?! I can't see you from all yak hair around me ... :-P

But yeah, one fine day...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

