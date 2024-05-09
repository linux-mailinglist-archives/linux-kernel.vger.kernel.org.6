Return-Path: <linux-kernel+bounces-173976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DD8C0896
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308141C217BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67B376E1;
	Thu,  9 May 2024 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDflKSIu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD93D548;
	Thu,  9 May 2024 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215525; cv=none; b=X0vcGd9zkqHhK9zb0LxhUfkF6a6rA42F/rK+iEnJqB08r9T687YOW6REed2wSjzH9xFerZuoTHbHgg49do94zLIB9E/1ljluSObzz/OPrPCAY9I0NWsqZJ5t0FLJlS+umPkpz4SBubgNSy5H52ocPZY2gdt/IuOTNFuJ/lfIMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215525; c=relaxed/simple;
	bh=fU4qJTjvN/HQfhmAI8Gy/NQ76F8oZKqSQcpO7VySfk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhag6k/C5KGnIhEh2g6d22/WHrK5DdmGpOlPaVJ3ftrA85o68cN4gogrcKDdT2+BKQGm+ZyaPjxH+hG6AZmMlYummMSjEQGkV0YLzrHyV5mmQLutcCfwtmHsNK2Ry/5UTMl7Jlv59F6eU8Xm8ZDqhiB4kCN4NztqddVHZfXkBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDflKSIu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715215523; x=1746751523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fU4qJTjvN/HQfhmAI8Gy/NQ76F8oZKqSQcpO7VySfk0=;
  b=nDflKSIuJ4LF2HAeu7YeY7+seMU/w13YRlYxPfHuEviLuuLPCx9b8A8c
   Xn506caPeQHfV/pN3jTY6+YWz/McCrtaohDpYPLHMPts7jiQRhyXh1XXH
   dUpoP/P9khnldeAVpLNWt4G7RrcwDIwHR74RRqZqIvUur65QbhUY7t1En
   yMkxw0b4kQ4HnIVefM1tyZBVi1JTj/dvUEwoV/BkC86mwcKJDzvkhWJG0
   1HjW7dR/2EaqZ2LfpGLlxcdS8v4C/vcDv4ye6NxoZC25W5HIAtUfbOzpb
   S4zu27mbYC3SVC/sO7k3Zn0SGKHEoIWnT88zLXnxTTadNqwq2SFS9/aVk
   g==;
X-CSE-ConnectionGUID: zzTv5b9WQfKpqwFeaGEHlg==
X-CSE-MsgGUID: N4IbIIvTQzK2Nye+8uyBeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22503951"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="22503951"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:45:22 -0700
X-CSE-ConnectionGUID: 9i08LsuQRriO/o05XDxhdg==
X-CSE-MsgGUID: JNRQ31J0Tr2ashe2OesSWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="66495708"
Received: from ibganev-mobl.amr.corp.intel.com (HELO [10.125.110.203]) ([10.125.110.203])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:45:22 -0700
Message-ID: <0c983c29-d146-4ddb-a554-6c9728ff2af4@linux.intel.com>
Date: Wed, 8 May 2024 17:45:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for the
 scan test
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 ashok.raj@intel.com, jithu.joseph@intel.com
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240430212508.105117-3-chang.seok.bae@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240430212508.105117-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/30/24 2:25 PM, Chang S. Bae wrote:
> The scan test does not start when the AMX state remains active and is not
> re-initialized. With the extension of kernel_fpu_begin_mask(), the driver
> code can now initialize the state properly.
>
> Introduce custom FPU handling wrappers to ensure compliant with the
> established FPU API semantics, as kernel_fpu_begin() exclusively sets
> legacy states. This follows the EFI case from commit b0dc553cfc9d
> ("x86/fpu: Make the EFI FPU calling convention explicit").
>
> Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
> minimize the critical section. To prevent unnecessary delays, invoke
> ifs_fpu_begin() before entering the rendezvous loop.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
> Tested-by: Jithu Joseph <jithu.joseph@intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 56b9f3e3cf76..71d8b50854b2 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -325,4 +325,18 @@ int do_core_test(int cpu, struct device *dev);
>  extern struct attribute *plat_ifs_attrs[];
>  extern struct attribute *plat_ifs_array_attrs[];
>  
> +static inline void ifs_fpu_begin(void)
> +{
> +	/*
> +	 * The AMX state must be initialized prior to executing In-Field
> +	 * Scan tests, according to Intel SDM.

Nit: May be helpful to include the section title in SDM.

> +	 */
> +	kernel_fpu_begin_mask(KFPU_AMX);
> +}
> +
> +static inline void ifs_fpu_end(void)
> +{
> +	kernel_fpu_end();
> +}
> +
>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 95b4b71fab53..a35eac7c0b44 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -188,6 +188,9 @@ static int doscan(void *data)
>  	/* Only the first logical CPU on a core reports result */
>  	first = cpumask_first(cpu_smt_mask(cpu));
>  
> +	/* Prepare FPU state before entering the rendezvous loop*/
> +	ifs_fpu_begin();
> +
>  	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
>  
>  	/*
> @@ -199,6 +202,9 @@ static int doscan(void *data)
>  	 * are processed in a single pass) before it retires.
>  	 */
>  	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
> +
> +	ifs_fpu_end();
> +
>  	rdmsrl(MSR_SCAN_STATUS, status.data);
>  
>  	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


