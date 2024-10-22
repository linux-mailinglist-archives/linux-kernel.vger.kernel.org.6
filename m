Return-Path: <linux-kernel+bounces-375447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06B9A960E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F24AB214D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FDD12D773;
	Tue, 22 Oct 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEIK9zfH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801921E51D;
	Tue, 22 Oct 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563184; cv=none; b=m8ROm+S6akCzejyysRihUxPfI4Brh+9/gSp0Jyb4+X7B8bIm4M9GfvvMZfB7LQRikm/htjhdAE7n0Z1RpNMXrLu5TEzbuWfr+WI5rtJfm79YH3cuS3DMYYkgDGjhj97tHbgfFCM2vDl8eDLaACGFTyaZGeh2Z4I4dW770GQ0f9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563184; c=relaxed/simple;
	bh=2nukBzroJm/mhADGUaWldWPLXlkYJIS1QC74b76bY5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th2/JZOrVfY64ZksURLGOH5eoMYhD6pceHRQJ8Zax2wa4TklqXPxClbXWrG9hnC+ZQXloquW2G20KItGEYzhxM3AR+sCnPnCwcQhQWSzcLpGMeFM6VrvYzYS1m7jBPl9P/OLc4qzvIM3bV9jEAJsqMKiOZoLKg1s5smb3wzWHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEIK9zfH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so3411934b3a.0;
        Mon, 21 Oct 2024 19:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563182; x=1730167982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=959zJs+apCi2YZRJyiT2z5+atVYc4w5o2OLI4DZBUOg=;
        b=ZEIK9zfH7cTvxHtnKgjPE/7nVITSTNDY51Ov4nyCQ7QKmlPnO0/p9VPQHKLr4htTsj
         vVShTYo8w+rj9OtjKq1/SvL0EmTK96Zk4wrFuUBOPJOYnAOl2rIawPR0+XbFpZpeBO2Z
         3sKSNzetzSSOJIT5rfFEpDQfnBV6xdIlN8FLzsrQzVlWGhkHWNPvY2nECcNftZUdhZLk
         Tw2jvQxT/E0YjW8Zv+9wUdSt8g6xhNoiy2bhyZeRnYEqK3HQ1i+GQf4VNIeHgzWXS/N8
         0PJgIaYKhkmN8zhaxVOjFfSiopPik707rEz1fhUyWFe3nyfWz/T58F/OqvQ4uJz1N5RJ
         MurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563182; x=1730167982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=959zJs+apCi2YZRJyiT2z5+atVYc4w5o2OLI4DZBUOg=;
        b=X3yDZurbUQ17MkcyhRtdIaPIRVMvix+ZK8d5D+ws6OGIZEuxNSB46AOnbZbfYOuMuf
         UCNRmDiwWv5X3sA2xqFkzuctzounlNwccIEdwOXmSvPz0hmE+9wDWmE+PjvTW13ssMOc
         JTdqypZxRJUNGhKBXSufnykV+8hmRcFMfbFNDO+iQ6zxFcC03HQs0hCKROnvUm5IPk0M
         Cz4Yy0qKnpuBKWgA8XwLv5j7K8pvGnGSw1LS/SaCIjwFQUHdHTborvRCGX15tzzmToEq
         /W9dHyPvduhqbFHS9gfhqOQxmNwcQF4QzfKR0DnZNATSz7/hDJgnoS6G5SHldtYe8Q8u
         Ek0g==
X-Forwarded-Encrypted: i=1; AJvYcCXP0wPx8hmRuvCijz4F4vmL3OP0Ug95SBEjVbsE47iTxQ3SL4KuTJnIMSYz7mSQePewALgUp8krB6H8tzfK@vger.kernel.org, AJvYcCXdvLae6DegtZr3cg9WJxck7FHXtUpRNZJ/6V1qTDWCFroHpi2TpqeSTvwkDqyAFXqKHIcmDGYKS2+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39KItKVip/hHb9/drL+vsyhSaXz79lzkVf8L4XEstGWMh2Xwy
	1a/XCgKvsLMTJL6B43arkkkY/eQXFL0fr+xt/YR7EcSMPERvezve
X-Google-Smtp-Source: AGHT+IFLLC+yuPPzq9LAuUhveL/p4XBvgSvD4LS+OBJ0ihSrfZQIwC9lM4In6zU8WiHvsUkBKjNQHw==
X-Received: by 2002:a05:6a00:2e04:b0:71e:72b5:3094 with SMTP id d2e1a72fcca58-71ea33d2ea0mr19598845b3a.28.1729563181480;
        Mon, 21 Oct 2024 19:13:01 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffadsm3587779b3a.52.2024.10.21.19.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 19:13:01 -0700 (PDT)
