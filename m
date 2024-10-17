Return-Path: <linux-kernel+bounces-370044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A49A2688
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D191F21320
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871971DED41;
	Thu, 17 Oct 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IChV+AMP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000D1386B4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178789; cv=none; b=DmYUnvcXAmhDoSHSibztiSj/9aUYtyAt1O5s6OoFz+Xo0O1uZ/Nf4905rfUILl2pG/+gpbZlsMvXwn3RZphXHYfrpZnore0PTfW/kbHeEOudzRW6lddWJ1rfvoHC3NTjFu5XEPeof3FmRhd3/q5lZrvxofliFW9eK/2A9x/2ZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178789; c=relaxed/simple;
	bh=ZXoCe1q/t4AOpX/1OwAc1gYOxGdRpTyM+HyDxRk1tgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW9ofkUSdBYOhd/7240H3+R25P6b0NiyJBNIHdgH9aHgClR7WTM5vRQrfO1pzSTQK00AaU+Yjan8sd9fD8NQwyQxhEzwcrUCjcb/4++aovD6Bfk5FH+rmd65NYKc7G6YNhSeXFPhGVsd8LFGXS30YrHKUiBaNDXhzy52RQIbtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IChV+AMP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8107740E0263;
	Thu, 17 Oct 2024 15:26:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BW2z_0VrGvFT; Thu, 17 Oct 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729178775; bh=WsbRKK2PlAxFhWaznYS34LSEcmmVsVnA5klxIAtFpUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IChV+AMP4+RC8sdmeI7MnkN/EuwDKN02e58gCpHrLGl03maYA83DeHZJ2Yvi9dJoX
	 NLYUkA3Ebk6C3MFkeTBeFHyw248hGZmnKX4jcdIUtgiCbmpcAN8Pa6lYdWtjgIkK0D
	 qNeP2lyjXEC9B3aB8sKgC0xmyYK1Ysh4qTOfo4lMdOlSu5CQHR08HupbLcss533hN0
	 HNb+eR1/+HCySErjD3pAnFr/Z5/CpGjA7LDckrc50h3hw+f6RbeiaquvaCcFAil31S
	 5zO1Gw1tEFCCvo9hBB8abF8FoSyH8XCbQDycz4VGlOQht7hCmqP25QnYoTFQAjjXNn
	 mKDOA3tMws5XptxTPfT7erpzVSszwpMl0S8ab9T1h88EQZRScyFh+cQswlfXmteLw/
	 wq+8pjOYsdSzOjNy3y2JASUVrc7mNMJuyYtEvRrHiKW787X4UfjP1hJbaAknWyNzKp
	 1v/Rv89vErX+/tC5MWuRocz1znTo9Ut6YEcPpwq7rfPBLM9eI+dqeBbWqqpTDs8dmE
	 vLNcgCKxiF0D1xNCSmE4ow0XLqC+eyHbsaZeUKfSFKZl9NjI9+TKJPGSPnjWBpXqMd
	 QZ38tzMZto3nAol5WgkevdKaFc5KlYtvjZ0YceeE3yRJ9i1mqbpOya0Ph4wIPPgIQj
	 I//HPwn3hbW8bSi/jaTVg9QE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39F6A40E0219;
	Thu, 17 Oct 2024 15:26:07 +0000 (UTC)
Date: Thu, 17 Oct 2024 17:26:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Message-ID: <20241017152601.GAZxEsid01FYKqwnPA@fat_crate.local>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>

On Mon, Sep 30, 2024 at 10:22:10AM -0500, Tom Lendacky wrote:
> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> +		int ret;
> +
> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> +			     : "=a" (ret)
> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
> +			     : "memory", "cc");
> +
> +		return ret;
> +	}
> +
>  	e = __get_rmpentry(pfn);

So dump_rmpentry() still calls this but it doesn't require the newly added
services of RMPREAD and so this is looking to be disambiguated: a function
which gives you the entry coming from RMPREAD, I guess the architectural one,
and the other one.

IOW, I am still unclear on the nomenclature:

The _raw* entries do not come from the insn but then what's the raw-ness about
them?

This convention sounds weird as it is now, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

