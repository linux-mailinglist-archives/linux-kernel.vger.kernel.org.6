Return-Path: <linux-kernel+bounces-356103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B306D995C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408F31F24635
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2611CA9;
	Wed,  9 Oct 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpHu+/Fm"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A91367;
	Wed,  9 Oct 2024 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435321; cv=none; b=ZPSgDd04a4rbEi/7h+9Q2mEu52xgUJ4Y9SnezftjhwG7nqRG/q4D46YvfyoFuZqHZH1JA8WNnMhTxyarbLlAieooejN/LgtHnwffqQkmaq6IDMW0ctqBq/8KR2R2lPsscG/H7H2nPKphBaT4HEYqSVwvFMGJSC/kilZe95ULig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435321; c=relaxed/simple;
	bh=RioABCkDq8Sp8eUMRK8aLU6fXo1bwPzffAvOum24JWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKnR5GBoT0sTXsTCplarjRCvDOjckRZbekEpTkl70s7yGsUpXIKtYrKFmB1W/mYtcqUdNXBK5r/MblsK+cbs43OS+fMweSd41qtSEvaxurznql8jocGVPm/+aJSqQlRwbBrSNrxmM6813k8hWf89PcsGmSscjg13/ZIBhUosFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpHu+/Fm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so1920413a12.0;
        Tue, 08 Oct 2024 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728435319; x=1729040119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0NvT6Plc7CWUrIL+PDPW+ulJnaC3d7wC4XPns7aXl4=;
        b=GpHu+/FmqR7gDKcfv2iHBO3LBpRTToNmI95BpuztFlJOd/CmXKDX3KiN5527RYx5t7
         PqLyu03CXZn3BPAboZX4wRoCsOFCj/n+FGnHBnYIWu6uCrOioYviSR5LDgz2rOkwBE2m
         rh6wMmigh5homU7rDlmWIqrmmwjeC8b4RYvfDq0kdUQ0o56dYQyPyu+4sjOph30l6I9y
         Z2/rcXaUW7Zu1HJ5H0KeMkA4XB3np567kr+qSHyHC3h1eXmPOthZQGnjgC81SSA9Buoa
         h9tQJ+tQngCwG7YiTeLmaVOoKOJZxqHt/e9HewsyHPOnX7xj9/0IjP0hugQ6atxv6hqY
         a5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435319; x=1729040119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0NvT6Plc7CWUrIL+PDPW+ulJnaC3d7wC4XPns7aXl4=;
        b=qS996FKVtp5mab68ajfaNrqmcz8h5jNerf0ISBf+qSJR/8j/kTpJsnFzC8ADXQroPq
         7ReVm76berk0wfyXpTQp0ayzfpFvEM1KgqKE+fuYsTDInXjc6Q7uAYlNzeC83UZqLMLP
         380+6fi9SWT9CtSm6apn5LfZBXe1ccYETJ+iGRlBg2uIuCewBjNbkq+A7NIR/5esQMS7
         BG0dAJ49vT2zNyG+vsmA/9frcLxNaPhRzBu68OyC7UJbiA/VQ5KtJXmiiGr7oHmViiAp
         TnND7+C985rvFEbzXSSWJlvHUDaiwyHVgGSqSxG7fPPJ8228DCsCk1rhxFFXSR2V2gc1
         mF8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKFlaK8HcEgrnP9lMHjjIsR3u2t+22e91+ZQH7p/4/7bfHrZF+FRagIF8e/m4eR3ZR3/qvD0YgTKG6Dohm@vger.kernel.org, AJvYcCVW8khZ1oxIK/DWUL0qfZu6nr7luyhVezAMb+Qzr7vcS+hWQ9WdvRYCtfaVnRC4FDzFhJPqZ5ovyVj2@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5MpsPL7yGyxFkybTpZJGh/R2BTYQU0QlQCVw6dFCtweN9rVh
	medmEJcoG6dWkjWMVTQ3IXomJrE1IdXX8E6RyZyxtyDBo21Uu/eM
