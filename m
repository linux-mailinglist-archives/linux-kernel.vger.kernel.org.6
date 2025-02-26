Return-Path: <linux-kernel+bounces-534563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8915A46884
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24913AA433
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5B22A4E0;
	Wed, 26 Feb 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TUcw/5Dp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13822A4D0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592351; cv=none; b=A7UC1q6PSg8tQqn7GA6SyS704dcB/rU/M+oDjA3n7zqIxEOv6R8bnL23BQTb4Swwx76L510l/uEI4+VXbCiEZpv0aX1GjO+CwSANrB4IoIMlH75RFw0fFOf6yGBAogwqRiKIVh7LH62URWsOdfe2ob7rgC4UrYjm8fNCNCOKJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592351; c=relaxed/simple;
	bh=/uX6pYv2BtheN0Okj32QeCEnWvkXhUSV4xB+0pc07+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfYZ0roiBbvxA3I/oXG5ZvE7Cf06yX5wZVHmfg3b3PHF7VN9W4sdLB5AGbGjnHxY3eg7sqUvvPPfTMoNCl8QmmNcRvALxQQu9zUtWaF/xCbQSYMzGPUus3lxMMW1k2bhhSk2rOOSZBy5DvGwogd1I3qEymFEWbaIsJtZZ+1T9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TUcw/5Dp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2829740E01AE;
	Wed, 26 Feb 2025 17:52:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3mwnvL0p8djZ; Wed, 26 Feb 2025 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740592343; bh=XJndiJfMb6eISZyXsJk6B+T1pXjFoCbOPkn+6aSQ8hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUcw/5DpZDdbXAML0YWzEsDkcrtvEYP6h7WtD69qOzuKEXb66PkQ/AJ7B6F+xwtuP
	 wDK6ZJbZSbSwNgkdkF8KEUzMStciTih81dFg85fqM7MPCMjZ6mSOvfphjXLJKwfiZO
	 R3dIx95Unnx9b+XjxOQeEz82S4SzMZhpbVCehGpZiL5QLlb3RYprQQkMqYtnGjQCZA
	 2Q2nTIQ4ArCCLXkLfgO8uGAphoCERyCIycbvHOZwGdygSsDbBU0vQ34g4u335IeJJH
	 y776iOWFnRkgDVq43FQpJRpV79sXfVLFU3US0uTXD6DAxFzPu1E0ehCw5IsPnCtWui
	 begOIkFZ7BbmQf/XizjJqE1vCdf/RuLRmXFU9mML5A6daWwZTIARPK9WgxUiEN6mtp
	 vNhNb992GjACoR8UaenZejKEWmoZaQtfUb+YB+XNqocmv9UDaCdKIqh25H2DFcnaFB
	 f43dzIRM2mcAEo6uirQbHD3Ms7wAYOCe1w7RZj84eyo7I6hRg17n260U3uhECChlCS
	 3xw9Nx6qkGP28XaVedUEPq4c7dcQ1ti5CLuh9Vx8YCStxKyEBuBBbf9SO0bwb6l4vz
	 dvc9H9GJAHesfmuR2AsTpkSU6B7zITUD7S0pj/nvbGmrBoVqAKKuGZPVgElHKEywN2
	 jZ7p6pSzAS0MXQp6Z/rovqjk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DC3F40E0202;
	Wed, 26 Feb 2025 17:52:17 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:52:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 3/6] x86/microcode/intel: Prepare for microcode staging
Message-ID: <20250226175209.GNZ79UyXn5pODSYNrn@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211014213.3671-4-chang.seok.bae@intel.com>

On Tue, Dec 10, 2024 at 05:42:09PM -0800, Chang S. Bae wrote:
> +static void stage_microcode(void)
> +{
> +	unsigned int totalsize, pkg_id = UINT_MAX;
> +	enum ucode_state state;
> +	int cpu;
> +	u64 pa;
> +
> +	totalsize = get_totalsize(&ucode_patch_late->hdr);
> +	if (!IS_ALIGNED(totalsize, sizeof(u32)))
> +		return;


	... lockdep assert hotplug lock held blabla...

> +
> +	/*
> +	 * The MMIO address is unique per package, and all the SMT
> +	 * primary threads are online here. Find each MMIO space by
> +	 * their package ids to avoid duplicate staging.
> +	 */
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		if (!topology_is_primary_thread(cpu) || topology_logical_package_id(cpu) == pkg_id)
> +			continue;

		if (!topology_is_primary_thread(cpu) ||
		     topology_logical_package_id(cpu) == pkg_id)


> +		pkg_id = topology_logical_package_id(cpu);
> +
> +		rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &pa);
> +
> +		state = do_stage(pa, ucode_patch_late, totalsize);
> +		if (state != UCODE_OK) {
> +			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
> +			       state == UCODE_TIMEOUT ? "timeout" : "error state", cpu, pkg_id);
> +			return;
> +		}
> +	}
> +
> +	pr_info("Staging of patch revision 0x%x succeeded.\n",
> +		((struct microcode_header_intel *)ucode_patch_late)->rev);
> +}
> +
>  static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
>  					  struct microcode_intel *mc,
>  					  u32 *cur_rev)
> @@ -627,6 +662,7 @@ static struct microcode_ops microcode_intel_ops = {
>  	.collect_cpu_info	= collect_cpu_info,
>  	.apply_microcode	= apply_microcode_late,
>  	.finalize_late_load	= finalize_late_load,
> +	.stage_microcode	= stage_microcode,

Btw, you can get rid of ->use_staging and simply check whether
->stage_microcode is not NULL.

>  	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
>  };
>  
> diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
> index b27cb8e1228d..158429d80f93 100644
> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -120,11 +120,18 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
>  void load_ucode_intel_ap(void);
>  void reload_ucode_intel(void);
>  struct microcode_ops *init_intel_microcode(void);
> +static inline enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)
> +{
> +	pr_debug_once("Need to implement the staging code.\n");
> +	return UCODE_ERROR;
> +}
>  #else /* CONFIG_CPU_SUP_INTEL */
>  static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
>  static inline void load_ucode_intel_ap(void) { }
>  static inline void reload_ucode_intel(void) { }
>  static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
> +static inline enum ucode_state
> +do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize) { return UCODE_ERROR; }
>  #endif  /* !CONFIG_CPU_SUP_INTEL */
>
You don't need to export those if staging is going to be done only by the
Intel side. Just keep everything in intel.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

