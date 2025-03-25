Return-Path: <linux-kernel+bounces-575205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8DA6F415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D416D7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B60255E3E;
	Tue, 25 Mar 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SpxoeKN0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999A84FAD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902333; cv=none; b=LtKVPtU4+jb+v6kWEmDGOJFAhm2MOGHdfl6nh2SltvGUdlQjTys3vON5jIZruGs5NydgBHYcIdcoeWuIL2/iURn7hlojAxAQwjZBqVrFjDIPllpXRjKvb3YOXbEiyGr+kyH6NbxsIKaecWdZXaLCCDB0LUKKjMnl+2bX8Mnk3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902333; c=relaxed/simple;
	bh=035JiKXzE8lT+FQAeSSP0ZDNMVHVzKXH5xu2zITPEYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck4j3aS5xIUrTdm8PcyK74v/H7WVaJDhmFEc6nE9szHjnTen3OJGDscXfOENQzl7fmApZmad2XX5aMBmdd4c16dXEwjQValGNwwwtmbcU9eLx5GuuFFfVb1dXy4GtzemVCzhNeeZ3rdl+cdwztyul0kihpcKT/Sb8Ix6EbWvMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SpxoeKN0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA97940E021E;
	Tue, 25 Mar 2025 11:32:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id suK7EEZAeC3u; Tue, 25 Mar 2025 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742902322; bh=EUkEd1LhxWYmNpKAPz3PHRuSzg8imVfV3izJlx4fmQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpxoeKN0AGwnKaq3xlzU3NsmZbccYhdJWlzE4PFpz2IQsq+O2ZgdiHmyzgRXVCSdv
	 ztcxlF5FBwW+zxU5lbBRohrKM7FdXflej0S2HpA5btr8j8g/SeHxM49Edk3sMz7DD4
	 ZZs0y9V3Uqr6FA+XRi9E+nIFmxW5gr5fe1cjOXtp7DDWMceQVq2a9VnbzcWWb/AD9m
	 qcmw3biO491jFdL5Y8iiQZfaeBL18XNr2HIyT6vCyRJPK52so25ptjZj4WhN1Ub9Jl
	 4ItUsrR5zjews8zZxWjVR040/04kjvVtAEFR02WSlRSymBs1c4NkU4pPRRXdAJVq8W
	 fmQZuPVt+2zZZG4EwPrPWP1WsUqTjCOQEncn54DaFbaZcgyQz35A640l1HYi3MGU0F
	 lgPeEGYx7fm0KXvnfVu0kp34vFACnKHfpK1qI88a5RmdCJjCdhwKGKQ72N7y5IdZ/z
	 yPBRtXe0yv9E1JIpka0wA61oDhf2k1RpLPclCjYP9DDrJigH/881ZNBm1bygBWRp6Q
	 Znqmg4CGDbKRZA70XGAPHmxOBUpYCGj6ynlooTyILbOuuRhwvTyEtC5y5OCeUZccfX
	 L913/+j8QYd1qwssPCdREUMjLXpMQQV4T1NaCGYEwA6vYgsDbK4eVtQXBtdx0+SVm5
	 wdypDKE4UF3NKK1SMUNGruvw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEE4040E0214;
	Tue, 25 Mar 2025 11:31:48 +0000 (UTC)
Date: Tue, 25 Mar 2025 12:31:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Message-ID: <20250325113142.GAZ-KUHnzOOSRX20y5@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250324092915.GAZ-El68JG2BVuMK0K@fat_crate.local>
 <20250324174115.ogelbfgdmeoybi3b@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324174115.ogelbfgdmeoybi3b@desk>

On Mon, Mar 24, 2025 at 10:41:15AM -0700, Pawan Gupta wrote:
> "Unknown" status reporting was requested by Andrew Cooper. I am not able to
> find that conversation though. IIRC, the reason was out-of-service CPUs
> were not tested for the presence of vulnerability. Adding Andrew to Cc.

Right, except we don't do that for other vulns... let's wait for him to
respond though...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

