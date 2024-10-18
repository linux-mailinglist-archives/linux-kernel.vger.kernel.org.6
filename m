Return-Path: <linux-kernel+bounces-371700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F19A3ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385B9286FED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD221CCB33;
	Fri, 18 Oct 2024 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LmAIkk9M"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC51C3F10
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255797; cv=none; b=hhcYNG53NhN1SchyA7vXZaTIZ3ulpBjrUKGnuRR8amEC1aF9qzOAnBJgsAWWU+iMpPT2v/rwH5W1f1GRJ7kzStdpZvD7LFHPsKfceKeXvH9HFobIqiDOw9KHu8rdkEkBQvo5HX2JqJY3GlXET1s1F9P5TS9wviTGmMxfeE4ucDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255797; c=relaxed/simple;
	bh=x8Jx1PJsd1fk6/RgEx6LeCS+xcpZp2A5jYTRP0faV4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfuvOYE908JD84yQ1jzl/b8Fre+Whr9ZMReVWk5TlFXlYmz5cYHYSS/X9zLcDLDGqfEPLEYeTbVYRI6uaH1bXkeJrtiSs8kgbt6+v17EW7laVr9WfhTAiu1IJd+RQtKIULHBNtWYrsbQJkvUujFemF2HORDx0gGOvgpDz6A1Px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LmAIkk9M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBB7D40E0169;
	Fri, 18 Oct 2024 12:49:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ITSQRhb-uJed; Fri, 18 Oct 2024 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729255789; bh=GDNu1/78QwFrBbhAg+/okEcKgChAgn+ja2+bT034AL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmAIkk9MkaUQ5N5snzfDqqGGDMEIelMl3go/9ErxHvW9+bV6THUlDNB95W6zBkhkN
	 UmJtg5ASgkp1/rcITmvPXS2WXdCqlVnRwFGLsAUAFWMFxJk/exIJvcqGMxDmDwXH7o
	 HiiiuwJz3+/WGTi99n6LUvty6Qig5Fy7nP140jR37cshgMIXiaPsLPqeLHCa0jK1bp
	 cgyu98w0INq+kdefOtnJp5nUu/ZoZqitoq8cGqTXCAIqjA9A2Aekql7Z053Iri8f/n
	 OlFhX9fbN1v1z8K5AYuAqfkymu7LfRk/3AMVFNvnbDRmRFnRAHT0/35/0Rci4X1VDN
	 EEctpil6UOXGXv978pAiDQBVMW6V1OZS3tmNTTW0L2RKdMs1y7bn0Iwls9mAd6rQzv
	 hAXXaMsy0ZWR7WxB5qm9WUdvaNV2UlhXHnaio+DO9+Juff9FDVZ9HZYMi9HzUPQ62V
	 TilI5jQGF13PLGY/d4RYQgSP0YqIi9Gp1KBZ+tbYKASofL3nCJ8hngowdINWc1h5wO
	 yiS52Ziysu+1SWwTQqoLPK3eOLTe0fBYto3EAbgHK3Ef8YcVSNaIX/WUoXRqTT+zaM
	 7dtPFxecOdaxMgBAVPzrqhqVP+dU4ihF9mvNRFwy2qp/HJR/jiz06Wmw0lnFad4ySQ
	 PEXJkRPC2eiaxR3uSPnFhqUA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF10E40E015F;
	Fri, 18 Oct 2024 12:49:43 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:49:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
References: <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>

On Fri, Oct 18, 2024 at 01:58:57PM +0200, Borislav Petkov wrote:
> The next thing that is catching my eye is your simulated NUMA config:
> 
> [    1.668943] smp: Brought up 32 nodes, 512 CPUs
> 
> Lemme see if I can repro that here.

I can do only 4 nodes here:

[   23.137188] smp: Brought up 4 nodes, 255 CPUs

But that thing boots fine too.

I guess the next thing to try is a two-socket box like yours.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

