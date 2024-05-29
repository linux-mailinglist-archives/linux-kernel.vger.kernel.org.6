Return-Path: <linux-kernel+bounces-193820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C68D32A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1791C2328D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360A169AC1;
	Wed, 29 May 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jb1q293q"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA1E888
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973940; cv=none; b=rV+GAy+5py6K4PW7vELrclsSkXd7YJelrT9k/EGzXuq2qL4hdPplzlTOeYy6PqliQvi8ID5McbL3f/rrv5B2mD1ZP9Hz0l06ot1a+K+xOrAb0DR+9vJRK3gTE0ecFH57gEX0Ib9pH6qQTv3GM9XGhhBVmFXd7F0VwoyBNJyEK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973940; c=relaxed/simple;
	bh=0QL4BvsTjLA5ayAniWR5sm/TXQpiVSWPTQlZGz10zV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWIC5zkSXOVXV5JrSym2QtCTOLapnUQZmC1qmXP6aZmHdp3J1xU87sHIZGBR75EoIgjcHf6Q2OLB5MozJuX+cS7LtkPJDqdVIPvEk+6d1k9ip/5EsH5XhmbnBOegHryzbVXzmBRHMtJF4OkNC6zNuFSy5WVkTR2I4HEVYwpfg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jb1q293q; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so1748930f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716973936; x=1717578736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciTtYKEbBr+vQK3oiFVI2dnU7hwIdnBzRqy3mCB0PTM=;
        b=jb1q293qI9vAJoHURlEOf8Cn5tWvv9VkArgEGFlrCELK3M8icQFATwhEr37FtPp5iC
         9SqN3QzOaWuikA760gUPv3+Px6Trv1+Lr/TY1GbBr80Ox3xJ4di+zvwwCDM1OPbmlRFg
         CPOZiOiS0On4+VoM4h0k7CEBdL24ExtsmOKxDNLHgemLsp1YdnDG/Fiy45pERJsN56PK
         HDddmZT9hQkK7RjhnI1C4Z37P6mAEoR8LBAvtPiFPTW5hyLvLLIEsA6a4HdvIwD6u51O
         ye8yhxaoxny5FI0SiHj7WcBNNtfNxx5Sz7p7HNY2/tpopVG+kryUuRZG8IIY6JZIoANJ
         jENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716973936; x=1717578736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciTtYKEbBr+vQK3oiFVI2dnU7hwIdnBzRqy3mCB0PTM=;
        b=iM/Wi00QlY3GfpipE+PEqGfGxUQH1A0f8RS5Dsidd7zwuV2ROu/NImy2P31QA6HAoD
         tiFew/xVyqC1IP/tEPcAmKgh0k+3gYOLiJzDHTR4/LbmcgX4lGPfi1reE0jnmg6Wra2e
         OUGt5xDn/Qgo8tvD9QxF/yl49heZs17BsSg9YlPeniahOz5wWX49lMrlvJlmJKrUEiST
         e3O37zBlQAcfOYl6MlDoYfHczpidMQrwHT0DueW4pNkyufMt+yzM9jO9TEd7Ncu2cejR
         Oz+V6gwU+efb2lPbH5NsMpA/orhq6jZkecykZWXt2AAU9stmUurFP9YeUCpo7tLyzliZ
         EbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTWp1kn3712DmKXLkSBQ5FY51Ib4Ej5aE0NAKQp4zaAZJCvAt435Ug/phi82bI/ObkOlrYjUjYwaNSWBd185AFMK7yLkFgvheIorxF
X-Gm-Message-State: AOJu0Yxj37w7dub/379nHgAIyzpeeh9U6sp9/3j94HBE68m/iKDhO4sp
	diZ2xfKhuo2AQiLrWs+LJyFGAxoYcve/L7wNVKuUTM0MVztvOo2L6wuJltQiKug=
X-Google-Smtp-Source: AGHT+IGzTz+2XrrYGSweYUU8ur8Euj8k3ViZtqjUVGNlAHrRa8447ANMpaIZTurk5qHKqtB4e2nxWA==
X-Received: by 2002:adf:ee0e:0:b0:354:e729:c101 with SMTP id ffacd0b85a97d-35527056972mr12104266f8f.12.1716973936132;
        Wed, 29 May 2024 02:12:16 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c92f8sm14111197f8f.67.2024.05.29.02.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 02:12:15 -0700 (PDT)
Message-ID: <808db317-4cee-426b-a840-013a5e03098d@baylibre.com>
Date: Wed, 29 May 2024 11:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal
 zones
To: Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
 <75826085-fd59-466a-b1de-b4c323c801c1@collabora.com>
 <CAGXv+5FPG4ob3mTU0Utm8Wgk0_ZLw=NLPbfFerWh4OUeAz7UHw@mail.gmail.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <CAGXv+5FPG4ob3mTU0Utm8Wgk0_ZLw=NLPbfFerWh4OUeAz7UHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/24 10:33, Chen-Yu Tsai wrote:
> On Wed, May 29, 2024 at 4:17 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 29/05/24 07:57, Julien Panis ha scritto:
>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>
>>> Inspired by the vendor kernel but adapted to the upstream thermal
>>> driver version.
>>>
>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> I'm getting some crazy readings which would cause the machine to
> immediately shutdown during boot. Anyone else see this? Or maybe
> my device has bad calibration data?
>
> gpu_thermal-virtual-0
> Adapter: Virtual device
> temp1:       +229.7 C
>
> nna_thermal-virtual-0
> Adapter: Virtual device
> temp1:       +229.7 C
>
> cpu_big0_thermal-virtual-0
> Adapter: Virtual device
> temp1:         -7.2 C
>
> cpu_little2_thermal-virtual-0
> Adapter: Virtual device
> temp1:       +157.2 C
>
> cpu_little0_thermal-virtual-0
> Adapter: Virtual device
> temp1:       -277.1 C
>
> adsp_thermal-virtual-0
> Adapter: Virtual device
> temp1:       +229.7 C
>
> cpu_big1_thermal-virtual-0
> Adapter: Virtual device
> temp1:       +229.7 C
>
> cam_thermal-virtual-0
> Adapter: Virtual device
> temp1:        +45.4 C
>
> cpu_little1_thermal-virtual-0
> Adapter: Virtual device
> temp1:       -241.8 C

It's likely that your device has bad calibration data indeed. We observed the same
behavior on the mt8186 device we used (a Corsola) and finally realized that the
golden temperature was 0 (device not properly calibrated).

To make a comparison, we run chromiumos v5.15 and dmesg output was:
'This sample is not calibrated, fake !!'
Additional debugging revealed that the golden temp was actually 0. As a result,
chromiumos v5.15 does not use the calibration data. It uses some default values
instead. That's why you can observe good temperatures with chromiumos v5.15
even with a device that is not calibrated.

This feature is not implemented in the driver upstream, so you need a device
properly calibrated to get good temperatures with it. When we forced this
driver using the default values used by chromiumos v5.15 instead of real calib
data (temporarily, just for testing), the temperatures were good.

Please make sure your device is properly calibrated: 0 < golden temp < 62.

Julien


