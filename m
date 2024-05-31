Return-Path: <linux-kernel+bounces-196778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A278D61C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427EAB250AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D9C1586D5;
	Fri, 31 May 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SMApdGDK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6762AD2D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158628; cv=none; b=BVDrELH4CqiUYkrkxTIqopYXnLhlvRmyf5GXY9xzzqHy9aYz5dZ99UdXzOtu6Aaz1xCD1fPVJFHGAt0ifJYaOs4IWzyJrx+zINpDxULJ/JIFcJ55cVsTwGIJLKCjMQ5trchYrKZ1p7+QfU9c6WVZPI7CzawmdEaru6Cyubn5Biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158628; c=relaxed/simple;
	bh=2mc0HWTfOV1Teq6IYJqOMKDrFW1OILUGkAVGkdJ9Acc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVNe8mpWyxd2rA5TlsiGHggKVXOVspmXuzpvbkkwtdjrKMq6cnyWf/J4JHjW8R8yXNrMwKmTxmsTvBqu4ogkr4r7JiaSD9IORaHWD81FnqYHQCiFP70pH37VGBG7A8H6Uu7bnD2avxxT9TMjqazkcpxH39rA1m8QdB26U8d9HZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SMApdGDK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A6C440E0192;
	Fri, 31 May 2024 12:30:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sPIeD_FlmuX3; Fri, 31 May 2024 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717158619; bh=Cp7gWFWCgunxt2EZJJB/aMuJ7vmygLLqyPm4seO3fyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMApdGDKJuXYKkzBsXvwplsjbBQp5vqi+c5SXxkmQngoAniCZWwd+D8iDQqxgQXAq
	 9aIylFmNIC2SiiDYnmCouKbPaNfEIcXMoILkbr70GUv16+ylobyh2c832VEhU6uUvK
	 3UrxUutyaYyOU0uMnM06iX0V9wfxNLY2ZrFxfNc5IKxoRlV2CukGQ7eMjX3zkxTTv6
	 6CptbotB/rPBL/D1tn7nwnWvqv14u1ke7ld8OTKUJ64iDVVeM0/jgadH9AaMFCv6mH
	 sXlu7OcCjKqOZaYJdLeMGlXEZMTAn6E8yqbeNosVT3qL1RocRBTA1uXTxSfLfimK2Z
	 qVf20E6SmUCF9rvTjWdhdXMumbv5LmoIPqXFNfZfwavzsrFB4Zrvb+QkPJun87P8/W
	 7fHkb9g+ehc6LED69c92QsZed8qHvOuMrlYvptYKteNzFhNhrssmXihrxp63rdVVZ5
	 VyjQ+wiYsqWQMH1T5o0MlQCXHzxejAua71GG9eh+LtM9GJGjHynoSFV7QbLfDequXq
	 qnbKRMXMswlVjY/GpL+0/xbCssqOmNuFYtSP5+i/p8G0vUZsqcSrqYFh23d5v7vNlN
	 NLVcMASThnwqJxikvCi5OOmsM2y5PvBeVvd8ndXCkSC4UYJiPzJIRnzpoSntafxkmA
	 vLHMB5HIbule/nrq7PtTEjdE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1EE540E0177;
	Fri, 31 May 2024 12:30:04 +0000 (UTC)
Date: Fri, 31 May 2024 14:29:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 07/15] x86/sev: Use the SVSM to create a vCPU when not
 in VMPL0
Message-ID: <20240531122959.GCZlnCx8uxvozjmfly@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <aa7f311d90efb49dfa6f4589854ee43c049b7b88.1713974291.git.thomas.lendacky@amd.com>
 <20240527123304.GBZlR9gBzBIjqEKKo6@fat_crate.local>
 <4f704d19-088a-89d7-0515-144db61b93a5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f704d19-088a-89d7-0515-144db61b93a5@amd.com>

On Tue, May 28, 2024 at 03:28:28PM -0500, Tom Lendacky wrote:
> I just think it's easier to follow, with specific functions for the
> situation and less indentation. But if you want, I can put it all in one
> function.

Well, if the function were huge and hard to read sure, but right now it
is simple and with single indentation level. There's the other side of
having too many small helpers, leading into not seeing the flow. The
logic we should follow is: if the function is big and fat and has too
many indentation levels, you split into smaller functions.

The "Functions" section in Documentation/process/coding-style.rst has
some blurb on the matter.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

