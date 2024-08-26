Return-Path: <linux-kernel+bounces-302050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5F95F92A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDD8283DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF61991BE;
	Mon, 26 Aug 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9MLujnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2E198E83;
	Mon, 26 Aug 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697948; cv=none; b=q61wk0uxkLN/npv40e+qTOWdgB+NyAgk+BjZG4aKMi74CEfpznVw7sjxrQA5vUlZALJVnUNrDW8aLnpi5yOOx6Z01IdReTz+uko8X9BvycCZ04HewENsfdxPziBUb6+Rprh3ALl/QvuS7W1lV53MM14qH3201Y3igAh9PhLAWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697948; c=relaxed/simple;
	bh=ysY6MyTvKsXP7owiZXnmlj8olMa912wMXUBKgkEWvQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6Ch9dxSUoKTIsPTK1K9UZwjGmQQvow6GVk/etQW7CJJltxMo0F0OTO2R8PksyOzvij3xRpG/XYpAIT1MBAvSsJEPXyfaATdfX7e1OlWLYyZfCqkc5vJ47hOSbF9hYWR2g/SjRv6Xv68357uKkn6f1qdgBdIWZESAaGwxIxb8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9MLujnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0776C4AF49;
	Mon, 26 Aug 2024 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724697947;
	bh=ysY6MyTvKsXP7owiZXnmlj8olMa912wMXUBKgkEWvQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9MLujnAIuhs9iPsUiSSS8j7gPgUwkYitsGUpPwy7lycl7v9PEQacqaUTSiKFUDsH
	 4JMSX7U/Piqwfpa6raVl06drab3HLD7laYn0KtWb/QXS0aNJDrRCs1KwL3TIYvva8/
	 IqsMklpNQl6yV/Rtpt8aVlpto6nCtl4+ghA1jPyOosuUSv0XY40StXI3eUVziSxquR
	 tBImSe+k9Lj7Db6bmZIr8MSaR1Un0g5NXaWf/ovIuf8MDRprXt5JDpiqfuDeXxaUnW
	 Ymii34og+J8XNg1B1iyWD3fgw6r0kGp4fdQsPBynXmJYWnfnM6GhqzMLq3qVuqQVJr
	 Jvw9+m+4E23NA==
Message-ID: <755c5428-da97-416c-9af3-52b94cbe4ac5@kernel.org>
Date: Mon, 26 Aug 2024 20:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] soc: ti: Add IOMPU-like PVU driver
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <30e16282dd0f7583c8d6ad0078ccdb17a804504d.1724694969.git.jan.kiszka@siemens.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <30e16282dd0f7583c8d6ad0078ccdb17a804504d.1724694969.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2024 19:56, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The TI Peripheral Virtualization Unit (PVU) permits to define a limited
> set of mappings for DMA requests on the system memory. Unlike with an
> IOMMU, there is no fallback to a memory-backed page table, only a fixed
> set of register-backed TLBs. Emulating an IOMMU behavior appears to be
> the more fragile the more fragmentation of pending requests occur.
> 
> Therefore, this driver does not expose the PVU as an IOMMU. It rather
> introduces a simple, static interface to devices that are under
> restricted-dma-pool constraints. They can register their pools with the
> PVUs, enabling only those pools to work for DMA. As also MSI is issued
> as DMA, the PVU already register the related translator region of the
> AM654 as valid DMA target.
> 
> This driver is the essential building block for limiting DMA from
> untrusted devices to clearly defined memory regions in the absence of a
> real IOMMU (SMMU).
> 
> Co-developed-by: Diogo Ivo <diogo.ivo@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/soc/ti/Kconfig  |   4 +
>  drivers/soc/ti/Makefile |   1 +
>  drivers/soc/ti/ti-pvu.c | 487 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/ti-pvu.h  |  11 +
>  4 files changed, 503 insertions(+)
>  create mode 100644 drivers/soc/ti/ti-pvu.c
>  create mode 100644 include/linux/ti-pvu.h
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 1a93001c9e36..af7173ad84de 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -82,6 +82,10 @@ config TI_PRUSS
>  	  processors on various TI SoCs. It's safe to say N here if you're
>  	  not interested in the PRU or if you are unsure.
>  

...

> +
> +static int ti_pvu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *its_node;
> +	void __iomem *base;
> +	struct ti_pvu *pvu;
> +	u32 val;
> +	int ret;
> +
> +	pvu = devm_kzalloc(dev, sizeof(struct ti_pvu), GFP_KERNEL);

sizeof(*)

