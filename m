Return-Path: <linux-kernel+bounces-306858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F0D9644AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF521F260A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E61A4ADE;
	Thu, 29 Aug 2024 12:33:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5571A2C3C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934838; cv=none; b=AMh3AI773CK4N60NNcXBhjYWwkRd8kKyjHvYwIcsWsvKU7dQiqaJY+17GTp6kCZvHLd6t4WlN7J6h48ubOcq2nRhifXr5YrmVcSJsfYrNDjlrCexagTeRiTmpQEEQk5wxUwebmRhST6uW10q9dKsyiEQjpQr1WpsqZ3kmSbRXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934838; c=relaxed/simple;
	bh=Rejae07MO26NNA/KXYCKtW6yuzjuQL6t3j3weNlO29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjCk5NfFtjXfuYdtq+hWZKYvXCGyO1C+8ftk1HG/8qe6rbPMW9Hv9roAYnZfNcNqByf59NnNHvf4mK8/twQqSOzxEwR9Mp4belN8a6DHO6o7SkAwEIHuCn7ap46rgpCHGM0jH5eHnxsrThKfUdnCn7+9R6+gm7qFybHrss+3f40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4721ADA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:34:22 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D03F23F762
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:33:55 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:33:45 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: versatile: fix OF node leak in CPUs prepare
Message-ID: <ZtBqqXWvVWDtaeE8@e110455-lin.cambridge.arm.com>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>

On Mon, Aug 26, 2024 at 07:49:33AM +0200, Krzysztof Kozlowski wrote:
> Machine code is leaking OF node reference from of_find_matching_node()
> in realview_smp_prepare_cpus().
> 
> Fixes: 5420b4b15617 ("ARM: realview: add an DT SMP boot method")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I think Sudeep is going to take the series through his tree, but he might
be on holiday at this time.

Best regards,
Liviu

> 
> ---
> 
> Not Cc-ing stable as this should have almost no impact, except code
> correctness.
> ---
>  arch/arm/mach-versatile/platsmp-realview.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
> index 6965a1de727b..d38b2e174257 100644
> --- a/arch/arm/mach-versatile/platsmp-realview.c
> +++ b/arch/arm/mach-versatile/platsmp-realview.c
> @@ -70,6 +70,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
>  		return;
>  	}
>  	map = syscon_node_to_regmap(np);
> +	of_node_put(np);
>  	if (IS_ERR(map)) {
>  		pr_err("PLATSMP: No syscon regmap\n");
>  		return;
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

