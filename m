Return-Path: <linux-kernel+bounces-242636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47782928AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A641F22B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C71684A3;
	Fri,  5 Jul 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HZhyOtPH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B81487D8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189750; cv=none; b=gr4gUAbvaONG00R1e7QsGGcy387Af0X9F1miOkOKbc4vhrIqIrJeW0VtAICgwAdduR9RqKfp3Jp2+mwGBm/9iGfmQR/RayT3mrbRtIiS86Bg38fIuGRQoD1kh/j27IhTuXKG56wcrqNm0GMqLhKfrpfV+NwsNdNb75bMkLbRZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189750; c=relaxed/simple;
	bh=hsj1pV3wI35C4h9vLbUYU+0lqVolpEH+QH3zXGmOwcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugWHBa3CFB+qnXz/PhwNjBpEeGFIlDvy2VfDF5yCCcBkHto10U+P3zMMkqjH36tgMlku2Tel7GAUNgrJ0CCZd+XbW93MWIjcjBdD/EmHUl+tmvjicPJPQ+8Z3qvHOZn8hyPoGWimjd8FrOPfXm0lhTWmIbqUbCABOez01YP+wVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HZhyOtPH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 779D340E0177;
	Fri,  5 Jul 2024 14:29:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6cKDbcrtIBvA; Fri,  5 Jul 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720189742; bh=YF0KsnKaZaCiX1t5IcuNZnzLBHM/kNxnGffyLGgs1r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZhyOtPHKvgy3VbdAWfjYEx2AfjjYC69QlPTFKTDF3FH8CN7yV3MbvNsXmd7jUP9D
	 550wAb8nDVjI0kXZosh0axvpbIlBEeZffI1SjrsFrLb5Hrg0a1AwgJ+03RSXwgHI7d
	 PUx1bBE2YPtea8lvxQPuIOaRPAvGc+uabkNU5XFegE0Zk48WWJB4J/PHql7iVv2oTr
	 IoQM7VppJgwq/awiaKJJQe0QWSlKp4kNABrnJKFqo/qWdcHZmVqXWPL55MjaT4RqP9
	 LJf/VHbiDByLyy6w3oBF/vxmJQwyeSIu0abTnBFecBY6/Pii/fvHsPG75HnT5g+xai
	 QiGBodj7mznM7d/tuYuikzzoK0bCyGpK3lEwre3yLllrdr7IzEa1Tv96U6eWfZ+ZkW
	 y3b81G0FH3RiK5cw7w5KVz1aFJdkKNFdU6amOFD8V7yws2IV2dnrMjOVqODPMYB6D7
	 0BrPR9TEp50P3p0ZKieZDuLj2vcaMNLqXZlTdW1vrdHEeq7GGsF3kTY5iu+HwKGvMC
	 Ak4EXpRK77+ayR86BzN9r7Mo8DYyCQmgCE9TeVVrMFWuk7vaVajZD9HArxzrpfJ2k3
	 wiHLpDch8bUNtG1ltpqwn95dF9twYXvQGL+PRfa/VDRPYgDHD2jLR3TDSYTEcMYI8Q
	 pLwa3XXkIjafcMq3f4kd7+1s=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3311040E0187;
	Fri,  5 Jul 2024 14:28:34 +0000 (UTC)
Date: Fri, 5 Jul 2024 16:28:33 +0200
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
Subject: Re: [PATCH v11 3/3] x86/snp: Convert shared memory back to private
 on kexec
Message-ID: <20240705142833.GBZogDEZ1kk5bbDp7C@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1719948376.git.ashish.kalra@amd.com>
 <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee7d5134e67964bb5c602b5c5d69f5a1decf4597.1719948376.git.ashish.kalra@amd.com>

On Tue, Jul 02, 2024 at 07:58:11PM +0000, Ashish Kalra wrote:
> +static void unshare_all_bss_decrypted_memory(void)
> +{
> +	unsigned long vaddr, vaddr_end;
> +	unsigned int level;
> +	unsigned int npages;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
> +	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
> +	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
> +		pte = lookup_address(vaddr, &level);
> +		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
> +			continue;
> +
> +		set_pte_enc(pte, level, (void *)vaddr);
> +	}
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	snp_set_memory_private(vaddr, npages);
> +}

Merge the whole unsharing dance into a single function:

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 5013c3afb0c4..f263ceada006 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1049,58 +1049,47 @@ static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int leve
 	return true;
 }
 
-static void unshare_all_bss_decrypted_memory(void)
-{
-	unsigned long vaddr, vaddr_end;
-	unsigned int level;
-	unsigned int npages;
-	pte_t *pte;
-
-	vaddr = (unsigned long)__start_bss_decrypted;
-	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
-	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
-	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
-		pte = lookup_address(vaddr, &level);
-		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
-			continue;
-
-		set_pte_enc(pte, level, (void *)vaddr);
-	}
-	vaddr = (unsigned long)__start_bss_decrypted;
-	snp_set_memory_private(vaddr, npages);
-}
-
+/* Walk the direct mapping and convert all shared memory back to private. */
 static void unshare_all_memory(void)
 {
-	unsigned long addr, end;
-
-	/*
-	 * Walk direct mapping and convert all shared memory back to private.
-	 */
+	unsigned long addr, end, size;
+	unsigned int npages, level;
+	pte_t *pte;
 
+	/* Unshare the direct mapping. */
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
 
 	while (addr < end) {
-		unsigned long size;
-		unsigned int level;
-		pte_t *pte;
-
 		pte = lookup_address(addr, &level);
 		size = page_level_size(level);
 
-		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
-			int pages = size / PAGE_SIZE;
-
-			if (!make_pte_private(pte, addr, pages, level)) {
-				pr_err("Failed to unshare range %#lx-%#lx\n",
-				       addr, addr + size);
-			}
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
+			addr += size;
+			continue;
 		}
-		addr += size;
+
+		npages = size / PAGE_SIZE;
+
+		if (!make_pte_private(pte, addr, npages, level))
+			pr_err("Failed to unshare range %#lx-%#lx\n",
+				addr, addr + size);
 	}
 
-	unshare_all_bss_decrypted_memory();
+	/* Unshare all bss decrypted memory. */
+	addr = (unsigned long)__start_bss_decrypted;
+	end  = (unsigned long)__start_bss_decrypted_unused;
+	npages = (end - addr) >> PAGE_SHIFT;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)addr);
+	}
+	addr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(addr, npages);
 
 	__flush_tlb_all();
 
@@ -1114,8 +1103,9 @@ void snp_kexec_begin(void)
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
+
 	/*
-	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * Crash kernel ends up here with interrupts disabled: can't wait for
 	 * conversions to finish.
 	 *
 	 * If race happened, just report and proceed.
@@ -1124,7 +1114,6 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
-/* Walk direct mapping and convert all shared memory back to private */
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