> +	if (!pvu)
> +		return -ENOMEM;
> +
> +	pvu->pdev = pdev;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "cfg");
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pvu->cfg = devm_regmap_init_mmio(dev, base, &pvu_cfg_regmap_cfg);
> +	if (IS_ERR(pvu->cfg))
> +		return dev_err_probe(dev, PTR_ERR(pvu->cfg), "failed to init cfg regmap");
> +
> +	ret = devm_regmap_field_bulk_alloc(dev, pvu->cfg, pvu->cfg_fields,
> +					   pvu_cfg_reg_fields, PVU_MAX_CFG_FIELDS);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to alloc cfg regmap fields");
> +
> +	pvu->num_tlbs = pvu_field_read(pvu, PVU_TLBS);
> +	pvu->num_entries = pvu_field_read(pvu, PVU_TLB_ENTRIES);
> +	dev_info(dev, "TLBs: %d, entries per TLB: %d\n", pvu->num_tlbs,
> +		 pvu->num_entries);
> +
> +	pvu->tlbif_base = devm_platform_ioremap_resource_byname(pdev, "tlbif");
> +	if (IS_ERR(pvu->tlbif_base))
> +		return PTR_ERR(pvu->tlbif_base);
> +
> +	its_node = of_find_compatible_node(0, 0, "arm,gic-v3-its");
> +	if (its_node) {
> +		u32 pre_its_window[2];
> +
> +		ret = of_property_read_u32_array(its_node,
> +						 "socionext,synquacer-pre-its",
> +						 pre_its_window,
> +						 ARRAY_SIZE(pre_its_window));
> +		if (ret) {
> +			dev_err(dev, "failed to read pre-its property\n");
> +			return ret;
> +		}
> +
> +		ret = pvu_create_region(pvu, pre_its_window[0],
> +					pre_its_window[1]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	val = readl(pvu->tlbif_base + PVU_CHAIN);
> +	val |= PVU_CHAIN_EN;
> +	writel(val, pvu->tlbif_base + PVU_CHAIN);
> +
> +	pvu_field_write(pvu, PVU_DMA_CNT, 0);
> +	pvu_field_write(pvu, PVU_DMA_CL0, 0);
> +	pvu_field_write(pvu, PVU_DMA_CL1, 0);
> +	pvu_field_write(pvu, PVU_DMA_CL2, 0);
> +	pvu_field_write(pvu, PVU_DMA_CL3, 0);
> +	pvu_field_write(pvu, PVU_MAX_VIRTID, NUM_VIRTIDS);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get irq\n");
> +
> +	ret = devm_request_irq(dev, ret, pvu_fault_isr, 0, dev_name(dev), pvu);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq\n");
> +
> +	pvu_field_write(pvu, PVU_EXC_ENABLE, 1);
> +	pvu_field_write(pvu, PVU_ENABLED, 1);
> +
> +	dev_set_drvdata(dev, pvu);
> +
> +	mutex_lock(&ti_pvu_lock);
> +	list_add(&pvu->entry, &ti_pvu_list);
> +	mutex_unlock(&ti_pvu_lock);
> +
> +	return 0;
> +}
> +
> +static void ti_pvu_remove(struct platform_device *pdev)
> +{
> +	struct ti_pvu *pvu = dev_get_drvdata(&pdev->dev);
> +
> +	mutex_lock(&ti_pvu_lock);
> +	list_del(&pvu->entry);
> +	mutex_unlock(&ti_pvu_lock);
> +}
> +
> +static const struct of_device_id ti_pvu_of_match[] = {
> +	{ .compatible = "ti,am654-pvu", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ti_pvu_of_match);
> +
> +static struct platform_driver ti_pvu_driver = {
> +	.driver = {
> +		.name = "ti-pvu",
> +		.of_match_table = ti_pvu_of_match,
> +	},
> +	.probe = ti_pvu_probe,
> +	.remove_new = ti_pvu_remove,
> +};
> +module_platform_driver(ti_pvu_driver);
> diff --git a/include/linux/ti-pvu.h b/include/linux/ti-pvu.h
> new file mode 100644
> index 000000000000..d40642522cf0
> --- /dev/null
> +++ b/include/linux/ti-pvu.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI Peripheral Virtualization Unit driver for static DMA isolation
> + *
> + * Copyright (c) 2024, Siemens AG
> + */
> +

Missing guards.

> +#include <linux/ioport.h>
> +
> +int ti_pvu_create_region(unsigned int virt_id, const struct resource *region);
> +int ti_pvu_remove_region(unsigned int virt_id, const struct resource *region);


Best regards,
Krzysztof


