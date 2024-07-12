Return-Path: <linux-kernel+bounces-251005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15192FFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253DE1F24503
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA81DFE4;
	Fri, 12 Jul 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YJlHCOnf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61951EB35
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804925; cv=none; b=tYKiySO32LRb7TG0NGv7xMdW2AOimqlsE3/P7uY/x1gS++gbYgVoM5o/MUtYToOPOn/3FmF0QloJVDJlsir07nH3PW7on/7ZSqzNXEDMO5UQx0OnW+VvwMSPpHox3PxLX3bOjsYVDb+FKLq1oc3WaTyGJtP7fP9qPFIeCt+E8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804925; c=relaxed/simple;
	bh=VHr1bcCSVqb6Mo3CrfGKpANto2zUqf0LHkEiaSoPyUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcRht2Kt6kWxGyUkcRXuedVyp8yxeX2hgTqkpQSv26MgK3BrhnIGY9Kn4uoxzAWWZV32RU6WPsoi41pbScW+TDDJ68FiIFEFtV8tgHUKfgw6o4xC7MjozjPA/JZ0MzpSsp0KtPDFABqSBFui1Q5qoHMS3uq8D/v0UyUIVN6ykwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YJlHCOnf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D499040E0206;
	Fri, 12 Jul 2024 17:21:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hPnwujdl2Ydg; Fri, 12 Jul 2024 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720804910; bh=pWvZ9F13yzgk+gnkq81C8CS7Qf8niO7CTls0UJjzK+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJlHCOnf/7bYpuMc4FdfIloed6zctYZBAcPZgrftK2AXqwWPbJNF6eka8N/F9yZ//
	 voENPln2C6YYemt0rswXMIz/iwTgGn9kjh9Ym7jzZjsBdkGUERI1gP2uCuP99ICEYD
	 5LBCM6dFP+EWCETG1z2T3FaUGNqWOFrdD3TNfAw+9v7zLJkiGbgpOasHE0l5jzQ3hH
	 O7dDz2czzLJyECDsHJxYjeM8SFbgkxdbwDR+6vEp2KtvR7iWH1U3eDogL/mv0pjoWs
	 hdUAdH3W4wwtrodhYP79KdT/vljbwtJVKivghzo3eO4O5pUwYMit8jxohMbBnrUrgQ
	 bFqnlQ6VIc7/y4n+ajP/EQSA28+WGyYemNBSI6fVd8bQfGw1n6T67hzQ76iPe/5C0+
	 +MYrtjvhCWtfYpDjYgnO9NIxDGA2MyBks1KTuaNVa31gqfRDUUsOywnIqipx2rdBPj
	 dnIGx8tQfi/7r1YWwTrhhrnF5i6F3DnewRXQcE84P6dGa6sH4XN/D2xy+TGvsRgvBZ
	 /elkn/MUu1UhUVIUKbtPkLsksLNoiQGCVOMQwwv+iKfDGA3tcTXpQGbcrRkVbtcHhM
	 h68GxJCTUTH7ibcePhCf5f1GoVSAcYrXSduCli1rx7TN/qw/WYqYxdr5hZnWY9zCWN
	 QiMYajZly6NaRQiA/nxUdESs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CB0840E0194;
	Fri, 12 Jul 2024 17:21:38 +0000 (UTC)
Date: Fri, 12 Jul 2024 19:21:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422165830.2142904-2-leitao@debian.org>

On Mon, Apr 22, 2024 at 09:58:15AM -0700, Breno Leitao wrote:
> +config MITIGATION_GDS
> +	bool "Mitigate Gather Data Sampling"
> +	depends on CPU_SUP_INTEL
> +	default y
> +	help
> +	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
> +	  vulnerability which allows unprivileged speculative access to data
> +	  which was previously stored in vector registers. The attacker uses gather
> +	  instructions to infer the stale vector register data.
> +
>  config MITIGATION_GDS_FORCE

Btw, can we get rid of that thing, while at it?

Ubuntu and SLES don't set it, no clue how to check RHEL configs but if it is
not set there, we probably could unify both options...

I'm looking at

  53cf5797f114 ("x86/speculation: Add Kconfig option for GDS")

...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

