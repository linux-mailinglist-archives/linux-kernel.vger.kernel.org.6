Return-Path: <linux-kernel+bounces-361649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A599AAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6525D1F225B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA81C174A;
	Fri, 11 Oct 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoI+Usxq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3519FA9D;
	Fri, 11 Oct 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670491; cv=none; b=CBT3s54Aqxw597z+Z8LEF3KlPEZ1+AirVcBtCQ6TQUwRh1IRNlL0Mz9jjMx7Ac9fALcN/16EmbBbkagp4Apda77AECWLhW1EKfAvmCn7Y6WuoWlBOpZI6URXGVB65wFN3EnAbGAVgReBcILWCgRDeu3rFGTS0Ud0PFK1aQZep6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670491; c=relaxed/simple;
	bh=O9akyF+l4OekYxQTbFlJlxL5DuWypqgamAjq0XJAt1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4DrzsEPKK+2yK+rZksh/sGtehdxu2glJSGqfGLMoV3WixYjo9Br5khOCfWUWj9A4tEQxkzlwgPXOt/VzDREExKt5Y9q4GsMndv7i143zBZiAp0HVChjiyddIBJs7KKEeKE6R6L6iW4MJvAXK6qFQEGKm/DbZBVr+VBv/APda7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoI+Usxq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728670490; x=1760206490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O9akyF+l4OekYxQTbFlJlxL5DuWypqgamAjq0XJAt1A=;
  b=PoI+UsxqQTRXlLy+NkOPUyu33CkkOLxAolYEBcP4FWkEQ0tmexh+ETal
   SrrtzZW0FyuPISv9TMhm4Zc/Bc5oE71yVL18xc0CLAGfnc0oVxCSMBucO
   C3HaRW6acQmPNbfw/OTzQT0VbQXlcmhfcs5cRccHF7A3nhgxJeMEvt0+6
   s0lisbLrvT5Cwv0nqWmkC/k4yyZ6NF4ZUKL4RIqlaBi2F32n4rJy5UtqP
   Qv78nykEpsLI5q1SzRWUh2+UXPKHoczBPmyNx8gWL9ZCKbLRprgW9aEj0
   BeZcoXJNBiMHFLJRBxVZFFlsM40XVcGntFV+Wz2CG0YJL5plp8LppIySI
   A==;
X-CSE-ConnectionGUID: vf+Vn+7YQH6lxZE6lq3hiw==
X-CSE-MsgGUID: iTGFTQgjTO+aCKyYBOz+IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31778509"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="31778509"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:14:49 -0700
X-CSE-ConnectionGUID: uy/LMMkCSCqnawtJrPKUMQ==
X-CSE-MsgGUID: Sv2oiJwoSPawOCknVhG8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77791769"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:14:48 -0700
Date: Fri, 11 Oct 2024 11:14:47 -0700
From: Tony Luck <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v8 06/25] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Message-ID: <ZwlrFxLTq4n6fnaJ@agluck-desk3.sc.intel.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>

On Wed, Oct 09, 2024 at 12:39:31PM -0500, Babu Moger wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3ae84c3b8e6d..43c9dc473aba 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1195,6 +1195,7 @@
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>  #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff

Nitpick. Most of the MSRs in this file are in numerical order (within
each functional grouping). So this belongs before MSR_IA32_EVT_CFG_BASE

Same in patch 14 which adds MSR_IA32_L3_QOS_ABMC_CFG

-Tony

