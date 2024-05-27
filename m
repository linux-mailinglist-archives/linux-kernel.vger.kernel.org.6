Return-Path: <linux-kernel+bounces-190589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E08D0019
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D781F21F19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB815E5AF;
	Mon, 27 May 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MDuMiMvO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472213B2A4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813232; cv=none; b=MNGjM7txr4WWEqpKyW8yXxRMzmOXJmfdZQ9bCFCYcZK5Si3oxQJgaiMzQaJkP1KDuCMzg+WqJTBxADso/eUOjHZqJZ1wOrfsIoJIO0cO8pg/8BbFNHAVwgILTopXhlIu2t2o0Mzi5EF54AjLd5VIOGTS/foKxht+mdLCUWWV9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813232; c=relaxed/simple;
	bh=0POJpo4op/4WKtBiRoOk3agZ6RzBzkKKvc//+TM5oeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2MXN1ao0OHonFqo36cwhoUDrD7+LkpWQzFVTzrjhRWjhes5FpM7c+YLaPDR2UAb4VmHsHC5zNOQlrVzRO0Cm//gHwy2xmJUtP6jSaKpt1/mq+U3c2PUuDXqqPu19h5EaeUsmaclwMkgcF3M1/aQRVWoGMO5/h/gxPc/FVAzHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MDuMiMvO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 74A3B40E02A9;
	Mon, 27 May 2024 12:33:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V4U4EjJu8wWB; Mon, 27 May 2024 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716813224; bh=+KQ1XXPKYiyM2BBxP7vDHilnO6xgA3d3JBHZpfRVIW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDuMiMvOnVl/o/XhDMvbOYg3o/XU5nS45zcZIu2GSiQvmybJVGnSqNbAFYSxButLQ
	 TU9EyUl57PnV3M/VbRpumxQ0PCa3PRnMbdTnjacqvtWdbdRSLWI3sb5dUzwqSNkIcO
	 XuKhmSFjvh5q76HZQmNLySdgNY995WBjukkw3DZTz2yqaZVztk0ms4sE9mrDG7xoZl
	 ELfn5bkcv+fAS4LJGJ829D7tAu9QY4txE+KNAJOubqRxTOW8Q/x32p8OAUIHjlnkpC
	 ZgPdd3ESyksr++z8T791SxoaxsjTTe0+BLVO04zqBlzMn5QbXDQp4CRTOKszNg7+lT
	 XAB/4P6u+7nd88NrKqdQmM7Ia9I40RtoHDfO/XUUr8IfXStnyyV/69I0BmnAvcaSz7
	 FfHunVX2ZgPkuy8kQDoi2jgzfk5bD8QlCS4Wk73VzLlvravgbGP2S8TR9YoZyjGwY3
	 wj3kwEgS3bAMCP19c/lqGCUXB+stXu1eHjXeRAjLCil/LCuL7AsqU0LNy1qRVZgZlE
	 4WuXX/MU8xBfiMKqQ22vmhi4+nViNrL/u9mNmPKSE4UAm78qSzBTe3kw73u4AUDISD
	 1xXvmldfFWufIhU8JgwUZLdEIf1USAstLpdco2YP8ScIPYRFslw3aFUy4FFrL6nRjC
	 LW9xkVjajInrdwHHrIg7nmtk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2194E40E016A;
	Mon, 27 May 2024 12:33:30 +0000 (UTC)
Date: Mon, 27 May 2024 14:33:24 +0200
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
Subject: Re: [PATCH v4 07/15] x86/sev: Use the SVSM to create a vCPU when not
 in VMPL0
Message-ID: <20240527123304.GBZlR9gBzBIjqEKKo6@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <aa7f311d90efb49dfa6f4589854ee43c049b7b88.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa7f311d90efb49dfa6f4589854ee43c049b7b88.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:03AM -0500, Tom Lendacky wrote:
> -static int snp_set_vmsa(void *va, bool vmsa)
> +static int base_snp_set_vmsa(void *va, bool vmsa)

s/base_/__/

The svsm_-prefixed ones are already a good enough distinction...

>  {
>  	u64 attrs;
>  
> @@ -1013,6 +1013,40 @@ static int snp_set_vmsa(void *va, bool vmsa)
>  	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
>  }
>  
> +static int svsm_snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
								  ^^^^^^^^^^^

bool create_vmsa or so, to denote what this arg means.

> +{
> +	struct svsm_call call = {};
> +	unsigned long flags;
> +	int ret;
> +
> +	local_irq_save(flags);
> +
> +	call.caa = this_cpu_read(svsm_caa);
> +	call.rcx = __pa(va);
> +
> +	if (vmsa) {
> +		/* Protocol 0, Call ID 2 */
> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
> +		call.rdx = __pa(caa);
> +		call.r8  = apic_id;
> +	} else {
> +		/* Protocol 0, Call ID 3 */
> +		call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
> +	}
> +
> +	ret = svsm_protocol(&call);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +static int snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
> +{
> +	return vmpl ? svsm_snp_set_vmsa(va, caa, apic_id, vmsa)
> +		    : base_snp_set_vmsa(va, vmsa);

Why do you even need helpers if you're not going to use them somewhere
else? Just put the whole logic inside snp_set_vmsa().

> +}
> +
>  #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
>  #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
>  #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> @@ -1044,11 +1078,11 @@ static void *snp_alloc_vmsa_page(int cpu)
>  	return page_address(p + 1);
>  }
>  
> -static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>  {
>  	int err;
>  
> -	err = snp_set_vmsa(vmsa, false);
> +	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
>  	if (err)
>  		pr_err("clear VMSA page failed (%u), leaking page\n", err);
>  	else
> @@ -1059,6 +1093,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> +	struct svsm_ca *caa;
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
> @@ -1105,6 +1140,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	if (!vmsa)
>  		return -ENOMEM;
>  
> +	/*
> +	 * If an SVSM is present, then the SVSM CAA per-CPU variable will
> +	 * have a value, otherwise it will be NULL.
> +	 */

	/* If an SVSM is present, the SVSM per-CPU CAA will be !NULL. */

Shorter.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

