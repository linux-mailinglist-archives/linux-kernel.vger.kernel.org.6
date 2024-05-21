Return-Path: <linux-kernel+bounces-185018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1AF8CAF73
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979BFB2090F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1E76049;
	Tue, 21 May 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfFo78A3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA26E602
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298553; cv=none; b=KIC53jBc9BUjUKHTSa7SuBIGvEdSIfr6qGwrsKXX9UfX577ogVr7hH1M/HVheIzhwLh14W5y06HIIZiK8koPUELaA3guk73Z5+QZ8x0OggF67H9o8wZmjSBpjPr0Ozgp8vspO6IYbxJMRdavLL484rSnlNrmKXP28wsKUFA5TTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298553; c=relaxed/simple;
	bh=Jatn8u4QFUuL+pR08zoVUZZsvNQF78BGvon9Gukephw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erMtP6JqpS/J26fQpnIXkJjadRJxAnylhRatWZPls2Q0LAmtoGCDu7fokLFROFm/6paUUMukopVXWAKzbti0+hPFR6MFFzpmh4fUq+/NGnVy5eKFCABbhgih/7xhiErhM+dzPiRPS/0m3SK3NiqcBMcmliZAl4beIe6iVQWbpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfFo78A3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716298552; x=1747834552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jatn8u4QFUuL+pR08zoVUZZsvNQF78BGvon9Gukephw=;
  b=mfFo78A3pJc7R0fus06fompILajLRMU7cfU2h7+435yv1ZRMUIsIcfkT
   n+8+NNmvKpoqQIzJ1YhDMvbC2HrEzyqRWPzuKFo0lYJ8iJ/DsXZSIukaL
   jCCNHvywlMzeG1s3WB2W9vBEcPgHNVClW3xI1k1xosbC4GbMcWRYWwgWZ
   h9qyL5y9Z9+XH+O6dM062+AiC6+8Sknrz5Wc7lpEhGStKskuQ5p1w36D4
   ERpDXTz4ymdkVcp4M+I3TqmSyaUM21U/jwTP3IXdMDmxK6Ef4cZzSNHhV
   lle2SCgG9YjH2v0e5R4Rew1M3dt4dzc2xMBKUYuxYyb6th2ocraAmy7er
   w==;
X-CSE-ConnectionGUID: +i49ERRsTheevRXL4W7JaQ==
X-CSE-MsgGUID: D2gWwjYSRhKBvY9IIzMelA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16330966"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="16330966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:35:51 -0700
X-CSE-ConnectionGUID: kPBC/OVTTnG2naU3R85JMA==
X-CSE-MsgGUID: 71kxtUr8T8mlgwjFVvkliA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="33526496"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.221.140]) ([10.124.221.140])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:35:50 -0700
Message-ID: <38dec9ee-1dde-4b3b-87c7-a65161d4a015@linux.intel.com>
Date: Tue, 21 May 2024 06:35:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
References: <20240521073505.2190633-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240521073505.2190633-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/21/24 12:35 AM, Kirill A. Shutemov wrote:
> Currently attempt to do MMIO from userspace in TDX guest leads to
> warning about unexpect #VE and SIGSEGV being delivered to the process.
>
> Enlightened userspace might choose to deal with MMIO on their own if
> kernel doesn't emulate it.

Any specific use cases ? Like who is using it?

> Handle EPT_VIOLATION exit reason for userspace and deliver SIGBUS
> instead of SIGSEV. SIGBUS is more appropriate for MMIO situation.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Code looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index c1cb90369915..d2aa93cebf5a 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/sched/signal.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -630,6 +631,11 @@ void tdx_get_ve_info(struct ve_info *ve)
>  	ve->instr_info  = upper_32_bits(args.r10);
>  }
>  
> +static inline bool is_private_gpa(u64 gpa)
> +{
> +	return gpa == cc_mkenc(gpa);
> +}
> +
>  /*
>   * Handle the user initiated #VE.
>   *
> @@ -641,17 +647,20 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  	switch (ve->exit_reason) {
>  	case EXIT_REASON_CPUID:
>  		return handle_cpuid(regs, ve);
> +	case EXIT_REASON_EPT_VIOLATION:
> +		if (is_private_gpa(ve->gpa))
> +			panic("Unexpected EPT-violation on private memory.");
> +
> +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)ve->gla);
> +
> +		/* Return 0 to avoid incrementing RIP */
> +		return 0;
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EIO;
>  	}
>  }
>  
> -static inline bool is_private_gpa(u64 gpa)
> -{
> -	return gpa == cc_mkenc(gpa);
> -}
> -
>  /*
>   * Handle the kernel #VE.
>   *

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


