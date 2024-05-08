Return-Path: <linux-kernel+bounces-173784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B88C054E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D0D1F238D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8D130AD6;
	Wed,  8 May 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TkagnrbH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6E12CDBC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198350; cv=none; b=BR/YmcK/BOxs4onHGGpQt6g/KFZZlNwP8cVO77DigskPH45aSshypNZF3AAKm+NqpT7i8O38R8vdSe/SjD+7sDUTHsLRwVbj+5htz86MckRS2ul0VPiOh1/hqAtA5b0OYqUaaUnR8gV5t2ygL5iHu0m0VL17xGZaUfu1Xx0ZfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198350; c=relaxed/simple;
	bh=zaUSX8sLWLFSHSiw66RLbQWTPig4OY5lRHm8jle69jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhP75YxYb3emJzlCL/6KGtkN4MeSy+9BKqEU3l845td8E6nUxdLwrMONX5XgvkWIdm8L7asTHzlJwzuC2glxbyji7dvgaPiECgvACUPNaIj4EjpMPadOQU0bLfPJK3yZBecn5avOjWLsDVA+Gge0K0HkLFKUdyx1RnjQL1HQk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TkagnrbH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 97F3D40E024C;
	Wed,  8 May 2024 19:59:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ep9HqdczqPFU; Wed,  8 May 2024 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715198343; bh=cB29kPgrgp/EHkOIaR8NmXBF5c9yJWY6ZPaSBSvAyKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkagnrbHvAS4obffxl2FYnl0s2IZaB0jr/Cc0c4BZA0/nZW6dzopBlpEJnV1go638
	 Px7vcCLzAugoD47seDdLMaG4yrDgEH/IYUOa4zamwXm6nUeqRDvu8pfNDPB964BK9f
	 Rt17cH7LcCaPWslEAvnS9Ahr27TQhFzZhuO+GHFawC7I2eNFoEOrXqFxraICCpcAvW
	 5/iurBm5wNspcVVayG3UL+oaPB6zIzH2eQ2/g7+YsSYEJsLfaRYbD3eX1iUXQYsl5F
	 0EQmj9DcPR/4wdX69E6+jihMJX94zs3Cott1ipDSgAJdplduweCot+H4fBecdBT1q8
	 4UC7xDWb3+9mO4S2jVXqtImQB8euKZKoF/pmgcDNhEXX9ZbNlzmKBIDl0eYqsiBvPF
	 XGOfXT0uVXzub5PMxtwxE9hvxuP+jEDrwZKEy3CpVhSNK5zhWYd2gAjV4aZ9XyFngg
	 uUzLxeVO8ZMq6qTtJSguUzkkCgQwkIdS6byvmy8wwXTD1Nw5DqutQTjRRMt4pZPcjV
	 JNqN0DZk4nSWls3xruWQ1fBf+jxg0f5rBYVuusguPqWPS2Ii/MFc6/VACMgOKtvYkm
	 H4W4vuFuBzYdnJV8G6wYXIRmh5mGsOrOUCqj7CD2gV7OgHI5+IImcA19E0B5vVvnO9
	 e3//2//lLgGhJJ+5P4t8O69Y=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38C1840E01A3;
	Wed,  8 May 2024 19:58:49 +0000 (UTC)
Date: Wed, 8 May 2024 21:58:42 +0200
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
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
Message-ID: <20240508195842.GIZjvZcpRz0bdkiPWA@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
 <20240508080509.GWZjsyNS0xBXUzKPUG@fat_crate.local>
 <22dc9ceb-4b16-be68-ed8e-c6a222619032@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22dc9ceb-4b16-be68-ed8e-c6a222619032@amd.com>

On Wed, May 08, 2024 at 02:13:17PM -0500, Tom Lendacky wrote:
> ok, maybe __perform_svsm_msr_protocol or such.

We'll bikeshed it in the coming weeks.

> There's quite a bit of interaction so I'll make sure to prefix everything.

Ack.

> The paravirt versions of local_irq_save and local_irq_restore can't be used
> as early as this routine is called.

tglx says you should do native_local_irq_save()/.._restore() helpers
just like the arch_local_irq_save()/..._restore() ones but use only
native_ functions without the paravirt gunk.

In a prepatch pls.

> > > +	struct svsm_call call = {};
> > > +	int ret;
> > > +	u64 pa;
> > > +
> > > +	/*
> > > +	 * Record the SVSM Calling Area address (CAA) if the guest is not
> > > +	 * running at VMPL0. The CA will be used to communicate with the
> > > +	 * SVSM to perform the SVSM services.
> > > +	 */
> > > +	setup_svsm_ca(cc_info);
> > > +
> > > +	/* Nothing to do if not running under an SVSM. */
> > > +	if (!vmpl)
> > > +		return;
> > 
> > You set up stuff above and now you bail out?
> 
> setup_svsm_ca() is what sets the vmpl variable. So nothing will have been
> setup if the VMPL is zero, in which case we don't continue on.

You still assign

        /*
         * The CA is identity mapped when this routine is called, both by the
         * decompressor code and the early kernel code.
         */
        boot_svsm_caa = (struct svsm_ca *)caa;
        boot_svsm_caa_pa = caa;

regardless of vmpl.

I think you should assign those only when vmpl != 0.

Otherwise the code is confusing.

> > Judging by setup_svsm_ca() you don't really need that vmpl var but you
> > can check
> > 
> > 	if (!boot_svsm_caa)
> > 		return;
> > 
> > to determine whether a SVSM was detected.
> 
> Yes, but the vmpl var will be used for attestation requests, sysfs, etc.

I guess that comes later in the patchset...

> > Huh, setup_svsm_ca() already assigned those...
> 
> setup_svsm_ca() assigned the ones from the secrets page. The kernel now
> switches to using its own CA.

Comment pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

