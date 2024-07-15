Return-Path: <linux-kernel+bounces-252417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE49312CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EF61F22278
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC63188CD9;
	Mon, 15 Jul 2024 11:06:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E14A185623
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041618; cv=none; b=dVAiAyFmy++4wRFplZsP1LYxJ1TKCX7eh7VGSgfF72pFaaPSwhcRRvr/cENoqAoNA3AP1JZf2ZICtxvX9Yby53jppsFfFnd822wEtBVkK1ZEgApYAY0MWsH5Nikd5aQCu2lU+8KRuy71XJbrE/FoJrIvsklBwc3p2Gvhd7Mv1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041618; c=relaxed/simple;
	bh=9U3wtHuANCNGFZX1DjpKeN9xrR/JfiUE4Wt3jyP5Sxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Nn7+USwM2Q5FdKfCXOY5e6AijzqQiQIyD3EMihN/OSZYO5hBKmS8609rKdKxLQG/bnFnGv9EyH+NsffnLOc/Dy3z+Lsy+CYJYbl69OTIy210YtzqH5adIeIJFSNIqm8SDNjsIhF2PGqhhPUol6b88EeNrhjuaddytrxGcuIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F35AADA7;
	Mon, 15 Jul 2024 04:07:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B41A3F766;
	Mon, 15 Jul 2024 04:06:54 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:06:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Abdurachmanov <david.abdurachmanov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ross Burton <ross.burton@arm.com>
Subject: Re: [PATCH v2] clocksource: sp804: Make user selectable
Message-ID: <ZpUCzFm8Jy9TKUnk@J2N7QTR9R3>
References: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>

On Wed, May 29, 2024 at 08:48:14PM +0100, Mark Brown wrote:
> The sp804 is currently only user selectable if COMPILE_TEST, this was
> done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
> COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
> spuriously offered on platforms that won't have the hardware since it's
> generally only seen on Arm based platforms.  This config is overly
> restrictive, while platforms that rely on the SP804 do select it in
> their Kconfig there are others such as the Arm fast models which have a
> SP804 available but currently unused by Linux.  Relax the dependency to
> allow it to be user selectable on arm and arm64 to avoid surprises and
> in case someone comes up with a use for extra timer hardware.
> 
> Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
> Reported-by: Ross Burton <ross.burton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Changes in v2:
> - Rebase onto v6.10-rc1.
> - Link to v1: https://lore.kernel.org/r/20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org
> ---
>  drivers/clocksource/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 34faa0320ece..ca6045f90000 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -390,7 +390,8 @@ config ARM_GT_INITIAL_PRESCALER_VAL
>  	  This affects CPU_FREQ max delta from the initial frequency.
>  
>  config ARM_TIMER_SP804
> -	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
> +	bool "Support for Dual Timer SP804 module"
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
>  	select CLKSRC_MMIO
>  	select TIMER_OF if OF
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240522-arm64-vexpress-sp804-365d6938b07c
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
> 

