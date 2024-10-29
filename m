Return-Path: <linux-kernel+bounces-387123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6D9B4C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5209B23801
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2B206E7A;
	Tue, 29 Oct 2024 14:37:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97464219FF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212676; cv=none; b=mHnVPZnLjI/HM13g4G4gBD0UGj6kZmKnhWISiwzDDq2TPzWQKPLN5/ZgSjLaZnocMjYQkZPv7v3lAlSirK6lRlmAek56//eUdHFN2HwGPLk09k0URFTA3gUSCIFmCLvPrzPm22RmMlLklttZNykdjbO7vNa5MUeO6GPo7hisDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212676; c=relaxed/simple;
	bh=Pw2VJ8hVeT8vtMdyjmK6zuisBghTcsaJOOfhiemGoWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAzhA/A4Im+LlJ9WumsFozMrM9CnZ8/zom2d8TrGOWi+EOLgv58JZqBgOyHkLPIVHd1O1ZyFC/N2XSpTfxorB7B6IviFuxSLUwPy62pGaepvGWWVkzGZCM3E6Lwmx8Z5y3jfB/iq4XD8cQB72nkE7swY5bo3Dzp5OSrLjwbrTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728C315BF;
	Tue, 29 Oct 2024 07:38:23 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F353F528;
	Tue, 29 Oct 2024 07:37:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:37:42 +0000
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
Subject: Re: [PATCH -next v4 04/19] arm64: entry: Remove
 __enter_from_kernel_mode()
Message-ID: <ZyDzNmSgmYkXWcdD@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-5-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-5-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:45PM +0800, Jinjie Ruan wrote:
> The __enter_from_kernel_mode() is only called by enter_from_kernel_mode(),
> remove it.

The point of this split is to cleanly separate the raw entry logic (in
__enter_from_kernel_mode() from pieces that run later and can safely be
instrumented (later in enter_from_kernel_mode()).

I had expected that a later patch would replace
__enter_from_kernel_mode() with the generic equivalent, leaving
enter_from_kernel_mode() unchanged. It looks like patch 16 could do that
without this patch being necessary -- am I missing something?

Mark.

> 
> No functional changes.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/entry-common.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index ccf59b44464d..a7fd4d6c7650 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -36,7 +36,7 @@
>   * This is intended to match the logic in irqentry_enter(), handling the kernel
>   * mode transitions only.
>   */
> -static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs *regs)
> +static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
>  {
>  	irqentry_state_t ret = {
>  		.exit_rcu = false,
> @@ -55,13 +55,6 @@ static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs
>  	rcu_irq_enter_check_tick();
>  	trace_hardirqs_off_finish();
>  
> -	return ret;
> -}
> -
> -static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
> -{
> -	irqentry_state_t ret = __enter_from_kernel_mode(regs);
> -
>  	mte_check_tfsr_entry();
>  	mte_disable_tco_entry(current);
>  
> -- 
> 2.34.1
> 

