Return-Path: <linux-kernel+bounces-204497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA958FEFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8425F28432C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA819E7CA;
	Thu,  6 Jun 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUn8bC65"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC41B011E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684756; cv=none; b=jD9ESKTtEXDllnoJdP0UZL3g/tnVA5zkxwgtX5doWxneu4Zv+6iIIsMBtsxSjLX4T0WjfQYk8Eq7LkTd/NkGSGWq04A4yFljcNROwuCTdjb9Uv8s/4yKgJpv+KbopNX/7MprCbEYIZ4W8QOGuCHR1rnYYqSLLTGyFX2QAGEzqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684756; c=relaxed/simple;
	bh=PW0mB/Ap+iosdJhw53tmQWtAwnayyP9uDzO9zkRDuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvgf7Uk28etwnBoe2e8FUCqIxlwPDs2I62SEpyho/iz8lH3wJYMGyUIT4Qno63OFtSUOybOiWjBkILIasT+bjpYL+kRTEEMg0Ldly9OIMDCG2i3vlbLm6bxUfDYgd58lVccod+/WTi7gYtK1DA9OZ1oKzZnDCzCYZwIIt0JTNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iUn8bC65; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E69240E016C;
	Thu,  6 Jun 2024 14:39:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bk0JMOZU0YBh; Thu,  6 Jun 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717684745; bh=+LG5ed49RtXEviXf/9mwTYPthSUWIdmD9Du5/B+SoL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUn8bC65hH12zSAv5Z1ZPeFgEfXppDTQC0RTZhU6a3Dtv3eN0gQ5TIRkgZ6yB7yxF
	 qIXe0XtDmefjN7K5zKn5wi1Zo4AbaqUtTG6MqDXGK/JCAVcUi4b3E18reLYRcIyOPY
	 5iQZTkFB3c2oD/yVnYH119lPuEhIrrN10IE3F0WRqqep8H2fBfRYE2n3DNJz6yZepe
	 tADOSVaT7CcjfNj2xse2+VcVZF/VGrH3xDej3Bp//tnvSVSOHoMrr/jCV45PTOkmNV
	 n3fUUljocQFNWPbus1Y562aurZ5AjEXdP/lj/8DKL6089kgfMzFyYyBWkCSTXjotxZ
	 q51dFgeG1iS8F/kiug6ASDvef9qhgyCqGbGqYkGFE7fZNzQvAmjO1/FNEBkNZOOCzl
	 MLXlyS1a4sT4Z3mIjBBlOW6LsBehDch9/i/aCZvZ5ULDSyhKscjP54Dq5+JzAoa3t6
	 zvYDtkitTE6dhossGMsmKqkG5kFFzbO7uEKpR/UZ6GNnlgBTJtdfNvyDyHdWy/B5VB
	 AmOxlIXx0QT6bodV5xRYz8ZUDvrOnn0v6JvRf8agMtJurDqpo6499tT7lsRUNK9U7f
	 nGVOgO2rc1FdSyaWBvLDbprfpxGOf3DnzpsJvqdAEqrqYVs3w5YR8Vk45RXznDlDE4
	 7dgC1VghNqaVjDTso2OqoxgQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0A8A40E0027;
	Thu,  6 Jun 2024 14:38:51 +0000 (UTC)
Date: Thu, 6 Jun 2024 16:38:44 +0200
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
Subject: Re: [PATCH v5 04/13] x86/sev: Perform PVALIDATE using the SVSM when
 not at VMPL0
Message-ID: <20240606143844.GDZmHJ9CK_aNoD3TSe@fat_crate.local>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com>

On Wed, Jun 05, 2024 at 10:18:47AM -0500, Tom Lendacky wrote:
> The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
> be present when running at VMPL1 or a lower privilege level.
> 
> When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
> memory validation instead of issuing the PVALIDATE instruction directly.
> 
> The validation of a single 4K page is now explicitly identified as such
> in the function name, pvalidate_4k_page(). The pvalidate_pages() function
> is used for validating 1 or more pages at either 4K or 2M in size. Each
> function, however, determines whether it can issue the PVALIDATE directly
> or whether the SVSM needs to be invoked.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c |  45 +++++-
>  arch/x86/include/asm/sev.h     |  26 ++++
>  arch/x86/kernel/sev-shared.c   | 250 +++++++++++++++++++++++++++++++--
>  arch/x86/kernel/sev.c          |  30 ++--
>  4 files changed, 325 insertions(+), 26 deletions(-)

