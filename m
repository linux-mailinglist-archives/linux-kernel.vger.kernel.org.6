Return-Path: <linux-kernel+bounces-271130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86DD9449E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D181C24410
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F55188013;
	Thu,  1 Aug 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3V0h7C0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53A184529
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510014; cv=none; b=XXGltpSSjiNyBd/961ickV7yCP3xx0gjE3iZYezdSy35AhzWwLnNQmhfOdSOkc7+CfEaIHvQaGwOg8ynZQpYrAJITOIGV7Z+r8zWVj9caiuULb/yta0Wn/76HsJC6Xl9a8payOERNTlrZ0Gy/+7lbkih4eQLyT+Goccw0aUNuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510014; c=relaxed/simple;
	bh=lGsquQLMtx6JtZ5cE+/NHCjgtnCFyHLf7m/m7jXcv4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvahoLEAPWZrEDfXIEE18kqG7xKbKb86bDuR2X8N6QRVDb0i+ZY0GzSE6cZAx2a31PuXYDr1ow4JjEqysjDYnEAPIWJ6/ZQP3KOjBmRRmV9RN3dEiszRrC14dugOCvMkpx5RoyFkhcIVNTqjkky/lfTqAccOsEPPMujbkYgmWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3V0h7C0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso613843366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510011; x=1723114811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nixP02A7oEt1hy5pTWT9vtqylJ4GWCAGniHQdRCLdt8=;
        b=K3V0h7C0FSt/ef9PiulAK/Rpx2OHw9EmzY1Soh0PmfEnPAWfDxDUClQr5cnDynSMLZ
         Pl9Iv3sG9x7Y/Do8BvlxkCN1rLOWI04rja3FREGGpcA4lnYt/FVv9I9yWEPyn16bRiZO
         5OuXAcwUNu8gpptZbZNbzrElMEchXI0jos54MDvm7m8Lu5uJflFA07zwhwLmwKEW6G1U
         0gRN22iJf9EA1ZnaF9byqg6Tb9rFT4NDTpnu1cakAOoNKv1ag1a8d/s3Yd7AIW85AoOO
         SAoUIChARdvYRfq0sgJ/urnphugJdlcEdW3811j8g9IpnE841QFL74wagEKbOaZu2sfP
         fjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510011; x=1723114811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nixP02A7oEt1hy5pTWT9vtqylJ4GWCAGniHQdRCLdt8=;
        b=nEWSkrmFm7vZ/qYbRnX6cFpbF4K3CgsOdPntTJPYEoiXtFLCHaniVGRrYY0XUQbn+I
         IC7UfakW7e75rkl2zde5F1eYjCiT6GvBZOoSSpkwmNo8rn4NHi3pJQwwuGcOR5tle1vp
         gbXU9BhwvkiWO5Ew9bajthMcJX0Jh/a0dLf4yMKzXW69orFfgKSefxmmqDIP6VdtTQ9f
         WPBhQ6Xwxge4VVzDl49eyQ+3wDZoWaZ57hRbzGCuo0WeC569BeKAk2S0/AqecnRKCeJm
         t/Bxn3vEt+r6MQ4048pefLDB2s/FjzQe+wu6qr2D8D78ZVsswSysw++3idPNDS9IRWoC
         stvg==
X-Forwarded-Encrypted: i=1; AJvYcCVRBYXDHY+AgpBu5UQdZV0TD/AJLaCQHb6s5tvRmdieydEmOYyTjShJjOQk0vPWhrP8kNCXwR6kWbx3gqfTQKJ0iZB6N6gLLbURP2Xt
X-Gm-Message-State: AOJu0YzyzR8xJUCzgkxdxJc/7E1aT8YcQ2wNGrmCYbCf98/9oMMasZBV
	3Vs+18r75/zczpdACn+CEwNHGK3QwgQwRSkRSgeQdzoMkkaSNc0X2r9mLKr82gXSfY3GLTW8zJS
	DF/0=
X-Google-Smtp-Source: AGHT+IFBiJe1UjzoCyX9kFv29xIjXEtAXD5xStRwHkeZ85VlS8x4P0YsI/ql+ZacL9kzRRMapdJh6Q==
X-Received: by 2002:a17:907:3e1a:b0:a7a:81b6:ea55 with SMTP id a640c23a62f3a-a7daf675ae1mr160437666b.56.1722510011086;
        Thu, 01 Aug 2024 04:00:11 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4acd7sm902707366b.140.2024.08.01.04.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:00:10 -0700 (PDT)
Message-ID: <95e16e32-1f40-48a0-9c19-4a58e7d8b780@linaro.org>
Date: Thu, 1 Aug 2024 13:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Enable EUD on Qualcomm sm8450 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Elson Roy Serrao <quic_eserrao@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240730222439.3469-1-quic_eserrao@quicinc.com>
 <023d4ea8-635d-435f-bae2-87284f70123b@linaro.org>
 <1fcace72-a886-49bc-a30a-fde5a1de7a25@kernel.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1fcace72-a886-49bc-a30a-fde5a1de7a25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2024 09:55, Krzysztof Kozlowski wrote:
> On 31/07/2024 13:13, Caleb Connolly wrote:
>> Hi,
>>
>> On 31/07/2024 00:24, Elson Roy Serrao wrote:
>>> The Embedded USB Debugger (EUD) is a mini High-Speed USB on-chip hub to
>>> support the USB-based debug and trace capabilities on Qualcomm devices.
>>> The current implementation lacks in below aspects that are needed for
>>> proper EUD functionality.
>>>
>>> 1.) HS-Phy control: EUD being a HS hub needs HS-Phy support for it's
>>>       operation. Hence EUD module should enable/disable HS-phy
>>>       accordingly.
>>> 	
>>> 2.) Proper routing of USB role switch notifications: EUD hub is physically
>>>       present in between the USB connector and the USB controller. So the
>>>       usb role switch notifications originating from the connector should
>>>       route through EUD. EUD also relies on role switch notifications to
>>>       communicate with the USB, regarding EUD attach/detach events.
>>>
>>> This series aims at implementing the above aspects to enable EUD on
>>> Qualcomm sm8450 SoC.
>>
>> Are there any plans to make this feature available for folks outside of
>> Qualcomm / an NDA?
>>
>> There is an openOCD fork on CodeLinaro but it still requires some
>> proprietary library which is only available to folks with a quicinc
>> email as I understand it.
> 
> Are you saying that there is no fully open and available user-space
> which is necessary to use EUD?

Yes, exactly. Tools must be obtained via the Qualcomm Package Manager 
which are not available by default after making an account and signing 
and NDA.

Kind regards,
> 
> Best regards,
> Krzysztof
> 

-- 
// Caleb (they/them)

