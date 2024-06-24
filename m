Return-Path: <linux-kernel+bounces-227779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E6915676
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B056828115F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FF19FA9E;
	Mon, 24 Jun 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h2+L2ArA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01A19EEDF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253618; cv=none; b=i+aIZcR/vm2MNYN8chopJJ5ohSqHGWPFLx+/aM/0MNpLRQgKhdW6qtYqGndgpMnRCz87Ms4XtwM1JQt3aH04sfKVg3KBmQJ3VYsS8q5yQ07cHq9uGwZfxQZByOyB8B6WNg3l94HoKoU2vfWwmxMozbbCd5mJuOdCBmXcMNaL+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253618; c=relaxed/simple;
	bh=4cd3E57DomYexAwjnNGQYrQ3i9hQpe0rzaoBEUWLk2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXvgVTVP9XM4qTyzcx/GEGCPZ5Vir3qcoNfi5J59himPBBiISlID5jyhePx/0jp+RoRMwO5lmPwF/N97uk+ZzSGM1MVsesmA7GZjkKPaL7qZaGqMhxvgymshl6pynUKX3kb/s3SXWxQDbFqxHu2zxUss5t3bSIR2ooJNEe5uJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h2+L2ArA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AEEB040E01D6;
	Mon, 24 Jun 2024 18:26:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YhcAhENbR_WH; Mon, 24 Jun 2024 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719253609; bh=fXBniNOuUrC5AGYiVs4PLfsvA4GQHtYMsgsNMOxALm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2+L2ArAjnVtpNtjTXIsYwgHNdbGwaWF8PXEmAs1qB0SlNZF0QUk1HYOaHbSlJIui
	 viSCdg7TaroT2VnwNwVZ4C+9YD0rg/L2sCP5Y9s81qU0Y78fm8MG2fjMOr4ODt3QFW
	 kOFiXZphJZA+3pzx3jeNs5UltFEsGSNwV5r9NMQlFo1E/AVoeTuMpvHjtypHXWMhr2
	 OCJazXAsbqYzbCoHu/78daIwWXHa0qEHxF6Whsq6YabVaPLJicAlfjiexwQfdmA6wI
	 5SyvrtFobGhxIrUDEPz8qxgM7EsRCOgeNJw62ZPNe8YIP6keb0KaZWVRezMn2XamEn
	 SKDaurjw/Gdb80OxsUQaEnMfMOwM1ozJGUIXDW8g8WgUEUYf97KoTGU0s0+PcUgNYY
	 a1Flsfh+/bvdCvQf7Q8uqxm1A8Nb5LBvRkavxSKHIahIZk5ZS67wMSsmniIGYp0k5E
	 apvDcRfV6UfLT/VxDOGTZu1Wy0KBBm5gCgAuw0MRyCROcQHxdbxcVU0btWvm2t+Pf0
	 fzBsyzKqtdzAJfO1HaKeJTJmJfVlaOVhhoEow2OdPcIrTG+DA9c7v5GRWXL1fR7XfM
	 kKw786IMPpxU1KokfzZJsgd+sY9lzwol9eEh7OrAsMPYIQM+QDQexaF5bTARc0a4A1
	 R3Uz8o0Ezn7Ahaw68OiYxY5A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D62A40E0177;
	Mon, 24 Jun 2024 18:26:21 +0000 (UTC)
Date: Mon, 24 Jun 2024 20:26:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <20240624182615.GLZnm6R4hLvnlF16aP@fat_crate.local>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>

On Thu, Jun 20, 2024 at 10:23:59PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> SNP guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only

The secon, kexec-ed, kernel...

> sees E820_TYPE_RAM.

...

> @@ -92,6 +94,9 @@ static struct ghcb *boot_ghcb __section(".data");
>  /* Bitmap of SEV features supported by the hypervisor */
>  static u64 sev_hv_features __ro_after_init;
>  
> +/* Last address to be switched to private during kexec */
> +static unsigned long kexec_last_addr_to_make_private;

This is particularly yucky.

AFAIU, you want to:

1. Skip GHCB addresses when making all pages private

2. Once you're done converting, in snp_kexec_finish() go over the GHCB
   addresses and convert them explicitly, one-by-one, without this silly
   variable

>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -1010,6 +1015,169 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>  }
>  
> +static bool set_pte_enc(pte_t *kpte, int level, void *va)

Code duplication: __set_clr_pte_enc().

You need to refactor the code instead of adding just another, generically
looking helper just because it is easier this way.

> +{
> +	pte_t new_pte;
> +
> +	if (pte_none(*kpte))
> +		return false;
> +
> +	/*
> +	 * Change the physical page attribute from C=0 to C=1. Flush the
> +	 * caches to ensure that data gets accessed with the correct C-bit.
> +	 */
> +	if (pte_present(*kpte))
> +		clflush_cache_range(va, page_level_size(level));
> +
> +	new_pte = __pte(cc_mkenc(pte_val(*kpte)));
> +	set_pte_atomic(kpte, new_pte);
> +
> +	return true;
> +}
> +
> +static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	/* Check for GHCB for being part of a PMD range. */
> +	if ((unsigned long)ghcb >= addr &&
> +	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
> +		/*
> +		 * Ensure that the current cpu's GHCB is made private

s/cpu/CPU/g

There are multiple places.

> +		 * at the end of unshared loop so that we continue to use the
> +		 * optimized GHCB protocol and not force the switch to
> +		 * MSR protocol till the very end.
> +		 */
> +		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
> +		kexec_last_addr_to_make_private = addr;
> +		return true;
> +	}
> +
> +	if (!set_pte_enc(pte, level, (void *)addr))
> +		return false;
> +
> +	snp_set_memory_private(addr, pages);
> +
> +	return true;
> +}
> +
> +static void unshare_all_memory(void)
> +{
> +	unsigned long addr, end;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,

This ends with a ','. Is anything more coming?

> +	 */
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		/*
> +		 * pte_none() check is required to skip physical memory holes in direct mapped.

This sentence needs to be written for humans. And come to think of it, you can
simply drop it. lookup_address() can return NULL so you simply need to check
its retval.

> +		 */
> +		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			if (!make_pte_private(pte, addr, pages, level)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);

Might as well terminate the guest here.

> +			}
> +
> +		}
> +
> +		addr += size;
> +	}
> +	__flush_tlb_all();
> +
> +}
> +
> +static void unshare_all_bss_decrypted_memory(void)

Why is this a separate function and not part of unshare_all_memory()?

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

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

