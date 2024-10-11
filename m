Return-Path: <linux-kernel+bounces-360288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE679997EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01364280C58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADE4A06;
	Fri, 11 Oct 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpXFY4sm"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E180635;
	Fri, 11 Oct 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606708; cv=none; b=RxdNnhpPsUZenDXbxVsnPfGNzB1rOjOKdRLGhak0nDWMO8DNrOaWsjtkIcZzOIZZyX8yP4C3ukOwuN3DwveO43EwsBX6+ypK0NgTjQ7hr7Ar9eD3slFsmtb4TN5VjFqRVfTSJ2BkTj84zBUzx6Yrp3yOC42BFeWLzenE8/daVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606708; c=relaxed/simple;
	bh=F4BtsFiVX7x2rfeUPCkR60/f3abJBEkIYsc6FplV7sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pyv5ZLUydSbFV/0+cz8VfATi1cc0xZWMCPpqPuIVkN96dgJAzc8tLnvax7oxGGgZihmn/4rxBRYlRpLTUlRF/BN7Enki6/rVDEAoYuiDLxuAyKjmVASCtYLCRcJbQhx9cMglX/6kccU2GKlHQzOPoervGotQ2j9UJ82GsqgEMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpXFY4sm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b90ab6c19so14788345ad.0;
        Thu, 10 Oct 2024 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728606706; x=1729211506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tekWhDCN5toSUCUqsw16CTcau0DYG46Y6c1PLwZiPkk=;
        b=LpXFY4smPAa66i/7noNqqnAdHzvHAytVG/IUn29DJmZbZiXH1W0xPDypLApQMThHkL
         6wElh7VEcM+o8aXHyFqOjpM90JFZb9k+KzRb+6gqPqvIxJ0nkbDhPJuCFNoOCZ2AP1kY
         sZpos1HiNz5wVUVJZdQuW45Sj/KWccbYhL7r628id2gSRn0ifsrm801ZK1dq5lKQMKpc
         RobMVqeSx682H9Z+tyHRCY1eUc3SdI+OeFjpo2GVHZznRT2V19xurgLtLJG4vzynwzmZ
         4M2VleJjiiaaH9yaqvVXvsLxJWrWH+Ph44SBvrz7/+6sLh4ZGo82JbLDeeSJMQYu3CQW
         WXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606706; x=1729211506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tekWhDCN5toSUCUqsw16CTcau0DYG46Y6c1PLwZiPkk=;
        b=wuQkCu3c3Lb00QMDJXVvgmqXUfHt1ikoFN7kFHHjjRZn+hTWQBLNSo2mW80CY6AUKR
         wTTebG4en+ioHkYgO4agPYk9x1DUzYgAbuwBgcnKxDTdEvjGJA2JUjOWOYlS/vBXyKLc
         AiHIk9QkrcrKzZXaGERcnKELKsoippIoAYbeDdHMBWriDTnIJLDgJFW5FP1BJdlonOAt
         ywLYoO2CUrgad2fBEHthHOUAT97TKc33vKGYOWy9eIhMj1LJsUrcqCuu6Q4oVeaG1XeC
         6ExopnFFKIWitm1wccACiIxPilKFYmE5xuQZT1adTsvF0bqi5AZkl3Yo7UIR7kCT86Uq
         X5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXKZFwXQwR166WaX+eoztfdGSaIU5DaLn+mQ0lswj1C5Zf+wDPIIW+13r8npNQg39XJvFTgdw8U/XvW@vger.kernel.org, AJvYcCXOjvjzt44e8miW+tXc7NDqYuc2Uz6rBNGdABUpQ2rb1qQuY6fdj0azwmmZn4FaHNrmeGG6paSrofX9zTji@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1euJscgY1eK6ISGps3uRfBGSW0+YHqBj+R80tVi8lKYWu4yhW
	PKqyao/+rNDlRIML5uLdq3P0AJ4ShxWJvG1kLt+59PJ6Y2tBUSzE
X-Google-Smtp-Source: AGHT+IHUvRrkj3FkAVO0d+YRG+WVM1cjdUJiXP6ZpBkhyprfTNny88vxjsdCgMjhLkqdqnaNMYAmtg==
X-Received: by 2002:a17:902:d491:b0:20b:8aa1:d53e with SMTP id d9443c01a7336-20ca16bdc6bmr9881955ad.44.1728606706355;
        Thu, 10 Oct 2024 17:31:46 -0700 (PDT)
Received: from [172.19.1.53] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33b5sm14865485ad.37.2024.10.10.17.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 17:31:45 -0700 (PDT)
Message-ID: <037102f1-3e8d-4b76-a9d2-a23fde7a502a@gmail.com>
Date: Fri, 11 Oct 2024 08:31:41 +0800
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
 <02098767-19ce-407e-88be-24c6259c4053@gmail.com>
 <20241009100450.362e3556@xps-13>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <20241009100450.362e3556@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.


On 2024/10/9 下午 04:04, Miquel Raynal wrote:
> Hi Hui-Ping,
>
>>>>>> +		return 0;
>>>>>> +	}
>>>>>> +
>>>>>> +	ma35_nand_dmac_init(nand);
>>>>>> +
>>>>>> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
>>>>>> +
>>>>>> +	/* setup and start DMA using dma_addr */
>>>>>> +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_FROM_DEVICE);
>>>>>> +	ret = dma_mapping_error(nand->dev, dma_addr);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(nand->dev, "dma mapping error\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);
>>>>> Please enforce a dma mask of 32 (even though it might be the fault).
>>>> I will change it to dma_addr & 0xffffffff.
>>> That's not what I mean, I believe you should use the dma API to ask for
>>> a mapping within the accessible 32-bit address range. The
>>> dma_mapping_error() check should return an error if that's not the
>>> case. Then you can safely write the value.
>> Here is my misunderstanding: just fill in the dma_addr directly,
>>
>> no type conversion is needed. I have already tested it.
> FYI, it only works because the default DMA mask for your device is gonna
> be 32 bits. If the reality (what your peripheral DMA can do) was
> different than this, you would have to set a different mask explicitly
> to make sure the dma-mapping step would not provide buffers which are
> out of reach.

Sure, I will keep that in mind. However, due to the memory architecture 
of the MA35,

which is designed for a maximum of 4GB, there won’t be any situation 
exceeding 32 bits.

Thank you.


> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen



