Return-Path: <linux-kernel+bounces-200614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D58FB26D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994B9B25B60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA5146006;
	Tue,  4 Jun 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/Ea3iyB"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA5146A8E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504727; cv=none; b=Zx+4GVRGDMWE5SIdWH+qNlyOqaZkSjtU1lnk2HI52fuh08+TotJ3AiT2tkHnLOMgMBqk0exWk080fW59jpReR8lapOaxpjQj+6XmA679QPwW/CbV0vnzlg0qOHFxB1rPoB4EgsuL11i0/wytl5ZUFixZX8bUYK7kgKRQ9wY4iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504727; c=relaxed/simple;
	bh=+uiMXEG+EZule7VdPnnx+fU2SmeBWfCCqxuavrdMkio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuN1JTnH9HWz7juwo9L6REyq7v5H3c8E7Pw/CWKnkkN2U2w/bPv4c8cXMtV0oKuCkqlVCF3ZK50ydK+A95A7O36bIJWBUDD2QEsNarkRKruxABRUhoiLH/wbRpVyI+Umpjg+3V5Ra9QrNLS8JDjuQKbN4m9HEWAiuoqvusedDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/Ea3iyB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a526c6a2cso3390536a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717504724; x=1718109524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBuKKqkxYHyIgRStro7NrXTT71EaUUMEHnaPxL+Wr1w=;
        b=G/Ea3iyBNGnW4EYW3lA/f9c9vHKCM1CZgf4B6E9IA2z4eKvfM6xd0qsvVA5YrI4y6w
         UUH+MwjjBHaj1kdnJ9ruAwhoTXaY9j1Pk5Z8faE1H0s4x768bslB4Hvz52Q3MgW3X4a0
         dCja4Vn/wAWOa7/QQToalu0nzdMsqrgphEDkqf+8U8ztOlw/jBmNzpGuYXTgUAcCxvu2
         GOdLyke5AhfkPvb/Tem/n1NY5k+rQzr9zcnPbWP3LrQLXA5wAFiwRy90UoE8RDNTGCNa
         a9CoiTOOB/vpc0UiWHd/dWUmfbsEZ2WkVgkkDWNlu/hWrgSj3ehyF/PIKva9NkjI/JR4
         JuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504724; x=1718109524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBuKKqkxYHyIgRStro7NrXTT71EaUUMEHnaPxL+Wr1w=;
        b=gDEPlmPJHOKsUZ9Ja3sXnWpmjhJkKQsZVRDa+/99VzG8JSNHWwAIe2JZwQZrQBsH5S
         NyytQ4LA6DF+0bf3ANaOi11c9owdZYTnXeeAM0WTOKPS2kjnUx8DiJbUIp0OypRswWkZ
         V4lZF1gHWz2Qu4ARPyKKzddLFur2gErem7bDT8Zqrc3Tl8UbhKicyRlx9qUvOTyArFFB
         ZUU2ENouFZhh0SYNFkxC1CWli3lwIVOSOgknxo0MxYuqNO/IoIsY0zKe8dL3/fMuQ683
         o4AXR/06BI2ZFzHZXWp51RecQ99KIfO1c9gav67s5Hju2Z+8DauI7i7f7lSv9TcGlbFy
         4E3g==
X-Forwarded-Encrypted: i=1; AJvYcCXoGKfF03Hovu5inMYpBIHYvYmIpHJ8qT1VykH8hvGlC1UGzOXv0vFeDOHPe2pNNP4aeSiT0pBdxeNwCge3svBodG9WHmE/p523aD3N
X-Gm-Message-State: AOJu0YwoJZXEblnd0q6sDAsDu2qZMpKhWg4QsGuyndkUNafqq+JHY+A2
	gCsrCJ/u8QcbaLpd3dmJ3KHy4uidIYq6AEUwjoa2W6pZt5m0rTe+zm8kGp0REqg=
X-Google-Smtp-Source: AGHT+IFgYFCnESUw6iN6J+ZbQ2mgU4JikyHrl7BKDBQRaTZ5P417GpeMSdUA1tYffFqVseAU4uAeWg==
X-Received: by 2002:a50:9548:0:b0:572:a16f:294 with SMTP id 4fb4d7f45d1cf-57a3644b930mr7917381a12.30.1717504724455;
        Tue, 04 Jun 2024 05:38:44 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a81f1dbd9sm1152023a12.93.2024.06.04.05.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:38:43 -0700 (PDT)
Message-ID: <402aa998-8b3c-4c3c-8dcb-f128b6ddac46@linaro.org>
Date: Tue, 4 Jun 2024 14:38:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: Make the PCIe 6a PHY
 support 4 lanes mode
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Zl8GoRoY9lXRtg2R@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/24 14:20, Johan Hovold wrote:
> On Tue, Jun 04, 2024 at 02:00:10PM +0200, Konrad Dybcio wrote:
>> On 6/3/24 14:52, Johan Hovold wrote:
> 
>>> As I just mentioned in my reply on the PHY patch, this does not seem to
>>> work on the CRD were the link still come up as 2-lane (also with the
>>> clocks fixed):
>>>
>>> 	qcom-pcie 1bf8000.pci: PCIe Gen.4 x2 link up
>>>
>>> So something appears to be wrong here or in the PHY changes.
>>
>> Is the device on the other end x4-capable? Or does it not matter in
>> this log line?
> 
> Yes, of course. It's the CRD as I wrote above, and you can tell from
> other log entries:
> 
> 	pci 0007:01:00.0: 31.506 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x2 link at 0007:00:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
> 
> lspci and what Windows reports.
Ok, good. I was scared of double-sourcing of parts that are not identical
in spec..

[1] suggests this wasn't ever achieved.. which makes the cover letter of
this series a bit misleading..

What does the TCSR check return? If 0, can you hardcode it to 1 and see if
the link comes up at x4?

Konrad

[1] https://lore.kernel.org/all/Zl8H0KOrfuF91kpZ@linaro.org/

