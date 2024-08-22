Return-Path: <linux-kernel+bounces-296900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFD95B05D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF51F27B95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC517D374;
	Thu, 22 Aug 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQ6gMGZb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960B17CA0A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315325; cv=none; b=Ll1JeDE5S4NQLHXtvlJX4B6LD/lStooJCqzLCye4pWhKkqL/GJkqaGB1h3hkWCEaZy4a8nEFgNF1y0ux7kGDA1V8zaU5K7bk018qbQrwe+HmK55hxe4kQLDMCUfCXv3UB5/rrA9+GqQPW9J9b6pt/pX8t1jszuwTh/oBClkrpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315325; c=relaxed/simple;
	bh=17uaz+cE2JgBv5H3Dvg0wnIYqRe9KhFU1bSLVIOsUqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+YxdTtlVpSmSDt8qedDSjR9GVV+0zi2r5h4VZRpeWzmYQwwwFYLEpFvRitgeDZCa9hUusB6AXkyU0GyVUfRaVpP7cZYJu2DFhtylsCddmijhYa9vTzsFjt0kVXYoJ3wmNyXcRPnM+2sFD8WSvbaEEqOC7P2OpCF8ebUkSZbFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQ6gMGZb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724315325; x=1755851325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17uaz+cE2JgBv5H3Dvg0wnIYqRe9KhFU1bSLVIOsUqs=;
  b=RQ6gMGZbf2z78OZW7UwfBKxU+INFKl+QMX4PaajCMYjvcRM5KFT5mpCQ
   f18KuOmQTz3yrRxB8d+BiWOmqFd6sWVuEeuBZ9GIT6i6YiL60kkYxQqbX
   4NoGvSXtOorCE/Y8Zuw4iRVJb5ZLVAoRhJqLJ4qQ7mhrdPZVk3CQTkSaW
   KVnR0M/h7wBRtNF71l77LwhygM/5y4H4UMiIZSnHa37KyLJcTzZtt22bW
   kmQLGWDTdBW6DDe5GsM52L8NaOeHBuyVWAJMLFWt14m5sYsrZusNyLpg4
   wX47Yk3ru572E4aXAbmhhxyJRjs9htQERxdvaxVrT3LZjiw45gbA9x35z
   g==;
X-CSE-ConnectionGUID: ET9jt4rWRPeJgnZAGE1yEw==
X-CSE-MsgGUID: J4HRSceeTNaxONAdDxthcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33282172"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33282172"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:28:37 -0700
X-CSE-ConnectionGUID: DKvT1eLtRcWKhD0H/FBu4w==
X-CSE-MsgGUID: tu/arhuVTVScQIqt2ipkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61903695"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 22 Aug 2024 01:28:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C1D0849F; Thu, 22 Aug 2024 11:28:14 +0300 (EEST)
Date: Thu, 22 Aug 2024 11:28:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v4 6/6] x86/tdx: Implement movs for MMIO
Message-ID: <tcngnuglju2mnpfa4o2hw3fpwdkk4ryso5dq2zjfi2wn4yr5yd@2iij74o7ugaf>
References: <cover.1723807851.git.legion@kernel.org>
 <cover.1724248680.git.legion@kernel.org>
 <9320e721e609e55a020d3eb98f48fc856371c561.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9320e721e609e55a020d3eb98f48fc856371c561.1724248680.git.legion@kernel.org>

On Wed, Aug 21, 2024 at 04:24:38PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 

Please capitalize MOVS in the subject.

> Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> consists of dividing it into a series of read and write operations,
> which in turn will be validated separately.

Commit message is pretty sparse. I think we need to elaborate on the
similarities and differences with SEV implementation. Locking context
difference is important.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a75a07f4931f..45136b1b02cc 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -503,6 +503,10 @@ struct thread_struct {
>  	struct thread_shstk	shstk;
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	unsigned long		mmio_emul;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*

Hm. Do we need to track exact target address in the thread struct?
Wouldn't be single bit be enough to allow MMIO to userspace address from a
kernel regs->ip?

There is space for the flag next to iopl_warn.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

