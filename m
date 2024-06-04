Return-Path: <linux-kernel+bounces-200658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754688FB30F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDF41F2201A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D81146D4D;
	Tue,  4 Jun 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHnxR0f3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B5146A98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505738; cv=none; b=r4/FPIUqh7t7nhOo6oy/arUWRks2+d9WoEflSEmbNiUbia/WH/J9y3MXx8EsGZ+TNbpTVcUIEF4gwc1KXUnw0QHBET4rAdSob+7wRno4gtTjLUvNrc8lLvr72gqqPgoJZS67PBYQtOFatonhjW7Tx76ccT1iLZRzCnszYBJh4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505738; c=relaxed/simple;
	bh=V0vCL6gVkhzAyZZo+oJsCeJeNNIlPl7HtsS1Su1kgQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuA/uwuky6Bxs12uMiLU/gK20AjMT5rCm6U6trHTtL1ykb8/Hkn7JcFxwwqWMgL0pF95j/opG1T0Bng8zHzA1Oz6hkXO7mVNMPt+40kludHZeiu7f1plHUMDErDiTrRlCccfASfJl5kLkbeDsh1h/PkdHfTDz9oAKzLNhe1h8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHnxR0f3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so5030637a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717505735; x=1718110535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuBOud40nBOggoAWfa0+Eb9qxrfGYqM4K+kdHXRtdok=;
        b=SHnxR0f3f/eU2/9IpCfHNwpBuiGCWzuq4zshgc5MNDPEmAyV7g1B7HhuguAmHhuaIz
         ZiHBrzhD4ysLNPMyWR6mjYcDkGuj+qdIs9RBdBO8xB/qHETk/+8whqn5kWAitl41VQhr
         tKmXN4SoOw6sji9FRuuLr6hD0ntJHruRuVnceFlU/a7eBUCtTVvpFbFp1kBlLc0++kGC
         V55LkloIlxmWEUoC47k5vGngmBDV8hFOznZ/nwZAJiFUIRw9lAWdB6wWNbrm7OYyK9tQ
         OWOEgG/hvmMp/kbatitGCDgf4af/d99T3n1NoZEeUp9a7IjT1PJTR+JZUDPmBFxX+fAi
         9vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505735; x=1718110535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuBOud40nBOggoAWfa0+Eb9qxrfGYqM4K+kdHXRtdok=;
        b=mjWcXEvJJRSNLD1UjZD/HTgU1gwC13QZXKjcceP16/MuB3/wbkOmISF9MRVgNcZEKT
         CoZPJIx92IMUa0XcoK3KXn2/Y2ZNMKmC+z8ueGqwGHOLu8I+JXPg4s1lfWBiEiUbUqd+
         gBFmjb4NpENSm46JsHqPVUFHoCiEeP2VKOjVqCyFYRy6x0XZRKRfMte0iVRdSI8jdO+r
         WO0tp/3By4rRwoBfgbEht7mLjVLOHzLTfzgslaPQPZ5NvzvazybUFkBTpxelUTPGZtYW
         8Ros2n1ppr6pPzbqDx8ZUi9xuUtfob/1ZpdB0gEAg4djtowowSGZehr3n36kj8Ohedne
         0M1A==
X-Forwarded-Encrypted: i=1; AJvYcCWGgMUmvKAv8iuGur6/P3kdsrnRj/qcDSSs6Xh48ycUxtlqTjTucC+/ntmQiIgKfOMA8wtjGls3T0VmVf8afi4LEex1oMHZ9bba7jDq
X-Gm-Message-State: AOJu0Yz82d03YFcW0cqO4yAQ698iSUVm9L5nwZ8gDXWtWd8ZecyWe8Gi
	hon0WNVbYE0dTYpK+79oMH9rTAb39iVeAyrhFUAw6nBb3yygTWjcwTLTJZSYkoo=