X-Google-Smtp-Source: AGHT+IGgdPci5tGpUoy9qJpLoTxEnoy7M88f2wWdzVnzaH0MvgESF9Yr8nEj/m+NskSqeNXA93FS3w==
X-Received: by 2002:a05:6a21:9102:b0:1d2:ba9c:6d9f with SMTP id adf61e73a8af0-1d8a3bfec3amr1518239637.17.1728435318500;
        Tue, 08 Oct 2024 17:55:18 -0700 (PDT)
Received: from [172.19.1.53] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66475sm6969202b3a.149.2024.10.08.17.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 17:55:18 -0700 (PDT)
Message-ID: <02098767-19ce-407e-88be-24c6259c4053@gmail.com>
Date: Wed, 9 Oct 2024 08:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
 <20240927020749.46791-3-hpchen0nvt@gmail.com>
 <20241001215755.5c2f8465@xps-13>
 <8d5e7755-17fd-4860-bcb0-8c1de04bf0c5@gmail.com>
 <20241008105230.7fd25438@xps-13>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <20241008105230.7fd25438@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.



On 2024/10/8 下午 04:52, Miquel Raynal wrote:
> Hi Hui-Ping,
>
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	ma35_nand_dmac_init(nand);
>>>> +
>>>> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
>>>> +
>>>> +	/* setup and start DMA using dma_addr */
>>>> +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_FROM_DEVICE);
>>>> +	ret = dma_mapping_error(nand->dev, dma_addr);
>>>> +	if (ret) {
>>>> +		dev_err(nand->dev, "dma mapping error\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);
>>> Please enforce a dma mask of 32 (even though it might be the fault).
>> I will change it to dma_addr & 0xffffffff.
> That's not what I mean, I believe you should use the dma API to ask for
> a mapping within the accessible 32-bit address range. The
> dma_mapping_error() check should return an error if that's not the
> case. Then you can safely write the value.

Here is my misunderstanding: just fill in the dma_addr directly,

no type conversion is needed. I have already tested it.


>>>> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_R_EN,
>>>> +		nand->regs + MA35_NFI_REG_NANDCTL);
>>>> +	ret = wait_for_completion_timeout(&nand->complete, msecs_to_jiffies(1000));
>>>> +	if (!ret) {
>>>> +		dev_err(nand->dev, "read timeout\n");
>>>> +		ret = -ETIMEDOUT;
>>>> +	}
>>>> +
>>>> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_FROM_DEVICE);
>>>> +
>>>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
>>>> +	if (reg & INT_ECC) {
>>>> +		cnt = ma35_nfi_ecc_check(&nand->chip, addr);
>>>> +		if (cnt < 0) {
>>>> +			mtd->ecc_stats.failed++;
>>>> +			writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
>>>> +			writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | SWRST,
>>>> +				nand->regs + MA35_NFI_REG_NANDCTL);
>>>> +		} else {
>>>> +			mtd->ecc_stats.corrected += cnt;
>>>> +			nand->bitflips = cnt;
>>>> +		}
>>>> +		writel(INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>>>> +				      int oob_required, int page)
>>>> +{
>>>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>>> +	void *ecc_calc = chip->ecc.calc_buf;
>>>> +
>>>> +	ma35_clear_spare(chip, mtd->oobsize);
>>>> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
>>>> +			(u32 *)chip->oob_poi);
>>>> +
>>>> +	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
>>>> +	nand_prog_page_end_op(chip);
>>>> +
>>>> +	/* Copy parity code in NANDRA to calc */
>>>> +	ma35_read_spare(chip, chip->ecc.total, (u32 *)ecc_calc,
>>>> +			mtd->oobsize - chip->ecc.total);
>>>> +
>>>> +	/* Copy parity code in calc to oob_poi */
>>>> +	memcpy(chip->oob_poi + (mtd->oobsize - chip->ecc.total),
>>>> +		ecc_calc, chip->ecc.total);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
>>>> +					int oob_required, int page)
>>>> +{
>>>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>>>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>>> +	u32 reg;
>>>> +
>>>> +	/* read the OOB area  */
>>>> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
>>>> +	nand->bitflips = 0;
>>> Why storing this value in your structure?
>> Because ecc.read_page needs to return bit flips, it is necessary to log them.
> I believe you don't need bitflips to be part of the ma35_nand_info
> structure.

I will remove this variable and then investigate where to obtain the 
information from.



>>>> +
>>>> +	/* copy OOB data to NANDRA for page read */
>>>> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
>>>> +
>>>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
>>>> +	if (reg & 0xffff0000) {
>>>> +		memset((void *)buf, 0xff, mtd->writesize);
>>>> +	} else {
>>>> +		/* read data from nand */
>>>> +		nand_read_page_op(chip, page, 0, buf, mtd->writesize);
>>> ret =
>>> if (ret)
>>> 	...
>> I will add a return value here.
>>
>>
>>>> +
>>>> +		/* restore OOB data from SMRA */
>>>> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0);
>>> same
>> ma35_read_spare() is declared as void, with no return value.
>>
>> SMRA will be changed to NANDRA registers.
>>
>>
>>>> +	}
>>>> +
>>>> +	return nand->bitflips;
>>>> +}
>>>> +
>>>> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
>>>> +{
>>>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>>>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>>> +	u32 reg;
>>>> +
>>>> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
>>>> +
>>>> +	/* copy OOB data to NANDRA for page read */
>>> What is NANDRA? does not mean anything to me.
>> NANDRA is the Redundant Area Word of the MA35 NAND controller.
> NANDRA is specific to your controller. "redundant area" is already more
> understandable.

I will change the comment to

/* copy oob data to controller redundant area for page read */



>> The controller reads ECC parity from this area for calculations or uses the information for check.
> This is what we generically call the "ECC bytes/area" I guess?

Yes


>> I will change NANDRA to NANDRA registers.
>>
>>
>>>> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
>>>> +
>>>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
>>>> +	if (reg & 0xffff0000)
>>>> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize);
>>> What does this mean?
>> MA35 NAND controller checks oob bytes 2 and 3.
>>
>> If this page has been written, oob bytes 2 and 3 will be set to 0.
>>
>> Therefore, if bytes 2 and 3 are not 0, it indicates an empty page, and it will return 0xff.
> Ok, please define a macro for that, something along:
>
> #define PREFIX_RA_HAS_BEEN_WRITTEN(reg) FIELD_GET(GENMASK(..), (reg))
>
> if (!PREFIX_RA_HAS_BEEN_WRITTEN(reg))
> 	memset();