Message-ID: <9cfd923a-4bc8-4a6c-986d-8d0c6fd6d9bb@gmail.com>
Date: Tue, 22 Oct 2024 10:12:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
 <20241018022519.721914-3-hpchen0nvt@gmail.com>
 <20241021103254.1f31205b@xps-13>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <20241021103254.1f31205b@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.


On 2024/10/21 下午 04:44, Miquel Raynal wrote:
> Hi Hui-Ping,
>
> hpchen0nvt@gmail.com wrote on Fri, 18 Oct 2024 02:25:19 +0000:
>
>> Nuvoton MA35 SoCs NAND Flash Interface Controller
>> supports 2kiB, 4kiB and 8kiB page size, and up to
>> 8-bit, 12-bit, and 24-bit hardware ECC calculation
>> circuit to protect data.
>>
>> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig               |   8 +
>>   drivers/mtd/nand/raw/Makefile              |   1 +
>>   drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c | 919 +++++++++++++++++++++
>>   3 files changed, 928 insertions(+)
>>   create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index d0aaccf72d78..e3677bcaf035 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -454,6 +454,14 @@ config MTD_NAND_TS72XX
>>   	help
>>   	  Enables support for NAND controller on ts72xx SBCs.
>>   
>> +config MTD_NAND_NUVOTON_MA35
>> +	tristate "Nuvoton MA35 SoC NAND controller"
>> +	depends on ARCH_MA35 || COMPILE_TEST
>> +	depends on OF
>> +	help
>> +	  Enables support for the NAND controller found on
>> +	  the Nuvoton MA35 series SoCs.
>> +
>>   comment "Misc"
>>   
>>   config MTD_SM_COMMON
>> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
>> index d0b0e6b83568..cc24955627f8 100644
>> --- a/drivers/mtd/nand/raw/Makefile
>> +++ b/drivers/mtd/nand/raw/Makefile
>> @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_INTEL_LGM)	+= intel-nand-controller.o
>>   obj-$(CONFIG_MTD_NAND_ROCKCHIP)		+= rockchip-nand-controller.o
>>   obj-$(CONFIG_MTD_NAND_PL35X)		+= pl35x-nand-controller.o
>>   obj-$(CONFIG_MTD_NAND_RENESAS)		+= renesas-nand-controller.o
>> +obj-$(CONFIG_MTD_NAND_NUVOTON_MA35)	+= nuvoton_ma35d1_nand.o
> Can we name this file like the others? nuvoton-ma35d1-nand-controller.c?
>
Sure, I will change it to a similar name.


> [...]
>
>> +static void ma35_nand_hwecc_init(struct nand_chip *chip, struct ma35_nand_info *nand)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	u32 reg;
>> +
>> +	/* Redundant area size */
>> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
>> +
>> +	/* Protect redundant 3 bytes */
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL);
>> +	reg |= (PROT3BEN | ECC_CHK);
>> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
>> +
>> +	if (chip->ecc.strength == 0) {
>> +		/* Disable H/W ECC, ECC parity check enable bit during read page */
>> +		reg = readl(nand->regs + MA35_NFI_REG_NANDCTL);
>> +		writel(reg & ~ECC_EN, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	} else {
>> +		/* Set BCH algorithm */
>> +		reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & ~BCH_MASK;
>> +		if (chip->ecc.strength <= 8)
>> +			writel(reg | BCH_T8, nand->regs + MA35_NFI_REG_NANDCTL);
>> +		else if (chip->ecc.strength <= 12)
>> +			writel(reg | BCH_T12, nand->regs + MA35_NFI_REG_NANDCTL);
>> +		else if (chip->ecc.strength <= 24)
>> +			writel(reg | BCH_T24, nand->regs + MA35_NFI_REG_NANDCTL);
> You should use a switch case here, and refuse strength you cannot
> achieve.

Got it. I will change it to a switch case, handle unsupported strengths, 
and display dev_err.


>> +
>> +		/* Enable H/W ECC, ECC parity check enable bit during read page */
>> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | ECC_EN,
>> +			nand->regs + MA35_NFI_REG_NANDCTL);
>> +	}
>> +}
> [...]
>
>> +static int ma35_nfi_ecc_check(struct nand_chip *chip, u8 *addr)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	int i, j, nchunks = 0;
>> +	int report_err = 0;
>> +	int err_cnt = 0;
>> +	u32 status;
>> +
>> +	nchunks = mtd->writesize / chip->ecc.steps;
>> +	if (nchunks < 4)
>> +		nchunks = 1;
>> +	else
>> +		nchunks /= 4;
> This should be part of your initial configuration and be done once for
> all.

