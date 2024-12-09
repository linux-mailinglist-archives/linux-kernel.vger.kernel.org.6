Return-Path: <linux-kernel+bounces-438477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7219EA1C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4632827C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C719DF4B;
	Mon,  9 Dec 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cTWSQWhV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774721991BF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782967; cv=none; b=Xn8KaPoar2itf3JWpsL2V1Um2EpNZNpz1SVTbidWoF1gCd3Tw3o87EAneGKBYFhTGyKKdz8wxxLvTPUXSbyUtaJI/zfwVAx1T53Lo7ssXDFLqZ8wrb77gYtWcXVcyU37ds4rYp9EeAdcyLF7pzsvA34WtexNa8G53/gh2MrZ6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782967; c=relaxed/simple;
	bh=GktQMYm37Wg8CfvA44Oj4pBsWEHt9vuv8q8nPDbsSwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onw6QpKtqen2NVf6IWNliD9q3fp+zpZ9dj48fFAEcJIQs3Y9JExhE6qnoQlEovVOELuhHFc/9b628Alsc1PTk9R77pCZKCegbfQXbSea0LTO6lMdznOLNvxywkVNW3mfo8mgDMiOK46Oy12SC1+LyvHTuFNjX7f456WHVqRbnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cTWSQWhV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 829A440E0277;
	Mon,  9 Dec 2024 22:22:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t_Nv5roALjsF; Mon,  9 Dec 2024 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733782960; bh=f9FQY4VtMuIJtMrD4USYlcEYaZpMTlJpZvs0uwssGx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTWSQWhVMxYzycbY0D7CpMys7VuHk8gJ3pt4XjYtui9+vSx6y0aewJ0UyYEBe7i4c
	 LasuACrEHCCYuVXvrYZudQ26uZxCAX94RTWch65I5BOmCIWMe0Z4GSzZCK/BdIOPBK
	 e0JTXCK1bIGVPE9KsFrWyWG9gtDD5hAxmLNdQeIUf17iwTubcaGHz6V7vDyZaayI2p
	 psUIxdlQcKqtI9ZhWe451H47NENhz3M8cOkf+RNvBgQbynydyJ9ju5g9bw+X4cpnXR
	 2M9hqRmle2Tg5/xDNM3YIJzYmfhCFRgVyFgMjS4bBy939OKmvY5J4I0o43SIAb0A+u
	 FsAqVhtwlhYf3n6+oJDKMgtPgQSjyrCDRE4wcZdUsdC9T4tXQOv1qXxiIJNJZdTl3e
	 QAigDngPI5ATp2lgS1LqhlqEvQexUOFlPy6ZXiuFMjnMfWS2f22hLXA6tf5pzaG/2F
	 dvHZ5om7AwkqrG3rpDlyEX9R5wM8pclLfK9qo2I7EEGnPMKjMvKQQoEYBhy3zKto52
	 BobxTq/ktqQYn3gyRqUVI2A8r2WyTTVbltmRaOllDB91FpRJwzboZE0SzCuFudzIp5
	 OGBC8mjOy673mMJbIVsSoh6vK6zV66hLyq4QNC6YVyeD8Ci+OzzYW4GezmlNrqDUMQ
	 QcVJvXCS3y8UVRZXhfJRJuY0=
Received: from zn.tnic (p200300EA971f9307329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF36940E0266;
	Mon,  9 Dec 2024 22:22:32 +0000 (UTC)
Date: Mon, 9 Dec 2024 23:22:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] [PATCH] x86: Fix build regression with
 CONFIG_KEXEC_JUMP enabled
Message-ID: <20241209222232.GLZ1dtqBUEm15bNUY5@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org>
 <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local>
 <7ee6d1aff2da6f79e08c9a3134bc8519e991f0f4.camel@infradead.org>
 <20241209162247.GFZ1cZVycGCYJwnMxw@fat_crate.local>
 <9b8f82c0c38093f0092f1015b641c30f2f478e17.camel@infradead.org>
 <20241209171818.GGZ1cmWjBZJJE-mg-o@fat_crate.local>
 <16E951B7-155C-4E84-BFC3-CAA9EC765960@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16E951B7-155C-4E84-BFC3-CAA9EC765960@infradead.org>

On Mon, Dec 09, 2024 at 09:52:57PM +0000, David Woodhouse wrote:
> Already had to. The question is whether I'm content to follow the existing
> precedent and put the ifdef around just the two lines of code which don't
> compile otherwise, or whether I want to clean it up and elide the whole of
> the unreachable code paths.

I'd say, let's try it and see how it looks and whether the code gets more
readable this way but let's get rid of the yak hair first, shall we?

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