Some touchups ontop like slimming down indentation levels, etc.

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 226b68b4a29f..ce941a9890f8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -284,11 +284,12 @@ void sev_es_shutdown_ghcb(void)
 		error("SEV-ES CPU Features missing.");
 
 	/*
-	 * This is used to determine whether to use the GHCB MSR protocol or
-	 * the GHCB shared page to perform a GHCB request. Since the GHCB page
-	 * is being changed to encrypted, it can't be used to perform GHCB
-	 * requests. Clear the boot_ghcb variable so that the GHCB MSR protocol
-	 * is used to change the GHCB page over to an encrypted page.
+	 * This denotes whether to use the GHCB MSR protocol or the GHCB
+	 * shared page to perform a GHCB request. Since the GHCB page is
+	 * being changed to encrypted, it can't be used to perform GHCB
+	 * requests. Clear the boot_ghcb variable so that the GHCB MSR
+	 * protocol is used to change the GHCB page over to an encrypted
+	 * page.
 	 */
 	boot_ghcb = NULL;
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8b191e313c0a..b889be32ef9c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1220,6 +1220,15 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
+static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_size,
+				    int ret, u64 svsm_ret)
+{
+	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svsm_ret: 0x%llx\n",
+	     pfn, action, page_size, ret, svsm_ret);
+
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
 static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svsm_ret)
 {
 	unsigned int page_size;
@@ -1230,16 +1239,7 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	action = pc->entry[pc->cur_index].action;
 	page_size = pc->entry[pc->cur_index].page_size;
 
-	WARN(1, "PVALIDATE failure: pfn 0x%llx, action=%u, size=%u - ret=%d, svsm_ret=0x%llx\n",
-	     pfn, action, page_size, ret, svsm_ret);
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-}
-
-static void pval_terminate(u64 pfn, bool action, unsigned int page_size, int ret)
-{
-	WARN(1, "PVALIDATE failure: pfn 0x%llx, action=%u, size=%u - ret=%d\n",
-	     pfn, action, page_size, ret);
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
 static void svsm_pval_4k_page(unsigned long paddr, bool validate)
@@ -1284,7 +1284,7 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 	int ret;
 
 	/*
-	 * This can be called very early in the boot, so use rip-relative
+	 * This can be called very early during boot, so use rIP-relative
 	 * references as needed.
 	 */
 	if (RIP_REL_REF(snp_vmpl)) {
@@ -1292,7 +1292,7 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
-			pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret);
+			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
 	}
 }
 
@@ -1315,16 +1315,19 @@ static void pval_pages(struct snp_psc_desc *desc)
 		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
 
 		rc = pvalidate(vaddr, size, validate);
+		if (!rc)
+			continue;
+
 		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
 			unsigned long vaddr_end = vaddr + PMD_SIZE;
 
 			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE, pfn++) {
 				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 				if (rc)
-					pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc);
+					__pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc, 0);
 			}
-		} else if (rc) {
-			pval_terminate(pfn, validate, size, rc);
+		} else {
+			__pval_terminate(pfn, validate, size, rc, 0);
 		}
 	}
 }
@@ -1429,24 +1432,26 @@ static void svsm_pval_pages(struct snp_psc_desc *desc)
 
 		do {
 			ret = svsm_perform_call_protocol(&call);
-			if (ret) {
-				/*
-				 * Check if the entry failed because of an RMP mismatch (a
-				 * PVALIDATE at 2M was requested, but the page is mapped in
-				 * the RMP as 4K).
-				 */
-				if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
-				    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
-					/* Save this entry for post-processing at 4K */
-					pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
-
-					/* Skip to the next one unless at the end of the list */
-					pc->cur_index++;
-					if (pc->cur_index < pc->num_entries)
-						ret = -EAGAIN;
-					else
-						ret = 0;
-				}
+			if (!ret)
+				continue;
+
+			/*
+			 * Check if the entry failed because of an RMP mismatch (a
+			 * PVALIDATE at 2M was requested, but the page is mapped in
+			 * the RMP as 4K).
+			 */
+
+			if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+			    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
+				/* Save this entry for post-processing at 4K */
+				pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
+
+				/* Skip to the next one unless at the end of the list */
+				pc->cur_index++;
+				if (pc->cur_index < pc->num_entries)
+					ret = -EAGAIN;
+				else
+					ret = 0;
 			}
 		} while (ret == -EAGAIN);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

