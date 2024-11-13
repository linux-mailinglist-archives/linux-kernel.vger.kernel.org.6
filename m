Return-Path: <linux-kernel+bounces-407127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27E9C692B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0491F2395A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45C178384;
	Wed, 13 Nov 2024 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2XsqJfu"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D41632D6;
	Wed, 13 Nov 2024 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478616; cv=none; b=nFubKG6TPG9VWnGh4jGm6azuNtIDzxY86+LCjMW6Pa0jrlHgLn+I/dz137ejGHztAN8QE19IHZjFO+s7v1keeoexKfS8RSr5L3ZDKH5+NJRs5hZ4E7qb4aSIoSPIyvaAhYgMnw93tVqZIgBN7WsL/iKviIiEnjtcjPzOaqi0PII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478616; c=relaxed/simple;
	bh=M3QLQ7BUvZUzw3ahRjrFVquLHnvHBKxtTgkx9faOth0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lNEoMvbaUBMrfLeVQYR0lYVIdUNhl9X5TPLBsOBqWbUs5FFz1D9uLcDa5xzpkmWvARc2iFYlmZ16HwLNPqMi0FEXhp2LCwaXJ1mlV7XPMsCAN/GzNuhUGqVORd83ulwRFVego4lcQARNivBvqOYRaM2fc6zl6PVwwJubv2X+mX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2XsqJfu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so5282020a91.0;
        Tue, 12 Nov 2024 22:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731478614; x=1732083414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dWsx5nJGnXXSk2Ufj1TPsNBwAQF6kKooyg82zNLy88=;
        b=j2XsqJfu1lcy723RPhwFBjb08zPwwiUKmef6eQ+JFOLitSE+R6F3Hj4lC2ux3tEXM5
         hx4pnQJ0kPOAOPGM937lVmGHa8sVM5KQuj50F7dMsSxNwYBApq9TcHfsnBREokivH442
         3T9W4EE9x6lRILaI2qMMXrfimGqp7t72pAUkK3nJN7+y6Jd59DSzOweCtDBFBBLBEP5q
         XXu7E3Klx0OjkfDT79EmC87TE/Rr194VcMI4puTi7RYIspMSAn/2Z7jqQxpetc/4eNxs
         02jcypkuxXJDjbPQMf3Z6bcQlA3QSVRxFlYeEdX3GK/OgSTOWXmwk/cjG6mJQJ3RuNdG
         /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731478614; x=1732083414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dWsx5nJGnXXSk2Ufj1TPsNBwAQF6kKooyg82zNLy88=;
        b=k2jSyP4nRJIL8EHVLKI8qPFMyefb59bFMGzMCtLx+ogOL9mLrdG8obPEuWK28SEx3f
         IupobCpOnxxhnk06udeC75J5anzynwvHVNkcKrEdJRgKLVQiRHcwpzeA8rlvnGoct/Lz
         6wavcpOb/HJTf/NMseaYDVC47kUhzePY5xYtoMBaAKchtFxNoGpjTokzkAL8Ko2nFL7o
         Ekvo/PvNjPbHN2OLeq9jIfQHFaFkZfvfiqazBVMkb3xnCXUOANsxH9z5Lrn8QenrLPSi
         ynhXMqlOjIowaaVnh3I2ZJs+tuSC/MnWB3OdQayFnulCXJBI1eLXBo9vKVP6ArmZXe/O
         p0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHb5jYx2mluSLGT4DX9udaw6Foupose2wVYwQTig0rSAqa7ctSwuZuZnyEilvQptdGNz2BV2RctKY@vger.kernel.org, AJvYcCVdNMi3E/GYsh3u9SB00nyMSb6RXJ/OgwRCRV+pFKzSp7QamJl4JiOo5SuHGNIKPYEJ+ey6JzexRjKQx0Xd@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNzX7IrvxBRl/3Qo+hGTYDKMvYzcunqyRMoZ069t0LFfOVDrg
	80LQD9rL0LAAp1eLiAHSk3iXyRQgFANxr1wjhNbjYVhZbzfS1aT4
X-Google-Smtp-Source: AGHT+IEDrczFgFYUt0SpNxIqMdH27qTt4lLwgzyYo/TRfEHiJZ3LxPGin4/itPwqN0UbsgxzaBid1Q==
X-Received: by 2002:a17:90b:524e:b0:2e2:d859:1603 with SMTP id 98e67ed59e1d1-2e9f2d5c5a7mr1978413a91.25.1731478614156;
        Tue, 12 Nov 2024 22:16:54 -0800 (PST)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ec86d2sm642280a91.21.2024.11.12.22.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 22:16:53 -0800 (PST)
Message-ID: <245b6c20-d7c1-438a-8b8f-d80a2e5d2807@gmail.com>
Date: Wed, 13 Nov 2024 14:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: Re: [PATCH v8 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241023092617.108021-1-hpchen0nvt@gmail.com>
 <20241023092617.108021-3-hpchen0nvt@gmail.com> <87y11p1vhx.fsf@bootlin.com>
Content-Language: en-US
In-Reply-To: <87y11p1vhx.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.


On 2024/11/12 上午 02:22, Miquel Raynal wrote:
> Hello,
>
>> +static int ma35_nand_attach_chip(struct nand_chip *chip)
>> +{
>> +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> +	struct ma35_nand_chip *nvtnand = to_ma35_nand(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct device *dev = mtd->dev.parent;
>> +	u32 reg;
>> +
>> +	if (chip->options & NAND_BUSWIDTH_16) {
>> +		dev_err(dev, "16 bits bus width not supported");
>> +		return -EINVAL;
>> +	}
>> +
>> +	nvtnand->nchunks = mtd->writesize / chip->ecc.steps;
>> +	nvtnand->nchunks = (nvtnand->nchunks < 4) ? 1 : nvtnand->nchunks / 4;
> This second division looks broken. Also, you probably don't want to do
> that outside of the ON_HOST situation. Finally, you should probably
> update chip->ecc.steps and chip->ecc.size to your final choice.

Regarding these two lines, I will remove them and instead set them in 
ma35_nand_hwecc_init().

However, since the nchunks is actually used to get the ECC status 
register count,

I will rename nchunks to eccstatus and perform the calculation using 
ecc.steps.


>> +
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
>> +	if (mtd->writesize == 2048)
>> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 4096)
>> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 8192)
>> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +
>> +	switch (chip->ecc.engine_type) {
>> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
>> +		chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;
> What is the reason for refusing subpage writes? This is not something
> you can do later, so unless there is a good reason, please do not set
> this flag.

I will remove the NAND_NO_SUBPAGE_WRITE flag.


>> +		chip->ecc.write_page = ma35_nand_write_page_hwecc;
>> +		chip->ecc.read_page  = ma35_nand_read_page_hwecc;
>> +		chip->ecc.read_oob   = ma35_nand_read_oob_hwecc;
>> +		return ma35_nand_hwecc_init(chip, nand);
>> +	case NAND_ECC_ENGINE_TYPE_NONE:
>> +	case NAND_ECC_ENGINE_TYPE_SOFT:
>> +	case NAND_ECC_ENGINE_TYPE_ON_DIE:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> ...
>
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
> Please convert to device_property_ helpers. And remove the of include
> once you no longer need it.

I will use device_property_read_u32 instead.


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
> ...
>
>> +
>> +	ret = mtd_device_register(mtd, NULL, 0);
>> +	if (ret) {
>> +		dev_err(dev, "MTD parse partition error\n");
> probably useless error message?

I will remove this error message.


>> +		nand_cleanup(chip);
>> +		return ret;
>> +	}
>> +
>> +	list_add_tail(&nvtnand->node, &nand->chips);
>> +
>> +	return 0;
>> +}
> I believe next iteration should be the one, I'm rather happy with the
> overall look.

Hope so, thank you!


> Thanks,
> Miquèl

Best regards,

Hui-Ping Chen



