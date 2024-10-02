Return-Path: <linux-kernel+bounces-347688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36EF98DAEB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0303E1C23796
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503261D0B93;
	Wed,  2 Oct 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWv5AUZ7"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB411E52C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878865; cv=none; b=e9aQPhlJunllPW9j+cC1vs+SzqFeYOFmqWtjhClROdX0y3lGSUMQVXXV2tMei5K8XRwvAoq7jf0snydjz8tXcKfYviDy0c/eLK9LCP810yvqiZGYYXwDsgKjbZFGLYmvKrzR8PPUZe17YYYZumrWnJDP0ZmrjK/YYDqWT74Tljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878865; c=relaxed/simple;
	bh=iZKUcOr9WiY7fw1TZEJpDuldbbShm1jCokqyOTVUnmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFvmMUZH2slDASNnsQrD8WinKVYu/PhSaQ4/K2GK2yS05A+3if9xuqKzlvvoBKCZK4OOHLGhxZJ1luBP3/dQIfD6zwlrKQI7mlOBldPuEiFzWyfQW6fdeQJfKZahohwpHibqeO/ECzJ5EBK9H85YJUMXjKVvkU9krwGrt5BXKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWv5AUZ7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso43677901fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727878861; x=1728483661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOjmMSD+1qFUDNahCJtFQCykO0u5IxQPYan6U2unhTo=;
        b=TWv5AUZ7LwbG8vsAofebMvnNpzRc0C3l9xvz4opC98oCIGt/Z7/dFlhoFAtSTojPsn
         ITC0gQu54r3l187uK56QcsSwRID6tYDQrqoD2TANK3xjLrh07gOgB+UHqJxWLOp3NsUL
         Q5CoSn6Vo3r3T6UI+P3An6XVuLpocfVP/4IPiV8R70vHntgBGmj4W6GtuvmgbmdXTmT3
         AUXHmNnzsY6NEfEbbegJkJLU473aeHLTCMH9EZoQ8Zx9s90Qk6E7CwS5I4j7iLUFcEzc
         OCPky5eKhGGKw/qJnQz9zHM8I9zmpZgsKz6zfDoOZTStLNrnMkzPNxncm2iOZ2n5OTs9
         XHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878861; x=1728483661;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOjmMSD+1qFUDNahCJtFQCykO0u5IxQPYan6U2unhTo=;
        b=LQ354VQQzwhSstR+23Cgaw4weL8N2B3FaVFGQ4CR6xLBfZ2ueiULQygFKn5jmjH9vf
         lihB1rg04cmAFH1K9Ml6EMy9gzUOznE6du50M+G6BKyhCfH8u2tQLhH+q1uNvCwU+/c4
         N/8679R5N4fvdEidOjeOxQOGu9/6/HZhON3yG4QQ/fb6L01KO7coe/YlM70kiDR8V3v0
         OoJA9TziOF6YO9psW5YyQOcDV0ZZPlSbyYrBmpuJq4OIN8BmU2/4qjLL8vRRtEMRNVql
         3MsQgTzyS6Gq+fk64WCT8cTbyWrgu6CgGIMRbzefQES0AcRoa9aDIHF341iPvATPfzow
         jQLA==
X-Forwarded-Encrypted: i=1; AJvYcCViwkkqjGaypkIhUVcU92K1DKVvDaq9SIFQY3pYfE21jYaq1YhBfAScBqxvy0+MRAq+Mu0UqSNzZLyWkqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgbWQMfBBDB2M7H8cAwkEn3iCsywAPexn1ThORHXqAObG5zf0
	SBPU3Nz+6x0WS1PFDeyyw2tCS7i9o4OoAOMVimY67CVfKmDfXTfbWJcW1T4JTP0=
X-Google-Smtp-Source: AGHT+IF9UkuFw+jI8gubKxftX8cq188rSSp6EYoZVMKxXBrLE96YC4OiagtH/BEnyk21lHDkYa4cAw==
X-Received: by 2002:a2e:bc24:0:b0:2fa:d4c1:3b6b with SMTP id 38308e7fff4ca-2fae10c5564mr22928251fa.33.1727878861066;
        Wed, 02 Oct 2024 07:21:01 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ea57sm7630698a12.55.2024.10.02.07.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:20:59 -0700 (PDT)
