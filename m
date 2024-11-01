Return-Path: <linux-kernel+bounces-392032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047679B8EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD518283738
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9715A864;
	Fri,  1 Nov 2024 10:17:52 +0000 (UTC)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970A156F28
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456272; cv=none; b=f3MF3MIFGVCSWSpJ3XO5ofnqiwQQlZAWW7nsav6ruh+Yrs+lbtcZMvBUZblVxQPCQowwjytcFdQHS7Pq7Tpo7yUaO08zLEDYaDWmff2Z9yJ/EZjrr1nxPd51daOAlKfnnYjOprxFZkegfn4eC91rmLdpCCwEzMS3I0jIFEbrg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456272; c=relaxed/simple;
	bh=e00zWZfVfIqdu2m8FU2GXwtFX+jh2hRaBYAD7fGyLTw=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To; b=BSvuQxfA81XRuvsk+aE1s071ilViwUZBXZAb6cZzrf5AH2NDJwLw2zEuBBCv4wN+T0Ot4x2C3DS50Z59k3+Be05h4uaLfVeKQi+WuYQxfqsUklh6g6HXv8TaK14YPlAAyXu4ATfwgUywqzih0KZxbBQNnXuhJCp00VPpZcKX2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
	id 1t6odz-0004XZ-GE
	for linux-kernel@vger.kernel.org; Fri, 01 Nov 2024 11:12:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] rtc: bbnsm: add remove hook
Date: Fri, 1 Nov 2024 11:12:30 +0100
Message-ID: <f22fc806-7816-4da9-8cac-a84db22d96fd@wanadoo.fr>
References: <20241101101032.1446992-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-FR
In-Reply-To: <20241101101032.1446992-1-peng.fan@oss.nxp.com>

Le 01/11/2024 à 11:10, Peng Fan (OSS) a écrit :
> From: Peng Fan <peng.fan@nxp.com>
> 
> Without remove hook to clear wake irq, there will be kernel dump when
> doing module test.
> "bbnsm_rtc 44440000.bbnsm:rtc: wake irq already initialized"
> 
> Add remove hook to clear wake irq and set wakeup to false.
> 
> Fixes: eb7b85853c38 ("rtc: bbnsm: Add the bbnsm rtc support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/rtc/rtc-nxp-bbnsm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-nxp-bbnsm.c b/drivers/rtc/rtc-nxp-bbnsm.c
> index acbfbeb8b070..fa88fd8ffadf 100644
> --- a/drivers/rtc/rtc-nxp-bbnsm.c
> +++ b/drivers/rtc/rtc-nxp-bbnsm.c
> @@ -206,6 +206,12 @@ static int bbnsm_rtc_probe(struct platform_device *pdev)
>   	return devm_rtc_register_device(bbnsm->rtc);
>   }
>   
> +static void bbnsm_rtc_remove(struct platform_device *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);

I think that an error handling path in the probe should also be added 
with such calls.

> +}
> +
>   static const struct of_device_id bbnsm_dt_ids[] = {
>   	{ .compatible = "nxp,imx93-bbnsm-rtc" },
>   	{ /* sentinel */ },
> @@ -218,6 +224,7 @@ static struct platform_driver bbnsm_rtc_driver = {
>   		.of_match_table = bbnsm_dt_ids,
>   	},
>   	.probe = bbnsm_rtc_probe,
> +	.remove_new = bbnsm_rtc_remove,

I think that .remove should be used here instead.
(see 
https://elixir.bootlin.com/linux/v6.12-rc5/source/include/linux/platform_device.h#L240)

>   };
>   module_platform_driver(bbnsm_rtc_driver);
>   

CJ


