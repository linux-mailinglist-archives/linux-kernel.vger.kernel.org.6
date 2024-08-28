Return-Path: <linux-kernel+bounces-305144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92260962A36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0089DB23DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C319DF67;
	Wed, 28 Aug 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMiHt29o"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3D2D600
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855259; cv=none; b=RJjmVixI13C6mnivwx/7G6IUNmWzhAQ3DN/LP6F1nkV4CRvlUeusqFbQgxkiPPIDwmGWe7ya1Gk0iQwD0WRykF6Qudss2GAb0UwM1iVLJEiTzs2euxbIHkV5L2qeJ2JUkPNLZqGsj6jl77dU299wfoKza6o6dvsRZJmXQMN0GgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855259; c=relaxed/simple;
	bh=LrfKXxq5fUZiBLqw9Ytc2vg5QLnJoJg1U4xYgYFfVJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba1+gEweqaLaClZTptY4PVA+P5ek0Nwmloo/wdYxlEn1aYCVWKqBCfembAH3s+9cuLxt64yGzBt1DoDaSmNByXLRjri16PCDYJ57Kn9Wt1IDof5uBeixWdPTrLCsD734fFRFD0f9ngqFAeK/a9x4jGUx9bLKNGzfSm+3CCUOPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMiHt29o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83562f9be9so635875966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724855255; x=1725460055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKUQxEFCjBIV2FGcEmpu9pMke+ylyw5c7eHy/Ue8ep0=;
        b=bMiHt29oYmudSaAgMlopG1QyxkWDvOal3qQTOOkl3G72UdXlbvk5zqM5BGKrXLQRGy
         pILOkEMSCA9J93K70xdsi/Uu3OdB7vIZnBU4uNx5r9BI0PdpGYRcbWf6lQlLqK70uBF7
         tA384Wx5rf6oxMPTrBlFCC00Ud5/7iGCDTLE6unquI3/+QNGvjbw12joCXEVCd33zZHm
         Ijt1KGBUnIPznWJpDo3zVC3b2xHjFGHwXO3rTS7vmQsVRCJd9mgFXp9rxuaZDov4o+et
         8IKdbWh0r/4UF71zF9O//67jDD/zLBp/nsk4PvHk3DvXMfL1826oBC9Prk6ORV7H9sYn
         7xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855255; x=1725460055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKUQxEFCjBIV2FGcEmpu9pMke+ylyw5c7eHy/Ue8ep0=;
        b=jqf1V4Nm14AEXlVWEIRTuefetrg3jxi6/LTAgP2jykAzZMWKPBI8tPfP8Hl3hM3LVP
         E6VRVCMHiMCva/psaVtwMBtwgWr4OHw0Z5qguHZznq2lxv1uBtzq1pRlghMBkqea67vy
         jxXmOEytpvgUPjUGbm44kczDhbYde+AE1TAMZ4riqGjnee3YGwBv3ufXvwWQaGcwZ5Wq
         4Bhl6gh3SaLQpYfWqO1Qd4PHiLWHBwEWjPVVenp+0ctPp66cNgiilpnXxiSr7RMbWwBA
         gvrPXY7l8SP6by8PMBuxMki+W5El3QnaRA3JSKotQRQsPmSsfU+Wp2jv5nRMeVsEnvJX
         6W8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw7bvNhIRurJm3mdqVSDAhMRwBqvYB5PG445R2Hel6/hZxW8h/qEMhfe7Js2FvJLwm26Q+n7fmoIEGb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztdVdm3EbCUgkDUUG8Voq+pF17uXG5Nx+f+MGVwudixsK9VjFE
	M6boDlv701Fmj4q/El2YEKctS64x6jQF3kfp7H2IRWuVZ0rCcagQIkUxvsex3qc=
