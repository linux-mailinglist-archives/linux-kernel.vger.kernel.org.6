Return-Path: <linux-kernel+bounces-295187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF99A959854
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527271F2164E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8A41C93C2;
	Wed, 21 Aug 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WePKUzf0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E21C93A9;
	Wed, 21 Aug 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230865; cv=none; b=Ymog0VzbIhpMwsuyrAS2eTFhuWH9Yc+RSd1t+m7E3cfY+cdtIyzzK58Q94grGOtsJJwF0bBLKVEvTxTWstg6tf8QZlaA9qTbKFtISSMF3sCX6YGQnnA6DpMA9r6Ssd3BbYnsPyRV2SiWcUsfPEwpjWtQppULJA6HCN4z5lG85xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230865; c=relaxed/simple;
	bh=2G4lmVJYJdg1XmNfOHPJL0lvj+y+GJhPa4tXV1E0Uhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwbDdozrOBDEXNZZHq8iydMIN8yQDGF4hSYXUuIhrBhJY1v+MwS0Sd2b/vOyVT7O3BMvyErd9O0nzeXmkf/WZTdkD+IaAqIXXLcnyehDfgyKKbcse1w64JnY0qJHOkuM7BjDzSpY86V/h8nmBLJL9nWdYMk0AVLcCBYbsGDh6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WePKUzf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329A3C32782;
	Wed, 21 Aug 2024 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230864;
	bh=2G4lmVJYJdg1XmNfOHPJL0lvj+y+GJhPa4tXV1E0Uhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WePKUzf0lACwBXiRC3KE9leaJ1UzxoGlncYk3zQ+Ik7kPmEEys8iKwP27dgwZflrd
	 kYAbvAH5JxGhicx2+OceWCueMxRTDUH8IzdmSMmzhryXEJZ3vH/mLLe/Vbe2JnKVqw
	 T2tdsri/XMQYAL30kPWDF9tu6PmiNTHxFywF8CQA7kcFII7FF5MnR8s/WdqmM9I73c
	 bG4jS7yLkd0YIUSjc+aAezvi8LhswvHtjl0CuJL4ZIfHTvRCyrHURT6Y12uappZ5tt
	 rtl0psDosVhS6i9PaMFSHACuvcfMzo9s6sYnrr9ke8KhaS6SqgPl6ONr7BXtWwr4Hs
	 JoIl4kCm+jyfw==
Message-ID: <25b487b7-63e0-402d-a0a2-ed9d03e82630@kernel.org>
Date: Wed, 21 Aug 2024 11:00:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
To: "friday.yang" <friday.yang@mediatek.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-4-friday.yang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240821082845.11792-4-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 10:26, friday.yang wrote:
> In order to avoid handling glitch signal when MTCMOS on/off, SMI need
> clamp and reset operation. Parse power reset settings for LARBs which
> need to reset. Register genpd callback for SMI LARBs and apply reset
> operations in the callback.
> 
> Signed-off-by: friday.yang <friday.yang@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 148 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 2 deletions(-)
> 

...

> +
> +static int mtk_smi_larb_parse_reset_info(struct mtk_smi_larb *larb)
> +{
> +	struct device_node *reset_node;
> +	struct device *dev = larb->dev;
> +	int ret;
> +
> +	/* only larb with "resets" need to get reset setting */
> +	reset_node = of_parse_phandle(dev->of_node, "resets", 0);

Nope, you do not parse rasets.

> +	if (!reset_node)
> +		return 0;
> +	of_node_put(reset_node);
> +
> +	larb->rst_con = devm_reset_control_get(dev, "larb_rst");

Where are the bindings? Why do you add undocumented properties? How
possible this passes dtbs_check???


> +	if (IS_ERR(larb->rst_con))
> +		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
> +				     "cannot get larb reset controller\n");
> +
> +	larb->nb.notifier_call = mtk_smi_genpd_callback;
> +	ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add genpd callback %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mtk_smi_larb_probe(struct platform_device *pdev)
>  {
>  	struct mtk_smi_larb *larb;
> @@ -538,6 +662,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	if (!larb)
>  		return -ENOMEM;
>  
> +	larb->dev = dev;
>  	larb->larb_gen = of_device_get_match_data(dev);
>  	larb->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(larb->base))
> @@ -554,15 +679,29 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	pm_runtime_enable(dev);
> +	/* find sub common to clamp larb for ISP software reset */
> +	ret = mtk_smi_larb_parse_clamp_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clamp setting for larb\n");
> +		goto err_pm_disable;
> +	}
> +
> +	ret = mtk_smi_larb_parse_reset_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get power setting for larb\n");
> +		goto err_pm_disable;
> +	}
> +
>  	platform_set_drvdata(pdev, larb);
>  	ret = component_add(dev, &mtk_smi_larb_component_ops);
>  	if (ret)
>  		goto err_pm_disable;
> +
> +	pm_runtime_enable(dev);
> +
>  	return 0;
>  
>  err_pm_disable:
> -	pm_runtime_disable(dev);
>  	device_link_remove(dev, larb->smi_common_dev);

Label asls pm disable. Where is the pm disable?

>  	return ret;
>  }
> @@ -686,6 +825,10 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
>  	.init     = mtk_smi_common_mt8195_init,
>  };

Best regards,
Krzysztof


