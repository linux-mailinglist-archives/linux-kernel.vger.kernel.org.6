Return-Path: <linux-kernel+bounces-379887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AEF9AE583
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23040B23618
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F211D514C;
	Thu, 24 Oct 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P8c0EujE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D113AA2F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774973; cv=none; b=FwHhUzlNtUhT0IqAZjoT28FL41aw7GWAXUqw9pEFSfAe1tIXZE0OoWmJ9qF2O1CTTOyjOKadFgTDEwsTN0OD5bkHBUxl9qMtjG8HLGkqTRKaecpvx/fbO1m556ehHstaUoCWmQxth3dLiQiQNO/wt8ZNIgRh0/5t2kcJscwXzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774973; c=relaxed/simple;
	bh=9wuvnud6703YzTJAH4atYTV0zU5hlUyODfjK9nlAxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT920tf/cj+BETMnCZmjsJDoIuglSUZp0Op338XkVKmP4T5NCs3zbVUCkD0uzV4WkSsvX3WM/Uz4OfYcgaSMxIaCqU1V9X100MHNltAVDbf96159QBuleYQDtBTJQxG4Nui1VXVIlejrqd402dKDp10LNacSW2AULWBLcO6NUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P8c0EujE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 95DFE40E0284;
	Thu, 24 Oct 2024 13:02:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lHeVMTeSHwzi; Thu, 24 Oct 2024 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729774964; bh=qEtuLErmLc5asX1bnJMv2F0QZfhS0C8+sa3HtFQ00B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8c0EujEPYGAe9GgSXzHOzz/GoCuxCl94qXRCqmmEym0XyQGPfAlvpezlGm+qi+QT
	 ov6Dquqg/Ac1mIGlXBiH2VpSI1q8cwFQAVGaTJJ0aMLfGFwJyAkPy+IJ+ausaeV6fO
	 MxzcVzvleDkBkPxjAXyj0xUR0+SJeUdRD4QypTjcE3mhZjiSi5NBmEkRUO481P5Ve+
	 XDQgG8NrHcu1e6LJ7CuueyfCGIrIPwnmEahhNvNA2QbINVwFq7oaDzFk/sqNNlFVuO
	 lfsr7qzg3vteiepd3OUOX5qFGqaf3OsFjD5XkcLG0cMAuZ2Kd3V8YcxLJA4VkN0cJ8
	 lVobsE9l2h0DgbshN6Vo3RaMS6Hct+OM2bkLxL2EOTPXLBvyRXi9CRjUStE4ieJS/P
	 Bb9Edt+uMcAfHv96HYAOSSvZqTA5VzxL8DrmU7nC50UYn3nrzYtg/qsrvS5+V2tyyr
	 +aKmKTsx+mm9PJerOjZoq3VOu6Ukfui9pEiYBEBpWKaIXiLdnkOtNNL7Aso1G24mX+
	 wOxUp0/ez0+8RZ/HyQ3ZlvASH6kjyQefDFSshrvTzmZQK3qUZ/wtrlB0fogMhvQ1MM
	 qFyUu77faSUeiMFcwagKKcv0tVQXs6UfNBp+ireETzO2eYGEjAkn99lYvrjfo2RVoF
	 oRvMN/Af+yQa77fa+XeQV21w=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB03940E0263;
	Thu, 24 Oct 2024 13:02:38 +0000 (UTC)
Date: Thu, 24 Oct 2024 15:02:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024130237.GEZxpFbaCWGCKMWaNR@fat_crate.local>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
 <yuxpa4k3hdpplol35cdbvcaiwbi2i4mwwkww6tuab6loopdezm@qkhzxo3zlf7g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yuxpa4k3hdpplol35cdbvcaiwbi2i4mwwkww6tuab6loopdezm@qkhzxo3zlf7g>

On Thu, Oct 24, 2024 at 03:32:32PM +0300, Kirill A. Shutemov wrote:
> Although, it might be worth updating end of userspace VA in mm.rst with
> -PAGE_SIZE.

Sure, we try to keep that VA map file up-to-date as it comes in very handy
often times.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

