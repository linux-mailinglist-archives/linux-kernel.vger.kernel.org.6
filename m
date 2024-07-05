Return-Path: <linux-kernel+bounces-242637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C87928AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9EC1C21AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3415FA60;
	Fri,  5 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gTsd4FL0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440752AD39
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189834; cv=none; b=qOvx9NJSKaZIDKqcBDORfd15vV9gllgCsTCRDjJxOyOOcQE9fURhEyiDdFXzEPEg7fazDsvE1+hnXRWtIwG1I49p7S3384aHf1hwuVYUYCrCWA3+k1QSNN/L8v/SvGGzCvV0JBwXNeFl80eVF4d2QxKGYn6PiF/fKfQxs1NptE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189834; c=relaxed/simple;
	bh=R3U1aAfOL8Y9Bu6suftkngTbLFC0mE6lQTEtVPHOJT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdrJN3wUrldInkTkiRWeY8OhJHM+t+0hWq56pKxfPHb1fnkRysbmkzGNNJZpi8em8MAr836+8aD/JbSwvZlv3IPxSpw4jXjl+DLns+SzQUgadVfRfn3Sda+YCKnpWSiyzumonXvUUeOqWsA9WmZ1by3A8hp0+RGU8IzZdIwqgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gTsd4FL0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C96B40E0219;
	Fri,  5 Jul 2024 14:30:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BFFYtxOv6gv2; Fri,  5 Jul 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720189827; bh=SUHxe1AHOwJWYYrDHyjgIlUnmFRk9ImUv9nuF924aEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTsd4FL0CsyixMOlS8e1NvRtOAvyGHduPKIpatycMYaEaqN7VgaqXu9W3c40b2+9q
	 Qs6fRL6r8IFz/4RuFJPc3yjIypZhtSeTKbXepLxHDn+KPsdyc65H/k+Rw5BJBpG106
	 057SCcLUAymtiv0amqNSKUKCS3eETb+vTxPpp6OsHQy/CMyRnSde2P3bcg0uLawT4n
	 OiHGTX5XcqPK91dB5cmRxfXMtAPQVn5lY3jsokJGcf5bjaMZme/a4Y/emrxoXdxpz5
	 jpxciBPYyQPoswPPBPOrIgaCYQkq4ThEfgW1E0Zv9J2f8VhcJAyaWTurGQXsKfjhrl
	 jp2vcUoTy/pqkFOYXDqrEt3jL7CQdJubJ2+7E7umuO/9C2tQTdaA0GmD6zS7FCFwB7
	 8bzbjP81lnsBt9QKA+Bhi3a3hmncvu0CN29HJ8ox0nIGtN+Def9ftmp1ZrOFI+xY5J
	 wwoB33MALMi2kxzGF5y0rBcyKWiRZFMlM3lWXQZAl828SuxAosYYhT6Sk32geXAmlX
	 1KfV74btfbKQ4ahZPM7mADLn99LRjJTnn9WQRUrc0ch5WKHf+1GfMY3ilZmj0M/W0k
	 NW5ArNil4s0zMb1efw8AO6bhWL+KiEeT7zUILJVnSSaWL+UxnaN2aYOLfw3Z6O5lRD
	 mCH1R6wU/Y54N4pRpxATXIzw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84E9240E0177;
	Fri,  5 Jul 2024 14:29:59 +0000 (UTC)
Date: Fri, 5 Jul 2024 16:29:58 +0200
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
Message-ID: <20240705142958.GCZogDZlbQWU5vHU34@fat_crate.local>
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
> +static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +	int cpu;
> +
> +	/*
> +	 * Ensure that all the per-cpu GHCBs are made private
> +	 * at the end of unshared loop so that we continue to use the
> +	 * optimized GHCB protocol and not force the switch to
> +	 * MSR protocol till the very end.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		data = per_cpu(runtime_data, cpu);
> +		ghcb = &data->ghcb_page;
> +		/* Check for GHCB for being part of a PMD range */
> +		if ((unsigned long)ghcb >= addr &&
> +		    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE)))
> +			return true;
> +	}
> +
> +	set_pte_enc(pte, level, (void *)addr);
> +	snp_set_memory_private(addr, pages);
> +
> +	return true;

Zap make_pte_private()
    
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index f263ceada006..65234ffb1495 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1022,39 +1022,14 @@ static void set_pte_enc(pte_t *kpte, int level, void *va)
 	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 }
 
-static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-	int cpu;
-
-	/*
-	 * Ensure that all the per-cpu GHCBs are made private
-	 * at the end of unshared loop so that we continue to use the
-	 * optimized GHCB protocol and not force the switch to
-	 * MSR protocol till the very end.
-	 */
-	for_each_possible_cpu(cpu) {
-		data = per_cpu(runtime_data, cpu);
-		ghcb = &data->ghcb_page;
-		/* Check for GHCB for being part of a PMD range */
-		if ((unsigned long)ghcb >= addr &&
-		    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE)))
-			return true;
-	}
-
-	set_pte_enc(pte, level, (void *)addr);
-	snp_set_memory_private(addr, pages);
-
-	return true;
-}
-
 /* Walk the direct mapping and convert all shared memory back to private. */
 static void unshare_all_memory(void)
 {
-	unsigned long addr, end, size;
+	unsigned long addr, end, size, ghcb;
+	struct sev_es_runtime_data *data;
 	unsigned int npages, level;
 	pte_t *pte;
+	int cpu;
 
 	/* Unshare the direct mapping. */
 	addr = PAGE_OFFSET;
@@ -1063,17 +1038,28 @@ static void unshare_all_memory(void)
 	while (addr < end) {
 		pte = lookup_address(addr, &level);
 		size = page_level_size(level);
+		npages = size / PAGE_SIZE;
 
 		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
 			addr += size;
 			continue;
 		}
 
-		npages = size / PAGE_SIZE;
+		/*
+		 * Ensure that all the per-cpu GHCBs are made private at the
+		 * end of unsharing loop so that the switch to the slower MSR
+		 * protocol happens last.
+		 */
+		for_each_possible_cpu(cpu) {
+			data = per_cpu(runtime_data, cpu);
+			ghcb = (unsigned long)&data->ghcb_page;
+
+			if (addr <= ghcb && ghcb <= addr + size)
+				continue;
+		}
 
-		if (!make_pte_private(pte, addr, npages, level))
-			pr_err("Failed to unshare range %#lx-%#lx\n",
-				addr, addr + size);
+		set_pte_enc(pte, level, (void *)addr);
+		snp_set_memory_private(addr, npages);
 	}
 
 	/* Unshare all bss decrypted memory. */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

