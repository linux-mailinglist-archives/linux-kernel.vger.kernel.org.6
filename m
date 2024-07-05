Return-Path: <linux-kernel+bounces-242633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC6928AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF601F273E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685614A08B;
	Fri,  5 Jul 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g3y4MqWO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6604146A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189610; cv=none; b=HOqZlY+GiqxESG44fHujnMj4nONdc2UP/HtLYIFnkXM7WcOJ/Likc2dz2p56uNpFEgEYa/Yi1Jn28+HBiXf9cGFmoPA/BYhA0y33pjGuYmWCQOU2skczsdYOLab+V0l0gB9eyxfKEPRPADbXN6lVkT8WJN4TeGM8Ch0SJ23saV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189610; c=relaxed/simple;
	bh=Fz6JcQVlyLo+M/+wq0DJI1lPg0Zr6pFUHK/8PoB2AYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYpXe0XQUWiL7Hqrj11IkPrvSBlVDyZ18f7A4CfYFVT4ncsrPI81/VT/2WU8AIbbbT8D9P5UreNy31hwuydDijgRRPsf/Svt0UIDiwMZWQ3pjC+r+NKJHMjeYRjy3AwSvWeA0/hNQqAHLNg2HLsW5DqBD6o9ytALebNaZMYOMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g3y4MqWO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E46240E0187;
	Fri,  5 Jul 2024 14:26:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t-44_YkbTsu8; Fri,  5 Jul 2024 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720189601; bh=7i2R7/VkJeoOTDTwDpDdDrekidEWRlIFfduUba7D268=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3y4MqWOc2ZSUN7k7BfugPBSm9wWO2Qv6biJlImbrUmB9uquwpzZDy9RlIQGR6Y4t
	 LeMgHXiZ15vK4TTlq+vcooie3l/9G5PMJwbrzkd/gGfZ2MfBiG2xDqf/IpZJv08DeJ
	 sNlQQevbU5idK6wbIYmhsyvKXcnTRoJcdPEeJsbnIXQpGEoLbtBG88uzUk1jP8Pugx
	 0DHhkCXUmKg2yOPQ3N7KIYwK9YAPU/YDmf58KbM2IFpIfwnBSbtwUAjskGD4wN+m4T
	 j2F33fAP0YG+JYU2HX7/7qVEsbnRdGFxSPODY9iHIaJs3XVcARXQbTjXxA4anx8GYL
	 AS41SiH3E+EnA97iFqsKlVfHWGFuVij+5S+0TCaieAm6HIBJjqCMXF5lh3XOeSrB8w
	 oPQhVGtQmbKxHDCTs1aSYcnylCK1uIPCQY9tvefafek2TuZhpG5y/iADVvTKAFh/Mf
	 fuyoB/ezGEmpBroZhyaYH9j05xUgJLsymz0j9BfjLrjq8rPjZleHflxhigcZ6mKmt7
	 QxM7cnq+nrFexCNooBxOpdRqLaHaNMT/o/9bsR/Gy4kNsVum9bzAzBEqGTaIizM1uP
	 fpbPEe67+uYn4+lOWTr3+xzpf8Ed2Pod1d6zglZw4q7A0AAbQ1j4HrQPlfOmUGrY74
	 aEPv9W/g855nnhh9CQutnrSo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA21A40E0177;
	Fri,  5 Jul 2024 14:26:12 +0000 (UTC)
Date: Fri, 5 Jul 2024 16:26:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, bdas@redhat.com, vkuznets@redhat.com,
	dionnaglaze@google.com, anisinha@redhat.com, ardb@kernel.org,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, jroedel@suse.de
Subject: Re: [PATCH v11 2/3] x86/mm: refactor __set_clr_pte_enc()
Message-ID: <20240705142607.GAZogCf61FRALJxHGZ@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1719948376.git.ashish.kalra@amd.com>
 <f2152ca66e98cc399681e4964d748306b1845710.1719948376.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2152ca66e98cc399681e4964d748306b1845710.1719948376.git.ashish.kalra@amd.com>

On Tue, Jul 02, 2024 at 07:57:54PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Refactor __set_clr_pte_enc() and add two new helper functions to
> set/clear PTE C-bit from early SEV/SNP initialization code and
> later during normal system operations and shutdown/kexec.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/include/asm/sev.h    |  9 +++++++
>  arch/x86/mm/mem_encrypt_amd.c | 47 +++++++++++++++++++++++++++++------
>  2 files changed, 48 insertions(+), 8 deletions(-)

Some serious cleanups ontop which reduce the diffstat even more. Untested ofc.

Holler if something's unclear.

---
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 0c90a8a74a88..5013c3afb0c4 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1012,11 +1012,14 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 
 static void set_pte_enc(pte_t *kpte, int level, void *va)
 {
-	unsigned long pfn;
-	pgprot_t new_prot;
-
-	prep_set_clr_pte_enc(kpte, level, 1, va, &pfn, NULL, NULL, &new_prot);
-	set_pte_enc_mask(kpte, pfn, new_prot);
+	struct pte_enc_desc d = {
+		.kpte	   = kpte,
+		.pte_level = level,
+		.va	   = va
+	};
+
+	prepare_pte_enc(&d);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 }
 
 static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4f1a6d1e3f4c..68a03fd07665 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -234,6 +234,22 @@ struct svsm_attest_call {
 	u8 rsvd[4];
 };
 
