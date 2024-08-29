Return-Path: <linux-kernel+bounces-307104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E4964824
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530BF1F259CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712A1B1D48;
	Thu, 29 Aug 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RsFL5RCl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448E1A76C1;
	Thu, 29 Aug 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941369; cv=none; b=szV5eHTIlV8RF4ydtqCjOKMSVE6Kpio6UPYLlOKAt8t6w7/id0OZytKYn2pFKKJ9aw/p6XIH1sNEN3yCdpzpASUHzLbXT31b1IT94HtcxRwThFvb5edKBKdDh4UxwbXtuTEXHZszXcePtBzNjz6TCUtt9phzV0i0PCW8ZFqWuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941369; c=relaxed/simple;
	bh=gAcRbQTu/a5oxU8HgdH6u2TScEh8nTCQf3KroGJv+mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXIwjcWxnbF9XMq3vNzw46RGO3Gq75184sjzvDGeNjSe4BhSIZZ7zuqFpq07deALgXRDGPIDHuvGhLShJOBZF4O4CXP0GJCLz9bpvxiRMRfuV35maIE7ADpaI6p6Qm6WDT4N86Gk4HqSK7LZwm2UDmiyS15GnvsFwbHr1y/IBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RsFL5RCl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 51F6540E0285;
	Thu, 29 Aug 2024 14:22:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z_3om9jwFIrw; Thu, 29 Aug 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724941361; bh=zJx9ixYeyjWo1R0Y9LIHO0GPlTekBh5dy/up5rE0uo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsFL5RCluxJm6DvZl34Chz5X/oz8TBCFpaCo2Yvlv9EtmzrLJJgGOuIIRH6ijdzrC
	 VJkhDykX0UgXY3pu4FfZTglHiHW0/1RRH11TwJB8T4jXQQgQJ2msZqaH8rm9mcX2gT
	 qAUwg9yWlfNY8qtfL+Erc03T5ztiAtNANCNfiIrn/KbdNspuQ0dWiJOtkEiBPG4/mn
	 gEHnMFeTX7/XAK0N4lPyLaLxpsyqV6MQcGtEGCcYMnW83NtIo3LuGkRnASVue56zmA
	 jo2WaoqvAQvFr0bVejTU+OU0C6i3moFfYz2EHjy7BB3BxwXidjoV876c4sfqfA/xhN
	 CJ0/nnuI4CMOubuaV/sqb+HvPUUbWNcXhYBI80b6FIHTeBXuCiIIDWJRtzXTA9IjKt
	 /Id10OpNKUDkS/D7RegzWcAGhje4ETttq5bHegUIG1B8av3pQQrGiJLtVeXJkCa0nW
	 UB/y/gkwH3KSgd1FBYSwU9yg9RhTXmj/S1jy1acSHaM/+FVEdByZeFkesI4AvI3/SP
	 FTYOtVtrDnCGI1LbaVaKhNWK9Ue1YSf7rnJC7DXLUi8s4g4pQFln2RSdJ19Ydhz7ZS
	 2rs59HHlQdBdQzRqlRJKOG+FdhjsgC2GkrJ82RqynaQvj8U2+B2TxXbn9AtazkWENn
	 f9I5WkIuEM3SqM+yzRYQ90Zs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF9B440E0169;
	Thu, 29 Aug 2024 14:22:27 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:22:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20240829142226.GEZtCEIjD3wW6OowIs@fat_crate.local>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
 <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>

On Thu, Aug 29, 2024 at 03:24:38PM +0200, Borislav Petkov wrote:
> On Thu, Aug 01, 2024 at 03:56:37PM -0500, Pavan Kumar Paluri wrote:
> > +#include <linux/memblock.h>
> 
> What's the idea of adding some random include here?
> 
> Does this file use memblock?
> 
> I don't think so.
> 
> You need to resolve include visibility by including the headers where you need
> them:

And with this applied, your next patch needs includes too.

Please include only those headers into sev/cmdline.c which supply the
facilities you're using. IOW, include only those headers and only into those
files which need the respective facilities.

This needs to be done right because otherwise we have an include hell and some
poor moron gets to mop up after you in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

