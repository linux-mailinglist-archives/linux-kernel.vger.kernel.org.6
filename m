Return-Path: <linux-kernel+bounces-272118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC8945740
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9182B222A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA722097;
	Fri,  2 Aug 2024 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aczy2yv/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA98836;
	Fri,  2 Aug 2024 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574873; cv=none; b=XWfasGPL2upu3hNj9B7PryjcxqU+JhE7MMj2q9JAekQXNdzlYeQww9sRUpomlHzXlaKkpaEFPObW2qAXstnD0zeq9X5XBLwO7oystp7UIMVPEs/d8mTlMDCL+N8xtVD1CfYRb1YSELM1fpIGvAOM2OJIxlg7418HgsIRSfnSbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574873; c=relaxed/simple;
	bh=EZRqLqdL0AHmtBFsel5pUoJssWuOxisPoAgmk55uZFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3gue8PcHm9IRoZeAJOVV5Bp8wrl7D3pIaQhZNInuI6P3SkO6xPxb4ow5qiPw2xaxVLCmlC6EwI5cYBoz7fj8du8fvCjR4csRW0p2buRfrdiIHjAlRYG7qbEIx3xcuEktUcpKFrx6H/TGp5N1VkbOQjNOPuVUg0+dd4H9DJR1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aczy2yv/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso31149795ad.1;
        Thu, 01 Aug 2024 22:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722574872; x=1723179672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFKigovb0c/iNhyUWRzIRaCFkACHoRPioRGFAtBz5kY=;
        b=aczy2yv/GU4NbqZ0ZWrSB8LskTP5sZSgidqCBfgdi91z39kOfrxSHM3AfJzrIoEgt9
         eFMrYnk183NpsMwUaY1lusQ4bp5SqOf1jJjF2wqZbiELeL0RkzLBgLUq/3ZskX7k9FbL
         bk3485LBHkenaNYaUWJbiQ7tPMQUSzIOm3m/F/MK1k5tkEiWlQYd7QD/FR9sh66+crC3
         hJQEACt1XX/ciBVgdPJVylL7d7iuCYvyHFqSozEMDbAorC5sPIKAq7iA8v82KFUwnZcS
         lwW8lcy+OjiylY1M6hLMFdKK5U+ynhCZN8lxkcOGTRKhOCYdqLtqlMD3GDUbNbus/hTv
         uRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722574872; x=1723179672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFKigovb0c/iNhyUWRzIRaCFkACHoRPioRGFAtBz5kY=;
        b=WNZwtrs9+X6NcGOlhab3GNDQg52d168AiO5DNbKNHRFWeX4Q6oQBkx9kz5yVYIqMmb
         AKqzrJpqLja3+ojCOX+Y1StvKfHCBWuMt4G+L7V7nEl3H3Q/sHs7WccAUyjRY1OeuVwk
         VmKIW4gaUcpJbBjvZrMuG5yOPeuf97qMs0wot6DR62lRSei6g9IphqnhpTIUrzp+YS02
         hkXSDeja9loC5lJGnD8AfF41pxyDdMdeY5JFxxvgRtHMNePsU5PvtZO5bMt5iEyctY07
         xAaYHKEL/isSeUrGk4J9h8n7MFI45zGdnv75ee4Q4yQfOOxUypt6JeqoSCGvs1NdYXZ7
         Ndvg==
X-Forwarded-Encrypted: i=1; AJvYcCVsr7kMKOgZS420WSm46tPR3UIDxXfFDrHPELo2ms4ry9eNHZ16UiG0o7Cll1owunAZvuoLGYfLSvRGNjGYJ5D9qAWLsF2j2LW60kSizJV3HijUENcSCYii0gYQycZzZt+iVT2fiJ/TYw==
X-Gm-Message-State: AOJu0YykNOhdFkDs+aaDreskpGQa765S2ST2FGm+Y8qxNZmz+EC+4l/9
	MoydC1vY2ZBi53sqK0nQDQTVs+GyX0XUutWo77OW794+B7lthkER
X-Google-Smtp-Source: AGHT+IHcflfL/YECuodg/hQlDr7gN6A6Zu66HPKnYHhtmqIU+9cxcGsm8NNmBnxNmOCqDTuqOCC1tA==
X-Received: by 2002:a17:902:e18b:b0:1fb:81ec:26da with SMTP id d9443c01a7336-1ff574cf79dmr24831925ad.58.1722574871621;
        Thu, 01 Aug 2024 22:01:11 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5a473sm7880685ad.106.2024.08.01.22.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:01:11 -0700 (PDT)
Message-ID: <ea046ad5-ee78-44a5-803c-a09669cb8a82@gmail.com>
Date: Fri, 2 Aug 2024 13:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: nuvoton: add new driver for the Nuvoton MA35
 SoC USB 2.0 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240801053744.807884-1-hpchen0nvt@gmail.com>
 <20240801053744.807884-3-hpchen0nvt@gmail.com>
 <85bd5da2-312e-4d25-a4e9-afae4fedbd50@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <85bd5da2-312e-4d25-a4e9-afae4fedbd50@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/8/1 下午 10:43, Krzysztof Kozlowski wrote:
> On 01/08/2024 07:37, Hui-Ping Chen wrote:
>> +	struct regmap *sysreg;
> Look here - iomem? No.

Yes, this is my mistake.



>> +};
>> +
>> +static int ma35_usb_phy_power_on(struct phy *phy)
>> +{
>> +	struct ma35_usb_phy *p_phy = phy_get_drvdata(phy);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(p_phy->clk);
>> +	if (ret < 0) {
>> +		dev_err(p_phy->dev, "Failed to enable PHY clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	regmap_read(p_phy->sysreg, MA35_SYS_REG_USBPMISCR, &val);
>> +	if (val & PHY0SUSPEND) {
>> +		/*
>> +		 * USB PHY0 is in operation mode already
>> +		 * make sure USB PHY 60 MHz UTMI Interface Clock ready
>> +		 */
>> +		ret = readl_poll_timeout((void __iomem *)p_phy->sysreg + MA35_SYS_REG_USBPMISCR,
> Eh, I responded to v2, not here, so repeating:
>
> sysreg is a regmap, not io address. How could it possibly work and be
> tested?!? This cannot work. Test your code *before* sending it.
>
Yes, this is my mistake. I won't reply to v2. I will reply here.


I would change 'readl_poll_timeout' to 'regmap_read_poll_timeout'.

And it has been tested OK on our platform.



> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen



