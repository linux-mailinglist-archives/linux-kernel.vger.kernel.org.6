Return-Path: <linux-kernel+bounces-343242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB77989881
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9911F21928
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BBD17E44A;
	Sun, 29 Sep 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luRI31vA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3C3D96D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727654261; cv=none; b=qmV3BVbnhxQVvlIQgmKWUYrRIx4CWbHd++DwSCgEl8e5s5KUqJLy35Uo4FsAuRZA1oI2mT577Sg4eOYXHvw9pkff/9YjbIxpyrFghGLFOdd0olNTOWGV2X5q2entyp135ES5bi7OZMZEwQVjA+dkpJyYNvAcpcA6IwnaD48cK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727654261; c=relaxed/simple;
	bh=HaXo0toqOF7Y+jB24eT1VlknmgOwcedF3GO+Ll48qjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGhxFonrCYICE0nehJnmyUmmkTeNwBRikPLphuZFgAKRte/lB5/HKBSzLiOm6ILAIo+1HMKUCLP5nUXA/1Jyafrn2ZLB6CTpNKmoA2CJCypAL7/dE9yzh299O/DfUPSSvAIyctOWs6xT+Cf3ks+bu0M2d36Z0L4HC0M3KNXg7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luRI31vA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a93b2070e0cso462027966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727654259; x=1728259059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJrt6UWom7A/xyTFs1oFeQLFFYTQTqna27U8+xF6ZSs=;
        b=luRI31vAhd0lCTFbpvCWmlp9+0kozyYm3yf624KPVeExHxw9y03w6hNIyRa8CrTaKX
         /QSwQssn00maDqNvcEmy4xX5ijya0Z88K1i342ymjx6WofIIYv59lNVg7/nVF4g2hdkn
         NhzlDCw6EuxDTR1GUvfLIDxhThg6YqPOiQ7vk44YqPRGDN5066Qc3kk1F/Fe+cFJ+HNr
         NE6jYlvxpLAz6RnqnxhSR+X7pXNlLUHcvxOsXelaihPUj4mH/D0YsEHZcJKsScytqK/6
         tpFDa6bvyQmcfZkI9RwHW1l0UzmM7k0EgvTxECmZFcCWlnWZhhTOJPKrjimuJk6hztia
         2MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727654259; x=1728259059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJrt6UWom7A/xyTFs1oFeQLFFYTQTqna27U8+xF6ZSs=;
        b=RdFRQGFpdL8LDqnmvr8pA62Z+jmlErIOj88LzGPOZ1MZIglOXLy5DaVXFi6G8Ppaeb
         Ei2FLPNsD8hdWR4mnKS7S7fHxq/Hp585WCjZmYJ6ERO/i+vOmfr2lyPz7VlvLPOnjLk+
         ykBFd2Rji7hCIviGLDX4qP6556mpPgbGvs1Nzp1QbwxCyQ66faezb1sRreBshXlL+Lzz
         B33QQ8v2VzAzF4rfYYxa99sO5ZnryP2lQ++Y5LacHf+zE/8dW2h9OqupefiKAODuY3+D
         BCzUFz8X28G7kKx+zFx7VQLiKJMcCzPVwD9llMAFgjazUQ107XSCChEOH0LORAdtI8r9
         H8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWiqEl0yaTjVnWghTj72dv7imRa2ccM3xmoAzU1LcajGCkLEHjoMqC+3teXmVSANw2xjZoFJjn0qVODMX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PEbGL1SdPykpPrpj7s5UbPJiiTThUbjXbsG1tipF3P/wZAGB
	gjHgHek9q3buaslUrwMBECo1SX9hcdZu5zcD7qguvZ8q99rptOxj5zexfN44fTU=
X-Google-Smtp-Source: AGHT+IHIuAFzumpcyKBz+LueTVTgTI2SycPOicG0Iw7ZflSGBVkIXpdr88atR9QP+oiJTpCvoWA5+A==
X-Received: by 2002:a17:906:fe04:b0:a8b:6ee7:ba29 with SMTP id a640c23a62f3a-a93c4ac9401mr1138374166b.44.1727654258502;
        Sun, 29 Sep 2024 16:57:38 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c593dsm444079266b.54.2024.09.29.16.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 16:57:37 -0700 (PDT)
Message-ID: <6b702201-4418-4bbe-95b2-50039c08b4d8@linaro.org>
Date: Mon, 30 Sep 2024 00:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] media: qcom: camss: Add support for VFE hardware
 version Titan 780
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-14-quic_depengs@quicinc.com>
 <6ddaa41b-86cf-44e5-a671-fd70f266642b@linaro.org>
 <eb77972c-9c9a-48f9-b850-21e6c2df005a@quicinc.com>
 <d842a992-e04f-4a11-abaa-da50808fea77@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d842a992-e04f-4a11-abaa-da50808fea77@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/09/2024 02:28, Depeng Shao wrote:
>>>
>>
>> Thanks for catching this, I forget to add the rup irq, so this logic 
>> is also missed. I have tried it just now, the logic works good, will 
>> add it in next version patch.
>>
> 
> I go through the code again, and find we don't do the wait for 
> completion in VFE 480 driver, this is just used in VFE gen1 driver and 
> just during disabling port.

Right but, we _should_ wait for completion there, the fact we don't is a 
bug.

One context issues a command to take an action and another context in 
this case an ISR has to fire for that action to be complete.

Therefore we _should_ wait_for_completion() in the initiating context 
and timeout if it exceeds a reasonable timeout.

Granted, we've "dropped the ball" in 480 you're right, it needs to be 
fixed and will be but, please in your submission do the right thing.

---
bod

