Return-Path: <linux-kernel+bounces-369962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F89A24F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58077282CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6B1DE4D3;
	Thu, 17 Oct 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DrYrGsou"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC581DDA09
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175251; cv=none; b=DUqw9pwqHBPAEDgn3G4RACOqA5+MCHZcuT40yIPgnMHe9NC+e/jBNA8mZzp0nA2EbYZN4uvvgfM+46aV6HqR5gfd+hOm/GwMWr/pwINaFCQQ3LKd+1N41Uohg5a2Kvx7sqmWjJWTWLKyhvMmPYOadv3wwzEyZ64J15YMdsCER+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175251; c=relaxed/simple;
	bh=C00nGTAtRv8TGq3OiRXVdb8IpoflJUdtx9mCcdmm94w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRJ/dPasOUfI71GXdy+zkhxjaDExHtJs54LTyubLR7XJEvFtB08lIzud3fBnkkzcr5AFUdu6yn/60qDV3bfFPEfIs+y2M2WHeC8Bec7JwqwpSdfPGdvwdKiOziTj0DzjwU6q29hatx2mbUJWaO6mvb+Fwv6psvLFWic+qM1F7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DrYrGsou; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4740740E0219;
	Thu, 17 Oct 2024 14:27:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UWQ6ZAT1KddA; Thu, 17 Oct 2024 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729175238; bh=AsLIA89ilfLtDxPGEdZ24yVmQs4O8Xqg+22pq3GQ4v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrYrGsouJQzmqrfF5HB3yvd0JmHcnRv4J3fJgCZ/5tManzEHZxRXHxISZYTjqaIQT
	 ma4ir7Z7xMENSRadYMUVpjLur1DYwriUdZLCl6RRyDroEyCrKNRqdV/d7J6/V19VRk
	 PysGupxS0hAbubJrx3dGig3M4aXCZIFdn6HomWCBIPQuUQD/KYv7M76KmDwUvpqYuI
	 fJFxyEhxM+ij3vMELlYyzg/nPpugyQ3NyR4PIMts2MQ0/ZLM/+wMHSjSK2cnzXqubj
	 itrv72zQopy4C9o0QC1Ry1vvJtqToV3cry67lMyrudwML8yaMBdtXvfZuyBjfbq7yw
	 XRxhtjHqIHCv99A/468ezsdGo2fnHJVmfvthPTrgEdlOWTlEK6Ja8SZ1sTh8ZYfTqJ
	 3HBFAWXV1SNdO0Nqier5Sj2WynksN1GfZ5RDgDTbtNojmHtaE6AaKyZlbfkHEppPDh
	 EhnhknKBzAwmbtqDxEb7UnX8+h9wG7YL5VIHz51JP5gzqpMC7aYxTYiC2PAvba+huh
	 FaQu/hJ7fgn40J5PVFLNcY6kPo02KlICE6muNW8bfvrf9w5+uFuJJKWEJKAMUZt5vb
	 kXO7q14w10WgDLp06FXjiePjQHNGc5Hikpil3ZXXtm9GOz63mvB+zJo+PUHcgROgYA
	 vEW02VWgWVflhwPMAqDm7J1E=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C98940E0169;
	Thu, 17 Oct 2024 14:27:13 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:27:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
References: <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>

On Thu, Oct 17, 2024 at 08:23:10AM -0600, Jens Axboe wrote:
> Yep, it boots with that added on current -git WITH the microcode
> package installed.

Ok, lemme go stare.

In the meantime, is it in some way possible to catch serial output from the
box with my patch?

It should be dumping something to serial, a splat or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

