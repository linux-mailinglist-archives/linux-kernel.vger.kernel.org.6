Return-Path: <linux-kernel+bounces-442963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC29EE4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B001A1661BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAC211498;
	Thu, 12 Dec 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGZqPh7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374A1EC4D2;
	Thu, 12 Dec 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001370; cv=none; b=lpmRSvqFZ6/HJu9aGaD9d7P4uyJE3hKgTKTMEVPmpx9FsnoNdbiS6l5y+eM36DnxCxqEWPQ6Jo5G4A3FFDGUKPoyooP3CAM/JGxde6wmSwLP3oA8EE5KaQNby4dKzC97W2q8ogbck0EvHgsxmiRy7LEQikhoiokY0T3/F4UzXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001370; c=relaxed/simple;
	bh=EzrdvltG4zXSo7Kf9ToJ/1P4INPNq02YkmJFult7cCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1T8DtY8PYBJLL79XTYAonB3drqzfR8VHPOt687JK3KiWo2GM2rzlibiimX/7vgH7Y73qR5s3KGy8+do6OTeTbzBvfQuSUyv/Kh9wS6rPduosewiaEhSimenj56x5t6f+gfgHsl10sSvBFIvx6I8suXjYVoIqpuzNiyFdAsuq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGZqPh7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D0EC4AF09;
	Thu, 12 Dec 2024 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734001370;
	bh=EzrdvltG4zXSo7Kf9ToJ/1P4INPNq02YkmJFult7cCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IGZqPh7lNdNMwPGCgcmoxc3ckg0ihyc6U5d27374FCNF5G2ox0rpx0WOFRJPvdfG5
	 nMbmUk2LDw7cy6/KD0d0w6d/pR5Y3RuUHPUMPf/3b20jJBp87JZzDDxhRBchmKuSSe
	 7l2U+uxVIsP2w13ohHoLhfwi6FfjeoqprJGk4C1qvKSjxwqXWxVKFFBRlEg7N1SChI
	 AVb/VpioyQt9O6RmGDGTurMbU9S33aT9gP+MZbl/tJ1tdpfug6JdLR8sATL0dEn++r
	 GzGicP5Q5+nsoRlQ9MNQvV/59Q3JRm0Bcr0dSWNsynUHX0lf/vCUqbbL8LeNB7EwzS
	 uhWk1KDYISj5g==
Message-ID: <a2288f77-0178-4769-8bf3-662c82b8b4e3@kernel.org>
Date: Thu, 12 Dec 2024 12:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory/mediatek: Add an interface to get current DDR
 data rate
To: Crystal Guo <crystal.guo@mediatek.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
 <20241212090029.13692-2-crystal.guo@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241212090029.13692-2-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2024 09:59, Crystal Guo wrote:
> Add MediaTek DRAMC driver to provide an interface that can
> obtain current DDR data rate.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  drivers/memory/Kconfig                 |   1 +
>  drivers/memory/Makefile                |   1 +
>  drivers/memory/mediatek/Kconfig        |  21 ++
>  drivers/memory/mediatek/Makefile       |   2 +
>  drivers/memory/mediatek/mtk-dramc.c    | 325 +++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-dramc.h |  41 ++++
>  6 files changed, 391 insertions(+)
>  create mode 100644 drivers/memory/mediatek/Kconfig
>  create mode 100644 drivers/memory/mediatek/Makefile
>  create mode 100644 drivers/memory/mediatek/mtk-dramc.c
>  create mode 100644 include/linux/soc/mediatek/mtk-dramc.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index c82d8d8a16ea..b1698549ff81 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -227,5 +227,6 @@ config STM32_FMC2_EBI
>  
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
> +source "drivers/memory/mediatek/Kconfig"
>  
>  endif
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index d2e6ca9abbe0..cf1091449d2e 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
>  
>  obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
> +obj-$(CONFIG_HAVE_MTK_MC)	+= mediatek/

What is HAVE? Why this is not just MTK_MC or ARCH_MEDIATEK?

>  obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
>  obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
>  
> diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
> new file mode 100644
> index 000000000000..00764cdb157e
> --- /dev/null
> +++ b/drivers/memory/mediatek/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HAVE_MTK_MC
> +	bool "MediaTek Memory Controller support"
> +	help
> +	  This option allows to enable MediaTek memory controller drivers,
> +	  which may include controllers for DRAM or others.
> +	  Select Y here if you need support for MediaTek memory controller.
> +	  If you don't need, select N.
> +
> +if HAVE_MTK_MC
> +
> +config MTK_DRAMC
> +	tristate "MediaTek DRAMC driver"
> +	depends on HAVE_MTK_MC