Message-ID: <fe2dfd0b-6b2a-496e-b059-0600d2ae474c@suse.com>
Date: Wed, 2 Oct 2024 17:20:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.09.24 г. 1:31 ч., Daniel Sneddon wrote:
> The current md_clear routines duplicate a lot of code, and have to be
> called twice because if one of the mitigations gets enabled they all
> get enabled since it's the same instruction. This approach leads to
> code duplication and extra complexity.
> 
> The only piece that really changes between the first call of
> *_select_mitigation() and the second is X86_FEATURE_CLEAR_CPU_BUF
> being set.  Determine if this feature should be set prior to calling
> the _select_mitigation() routines. This not only means those functions
> only get called once, but it also simplifies them as well.
> 
> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 191 +++++++++++++++----------------------
>   1 file changed, 77 insertions(+), 114 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 45411880481c..412855391184 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -41,7 +41,6 @@ static void __init spectre_v2_user_select_mitigation(void);
>   static void __init ssb_select_mitigation(void);
>   static void __init l1tf_select_mitigation(void);
>   static void __init mds_select_mitigation(void);
> -static void __init md_clear_update_mitigation(void);
>   static void __init md_clear_select_mitigation(void);
>   static void __init taa_select_mitigation(void);
>   static void __init mmio_select_mitigation(void);
> @@ -244,21 +243,9 @@ static const char * const mds_strings[] = {
>   
>   static void __init mds_select_mitigation(void)
>   {
> -	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
> -		mds_mitigation = MDS_MITIGATION_OFF;
> -		return;
> -	}
> -
> -	if (mds_mitigation == MDS_MITIGATION_FULL) {
> -		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
> -			mds_mitigation = MDS_MITIGATION_VMWERV;
> -
> -		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> -
> -		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
> -		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
> -			cpu_smt_disable(false);
> -	}
> +	if (mds_mitigation == MDS_MITIGATION_FULL &&
> +	    !boot_cpu_has(X86_FEATURE_MD_CLEAR))
> +		mds_mitigation = MDS_MITIGATION_VMWERV;
>   }
>   
>   #undef pr_fmt
> @@ -284,35 +271,17 @@ static const char * const taa_strings[] = {
>   
>   static void __init taa_select_mitigation(void)
>   {
> -	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
> -		taa_mitigation = TAA_MITIGATION_OFF;
> -		return;
> -	}
> -
>   	/* TSX previously disabled by tsx=off */
>   	if (!boot_cpu_has(X86_FEATURE_RTM)) {
>   		taa_mitigation = TAA_MITIGATION_TSX_DISABLED;
>   		return;
>   	}
>   
> -	if (cpu_mitigations_off()) {
> -		taa_mitigation = TAA_MITIGATION_OFF;
> +	if (!boot_cpu_has(X86_FEATURE_MD_CLEAR)) {
> +		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
>   		return;
>   	}
>   
> -	/*
> -	 * TAA mitigation via VERW is turned off if both
> -	 * tsx_async_abort=off and mds=off are specified.
> -	 */
> -	if (taa_mitigation == TAA_MITIGATION_OFF &&
> -	    mds_mitigation == MDS_MITIGATION_OFF)
> -		return;
> -
> -	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
> -		taa_mitigation = TAA_MITIGATION_VERW;
> -	else
> -		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
> -
>   	/*
>   	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
>   	 * A microcode update fixes this behavior to clear CPU buffers. It also
> @@ -325,18 +294,6 @@ static void __init taa_select_mitigation(void)
>   	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
>   	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
>   		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
> -
> -	/*
> -	 * TSX is enabled, select alternate mitigation for TAA which is
> -	 * the same as MDS. Enable MDS static branch to clear CPU buffers.
> -	 *
> -	 * For guests that can't determine whether the correct microcode is
> -	 * present on host, enable the mitigation for UCODE_NEEDED as well.
> -	 */
> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> -
> -	if (taa_nosmt || cpu_mitigations_auto_nosmt())
> -		cpu_smt_disable(false);
>   }
>   
>   #undef pr_fmt
> @@ -360,24 +317,6 @@ static const char * const mmio_strings[] = {
>   
>   static void __init mmio_select_mitigation(void)
>   {
> -	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
> -	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
> -	     cpu_mitigations_off()) {
> -		mmio_mitigation = MMIO_MITIGATION_OFF;
> -		return;
> -	}
> -
> -	if (mmio_mitigation == MMIO_MITIGATION_OFF)
> -		return;
> -
> -	/*
> -	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
> -	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
> -	 */
> -	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
> -					      boot_cpu_has(X86_FEATURE_RTM)))
> -		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> -
>   	/*
>   	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
>   	 * mitigations, disable KVM-only mitigation in that case.
> @@ -409,9 +348,6 @@ static void __init mmio_select_mitigation(void)
>   		mmio_mitigation = MMIO_MITIGATION_VERW;
>   	else
>   		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
> -
> -	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
> -		cpu_smt_disable(false);
>   }
>   
>   #undef pr_fmt
> @@ -435,16 +371,7 @@ static const char * const rfds_strings[] = {
>   
>   static void __init rfds_select_mitigation(void)
>   {
> -	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
> -		rfds_mitigation = RFDS_MITIGATION_OFF;
> -		return;
> -	}
> -	if (rfds_mitigation == RFDS_MITIGATION_OFF)
> -		return;
> -
> -	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
> -		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> -	else
> +	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
>   		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
>   }
>   
> @@ -485,41 +412,92 @@ static int __init clear_cpu_buffers_cmdline(char *str)
>   }
>   early_param("clear_cpu_buffers", clear_cpu_buffers_cmdline);
>   
> -static void __init md_clear_update_mitigation(void)
> +static bool __init cpu_bug_needs_verw(void)
>   {
> -	if (cpu_mitigations_off())
> -		return;
> +	return boot_cpu_has_bug(X86_BUG_MDS) ||
> +	       boot_cpu_has_bug(X86_BUG_TAA) ||
> +	       boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
> +	       boot_cpu_has_bug(X86_BUG_RFDS);
> +}
>   
> -	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
> -		goto out;
> +static bool __init verw_mitigations_disabled(void)
> +{
> +	/*
> +	 * TODO: Create a single mitigation variable that will allow for setting
> +	 * the location of the mitigation, i.e.:
> +	 *
> +	 * kernel->user
> +	 * kvm->guest
> +	 * kvm->guest if device passthrough
> +	 * kernel->idle
> +	 */
> +	return (mds_mitigation == MDS_MITIGATION_OFF &&
> +		taa_mitigation == TAA_MITIGATION_OFF &&
> +		mmio_mitigation == MMIO_MITIGATION_OFF &&
> +		rfds_mitigation == RFDS_MITIGATION_OFF);
> +}
>   
> +static void __init md_clear_select_mitigation(void)
> +{
>   	/*
> -	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
> -	 * Stale Data mitigation, if necessary.
> +	 * If no CPU bug needs VERW, all VERW mitigations are disabled, or all
> +	 * mitigations are disabled we bail.
>   	 */
> -	if (mds_mitigation == MDS_MITIGATION_OFF &&
> -	    boot_cpu_has_bug(X86_BUG_MDS)) {
> +	if (!cpu_bug_needs_verw() || verw_mitigations_disabled() ||
> +	    cpu_mitigations_off()) {
> +		mds_mitigation = MDS_MITIGATION_OFF;
> +		taa_mitigation = TAA_MITIGATION_OFF;
> +		mmio_mitigation = MMIO_MITIGATION_OFF;
> +		rfds_mitigation = RFDS_MITIGATION_OFF;
> +		goto out;
> +	}
> +
> +	/* Check that at least one mitigation is using the verw mitigaiton.
> +	 * If the cpu doesn't have the correct ucode or if the BUG_* is mitigated
> +	 * by disabling a feature we won't want to use verw. Ignore MMIO
> +	 * for now since it depends on what the others choose.
> +	 */
> +
> +	if (boot_cpu_has_bug(X86_BUG_MDS)) {
>   		mds_mitigation = MDS_MITIGATION_FULL;
>   		mds_select_mitigation();
> +	}  else {
> +		mds_mitigation = MDS_MITIGATION_OFF;
>   	}


BUt with this logic if CONFIG_MITIGATION_MDS is deselected meaning 
mds_mitigations will have the value MDS_MITIGATION_OFF, yet now you will 
set it to _FULL thereby overriding the compile-time value of the user. 
So shouldn't this condition be augmented to alsoo consider 
CONFIG_MITIGATION_MDS compile time value?

<snip>

