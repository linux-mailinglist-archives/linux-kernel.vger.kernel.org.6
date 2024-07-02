Return-Path: <linux-kernel+bounces-238095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB88992436A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B27B215C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0C1BD02F;
	Tue,  2 Jul 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEOQc61e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DA148825
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937057; cv=none; b=CkJMrtuq++3bX4F881SbB7SyMJdfch/RrpTovflwhSgUi/fdhGgrGwgv8ll59Vca2VKSQI0rIsStpAsj/vSHU5cMkxvP9JN0ymK+eedwJyuCEUZbpp35E0112LgYypOtMHOnyItFkuXhS/eH+PJHJdPdSlz67EJ8wyrj0gj2jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937057; c=relaxed/simple;
	bh=tvzSqwVzqT2MeN+0OQxjWbM8B/fx4OAm7mNBB19+s0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/2HiYS4eH35ihZEkHYKJiCG1MxW3LtJj5SVSbQFUrvb1U5qZNaYFpDWQ5SJpLBjqLaaAha7w1v4oTUgA3scFVEeXVWxSaYnUKonfm8VW5GZRQtJ07RHLKkyXfOSjOr9XcbzM57UK0M3bq6BVK7LhXBYfGtmt5NxHCaNbqvGWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEOQc61e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719937055; x=1751473055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tvzSqwVzqT2MeN+0OQxjWbM8B/fx4OAm7mNBB19+s0E=;
  b=nEOQc61e5DBE+5hqA2Wm3VQ8DcVJ/zdpssPvvuOMcJTuR9O6qR+PgCBm
   mDlAHIT1PoUl6k1cuDaJmfYQEmio5s7tctIWdoD/Q25G/4O13s6kjbLgF
   5BL4wwSlf9jP7WhC1zZUM3CqOPd1JVYItXcAgDEHU+1syBiutjwAj1xtE
   VC+fD8rQ1ypv6sVnAyJGbu+v4pwHcaFe55maQU8OnyuiUpWOn9rFOD6U/
   4NjgTdnLHlpRtu62Ot4QhJmenz+CDo5DamQrBAUs2u1yW+ZPcBq1TVMpK
   XLyzKBgXEYZErzwkqjaVzUInPNXE21oZPCwgDIDA8Sf49RysNgTHwaOxS
   Q==;
X-CSE-ConnectionGUID: 4gTu9g3NSU2nCvF2xIhupQ==
X-CSE-MsgGUID: mAtU9hStR7S7xtZS+pEvUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27802807"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27802807"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 09:17:15 -0700
X-CSE-ConnectionGUID: q4CqYxW3SWS2V+uD9YkGxA==
X-CSE-MsgGUID: TGILGBwYQPqrWVg3SvI8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45731126"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26]) ([10.124.240.26])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 09:17:07 -0700
Message-ID: <3b28af5e-1274-411e-9536-9ad964e0b25f@intel.com>
Date: Wed, 3 Jul 2024 00:17:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 4/4] x86/tdx: Enable CPU topology enumeration
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-5-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240624114149.377492-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/2024 7:41 PM, Kirill A. Shutemov wrote:
> TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
> generates a #VE when accessing topology-related CPUID leafs (0xB and
> 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
> topology. In practice, this means that the kernel can only boot with a
> plain topology. Any complications will cause problems.
> 
> The ENUM_TOPOLOGY feature allows the VMM to provide topology
> information to the guest. Enabling the feature eliminates
> topology-related #VEs: the TDX module virtualizes accesses to
> the CPUID leafs and the MSR.
> 
> Enable ENUM_TOPOLOGY if it is available.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/coco/tdx/tdx.c           | 27 +++++++++++++++++++++++++++
>   arch/x86/include/asm/shared/tdx.h |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index ba3103877b21..f6e48119d6fd 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -249,6 +249,32 @@ static void disable_sept_ve(u64 td_attr)
>   	return;
>   }
>   
> +/*
> + * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs (0xB and
> + * 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID #VEs.
> + * In practice, this means that the kernel can only boot with a plain topology.
> + * Any complications will cause problems.
> + *
> + * The ENUM_TOPOLOGY feature allows the VMM to provide topology information.
> + * Enabling the feature  eliminates topology-related #VEs: the TDX module
> + * virtualizes accesses to the CPUID leafs and the MSR.
> + *
> + * Enable ENUM_TOPOLOGY if it is available.
> + */
> +static void enable_cpu_topology_enumeration(void)
> +{
> +	u64 configured;
> +
> +	/* Has the VMM provided a valid topology configuration? */
> +	tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED, &configured);
> +	if (!configured) {
> +		pr_err("VMM did not configure X2APIC_IDs properly\n");
> +		return;
> +	}
> +
> +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
> +}
> +
>   static void tdx_setup(u64 *cc_mask)
>   {
>   	struct tdx_module_args args = {};
> @@ -280,6 +306,7 @@ static void tdx_setup(u64 *cc_mask)
>   	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>   
>   	disable_sept_ve(td_attr);
> +	enable_cpu_topology_enumeration();
>   }
>   
>   /*
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index fecb2a6e864b..89f7fcade8ae 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -23,12 +23,14 @@
>   #define TDCS_CONFIG_FLAGS		0x1110000300000016
>   #define TDCS_TD_CTLS			0x1110000300000017
>   #define TDCS_NOTIFY_ENABLES		0x9100000000000010

The ID for TDCS_NOTIFY_ENABLES I read from TDX spec is

	0x9110000300000010
	
> +#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019

and
	0x9110000000000019

for TOPOLOGY_ENUM_CONFIGURED.

Both version of them can work actually. But I'm curious where did you 
get them? just an old version of spec?
	
>   /* TDCS_CONFIG_FLAGS bits */
>   #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
>   
>   /* TDCS_TD_CTLS bits */
>   #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> +#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
>   
>   /* TDX hypercall Leaf IDs */
>   #define TDVMCALL_MAP_GPA		0x10001


