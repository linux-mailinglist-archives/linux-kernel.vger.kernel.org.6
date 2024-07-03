Return-Path: <linux-kernel+bounces-239825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3549265D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94BB1F234AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E8181CF9;
	Wed,  3 Jul 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NJYYP5p5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C1282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023322; cv=none; b=KmGGCEsp55dijI9AYDgb31Qwxj29otnLlTLMIC23RZzrfEIlB7CCQqBu3OrSPY0+S1pXgwgycSD9Ddz5YGoF1dJoyJ2VLceb6rtygKWwudlht6FPwo6lX3PVYtTB8y0hJ5iTjpIo/L8N07uX+2INptqNTpZnkmiXndkynsdmE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023322; c=relaxed/simple;
	bh=KRth0iebN6/wo4KQqzUSAyJ7r8lYvAHffdsGRwNmiFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC/ZL7disDS9q5uXnNks6OrTRltzKJgk0ZgmWWISSfJymlyl/pb63HI7+kqo4JjEpqpOXChXQT/WUjsbpyMPtmqK7uz4cUnx7BzOITrWPZcIZpKPRaV5AEE7qNoOizeNw0NlBfdTZN7Mxgl0elIit2sN014C/Zl6DT5ZYdZQ2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NJYYP5p5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77EB740E021B;
	Wed,  3 Jul 2024 16:15:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zxcfPISuKBv7; Wed,  3 Jul 2024 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720023314; bh=rPAhb+lh0T6Zm1tf96NCIWVlN0UwT3YgV/h+ZK/B/L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJYYP5p5zmLSRvJf2Hy7MxkI1vUMPlUAynbRTikknVpZdS6+YMC1CDWEDIfIGICXQ
	 32vSZMPUIh1B0hUuUwPXTRj4DFk0lpjL8eClXcC86swkvzx/oxMzrdgZaEIf8IcZ0g
	 yxU3c3VwXgX9Q8cKoY3DPGsghAV4RqqvXz1JLKPU/grFBbqpo6fU1hqrxHKoUcbf6/
	 5qOq0HLJk5xbqNGfgU5fuV9LsZuHDMK6u0Hf5jI1KJdgCCgTIWBD9Z6bRsThHCcuTn
	 5J8g82JBzTllE+U1aHDi9+wcnpuD6Tx7Uwpwm6pPsPb8v/hVH5EVzj9z4+4FF+TWoz
	 k4taivFhvL0neq0dgumwW9HQKvXPqDSEFBoNRLd1cZPfYQ1fXTq/iIyCuvccNIpvp7
	 03oLD3yApob8oRPvfPgVGu9BXYU1wOG7xpdYH5FejGSC9k5yxlrvcNsFa4XX1VBtoQ
	 KoVFYaSZEl3nU2Rwmr9gqM9s9li9HgHOIXkpbH6bOmo7XFlqwDSumz2A5zdFRX4VBv
	 QLmuiZoqx0WSKWKJdagmGa6Od/EvE4BWItMHTsjNf67mjW/fstd7Yf2VDe5KJ3BSWk
	 cRZpK2iJ3NT/U7FFKCDN5cxRpoPR2C56Z+L7AutPsQD8G5ptbCdCaondFQX1SbTWox
	 Tzv0IuLWB58XQLgOMrDj4wU4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BC0240E0185;
	Wed,  3 Jul 2024 16:14:48 +0000 (UTC)
Date: Wed, 3 Jul 2024 18:14:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>

On Tue, Jul 02, 2024 at 08:32:22PM +0200, Ard Biesheuvel wrote:
> For kexec on a 64-bit system, I would expect the high-level support
> code to be capable of simply mapping all of DRAM 1:1, rather than
> playing these games with #PF handlers and on-demand mapping.

Yeah, apparently we can't do that on SGI, as Steve said.

I like the aspect that the #PF handler won't fire in the first kernel because
of EFI mapping all RAM. That's good.

So we could try to wire in a #PF handler in stage1, see below.

Steve, I don't have a good idea how to test that. Maybe some of those
reporters you were talking about, would be willing to...

---
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index d100284bbef4..a258587c8949 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -32,6 +32,7 @@ void load_stage1_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

