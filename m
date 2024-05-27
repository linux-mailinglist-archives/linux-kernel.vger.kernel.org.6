Return-Path: <linux-kernel+bounces-190260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ED58CFC21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8263E1F22913
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6236E613;
	Mon, 27 May 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7lheJJZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EC5FEE6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799696; cv=none; b=mAeH6nc1gvOL8m9sIxhAxIR0HsXdsgzY7HZcCHGaaxUuUTtP9DP9JUvHzE7DY6hl9TdL/hl1Sj2QNWCKH5/bh2JvxMFWM+48R06YKuKnwSoyxrgP9MOZVF2/qut7pISUyEkkQkB+LNqMEdqFu2sAQqZbfeXPsNzz6WmW2IHB8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799696; c=relaxed/simple;
	bh=sPNOh/RvH7+NhB0lztzZ10hM6y4Nef8BFMKIfZEdbLY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jvIsowVNiGBfQT6uRbN35YnasbN/NdrZr0rmvMNxaXSZxifYk2lRaqRF/sCcftkL5Pi0w4iPVOHH03D7PVh1fkAzrba0GIaUafUU8vAo0/E6viC1Ow7vpoiChZ4W5YsUCQjTNcKnWJut30j2N4KjkOJVTthD4xxsQRmZCzpTm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M7lheJJZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so17072075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799694; x=1717404494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BoiH3PrE5Z52gU+/bga8Krds/WFhLzgOzlw5DShXKc=;
        b=M7lheJJZkgd6OyBUBE8HocDjv7l2Iq4Om6LAUSMjOGKG58zGfv0edLM44gcYghkyX2
         qhleDfdi46a5lRhQ2RurLXmspQQftsUUoLAR7ebrLMNslCB8qTUzNBuwBAGXlxucIv00
         dCfk5A0dmNAgJ8THYwjVrnPZv+HxjIVPkjlApP6ANWsin6l45ia3LjfUxLRbTyTNLeUO
         OOzbtzjZtgbmu4fXOdR13EpnGPANQ9CzfqAAMeYMUIDkXJLpgJZhKSUXo0PucV3lrxfD
         W4JEM9nkimbwtpV3/9CphbJ/i/eCqe7b+yPHiM7sroVOtHsV2k4ihdeUz2KsVWEFI4VR
         LtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799694; x=1717404494;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/BoiH3PrE5Z52gU+/bga8Krds/WFhLzgOzlw5DShXKc=;
        b=bMnSYobLHzEFkcD2qD4aMSzOLTT2GWbq4rF4q5t/d34xNQDesr2eXi8lw2MxqUHF9I
         6D8tvxvVIczYgMtTOZeTGCnEnKNEOzek54LGpbapScIDzW1W6fVs2l69KFyIANd2V+cd
         XGz7WpXGt6thh8Sow+AFwuwrKUTtTQJECRdHQzLGxRMeij1pqcRiBAKi00pqJ2CmvKo6
         OWJiMOUn0Siptv/Tq8TrWKTIOEcq8dMYCZsKADidK0cDAkNyN+/Ord9vPNDACgkDpM4c
         Q/NO+b3oSnnOpi/DLsKGwxtg5G6PuAPDMwsXPEMpIVnT/4bVusYPizDU3gnojFqHhUx3
         gPbA==
X-Forwarded-Encrypted: i=1; AJvYcCUUbztXDK2jOEz/ZcRnaNrKPvhOQ9IN/vf018aXM4VUk8hSr4i/d1iGn0huTcMrt5KvWHVt+R7XlIP9upTAQuQV2DzFXGDRmEMkSU7E
X-Gm-Message-State: AOJu0YwLnTZF4Dgey1DmcBvDHXe7lIFgk8J2vqqurx8shZyNS7x1F14i
	B1mW5SqsfzqxQOTtQMRMaeMinQF2TUyc0Y3XkDAUhILh/u5zJCLW/v0W3WpsPvU=
