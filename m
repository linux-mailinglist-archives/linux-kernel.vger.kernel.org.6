Return-Path: <linux-kernel+bounces-178831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF98C5857
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D67E281CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B817EB85;
	Tue, 14 May 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ODk1gx8g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECB17B518
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698592; cv=none; b=cEsl4b0gPXrXYSnWzvez74Xsmsorbhjy6/xhSwrYMQHFXZEyretBKI7aEbhxlbPfwDMC7xkZMRPAhhwOWJPvZWuEuxIJK5agFJPyRRtQ/CGJzxRnRLF6sQtrZ0wxi8MpdsJBhRuG3E9YtVpNw+PzuYi9sODADpM1xELdGIE1+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698592; c=relaxed/simple;
	bh=z6fAyKn/SpWWFe2JXSPhWLmYwTyrsGE1TLC7A0eNQww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUEpEaZEM5lvdq/QyXxz1JpvRYMjwABZKLowq2UR7cLfSe/sw+KJ6LY+8WjpmXRrB2nyKLxnAQX9OT9/OW//bSJN+qblHjoN+syFcyQfxUQtaaXPazDtzrtCoulqj5wCosbuhIShvFJpmaW9T2UdB1S6Dq3CoHkex91qWBqMcVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ODk1gx8g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so38035645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715698587; x=1716303387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzm/YTMCpj48fbYX/SiJJaWBOaoRNZq6+Vjd36u99Ic=;
        b=ODk1gx8gGQF1yatfOTsKxOv3YjMRWeDk8gcs3dWUQtr+SB6qlka9f2aCY3BlrGI+cf
         ccRl2+U4RAd9Qt3qtgWgugXgdF879MfqIoZbeyzlEw0gZ5wpUP436anwUmlKB9qhAFYh
         fNw+R0losQ9YYM7963wjg4+c3N+TtGZpF9+vDh1fAQLwI/bkdpiyJCvs11DVysfAnWm0
         ychNJEeIQ67XfF1uhO1Hf9B8W5hV+Qj5JdNFq+EA9EETRBc/uQnvUR7+K/pV80HK2BHw
         OebECOqsVVWoSdYdB3uoMUWnDwixQJ5+AnWk5cebBdImPszGOjUpH+U+r/C7sL6DHvyC
         YzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698587; x=1716303387;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzm/YTMCpj48fbYX/SiJJaWBOaoRNZq6+Vjd36u99Ic=;
        b=igwhilMQhdie3ojD2n8jH+oOlMbVelVG+uMlJCiYPO0AhNakhCcgCqCtgcrWIf8jjd
         DxCoGmUXdXQJnIw7EJQMwbBlDIABiViQ5EfifCdltUxzp/9I3tgS5sQ7DZO9ncp3SOvC
         u8VJS+m0gZpz5O4HeKNGfl+dincPhGH9BtuMXH4c74y3lJybYgK5tcyZW7Clsicwg0mL
         p7FMB7SRaVE1XUIfHQ3VBX2WazZLv9uSP6DVY9N4pg8oQTqgJ7tl0qMJmcTJNNZSPVzr
         wKJNzraNEoLpjJbXl739xEEt2oLxt2mVjtJ2T6WyvEPOQZW6UpQQqP212t4D9wDLQ8uM
         elwA==
X-Forwarded-Encrypted: i=1; AJvYcCXSnbFl7b43bTMFBOQHe3+jLpfUnQREpC47m21uhcv18O00Nf9DYiYzaf4+yJUzSo/SW6E/xEgDdZo0f704IWjwWF6V/hJeiMHlRGKJ
X-Gm-Message-State: AOJu0YyQcMwFjHIsbzmQx2rHB0nHYTUEr3VcdJSHr45qHAb2sarzbVpN
	4m+5sdOnW0IILHn/pCiIad/AXCorTJ+XavFbDnW4YOs6+6f4jDUc1OZjGn0Mdtw=
