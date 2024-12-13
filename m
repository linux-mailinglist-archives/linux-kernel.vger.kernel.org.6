Return-Path: <linux-kernel+bounces-444726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409B69F0B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784181888922
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C751C3C11;
	Fri, 13 Dec 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwNHO1Km"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFB4A21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090602; cv=none; b=E4l8z7VpQUZPP3f5TC2o6gWoGiREUmhAfmwMBqhf+q3QrgpJY12PBnJdv9/vbI/sVc3tuOGg18NWsyx7aYPDay5AJqMb1G66laH98aY60ahDsVvBzjXhxZUOxlFOWN02AjlihJSarZprVNGvbZ0LykxQFqrH3oVuxcQIFp6O4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090602; c=relaxed/simple;
	bh=rseqG1N7BkubN/07fCW2g1V5YNbhgZMmYrUXJDT4lHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU0qGxppoNpfi8MV3vYku98q7JWsnM5jfxeZvmvNkawYZyM+ooIpcqyO18DVDWxcPvkfNliG7WvdPk92Jk/FxKmh1CQmGAfgkDwkEg63KSh8VVs3A7tFEDjLXTVnLSrB66BUdQr6XwEhYJoSZTzxARoXc492G4oHNwELMPZtEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kwNHO1Km; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54019dfd6f1so209934e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734090599; x=1734695399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZNvkdVhdOTKRjQLQWRnWH7IxlshGdmbBQhAJdL+f3Q=;
        b=kwNHO1KmTH8zu/hoO3ZP64VuRS4sIeoLta+FafK6O5/yYGcBF87Db3nqf7YTnUxHBP
         VEK/d22jy96pcGGJXyyWwLDAhLanSbgey51Ut7iN/QB5aQUDRl3BmBhRGKkOjb21BHE+
         VEvcxVVl0sF52D7rlYulA9DIGONJarmYBVOdMl/29FsegtP+oSQ1dr2Zo5f2y5GCOcDz
         y6Ql3Q65RWZyx1XvXAkOn3H1xZaYqQVTjSy1+8FCnT5IkoIEdCKhc38FvBO7VykRxln3
         Sat6oVsDiawtBLLOqqX/HY4B4+umBtTpjw+9SMfBEm0FWPlK8Brz9+umjYh0hSQiNTTb
         cmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090599; x=1734695399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZNvkdVhdOTKRjQLQWRnWH7IxlshGdmbBQhAJdL+f3Q=;
        b=AvZRbImL/v9S1w1BdgncWXpwmTlwRMUq5EmKW0lEO1bnMbsarv1bpEkB5T0LWVhkBP
         DK1htlkTT0HQ57GaJV66HMzZaff8UqcC13+MQwbFVDa2iQGCtlssB0WA+eXI8EbvOVA/
         /aQpY+3/3QixKzEdHnCJR09eyNI1mTB1MTsd/9F6XvTC5ZDCufiMgJ/BEAOoRjC45RtM
         Fcc2JhmN1kwuweWaH6+ZjFhaUSI6CyxrnU5EwpX4sPdYvI29vyUpp8XmkCXTwkOkwlhO
         LOJzfHzylRb7zQSRvryMMo7Bn1Xmjn1RkJf6B713TTjgeI72dqGKtcfS2ymXcZHn5uTy
         9gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmxAfZrFtVy9lhLxEu3lL+imygQHrs+dbE6CWmP736nTSP7QBnrq2xqhVfg89/YtdeIJmFsBnHMZ10/dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFQ0YRRNCyWk10I8sasiWZeUquLTvFrSMH5cvrPrq8gQR9sS5
	0tka2vAR1unOnL98Aw1N8PgPKnIfCjf5Xln/aMBPr3BYljGCKorUquqcFOQ9WjQ=
