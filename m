Return-Path: <linux-kernel+bounces-561506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DBA612C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EBF1B6397B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E081200119;
	Fri, 14 Mar 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JwXjMUAu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C191EB3E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959266; cv=none; b=YbWMrcbPWKMZJoO866zr5m4ckqb/UtUCKc+yy9AMg4ir+Jn1zyH+JXiD9mf2XpS23k/WKsK1ONMGmRKcc7FtEBdvsRA/ACchtnzDiYEXSKECTekXpxzYVfBNmfMYI6O3PwuSBKDtLwpCcA9g+0YXCd6jgk+4Uj2MoFqLSw65Hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959266; c=relaxed/simple;
	bh=hEWNd4+ZbADXTs7pFR7y0qjRbhEivmqNY5fnmLcsHuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lip5bybGInT0OsHBP5JrEEEGCKj8VxPPfq/XIEDTQkBE5gp/GW4CvzbI7rfQwcoPEb78FDM4RpABNHYI0Ri/L7hK2L/TcikjP8Pf7u1a5UsUqqWfPMYKQ9QKlFMq8kw7Ow//R4GZY1FTOCnIRRJZJNsdBi8HHUuo3jsLVqQCPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JwXjMUAu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B766940E015E;
	Fri, 14 Mar 2025 13:34:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6VzkRisj_CbX; Fri, 14 Mar 2025 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741959259; bh=5XLbc6mtHdBLfYeaOQAZ7qgWMakane4UKzHxMIhvsKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwXjMUAugAcXhDdW6TKtABIMLeEvoEMiy5CR9tUFwk5pSOH6llsMRf9IBVCcEPQm6
	 xGr1x4fsBAnO6y/l1SFH4w0jzQweHrYtTG0sGtP6BOnXnuJ/NqRNcPMUmUFOd7Ckqk
	 TQ5u5xXumejKW/FWAqszAon0xfXdvUSjDLy3xb0wi75CLwzqEPHi/0pBf3gWcQ2yfX
	 O/Gcxj8mVCGv47upjspTTyark6/wtE7xb+nI+m/AJF4gvRi1E+aS2T2SQhPPZ4cnGo
	 zVeHj6buzGl0seBM2HxhdPDEAk9W4psV+10b/B3Ii3TCmRMs5MeEOQODpW6vvVSUfd
	 XZKplHaJj6wd54wsJyU2e+W2twnL4BFUfCFHoop/DtFmI4B1p1CXeIY3TCVT1b4JQs
	 ircaNqFD5xYtz89NxM7fzR05MxLerc/mxHEm1W1iSnDIuoeYY2AiTzw3BApT1Tet7g
	 lCz2HZoJBQXjI+pmwaOzpgmJBXisT9FFI6aBACGYOUg2H4nKFQ5RCIS8V0sMLwIoGa
	 weJZ4QN0NUcAPVpBKoPv6A7oreMtvEUL9FMJ4bmlBdNUDKm65p7KDFyIKAtf5Qak9c
	 T4biGQasFATp7hvW4fia+E4vKAexsIDNMwXSCqXEMtEbBgSXK/8jzWBlAbs/l4wLuM
	 2QodZDeFQbgqDn8nGmcNGncU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E1F640E023B;
	Fri, 14 Mar 2025 13:34:12 +0000 (UTC)
Date: Fri, 14 Mar 2025 14:34:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 __untagged_addr()
Message-ID: <20250314133406.GEZ9QwTmnwjtX6PiJ6@fat_crate.local>
References: <20250314093111.654359-1-ubizjak@gmail.com>
 <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
 <CAFULd4bwsZENN5eVLXDDizt6+EcdwgnFBaS4b7YjjqzR-Rmjjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4bwsZENN5eVLXDDizt6+EcdwgnFBaS4b7YjjqzR-Rmjjw@mail.gmail.com>

On Fri, Mar 14, 2025 at 02:22:45PM +0100, Uros Bizjak wrote:
> Do you see the removed functions?

I'd actually wanna see real benchmarks which show any performance improvement.
Like this one here. But this one which shows only within-the-noise:

https://lore.kernel.org/all/20250314132306.GDZ9QtukcVVtDmW1V1@fat_crate.local

But hey, apparently it doesn't cause any slowdowns either and apparently Ingo
thinks all that churn makes sense so whatever...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

