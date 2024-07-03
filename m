Return-Path: <linux-kernel+bounces-239827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174119265D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4961B1C21666
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BEC181CF9;
	Wed,  3 Jul 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c83fgs1V"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABB282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023446; cv=none; b=rGDoWX0Nbx3Q7QV2L7UaApQZiKgZn/pKtrNlzVSz+mCTfCj3AvMTgIrglCEmKlfH6i96s1LQWb1jMVsLDe5C33TpDn942iN8xsbMEC6gCLiCCLO8t1ehljqA23dBEmEZyceEszTd/trkgZ/4XVu8UJqIFwUOSgYhWNTGYsnTGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023446; c=relaxed/simple;
	bh=bAPKH1BSbBoqGiLHQMcAqDCt+IXdvgO/pStAObxxyy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANegs419uta5bblUhVo6oAH+8LN0rB6cjViNz8SAdLPbJIxBm0ViIvdntV0DDJiHZB223/fUI0ftSiMjJajzR97+uO7OEieCnBzs2Ru0vlaFF2xa/Da9d1OdtVf1rMsepWUsk2kAuVt6GYZzxoFt9F3SV7pJraaFlLMWw299f6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c83fgs1V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F10E40E021B;
	Wed,  3 Jul 2024 16:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r_c2mgWIPCed; Wed,  3 Jul 2024 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720023438; bh=oD7j6ih1M9drIJEqbHF4TrF5ceFQN+NEGaJXKS6DBKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c83fgs1VySLP1q0OKCXpHrmc97Wu/S3joFga9UhmStZrQkFx7+tKbyveNHlUAf6x7
	 Acg6KyvAQmcn+0EmaXa2nP9wq14elI3QiwhEibkEs/P4txDQJE6Q9vkacfjY/TAiqa
	 FktUUA+N24t3rwPDkgfpAFr5YTkwa8B/O7nuQH6ViGm6zz5J8eSS3t+/wuae7JUGFp
	 sWMjv/TcIsCh+dzGnjMY09BarUQMhOEDiIqqWS2/VRkr8m0ittycHdHtxGvxrj9p7w
	 7t5/76ObTuGpcmF7qrCVgxuej8P4AXII073e8Ef+iHMfyI8TDcj7iH0Xdq9OXG2ZIc
	 dKhqZulTFIuAdtaop03PfNHVXVTSZI2igtL7Ra+jYjb8Cdpl6UE6NOw9xc1ZGSpQwF
	 5Jq6di4DikIfjzoAydD+nBPGq0d3Wvl1wM37CuR0YWlw5OXLMzCJMiXKRP9lLOAF+f
	 fA1p2hBJxb+vIjqY1I96zYPlRZ3k4GvmK99uBi2gSjcNWMXoQmK2VYQiKe+LgXiH8V
	 EuBjsvvv0yOhGNPKOsMra/iK2jBpGdFmM86NaimlRDXHpWI6zHCoVLOatQzfefwBYY
	 YKQcs0NM7LXDlB2wXE/6bAalUpoIUjMeYWSVKljzb9xAohyxLWumS7pnPmcKS5L5bs
	 LNyGL1/C6+XhKpFfIqrfTSmQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1964A40E0185;
	Wed,  3 Jul 2024 16:17:06 +0000 (UTC)
Date: Wed, 3 Jul 2024 18:17:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@intel.com,
	xin@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	peterz@infradead.org, nik.borisov@suse.com,
	houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Message-ID: <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>

On Wed, Jul 03, 2024 at 09:06:55AM -0700, H. Peter Anvin wrote:
> I believe tglx declared to use them unconditionally since FRED depends on
> WRMSRNS (and the kernel enforces that.)
> 
> Using an alternative would make wrmsrns() a more useful construct in
> general, though.

We can't use them unconditionally and we don't need an alternative just for
that - a simple

	if (cpu_feature_enabled(X86_FEATURE_WRMSRNS))
		wrmsrns()
	else
		wrmsr()

would be perfectly fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