X-Google-Smtp-Source: AGHT+IG0VcdWIeT4PzXXz06JGTHeBkT+18KEYemx0hl3tEIhJioXs2xJKw1upFf3YTD1NYeX0DEDLQ==
X-Received: by 2002:a05:600c:3c83:b0:41b:8041:53c2 with SMTP id 5b1f17b1804b1-41feac51e04mr130867835e9.15.1715698587492;
        Tue, 14 May 2024 07:56:27 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:8f53:4974:39da:db5c? ([2a10:bac0:b000:7315:8f53:4974:39da:db5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ffd56e4f1sm152481725e9.0.2024.05.14.07.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 07:56:27 -0700 (PDT)
Message-ID: <4019eff6-18a9-49b2-9567-096cdb498fb0@suse.com>
Date: Tue, 14 May 2024 17:56:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
 <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.05.24 г. 15:21 ч., Kirill A. Shutemov wrote:
> Memory access #VE's are hard for Linux to handle in contexts like the
> entry code or NMIs.  But other OSes need them for functionality.
> There's a static (pre-guest-boot) way for a VMM to choose one or the
> other.  But VMMs don't always know which OS they are booting, so they
> choose to deliver those #VE's so the "other" OSes will work.  That,
> unfortunately has left us in the lurch and exposed to these
> hard-to-handle #VEs.
> 
> The TDX module has introduced a new feature.  Even if the static
> configuration is "send nasty #VE's", the kernel can dynamically request
> that they be disabled.
> 
> Check if the feature is available and disable SEPT #VE if possible.
> 
> If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> attribute is no longer reliable. It reflects the initial state of the
> control for the TD, but it will not be updated if someone (e.g. bootloader)
> changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> determine if SEPT #VEs are enabled or disabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
> Cc: stable@vger.kernel.org

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com> though one nit below.

> ---
>   arch/x86/coco/tdx/tdx.c           | 88 +++++++++++++++++++++++++------
>   arch/x86/include/asm/shared/tdx.h | 11 +++-
>   2 files changed, 83 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1ff571cb9177..ba37f4306f4e 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>   		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>   }
>   
> +/* Read TD-scoped metadata */
> +static inline u64 tdg_vm_rd(u64 field, u64 *value)
> +{
> +	struct tdx_module_args args = {
> +		.rdx = field,
> +	};
> +	u64 ret;
> +
> +	ret = __tdcall_ret(TDG_VM_RD, &args);
> +	*value = args.r8;
> +
> +	return ret;
> +}

nit: Perhaps this function can be put in the first patch and the 
description there be made more generic, something along the lines of 
"introduce functions for tdg_rd/tdg_wr" ?

> +
>   /* Write TD-scoped metadata */
>   static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
>   {
> @@ -179,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
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
> + * Newer TDX module allows the guest to control if it wants to receive SEPT
> + * violation #VEs.
> + *
> + * Check if the feature is available and disable SEPT #VE if possible.
> + *
> + * If the TD allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
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
> +		/* No SEPT #VE controls for the guest: check the attribute */
> +		if (td_attr & ATTR_SEPT_VE_DISABLE)
> +			return;
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
> @@ -204,24 +274,12 @@ static void tdx_setup(u64 *cc_mask)
>   	gpa_width = args.rcx & GENMASK(5, 0);
>   	*cc_mask = BIT_ULL(gpa_width - 1);
>   
> +	td_attr = args.rdx;
> +
>   	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
>   	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>   
> -	/*
> -	 * The kernel can not handle #VE's when accessing normal kernel
> -	 * memory.  Ensure that no #VE will be delivered for accesses to
> -	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
> -	 */
> -	td_attr = args.rdx;
> -	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
> -		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> -
> -		/* Relax SEPT_VE_DISABLE check for debug TD. */
> -		if (td_attr & ATTR_DEBUG)
> -			pr_warn("%s\n", msg);
> -		else
> -			tdx_panic(msg);
> -	}
> +	disable_sept_ve(td_attr);
>   }
>   
>   /*
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index fdfd41511b02..fecb2a6e864b 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -16,11 +16,20 @@
>   #define TDG_VP_VEINFO_GET		3
>   #define TDG_MR_REPORT			4
>   #define TDG_MEM_PAGE_ACCEPT		6
> +#define TDG_VM_RD			7
>   #define TDG_VM_WR			8
>   
> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> +#define TDCS_TD_CTLS			0x1110000300000017
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
>   
> +/* TDCS_CONFIG_FLAGS bits */
> +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
> +
> +/* TDCS_TD_CTLS bits */
> +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001
>   #define TDVMCALL_GET_QUOTE		0x10002

