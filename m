Return-Path: <linux-kernel+bounces-244392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614392A3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C94C1C2187D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7628120D;
	Mon,  8 Jul 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KWMaaAAT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0761E495
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445589; cv=none; b=fKunktR+RWYemqPAhudSiwk2dx/Tlc0zFyrpvXTGovqorZyOMHsOwQLNF1+XRW8FXy4tiPYI/KfzvLJ45uMYTgcHVsC+SH7pxOAo7TeJIfEkyaBLhox+/US6kM43XdS+C5fD4ann86/C0PD85VBrb7L++2+qil9I+Ug8Rv3qJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445589; c=relaxed/simple;
	bh=xJcQFXw7GbGs94C9dDktSR93+HCI0OxcOuc6mKdqD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQrjoAnXjEwCHwYA9cHCVO4HyDGfsmyuSdG7kSVeD9l7QlQX70y4J9uX2z8TOhtkWcbKe8f09t2kJVT1Jpd0vblwaWVm5dCp9i1pAYp6ZnVu2/UT8dUW+D9UuoeX+2YToV5qAKCaw8RNIUmBRHWLI/Sch+bJo/t3ODal/8l3d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KWMaaAAT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E6DC540E0177;
	Mon,  8 Jul 2024 13:33:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Yew91bsIZiz1; Mon,  8 Jul 2024 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720445581; bh=jphruZogw6SdTXWimkwULPjepibUloAfNYwZTqLiGMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWMaaAATX2jxGWynwS7QCC/lRy44BGlC8A2vdzz+JxYJ/vDahwmNbfi4kvfxjqtcJ
	 VvZPX9UAqyMPH9TPc/ael1hl5/PgVUzxaiJgUHF7QWRiKFs7pNotwxctZHALrXn75P
	 hz2MxesL6yPGjb9WTgzgaT946No9yLXLSCAMtiwCVbvbiAudlMWkTfiorMeMtS0Nml
	 Q/aVnG4h04V3zcq/jvJvWjsxpqYJaTZ+luPF+wiQ74gFH910FpNJP1o0ROT7sPvu8G
	 b4k3A+gHQzEF2pXm1gJMYzAeLYqcXjSPAP0gY82Ayxq5WIDG/VaSmmDjU9v7x13UvV
	 4vkhVuDcofifq4rMBb3p6fA/l3ZfrfdKNUZ3Gjk5U42xDprbpeAdN5nKQXjGcZSQ+v
	 XUeX1eGyrF3OfE2If6aIrZyo1dk/FcKEvnNCVOvDIVxIBDIvaNsmIdjs8hxZMbmjUz
	 mphl4eU2pcHQqlpYhGT8bq8DEEcLIqY52f+n2XGbYUx8/gOqnhBm0W+Xg7/9kbYZJ1
	 yHt1cMtn9siMW+BvGkvA8BcfrLwjKO0B054qIWLGOEUKScEr8oSU6Sx32f6wLJfnjL
	 UPMkaGA0v+B97GhyhRAfjjq7Zc8Hvhe+KwuxcfUOcHgPdCLBYQp0uDcnLJZxn4tf7o
	 uZO5kHdqXd9q1pAQYHnE8q3g=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F8E540E0192;
	Mon,  8 Jul 2024 13:32:48 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:32:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dexuan Cui <decui@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <20240708133242.GCZovqepGsDSL72tjZ@fat_crate.local>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>

On Mon, Jul 08, 2024 at 03:34:34PM +0300, Kirill A. Shutemov wrote:
> Borislav, could you drop the original patch from tip tree?

Long gone already.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

