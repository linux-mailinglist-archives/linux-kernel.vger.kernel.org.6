Return-Path: <linux-kernel+bounces-394720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C19BB326
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EF11C2223D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E711BD00A;
	Mon,  4 Nov 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C0W3+372"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E691B392F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719010; cv=none; b=OLqG1ezplA1wmGZuVHVloNGHcEN8smq33eRHA7gcjFzk2WJG4FzpB6e4PXA3ecI73uNm8fA6J2rJPQPfzw1Mg0WIikjswqyAfz5kEtfhmMXOyyMJSU7ecpE8PesAkAG/1w3ux2UVotUepIcAeC7AZ/FhvtaQaN3F76pcDV/CXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719010; c=relaxed/simple;
	bh=qP4hDvDNGNshTtKv0xihRVPhLeM67stLE1XTEPYwHCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDj7vJVRvkGaXrSs3a7RP0ixKO8tI3DiSf4SNoANRZYPfMq+RivCSAUd4GAd3wg+U6Q/WdSZjjmNrHYWKt6SDKFBXBsa3dOSx72yGZbdbdt4GUOTjN58NEjVQCJEDGnlqhm6K1XKKU+6AJm9qi5z/ZwdydU1nxXe7+pjuACmF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0W3+372; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C68D540E0163;
	Mon,  4 Nov 2024 11:16:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cQ1kvBB3nEVC; Mon,  4 Nov 2024 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730719001; bh=KW8V/FzpAQG60s4wM40wPNAONpbD7YvdIN6uAJU0zqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0W3+372k5Es2PW0I2K4w4495idnMZs+/cb3XXKfGp58Dm2wZWaXS8NfvZOMsvBJP
	 M6Tw67jJTRWXuoiO+hnMfcFO40k9391F06AubHrQJHM0FQfxqjO18MjEok8EIC7HvF
	 w5LX8IKbdVBLAfnV+1g+2I/Y1T6QxjWvexTWl44LX9QMwFRQTQvmtuH0bvQd26SQzj
	 l/eH7R2YaO/D/QsupbRZRXR11EimCMyqlzI88AsPLi9pCWDl13wGQ4gTFz4G88z0Mt
	 mI5IyGdmBgtzgxKCFffS6dFi5x2EhqgnIMcY0TZjPLKGmok00Kr35PQ69Oxdo117hs
	 OAFjQGhdFphsQLjoEHNl0+u0l4NtKB48Q1wUp+oXC42OgjInUQHqw+YipR2irsqlsO
	 IUdGY/KJr3wGwrfyG+ZOR356DHTffzIlsknaWmXm2xLukZBV2VMs8W3LYxy/R+gx6p
	 Wd1TiZjK8yhwt4MgC/e6XiTlD6n2EcX8gNW3WVzMZg8okvvOPDXR5kLUBH7TWE2G7J
	 N3TPpM5omudekbYoIXEEuG1lBzjDyNYzG5P1BO/dRIGhyNzqY4b7QKaQbiAVHLEtfZ
	 aXWWHo7jU0Bxtcb7vfsDHhpTaUCa6SrFjt1rkVK/z0V/L4H2tNz2LdzX9jmVEu0l3W
	 Wtrxp7ZjMeQ4aMesLJttcrnM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA97740E0265;
	Mon,  4 Nov 2024 11:16:35 +0000 (UTC)
Date: Mon, 4 Nov 2024 12:16:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC 4/7] x86/microcode/intel: Prepare for microcode
 staging
Message-ID: <20241104111630.GSZyitDuXnBYmEFxvo@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241001161042.465584-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001161042.465584-5-chang.seok.bae@intel.com>

On Tue, Oct 01, 2024 at 09:10:39AM -0700, Chang S. Bae wrote:
> +static inline u64 staging_addr(u32 cpu)
> +{
> +	u32 lo, hi;
> +
> +	rdmsr_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &lo, &hi);
> +	return lo | ((u64)hi << 32);
> +}

A single usage site. Move its code there and get rid of the function.

> +
> +static bool need_staging(u64 *mmio_addrs, u64 pa)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; mmio_addrs[i] != 0; i++) {
> +		if (mmio_addrs[i] == pa)
> +			return false;
> +	}
> +	mmio_addrs[i] = pa;

This is a weird function - its name is supposed to mean it queries something
but then it has side effects too.

> +	return true;
> +}
> +
> +static void staging_microcode(void)

stage_microcode().

Functions should have verbs in their name and have the meaning of
a "do-something".

> +{
> +	u64 *mmio_addrs, mmio_pa;
> +	unsigned int totalsize;
> +	int cpu;
> +
> +	totalsize = get_totalsize(&ucode_patch_late->hdr);
> +	if (!IS_ALIGNED(totalsize, sizeof(u32)))
> +		return;
> +
> +	mmio_addrs = kcalloc(nr_cpu_ids, sizeof(*mmio_addrs), GFP_KERNEL);
> +	if (WARN_ON_ONCE(!mmio_addrs))
> +		return;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {

Oh great, and someone went and offlined one of those CPUs right here. Fun.

> +		mmio_pa = staging_addr(cpu);
> +
> +		if (need_staging(mmio_addrs, mmio_pa) &&
> +		    !staging_work(mmio_pa, ucode_patch_late, totalsize)) {

do_stage()

> +			pr_err("Error: staging failed.\n");

							... on CPU%d, err_val: 0x%x"\n"

perhaps?

For more info debugging something like that?

> +			goto out;
> +		}
> +	}
> +
> +	pr_info("Staging succeeded.\n");

		"Staging of patch revision 0x%x succeeded.\n"...

more user-friendly.

> +out:
> +	kfree(mmio_addrs);
> +}
> +
>  static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
>  					  struct microcode_intel *mc,
>  					  u32 *cur_rev)
> @@ -627,6 +676,7 @@ static struct microcode_ops microcode_intel_ops = {
>  	.collect_cpu_info	= collect_cpu_info,
>  	.apply_microcode	= apply_microcode_late,
>  	.finalize_late_load	= finalize_late_load,
> +	.staging_microcode	= staging_microcode,
>  	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
>  };
>  
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index cb58e83e4934..06c3c8db4ceb 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -120,6 +120,11 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
>  void load_ucode_intel_ap(void);
>  void reload_ucode_intel(void);
>  struct microcode_ops *init_intel_microcode(void);
> +static inline bool staging_work(u64 mmio_pa, void *ucode_ptr, unsigned int totalsize)
> +{
> +	pr_debug_once("Need to implement the Staging code.\n");
> +	return false;
> +}
>  #else /* CONFIG_CPU_SUP_INTEL */

You better have an empty stub for that work function here too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

