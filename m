Return-Path: <linux-kernel+bounces-306867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD949644C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73E71F21922
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FA1AD9D9;
	Thu, 29 Aug 2024 12:34:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AF196455
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934881; cv=none; b=E5gWDFCTabO71oElmNMB+/NwR9KMnI+lWgAM63FtIbs9WMgpjK/kJ+K5P4VH2dXyatDHj0l9XaR2RAwAJkFsnjVVOKCOWZry8d/E9W9tmv1NpF1YiqddRdt2QuF0GnSPRcC1r0sZ3M+eYY2paQO8IqteKQy9APPJ++S8BikBGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934881; c=relaxed/simple;
	bh=HKjwKwvzbKjmVaUO91Irytsyx+WvJ9b5wVoWMYjWRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+HFnR2jVPnfrsQFTMMJcxhWuA+ELWcIbiQ/2gPPx6ebDvFhnlbZY6Z+5SBq4Hgbc4AKtstaJ08VfISqQUzElcw8ON2E94rRYpBjfUH/szxq47j7Iim7ti8qr6pHEshBKHHg7MwKNa3vLQptI3CAe3orYY7UWpOQehbnczBrrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09FF311FB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:35:05 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8981F3F762
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:34:38 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:34:28 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: integrator-lm: fix OF node leak in probe()
Message-ID: <ZtBq1G4GRo-hw58Z@e110455-lin.cambridge.arm.com>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
 <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>

On Mon, Aug 26, 2024 at 07:49:34AM +0200, Krzysztof Kozlowski wrote:
> Driver code is leaking OF node reference from of_find_matching_node() in
> probe().
> 
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/bus/arm-integrator-lm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
> index b715c8ab36e8..a65c79b08804 100644
> --- a/drivers/bus/arm-integrator-lm.c
> +++ b/drivers/bus/arm-integrator-lm.c
> @@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  	map = syscon_node_to_regmap(syscon);
> +	of_node_put(syscon);
>  	if (IS_ERR(map)) {
>  		dev_err(dev,
>  			"could not find Integrator/AP system controller\n");
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

