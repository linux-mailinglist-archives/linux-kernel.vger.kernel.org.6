Return-Path: <linux-kernel+bounces-414916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444249D2F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7EEB26E20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43B1D1E73;
	Tue, 19 Nov 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K5LEO+o0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE11448DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046195; cv=none; b=nJSTpLHNO9N3oAsdMxIZPTDzCsEVALeeIPJqi1kj7NdlhiIk2Wqz8WWCKSto8Rk8r9rIlw/x6S88nvMbmIAkuA8d5DTe8Cq9QN/gPDBE/Cg5OmM1uoNWbz9UNgPMXbYZEOSTRLCtZTVgzoqNQhG7C7y1uVZW6UB3H9WCtGLAhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046195; c=relaxed/simple;
	bh=WV4aXjS1tFvbzHRe922R9c7CNUVWe3tB8n+6VPKQTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNRk3/shk+v/h7knMeO3wdec+nFkcOXVK6wG0RoKZJ5xEeXx8U1IgkFyec3LjPb+OuXu6Yb6xLcGeQTK3stBNr6JycpMrrqPSRbBf62JfnPTfGpVSznxQ1Cldz0AkN0lI497o0Z5orybteRtAnkiyLWup6FRxyh4PSXefpFkJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K5LEO+o0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E164140E0263;
	Tue, 19 Nov 2024 19:56:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q9uQ9R7wxGZj; Tue, 19 Nov 2024 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732046183; bh=7Ss/uRJqFFLeKE4J8iNR8V5NJfP3ylMww2/cWbWfHdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5LEO+o0PCcCpxe51YOTX0U0Fl9SC/qL0IGfIV0Anmr75oruYebD1Q0sA8qCuBtbp
	 uevwLerWSaNvVH51pEZQTL/ImHuEeD05TeP5ts0otA23Ye0RiAN0gNcK/fvJ/p2q9j
	 9wH5K+55RpnUdXq7iM5Ws4anKRpvDuIh0U7vHqlkOnpFgPjGMO4+6fB7jQZIueBHnW
	 NvMqVEFkrZIwap/um3TAnZyUYVSeIOLCn8bY502jxpqL4alq0PZjasbFsSWCfH/PNy
	 FbtC1mZ5WSgcTbnoFj6Ht0xhBNdzuWFAinDAlHHOf0D0jmrtIt8eYLeVoV061BMahj
	 /8moFyfNxVrg4IB5Bj3lAYTMcLXTjqpgcKye31XNSQAwpT6Xbqn0nFPF01YdVsjpWN
	 8PTkJdT2ys2wEo44B7/tNFvfRPkLhCBwUawRU8bW98G4yDOspJ8FROs+Umj63nKdia
	 7Cy4kRB5O+fFAg9sn2z0casPZQP3eaWiTX69BBWlZNCTJuSxUjg1tFo6qrPDO/tEzG
	 0ldYN3nFnoWAtsevXZf3hwNGp33SrZFQqfxmIZZZyOKSCSsvSUVagYz8yWD5C2NsuN
	 NiMAxXHvwKPlapaubsbLfxTczGqPtmWyPurG7+ZpYHdCiGbilMT0vyX47B5B0bfNXT
	 XLacTOAXotT2kA41yKJ9UmiQ=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D01940E015F;
	Tue, 19 Nov 2024 19:56:11 +0000 (UTC)
Date: Tue, 19 Nov 2024 20:56:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	thomas.lendacky@amd.com, ardb@kernel.org, tzimmermann@suse.de,
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating es_em_ctxt fi to zero
Message-ID: <20241119195604.GDZzztVDfxIWf-5F74@fat_crate.local>
References: <20241119180517.196079-2-ragavendra.bn@gmail.com>
 <20241119192602.GA2272685@bhelgaas>
 <ZzzrDB_1CyNfL0zo@desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzzrDB_1CyNfL0zo@desktop>

On Tue, Nov 19, 2024 at 11:46:20AM -0800, Ragavendra B.N. wrote:
> Yes Bjorn, I completely agree with the need to update the reason, I will
> update the commit log and send the newer version accordingly.

I think you should take the time, read that handbook Bjorn pointed you to and
then read 

https://kernel.org/doc/html/latest/process/development-process.html

and especially

https://kernel.org/doc/html/latest/process/submitting-patches.html

before you submit more patches.

Make sure you know how patches are done before you send more. Wasting
maintainers' time with things which are already documented at large is not
nice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