X-Google-Smtp-Source: AGHT+IFnd0CvBW2tABoaK1J/pJgxzTxcr2o+uC11U99GYHYQiH/fIhe9VfOGvgAmhW5w7FBYxbQubQ==
X-Received: by 2002:a17:907:7da7:b0:a7a:9a78:4b59 with SMTP id a640c23a62f3a-a86a519905amr1155865466b.23.1724855255191;
        Wed, 28 Aug 2024 07:27:35 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-46.ip.btc-net.bg. [212.5.158.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e587854csm250765566b.169.2024.08.28.07.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 07:27:34 -0700 (PDT)
Message-ID: <0dce2a59-544a-4e98-b895-ce5848778108@suse.com>
Date: Wed, 28 Aug 2024 17:27:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
 <20240828093505.2359947-4-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240828093505.2359947-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.08.24 г. 12:35 ч., Kirill A. Shutemov wrote:
> Memory access #VEs are hard for Linux to handle in contexts like the
> entry code or NMIs.  But other OSes need them for functionality.
> There's a static (pre-guest-boot) way for a VMM to choose one or the
> other.  But VMMs don't always know which OS they are booting, so they
> choose to deliver those #VEs so the "other" OSes will work.  That,
> unfortunately has left us in the lurch and exposed to these
> hard-to-handle #VEs.
> 
> The TDX module has introduced a new feature. Even if the static
> configuration is set to "send nasty #VEs", the kernel can dynamically
> request that they be disabled. Once they are disabled, access to private
> memory that is not in the Mapped state in the Secure-EPT (SEPT) will
> result in an exit to the VMM rather than injecting a #VE.
> 
> Check if the feature is available and disable SEPT #VE if possible.
> 
> If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> attribute is no longer reliable. It reflects the initial state of the
> control for the TD, but it will not be updated if someone (e.g. bootloader)
> changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> determine if SEPT #VEs are enabled or disabled.

LGTM. However 2 minor suggestions which might be worth addressing.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
> Cc: stable@vger.kernel.org
> Acked-by: Kai Huang <kai.huang@intel.com>
> ---
>   arch/x86/coco/tdx/tdx.c           | 76 ++++++++++++++++++++++++-------
>   arch/x86/include/asm/shared/tdx.h | 10 +++-
>   2 files changed, 69 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 08ce488b54d0..f969f4f5ebf8 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -78,7 +78,7 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>   }
>   
>   /* Read TD-scoped metadata */
> -static inline u64 __maybe_unused tdg_vm_rd(u64 field, u64 *value)
> +static inline u64 tdg_vm_rd(u64 field, u64 *value)
>   {
>   	struct tdx_module_args args = {
>   		.rdx = field,
> @@ -193,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
>   		__tdx_hypercall(&args);
>   }
>   
> +/*
> + * The kernel cannot handle #VEs when accessing normal kernel memory. Ensure
> + * that no #VE will be delivered for accesses to TD-private memory.
> + *
> + * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
> + * controls if the guest will receive such #VE with TD attribute
> + * ATTR_SEPT_VE_DISABLE.
> + *
> + * Newer TDX modules allow the guest to control if it wants to receive SEPT
> + * violation #VEs.
> + *
> + * Check if the feature is available and disable SEPT #VE if possible.
> + *
> + * If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> + * attribute is no longer reliable. It reflects the initial state of the
> + * control for the TD, but it will not be updated if someone (e.g. bootloader)
> + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> + * determine if SEPT #VEs are enabled or disabled.
> + */
> +static void disable_sept_ve(u64 td_attr)
> +{
> +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
> +	bool debug = td_attr & ATTR_DEBUG;
> +	u64 config, controls;
> +
> +	/* Is this TD allowed to disable SEPT #VE */
> +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
> +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {

Should you check for the presence of those controls in in 
TDX_FEATURES0.PENDING_EPT_VIOLATION_V2 ? I.e perhaps this code can be 
put in the same function that checks the presence of RBP_NO_MOD in a 
different series by Kai Huang?


> +		/* No SEPT #VE controls for the guest: check the attribute */
> +		if (td_attr & ATTR_SEPT_VE_DISABLE)
> +			return;

nit: Given that we expect most guests to actually have this attribute 
set perhaps moving this check at the top of the function will cause it 
exit early more often than not?
> +
> +		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
> +		if (debug)
> +			pr_warn("%s\n", msg);
> +		else
> +			tdx_panic(msg);
> +		return;
> +	}
> +
> +	/* Check if SEPT #VE has been disabled before us */
> +	tdg_vm_rd(TDCS_TD_CTLS, &controls);
> +	if (controls & TD_CTLS_PENDING_VE_DISABLE)
> +		return;
> +
> +	/* Keep #VEs enabled for splats in debugging environments */
> +	if (debug)
> +		return;
> +
> +	/* Disable SEPT #VEs */
> +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
> +		  TD_CTLS_PENDING_VE_DISABLE);
> +
> +	return;
> +}
> +
>   static void tdx_setup(u64 *cc_mask)
>   {
>   	struct tdx_module_args args = {};

<snip>