I will define a macro. Thank you.



>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static irqreturn_t ma35_nand_irq(int irq, void *id)
>>>> +{
>>>> +	struct ma35_nand_info *nand = (struct ma35_nand_info *)id;
>>>> +	u32 isr;
>>>> +
>>>> +	isr = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
>>>> +	if (isr & INT_DMA) {
>>>> +		writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
>>>> +		complete(&nand->complete);
>>>> +	}
>>> I guess a more future proof implementation would always writel(isr); to
>>> silence the interrupt. Otherwise of course you must call complete()
>>> only upon isr & INT_DMA.
>> This part can remove the if(), but writel(isr) is not feasible.
>>
>> The isr may contain the ECC flag, and clearing it could cause a miss in ECC handling.
>>
>> I will change it to:
>>
>>       writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
>>       complete(&nand->complete);
> In this case keep the if() but be sure to handle the timeout correctly.

OK.


>>
>>>> +
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static int ma35_nand_attach_chip(struct nand_chip *chip)
>>>> +{
>>>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>>>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>>> +	unsigned int reg;
>>>> +
>>>> +	if (chip->options & NAND_BUSWIDTH_16) {
>>>> +		dev_err(nand->dev, "16 bits bus width not supported");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* support only ecc hw mode */
>>> Why ? Please don't.
>> I will add handling for other cases.
>>
>>
>>>> +	if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST) {
>>>> +		dev_err(nand->dev, "ecc.engine_type not supported\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	nand->ecc_buf = devm_kzalloc(nand->dev, mtd->writesize + mtd->oobsize,
>>>> +					GFP_KERNEL);
>>>> +	if (!nand->ecc_buf)
>>>> +		return  -ENOMEM;
>>>> +	chip->ecc.calc_buf = nand->ecc_buf;
>>> Are you sure you need this? I don't see the point.
>> This is unnecessary; I will remove it.
>>
>>
>>>> +
>>>> +	/* Set PSize */
>>>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
>>>> +	if (mtd->writesize == 2048)
>>>> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
>>>> +	else if (mtd->writesize == 4096)
>>>> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
>>>> +	else if (mtd->writesize == 8192)
>>>> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
>>>> +
>>>> +	chip->ecc.steps = mtd->writesize / chip->ecc.size;
>>>> +	if (chip->ecc.strength == 0) {
>>>> +		nand->bch = BCH_NONE; /* No ECC */
>>>> +		chip->ecc.total = 0;
>>>> +	} else if (chip->ecc.strength <= 8) {
>>>> +		nand->bch = BCH_T8; /* T8 */
>>> bch is probably a bad name, and in general I don't see the point of
>>> saving this value. Just check the ECC strength in the above switch
>>> cases and don't use this intermediate variable.
>> I will change it to directly use ecc.strength for the check.
>>
>>
>>>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH8;
>>>> +	} else if (chip->ecc.strength <= 12) {
>>>> +		nand->bch = BCH_T12; /* T12 */
>>>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH12;
>>>> +	} else if (chip->ecc.strength <= 24) {
>>>> +		nand->bch = BCH_T24; /* T24 */
>>>> +		chip->ecc.total = chip->ecc.steps * MA35_PARITY_BCH24;
>>>> +	} else {
>>>> +		dev_warn(nand->dev, "NAND Controller is not support this flash. (%d, %d)\n",
>>>> +			mtd->writesize, mtd->oobsize);
>>> This must be a dev_err() and return an error immediately.
>>>
>>> Also the string is not correct.
>> I will change it to:
>>
>>           dev_err(nand->dev, "ECC strength error\n");
> 					    unsupported

I will fix it.


>>           return -EINVAL;
>>
>>
> ...
>
>>>> +
>>>> +static int ma35_nfc_exec_op(struct nand_chip *chip,
>>>> +			  const struct nand_operation *op,
>>>> +			  bool check_only)
>>>> +{
>>>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>>>> +	int ret = 0;
>>>> +	u32 i, reg;
>>>> +
>>>> +	if (check_only)
>>>> +		return 0;
>>>> +
>>>> +	ma35_nand_target_enable(nand);
>>>> +
>>>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
>>>> +	reg |= INT_RB0;
>>> This RB pin looks like something hardcoded, whereas it should not :-)
>>>
>>> If you have several RB, it means you have several CS as well!
>> The MA35 NAND controller is indeed expected to support two sets of CS and RB.
>>
>> However, currently, the MA35 series only supports one set, so this name will be changed to RB.
> No, please use the correct names for RB and CS, but please read the
> value of the right RB and right CS from the DT (reg and nand-rb). These
> properties are standard and can be used to use eg CS1 and RB1. In this
> case the whole driver logic is the same, there is a single CS
> supported, but it becomes correct because you don't silently assume CS0
> and RB0 will always be used (you would be surprised by the number of
> designs not using the first CS/RB). It's just a bit of additional
> logic, nothing complex here.
>
Okay. I'll look into how to make the modifications.



> ...
>
>>>> +
>>>> +	mtd = nand_to_mtd(chip);
>>>> +	mtd->priv = chip;
>>>> +	mtd->owner = THIS_MODULE;
>>>> +	mtd->dev.parent = &pdev->dev;
>>>> +
>>>> +	writel(NAND_EN, nand->regs + MA35_NFI_REG_GCTL);
>>> I would expect your reset bit to be set before this writel.
>> Are you referring to SWRST? I will call the reset engine before enabling it.
> Yes, thanks.

Thank you.


>
> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen



