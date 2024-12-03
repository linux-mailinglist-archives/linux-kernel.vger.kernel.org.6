Return-Path: <linux-kernel+bounces-428526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477E9E0FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62F4B22697
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C8136E;
	Tue,  3 Dec 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGBjGht9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F01370;
	Tue,  3 Dec 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185630; cv=none; b=U8rdndGoz+qXWJoSylt5V5fyTL4ShIDAAeNx7sTXnhT2OA6oFh2GSzqnkV3WNqu+o37W7GoxrlgKDM/lNwkMtkhtyS/lKe6BG5cL9wn5i6pXAC7K/qiu9xkQFONpYG0mMrGqes/CAXTU2kwSzTle7y1VryrKJasosOUaupO3viU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185630; c=relaxed/simple;
	bh=vIqmA1nOy+jz/4U+APL/rsZ/a53grp9JYAOhnJ4AJPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hm/8Q2189HW1Tx4r+lyThAHptvLhdWePC7MeMieqekXSqr3x35+XjKnwKCBYd/dKopOvS/Mi3O6cM8kZ0a4gWSjbjtdCXRmWDPApM5Jf1T9yeLyweDnp9OPR6kmjX1bSGPvQxw8QdlUyuYozt950y2b+hgAD6GWkd4VKBeGbPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGBjGht9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21539e1d09cso44658845ad.1;
        Mon, 02 Dec 2024 16:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185628; x=1733790428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLYTwGWkMWLIc6S8rXeQ5AdWzJOnAigIrBbJB1JhA1I=;
        b=OGBjGht9TYS0GlBZPndVXqhMojLuG1mwQfFzQVAVjX5gkLkk1+nZd2VnMYRYUzFYqt
         a9tOgDqXrEEBQDR8YSqt7/74R4AgEgfclKxeytBRl9ANQQROE2NuCy8PtjGD7+zO3MLm
         C+JpQMNrmIQAfVsGM8QYnM12sGTFgeZVp9MCDJGNpgFLSRn2iFoe3vgkBIKIbO/xOjdV
         WjdWRNod3QZkbukJ/h6khPBtqQfsZe/Bx/ah1UFqnVOFk/4I2FKoIZe3xf/pJzZdV5m4
         DkARvEuBgsmWEwzeI6LantNe1JVT/i8MrX4cqF/KwxNe3RPFZ1R7qFwae6d4agaa/X+1
         N4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185628; x=1733790428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLYTwGWkMWLIc6S8rXeQ5AdWzJOnAigIrBbJB1JhA1I=;
        b=nxrmGtctu6BnRglIZOPr2ZCNori7xzZGjTy9hbcSbaapQb/VdyG99TMYBvLqgJIkgh
         BdmcCXFL07hJSYdt/9FSm9RlXidD37yEHt9QCrBaws9klh8DMg9QW4/tJC1qIK9wL0am
         eFqFwFYCU4YWenWOZ0cYSJ+p6lyMJJjTLX4kQqHluf4BCK07z23l+7R04hqmcEAXcUzv
         vL5ylINpVEcQ6S7ZKtgvHpCgtTqV8ZNFZOBZRKB84g3a7NjvBSFXUcI/KErgxlhigxHp
         0J36pGRsrKxFyDGmtMZz3ju3lQAplvkfR56BlwFLlWk8Sk/T+hfrwSHVy0Y4qfiyNMuf
         bDkg==
X-Forwarded-Encrypted: i=1; AJvYcCUOp7TbK7KPmT1Ql/4M1louyS8EQ3ptdt4kX4UbMerZ8SBBIeTUCycjMxJ1KzaHt3sWNnVS8w6yEQ9E3mH4@vger.kernel.org, AJvYcCUXfteA0OLK46Ux3TxsR2hhWtaf8snL5jT0Gb/okXE4Uc4DRuOGQE8bJGw48iN6fHxi3bx7/mRB8vHp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj6qa5ZxXwxuMEfbxUg6WLjfO8lAP13pT6QZ0Wv3pFrXNdgs2
	sS+Iv3n+hNZzBsSplMHo2Pb93O29OkQIxG6zBFdoFe1g/rVksFqC
X-Gm-Gg: ASbGncuGwPnDQfqviBvQJGC47AThY/xS9j6h4e2YZFTPx6EeXmip3G2eK0+lTfJbOpT
	enDuxksNUZZ8PGMK0FH/w2mpo5yqpVATPZPaKt0sSeMvrxSIQjXsCoNrQ+Tamkx6G7gFJG/sUo2
	0K3C4ANqDY/F9lRD599Ry2p2thL5jpGbWSAZfVWJrh5h/nmJ17hlvyzTUJonnVap3AYsoScJCLj
	8BOWCRYZ2pvMJnhP2HD1mx3Dn1EPTaWK4PHH40WverI1qvQP3BCUj96uO44JbW0N249WU9mlx1F
	wOpNS8wm7VdMbq5uWn1AdA96
X-Google-Smtp-Source: AGHT+IGHwdUtcOPNOesLU2uYuzU+uzBNriJXCHFU8gQ6QyGwX1BK3vvXSZUFFBjaUgWZE1pjKQq8OQ==
X-Received: by 2002:a17:903:22cf:b0:211:3275:3fe with SMTP id d9443c01a7336-215bd1cd723mr8388845ad.17.1733185628104;
        Mon, 02 Dec 2024 16:27:08 -0800 (PST)
Received: from [172.19.1.53] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159d48d97esm20570085ad.239.2024.12.02.16.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 16:27:07 -0800 (PST)
Message-ID: <6395117f-4ed8-45b5-ba80-417d61beb55b@gmail.com>
Date: Tue, 3 Dec 2024 08:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241125052524.135362-1-hpchen0nvt@gmail.com>
 <20241125052524.135362-3-hpchen0nvt@gmail.com> <875xo257rd.fsf@bootlin.com>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <875xo257rd.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mique,

Thank you for your reply.


On 2024/12/3 上午 01:12, Miquel Raynal wrote:
> Hello,
>
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
>> +	reg = readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
>> +	if (mtd->writesize == 2048)
>> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 4096)
>> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
>> +	else if (mtd->writesize == 8192)
>> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
> You should error out if the writesize is not supported.

Okay. I will return -EINVAL if the writesize is not supported.


>
> Thanks,
> Miquèl

Best regards,

Hui-Ping Chen


