Return-Path: <linux-kernel+bounces-413411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC59D18C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6466D1F22A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6E1E0DF0;
	Mon, 18 Nov 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uyc8sFzS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E314900F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957385; cv=none; b=e3UK+nP9OGDvzDRnPkeb9W2G8QqCNVc72zHbfdDeOxQXmmM9HbNYMsWHBCPWxdfnoZtvXjHNtqfHMvMxRlEe/ZaB0L+YG+4zXNtijAxGp2N9iEEEfvMvGryS8KkR0ywPGGfIdU/RKDwd2v3qzGgh1tu7p0Z9IJQvNAKNxHeiFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957385; c=relaxed/simple;
	bh=NG99sCIzkMZ517IWyj4bVoKCkpvbNzxlXOMeu+PJSDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGdJIQ0zF3LutShBOZ91hXgWINAkLHc6iMgHmH5bkA9+zImBx3ImFYwetKXO7WwJ9ZY4Uu6IDH7XDvW7iosLNAbWXANu1670eIVpjgVZXU0gHQqbBMFIo1TpIw3mER6XPC7gHubmG1vaiSX/9YroeY/EYydtq7C7PVLb57GsjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Uyc8sFzS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A6F540E0261;
	Mon, 18 Nov 2024 19:16:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k2Xa3fHTjXrI; Mon, 18 Nov 2024 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731957376; bh=SpfJjirS99dAr5ULucJWFrWYI4PMFQheWC+X4jWoQuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uyc8sFzSV/0GcsT3ewA0kv1ptuBlLc/fOpc1Wfb5bjWzZ3oq4qWDhCF6oegMrp2QM
	 WlGNFNs6EbYHKYGnGZkXkwfvTVPIOdy4S9bKpzY1ooDdVK80ZzC8foTB6nE2YmowiW
	 8bG/s4Y+Trnc1H9Ki3+cSZqYyU4JJB4lq1/7tAtZAzKM1ntWTog93Gfi7xtEy5H8O1
	 PNzIDn4/Jv+RyfMNAq4sqvtBrBIchLbxfH4KUqJVIqNbmxKtCj2Px5Hi0LW9yisup2
	 /R9SPfdZP7mh9QqUMjPtGToy8z/5TaXOIl+FjwvCYsyB/5Mlit74YdAs5y4N4stcNy
	 yDSaq8odaRYOAfWiSVsmpkKX0GddtLb88KwBVNrtWKd47AwEUy6hzn1N95w0wxmVr5
	 bXml/AntTxD9ENEphN2XV3jXCS63c27GgrLdO+zqutOCN7w9MT7+BlqZAqmuIJ6suY
	 sgyp2UsDqtAz8+Du1cq6dHgJT9Ov2TXNyBFs+7T3kRiJH1UAsklMX037bbbamXanLd
	 IsmMIY4OTykhN9MSrLRtVmDbADZHxbuUvAJodn5oyV1Qmm30TQidI+zGjZ7sF5c29p
	 UqUhp9L8YNOVJWDjqlhebPOkynV9LvnejxvWUZIgkGCRVcV9Q0scDK/V3hse9bFBE+
	 m9wlG6g5gsXFzD9TAAUIXYOc=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7774D40E021C;
	Mon, 18 Nov 2024 19:16:12 +0000 (UTC)
Date: Mon, 18 Nov 2024 20:16:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241118191605.GEZzuSdRMZ0CICHdcZ@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>

On Thu, Nov 14, 2024 at 12:03:41PM +0000, Andrew Cooper wrote:
> > +static inline void invlpg(unsigned long addr)
> > +{
> > +	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
> 
> "invlpg %0" :: "m" (*(char *)addr) : "memory"
> 
> The compiler can usually do a better job than forcing it into a plain
> register.

I think it is pretty smart and DTRT regardless.

The diff is only comments - insns are the same.

--- /tmp/before	2024-11-18 20:11:08.942464511 +0100
+++ /tmp/after	2024-11-18 20:10:37.722620293 +0100
@@ -3,27 +3,27 @@
 	movl	%ebp, %esi	# psize, psize
 # arch/x86/kernel/cpu/microcode/amd.c:495: 		unsigned long p_addr_end = p_addr + psize - 1;
 	leaq	-1(%rbx,%rsi), %rax	#, p_addr_end
-# ./arch/x86/include/asm/tlb.h:39: 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+# ./arch/x86/include/asm/tlb.h:39: 	asm volatile("invlpg %0" ::"m" (*(char *)addr) : "memory");
 #APP
 # 39 "./arch/x86/include/asm/tlb.h" 1
-	invlpg (%rbx)	# mc
+	invlpg (%rbx)	# MEM[(char *)_1]
 # 0 "" 2
 # arch/x86/kernel/cpu/microcode/amd.c:503: 		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
 #NO_APP
-	movq	%rbx, %rcx	# mc, tmp110
+	movq	%rbx, %rcx	# mc, tmp111
 # arch/x86/kernel/cpu/microcode/amd.c:503: 		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
-	movq	%rax, %rdx	# p_addr_end, tmp111
+	movq	%rax, %rdx	# p_addr_end, tmp112
 # arch/x86/kernel/cpu/microcode/amd.c:503: 		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
-	shrq	$12, %rcx	#, tmp110
+	shrq	$12, %rcx	#, tmp111
 # arch/x86/kernel/cpu/microcode/amd.c:503: 		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
-	shrq	$12, %rdx	#, tmp111
+	shrq	$12, %rdx	#, tmp112
 # arch/x86/kernel/cpu/microcode/amd.c:503: 		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
-	cmpq	%rdx, %rcx	# tmp111, tmp110
+	cmpq	%rdx, %rcx	# tmp112, tmp111
 	je	.L5	#,
-# ./arch/x86/include/asm/tlb.h:39: 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+# ./arch/x86/include/asm/tlb.h:39: 	asm volatile("invlpg %0" ::"m" (*(char *)addr) : "memory");
 #APP
 # 39 "./arch/x86/include/asm/tlb.h" 1
-	invlpg (%rax)	# p_addr_end
+	invlpg (%rax)	# *addr.16_25
 # 0 "" 2
 # ./arch/x86/include/asm/tlb.h:40: }
 #NO_APP

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

