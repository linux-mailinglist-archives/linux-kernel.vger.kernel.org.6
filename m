Return-Path: <linux-kernel+bounces-400227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740F9C0AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804A8B232D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51E20F5D1;
	Thu,  7 Nov 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VAB9gnmC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C439FD9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995218; cv=none; b=A2YWh0bW8qRmvtFJqW8JvBZm4ZZcxBxKXAhSdrWsPibjzuuelydZYy9AvpzLkpTVpxfaCNgK4iajkT4/R6WWCQ6fbFbQo+6rV4Vw2WH3Knyprjd+4wjZAHaCb5BdvgFVJ7CtFB1nY8t57nil7Ergfw9JDXhYS1Oe/3kSUUoFtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995218; c=relaxed/simple;
	bh=sBHlkErscr9+GFUnpD8ABqMeqfPqU8KmpOIfgz2zKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiVvE04HvDuC2ENhhP6kDDqRNdzXYQTTERKSFV4fCRgp2KJyvlVduXgnRSsEMEDj9UxmqKzwlRHxj73MkfIgurC+I9fuYqwGCDipVdioc+Q73oOIDVgvyUvt1t89gCUFYqudCJp/XpuMjYBA2zr0kCns7xv+u4Aw+EbZ2wA8GFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VAB9gnmC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 777FD40E0163;
	Thu,  7 Nov 2024 16:00:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UFWkTac5j3LY; Thu,  7 Nov 2024 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730995204; bh=b6JMfsS/ndFMVoqf3LtlBh9GE/Pw2tdXt3t3VZYw2ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAB9gnmC3EdSClWHXKT+cYAhbc5G4sMEyXwpSuTchlR3h/IDgnPZ9yDgqsJxpqwqW
	 2O+n6E4sp2DrPFCZLCjj4PTK3ojGwCvoEfkov6fpnpJ/hY7O6oWb5aH21wWY3/x1EN
	 AikpokvePMRwhVJjgSU36/SHfjoNrSs8EW/d3Jr1xtOlUBtzwEgmU403dW8bqV58Zf
	 lYF4PcjSmr5nXza4oOgK9zItA/FC92X3/DRb6BVtfoSiWyWIAfirygOhKAYneDReGa
	 mPtw2nPR4Pe2c7DcPfF1V67AT6xHoRKAcpw7tiskIO/kI1WThER+1tyRbt5Jtxi+tg
	 l0qqIEmlWvEFSEQCuHE/SPc8O1dCtqt0WupZpuVfvLGpqnYvDPj3B40tm7jMmmzUth
	 vIyl7kTjaXj9lTipByYDJSCSql2xN0z4lGVN0okb4D4gGjESdYewRtlO0SRb14Ljab
	 Thfr4XHHzOYjFaAN73TEsG9w+AZdkyUYCM1Mj/INbsABi7eVJMi6wq8IeRbhOsp9fQ
	 Q7159OoFZZWGfTCgSi8rvRre90n/XJObtGiVFbStwGkjVdUzRNSvqrHLhhiNepnWKd
	 jUnsVdm4Ym1mWznyAMgVgwcgCPm8H95evRh4C6HU3BRgrgjM588W1OvpVpfHgDUdp4
	 mqcQBKRtVLmietB7YxL+Bc+k=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7FED40E0261;
	Thu,  7 Nov 2024 15:59:52 +0000 (UTC)
Date: Thu, 7 Nov 2024 16:59:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v3 0/4] x86: Rid .head.text of all abs references
Message-ID: <20241107155941.GAZyzj7bhkavHswsI3@fat_crate.local>
References: <20240605101610.2824747-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605101610.2824747-6-ardb+git@google.com>

On Wed, Jun 05, 2024 at 12:16:11PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This series removes the last remaining absolute symbol references from
> .head.text. Doing so is necessary because code in this section may be
> called from a 1:1 mapping of memory, which deviates from the mapping
> this code was linked and/or relocated to run at. This is not something
> that the toolchains support: even PIC/PIE code is still assumed to
> execute from the same mapping that it was relocated to run from by the
> startup code or dynamic loader. This means we are basically on our own
> here, and need to add measures to ensure the code works as expected in
> this manner.
> 
> Given that the startup code needs to create the kernel virtual mapping
> in the page tables, early references to some kernel virtual addresses
> are valid even if they cannot be dereferenced yet. To avoid having to
> make this distinction at build time, patches #3 and #4 replace such
> valid references with RIP-relative references with an offset applied.
> 
> Patches #1 and #2 remove some absolute references from .head.text that
> don't need to be there in the first place.
> 
> Changes since v2:
> - Rebase onto v6.10-rc2
> - Tweak commit log of patch #3
> 
> Changes since v1/RFC:
> - rename va_offset to p2v_offset
> - take PA of _text in C code directly
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> 
> Ard Biesheuvel (4):
>   x86/sev: Avoid WARN()s in early boot code
>   x86/xen/pvh: Move startup code into .ref.text
>   x86/boot/64: Determine VA/PA offset before entering C code
>   x86/boot/64: Avoid intentional absolute symbol references in
>     .head.text

Those look forgotten in my mbox. Do we still want them to go somewhere?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