+/* PTE descriptor used for the prepare_pte_enc() operations. */
+struct pte_enc_desc {
+	pte_t *kpte;
+	int pte_level;
+	bool encrypt;
+	/* pfn of the kpte above */
+	unsigned long pfn;
+	/* physical address of @pfn */
+	unsigned long pa;
+	/* virtual address of @pfn */
+	void *va;
+	/* memory covered by the pte */
+	unsigned long size;
+	pgprot_t new_pgprot;
+};
+
 /*
  * SVSM protocol structure
  */
@@ -348,9 +364,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
-int prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
-			 unsigned long *ret_pfn, unsigned long *ret_pa,
-			 unsigned long *ret_size, pgprot_t *ret_new_prot);
+int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 void snp_kexec_finish(void);
 void snp_kexec_begin(void);
@@ -390,10 +404,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
-static inline int
-prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
-		     unsigned long *ret_pfn, unsigned long *ret_pa,
-		     unsigned long *ret_size, pgprot_t *ret_new_prot) { }
+static inline int prepare_pte_enc(struct pte_enc_desc *d) { }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 static inline void snp_kexec_finish(void) { }
 static inline void snp_kexec_begin(void) { }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index dec24bb08b09..774f9677458f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -311,48 +311,37 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
 	return 0;
 }
 
-int prep_set_clr_pte_enc(pte_t *kpte, int level, int enc, void *va,
-			 unsigned long *ret_pfn, unsigned long *ret_pa,
-			 unsigned long *ret_size, pgprot_t *ret_new_prot)
+int prepare_pte_enc(struct pte_enc_desc *d)
 {
-	pgprot_t old_prot, new_prot;
-	unsigned long pfn, pa, size;
+	pgprot_t old_prot;
 
-	pfn = pg_level_to_pfn(level, kpte, &old_prot);
-	if (!pfn)
+	d->pfn = pg_level_to_pfn(d->pte_level, d->kpte, &old_prot);
+	if (!d->pfn)
 		return 1;
 
-	new_prot = old_prot;
-	if (enc)
-		pgprot_val(new_prot) |= _PAGE_ENC;
+	d->new_pgprot = old_prot;
+	if (d->encrypt)
+		pgprot_val(d->new_pgprot) |= _PAGE_ENC;
 	else
-		pgprot_val(new_prot) &= ~_PAGE_ENC;
+		pgprot_val(d->new_pgprot) &= ~_PAGE_ENC;
 
 	/* If prot is same then do nothing. */
-	if (pgprot_val(old_prot) == pgprot_val(new_prot))
+	if (pgprot_val(old_prot) == pgprot_val(d->new_pgprot))
 		return 1;
 
-	pa = pfn << PAGE_SHIFT;
-	size = page_level_size(level);
+	d->pa = d->pfn << PAGE_SHIFT;
+	d->size = page_level_size(d->pte_level);
 
 	/*
-	 * We are going to perform in-place en-/decryption and change the
-	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
-	 * caches to ensure that data gets accessed with the correct C-bit.
+	 * In-place en-/decryption and physical page attribute change
+	 * from C=1 to C=0 or vice versa will be performed. Flush the
+	 * caches to ensure that data gets accessed with the correct
+	 * C-bit.
 	 */
-	if (va)
-		clflush_cache_range(va, size);
+	if (d->va)
+		clflush_cache_range(d->va, d->size);
 	else
-		clflush_cache_range(__va(pa), size);
-
-	if (ret_new_prot)
-		*ret_new_prot = new_prot;
-	if (ret_size)
-		*ret_size = size;
-	if (ret_pfn)
-		*ret_pfn = pfn;
-	if (ret_pa)
-		*ret_pa = pa;
+		clflush_cache_range(__va(d->pa), d->size);
 
 	return 0;
 }
@@ -368,33 +357,36 @@ void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot)
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 {
-	unsigned long pfn, pa, size;
-	pgprot_t new_prot;
+	struct pte_enc_desc d = {
+		.kpte	     = kpte,
+		.pte_level   = level,
+		.encrypt     = enc
+	};
 
-	if (prep_set_clr_pte_enc(kpte, level, enc, NULL, &pfn, &pa, &size, &new_prot))
+	if (prepare_pte_enc(&d))
 		return;
 
 	/* Encrypt/decrypt the contents in-place */
 	if (enc) {
-		sme_early_encrypt(pa, size);
+		sme_early_encrypt(d.pa, d.size);
 	} else {
-		sme_early_decrypt(pa, size);
+		sme_early_decrypt(d.pa, d.size);
 
 		/*
 		 * ON SNP, the page state in the RMP table must happen
 		 * before the page table updates.
 		 */
-		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_shared((unsigned long)__va(d.pa), d.pa, 1);
 	}
 
-	set_pte_enc_mask(kpte, pfn, new_prot);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 
 	/*
 	 * If page is set encrypted in the page table, then update the RMP table to
 	 * add this page as private.
 	 */
 	if (enc)
-		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_private((unsigned long)__va(d.pa), d.pa, 1);
 }
 
 static int __init early_set_memory_enc_dec(unsigned long vaddr,

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

