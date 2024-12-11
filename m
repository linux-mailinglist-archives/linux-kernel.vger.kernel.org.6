Return-Path: <linux-kernel+bounces-442142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79B9ED88A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39987282398
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502144384;
	Wed, 11 Dec 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC8DBxKa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26951BD9C6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952624; cv=none; b=uxo5hUIDnAMwYJ7q12OpI2/cibNeihtOtrR+s/V81OPSsU+S0qh9JmvjFu7OJcgfc+4qc1ZvR+Qg0Ksj2MxImP5fmz4xtdYRPTkHnlYAE5KemOMwWmgrybglZ2dbfybWj4bm0YP8JxrJlmwLz9f8FcKIfz9vZRXDicSr0d7JAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952624; c=relaxed/simple;
	bh=QN8NBE9T0l0nCy54fFLmu4grxTxcGTtywbY3oxKo6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LknW41wpixzQMnOAtfy3JwncIUBOIXyVK+7xT6cxpfZaIJ3Mn46m209QVveou5WjJLDIClobrxAGKWOQJQeAbZXZmYPsnMc/D2SGTbGzI84cCswbNADAKRtRTJYMA/CsbMxRYYJaCZukV42Mg3p34gho00bGeKcFy6cK2tlJ8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC8DBxKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908B7C4CED2;
	Wed, 11 Dec 2024 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733952624;
	bh=QN8NBE9T0l0nCy54fFLmu4grxTxcGTtywbY3oxKo6UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC8DBxKalTNKHRhRVXaSE/yFsEjc+YW4RbWfxHE0BR1b9eP3a2njMOJn5fYcbSCoe
	 ooW91OXTRT6KncknkwC6hoWj9dBA+sItCvq7jg7hNwWYoXald+Q+4pJ/yxiEsETqfn
	 uapoIAnfpIYPrOojg1dYGuGRYV4z7YCJW/gbAtP1I8MkYK+/Y1WnkZy+HKo5wajWdT
	 AaDJwo637rLffLECJHItB/Tr7TtXAYQLG7Cp7iuXgFoRjUAhEzUlsqiT/781+T6W8j
	 pl8xlTcd+RObcJK3UubhkyJJbyGe5cUDn163l8ri/uauY7aJ+2WqQYI7GQ5KTWSkRj
	 eCHBDqBQqULgg==
Date: Wed, 11 Dec 2024 21:30:19 +0000
From: Will Deacon <will@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	gshan@redhat.com, steven.price@arm.com, sami.mujawar@arm.com,
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
Message-ID: <20241211213018.GA17486@willie-the-truck>
References: <20241207012128.247522-1-jeremy.linton@arm.com>
 <20241207012128.247522-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207012128.247522-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Dec 06, 2024 at 07:21:28PM -0600, Jeremy Linton wrote:
> The TSM module provides guest identification and attestation when a
> guest runs in CCA mode. By creating a dummy platform device, let's
> ensure the module is automatically loaded. The udev daemon loads the
> TSM module after it receives a device addition event. Once that
> happens, it can be used earlier in the boot process to decrypt the
> rootfs.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/rsi.h                    |  2 ++
>  arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>  drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
> index 188cbb9b23f5..b42aeac05340 100644
> --- a/arch/arm64/include/asm/rsi.h
> +++ b/arch/arm64/include/asm/rsi.h
> @@ -10,6 +10,8 @@
>  #include <linux/jump_label.h>
>  #include <asm/rsi_cmds.h>
>  
> +#define RSI_PDEV_NAME "arm-cca-dev"
> +
>  DECLARE_STATIC_KEY_FALSE(rsi_present);
>  
>  void __init arm64_rsi_init(void);
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 3031f25c32ef..5434e5496ac2 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -8,6 +8,7 @@
>  #include <linux/psci.h>
>  #include <linux/swiotlb.h>
>  #include <linux/cc_platform.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/io.h>
>  #include <asm/mem_encrypt.h>
> @@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
>  	static_branch_enable(&rsi_present);
>  }
>  
> +static struct platform_device rsi_dev = {
> +	.name = RSI_PDEV_NAME,
> +	.id = PLATFORM_DEVID_NONE
> +};
> +
> +static int __init rsi_init(void)
> +{
> +	if (is_realm_world() &&
> +	    platform_device_register(&rsi_dev))
> +		pr_err("failed to register rsi platform device\n");
> +	return 0;
> +}
> +
> +arch_initcall(rsi_init)

This file already has an arm64_rsi_init()... Ideally, we'd hang this
off the end of that instead of the initcall but I suspect you're going
to tell me that platform_device_register() doesn't like being called
that early?

If so, perhaps arm64_create_dummy_rsi_dev() might be better?

Will

