Return-Path: <linux-kernel+bounces-326821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C99976D64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D9A1F21A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2CE1BD509;
	Thu, 12 Sep 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdvdfyad"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5CB1BD4FD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153923; cv=none; b=IpO1YTuOja5AGQwYPIa8laek6pGeH8Vt4rOVGm8QPWlEaueAyzsMSY9em6Dc6aLjNDsV1CwB84rheP/5ts8+gROUKN7Tg/dvBSo0ayDvMAxhNWHaDO6s+bhM/cElfXRZCLoD2FISDez5xwv8uxw0Id+Mne/1itJPbtoTgmLoBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153923; c=relaxed/simple;
	bh=JLkUVGiDvOxyxYbcuHoP7hUeOJR66jvK9ErDIQ+bqQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiddkIdSzVntyQc8k4Yanx1RR3Tv/zxs2BWnb2wmgwvQN58QEI49jkfuhXLKOcnyki/EZQkr5dhHZ5u320CvhozCGy6xsmuXiqKi3uwplffmlmtWaSfEEHVcowHjXz7Mp3Vt4KLRk34CH3cT1KQAmt/QiM7QRDXpaMjzZrp+E18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdvdfyad; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d13b83511so131149266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153920; x=1726758720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pp2nKxgKyUUwRWYFUOJ32ePs5kEKlqwCPYig/SVKyzI=;
        b=rdvdfyadfBnWQezC9Le4YIPyW//fToBKX9EMT3tS5VKTKZaTc95arLGJz5Zm06ZNbJ
         fMfXaPM0rWgOCmjJeItXN9ibEn1NY0CjA23/QXYElNPTv8qwHvOgfC08b0TBM934fggE
         +ioxKAvH3igXJoHk3d40o5ctzspuqXxactnX/ZlYE2bfBXKnsIgtFdH0xhKHroNb7Ds4
         Y8FGyfaFjHL8JsDK3ztNccHso0IXmVgr1gVnpcftizr0wdB/M3+HOvJuNUTGqXRa2KJx
         I1P1Pvv4gwQiMO4CVl0XS22ENu/UM24yud3Zsxr3cdK3xWZ9SHV+/8Hn2uf1tBEJhkuU
         6TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153920; x=1726758720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp2nKxgKyUUwRWYFUOJ32ePs5kEKlqwCPYig/SVKyzI=;
        b=iN/7KNdy7L3hlhLNVdkHokxyYJyRgHBE7a4ChOgUovZuODTyZJRvleoEN1NztUBCRU
         ANRS4GoctQ7tqa7XIfuZN8EfU94ORmGey0bVDl3AQ3wxvwhbjjxWa8a8FuM7NXsGGaje
         u7a2jF2gzY5rbpJnUqRBMR44iKy60nUQdq/Z/gETseFCkRQeMh/pBDYnx35UA/J3zraS
         WM28/WKPYYrSPrvQZ/oGm4h+sb4cEuV3m0zcSTmXuEdsIKvy4S6UZlU0Y0GITD95vxyS
         2fB9TODe7mVDERhvMS5T2zJixblxygsqMv1HQpB1D0tYq/nAhpr4+Wpk7hPvsmmtC+ft
         WgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAx0BjYSr5YISDH+8dVDPKOl+1nDUPMs5sNWZpJBDAeNBX3ZP0zA/jDU1dp29OUh98h6kq4xBjFii5Omo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxG3l+4l5Fp5WZhDrHLHCtRrDxIt1hb9zv26MA2k09/HTG88m
	ZZxGUa6zZdnDEIJUU0klS1iZIav1jmg47p9SHhpuMj4QQXhGOAdMFoUwx3AjiB4=
X-Google-Smtp-Source: AGHT+IGX4l9aTFwCHKggFIiy76YIi1Ok8DrhJuyxt3k/Eo8HbzkG8vJ1RfkPD3Mt7v//+e2YZTzpQA==
X-Received: by 2002:a17:907:7255:b0:a8a:18f9:269f with SMTP id a640c23a62f3a-a902966f353mr261081266b.60.1726153919502;
        Thu, 12 Sep 2024 08:11:59 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2844fsm761034366b.88.2024.09.12.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:11:59 -0700 (PDT)
Message-ID: <97e4f888-1ed7-4d82-b972-3e0b95610198@linaro.org>
Date: Thu, 12 Sep 2024 16:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <b1b4a866-fa64-4844-a49b-dfdcfca536df@linaro.org>
 <82dd61ab-83c0-4f9c-a2ee-e00473f4ff23@linaro.org>
 <da60cf71-13a4-465d-a0ee-ca2ad3775262@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <da60cf71-13a4-465d-a0ee-ca2ad3775262@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2024 13:44, Vladimir Zapolskiy wrote:
>> csiphy0
>>
>> vdda-phy-supply = <&vreg_l2c_0p9>;
>> vdda-pll-supply = <&vreg_l1c_1p2>;
>>
>> This is also the case for csiphy 1/2/4
>>
>> So, I _don't_ believe this is work we need to do, since its the same
>> regulator for each PHY.
> 
> This is board specific, and even if the separation is not needed on the 
> boards
> you have just checked, still it may be needed on some boards, which are 
> not yet
> checked/not yet known.

There is a Power Grid Analysis document which specifies these rails @ 
the SoC level and assumes you've used the Qcom PMIC to power, moreover 
the PGA re-uses the same regulator over and over again.

You _could_ provide that power from your own PMIC which provides the 
same voltage range as the Qcom PMIC you haven't used. Even if you did 
provide that from your own PMIC you'd have to provide _separate_ rails 
for the various CSIPHYs before it would be required to have a per PHY 
rail requirement on this SoC.

Are people really powering these SoCs with their own PMICs ?
No probably not.

Should we add the support for it anyway ?
Maybe.

So to reiterate:

1. csiphyX-vdda-phy-supply
    csiphyX-vdda-pll-supply

    In the dts and yaml

    => The names should be generic from the perspective of the driver

2. camss.c::csiphy_res_sm8550
    [0].regulators = { "csiphy0-vdda-phy-supply",
                       "csiphy0-vdda-pll-supply" }
    ...

    [N].regulators = { "csiphyN-vdda-phy-supply",
                       "csiphyN-vdda-pll-supply" }

    => The regulators for the PHY should be defined in the
       PHY resources description

3. Required not optional in the yaml

    => You can't use the PHY without its regulators

---
bod

