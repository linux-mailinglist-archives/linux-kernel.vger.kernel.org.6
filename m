Return-Path: <linux-kernel+bounces-193935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F028D343B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE6C1C21282
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44EB17BB1B;
	Wed, 29 May 2024 10:13:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC317B433
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977598; cv=none; b=BMIL+7ubYSag+KeZ7CPfE3OMA0yHwxWQWq6BI3jxTdIgCGP/wscmhbe7keTUR/LpjrbCJRdkVqDq2Ncl5xtXFKzyi7FFO55hJTpkjkCQIW+me8ldrDr9V3uHuHXNjGvDsG9xS0YVYcO2n82eAYoV2gWw8SksLKcFyj7T2hlrjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977598; c=relaxed/simple;
	bh=Ngxa2GWKs4Uq84NqmR/MCdsQquOm3zh0BhDz/lmyJvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS/XJP8qkpnyObQ5xgBEpQla8+mToB/mlk8rJ0xPhQ8t8Q/H00K9OXGPCCApgu9YpVV5VKOSeXCJkh5+25kLBGOm5uQ2qJBZzfLQGDaK7VGBLaKCLawI18OvvzitI5lt47A7/LmoLMa5KdwrRS6PTvaFtGQo08H6w5Rn/A5NoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC71339;
	Wed, 29 May 2024 03:13:39 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32FD23F792;
	Wed, 29 May 2024 03:13:14 -0700 (PDT)
Date: Wed, 29 May 2024 11:13:11 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
Message-ID: <Zlb_txl4CqCfxWZz@pluto>
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>

On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wrote:
> The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
> dependency on ARM64, to prevent asking the user about this driver when
> configuring a kernel for a different architecture than ARM64.
> 

Hi,

the ARM64 dependency was dropped on purpose after a few iterations of
this series since, despite this being an ARM IP, it has really no technical
dependency on ARM arch, not even the usual one on ARM AMBA bus, being this a
platform driver, so it seemed an uneeded artificial restriction to impose...
..having said that, surely my live testing were performed only on arm64 models
as of now.

So, I am not saying that I am against this proposed fix but what is the
issue that is trying to solve, have you seen any compilation error ? or
is it just to avoid the user-prompting ?

Thanks,
Cristian

> Fixes: ca1a8680b134b5e6 ("mailbox: arm_mhuv3: Add driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The MHUv3 documentation is unclear about whether this can be present
> only on ARM64, or also on ARM.
> Googling 'site:arm.com MHUv3 "aarch32"' shows no results.
> Googling 'site:arm.com MHUv3 "aarch64"' does show results.
> ---
>  drivers/mailbox/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 3b8842c4a3401579..8d4d1cbb1d4ca625 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -25,6 +25,7 @@ config ARM_MHU_V2
>  
>  config ARM_MHU_V3
>  	tristate "ARM MHUv3 Mailbox"
> +	depends on ARM64 || COMPILE_TEST
>  	depends on HAS_IOMEM || COMPILE_TEST
>  	depends on OF
>  	help
> -- 
> 2.34.1
> 

