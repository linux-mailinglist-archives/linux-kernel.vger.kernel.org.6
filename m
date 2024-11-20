Return-Path: <linux-kernel+bounces-415337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4909D34B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653DCB24EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09216EB56;
	Wed, 20 Nov 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP6d7+P7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78A1586FE;
	Wed, 20 Nov 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088981; cv=none; b=iOblJLuSVFON/Uhh/kQZmS7mzbh1uSfv4TLLyWNNGht+Wj62K9CXq3k+KFzO7O+Aj05g36lYtHG4k1g8VQOFzlrFZAJFXbPXvqwwxjvfrYhZqEWgxnVsWQgDjne07f12E1myGPcjFGamwZpyYIc4WSWRxGml0owtA7qrotbNdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088981; c=relaxed/simple;
	bh=9znmQf+6tAWf0be3BtDWelVJW/OEynrZro3lePlfJaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qncmenTaRFiVROTDYOnC1CqLLWg9RzL5hLeXGgScWoSqvvJrybHeyFaq1VZg3Lo9zeYO/Ur8gH5L45IDO6bVb9YEfGgpsh5BJr6LlNn0mc5fsgz2krt6IArVo6tMYKNxq4lcegb9E6urnKS+HWsGA+PyoJnJVptDm4IzwSadbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP6d7+P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4423EC4CECD;
	Wed, 20 Nov 2024 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732088980;
	bh=9znmQf+6tAWf0be3BtDWelVJW/OEynrZro3lePlfJaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tP6d7+P7+YIgBEQwoiPFx+SP/d8veC3W9rUPCIcmsg5EdQRpxzfAEFxJTUANno8pf
	 w4CC/fc2a1lHh/5YLYJ6ognn5hkOWilDU8fXhh6p9aB/CGhg2Ah7D91KJQ2bic3u/q
	 aUiT8eva8TFIsoEF+XADqBs84RL7uAQa/AB8Kl3wytajpqK1S8gETO+GpE8Dkr4Ano
	 cM+NMsFOFXwFYtOwOuJI2WfRPHrGONnE9gPr4l/uzoN2Kjjclhekdcc7DAxkIhFvzb
	 uuq9I51vhc3VTsUdvnHPZ73FwBLsk8RlMAJvxv+bBWai++XoKFCuFhIA2PX7Mw18VM
	 7DjyfHQJIJnZg==
Message-ID: <5bf3bdab-8614-4024-a9da-f7f58414c0af@kernel.org>
Date: Wed, 20 Nov 2024 08:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241120063701.8194-1-friday.yang@mediatek.com>
 <20241120063701.8194-3-friday.yang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241120063701.8194-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2024 07:36, Friday Yang wrote:
> In order to avoid handling glitch signal when MTCMOS on/off, SMI need
> clamp and reset operation. Parse power reset settings for LARBs which
> need to reset. Register genpd callback for SMI LARBs and apply reset
> operations in the callback.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 175 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 2bc034dff691..c7119f655350 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -10,15 +10,21 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>

Where do you use it?

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>

Where do you use it?

>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

Where do you use it?

> +#include <linux/reset.h>
> +#include <linux/reset-controller.h>
>  #include <linux/soc/mediatek/mtk_sip_svc.h>
>  #include <soc/mediatek/smi.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <dt-bindings/memory/mtk-memory-port.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>  

...

>  
> +static int mtk_smi_larb_parse_clamp_info(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +	struct device_node *smi_node;
> +	struct of_phandle_args args;
> +	int ret, index;
> +
> +	/* Only SMI LARBs located in camera and image subsys need to

Use Linux coding style.

> +	 * apply clamp and reset operation, others can be skipped.
> +	 */
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +					       "resets", 1, 0, &args);

NAK

> +	if (ret)
> +		return 0;
> +
> +	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> +	if (!smi_node)
> +		return -EINVAL;
> +
> +	index = args.args[0];

That's reset, not clamp port. NAK.

> +	larb->sub_comm_inport = larb_gen->clamp_port[index];
> +	larb->sub_comm_syscon = device_node_to_regmap(smi_node);
> +	of_node_put(smi_node);
> +
> +	if (IS_ERR(larb->sub_comm_syscon) ||
> +	    larb->sub_comm_inport >= SMI_SUB_COMM_INPORT_NR) {
> +		larb->sub_comm_syscon = NULL;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_smi_larb_parse_reset_info(struct mtk_smi_larb *larb)
> +{
> +	struct device *dev = larb->dev;
> +	int ret;
> +
> +	/* Only SMI LARBs located in camera and image subsys need to

Use Linux coding style. This applies to all your patches and all places
in this patch.

> +	 * apply clamp and reset operation, others can be skipped.
> +	 */
> +	if (!of_find_property(dev->of_node, "resets", NULL))

That's not how you use reset framework API. Use proper optional API.

> +		return 0;
> +
> +	larb->rst_con = devm_reset_control_get(dev, "larb");
> +	if (IS_ERR(larb->rst_con))
> +		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
> +				     "Can not get larb reset controller\n");
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
> @@ -538,6 +685,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	if (!larb)
>  		return -ENOMEM;
>  
> +	larb->dev = dev;
>  	larb->larb_gen = of_device_get_match_data(dev);
>  	larb->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(larb->base))
> @@ -554,15 +702,29 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	pm_runtime_enable(dev);
> +	/* find sub common to clamp larb for ISP software reset */
> +	ret = mtk_smi_larb_parse_clamp_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clamp setting for larb\n");
> +		goto err_link_remove;
> +	}
> +
> +	ret = mtk_smi_larb_parse_reset_info(larb);
> +	if (ret) {
> +		dev_err(dev, "Failed to get power setting for larb\n");
> +		goto err_link_remove;
> +	}
> +
>  	platform_set_drvdata(pdev, larb);
>  	ret = component_add(dev, &mtk_smi_larb_component_ops);
>  	if (ret)
> -		goto err_pm_disable;
> +		goto err_link_remove;
> +
> +	pm_runtime_enable(dev);
> +
>  	return 0;
>  
> -err_pm_disable:
> -	pm_runtime_disable(dev);
> +err_link_remove:
>  	device_link_remove(dev, larb->smi_common_dev);
>  	return ret;
>  }
> @@ -686,6 +848,10 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
>  	.init     = mtk_smi_common_mt8195_init,
>  };
>  
> +static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
> +	.type     = MTK_SMI_GEN2_SUB_COMM,
> +};
> +
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>  	.type     = MTK_SMI_GEN2,
>  	.has_gals = true,
> @@ -729,6 +895,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
>  	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
>  	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
>  	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
> +	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
>  	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
>  	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
>  	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},


Best regards,
Krzysztof

