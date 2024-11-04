Return-Path: <linux-kernel+bounces-395501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827069BBECE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F5281787
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497D1F583C;
	Mon,  4 Nov 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhZk4v2D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4521CDFD1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752300; cv=none; b=cBTGHMTZqFhzuVUcSQHu7M/yeXDxinPNdx0RNYkQIPWiby5FTHYk6u/cgMNmzOAgonFRN7XcuvoupfiVaB9uZrXFnanjiEcEsLG6jaWYYCTYmhjoSBdhuGoodenO4PHC8ssIf30u/TEqQY6naDvM9Bprd6BnddxZbScx822mM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752300; c=relaxed/simple;
	bh=RnQZzhU/kf1SpeQbI1mQ2Bl8UF4x/HqjYuZgJcjbEK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CivaR4frjNLTdiACR2Y4XCUrT/1wWWL4oZENKwG6w/hrsZXbiSoxTNhgXfxKyhgkTju5XFoz0JrQibtbaVyk/50+cN96xfQ3RfPcGpYZqXRdLHm3zk0ZR2ib7BSsrHR7tzUmuVZXCymwvkGHjJcVvjAsobIgug16vRNc+7FzsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhZk4v2D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730752298; x=1762288298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RnQZzhU/kf1SpeQbI1mQ2Bl8UF4x/HqjYuZgJcjbEK0=;
  b=mhZk4v2DYIhm1oikMHZIxARvRNWo5HZX0QjaAFyyg9Yb/dCD0oMFBqE/
   1+xMtDcJJurcy+/J1+HkIdbgpA1THBpL+z47f8MDJrbQ6gQmLgdaf7olm
   zwkSpqfiVZELSn4cBqdYeK5e7jblamjU+qwVa2G61Io93/1dTiCRjULia
   V59jtF+09BxIsPhwBcfvGRWgtLIzxqqAJq+W0xYyEvXhD9gLgBatyVgcD
   udOI/Aa/SW/CnOBaUCzn74tXKRevB88YoMkgD2TTrhfoJfmbLRncvAyKE
   jar2jGjhV8CNHtaqIIRH1N44t/fPgyJNACUP2/hVXN+7TUP0s/7DaLfnv
   A==;
X-CSE-ConnectionGUID: UzG8BY5uRBm7LpgN4O00bA==
X-CSE-MsgGUID: bg8ixbeSS76Bs22pA06YdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="18090445"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="18090445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:31:37 -0800
X-CSE-ConnectionGUID: oBBCSDAOTtaEMKZxo9jqRw==
X-CSE-MsgGUID: uJYE3pzCQUSM83q4nPVDYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83882590"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:31:37 -0800
Received: from [10.212.67.175] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A56F920B5703;
	Mon,  4 Nov 2024 12:31:36 -0800 (PST)
Message-ID: <346dffd1-c71e-47b8-9ee4-1bb9c9937cdc@linux.intel.com>
Date: Mon, 4 Nov 2024 15:31:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/msr: Make SMI and PPERF on by default
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: srinivas.pandruvada@intel.com, ak@linux.intel.com
References: <20240910192626.768146-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240910192626.768146-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Ping. Could you please let me know if you have any comments.

Thanks,
Kan

On 2024-09-10 3:26 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The MSRs, SMI_COUNT and PPERF, are model-specific MSRs. A very long
> CPU ID list is maintained to indicate the supported platforms. With more
> and more platforms being introduced, new CPU IDs have to be kept adding.
> Also, the old kernel has to be updated to apply the new CPU ID.
> 
> The MSRs have been introduced for a long time. There is no plan to
> change them in the near future. Furthermore, the current code utilizes
> rdmsr_safe() to check the availability of MSRs before using it.
> 
> Make them on by default. It should be good enough to only rely on the
> rdmsr_safe() to check their availability for both existing and future
> platforms.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/msr.c | 80 ++-----------------------------------------
>  1 file changed, 3 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> index 45b1866ff051..7659d145d01b 100644
> --- a/arch/x86/events/msr.c
> +++ b/arch/x86/events/msr.c
> @@ -39,85 +39,11 @@ static bool test_therm_status(int idx, void *data)
>  
>  static bool test_intel(int idx, void *data)
>  {
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
> -	    boot_cpu_data.x86 != 6)
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>  		return false;
>  
> -	switch (boot_cpu_data.x86_vfm) {
> -	case INTEL_NEHALEM:
> -	case INTEL_NEHALEM_G:
> -	case INTEL_NEHALEM_EP:
> -	case INTEL_NEHALEM_EX:
> -
> -	case INTEL_WESTMERE:
> -	case INTEL_WESTMERE_EP:
> -	case INTEL_WESTMERE_EX:
> -
> -	case INTEL_SANDYBRIDGE:
> -	case INTEL_SANDYBRIDGE_X:
> -
> -	case INTEL_IVYBRIDGE:
> -	case INTEL_IVYBRIDGE_X:
> -
> -	case INTEL_HASWELL:
> -	case INTEL_HASWELL_X:
> -	case INTEL_HASWELL_L:
> -	case INTEL_HASWELL_G:
> -
> -	case INTEL_BROADWELL:
> -	case INTEL_BROADWELL_D:
> -	case INTEL_BROADWELL_G:
> -	case INTEL_BROADWELL_X:
> -	case INTEL_SAPPHIRERAPIDS_X:
> -	case INTEL_EMERALDRAPIDS_X:
> -	case INTEL_GRANITERAPIDS_X:
> -	case INTEL_GRANITERAPIDS_D:
> -
> -	case INTEL_ATOM_SILVERMONT:
> -	case INTEL_ATOM_SILVERMONT_D:
> -	case INTEL_ATOM_AIRMONT:
> -
> -	case INTEL_ATOM_GOLDMONT:
> -	case INTEL_ATOM_GOLDMONT_D:
> -	case INTEL_ATOM_GOLDMONT_PLUS:
> -	case INTEL_ATOM_TREMONT_D:
> -	case INTEL_ATOM_TREMONT:
> -	case INTEL_ATOM_TREMONT_L:
> -
> -	case INTEL_XEON_PHI_KNL:
> -	case INTEL_XEON_PHI_KNM:
> -		if (idx == PERF_MSR_SMI)
> -			return true;
> -		break;
> -
> -	case INTEL_SKYLAKE_L:
> -	case INTEL_SKYLAKE:
> -	case INTEL_SKYLAKE_X:
> -	case INTEL_KABYLAKE_L:
> -	case INTEL_KABYLAKE:
> -	case INTEL_COMETLAKE_L:
> -	case INTEL_COMETLAKE:
> -	case INTEL_ICELAKE_L:
> -	case INTEL_ICELAKE:
> -	case INTEL_ICELAKE_X:
> -	case INTEL_ICELAKE_D:
> -	case INTEL_TIGERLAKE_L:
> -	case INTEL_TIGERLAKE:
> -	case INTEL_ROCKETLAKE:
> -	case INTEL_ALDERLAKE:
> -	case INTEL_ALDERLAKE_L:
> -	case INTEL_ATOM_GRACEMONT:
> -	case INTEL_RAPTORLAKE:
> -	case INTEL_RAPTORLAKE_P:
> -	case INTEL_RAPTORLAKE_S:
> -	case INTEL_METEORLAKE:
> -	case INTEL_METEORLAKE_L:
> -		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
> -			return true;
> -		break;
> -	}
> -
> -	return false;
> +	/* Rely on perf_msr_probe() to check the availability */
> +	return true;
>  }
>  
>  PMU_EVENT_ATTR_STRING(tsc,				attr_tsc,		"event=0x00"	);


