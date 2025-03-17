Return-Path: <linux-kernel+bounces-564800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D060AA65ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057BE1890541
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A511AB528;
	Mon, 17 Mar 2025 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WH5iepXM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869321A00F0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232760; cv=none; b=irYNw4za13qYWMdhPdJX97XRzSejaGTjsxoyLSohAJVq39FaFZm3HGnbd74t77D5zuITJoDjc9FYkbUyh6A/2XW9iUbToVakfaP9Z1UhmT35AkGLIo9K+A/4nt10272YrxZxbIS6+WujDy7Wn1ufcZHWk2xDtodK/EEQO2bkhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232760; c=relaxed/simple;
	bh=ehYg2/ONqk8/XLmoEtapE5qDS33Dk/PLd1UqYX+muWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNAqFkBJ2dpFcAKelr3puQph47rRBvglZ6jMeyOxdvHKTWuHrjpG1xcmzLomZkojBTkXJbCiN+hDMDcHQw0z/17P6LgiPBrsrNWyJ7sHEtmzsxCOhhSYrYzDgORHS3Fcsi61SHl/27UjiNKh3ZSKovN4lUF/I+N5GR0cpXuJuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WH5iepXM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 016BE40E0196;
	Mon, 17 Mar 2025 17:32:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Eo0M264fjHUB; Mon, 17 Mar 2025 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742232752; bh=N+vz/El3SrhGmEy1RKNR0F5TTNUav0MIz5A/z8IeTBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH5iepXMEKBW0KXDr5gAbvCU+akjLByJvOTPckQX4PHrDubv5J/umCQumiFeet767
	 GaWM1U1lBh7fEs6goZaa9jLgCcPD8TY4nKPXwvWBBXrvHbvBt8kEyebAo+351pJV0u
	 KBb5cMKE44jJqu5OtzYzK9LLGOXzAwTy6P2T3akISC4dFykzmiMwmwpvlBYqOuhs/n
	 t9W+llJOvQFNHUjKFKlk+U8dKdErxpunA9XgNCgVp3msOC5GTZHLDbxe2/KutaSyD3
	 pf50miQ5nzSuDas8mRdG6sQxvALpjRF/f+daKaNAxSutYo9otsP1Cm59EmiJIodyqN
	 Bsi9sW+tNbCbqyCZmQU+dSVZ3bQzpnmaUpZnnCm8H7vHd/5TBnglpkyb1/tLxpqqRT
	 MifubnxUiVnn5V+Lx/jYsC2meFv8HEyqBZNZdTUHfHb+cofQXqV0/+P+CtGi0DMjqN
	 jFYbtxFSZmVDiCyKQQDQ4/afGRdDzpX9G67DiUiEG1DL4u87AygrQZO2e63q4d/oHl
	 Z0NiUib4wEr34b4JvGH0oWtf670Dgax1fyzklJu1D75YDTXoTwN04dJpctJ8wNkI/K
	 nKQ0Hl+Bnx/BIs1xW1oC33ceMjhLYWWXLoZ8es2GSgtA1QrcjdBPl+N8tq50PVtgu8
	 ZRgK9luTRs2oQGzHyW05zTwk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFBF140E0169;
	Mon, 17 Mar 2025 17:32:21 +0000 (UTC)
Date: Mon, 17 Mar 2025 18:32:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317164745.4754-2-darwi@linutronix.de>

On Mon, Mar 17, 2025 at 05:47:17PM +0100, Ahmed S. Darwish wrote:
> The pattern to check if an x86 vendor is AMD or HYGON (or not both) is
> pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/processor.h>

So if we need to check "intel too", we do

x86_vendor_amd_or_hygon_or_intel?

Nah, this is silly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

