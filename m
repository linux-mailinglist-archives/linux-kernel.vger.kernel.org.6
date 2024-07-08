Return-Path: <linux-kernel+bounces-244128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE4929F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837421F218BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95867603F;
	Mon,  8 Jul 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SYmWKlMM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0053362
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432235; cv=none; b=ayQbTUmUjJEHo/WwQglltGF0hBTw2cY3I6XDZAwpQVQLShD4HidrBKNGE1P+bMS+B74FwTLxLE07ElCUgZf+oiehA0TMpedf3snBcg/CakNeXbPaCs65oEFWk9MEG1aq1HQYtrAeliNJAGc48lDWJ2lu6Hy4PUcwOBab8FPS6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432235; c=relaxed/simple;
	bh=MSiFZl8DqelUwaflNFerW/F81M2cDj2EG/ElfAiK+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA78ZOFZo/ZguSqcErBu9qt9IwX2x3r5xjfJwLY02/EChxGlpNkU5Uxp5VmmA0PZ6XuG0PE/q9kTPv60nN9HCncRX92bHp/mxfqY+HsYZwS/lZkn45+gRcPAlCclfStTcuhQRrBGazYgronx323dN/K9jXnr48JZNHTgxy1SR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SYmWKlMM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 67AC540E019D;
	Mon,  8 Jul 2024 09:50:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PMTKPkDd4mfN; Mon,  8 Jul 2024 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720432217; bh=V7PIN813Z2EbaJeK/9rFnzsZV22G82pDzPrmYIpIGA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYmWKlMMBBTIMnN/+vqLRSfZQ4evMR69ri71GtXRdSgUmRdZkmboVMc57HoKg1lD0
	 G/gtLGp+F0FRfURk8LAE4nFkRi7FlZpAP/0zoIephLsUVamCo7bIeeshg4P4xRcF4U
	 RngfT9mKbS3DhcX6vDpc/J4hX4ckiZQelQh1J+y+RXjY361SBGk17v3YoOfdTJFkJN
	 eeX4d414Im2PvIuK2PnWO9GXHU8Fo2fEbhxi4J/cuP+RebO0EtYzbI3YVc3cVFFx1I
	 XYCFUsioZCPstlxUFMc5Nd4YBNvd2JVRKVgaCfIZpGvi9Ho3fdabbkAhHtxrOzwqRi
	 4KtnOr+lvdGm0Zbt5P2eg8depp+ZIaBiFJzWwTqsxcQT3/zyZIcQoWhUmMEk0Fq5TQ
	 QrKRXQ2I9iXJNeYYZ6+v6GSiW19Bk718V3HmNdUgdvB2fdXSzHCQ8mV3E7vmE4W2DP
	 oSG11W+Tp3oK45SlNTDRvFeP6zYMIfg/PbZrnPZ2eh1Ee/ZlmAF56/IixthEKQ82vR
	 YmwWx2HwoTk2lr9M+YgPWoNJp7Iq4MQ74U/0lExUlHlfst176paTBmok5MbWZvPIjU
	 4SBBHJ+x7hy08XOl7vOrc7xS6KiVBIeVswvPAJY8qOZj8wSV0qvCZdj1TUbHjqCyBx
	 AS3ohDqaodKpOoCKT/jHg2bc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EBD640E0192;
	Mon,  8 Jul 2024 09:50:06 +0000 (UTC)
Date: Mon, 8 Jul 2024 11:49:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Yuntao Wang <ytcoode@gmail.com>,
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PROBLEM] ./arch/x86/include/asm/pgtable_32.h:59:5: error:
 "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
Message-ID: <20240708094958.GAZou2Rq4bCMCVln1C@fat_crate.local>
References: <f79ee8f6-3fba-4c5f-9dc4-371906c529a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f79ee8f6-3fba-4c5f-9dc4-371906c529a8@gmail.com>

On Fri, Jul 05, 2024 at 11:52:30PM +0200, Mirsad Todorovac wrote:
> Hi, all!
> 
> This is the result of testing randconfig with KCONFIG_SEED=0xEE7AB52F in next-20240703 vanilla tree on
> Ubuntu 22.04 LTS. GCC used is gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0.
> 
> The particular error is as follows:
> 
> In file included from arch/x86/kernel/head_32.S:29:
> ./arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
>    59 | #if PTRS_PER_PMD > 1
>       |     ^~~~~~~~~~~~
> cc1: all warnings being treated as errors

I can't reproduce that with your config ontop of

commit 0b58e108042b0ed28a71cd7edf5175999955b233 (HEAD, tag: refs/tags/next-20240703, refs/remotes/linux-next/master)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Wed Jul 3 16:14:20 2024 +1000

    Add linux-next specific files for 20240703
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

$ make ARCH=i386 -j128 CC=gcc HOSTCC=gcc
...

  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#1)

Something's missing.

Did you do

$ git clean -dqfx

before building?

Note that that cmd will clear *everything* so you better check your local tree
before you run it:

$ git status

and then

$ git clean -dqfx

after having saved the files which you still need.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