Feels useless, isn't it part of if?

> +	help
> +	  This option selects the MediaTek DRAMC driver, which provides
> +	  an interface for reporting the current data rate of DRAM.
> +	  Select Y here if you need support for the MediaTek DRAMC driver.
> +	  If you don't need, select N.
> +
> +endif
> diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
> new file mode 100644
> index 000000000000..a1395fc55b41
> --- /dev/null
> +++ b/drivers/memory/mediatek/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_MTK_DRAMC)		+= mtk-dramc.o
> diff --git a/drivers/memory/mediatek/mtk-dramc.c b/drivers/memory/mediatek/mtk-dramc.c
> new file mode 100644
> index 000000000000..9c2c8e187a4a
> --- /dev/null
> +++ b/drivers/memory/mediatek/mtk-dramc.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/printk.h>
> +#include <linux/io.h>
> +#include <linux/soc/mediatek/mtk-dramc.h>
> +
> +static struct platform_device *dramc_pdev;
> +static struct platform_driver dramc_drv;

Drop both. Don't write singleton code.

...

> +		if (!(dramc_dev_ptr->fmeter_dev_ptr)) {
> +			pr_info("%s: memory  alloc fail\n", __func__);
> +			return -ENOMEM;
> +		}
> +		ret = fmeter_init(pdev, dramc_dev_ptr->fmeter_dev_ptr, fmeter_version);
> +		if (ret) {
> +			pr_info("%s: fmeter_init fail\n", __func__);
> +			return -EINVAL;
> +		}
> +	} else {
> +		dramc_dev_ptr->fmeter_dev_ptr = NULL;
> +	}
> +	ret = driver_create_file(pdev->dev.driver, &driver_attr_dram_data_rate);
> +	if (ret) {
> +		pr_info("%s: fail to create dram_data_rate sysfs\n", __func__);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, dramc_dev_ptr);
> +	pr_info("%s: DRAM data rate = %d\n", __func__,
> +		mtk_dramc_get_data_rate());


This is terible coding style. Driver is in very poor shape.

Please perform extensive internal review in Mediatek to avoid sending
very poor quality contributions. This uses community resources in unfair
way. Few more comments, but all this code needs extensive rework and I
am not going to explain you basics of Linux Coding style, if you do not
want to take existing code as learning examples. Work with your
collegagues on that.