X-Google-Smtp-Source: AGHT+IG1rAoHsAHyRqKPmOSjqv99/sZwppXItf/q+FZevk0x6ZqV4EBji8R7gKbvE/UOP0Zpec+vYg==
X-Received: by 2002:a50:d541:0:b0:57a:231e:2cf5 with SMTP id 4fb4d7f45d1cf-57a364384afmr8146953a12.32.1717505735060;
        Tue, 04 Jun 2024 05:55:35 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb83f0sm7291474a12.35.2024.06.04.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:55:34 -0700 (PDT)
Message-ID: <dd1be285-d94b-448e-85d3-d5dce27f9ac0@linaro.org>
Date: Tue, 4 Jun 2024 14:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: Make the PCIe 6a PHY
 support 4 lanes mode
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rajendra Nayak
 <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531-x1e80100-dts-fixes-pcie6a-v1-0-1573ebcae1e8@linaro.org>
 <20240531-x1e80100-dts-fixes-pcie6a-v1-2-1573ebcae1e8@linaro.org>
 <Zl28nvnpGFRsYpGh@hovoldconsulting.com>
 <d93fe55e-7c65-48cb-bdaf-5e15bc22be30@linaro.org>
 <Zl8GoRoY9lXRtg2R@hovoldconsulting.com>
 <402aa998-8b3c-4c3c-8dcb-f128b6ddac46@linaro.org>
 <Zl8MUpfy/2Khw+wD@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Zl8MUpfy/2Khw+wD@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/24 14:45, Abel Vesa wrote:
> On 24-06-04 14:38:40, Konrad Dybcio wrote:
>>
>>
>> On 6/4/24 14:20, Johan Hovold wrote:
>>> On Tue, Jun 04, 2024 at 02:00:10PM +0200, Konrad Dybcio wrote:
>>>> On 6/3/24 14:52, Johan Hovold wrote:
>>>
>>>>> As I just mentioned in my reply on the PHY patch, this does not seem to
>>>>> work on the CRD were the link still come up as 2-lane (also with the
>>>>> clocks fixed):
>>>>>
>>>>> 	qcom-pcie 1bf8000.pci: PCIe Gen.4 x2 link up
>>>>>
>>>>> So something appears to be wrong here or in the PHY changes.
>>>>
>>>> Is the device on the other end x4-capable? Or does it not matter in
>>>> this log line?
>>>
>>> Yes, of course. It's the CRD as I wrote above, and you can tell from
>>> other log entries:
>>>
>>> 	pci 0007:01:00.0: 31.506 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x2 link at 0007:00:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
>>>
>>> lspci and what Windows reports.
>> Ok, good. I was scared of double-sourcing of parts that are not identical
>> in spec..
>>
> 
> On my CRD, there is a KBG50ZNS256G.
> 
>> [1] suggests this wasn't ever achieved.. which makes the cover letter of
>> this series a bit misleading..
> 
> True ...
> 
>>
>> What does the TCSR check return? If 0, can you hardcode it to 1 and see if
>> the link comes up at x4?
> 
> TCSR check returns 1. But that is not enough. The PCIe controller needs to
> handles some stuff about margining. See the following patchset.
> 
> https://lore.kernel.org/linux-pci/20240501163610.8900-3-quic_schintav@quicinc.com/
> 
> But even with this, I'm not able to get 4-lanes mode to work (yet).
> So it must be something else in the controller driver that is needed.

The margining settings AFAIU shouldn't be necessary for just getting the
link, but to ensure there aren't many errors while transacting..

> 
> IIRC, this is the first Qualcomm platform that would support Gen4 with
> 4-lanes upstream. Maybe I'm wrong.

Seems so

Another idea I had, maybe the PCIE_PORT_LINK_CONTROL &
PCIE_LINK_WIDTH_SPEED_CONTROL registers differ on qcom gen4 controllers..

Can you check the documentation and see if the defines in
drivers/pci/controller/dwc/pcie-designware.h still hold true?

Konrad

