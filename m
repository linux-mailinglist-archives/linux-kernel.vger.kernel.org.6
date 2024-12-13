Return-Path: <linux-kernel+bounces-444653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057219F0A57
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517A11889295
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEA1CD205;
	Fri, 13 Dec 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWUcAC6q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B01C3BF7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087785; cv=none; b=cSsmw+T5B/VIjTSIobGykanuJ0yOSutGSpo1PRq+2fCvLOTNM1Q/nyeD69j+dY8ogGlU5EBxDg0/FIq6BAVh4W7xGB0mc9cAKq+cQgGa75XJmnZ3k3aq6q8/PrCFsDZGYeb2z2F+Z1ToaXjRdJ3cBVCpZubOr3I3mdasl5NV1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087785; c=relaxed/simple;
	bh=qnkNPaMsb0tDHe6sxQvnBDZjuAa2B520VxXPvQjVm+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZU/BvV3Te+RPnX1sK06F98NvMXgknEPqcfsCRZQYxhYSSuXDoE5rVYN2kaFaZJ7gZzOVa+Ce85vrXLX3RDPt7TnoAe9JgMFCnty5P2JvI3eqzdC/HDK94D0EVkeldqR4ZCKd8+KmdX6S77cDzqKfx8gsCvHA75UcF5R111x37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWUcAC6q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e2ed7d951so256667e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734087782; x=1734692582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPrHEQPv1CwDbKkeMuoTmMG3oC4VaHuPVeckilyXmbw=;
        b=BWUcAC6qpgqWTiAnCz9FHU7fz92V01XRRwf//jR/+EWtd2X9po+o2sS+p362e1iPD2
         Tg0e4a/MunTkogXZXdfVX/d8vmFdmG6DSE7dAMIy1tfTMVsRZnTuJjgYp9yjeq0jdad9
         oaDtMaWZyKTP/k+SWoatww2WjdftOsDHMSJe77MZsj8nvpj01tXY9cFm4TTZhTyxxh0r
         AttqW0b3TJuK+QTv2h514FooI3bLEJ2Zmk2IAASJ0sFUL3T22xfSIy7ujldhnGwpfSk1
         RpGituwnNMNw3rftBsT8DLnO59Jxd5REsH0WVCQb7LQQLqzRl9LlShlLIx7RcFuM4vfs
         tenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734087782; x=1734692582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPrHEQPv1CwDbKkeMuoTmMG3oC4VaHuPVeckilyXmbw=;
        b=ZhR4pk68xu/6dnBaghjEkZr43F9YDwjE/RPvH44+NYiA4Ch62kjlGBTf+QCVLRHeee
         PfR3HRxxd+IfrvkNp4X4OiYOwoB7bJARN7oy/Ag49SSwDKibtbm6QnbMrHaW35s6gODe
         ivhnL0tu/cQ0c+SG7Dk9J/cWUGlnPmCmWd9zBPMJB7M+tpEs2NJmPxFKb6jMoVOTpeKd
         N5HZ8vdwpqU/SAAdq9mjrqCRSP8rCnNapQVb8wXzGoakogG/JyIHgVf8Mk5K2iHUnj6o
         D9zCvZskTOwnM4WxHTeH4nXB2ZVzG4bF2iihRdNVwqcQLhzeB8r/ZKStg/ICGxxhSWqr
         lm2g==
X-Forwarded-Encrypted: i=1; AJvYcCVu79ef863hK49Or4Y+WZRXqSu9JQVN8hG3D7wNJxLoD5j4Rryiov0obxz3sOKOlhVKva+WFDPt6SxycDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNiK7j5vvBUEWowpfEhWa5JuIa7/qbC2sUHzlIWb8SqWPpw1K
	WNKcawt0KFSNmseM/2czF+xITzKr1tlWMmmthyKnE+YyqQ90+36VfIO4cX5XY3U=
X-Gm-Gg: ASbGnct8vrC49P/1+0xIFVI1vKlhSMCVzH9e9lF78vbRYbeOX615KltZeVryOf7TPBV
	RcJVYxay5kKbv4qzVW5n/LtCvFWP3yiNDOyLpb0Y7ga955p9rmlRI3cCK40LMQfxuI3mFnamL6W
	oUrOJORSAlbPBJ1hLu3MfH4CVrF+czuYjEmJmNyoSa6fH/WPhjgYR7Hh2XR5L0/fRWmjtX/kVKX
	wb0RCfniQYP4awztGWrgYAvRsV8dyqC+pgFVUi49MWV5QsXcKFXgFlUFwZpbKne/5r7jhtm7t9U
	9pajwdZvH9vBShqkrVAnpPfEGZtpOngl/W4=
X-Google-Smtp-Source: AGHT+IF5+Ile5TFJDfu5dWJVDE0gHMtZwo3Q1j+ZWVbQP9H/N/T5Uylk2Nrnn2OcrR9w7ZkDQGevdA==
X-Received: by 2002:a05:6512:2825:b0:540:3593:9fd8 with SMTP id 2adb3069b0e04-54090568008mr203132e87.7.1734087781891;
        Fri, 13 Dec 2024 03:03:01 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401fbe50a4sm1495464e87.200.2024.12.13.03.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:03:00 -0800 (PST)
Message-ID: <a047e4b8-c2d6-4486-8037-e7b854660cb1@linaro.org>
Date: Fri, 13 Dec 2024 13:02:59 +0200
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
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
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
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <9c89e6f4-a9af-4270-b266-537f3464ee32@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 14:32, Bryan O'Donoghue wrote:
> On 09/12/2024 12:01, Luca Weiss wrote:
>> Currently the Qualcomm CAMSS driver only supports D-PHY while the
>> hardware on most SoCs also supports C-PHY. Until this support is added,
>> check for D-PHY to make it somewhat explicit that C-PHY won't work.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>    drivers/media/platform/qcom/camss/camss.c | 9 +++++++++
>>    1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
>> index 9fb31f4c18adee886cd0bcf84438a8f27635e07f..b99af35074cdf6fa794a0d2f0d54ecf12ac354d9 100644
>> --- a/drivers/media/platform/qcom/camss/camss.c
>> +++ b/drivers/media/platform/qcom/camss/camss.c
>> @@ -1855,6 +1855,15 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>>    	if (ret)
>>    		return ret;
>>    
>> +	/*
>> +	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
>> +	 * D-PHY is supported in the driver.
>> +	 */
>> +	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
>> +		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
>> +		return -EINVAL;
>> +	}
>> +

Looks like it would break all old board dtbs, which is not just bad, but NAK.

V4L2_MBUS_UNKNOWN shall be properly handled without the risk of regressions.

>>    	csd->interface.csiphy_id = vep.base.port;
>>    
>>    	mipi_csi2 = &vep.bus.mipi_csi2;
>>
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 

--
Best wishes,
Vladimir

