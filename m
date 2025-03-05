Return-Path: <linux-kernel+bounces-546589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E039A4FC7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F03817059A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C720E32F;
	Wed,  5 Mar 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekHgbt7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDE20CCC2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171480; cv=none; b=LZ0IHWewQ+FGuHOxw4HsTLHwoTm0ZMo2rmYdJHwTySKqzhJXMk3+WRATDTPdPOae0tql8yajxDxbm5NxpO+kZi0ewLr7arT3HTjgHN7hNO5kLnB91STuLhxBlcpdqnBDh7OsGJNiMoVJEEgOJz1FI0HTPIAkr6fxCmLmd4hNIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171480; c=relaxed/simple;
	bh=npi3WSqljcR+mGqxg1OuLdeU51YsUoRMSP7hkd+cUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEGIy2rQJQGW0BReBuzh8C9zWztQzmjsyqP+jusULpo+4riwELF0Q35y8yekQq+C05divilpsOwEQCxmyeKOy34LgiTtoUqIHIgaIxiM1Wl79wAqMn3oGAfZ5qAGKTJC0hYCFJC37ASuQVyHedyp8YkT3Hixkhn0SHv5LuN35as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekHgbt7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B07C4CEE8;
	Wed,  5 Mar 2025 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741171480;
	bh=npi3WSqljcR+mGqxg1OuLdeU51YsUoRMSP7hkd+cUKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekHgbt7xB7qUQ0HGovY5cQi1lK8k8GHd5cz/nY8XNNWRgS73kNOQg2AlcthZijp8q
	 eq6dUYPIkrFlG4OuPNR60/W7XGL76PYfmiFbIjGsBM15bDiF0M51qmOH/y2E+aVWX7
	 8C5gcBFr00rjWFu6MDqRS8ldeL3UiQ+58SwYF2uRG1zx9HehHOPZL/ZZcXTvvdW0+B
	 5WuZmXb1CKJB4/QZZuOnTK0llHyM1ct6WgApN0hoNzv7Wqe5X1MAGexjYW12CEk43n
	 kxwNBnRrGvuMaobgNn6Jnw6t2pgNdCrF4g9GUD+NbiSzPr1f9D8PrWhdRsQkqLzZLB
	 h+J5e0+dw1vtw==
Date: Wed, 5 Mar 2025 11:44:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Message-ID: <Z8grEnsAcMrm9sCc@gmail.com>
References: <20250304143340.928503-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304143340.928503-1-arnd@kernel.org>


* Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When extra warnings are enabled, the cc_mask definition in asm/coco.h
> causes a build failure with gcc:
> 
> arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
>    28 | static const u64 cc_mask = 0;
> 
> Mark this one as __maybe_unused.
> 
> Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/coco.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index aa6c8f8ca958..9e9204cfca6f 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -25,7 +25,7 @@ u64 cc_mkdec(u64 val);
>  void cc_random_init(void);
>  #else
>  #define cc_vendor (CC_VENDOR_NONE)
> -static const u64 cc_mask = 0;
> +static const __maybe_unused u64 cc_mask = 0;

So I detest __maybe_unused with a vengeance: the 'maybe' unnecessarily 
inserts uncertainty & probability language into the text, while there's 
nothing uncertain about this interface or the code. Why cannot the 
compiler figure it out?

Anyway, I'd suggest we change direct usage of cc_mask to a 
get_cc_mask() inline function instead, this will resolve the warning, 
plus it avoids some messy looking variable shadowing in tdx.c AFAICS:

  arch/x86/coco/tdx/tdx.c:static void tdx_setup(u64 *cc_mask)

Thanks,

	Ingo

