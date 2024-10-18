Return-Path: <linux-kernel+bounces-372178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162169A4553
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F6E1C23C15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19156204081;
	Fri, 18 Oct 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eiztQ5sz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8983370
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274187; cv=none; b=JLCOATwvhEsmrhBopw+oW7FzEHUwAIWW281xNNNZupLTY6vJDw9zN9I6FcA/lHXrMjYFSyJX+uyJiVTjUpkef2lqhQC2qUgy8pwZflqRQ4rjclnUL4wFgfpO53DuraxY+V+NCbONTf+P/VT/2Lxg7U9n2Gl1muiuF747HjjKpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274187; c=relaxed/simple;
	bh=QhD/7r8l7iwvMbHe2wjuvHhxh2VgGg4YYE0L+/lVSx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyF7Fsw4Jry1bltiHH6PhjeWb1N1Cr/YGbfIKYylNpFmyvnIWksUlLV4P/YmQYksxtxmNdXHaK438oVKYhOYvRyRWpBbiw94pIUt/wivoUc/xUYLB0xXFJz/CGp1g9aJ6bneBTJsUEoZyowdElR4QH5dRaFAiK25/5+27U8iOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eiztQ5sz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ACE3D40E0263;
	Fri, 18 Oct 2024 17:56:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kFqjZou3_eXn; Fri, 18 Oct 2024 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729274178; bh=6ZV6gi9VAspZmL8nzAKN7l1ondmW9GIJD0Llxbs1Ork=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiztQ5szKU/1YZAg1sFwSL/Xgfi8E3Tqs3k3GaFZFY0wjB1HiMo7UfDAoEWw0vZOA
	 JD9458T1Jl+DceRwdKDrMvr+dhLfcd1pYmaLQOAx0GtTlmlSTnnojNPx/s7wdY6uoD
	 XLoWNid8pExgO8NdCJJGdg6toy4EavlHirkg9CM3eEKwxPPqNW2uwpUYGAVYdmtpke
	 8zEIuYJFuOuL25EK/PQxXnYxdDHDMPjTIZVVMRJGbIWmXPv43gkYa+SAorztDgF5m3
	 P38g4Ef1Atq4xp52StLWL6CBkHeKcu62eGPGM+upsnFJRd8/Si3Sh1bmBcTFjLxW1W
	 iMlbj0smlBra/tO4vsem3PMaQbuFq7l4EySqKffSaFteMqpzfw9x7FCUUWXar9N24W
	 xyKG+bKlhCvVNTFBRyPzdcdC1ngCCediQj3cFeVGdS6WYwiP8dh+fvcoubNhqPspa5
	 bNuWR06GhaqerVIAKtmz1tO05dn9V6Y8IePzvQ6zKy+eBv1GmqNkOX1xFBNQ25GXne
	 6clb6MloxkCeMUjjedje1EldosWo7EinWKHQoXjWb6MgMyfhd3e+H3QPejMHqNqx3R
	 JtKJTXv/XjThQBLPGX6dCIku0vV4DPIQctonEjXD1LbTS5jJ8NPGVTJaOg+376fyaY
	 zLqW+hyIgO1DX78JRLe6I+pw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6063840E0163;
	Fri, 18 Oct 2024 17:56:13 +0000 (UTC)
Date: Fri, 18 Oct 2024 19:56:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
References: <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>

On Fri, Oct 18, 2024 at 10:48:19AM -0600, Jens Axboe wrote:
> Funky... Not sure I'll have time to get a serial console on this
> thing before next week.

That would be much appreciated.

> Like I mentioned before -rc1, maybe we revert this change and I'll be happy
> to test patches as time permits?

That's my plan if we can't resolve it until -rc6-ish or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

