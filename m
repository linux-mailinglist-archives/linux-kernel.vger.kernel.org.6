Return-Path: <linux-kernel+bounces-203114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA928FD69F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469572893F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8AB1527AA;
	Wed,  5 Jun 2024 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VB/S+pjH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89215279C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616342; cv=none; b=qFFvYX1zaHQgl4m13mUXo7qLCQ0/J3rVnbs2IccmcGmHk7hYibRPgt9IsJ2KpBqU7ALxauvT4M0TOZCvbxLq4wF0DBV7yGGfwtnnaQl+j8vhaXXjBiR8sjexhmtN3Aii6t4xjEc6C/4af3m90stRL3LyxqRoOTDMwwmxR+7mrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616342; c=relaxed/simple;
	bh=7h650y2e5OphaBjy96Qxr4NL7CCHMN60mPbcMmRU4pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK95TBpNbUMxjVadJ+tx1CFBof1KJkvavmcCD9ACg98ptDVqudxzokQjOu0S21/pOJ+EghsUCSwE4SoYrPjmrZVcZWYCrabFB6aujokLTe7mcHIQjGQ2hMjst72OvpDFUFRrZ0bUJu6+syNqoolC6bAjGEga6ROb7kagS500B5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VB/S+pjH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E6CA540E0176;
	Wed,  5 Jun 2024 19:38:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r9RjxZF7QwfH; Wed,  5 Jun 2024 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717616332; bh=2VZhrMXt+UZEUr5oqNJ/yeKrHJhYVrTwqvvEakDjAyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VB/S+pjHBD0FD2gWB24/TGNp9Oy2E8VLnud1c2Xg3mtpj4ZQL9H9G3Ff8knUjkoT7
	 +yl3kXawY/C/9KHDIhr9BOMp4+OKl9khRknaRFModL2W7rm9Gh6iaOGRLYpdwCOiCW
	 fBPRZaoFzP2qH9W0aV1MFmxhpzMI8gxNQTJcjG4B5BM63M8P3NbZrcQiRFAif8CoKv
	 /cdvWEjNQ47MwQapD38YLo7TJSo2UC3XFhME2JSCsvYpqVDfRjKM/rHWITyMTjQBi7
	 c71Ll2WFIgnNdIWAVQ/z17tYvRYi27ZfR7YzEenAmavkKJEORMyIXlxoSJpy32EC0Q
	 ZPlxXNJVJImlSf/kT0NqJk1SPMEzSblSnpr+CbZ/eP39rblWu8dknV8BDazoQr6+d8
	 Mj4bwnOjtaalEDjtAQqKimvZ5b9bZ2ybSU6gcUu7rQlrobGwYyy2kYW0gVymcVxVCU
	 K4/BFARKqh23zU9rO5YOdZ67JBLEV+ckKG4rGoOhoSQuIemjfWuNYd2eXkivuqLJk3
	 I51btqpin12Oeo3sRUt5sRtHevX5JAxbH4dPG4kXHQba7uIh67reZF/I5iL1QF8hMz
	 9gGjM2EOQKlzg4z4bozyPCJkGDiQP3KXRgYjNUh4tbEgevxQQAN4EQ4Qo9KBSDWWte
	 AGnbMJWfLp2vBL0bN11Tzq8A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 131DF40E016A;
	Wed,  5 Jun 2024 19:38:38 +0000 (UTC)
Date: Wed, 5 Jun 2024 21:38:31 +0200
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
Subject: Re: [PATCH v5 02/13] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240605193831.GYZmC-twcfjlArW3Hq@fat_crate.local>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <9d3fe161be93d4ea60f43c2a3f2c311fe708b63b.1717600736.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d3fe161be93d4ea60f43c2a3f2c311fe708b63b.1717600736.git.thomas.lendacky@amd.com>

On Wed, Jun 05, 2024 at 10:18:45AM -0500, Tom Lendacky wrote:
> During early boot phases, check for the presence of an SVSM when running
> as an SEV-SNP guest.
> 
> An SVSM is present if not running at VMPL0 and the 64-bit value at offset
> 0x148 into the secrets page is non-zero. If an SVSM is present, save the
> SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
> page, and set the VMPL level of the guest, which should be non-zero, to
> indicate the presence of an SVSM.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  .../arch/x86/amd-memory-encryption.rst        | 23 ++++++
>  arch/x86/boot/compressed/sev.c                | 21 +++---
>  arch/x86/include/asm/sev-common.h             |  4 ++
>  arch/x86/include/asm/sev.h                    | 34 ++++++++-
>  arch/x86/kernel/sev-shared.c                  | 71 +++++++++++++++++++
>  arch/x86/kernel/sev.c                         |  7 ++
>  6 files changed, 151 insertions(+), 9 deletions(-)

I did some touch-ups ontop:

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 79eebaa85b7d..6df3264f23b9 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -135,7 +135,7 @@ Secure VM Service Module (SVSM)
 SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
 defines four privilege levels at which guest software can run. The most
 privileged level is 0 and numerically higher numbers have lesser privileges.
-More details in the AMD64 APM[1] Vol 2, section "15.35.7 Virtual Machine
+More details in the AMD64 APM Vol 2, section "15.35.7 Virtual Machine
 Privilege Levels", docID: 24593.
 
 When using that feature, different services can run at different protection
@@ -150,7 +150,11 @@ services. An example fur such a privileged operation is PVALIDATE which is
 In this scenario, the software running at VMPL0 is usually called a Secure VM
 Service Module (SVSM). Discovery of an SVSM and the API used to communicate
 with it is documented in "Secure VM Service Module for SEV-SNP Guests", docID:
-58019[2].
+58019.
 
-[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
-[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+(Latest versions of the above-mentioned documents can be found by using
+a search engine like duckduckgo.com and typing in:
+
+  site:amd.com "Secure VM Service Module for SEV-SNP Guests", docID: 58019
+
+for example.)
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 927b71495122..c65820b192b4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -465,7 +465,7 @@ static bool early_snp_init(struct boot_params *bp)
 	/*
 	 * Record the SVSM Calling Area (CA) address if the guest is not
 	 * running at VMPL0. The CA will be used to communicate with the
-	 * SVSM to perform the SVSM services.
+	 * SVSM and request its services.
 	 */
 	svsm_setup_ca(cc_info);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 16d09c1a8ceb..2a44376f9f91 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -204,19 +204,18 @@ static __always_inline void sev_es_nmi_complete(void)
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
+/*
+ * RMPADJUST modifies the RMP permissions of a page of a lesser-
+ * privileged (numerically higher) VMPL.
+ *
+ * If the guest is running at a higher-privilege than the privilege
+ * level the instruction is targeting, the instruction will succeed,
+ * otherwise, it will fail.
+ */
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
 	int rc;
 
-	/*
-	 * RMPADJUST modifies the RMP permissions of a page of a lesser-privileged
-	 * (numerically higher) VMPL.
-	 *
-	 * If the guest is running at a higher-privilege than the privilege level
-	 * the instruction is targeting, the instruction will succeed, otherwise,
-	 * it will fail.
-	 */
-
 	/* "rmpadjust" mnemonic support in binutils 2.36 and newer */
 	asm volatile(".byte 0xF3,0x0F,0x01,0xFE\n\t"
 		     : "=a"(rc)
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 739362066e00..06a5078150b5 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1330,6 +1330,11 @@ static void __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
 
 	caa = secrets_page->svsm_caa;
+
+	/*
+	 * An open-coded PAGE_ALIGNED() in order to avoid including
+	 * kernel-proper headers into the decompressor.
+	 */
 	if (caa & (PAGE_SIZE - 1))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