X-Google-Smtp-Source: AGHT+IEED56KX/k0SKrUPUle14ZPrTlxBx2vb8tUqjMqmW8hTWg0L4LEMzpI/Q0kkUkfTHENA1aPyA==
X-Received: by 2002:a05:600c:5848:b0:41f:fb7b:bc53 with SMTP id 5b1f17b1804b1-421089ea66cmr72367625e9.22.1716799693619;
        Mon, 27 May 2024 01:48:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:371c:b423:6c2b:61bb? ([2a01:e0a:982:cbb0:371c:b423:6c2b:61bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1ad4bsm134400675e9.19.2024.05.27.01.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:48:13 -0700 (PDT)
Message-ID: <c767bc42-f4f7-44f5-b712-5933a921b386@linaro.org>
Date: Mon, 27 May 2024 10:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/7] phy: qcom: qmp-combo: introduce QPHY_MODE
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-3-a03e68d7b8fc@linaro.org>
 <v36mrliwd7rarqofbitv5mtb6kd3n3hmuwp6bgg67krnvzejd6@luityjlkb7nn>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <v36mrliwd7rarqofbitv5mtb6kd3n3hmuwp6bgg67krnvzejd6@luityjlkb7nn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 10:46, Dmitry Baryshkov wrote:
> On Mon, May 27, 2024 at 10:42:35AM +0200, Neil Armstrong wrote:
>> Introduce an enum for the QMP Combo PHY modes, use it in the
>> QMP commmon phy init function and default to COMBO mode.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 +++++++++++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index 183cd9cd1884..788e4c05eaf2 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -61,6 +61,12 @@
>>   
>>   #define PHY_INIT_COMPLETE_TIMEOUT		10000
>>   
>> +enum qphy_mode {
>> +	QPHY_MODE_COMBO = 0,
>> +	QPHY_MODE_DP_ONLY,
>> +	QPHY_MODE_USB_ONLY,
>> +};
>> +
>>   /* set of registers with offsets different per-PHY */
>>   enum qphy_reg_layout {
>>   	/* PCS registers */
>> @@ -1503,6 +1509,7 @@ struct qmp_combo {
>>   
>>   	struct mutex phy_mutex;
>>   	int init_count;
>> +	enum qphy_mode init_mode;
>>   
>>   	struct phy *usb_phy;
>>   	enum phy_mode mode;
>> @@ -2589,12 +2596,33 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>>   	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
>>   		val |= SW_PORTSELECT_VAL;
>>   	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
>> -	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>>   
>> -	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
>> -	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
>> -			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
>> -			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>> +	switch (qmp->init_mode) {
>> +	case QPHY_MODE_COMBO:
>> +		writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>> +
>> +		/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
>> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
>> +				SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
>> +				SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>> +		break;
>> +
>> +	case QPHY_MODE_DP_ONLY:
>> +		writel(DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>> +
>> +		/* bring QMP DP PHY PCS block out of reset */
>> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
>> +				SW_DPPHY_RESET_MUX | SW_DPPHY_RESET);
>> +		break;
>> +
>> +	case QPHY_MODE_USB_ONLY:
>> +		writel(USB3_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>> +
>> +		/* bring QMP USB PHY PCS block out of reset */
>> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
>> +				SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>> +		break;
>> +	}
>>   
>>   	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
>>   	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
>> @@ -3603,6 +3631,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_node_put;
>>   
>> +	/* Set PHY_MODE as combo by default */
>> +	qmp->init_mode = QPHY_MODE_COMBO;
>> +
> 
> I see that COMBO mode is backwards compatible with existing code. But
> shouldn't the USB-only be a default mode?

No because it would break existing platforms without "mode-switch" in DT.

Neil

> 
>>   	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
>>   	if (IS_ERR(qmp->usb_phy)) {
>>   		ret = PTR_ERR(qmp->usb_phy);
>>
>> -- 
>> 2.34.1
>>
> 


