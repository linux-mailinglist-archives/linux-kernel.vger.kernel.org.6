Return-Path: <linux-kernel+bounces-556238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E4A5C306
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458631899054
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702091D5165;
	Tue, 11 Mar 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4nw8c1X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8911CEEB2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701192; cv=none; b=cVnlcAAMnXMTx/2+fbUKU/gKN3q9/TLZIO7Rd1q9fNU25P1XgwRe2yZUs+x1oiZYbijLCN/R5vlrP8xIV7/fZ7JDE8NMZPbg8T5QtALSYIOsLvmVgwkoVUKaaUkDZI0c7WzUOB8OTMrq7VC22nSQ4k8WvpN6Tgm4nGA4vPtrlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701192; c=relaxed/simple;
	bh=wmWywKS5vDDJtSKTNaZeRU38Jcr1Dr4FMK7f3cvvuhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMjeQiEQ2IuYcWOQKFTXSi0BZbMAciIT+EAQSDs5yI+k9pzvbe3dSeAEJigCFEZ6XTIatM0OIn+zpWnoAV2WqFcmDFo1dKWbV9yhVG1LZmtYZ3MxtRngm6lPK28PPepTia/G6r9cKIUX6Kn/WnoW0hBoeUmIrvGmzmqpyURPgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4nw8c1X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741701191; x=1773237191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wmWywKS5vDDJtSKTNaZeRU38Jcr1Dr4FMK7f3cvvuhk=;
  b=A4nw8c1XwM4U/yau42rG14/gsGMX/9/WkbEmodTFGmjns0chlUhTKqVO
   4Qn0dDGOqYRMCeHFA8KgVGtBMHtsvSZLGgJPJA4wwwNgaGLlIFKQmb7Jn
   m3Qp2wvujqbC5G29bef0ImOMsZ9KdHa5EtyK6HV7Caek4u2PK2C4q+CD9
   1p03jL5+UUMZB8B2twcH1Eeqjbxr9fpeiz1PLMb0Ef3k6qyFI+It0FmfH
   Zi16s/WeN/sWhdPzFJ6zVXgUDRwTo/QphZRcJYdB2VsATiEiuX09KO9pX
   ls2n/dAN7U8gej27fCoSCld8Q2tp3DyVEDusZfDOL56r5ZTUHny/nHstq
   w==;
X-CSE-ConnectionGUID: 6ySZFvLDRLKCP4R3aCPL8A==
X-CSE-MsgGUID: uoRNw9v6S0+l1VoovpArqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41905685"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="41905685"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 06:53:11 -0700
X-CSE-ConnectionGUID: hL4xj8iOS/elwGO/7072DQ==
X-CSE-MsgGUID: AxHEUYQwRo6Hcr//Enfx3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="124936968"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.42]) ([10.124.221.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 06:53:09 -0700
Message-ID: <49a6a810-e793-443e-8bb9-a14b2ef6d676@linux.intel.com>
Date: Tue, 11 Mar 2025 06:53:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] x86: coco: replace static const cc_mask with a
 function
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Yue Haibing <yuehaibing@huawei.com>,
 Juergen Gross <jgross@suse.com>, David Woodhouse <dwmw@amazon.co.uk>,
 linux-kernel@vger.kernel.org
References: <20250310131114.2635497-1-arnd@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250310131114.2635497-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/10/25 6:10 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When extra warnings are enabled, the cc_mask definition in asm/coco.h
> causes a build failure with gcc:
>
> arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
>     28 | static const u64 cc_mask = 0;
>
> Add a cc_get_mask() function mirroring cc_set_mask() for the one
> user of the variable outside of the coco implementation.
>
> Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> --

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> v2: use an inline helper instead of a __maybe_unused annotaiton.
> ---
>   arch/x86/include/asm/coco.h          | 10 +++++++++-
>   arch/x86/include/asm/pgtable_types.h |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index aa6c8f8ca958..e7225452963f 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -15,6 +15,11 @@ enum cc_vendor {
>   extern enum cc_vendor cc_vendor;
>   extern u64 cc_mask;
>   
> +static inline u64 cc_get_mask(void)
> +{
> +	return cc_mask;
> +}
> +
>   static inline void cc_set_mask(u64 mask)
>   {
>   	RIP_REL_REF(cc_mask) = mask;
> @@ -25,7 +30,10 @@ u64 cc_mkdec(u64 val);
>   void cc_random_init(void);
>   #else
>   #define cc_vendor (CC_VENDOR_NONE)
> -static const u64 cc_mask = 0;
> +static inline u64 cc_get_mask(void)
> +{
> +	return 0;
> +}
>   
>   static inline u64 cc_mkenc(u64 val)
>   {
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index c90e9c51edb7..74d461cc8e20 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -179,7 +179,7 @@ enum page_cache_mode {
>   };
>   #endif
>   
> -#define _PAGE_CC		(_AT(pteval_t, cc_mask))
> +#define _PAGE_CC		(_AT(pteval_t, cc_get_mask()))
>   #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
>   
>   #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


