Return-Path: <linux-kernel+bounces-227240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC3914DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6401B21551
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985513D521;
	Mon, 24 Jun 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azm+95N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49613A3F4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234224; cv=none; b=QCfnpGuYPc10SBnrLCCE1J77FQKBdMBozDsdvQ5J5Fnb4jVwObrh6VzEVIxbczrHGkxqHTu3eDnmVJy0lEFMlrEI7/uZ3y5iiol/Gfl1jse2y2Mfcmo46Evb59ubZgEnAZ8UMQ/3uDNEoehmwOPUj7kTFnOefjcHHIoG2KB53LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234224; c=relaxed/simple;
	bh=C3Q5DK6TNILzpVXRTgf8TUgPn26tkA9li9PG5wh8BTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6YdfXxkdmGN6tUfysx64WwHuVSRuofzRvRlq3SukEUhQ7Cbpk0pGpTqKRykJiEAqqV8eBoDcQV8EBB059sVpOjdXsfrjVWM4tMf+nYFKU1MqY00s0x5SRS2eZVN2KDZ1mVfALkuzy8h9JgGkDdSDFVMN56m7sSYp8wqiZdtaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azm+95N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB54C2BBFC;
	Mon, 24 Jun 2024 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719234224;
	bh=C3Q5DK6TNILzpVXRTgf8TUgPn26tkA9li9PG5wh8BTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azm+95N+JH112xDShF9/qM9hFFN9aBa7g/Qf/5mN5cZs06EwnZn2ZiRXRQbdv9EAd
	 qhjSVa4n7E0uqA28yoVj7ijQK98dRqD+6EnpOvfWXz65A4yRjnltZX88V77+Pp1kxX
	 6/+GvIeUpywNjfC37NFWiiLbsCOiI+iOHmCGktyLyntyTMX/yzHA1SKskxLYykDLwC
	 osg/qVULJAs8wrVyFMSuqla+cC6Sen01Ph61YTdbVZ6RLl1hHjM28rIEeUducdnfI5
	 UW3PqGRHwV2k9Amx7aIYO8gX+QGi5oMJUA9ErNgzOWWGSa1fgVdVJSVaN9mWl3IUMW
	 RO8zSlJ0KC7Sg==
Message-ID: <a11f009d-b3af-4837-8e00-17a5349f9518@kernel.org>
Date: Mon, 24 Jun 2024 23:03:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: Add support for M5441x NFC
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Stefan Agner <stefan@agner.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean-Michel,

