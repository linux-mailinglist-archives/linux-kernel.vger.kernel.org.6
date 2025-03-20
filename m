Return-Path: <linux-kernel+bounces-569753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C18A6A72E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F249419C0B45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95A21CA18;
	Thu, 20 Mar 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VfGBYS6u"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6421DFE00
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477126; cv=none; b=ozfjfsGuhAadMc1WEzZcK/kG0rknzCeSoSCVChxPWH745umK2aRGK5XJ/JMKyqJdmzAXdFgca15QOhvqxxRj2bRWpe3fuXihG8ao1zm227eKz8KvDUERvjiHNav5/YC/P8U5SXk29BZkztk2/xOeJkAM3wxHyGGUiMpSMWAliLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477126; c=relaxed/simple;
	bh=CrAvtI+KqPJLCyH+EGcOWM8qTU28nSUxFfDHQusAqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC7AVD2eYoa2CGRplFuBkJ1IWnlLRBFghxnVWaBNJzB1HxcY50Oi5qmUyN8caEW1Y0i6nIA40Hyo+4xIf4777IFb4R2/Piqgvi33484P4u0WZqDFvoxa1uQo+qJEmx09HlukuE1V+uFV56QyTzqrAklsWV4m3SEPWkzXt0jFZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VfGBYS6u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3268140E021E;
	Thu, 20 Mar 2025 13:25:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PeTxtJwwvYry; Thu, 20 Mar 2025 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742477115; bh=3aa+wS37o38K92WJhVN/aqRy0B/qXAhUuUTdFXoVlf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfGBYS6uuXebLXBqF378GrTbYGNoCHQZnd/KGXDNXdOZmknAFXVGubXnh75iVrR7Y
	 sskwPeY8yElZef++/YMkclvBwR8qSIg1Hq6ehXhLQOYVh6ODBgiTXME28MkZuI5Q4Z
	 gYmv3Ah098dvGfQMRepBgZHYD2ZwxH6ja3FtFADVPSsgNY1nUrxzEYcnJsZV9AN7op
	 1S18ZTarWq0pXGqZPt0w9rZXl0G38IJh9uBDZHVBlKyX0v+NoNKL46TjawHsIJBoip
	 JYYdpgzv9PScMAqMxgQB4toO29Z4nTxUzcvXz2WkVgXg594qpDRJVzgfw2cg+6P2uk
	 te129dtV7xAgGRfyweMHCgmPBz+lA2Z6vjBJkhlFjCaykjm1zYmp/lyhszMy0+JRZl
	 uReWJcn2oAIciWKec4wkQt2x1hhnZuiut3S14DjxKvjNYkZDzQ/nA1EUdWE2bmHV3t
	 CiFuWYJp/F9VsynjU+GsJLnmqL7P7z3LkJCxGGC+93vtSo4MWdUDJQpNij+X1i61bC
	 tBXOBO2I0wFSMt4ur0b00TCxiBUrrH6HPpOxSCsLKKYo8CLQgKzLIj8D5/avam+lOF
	 0wqi6Rc3fKgXCmDwdT0HHSkQ8QkJUgfpn85pFOPDZtMOchxZJpl+jrzOZTUFs1X5jn
	 AWt1ryg9hIxF9S50AfmpURX0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17BEA40E0215;
	Thu, 20 Mar 2025 13:25:11 +0000 (UTC)
Date: Thu, 20 Mar 2025 14:25:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nick Terrell <terrelln@meta.com>
Cc: Arnd Bergmann <arnd@arndb.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: lib/zstd/compress/huf_compress.c:1033:1: internal compiler
 error: Segmentation fault
Message-ID: <20250320132505.GAZ9wXMd9_6LB6OKKW@fat_crate.local>
References: <20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local>
 <4C937266-6136-4103-A53C-C313B5DBC676@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C937266-6136-4103-A53C-C313B5DBC676@meta.com>

On Wed, Mar 19, 2025 at 05:10:01PM +0000, Nick Terrell wrote:
> Zstd hasn't changed in that duration, but I'm preparing an update now.
> You could check to see if this branch fixes your issue:
> 
>  https://github.com/terrelln/linux.git tags/2025-03-13-zstd-v1.5.7-v1

Nah, that didn't but updating the toolchain did.

Perhaps some artifact of using debian testing...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

