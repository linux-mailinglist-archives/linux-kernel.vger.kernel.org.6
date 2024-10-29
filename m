Return-Path: <linux-kernel+bounces-387130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B49B4C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BDC2826F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84A2071E5;
	Tue, 29 Oct 2024 14:42:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B20206E72
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212964; cv=none; b=Nyizwzgo+vLHkh8zfg/kwPzwEXMHfsihOgF2didfLG7a5MEFEVmS7Dy/rxJETELAkH1M9rX3MZtKFoYT40aoUF6cO6wK1qJASzj5Xwwr103hV9o+sekxsLlPcVSEXwZ8m2HbQGiwS90ySYMXCcBFLsNXTuE2m0lULEUBoc1RjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212964; c=relaxed/simple;
	bh=atKKY6/s7GlF08cjTCitLRrfM1w4+lG6hCY8u+1CXPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XteRxWYYDYrSqi6a7viZBDnos2GyTv/PsYjT8UIqVWDppebH7UbCbb7Qpbm3EOUSdsXE+2pmr/Dvrzs++F4KMTNA5modAQN0Z1N/IiVwtwoy40INVUPWF/+k89hYFfXRsXF8bSwcCexHKx7ezQxclFPmuUQLMskESFT1PnzyWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EDE13D5;
	Tue, 29 Oct 2024 07:43:11 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 998843F528;
	Tue, 29 Oct 2024 07:42:34 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:42:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, linux@armlinux.org.uk, will@kernel.org,
	catalin.marinas@arm.com, sstabellini@kernel.org, maz@kernel.org,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, akpm@linux-foundation.org,
	samitolvanen@google.com, arnd@arndb.de, ojeda@kernel.org,
	rppt@kernel.org, hca@linux.ibm.com, aliceryhl@google.com,
	samuel.holland@sifive.com, paulmck@kernel.org, aquini@redhat.com,
	petr.pavlu@suse.com, viro@zeniv.linux.org.uk,
	rmk+kernel@armlinux.org.uk, ardb@kernel.org,
	wangkefeng.wang@huawei.com, surenb@google.com,
	linus.walleij@linaro.org, yangyj.ee@gmail.com, broonie@kernel.org,
	mbenes@suse.cz, puranjay@kernel.org, pcc@google.com,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	Jonathan.Cameron@huawei.com, prarit@redhat.com, liuwei09@cestc.cn,
	dwmw@amazon.co.uk, oliver.upton@linux.dev,
	kristina.martsenko@arm.com, ptosi@google.com, frederic@kernel.org,
	vschneid@redhat.com, thiago.bauermann@linaro.org,
	joey.gouly@arm.com, liuyuntao12@huawei.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v4 03/19] arm64: entry: Remove
 __enter_from_user_mode()
Message-ID: <ZyD0WJeAhESLIBJp@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-4-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:44PM +0800, Jinjie Ruan wrote:
> The __enter_from_user_mode() is only called by enter_from_user_mode(),
> so replaced it with enter_from_user_mode().

As with the next two patches, all the __enter_from_*() and __exit_to_*()
are supposed to handle the raw entry, closely matching the generic code,
and the non-underscored enter_from_*() and exit_to_*() functions are
supposed to be wrappers that handle (possibly instrumentable)
arm64-specific post-entry and pre-exit logic.

I would prefer to keep that split, even though enter_from_user_mode() is
a trivial wrapper.

Am I missing some reason we must remove the wrappers?

Mark.

> 
> No functional changes.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/entry-common.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 68a9aecacdb9..ccf59b44464d 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -109,7 +109,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>   * Before this function is called it is not safe to call regular kernel code,
>   * instrumentable code, or any code which may trigger an exception.
>   */
> -static __always_inline void __enter_from_user_mode(void)
> +static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>  {
>  	lockdep_hardirqs_off(CALLER_ADDR0);
>  	CT_WARN_ON(ct_state() != CT_STATE_USER);
> @@ -118,11 +118,6 @@ static __always_inline void __enter_from_user_mode(void)
>  	mte_disable_tco_entry(current);
>  }
>  
> -static __always_inline void enter_from_user_mode(struct pt_regs *regs)
> -{
> -	__enter_from_user_mode();
> -}
> -
>  /*
>   * Handle IRQ/context state management when exiting to user mode.
>   * After this function returns it is not safe to call regular kernel code,
> -- 
> 2.34.1
> 

