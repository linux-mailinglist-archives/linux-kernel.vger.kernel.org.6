Return-Path: <linux-kernel+bounces-412404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F119D088B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A331C28180E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92213BAE4;
	Mon, 18 Nov 2024 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmoVERLQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3713B590
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731906270; cv=none; b=SGmj2uPwOSaLKlKYlZ9qmfQH6veNO7FJZHYqijeMtY+I3Fa6kXp13cD5SI4QNc9lzvnkDRJ7eFMnasxRQ09LId0kXViObj8+yxWMe2KHckRNIt+t5v/Dky8Yq4vBT5JPItUyA50LexOI6/sF18tSctmsjMbGc/doxSLAPyx65ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731906270; c=relaxed/simple;
	bh=rGyU2kIHVoo4upGQTVWSv1i5yCoyBSHWAzYvVPMA06Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt2618sQ0J5h6DzKnzbbh61zNt/YHoVJxfCIJqjR9VAxuwQwjR1Li+S3fm7jzDViqpBK2Oivc49+PqJb/VpHOQSbiFw/1IlAt6Hhf0S1D28JKuXBUxNjyAm5CQMZddpN2ynrnJ5wKMrkBuZMN9qVWv/aL0Xmed1XwsYwUi1MsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmoVERLQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731906266; x=1763442266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rGyU2kIHVoo4upGQTVWSv1i5yCoyBSHWAzYvVPMA06Q=;
  b=HmoVERLQCSlZ0WSI1jh4mgeSYMd1LaSKU0aKm2jpwG/i3R2QZjzZ/jjF
   4miIqLEKa/Dw+surrtppa/bEQlSzjMfiiXU0dU7CD32AzKfA4JWydja/6
   ViQunr1h3dlY6O65c5RWOM9RQlhtE60ryRo89oyClG0hZgn9Zhos/ZuRs
   DP5byEMdPndmTUSV+dcJFb23f7WnvFfxiHH49b/bk+WDOtnJ24T7ZBwqg
   KJUUTP3Oj5JgbhOaRp43SDR51Ss+UWZ5xWHgOZT0DosSnATe3MmJvhifH
   qvphlhnatNc/95i451n46MaCdq+m7flEswFMnUXsRGwpRn5IzwJyFX3Yx
   Q==;
X-CSE-ConnectionGUID: RSOm7nRxR0WT2lwW1OZ7nQ==
X-CSE-MsgGUID: r39j2I5fRGyR6T8ZOB4fAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31902714"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="31902714"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 21:04:25 -0800
X-CSE-ConnectionGUID: IX/of1irQz+q9jzgY6Ymgw==
X-CSE-MsgGUID: nxlemkQiQ7eTyKfQzXONpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94159684"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 21:04:23 -0800
Date: Mon, 18 Nov 2024 07:04:20 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v1] x86/cpu: Fix x86_match_cpu() doc
Message-ID: <ZzrK1NSDY0kzJBt6@black.fi.intel.com>
References: <20241030065804.407793-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030065804.407793-1-raag.jadav@intel.com>

On Wed, Oct 30, 2024 at 12:28:04PM +0530, Raag Jadav wrote:
> Reword x86_match_cpu() description to possibly what it meant to be.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---

Bump.

Is this useful?

Raag

>  arch/x86/kernel/cpu/match.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 8e7de733320a..82e5d29a04e2 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -6,7 +6,7 @@
>  #include <linux/slab.h>
>  
>  /**
> - * x86_match_cpu - match current CPU again an array of x86_cpu_ids
> + * x86_match_cpu - match current CPU against an array of x86_cpu_ids
>   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
>   *         {}.
>   *
> -- 
> 2.34.1
> 

