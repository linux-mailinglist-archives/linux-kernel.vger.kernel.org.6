Return-Path: <linux-kernel+bounces-441999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94F9ED6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2439282034
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52110207A18;
	Wed, 11 Dec 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LGslob5m"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966B1C3022
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945989; cv=none; b=qYkOsfQCkqZhYsn7XGddm3dOptrFTJefIWJgnYT8WXDK7e7yzAMTr+lrVAj8ggQu72z0nOeusORbZ4L6YgUjNh3ULCY2wSt8noIG+etIJuqRm8ckF1ZOvwl7qff5A7mbpI5b1+CyL1Jj3ZV69vuBUD0MzzwpqCB0urmBpupZhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945989; c=relaxed/simple;
	bh=eSv6jyYS7bs1pXUu2BATQ7WIGDGOMoLBSgAqFdPRo0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fecVI6JEevxOsOBJL5OWIKLZypMEZtKfxwBBLLhyGiMsv1sFw0q1xSsf3LmDoTW1yMWQyDtajznH1nYfWf7/diXnOxqjDXXfrFQKKUeUHS+t59ZatYeXrBppjjMwf44PARmPUmgHyYKhgFWnBYZRAUIMQ8zi4dhpIzAmfI0IRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LGslob5m; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4678afeb133so8148521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733945985; x=1734550785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iIB7OgclvuXmXcCb+7ry5WHS9m+ub2PzlVh4AHBJ290=;
        b=LGslob5m/WWjUWYTqogvacsddGGozjxLntHEgp9t7dI5Q8NKTAfRWlutU9qXbRgCkh
         +HC4gBYoSloGpLNSvqdkxLMSB1/KSNKsc820bqklkjjduC+69zOEQcyGb1C2RXKposd5
         Jy/Kgyzb3kXQSISLnfaFL17x7zdxAVPz7e+Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733945985; x=1734550785;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIB7OgclvuXmXcCb+7ry5WHS9m+ub2PzlVh4AHBJ290=;
        b=r1TbMQy6ziBC27IHqUbzsVBofSqmD9pO79RDqE9rk80F+t2ylps9FaTUuZuPj5hHfu
         zlZ3s3So9icQ9XLlpmXvAi2Te5VCIBJeWNyr4c35dueoWwGLJaGmMgNzc6Hu4wDHOWix
         nz/dy9nHAa2p9CrIyXZjpaqzf8iZ5EvLbqm/QeZirYaNcyvYDuiLD8ixMJYfhPWIouVK
         rDIrRZgD71Y9i5SW31tBrORIo+QRdfQKAPSL36uVkvKSst9jS/6KQIhLBFiHW3vOTwv0
         ANPK7zeHIMrZQdzi4dUmQxUETymB9zhxQG4B2dA1g4hdESWS80XdGfuBhl1Qo4C+tT5n
         QWZA==
X-Forwarded-Encrypted: i=1; AJvYcCWbiHeys7bwtDaoYAIWivq7fQZnKL9hGNxaFjSOOdZf6giYI9mJqlr0lwW4E5/DivnQx/LOQZRPaFHPR9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb61Q/yNe+MvMwl/253WpR6Q/nLmaBWQU1eTb4LfbfFFylvypJ
	xq2VDt4orftuLdFH/QvU27+1RJ1+oMv8TxOqtxCGIZRvlWhphWcgponlTiLoVA==
X-Gm-Gg: ASbGnctlNi7EoTmziQYtUhoVcVUhk/JAWjzTHlCZj2joYA/NikfwbZ8CC33Klzi3Ce6
	RfWwRivVWqJUN+8iqhe5iUM5LIheujZ2TbQYJjscXp1c/55wsZxyMG9G5N+acec+9JCc94SeBbG
	2YLhIJNFJIhyL3XNS/9SpnblJQn15/0BSOtMdabRkHG7ym8GolpEsqXd+RFtPCVftzr5NCjl5ol
	Kb0HSQYdXXcwmbToBDb8CWwqgc0OZTfx0e+Cp7uEelOZesvo+lBUC+aOHW+m381Zm62zyewu4Oh
	bEsquR6E0+maGgc=
