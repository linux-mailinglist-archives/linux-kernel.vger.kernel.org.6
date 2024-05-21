Return-Path: <linux-kernel+bounces-185105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40C8CB098
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8E1C21593
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E4142E61;
	Tue, 21 May 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bFVAHxie"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5314290C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302497; cv=none; b=lQCTZ3AG6cBocPWsCwv8KvB/LFkCmMvopAOXb9bPQYeWTFvUXLijH2KCp4f6mOOL63EY6wZzUOx61C4rnruq43quSP7KRvf3jdZAgbCKKLfk6ZUZczIMilJ6ycERkd6DfG7w5esIoEuiTWIwJuH/5/2CbXEo5ndybNqrly9BP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302497; c=relaxed/simple;
	bh=nZ1k0uetES8u8MlD8iJUWjUc76+6FpZkYnzMg83sWbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHMs+f4ez4rpadu6SXj6vhZTtOC0yBokSlBelAuLsP8UHWbfDHUU5PpgwgTaZ2FHaUPDxmqeVvhgyUKvXRZSbjcYNIRuh4cA+n/EPtBhutoLp5Q4VWkjpFXndJ7sPHV7lUr39isnmB5hK0HrAd8CgavgSVt21+nrjWrN4zeJXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bFVAHxie; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so2805381f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716302493; x=1716907293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZ1k0uetES8u8MlD8iJUWjUc76+6FpZkYnzMg83sWbo=;
        b=bFVAHxieuQVjKck7HTM7uyqnBMRA5+8K6e1D0lKLtcMXg1K9abX455xrGOQtqmdy/N
         MxfAwCutRAHQpNhbyCeEDQgzSmAxRJ+jduKZJE+RYSt/Y/013h6bHqhSY2IxWU6HYS6F
         xAIopEhpomgvfMWAVqzpt8xnmYgFhMlbdAPyBB9qApkgZkiYsHMpD0YSP0SstDXtbByH
         y13mcAdN8nIRSLsCs/pL6LOwor+CsCPuoq4iitkRtRGX43w98JWyT5xvFNfUQWNtC/vA
         jIWr1GaKvXu9xoThtiLe9mU6IY2ktXKzXOCRSBnGdbmDVSe4DrH893zG0S9hkUAQdV3N
         wgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302493; x=1716907293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ1k0uetES8u8MlD8iJUWjUc76+6FpZkYnzMg83sWbo=;
        b=HLqvCdehQaETyr3sqp5ykzTHU2BzQn5rUyCFlANZVUJ4eyIVA8GlXnN7hZfq/gyNFD
         Yr/1UaUu2naOQ36dGgr9qxe08Pyx3ZzpWADx+JqCWPlUg5eOst9k9HZ4+xb9rNUVUVbE
         BS+P2XVEprYCAIZ2sQYZ5rb/+OjsVnHyzuqLW063PCxnxCrdl9wjEFwKJ/0g33PS/vd2
         Ck9kp+s30tiWIDxHjNps6TL/C2dtt6nnKQDbTk5VEYCV4S2Jyg9MB3UX39ZbfbljjEIe
         uFec/HWTGkBjBD8LmLPgKOyQRdfzqUR+WsRsysfkzz8/NSzf0ufyDM58dt/dXqH2/lcP
         cDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMrg8OMTEpIUbE9XGPQiUWywt5YA2Q4jmCKCY7elGmsf8OmmJSdLynRPrY8DV+GimEhsAs66edpks/otpkbkmrRj4YVRW/VE/bCsom
X-Gm-Message-State: AOJu0YwzB/nxfIh0rrq1hGAe5nz4zaxam3vcT42Q4ge2Pi0RUBVYbUNg
	tNvnqZj7kO1r7gKAaGYwVzt3WqyBMaYEUl2f8zAxc+nq1NmNIrr9FlHi+Adql/E=