Okay, I will log this information during initialization.


>> +
>> +	for (j = 0; j < nchunks; j++) {
>> +		status = readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
>> +		if (!status)
>> +			continue;
>> +
>> +		for (i = 0; i < 4; i++) {
>> +			if ((status & ECC_STATUS_MASK) == 0x01) {
>> +				/* Correctable error */
>> +				err_cnt = (status >> 2) & ECC_ERR_CNT_MASK;
>> +				ma35_nfi_correct(chip, j * 4 + i, err_cnt, addr);
>> +				report_err += err_cnt;
> Please look at other drivers implementation, you should report two
> statistics: the total number of bf, also the maximum number of bf in a
> single ECC chunk (which give indications to upper layers on whether
> they should consider re-writing the data or not).

Okay, I will correct this return value.


>> +			} else {
>> +				/* Uncorrectable error */
>> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
>> +				return -EBADMSG;
>> +			}
>> +			status >>= 8;
>> +		}
>> +	}
>> +	return report_err;
>> +}
>> +
>> +static void ma35_nand_dmac_init(struct ma35_nand_info *nand)
>> +{
>> +	/* DMAC reset and enable */
>> +	writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
>> +	writel(DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
>> +
>> +	/* Clear DMA finished flag and enable */
>> +	writel(INT_DMA | INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
>> +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
>> +}
> [...]
>
>> +
>> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>> +				      int oob_required, int page)
>> +{
> The hardware ECC engine should always be disabled by default.
>
> Then, in these helpers you should:
> * enable the ECC engine
> * do your things
> * disable the ECC engine

The ECC engine of the MA35 NAND controller cannot be turned on or off 
separately.

The ECC engine is activated with the DMA,

and it calculates and writes to the OOB during the transfer.


>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +
>> +	ma35_nand_target_enable(chip, chip->cur_cs);
>> +
>> +	ma35_clear_spare(chip, mtd->oobsize);
>> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
>> +			(u32 *)chip->oob_poi);
>> +
>> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> +	ma35_nand_do_write(chip, buf, mtd->writesize);
>> +	nand_prog_page_end_op(chip);
>> +
>> +	ma35_read_spare(chip, chip->ecc.total,
>> +			(u32 *)(chip->oob_poi + (mtd->oobsize - chip->ecc.total)),
>> +			mtd->oobsize - chip->ecc.total);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
>> +					int oob_required, int page)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	int bitflips = 0;
>> +	u32 reg;
>> +
>> +	ma35_nand_target_enable(chip, chip->cur_cs);
>> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
>> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
>> +
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
>> +	if (PREFIX_RA_IS_EMPTY(reg)) {
>> +		memset((void *)buf, 0xff, mtd->writesize);
>> +	} else {
>> +		nand_read_page_op(chip, page, 0, NULL, 0);
>> +		bitflips = ma35_nand_do_read(chip, buf, mtd->writesize);
>> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0);
>> +	}
>> +
>> +	return bitflips;
>> +}
>> +
>> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	u32 reg;
>> +
>> +	ma35_nand_target_enable(chip, chip->cur_cs);
>> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
>> +
>> +	/* copy OOB data to controller redundant area for page read */
>> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
>> +
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
>> +	if (PREFIX_RA_IS_EMPTY(reg))
>> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void ma35_hw_init(struct ma35_nand_info *nand)
>> +{
>> +	u32 reg;
>> +
>> +	/* Disable flash wp. */
>> +	writel(DISABLE_WP, nand->regs + MA35_NFI_REG_NANDECTL);
>> +
>> +	/* resets the internal state machine and counters */
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL);
>> +	reg |= SWRST;
>> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
> Make sure the ECC engine is disabled here.

The ECC engine is activated by the DMA, so it is in a disabled state at 
this time.


