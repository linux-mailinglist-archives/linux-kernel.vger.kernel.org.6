Return-Path: <linux-kernel+bounces-197015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A08D64F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C5C28B238
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC957CA7;
	Fri, 31 May 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W0I6x00J"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842EF54656
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167290; cv=none; b=On4QGM2Zevxskx2t2Jn4mUP4Dj1hKjwBtgl6apr5RwaQgcjs1FfoAeN+w03DyNvRFM/XHREUw4YvwEl5Db3Qc5m3cknhrocWnmQj6ZskhDhfMDDBmL3ngzYrihn8jpjdPOGCJDrSATwBoFGWTs0BfkmgEjhgvwmaBc+SL+3QcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167290; c=relaxed/simple;
	bh=nE6E5FLTG/e2GjVjjRLiE2nCKGeY5JRM73xX44CiF2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok+X3lbnpjl8HZwhek8iR9v30ZCayiaeg6ykUmIDKf+l215dY2tuiHm/0V7CqoXDOwfg4IJzNJScDVI1I/0wzkX+ev7PIKrx9eaamIzlDBZjR2q27KJ3Fxg7TznlIo5s5sNfPzM+Q9fPVONWKY9zvQgbUIfUQm9FfIbyHqnGniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W0I6x00J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 60BC340E0192;
	Fri, 31 May 2024 14:54:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qvqEUXbV9wpc; Fri, 31 May 2024 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717167283; bh=58EpTMbYkdabimCKAYW9OCshcGz6t3rQsUDOZo5HP9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0I6x00J/49wxEJY5mcGi+Ee/7ux9OkCg8FKdonfy6EHM4jhdUVuzdONymdlpKvoa
	 GC8SiOP7VGH+GsJb9WHz3jJAhEYw24DoZ3L8lc3oS1SEna9SpKZV0cl8AQ3qLKGRBH
	 pblskE9F1L3aHhMiNkV23IRI16CfGEMtMXzgXWsQaSozT/QEzI2BUOXdfqeP3Hef/b
	 yYlqImxFw692YnUyWCX34dNyJlQSGj9+LpJdleiNjzYjmuSiF+eDD2p6V0w4rFEXZR
	 QtUFUvPOxesHvbFgsKtQkq1BVEQdpash+aQUG4CB31lNGuG/g14OVNzrgNZZ35PIGv
	 TRtfkm5uNgHXVhmFGokaTjZpTpeJfijDwgWQcITARdycPmJpfZXcXYeUjsqvpGUcY7
	 ChmllTTE/rw3uLw9e3Bla1reamgTVCTBmj7Hia3f+FR2C2NcVtWklys1aK5QX1ddiR
	 5pKL6DuP/fHP08iXsMEZXYExJu9jieS4Gig6F+vSqbDuPvgclVwANMax9xrUSHPmy4
	 NW4zWpYjcl0dOiBYF3xfKFxiOlcoHUyMgm+aXcMPfTrigItdAYfzL+R/TjVodZD8X+
	 wCf/UJJDCSPfgKzzDcXtAxrurLzqETi3D1fzENYGR2p46Tw3f1MT9tzVJDow/ivMV3
	 yor/Ui+B20oEvb7+cOgWJMaU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB2BC40E01E8;
	Fri, 31 May 2024 14:54:28 +0000 (UTC)
Date: Fri, 31 May 2024 16:54:23 +0200
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
Subject: Re: [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution when an SVSM
 is present
Message-ID: <20240531145423.GLZlnkn4JHSyh4-G8P@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:11AM -0500, Tom Lendacky wrote:
> @@ -624,8 +626,12 @@ void sev_enable(struct boot_params *bp)
>  		 * modifies permission bits, it is still ok to do so currently because Linux
>  		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
>  		 * permission mask changes are a don't-care.
> +		 *
> +		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
> +		 * supports the required SVSM GHCB events.
>  		 */
> -		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
> +		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1) &&
> +		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
>  			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
>  	}

Let's make that more readable:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fb1e60165cd1..157f749faba0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -610,8 +610,10 @@ void sev_enable(struct boot_params *bp)
 	 * features.
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		u64 hv_features = get_hv_features();
+		u64 hv_features;
+		int rmpadj_ret;
 
+		hv_features = get_hv_features();
 		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
@@ -626,11 +628,15 @@ void sev_enable(struct boot_params *bp)
 		 * modifies permission bits, it is still ok to do so currently because Linux
 		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
 		 * permission mask changes are a don't-care.
-		 *
+		 */
+		rmpadj_ret = rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
+
+		/*
 		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
 		 * supports the required SVSM GHCB events.
 		 */
-		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1) &&
+
+		if (rmpadj_ret &&
 		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}

> -static int __init report_cpuid_table(void)
> +static void __init report_cpuid_table(void)
>  {
>  	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
>  
>  	if (!cpuid_table->count)
> -		return 0;
> +		return;
>  
>  	pr_info("Using SNP CPUID table, %d entries present.\n",
>  		cpuid_table->count);
>  
>  	if (sev_cfg.debug)
>  		dump_cpuid_table();
> +}
> +
> +static void __init report_vmpl_level(void)
> +{
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	pr_info("SNP running at VMPL%u.\n", vmpl);
> +}
> +
> +static int __init report_snp_info(void)
> +{
> +	report_vmpl_level();
> +	report_cpuid_table();
>  
>  	return 0;
>  }
> -arch_initcall(report_cpuid_table);
> +arch_initcall(report_snp_info);

Zap one more silly helper:

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7955c024d5d7..ff5a32b0b21c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2356,32 +2356,23 @@ static void dump_cpuid_table(void)
  * sort of indicator, and there's not really any other good place to do it,
  * so do it here.
  */
-static void __init report_cpuid_table(void)
+static int __init report_snp_info(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
 	if (!cpuid_table->count)
-		return;
+		return 0;
 
 	pr_info("Using SNP CPUID table, %d entries present.\n",
 		cpuid_table->count);
 
 	if (sev_cfg.debug)
 		dump_cpuid_table();
-}
 
-static void __init report_vmpl_level(void)
-{
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
+		return 0;
 
 	pr_info("SNP running at VMPL%u.\n", vmpl);
-}
-
-static int __init report_snp_info(void)
-{
-	report_vmpl_level();
-	report_cpuid_table();
 
 	return 0;
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