X-Google-Smtp-Source: AGHT+IHj1hRyPZRmpYHWeU3LYRrDP7CJ224DzJ6GRA/c94bv1YnN1lYSiHKxZR3Gf4iM4ruXYyQNOA==
X-Received: by 2002:a05:600c:1794:b0:41e:454b:2f7 with SMTP id 5b1f17b1804b1-41feab40be5mr262645805e9.23.1716302492758;
        Tue, 21 May 2024 07:41:32 -0700 (PDT)
Received: from [10.2.5.115] (abordeaux-651-1-78-161.w90-5.abo.wanadoo.fr. [90.5.97.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff5e3dcfbsm428288055e9.22.2024.05.21.07.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:41:32 -0700 (PDT)
Message-ID: <8078d106-0173-4f04-aab7-4b2726b0bb3a@baylibre.com>
Date: Tue, 21 May 2024 16:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: mediatek: mt8188: add default thermal
 zones
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
 <20240521-mtk-thermal-mt818x-dtsi-v4-4-b91ee678411c@baylibre.com>
 <ff12e104-da8b-4800-bfbe-a006ffe1b840@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ff12e104-da8b-4800-bfbe-a006ffe1b840@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/21/24 16:19, AngeloGioacchino Del Regno wrote:
> Il 21/05/24 16:05, Julien Panis ha scritto:
>> From: Nicolas Pitre <npitre@baylibre.com>
>>
>> Inspired by the vendor kernel but adapted to the upstream thermal
>> driver version.
>>
>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 432 +++++++++++++++++++++++++++++++
>>   1 file changed, 432 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> index a9f1b9db54a6..2b0f3e03acc1 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> @@ -12,6 +12,8 @@
>>   #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
>>   #include <dt-bindings/power/mediatek,mt8188-power.h>
>>   #include <dt-bindings/reset/mt8188-resets.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>>     / {
>>       compatible = "mediatek,mt8188";
>
> ..snip..
>
>> +
>> +        gpu1-thermal {
>
> You forgot to implement my feedback to Nicolas - this must be gpu-thermal

Sorry, I did not forget. I just did not understand correctly.
Even after looking at mt8195, I thought that only the '_'
in 'cpu_big0-thermal' and 'cpu_big1-thermal' were wrong
in v3. Thanks for making it clear.

>
>> +            polling-delay = <1000>;
>> +            polling-delay-passive = <250>;
>> +            thermal-sensors = <&lvts_ap MT8188_AP_GPU1>;
>> +
>> +            trips {
>> +                gpu1_alert0: trip-alert0 {
>> +                    temperature = <85000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +
>> +                gpu1_alert1: trip-alert1 {
>> +                    temperature = <95000>;
>> +                    hysteresis = <2000>;
>> +                    type = "hot";
>> +                };
>> +
>> +                gpu1_crit: trip-crit {
>> +                    temperature = <100000>;
>> +                    hysteresis = <0>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        gpu2-thermal {
>
> ...and for consistency with the other SoCs, this must be gpu1-thermal.

Now I think I get it, thank you.

>
>> +            polling-delay = <1000>;
>> +            polling-delay-passive = <250>;
>> +            thermal-sensors = <&lvts_ap MT8188_AP_GPU2>;
>> +
>> +            trips {
>> +                gpu2_alert0: trip-alert0 {
>> +                    temperature = <85000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +
>> +                gpu2_alert1: trip-alert1 {
>> +                    temperature = <95000>;
>> +                    hysteresis = <2000>;
>> +                    type = "hot";
>> +                };
>> +
>> +                gpu2_crit: trip-crit {
>> +                    temperature = <100000>;
>> +                    hysteresis = <0>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        soc1-thermal {
>
> Any idea of what can "soc1" ever be? What measurement point is that?
>
> VPU? IMG? INFRA?
>
> soc1, soc2, soc3 make little sense.

No idea to be honest. I'll try to find out that information
and will change that in v5.

Julien

