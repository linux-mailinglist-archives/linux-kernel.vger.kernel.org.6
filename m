Return-Path: <linux-kernel+bounces-421826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB69D909D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF91686EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4F38F91;
	Tue, 26 Nov 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaExCHVK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F821BE65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590231; cv=none; b=c9/ccBkA/09NfHUGPYIjrYCrx/GmLotaD+3tg4ESDsMT4Ei01/ACb/qMJbqh7COBPSgb/eDpxOP4XIjNgP73A1rOMBZ+qjC08YV8m91iYY4yfaNlIrITVWWu6WRE8OE0tXKf627OWissieSJC+tLeBjueRXdykkfloCKCQGy068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590231; c=relaxed/simple;
	bh=n9BkLfzwG42gWfSjQFjBekrQh2+TDVjOr7ijh6ur4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfgVteUGte+fjHIzpdMFRQgCDPTIIrW6/bjvKQaacEITJQz9F21JN9jA2/WEcSmgRpcThgXyJgbc4pcdHN50NRwE1ekXSMSH7b2hY4yBDSCWPlBKY+eMzucHHwcHFEmFLBV0Pf1RCPmS5G1dursh0rEog0wo3XM8V/js7Cjs/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaExCHVK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732590230; x=1764126230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n9BkLfzwG42gWfSjQFjBekrQh2+TDVjOr7ijh6ur4bc=;
  b=BaExCHVKtc+6PZ57vJzJ4E0fmS44u+zXJ2172yJLB7jlxkVpcgEzwR5M
   BY2XzQFDi3ejgqGQ89KBVn83qNWf6dSgdeDr81EDxhn8mRIv6RRq76m1j
   UalTM+0TxMoSYfK0ySTAaihYutJNIz1zJfMhoxnm6hZtHVC1SFCO50vhw
   JLurAcdPg1W3GRXbVWdBfofH5Kt0O8+fZ+l+8G5KkuMdgry/pi86ax1xu
   7euF3fhaBmI0zFXQCYm7tIdRQ6tfsYk2FJVw0BEVIRI83A1gE68SnOcut
   GjnT1GRFOpRn5VfhNlx884eXKfOqNoc754JQnpr15LJrh7xxmJI6izp+H
   g==;
X-CSE-ConnectionGUID: Ap2/vllWTCGBh2gEdOJAVw==
X-CSE-MsgGUID: 7m1hsrTiQpK7+v36Hq1P7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43224259"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="43224259"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 19:03:50 -0800
X-CSE-ConnectionGUID: WNjJFlo2QiGTbaQLqvbZ0g==
X-CSE-MsgGUID: 2bL02DWGQkOKdxUAD7OVIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="91270265"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by fmviesa007.fm.intel.com with ESMTP; 25 Nov 2024 19:01:53 -0800
Date: Tue, 26 Nov 2024 11:20:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 01/11] x86/cpu: Move MWAIT leaf definition to common
 header
Message-ID: <Z0U+Yt7eS9DYw37c@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195328.4C71D0A5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195328.4C71D0A5@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:28AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:28 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 01/11] x86/cpu: Move MWAIT leaf definition to common header
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Begin constructing a common place to keep all CPUID leaf definitions.
> Move CPUID_MWAIT_LEAF to the CPUID header and include it where
> needed.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/include/asm/cpuid.h  |    2 ++
>  b/arch/x86/include/asm/mwait.h  |    1 -
>  b/arch/x86/kernel/acpi/cstate.c |    1 +
>  b/arch/x86/kernel/hpet.c        |    1 +
>  b/arch/x86/kernel/process.c     |    1 +
>  b/arch/x86/kernel/smpboot.c     |    1 +
>  b/arch/x86/xen/enlighten_pv.c   |    1 +
>  b/drivers/acpi/acpi_pad.c       |    1 +
>  b/drivers/idle/intel_idle.c     |    1 +
>  9 files changed, 9 insertions(+), 1 deletion(-)

Look straightforward to me, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