>> +}
>> +
>> +static irqreturn_t ma35_nand_irq(int irq, void *id)
>> +{
>> +	struct ma35_nand_info *nand = (struct ma35_nand_info *)id;
>> +	u32 isr;
>> +
>> +	isr = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
>> +	if (isr & INT_DMA) {
>> +		writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
>> +		complete(&nand->complete);
>> +	}
>> +
>> +	return IRQ_HANDLED;
> Should you return IRQ_NONE if (isr & INT_DMA) == 0 ?

Okay, I will add return IRQ_NONE.


>> +}
>> +
>> +static int ma35_nand_attach_chip(struct nand_chip *chip)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct device *dev = mtd->dev.parent;
>> +	u32 reg;
>> +
>> +	if (chip->options & NAND_BUSWIDTH_16) {
>> +		dev_err(dev, "16 bits bus width not supported");
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;
> Why not supporting subpage writes? Your controller does not seem to not
> support them. They are really useful to make your device last longer.

The main issue is related to ECC parity calculation.

Since the built-in DMA operates on a page basis, and the ECC parity is 
calculated

and written simultaneously, it does not support subpage writes.

I will move the option to ON_HOST.


>> +
>> +	switch (chip->ecc.engine_type) {
>> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
>> +		chip->ecc.write_page = ma35_nand_write_page_hwecc;
>> +		chip->ecc.read_page  = ma35_nand_read_page_hwecc;
>> +		chip->ecc.read_oob   = ma35_nand_read_oob_hwecc;
>> +		break;
>> +	case NAND_ECC_ENGINE_TYPE_NONE:
>> +	case NAND_ECC_ENGINE_TYPE_SOFT:
>> +	case NAND_ECC_ENGINE_TYPE_ON_DIE:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
>> +	if (mtd->writesize == 2048)
>> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 4096)
>> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 8192)
>> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +
>> +	chip->ecc.steps = mtd->writesize / chip->ecc.size;
>> +	if (chip->ecc.strength == 0) {
>> +		chip->ecc.total = 0;
>> +	} else if (chip->ecc.strength <= 8) {
>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH8;
>> +	} else if (chip->ecc.strength <= 12) {
>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH12;
>> +	} else if (chip->ecc.strength <= 24) {
>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH24;
>> +	} else {
>> +		dev_err(dev, "ECC strength unsupported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip->ecc.bytes = chip->ecc.total / chip->ecc.steps;
>> +
>> +	ma35_nand_hwecc_init(chip, nand);
> This should only be done in the ON_HOST case.

I will move the ECC-related settings to the ON_HOST case.


>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35_nfc_exec_instr(struct nand_chip *chip,
>> +			      const struct nand_op_instr *instr)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	unsigned int i;
>> +	u32 status;
>> +
>> +	switch (instr->type) {
>> +	case NAND_OP_CMD_INSTR:
>> +		writel(instr->ctx.cmd.opcode, nand->regs + MA35_NFI_REG_NANDCMD);
>> +		return 0;
>> +	case NAND_OP_ADDR_INSTR:
>> +		for (i = 0; i < instr->ctx.addr.naddrs; i++) {
>> +			if (i == (instr->ctx.addr.naddrs - 1))
>> +				writel(instr->ctx.addr.addrs[i] | ENDADDR,
>> +					nand->regs + MA35_NFI_REG_NANDADDR);
>> +			else
>> +				writel(instr->ctx.addr.addrs[i],
>> +					nand->regs + MA35_NFI_REG_NANDADDR);
>> +		}
>> +		return 0;
>> +	case NAND_OP_DATA_IN_INSTR:
>> +		ma35_nand_do_read(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
>> +		return 0;
>> +	case NAND_OP_DATA_OUT_INSTR:
>> +		ma35_nand_do_write(chip, instr->ctx.data.buf.out, instr->ctx.data.len);
>> +		return 0;
>> +	case NAND_OP_WAITRDY_INSTR:
>> +		return readl_poll_timeout(nand->regs + MA35_NFI_REG_NANDINTSTS, status,
>> +					  status & INT_RB0, 20,
>> +					  instr->ctx.waitrdy.timeout_ms * MSEC_PER_SEC);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
> I would save the return value when there is one and just call
>
> 	return ret;
>
> at the end.

Okay, I will handle the return value.


>> +}
>> +
>> +static int ma35_nfc_exec_op(struct nand_chip *chip,
>> +			  const struct nand_operation *op,
>> +			  bool check_only)
>> +{
>> +	int ret = 0;
>> +	u32 i;
>> +
>> +	if (check_only)
>> +		return 0;
>> +
>> +	ma35_nand_target_enable(chip, op->cs);
>> +
>> +	for (i = 0; i < op->ninstrs; i++) {
>> +		ret = ma35_nfc_exec_instr(chip, &op->instrs[i]);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct nand_controller_ops ma35_nfc_ops = {
>> +	.attach_chip = ma35_nand_attach_chip,
>> +	.exec_op = ma35_nfc_exec_op,
>> +};
>> +
>> +static int ma35_nand_chip_init(struct device *dev, struct ma35_nand_info *nand,
>> +				 struct device_node *np)
>> +{
>> +	struct ma35_nand_chip *nvtnand;
>> +	struct nand_chip *chip;
>> +	struct mtd_info *mtd;
>> +	int nsels;
>> +	u32 tmp;
>> +	int ret;
>> +	int i;
>> +
>> +	if (!of_get_property(np, "reg", &nsels))
>> +		return -ENODEV;
>> +
>> +	nsels /= sizeof(u32);
>> +	if (!nsels || nsels > MA35_MAX_NSELS) {
>> +		dev_err(dev, "invalid reg property size %d\n", nsels);
>> +		return -EINVAL;
>> +	}
>> +
>> +	nvtnand = devm_kzalloc(dev, struct_size(nvtnand, sels, nsels),
>> +			      GFP_KERNEL);
>> +	if (!nvtnand)
>> +		return -ENOMEM;
>> +
>> +	nvtnand->nsels = nsels;
>> +	for (i = 0; i < nsels; i++) {
>> +		ret = of_property_read_u32_index(np, "reg", i, &tmp);
>> +		if (ret) {
>> +			dev_err(dev, "reg property failure : %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		if (tmp >= MA35_MAX_NSELS) {
>> +			dev_err(dev, "invalid CS: %u\n", tmp);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (test_and_set_bit(tmp, &nand->assigned_cs)) {
>> +			dev_err(dev, "CS %u already assigned\n", tmp);
>> +			return -EINVAL;
>> +		}
>> +
>> +		nvtnand->sels[i] = tmp;
>> +	}
>> +
>> +	chip = &nvtnand->chip;
>> +	chip->controller = &nand->controller;
>> +
>> +	nand_set_flash_node(chip, np);
>> +	nand_set_controller_data(chip, nand);
>> +
>> +	mtd = nand_to_mtd(chip);
>> +	mtd->owner = THIS_MODULE;
>> +	mtd->dev.parent = dev;
>> +
>> +	mtd_set_ooblayout(mtd, &ma35_ooblayout_ops);
>> +	ma35_hw_init(nand);
> This is a chip called as many times as there are chips connected to the
> host, so the controller initialization should not be here (see below).

Okay, I will move it to the probe.


>> +	ret = nand_scan(chip, nsels);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = mtd_device_register(mtd, NULL, 0);
>> +	if (ret) {
>> +		dev_err(dev, "MTD parse partition error\n");
>> +		nand_cleanup(chip);
>> +		return ret;
>> +	}
>> +
>> +	list_add_tail(&nvtnand->node, &nand->chips);
>> +
>> +	return 0;
>> +}
>
>
>> +static int ma35_nand_probe(struct platform_device *pdev)
>> +{
>> +	struct ma35_nand_info *nand;
>> +	int ret = 0;
>> +
>> +	nand = devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
>> +	if (!nand)
>> +		return -ENOMEM;
>> +
>> +	nand_controller_init(&nand->controller);
>> +	INIT_LIST_HEAD(&nand->chips);
>> +	nand->controller.ops = &ma35_nfc_ops;
>> +
>> +	init_completion(&nand->complete);
>> +
>> +	nand->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(nand->regs))
>> +		return PTR_ERR(nand->regs);
>> +
>> +	nand->dev = &pdev->dev;
>> +
>> +	nand->clk = devm_clk_get_enabled(&pdev->dev, "nand_gate");
>> +	if (IS_ERR(nand->clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(nand->clk),
>> +				     "failed to find NAND clock\n");
>> +
>> +	nand->irq = platform_get_irq(pdev, 0);
>> +	if (nand->irq < 0)
>> +		return dev_err_probe(&pdev->dev, nand->irq,
>> +				     "failed to get platform irq\n");
>> +
>> +	ret = devm_request_irq(&pdev->dev, nand->irq, ma35_nand_irq,
>> +				  IRQF_TRIGGER_HIGH, "ma35d1-nand", nand);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to request NAND irq\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, nand);
>> +
>> +	writel(GRST | NAND_EN, nand->regs + MA35_NFI_REG_GCTL);
> I'd call the hw_init() of the controller here, before going through the
> chips init.

Okay, I will move hw_init() here.


>> +	ret = ma35_nand_chips_init(&pdev->dev, nand);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to init NAND chips\n");
>> +		clk_disable(nand->clk);
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen



