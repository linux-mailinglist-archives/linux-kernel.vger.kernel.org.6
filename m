Return-Path: <linux-kernel+bounces-421844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B269D90D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C2D1649E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936416A33F;
	Tue, 26 Nov 2024 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVxtvhhA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824E13A26F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593196; cv=none; b=lUgElt8XV0+IEPezC7GY7kRixwH2qDgfzCdD5OnjVZp8Ulb3yf5rfuXaeL44TTQy4sYPiwCAiGCuqa+BOv4saJy4zt2ugky/49DVwv6d+eMg3x3I808c+tNJmStW3HDndi0DclSjGUkSt4kh4TwKAxFdSv3ogcNqLHbcVVPrcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593196; c=relaxed/simple;
	bh=YX+92HzQxfeYlPYQFM0WstRDzwu80SSNNFTq5dHLS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6Kar2dc7wX6nbRIZBhBNYhqUfVa0IgOptBg7J1QAvl8tLrf2k7d9Vmx5DNwTNsGnpeCXG7y0z68Y7sj5IDz+o8IGJdTuqKZSNLU1qzAq+RhZ6ONTIv+yKZNM2d7Hai7wJhx61ymHAzvtnGkU4jFGoDsAKRk4c3VWU03n38oeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVxtvhhA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732593194; x=1764129194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YX+92HzQxfeYlPYQFM0WstRDzwu80SSNNFTq5dHLS3g=;
  b=BVxtvhhAkqD6l895oleQ/lkP590mxK9Ar3S6ekbiovO1Jp3LDYbIl+Kc
   IxAvqhdCQuNYTqdkfr7gY6AhjBLnOQfKGb5ujU5sB+Um08xcOT3Gmpuwy
   fsaVVpTBtVjlN3Lr/Wiuptnk4SvinI6v8DzdLN/ipQwympk3K3LQ9BDM/
   BxsrH9eYZ3SQWMQ71FPU19qhJVadCQk2e0w3SQrDTqWyqCnQpHLp8cpPl
   4CFSktzcPKH906XkXbTbWCVAGEFbTCABbWQPrBsPwgPqfXgUvKu0XJslk
   F3yLSvdcOw0i5F7lKKQh3M144cLMlgnYdnTaVbDqdBb0UWXjtLIOa7BaP
   g==;
X-CSE-ConnectionGUID: eOgr3FqfTlGUstVYN4PX3g==
X-CSE-MsgGUID: 7EwnPO4DROOV1Y0Li7xp4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43799552"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="43799552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 19:53:13 -0800
X-CSE-ConnectionGUID: TUsG2ZKKRLyduH54znYe5A==
X-CSE-MsgGUID: UmwoPz8tTcK06k4i+lDp9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="96401973"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa005.jf.intel.com with ESMTP; 25 Nov 2024 19:53:11 -0800
Date: Tue, 26 Nov 2024 12:11:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org,
	dave.jiang@intel.com, irenic.rajneesh@gmail.com,
	david.e.box@intel.com
Subject: Re: [PATCH 05/11] x86/cpu: Refresh DCA leaf reading code
Message-ID: <Z0VKZ+AxQdcnaEax@intel.com>
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195334.2F676736@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120195334.2F676736@davehans-spike.ostc.intel.com>

On Wed, Nov 20, 2024 at 11:53:34AM -0800, Dave Hansen wrote:
> Date: Wed, 20 Nov 2024 11:53:34 -0800
> From: Dave Hansen <dave.hansen@linux.intel.com>
> Subject: [PATCH 05/11] x86/cpu: Refresh DCA leaf reading code
> 
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The DCA leaf number is also hard-coded in the CPUID level dependency
> table. Move its definition to common code and use it.
> 
> While at it, fix up the naming and types in the probe code.  All
> CPUID data is provided in 32-bit registers, not 'unsigned long'.
> Also stop referring to "level_9".  Move away from test_bit()
> because the type is no longer an 'unsigned long'.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/include/asm/cpuid.h |    3 ++-
>  b/arch/x86/kernel/cpu/common.c |    2 +-
>  b/drivers/dma/ioat/dca.c       |    8 +++++---
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff -puN arch/x86/include/asm/cpuid.h~dca-leaf-checks-1 arch/x86/include/asm/cpuid.h
> --- a/arch/x86/include/asm/cpuid.h~dca-leaf-checks-1	2024-11-20 11:44:17.721669887 -0800
> +++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:17.725670041 -0800
> @@ -19,7 +19,8 @@ enum cpuid_regs_idx {
>  	CPUID_EDX,
>  };
>  
> -#define CPUID_MWAIT_LEAF		5
> +#define CPUID_MWAIT_LEAF	0x5

Nit, this change can be merged into patch 1?

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


