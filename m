Return-Path: <linux-kernel+bounces-435806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587339E7D10
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63C2843AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193F213E79;
	Fri,  6 Dec 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVL59Alq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A1148827
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733529502; cv=none; b=rFZKv++7k5BgjsM50BAAwSkKKzcw1BQDCJvce774wtfpJtBSPiXXveQLOsmzA4XsOTMjjPQ6OVGeqqfTcs4yksyViMkOy9mA4ApFUT5WhL2wZhbZbMpmoTApeHm/WwAWT9xP57ZIk+AYXtdIys85G0rnLeTf1bMqbVXZW7R0O6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733529502; c=relaxed/simple;
	bh=hBsMcd4G6B6veCsB5dJ69YNAOKE4ytxr8prMpeyiPe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBlpSnm61ItNVULqJfAeMJ+1X3wEThoV/gysNcsROxO7jieYuOnsT9s/19hq2lxPyH0J8MvENiOHnT53w4clAC0nWS6UPqIFGhKN2XItxi7xD3FYC2tseeB+F5Qvn0DynTB109ii6vGHYYkjeXY25GQCQ0dxHaf7JnWWHCr+t5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVL59Alq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733529500; x=1765065500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBsMcd4G6B6veCsB5dJ69YNAOKE4ytxr8prMpeyiPe8=;
  b=fVL59AlqI6gpL2T9WahDVx9VrBii5Wrb0mX70PwgKRtY+by38MXuenYa
   7DmY0NiEOTxAsWXGFM8jk5uyvU0TfQgnOIHS7vNVh05MLj0N+ZpvjqQsE
   IoPaoorJzoXYxjkFprjq8W32lnCwuMaGzJSgq4mK1s6CzMxX4Wi54OT2G
   Om3qB2ndztWxTBI7TovaK7anr/4bITWKQqasHdJewBi0PFB5OflmL2mjw
   lrowbN/Mu6ZNm5HUtSU6QoDDbH2yHknTpayrKBXZmHSQh9Lmv8C6XUPwM
   fzwTcKLc0fP4o0iqgSU9job2bwRblvAioawvuZ/G/eMSRRzvv6JlBB7s/
   A==;
X-CSE-ConnectionGUID: dkOacrQyQ5OvxtdSeCPSYQ==
X-CSE-MsgGUID: TLAzXLuKQlCSAkA+ThqnsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33951378"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33951378"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 15:58:20 -0800
X-CSE-ConnectionGUID: vgBYl1bbT1m3cA3SFEmYog==
X-CSE-MsgGUID: TSqvZ/ovQyegg/MVM/HQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="131944947"
Received: from dfryer-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 15:58:20 -0800
Date: Fri, 6 Dec 2024 15:58:12 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, kan.liang@linux.intel.com, mingo@kernel.org,
	peterz@infradead.org, tony.luck@intel.com
Subject: Re: [PATCH 3/5] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with
 'x86_cpu_id'
Message-ID: <20241206235812.g56p6p353fgbxm5h@desk>
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
 <20241206193834.3ABE2E95@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206193834.3ABE2E95@davehans-spike.ostc.intel.com>

On Fri, Dec 06, 2024 at 11:38:34AM -0800, Dave Hansen wrote:
> diff -puN arch/x86/events/intel/core.c~zap-x86_cpu_desc arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c~zap-x86_cpu_desc	2024-12-06 11:33:16.775171950 -0800
> +++ b/arch/x86/events/intel/core.c	2024-12-06 11:33:16.779172107 -0800
> @@ -5371,42 +5371,33 @@ static __init void intel_clovertown_quir
>  	x86_pmu.pebs_constraints = NULL;
>  }
>  
> -static const struct x86_cpu_desc isolation_ucodes[] = {
> -	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
> -	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
> -	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
> -	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
> -	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
> -	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
> -	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
> -	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
> -	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
> +static const struct x86_cpu_id isolation_ucodes[] = {
> +	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL,		 3,  3, 0x0000001f),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_L,	 1,  1, 0x0000001e),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_G,	 1,  1, 0x00000015),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X,	 2,  2, 0x00000037),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X,	 4,  4, 0x0000000a),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL,	 4,  4, 0x00000023),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_G,	 1,  1, 0x00000014),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 2,  2, 0x00000010),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 3,  3, 0x07000009),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 4,  4, 0x0f000009),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 5,  5, 0x0e000002),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_X,	 1,  1, 0x0b000014),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	 3,  3, 0x00000021),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	 4,  7, 0x00000000),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	11, 11, 0x00000000),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_L,	 3,  3, 0x0000007c),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE,		 3,  3, 0x0000007c),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE,		 9,  9, 0x0000004e),

This ...

> +	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE_L,	 9, 12, 0x0000004e),
> +	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE,		10, 13, 0x0000004e),

... and this can also be combined into a single entry.