> +
> +	return ret;
> +}
> +
> +static unsigned int fmeter_v1(struct dramc_dev_t *dramc_dev_ptr)
> +{
> +	struct fmeter_dev_t *fmeter_dev_ptr =
> +		(struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
> +	unsigned int shu_lv_val;
> +	unsigned int pll_id_val;
> +	unsigned int sdmpcw_val;
> +	unsigned int posdiv_val;
> +	unsigned int ckdiv4_val;
> +	unsigned int offset;
> +	unsigned int vco_freq;
> +	unsigned int fbksel;
> +	unsigned int dqsopen;
> +	unsigned int async_ca;
> +	unsigned int dq_ser_mode;
> +
> +	shu_lv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] +
> +		fmeter_dev_ptr->shu_lv.offset) &
> +		fmeter_dev_ptr->shu_lv.mask) >>
> +		fmeter_dev_ptr->shu_lv.shift;
> +
> +	pll_id_val = (readl(dramc_dev_ptr->ddrphy_chn_base_ao[0] +
> +		fmeter_dev_ptr->pll_id.offset) &
> +		fmeter_dev_ptr->pll_id.mask) >>
> +		fmeter_dev_ptr->pll_id.shift;
> +
> +	offset = fmeter_dev_ptr->sdmpcw[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	sdmpcw_val = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->sdmpcw[pll_id_val].mask) >>
> +		fmeter_dev_ptr->sdmpcw[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->posdiv[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	posdiv_val = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->posdiv[pll_id_val].mask) >>
> +		fmeter_dev_ptr->posdiv[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->fbksel[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	fbksel = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->fbksel[pll_id_val].mask) >>
> +		fmeter_dev_ptr->fbksel[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->dqsopen[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	dqsopen = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->dqsopen[pll_id_val].mask) >>
> +		fmeter_dev_ptr->dqsopen[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->async_ca[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	async_ca = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->async_ca[pll_id_val].mask) >>
> +		fmeter_dev_ptr->async_ca[pll_id_val].shift;
> +
> +	offset = fmeter_dev_ptr->dq_ser_mode[pll_id_val].offset +
> +		fmeter_dev_ptr->shu_of * shu_lv_val;
> +	dq_ser_mode = (readl(dramc_dev_ptr->ddrphy_chn_base_nao[0] + offset) &
> +		fmeter_dev_ptr->dq_ser_mode[pll_id_val].mask) >>
> +		fmeter_dev_ptr->dq_ser_mode[pll_id_val].shift;
> +	ckdiv4_val = (dq_ser_mode == 1); // 1: DIV4, 2: DIV8, 3: DIV16
> +
> +	posdiv_val &= ~(0x4);
> +
> +	vco_freq = ((fmeter_dev_ptr->crystal_freq) *
> +		(sdmpcw_val >> 7)) >> posdiv_val >> 1 >> ckdiv4_val
> +		<< fbksel;
> +
> +	if ((dqsopen == 1) && (async_ca == 1))
> +		vco_freq >>= 1;
> +
> +	return vco_freq;
> +}
> +
> +/*
> + * mtk_dramc_get_data_rate - calculate DRAM data rate
> + *
> + * Returns DRAM data rate (MB/s)
> + */
> +unsigned int mtk_dramc_get_data_rate(void)
> +{
> +	struct dramc_dev_t *dramc_dev_ptr;
> +	struct fmeter_dev_t *fmeter_dev_ptr;
> +
> +	if (!dramc_pdev)
> +		return 0;
> +
> +	dramc_dev_ptr =
> +		(struct dramc_dev_t *)platform_get_drvdata(dramc_pdev);
> +
> +	fmeter_dev_ptr = (struct fmeter_dev_t *)dramc_dev_ptr->fmeter_dev_ptr;
> +	if (!fmeter_dev_ptr)
> +		return 0;
> +
> +	if (fmeter_dev_ptr->version == 1)
> +		return fmeter_v1(dramc_dev_ptr);
> +	return 0;
> +}
> +EXPORT_SYMBOL(mtk_dramc_get_data_rate);

NAK, not used.

> +
> +static int dramc_remove(struct platform_device *pdev)
> +{
> +	dramc_pdev = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dramc_of_ids[] = {
> +	{.compatible = "mediatek,common-dramc",},
> +	{}
> +};
> +
> +static struct platform_driver dramc_drv = {
> +	.probe = dramc_probe,
> +	.remove = dramc_remove,
> +	.driver = {
> +		.name = "dramc_drv",
> +		.owner = THIS_MODULE,

NAK. You sent us 10 year old code, which means you replicated all the
bugs, issues and old-coding styles existing 10 years ago.

Start *FROM SCRATCH* from the newest driver, so you won't send us same
junk we already fixed during last 10 years.


> +		.of_match_table = dramc_of_ids,
> +	},
> +};
> +
> +static int __init dramc_drv_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&dramc_drv);
> +	if (ret) {
> +		pr_info("%s: init fail, ret 0x%x\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +module_init(dramc_drv_init);

No, just module_platform_driver

> +
> +MODULE_AUTHOR("Mediatek Corporation");
> +MODULE_DESCRIPTION("MediaTek DRAMC Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/soc/mediatek/mtk-dramc.h b/include/linux/soc/mediatek/mtk-dramc.h
> new file mode 100644
> index 000000000000..95e7dbfe7d0e
> --- /dev/null
> +++ b/include/linux/soc/mediatek/mtk-dramc.h

Move everything into driver.

> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_DRAMC_H__
> +#define __MTK_DRAMC_H__
> +
> +struct reg_ctrl_t {
> +	unsigned int offset;
> +	unsigned int mask;
> +	unsigned int shift;
> +};
> +
> +struct fmeter_dev_t {
> +	unsigned int version;
> +	unsigned int crystal_freq;
> +	unsigned int shu_of;
> +	struct reg_ctrl_t shu_lv;
> +	struct reg_ctrl_t pll_id;
> +	struct reg_ctrl_t sdmpcw[2];
> +	struct reg_ctrl_t posdiv[2];
> +	struct reg_ctrl_t fbksel[2];
> +	struct reg_ctrl_t dqsopen[2];
> +	struct reg_ctrl_t async_ca[2];
> +	struct reg_ctrl_t dq_ser_mode[2];
> +};
> +
> +struct dramc_dev_t {
> +	unsigned int support_ch_cnt;
> +	void __iomem **dramc_chn_base_ao;
> +	void __iomem **dramc_chn_base_nao;
> +	void __iomem **ddrphy_chn_base_ao;
> +	void __iomem **ddrphy_chn_base_nao;
> +	void __iomem *sleep_base;
> +	void *fmeter_dev_ptr;
> +};
> +
> +unsigned int mtk_dramc_get_data_rate(void);


Drop, unused.

> +
> +#endif /* __MTK_DRAMC_H__ */


Best regards,
Krzysztof

