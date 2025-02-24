Return-Path: <linux-kernel+bounces-529489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448DA426DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C72D1892E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9FF260A23;
	Mon, 24 Feb 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ddsWXL19"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AF25EFBC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411954; cv=none; b=i4ntQxl0NYAyzmU3Gxp9MO2VXjDLzBfwfBqx+LpXA0sCcJGYlpj+dGqPOWChZ5/0fheXXn5DhO9+ZxQD1kRs3fHxKwQ6EfRP1YgXVvVPLMg/y7bWetomvJxvPnoV6JtMMk8FILDnN/R+/SJ5er4osJmTeMs8ACgzfAAf/LLUNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411954; c=relaxed/simple;
	bh=6w9JznFWcu4k7nMsFiDQ3P70C5wFJZPdaMzPjz6phu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mREimVvhslIa2fO+GxvbERTk5mTm0aF7YBT+XABQO1a/SaNhKkfnLSgYHJ1KltPVpHHYfwjwp1ntjs2sZfWaM7DjqeK7AVUmvERaeqtScPQ/t45QfyVcfPhKQDr8iVCL0ixMPf14221eK5QRoFJXbk1O8yLH9TZt6tN9cr1qGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ddsWXL19; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1355740E0177;
	Mon, 24 Feb 2025 15:45:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EdTmD4OHH5AA; Mon, 24 Feb 2025 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740411945; bh=a9cepnlaTXdgU4WPhcPoszC014XzMTbJYKTAWbDclAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddsWXL19HknqZkfBsFhaXJ5QdgWkwZyTr1e5nHWbHOmkhngRoUKNg9Q5HpdXgytCw
	 VkV8S60yddajHm1Oa7+t7zdM3u6Bf2gX59vhROdJ9/veKxZvesh6RvaK0ZdhLRbVaA
	 +qdlMmitc3Fr2rlVisX+xWax1ahFv+AWSU70sGZBxYjd/Pz3RZpOaPALiSUcrM/fKD
	 RDaOTG2dO2Tp9/iU/HJZus7Xz8Y2eynkZvmpHDRHg6cUd5NVjAi6Hm0ucojbr/A6GD
	 7s/WySnw7JAvXb0HOQcYyJK4Ug82oRG5SL3RcFupRLiWo1k/YiE+lXlSNQj5Y+O8Iv
	 L16/ontlR30gpxPb77+t1px1eEW+6rtEIQktEJ3MsSoMEJ4Nvjpoxf3of8mEVdL6bE
	 yGqH2zXOHA2by2xd91YCi/FH86/fM91rfgJZ4r9PKWAKF2lTpIu8aW4MPJf26dEb30
	 eeu+iYp+S/aJymCpcrNro8xKoTNlUlUGQeJOk4oqQgdvJRLafa1+xWtC7zzEWJxM8w
	 GbyOcSlbQbJh4lk81zQZiJi0iLaj1lBUpYxsWM40hj28f1YiEWP5DRuggc4OW9G8T3
	 AaDv1iCtPOHcjMLMyNJgmGgE4axUI0wcGwn26miHPEZqb/mgmbGaFTWb2Gr0F5BAMN
	 7iKgFqg7ml8ptJQ7PLFumh8Q=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23B2440E01B2;
	Mon, 24 Feb 2025 15:45:35 +0000 (UTC)
Date: Mon, 24 Feb 2025 16:45:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/35] x86/bugs: Restructure retbleed mitigation
Message-ID: <20250224154529.GJZ7yUGfQiyQJc_aMl@fat_crate.local>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-13-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108202515.385902-13-david.kaplan@amd.com>

On Wed, Jan 08, 2025 at 02:24:52PM -0600, David Kaplan wrote:
> +static void __init retbleed_update_mitigation(void)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
> +		return;
>  
> -		break;
> +	if (retbleed_mitigation == RETBLEED_MITIGATION_NONE)
> +		goto out;
> +	/*
> +	 * Let IBRS trump all on Intel without affecting the effects of the
> +	 * retbleed= cmdline option except for call depth based stuffing
> +	 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
> +		switch (spectre_v2_enabled) {
> +		case SPECTRE_V2_IBRS:
> +			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
> +			break;
> +		case SPECTRE_V2_EIBRS:
> +		case SPECTRE_V2_EIBRS_RETPOLINE:
> +		case SPECTRE_V2_EIBRS_LFENCE:
> +			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
> +			break;
> +		default:
> +			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
> +				pr_err(RETBLEED_INTEL_MSG);
> +		}
>  	}
>  
> +	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF) {
> +		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
> +			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
> +			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
> +			/* Try again */
> +			retbleed_select_mitigation();

Err, why?

spectre_v2 and spectre_v2_enabled cannot change anymore - the select function
has set them. Why try again here?

This kinda defeats the whole purpose of having the select -> update -> apply
rounds...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