X-Gm-Gg: ASbGnctO0nh+kOWvWZfjIa0wUobV7BFun1yAEcvNXzCeD/APE0LlMy3B7tXkQMOHSz8
	mV9DSG+p7I8+taEiL7rsJBMbSHkuKibSEnsrI3o1bgUvsSk9rvFGQsgaf2tZ/G7IiPinTinC/y5
	oLEkA5mUoARPjUHxiID/35yUTg83VUyrTfcVzCX0pEajWEgQYOox+XNQwa8yV2XfOhDrTxL/sio
	0MnWJwg0ce0ZUYlKGkE4AJ3bpmS9dtatFLrKmCDtpvqhiLfPEnzcRfj0NOlMdS+VVey6J0iO+dz
	PFCg1KnxtY+JPxrekmffbOcEAkxxDNne1Y8=
X-Google-Smtp-Source: AGHT+IE7DQ2pj/KUeERm3qCZ9d65Km3gnEvSTNiDUBZ2SHDIDeNSeDP69n07wAfxEAhqwpPx2pLp1g==
X-Received: by 2002:a05:6512:6c6:b0:540:2300:25d2 with SMTP id 2adb3069b0e04-54099b72a8cmr257596e87.14.1734090598971;
        Fri, 13 Dec 2024 03:49:58 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f4001fb53sm1948890e87.157.2024.12.13.03.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:49:57 -0800 (PST)
Message-ID: <12618e8f-6f7b-4578-8315-1dc3d7049688@linaro.org>
Date: Fri, 13 Dec 2024 13:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: qcom: camss: Restrict endpoint bus-type to
 D-PHY
Content-Language: ru-RU
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Barnabas Czeman <barnabas.czeman@mainlining.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, David Heidelberg <david@ixit.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <20241209-camss-dphy-v1-2-5f1b6f25ed92@fairphone.com>
 <9c89e6f4-a9af-4270-b266-537f3464ee32@linaro.org>
 <a047e4b8-c2d6-4486-8037-e7b854660cb1@linaro.org>
 <D6AJ8KNRUHB7.1EC9O3WSCSNIP@fairphone.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <D6AJ8KNRUHB7.1EC9O3WSCSNIP@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 13:22, Luca Weiss wrote:
> On Fri Dec 13, 2024 at 12:02 PM CET, Vladimir Zapolskiy wrote:
>> On 12/9/24 14:32, Bryan O'Donoghue wrote:
>>> On 09/12/2024 12:01, Luca Weiss wrote:
>>>> Currently the Qualcomm CAMSS driver only supports D-PHY while the
>>>> hardware on most SoCs also supports C-PHY. Until this support is added,
>>>> check for D-PHY to make it somewhat explicit that C-PHY won't work.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>     drivers/media/platform/qcom/camss/camss.c | 9 +++++++++
>>>>     1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
>>>> index 9fb31f4c18adee886cd0bcf84438a8f27635e07f..b99af35074cdf6fa794a0d2f0d54ecf12ac354d9 100644
>>>> --- a/drivers/media/platform/qcom/camss/camss.c
>>>> +++ b/drivers/media/platform/qcom/camss/camss.c
>>>> @@ -1855,6 +1855,15 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>>>>     	if (ret)
>>>>     		return ret;
>>>>     
>>>> +	/*
>>>> +	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
>>>> +	 * D-PHY is supported in the driver.
>>>> +	 */
>>>> +	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
>>>> +		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>
>> Looks like it would break all old board dtbs, which is not just bad, but NAK.
>>
>> V4L2_MBUS_UNKNOWN shall be properly handled without the risk of regressions.
> 
> Please see drivers/media/v4l2-core/v4l2-fwnode.c around line 218.
> The code there sets bus_type if it's UNKNOWN
> 
>      if (bus_type == V4L2_MBUS_UNKNOWN)
>          vep->bus_type = V4L2_MBUS_CSI2_DPHY;
> 
> So setting "bus-type" in dt is not necessary, even if it makes things
> more explicit from dt side. I don't think we'll ever get UNKNOWN here in
> camss.

Thank you for pointing it out, I haven't tested the change yet, but hopefully
I will find time today to do it later on, it should exclude any doubts.

--
Best wishes,
Vladimir

