Return-Path: <linux-kernel+bounces-196985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9F8D649E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79094286F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B114502D;
	Fri, 31 May 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CO5IIWp2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526891B812
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166198; cv=none; b=vF8JzsrCGYcmsUHUZcs8H14LyEG/EBeqUNmK6zC9fZ7z1PeG8tPbt1xYsCy7tw1KGq1UoChv+PunkG8waBh2ROOi0ngXs8PoP5y9aavhaYM0mX0K4MsdM1patRuVizznaNjbf+K5gwHIQMVkQvcAcuDC1IFsuTY3Zj/zlDPnCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166198; c=relaxed/simple;
	bh=bp3mpYg5aqxQ5h2UJjsRt/+KZ6FiaFeWRlPVXrf5Vk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuboKtdv/+AGuD24guCOn7hqu/jemO0ouOyo/49qetbBUC6v0DbRnUm/oXr1p47ugbHcxG8AdlWawAkKpxLqj06T0u2i9EX2pR7nLn5TRa1e64b5temSTdLBXcKZbIvqBHS75Y9VUemLRFnWyII3uWyFDlVLEFKlwT1GyhCAzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CO5IIWp2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C45F40E01E8;
	Fri, 31 May 2024 14:36:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XTj2D6oU0NdG; Fri, 31 May 2024 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717166191; bh=c3MNzbuXB9F3awfURCkVkL8SA45DpAUdTvwlvfinAnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CO5IIWp2L7NutmxJgE06lLCideJvNYRN/NCTamsATUprRPcG3L84YPnsC/2aKdGPk
	 AL5H7ACj9eQ2bGkrEIJ/UdUzNCSaEmaqOfrqxiQ2dbSygCMgyj2veVkSC2/erqbWW/
	 URAIo53RVd5Ga40IyRozc/CsQuAKkdeHPhHVhUZ/1AewRDpyqdZbNyn/NyKXBTqJur
	 CSbJdjxYP/VX81Z+SmgP0ETDrD/1trZ8rCVk4dYIvnzj6s3PTS0Ag1TbM0u43s4a4s
	 DCEmFw88+/tfVV4aPQdzKogNCHA/cmFuP66kj+S3kFDyaUPkD4uVzQ3Jc+hQujHM1x
	 U5bEdzaCDMI9HfAXcko+iEFzEznMVa5aiAWz2JlBvzsm91MCs15e9PH3QNbMehJHcX
	 5PDCHg7TXlGTK6FBTWLJ7xdAM9ejoAQ0yYMi9E1EevzgYUFGgp+7N+l2kHJDESbEsv
	 8vzrf2TsE97/1bh6KIQftxB5ANZtoCjtcUDyo0+LM4fC8zgcguxBSQQbqoskoWZ36N
	 PxeyGkElVFLAQg11etnhYgNNVzZI3LALpO0YwJcCdB6DI6rpShRJnYkW0EC306dwSa
	 4f+OW0hkS5wwloyLKRA0r9ZKy8Hy9k4bp9IKLUCU+3sunTni8YGzSuggPk4LNfiF5M
	 iY9PHkFrMOHkKZsOiRY5th/c=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5E2140E0192;
	Fri, 31 May 2024 14:36:25 +0000 (UTC)
Date: Fri, 31 May 2024 16:36:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/14] x86/alternatives: Add nested alternatives macros
Message-ID: <20240531143625.GHZlngaQfx6CiJlujI@fat_crate.local>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-3-bp@kernel.org>
 <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>

On Fri, May 31, 2024 at 04:30:31PM +0200, Uros Bizjak wrote:
> Please don't resurrect the %P modifier, use %c instead.

Btw, out of curiosity, is %P being phased out?

I'm looking at

41cd2e1ee96e ("x86/asm: Use %c/%n instead of %P operand modifier in asm templates")

and yeah, %c is the generic one while %P is the x86-specific one but
phasing latter out is probably going to take a bunch of gcc releases...

Or is it something else entirely?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

