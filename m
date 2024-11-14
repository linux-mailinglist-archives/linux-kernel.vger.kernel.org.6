Return-Path: <linux-kernel+bounces-409037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9C9C86AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701A31F257BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93091F8921;
	Thu, 14 Nov 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iej9CPtq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D01F77AF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578212; cv=none; b=FJlZ6AUdyaRu6nd5m7rglkcI3oas26zYM5tBFtqJLCSnl+0l3AYRXc3Tr3r9u5uY8XqFxCLxB7mh8hS2/UxeBV7++M13uYtbuckw/XhQMBKfXShnDUgrv/bxv0l8JSyyRN13A9Stp1w3W75KFHUM6J1n9PUWZsPlme7qhWmmR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578212; c=relaxed/simple;
	bh=aFIQbBVOahB3EiW89EKsGjPEvHxcSCU+sAbF1SRThwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+dkiQ+yk56bxZzLFqe6gScdSDAWcOXgaE5AGVal7buUIDLgGxg4jeh3av/zxhe1svgK7DMvdTsKIyQc/Rk4ELTgcBJti53du1Zqr1PE2a8/p7yjqtgmYo0ppPiq66yCvbWdsiCwapGj8GAy/2Qrpv7FJg4Kp3IiR1KyL2UUgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iej9CPtq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6323040E0220;
	Thu, 14 Nov 2024 09:56:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PCZUpjcI85uA; Thu, 14 Nov 2024 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731578204; bh=SKoqH6vPWondk8/P2Xcyx0OU4c7KpE6bMJztPzlSm9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iej9CPtqkVDnqdL2Nu4y54mx6LIkF5jpaBOHveBhoL7Y16P67iU134/FVFd+CCmw7
	 1TstCo7s8rwVFLtr57+vyN38jfQ7nTwIA8frSACl0QwxUPezDmc24aaKPWHgfn1Lg5
	 FazRbu9Bw5fbXpdhzckRRTp+ZIjtUD+SugkYjiHULHB+qW4Oyv5piD6ICZYSFtQUPm
	 4KTFLBWSuIfQ+QuahSB7f1K3cqLVWeRrKOzWGPx8kUT7n+sbiutESkpfdLHLMC8utP
	 ZMBstY3cgmP4f5cPAZhYDSnXRq9BqSMrYZ/FR8fZeEUuslGCuZTDM0Z2LJhd+bcDwz
	 qs5QwroWXd2F6vdBtzsYU1d0mbYHII5l3RmR6EquVT9E6jl3aPU+2AjwJkwS130yVJ
	 XqVh58OH/9vZ0mUJGKxqNVrbIw9MnQWGWH0dgvCyKY6Lo0Grah7rrK0RQlM5SuVEDu
	 pzxNLP4wG187noweBWjzUa/SdYNVzaQONqqd2VM+HruHgejrgsSaU/HHz0LvSw6PHL
	 hlB+JRAt6/Ja3KHJk1/xdGhgIABM2frFxALqZimuC2LCgyqJYrIcVIC18NDy2420Gl
	 zWEp9uhmvrJPwRNtFR02ngE0HbJh61JNQYgyVxYE1bwxYOqgQ71O98HrlOS8Pux28d
	 joLeiewyD4vU7MeHDm6TOrFA=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11C3F40E0286;
	Thu, 14 Nov 2024 09:56:40 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:56:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0p5DT0SOWsCDn7@antipodes>

On Thu, Nov 07, 2024 at 09:58:12PM +0100, Thomas De Schampheleire wrote:
> Boris, perhaps you can propose a more fine-tuned flushing? I'd be happy to try
> that.

Let's see if that does the deal too.

Thx.

---
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257..4d3c9d00d6b6 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,8 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
 
+static inline void invlpg(unsigned long addr)
+{
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+}
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 31a73715d755..6a73f775ce4c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 #include <asm/cpu.h>
 #include <asm/msr.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
@@ -489,6 +490,9 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
 
+	if (x86_family(bsp_cpuid_1_eax) == 0x17)
+		invlpg((u64)(long)&mc->hdr.data_code);
+
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d..b0678d59ebdb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
+#include <asm/tlb.h>
 
 #include "mm_internal.h"
 
@@ -1140,7 +1141,7 @@ STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
 	bool cpu_pcide;
 
 	/* Flush 'addr' from the kernel PCID: */
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+	invlpg(addr);
 
 	/* If PTI is off there is no user PCID and nothing to flush. */
 	if (!static_cpu_has(X86_FEATURE_PTI))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