X-Google-Smtp-Source: AGHT+IE7tWa/E0nByPLL7S0B6qviBPi3v4T4dJLWOaG0p2vZl2++JiBW87VesGV7kVDu4s3AD+/ezQ==
X-Received: by 2002:a05:622a:1102:b0:467:6703:d469 with SMTP id d75a77b69052e-46796810483mr6964701cf.2.1733945985176;
        Wed, 11 Dec 2024 11:39:45 -0800 (PST)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672978dd2asm75448881cf.60.2024.12.11.11.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 11:39:44 -0800 (PST)
Message-ID: <474e5e38-37a4-439b-b25a-fe60df03f25b@broadcom.com>
Date: Wed, 11 Dec 2024 14:39:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 08/10] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-9-svarbanov@suse.de>
 <4bbdf9ed-f429-411b-8f5f-e51857f0f9d0@broadcom.com>
 <f9f49030-0518-4e30-91a7-3c088c31180b@suse.de>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <f9f49030-0518-4e30-91a7-3c088c31180b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/24 08:42, Stanimir Varbanov wrote:
> Hi Jim
>
> On 12/10/24 12:52 AM, James Quinlan wrote:
>> On 10/25/24 08:45, Stanimir Varbanov wrote:
>>> The default input reference clock for the PHY PLL is 100Mhz, except for
>>> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
>>>
>>> To implement this adjustments introduce a new .post_setup op in
>>> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
>>>
>>> The bcm2712 .post_setup callback implements the required MDIO writes that
>>> switch the PLL refclk and also change PHY PM clock period.
>>>
>>> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
>>> the expansion connector.
>>>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> ---
>>> v3 -> v4:
>>>    - Improved patch description (Florian)
>>>
>>>    drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
>>> controller/pcie-brcmstb.c
>>> index d970a76aa9ef..2571dcc14560 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -55,6 +55,10 @@
>>>    #define PCIE_RC_DL_MDIO_WR_DATA                0x1104
>>>    #define PCIE_RC_DL_MDIO_RD_DATA                0x1108
>>>    +#define PCIE_RC_PL_PHY_CTL_15                0x184c
>>> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK        0x400000
>>> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK    0xff
>>> +
>>>    #define PCIE_MISC_MISC_CTRL                0x4008
>>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK    0x80
>>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK    0x400
>>> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
>>>        u8 num_inbound_wins;
>>>        int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>>>        int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>>> +    int (*post_setup)(struct brcm_pcie *pcie);
>>>    };
>>>      struct subdev_regulators {
>>> @@ -826,6 +831,36 @@ static int brcm_pcie_perst_set_generic(struct
>>> brcm_pcie *pcie, u32 val)
>>>        return 0;
>>>    }
>>>    +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
>>> +{
>>> +    const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030,
>>> 0x5030, 0x0007 };
>>> +    const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
>>> +    int ret, i;
>>> +    u32 tmp;
>>> +
>>> +    /* Allow a 54MHz (xosc) refclk source */
>>> +    ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0,
>>> SET_ADDR_OFFSET, 0x1600);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(regs); i++) {
>>> +        ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i],
>>> data[i]);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +    }
>>> +
>>> +    usleep_range(100, 200);
>>> +
>>> +    /* Fix for L1SS errata */
>>> +    tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
>>> +    tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
>>> +    /* PM clock period is 18.52ns (round down) */
>>> +    tmp |= 0x12;
>>> +    writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
>> Hi Stan,
>>
>> Can you please say more about where this errata came from?  I asked the
>> 7712 PCIe HW folks and they said that there best guess was that it was a
>> old workaround for a particular Broadcom Wifi endpoint.  Do you know its
>> origin?
> Unfortunately, I don't know the details. See the comments on previous
> series version [1]. My observation shows that MDIO writes are
> implemented in RPi platform firmware only for pcie2 (where RP1 south
> bridge is connected) but not for pcie1 expansion connector.

Well, I think my concern is more about the comment "Fix for L1SS errata" 
rather than the code.  If this is a bonafide errata it should have an 
identifier and some documentation somewhere. Declaring it to be an 
unknown errata provides little info.

Code-wise, you could use u32p_replace_bits(..., PM_CLK_PERIOD_MASK) to 
do the field value insertion.

All the above being said, I have no objection since this code is 
specific to the RPi platform.

Jim Quinlan  Broadcom STB/CM

>
> ~Stan
>
> [1] https://www.spinics.net/lists/linux-pci/msg160842.html
>


