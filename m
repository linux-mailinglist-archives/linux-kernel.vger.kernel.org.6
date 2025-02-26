Return-Path: <linux-kernel+bounces-534940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EAA46CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F97A8E93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2525A2A4;
	Wed, 26 Feb 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gWNkAfOy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C12580EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603717; cv=none; b=Us4zCc6keyw7FV+HwjCKoTnEvWrrFpSHFnXM3YBM7Mprn2g4MsSTA7F7mCaMmZo5jmHKjLiL6oRucauuEsBNM7S/2+b071uaSUffLm8ZxfcqQta6y7Rd60jCRFdNgBDg5liUFmQ4h0n2vick/5a2OO01eibXBadIa1olwX4hG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603717; c=relaxed/simple;
	bh=yKU9EJZr612WJVkgqlspKelv1Q1eNweBctYN4VnqgGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7SlPQHPYsDs2c5QzGXWnjZnCKA20nSFvUUwoGrB9YJHYr4b/tQeIUj1jqYTmB/sZxslh007pePX1WKucMb4A5ZRNhlC7GkrakRwyXFO0FuQIzSjxWX2rv7NC90CStEjmjqCq3YcxYWVeYkEo+rcgqbw5Mv8Br7Oyc4quFOG0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gWNkAfOy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A5A440E0223;
	Wed, 26 Feb 2025 21:01:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sZdiiEm4Em5q; Wed, 26 Feb 2025 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740603705; bh=NzLtAt1JidKIy15EwPf1VFM0yOgOXtUkpSu66dQH+eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWNkAfOycTJuhc6f06M+atM6fdGcX1Rctkk7OiLHmPvsoEtcmC4VaCFrsk2KHni5S
	 xCaHqg+duWiOslKwq4tqSkW/H34SBR1GVzPbVH5VV/6ZIKTf2npAZC9siLrgkc0FZD
	 sx1sbih0iWu2EoIxAQUPz8bgnNHeySIIOV6HfxE742dgbimyy2x/J0zeuqU+QX3d4W
	 VhcTZca+Refz2I8thhPYRf65DrIxKHEpGYUgeVrsf9rxyimWd1e4hrLl94yzFQqWWE
	 9wC7blcneKluPj79PqPRkAZUCshUflFjNscZdfXmOFaBOcdTYqM1KxEtrA/3ACRgDH
	 Vs6dt6uvfXC4uAJ8pcLwNvnzOpWfBhtU/9TbCumiPmT6DronpzPU5xi5rrr99ASatx
	 y+moRJQXRvsd6AYFe6ltNRy44VIEeivSu/wm7f0rEzG9s9ujsPQmFpVMODjn2HnVOV
	 EJyb07yBcZ1GRpla/Q7i0mTC/NeCP2hN6J9OMJYaCECvE2Uw4DU4GsIA+26DWJvyH5
	 n5qo0CXDvXND/y8nFgNYIwMWBioZQ9PB2DHpJSEv2dI/f7eEGYBs43zyhd6CWlxhcB
	 EepGowwtH2l0yV8AkZ263e/M6h4HHPo3c/dOPGQfOW4Fw302n3N/eAlQrRjLu3UKeG
	 7s3ap7Aywh/qsPknTpiubSGY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7358740E015D;
	Wed, 26 Feb 2025 21:01:35 +0000 (UTC)
Date: Wed, 26 Feb 2025 22:01:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250226210129.GHZ7-BKYvxN_I3f_B2@fat_crate.local>
References: <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226201453.jgg6kucaathzmcvs@desk>

On Wed, Feb 26, 2025 at 12:14:53PM -0800, Pawan Gupta wrote:
> This is a bit ambiguous, mitigations=off,guest_host could be interpreted as
> disabling guest->host and enabling all others. Using attack vectors with
> both =on and =off seems unnecessary.

No, you'll have

mitigations=[global],[separate_vector(s)]

so global can be "on", "off", "auto" and the separate vector enables only that
specific one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