On 21/6/24 02:25, Jean-Michel Hautbois wrote:
> The vf610_nfc driver is also the one which should be used for the
> coldfire series. Sadly, these device don't support device-tree and so we
> need to do a few modifications:
> - Adapt the probe to use pdata if available
> - Add a new variant as there is a small part to adapt in
>    vf610_nfc_select_target()
> - Add the corresponding missing register definitions
> 
> Tested successfully on a 54418 custom board with a raw NAND:
> [    2.640000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
> [    2.650000] nand: Micron MT29F4G08ABADAWP
> [    2.650000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   arch/m68k/include/asm/m5441xsim.h |  7 ++++

I can take this ColdFire part via the m68knommu/coldfire tree if you like?

Regards
Greg


>   drivers/mtd/nand/raw/Kconfig      |  2 +-
>   drivers/mtd/nand/raw/vf610_nfc.c  | 79 ++++++++++++++++++++++++++++++++++-----
>   3 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> index f48cf63bd782..d4ee1eab7c4a 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -99,6 +99,7 @@
>   #define MCFINT2_PIT1		14
>   #define MCFINT2_PIT2		15
>   #define MCFINT2_PIT3		16
> +#define MCFINT2_NFC		25
>   #define MCFINT2_RTC		26
>   
>   /*
> @@ -333,4 +334,10 @@
>   #define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
>   #define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
>   
> +/*
> + * Flash module
> + */
> +#define MCF_NFC_BASE		0xfc0fc000
> +#define MCF_NFC_SIZE		(0xfc0fff3b - 0xfc0fc000)
> +#define MCF_NFC_ISR		(MCFINT2_VECBASE + MCFINT2_NFC)
>   #endif /* m5441xsim_h */
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index cbf8ae85e1ae..2ea3ee32a540 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -252,7 +252,7 @@ config MTD_NAND_FSL_UPM
>   
>   config MTD_NAND_VF610_NFC
>   	tristate "Freescale VF610/MPC5125 NAND controller"
> -	depends on (SOC_VF610 || COMPILE_TEST)
> +	depends on (SOC_VF610 || COMPILE_TEST || M5441x)
>   	depends on HAS_IOMEM
>   	help
>   	  Enables support for NAND Flash Controller on some Freescale
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index f31d23219f91..06f1ed5433c8 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -146,6 +146,7 @@
>   
>   enum vf610_nfc_variant {
>   	NFC_VFC610 = 1,
> +	NFC_M54418 = 2,
>   };
>   
>   struct vf610_nfc {
> @@ -486,10 +487,24 @@ static void vf610_nfc_select_target(struct nand_chip *chip, unsigned int cs)
>   	if (nfc->variant != NFC_VFC610)
>   		return;
>   
> -	tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
> -	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
> -	tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
> -	tmp |= BIT(cs) << ROW_ADDR_CHIP_SEL_SHIFT;
> +	if (nfc->variant == NFC_M54418) {
> +		/*
> +		 * According to the Reference Manual:
> +		 * bit 24: Reserved, must be set (ROW_ADDR_CHIP_SEL_SHIFT)
> +		 * bit 25-27: Reserved, must be cleared
> +		 * bit 28: Reserved, must be set (ROW_ADDR_CHIP_SEL_RB_SHIFT)
> +		 * bit 29-31: Reserved, must be cleared
> +		 */
> +		tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
> +		tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_SHIFT;
> +	} else {
> +		tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
> +		tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
> +		tmp |= BIT(cs) << ROW_ADDR_CHIP_SEL_SHIFT;
> +	}
>   
>   	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
>   }
> @@ -700,11 +715,26 @@ static int vf610_nfc_write_oob(struct nand_chip *chip, int page)
>   	return nand_prog_page_end_op(chip);
>   }
>   
> +#ifdef CONFIG_OF
>   static const struct of_device_id vf610_nfc_dt_ids[] = {
>   	{ .compatible = "fsl,vf610-nfc", .data = (void *)NFC_VFC610 },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, vf610_nfc_dt_ids);
> +#endif
> +
> +static const struct platform_device_id vf610_nfc_id_table[] = {
> +	{
> +		.name = "mcf5441x-nfc",
> +		.driver_data = (kernel_ulong_t)NFC_M54418,
> +	}, {
> +		.name = "vf610-nfc",
> +		.driver_data = (kernel_ulong_t)NFC_VFC610,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(platform, vf610_nfc_id_table);
>   
>   static void vf610_nfc_preinit_controller(struct vf610_nfc *nfc)
>   {
> @@ -810,6 +840,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>   	struct vf610_nfc *nfc;
>   	struct mtd_info *mtd;
>   	struct nand_chip *chip;
> +	struct nand_chip *pdata;
>   	struct device_node *child;
>   	int err;
>   	int irq;
> @@ -820,30 +851,53 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>   
>   	nfc->dev = &pdev->dev;
>   	chip = &nfc->chip;
> +	pdata = dev_get_platdata(&pdev->dev);
> +	if (pdata)
> +		*chip = *pdata;
> +
>   	mtd = nand_to_mtd(chip);
>   
>   	mtd->owner = THIS_MODULE;
>   	mtd->dev.parent = nfc->dev;
> -	mtd->name = DRV_NAME;
> +
> +	/*
> +	 * We keep the MTD name unchanged to avoid breaking platforms
> +	 * where the MTD cmdline parser is used and the bootloader
> +	 * has not been updated to use the new naming scheme.
> +	 */
> +	if (!nfc->dev->of_node)
> +		mtd->name = "NAND";
> +	else
> +		mtd->name = DRV_NAME;
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
>   		return irq;
>   
>   	nfc->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(nfc->regs))
> +	if (IS_ERR(nfc->regs)) {
> +		dev_err(nfc->dev, "Unable to map registers!\n");
>   		return PTR_ERR(nfc->regs);
> +	}
>   
> +#ifdef CONFIG_OF
>   	nfc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(nfc->clk)) {
>   		dev_err(nfc->dev, "Unable to get and enable clock!\n");
>   		return PTR_ERR(nfc->clk);
>   	}
>   
> -	nfc->variant = (enum vf610_nfc_variant)device_get_match_data(&pdev->dev);
> -	if (!nfc->variant)
> -		return -ENODEV;
> +	const void *data = device_get_match_data(&pdev->dev);
>   
> +	nfc->variant = (enum vf610_nfc_variant)data;
> +	if (!nfc->variant) {
> +		dev_err(nfc->dev, "No variant data found!\n");
> +		return -ENODEV;
> +	}
> +#else
> +	nfc->variant = (enum vf610_nfc_variant)platform_get_device_id(pdev)->driver_data;
> +#endif
> +#ifdef CONFIG_OF
>   	for_each_available_child_of_node(nfc->dev->of_node, child) {
>   		if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
>   
> @@ -862,6 +916,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>   		dev_err(nfc->dev, "NAND chip sub-node missing!\n");
>   		return -ENODEV;
>   	}
> +#else
> +	nfc->clk = NULL;
> +	mtd->dev.parent = &pdev->dev;
> +#endif
>   
>   	chip->options |= NAND_NO_SUBPAGE_WRITE;
>   
> @@ -937,11 +995,12 @@ static SIMPLE_DEV_PM_OPS(vf610_nfc_pm_ops, vf610_nfc_suspend, vf610_nfc_resume);
>   static struct platform_driver vf610_nfc_driver = {
>   	.driver		= {
>   		.name	= DRV_NAME,
> -		.of_match_table = vf610_nfc_dt_ids,
> +		.of_match_table = of_match_ptr(vf610_nfc_dt_ids),
>   		.pm	= &vf610_nfc_pm_ops,
>   	},
>   	.probe		= vf610_nfc_probe,
>   	.remove_new	= vf610_nfc_remove,
> +	.id_table = vf610_nfc_id_table,
>   };
>   
>   module_platform_driver(vf610_nfc_driver);
> 
> ---
> base-commit: e5b3efbe1ab1793bb49ae07d56d0973267e65112
> change-id: 20240620-upstream-nfc-mcf5441x-82e23b45e286
> 
> Best regards,

