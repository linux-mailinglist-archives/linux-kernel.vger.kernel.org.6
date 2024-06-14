Return-Path: <linux-kernel+bounces-214528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F016D9085FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8DD1F23619
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D001836E5;
	Fri, 14 Jun 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FrzuS8rP"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C761836CD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353011; cv=none; b=oxcyT68LgaHw9HOa1L3aU4xrNevutsI0VoZTQDg9DklTnvCQvL6JaHxlJKiCti+DJOT/qMhHvMmttXK5D8Tz8DASnK5wwkBGjDK6WB8OREiBchXy0zDwK6pWzJyihYIEphi0+jqKARX3U4xxz7fesDfqr+CElNAqKnsqGAxAOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353011; c=relaxed/simple;
	bh=nwE7qH3et0xBAyB0MTDxfmgBc8lMSr+/9XrUUisIykQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa9aKPwyuovdznhOch5Lv2bwbzA6kAkZXlOCBr/3Usb8vYj6/foeBjysy3yw0E8mD+dl5nJ7xxv6jgPq6wXwchDUpUXRhAYx3eEjZP7xXW3KSVwuDhFKnrbe5M3tZhymdDb8cHCulk6znkobA2FlJrOl5w35sHlkeB58oV1PA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FrzuS8rP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso30546021fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718353007; x=1718957807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGmOzn1R1K16dkDMQJjEQ6wgWuo7/3DN6CTKOSNpNgg=;
        b=FrzuS8rPAQXu5iSoydjMExSyF0JG+sUoXV2L9KKhAr3STgNHLgSQy3RJ9DFISFD2jh
         RJIaamNFcx6y3QzFGFgMkyXtZyCs3N/Yd4Ri0WILV4SqrgR6wM5wx5icfRFqrqDfCBE8
         GAZMoQdOeh1DYaZH/6ezzQCTaZPlDO/Xbj3lX3VijjB919wqP/MjTs56z4GU9mYxD394
         swGKG+ChzC/dgP+gb1DZ2njamktxwk17e3LYy/vZJqeZxD2GiFgoVdwvgeNk9ewvYBGy
         bZ5MXFrOwPGAf9etp/CNI0NbjA01Pwt7qNSRL8k73q1bkneRy6TvuZp5RQrUdyxbzua6
         Wg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353007; x=1718957807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGmOzn1R1K16dkDMQJjEQ6wgWuo7/3DN6CTKOSNpNgg=;
        b=lXLV0kF9vSL95qE6wlt9M0q+Rm33yOz5rmWGG9/lVGvFkGPsMnM+M90ZFRoVmWDj/5
         lcGBJqO0c6He0ysKUNP8nenAzX6gxHDQcamZ5p7kWHuPut1iEyN1juTrWtLgwWis8Ib+
         T3N2VjNzpuFqtL+7N7Fh8FrcC/+UvlOGSv9pe617rVnEcqwfTwStmhYd4MROK1tY4nRb
         wPss9osPWDHYtf/+xUuWsaa1+XjoKZMEfR5XvmKGjDugFWeS8JL/iDcpZ6r2ez8L7jkK
         yO6PtHd8ypwaz5uoisTHyzQLcWOgqb2FHbjwnxPYbd8T/tzDs9IxV0mYr4BN8N9FEkcg
         6hGA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCBxuY43Cew1Lt4yfU9XdbF3ZdzHIYjgPaz9zBr6bXG7nPO0LmHOSvnFDOb0LpfD//H+YyPUFDGqGTCljs0ZHL5Un+7uWJduaI4p5
X-Gm-Message-State: AOJu0YyWVs/mlXQ4WvObXlqVURA6TKS33gy+YthdOZ1+qN+VSezhSb5Y
	L5ftAp7hiV74zvQXmn4zEcV5hbc4W28wvUX59CWSEf/F70Uhp0nMBhNI9VB2jzc=
X-Google-Smtp-Source: AGHT+IGdVz9wnYuErYpbzpZPBaxajSeBzfE2NEQMkvFihFynmrdBmCln5caVCr3TFMsMNsUcb/jj1Q==
X-Received: by 2002:a2e:7d03:0:b0:2eb:e56c:c90a with SMTP id 38308e7fff4ca-2ec0e5c8c3dmr14354061fa.43.1718353006713;
        Fri, 14 Jun 2024 01:16:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127c6fsm51121795e9.24.2024.06.14.01.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 01:16:46 -0700 (PDT)
Message-ID: <d6b4e0cc-c16e-4ea7-bbc4-ddbaaadc9a25@tuxon.dev>
Date: Fri, 14 Jun 2024 11:16:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] dt-bindings: rtc: renesas,rzg3s-rtc: Document the
 Renesas RZ/G3S RTC
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "lee@kernel.org"
 <lee@kernel.org>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
 <20240614071932.1014067-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464811F43F19115FCF62A786C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113464811F43F19115FCF62A786C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 14.06.2024 10:53, Biju Das wrote:
> Hi Claudiu,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Behalf Of Claudiu
>> Sent: Friday, June 14, 2024 8:19 AM
>> Subject: [PATCH 05/12] dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RZ/G3S RTC
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Document the RTC IP (RTCA-3) available on the Renesas RZ/G3S SoC.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  .../bindings/rtc/renesas,rzg3s-rtc.yaml       | 60 +++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rzg3s-rtc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzg3s-rtc.yaml
>> b/Documentation/devicetree/bindings/rtc/renesas,rzg3s-rtc.yaml
>> new file mode 100644
>> index 000000000000..0e17f8a36155
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/renesas,rzg3s-rtc.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/renesas,rzg3s-rtc.yaml#
> 
> Please make it generic renesas,rtca3-rtc.yaml. Future SoCs may use this IP.
> So use IP name instead.

From what I know the file name should correspond with the compatible that
file was introduced with, and this one shouldn't be generic but SoC specific.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Real Time Clock for Renesas RZ/G3S SoC
>> +
>> +maintainers:
>> +  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: renesas,rzg3s-rtc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 3
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: alarm
>> +      - const: period
>> +      - const: carry
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: RTC counter clock
>> +
>> +  clock-names:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    rtc: rtc@1004ec00 {
>> +        compatible = "renesas,rzg3s-rtc";
>> +        reg = <0x1004ec00 0x400>;
>> +        interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "alarm", "period", "carry";
>> +        clocks = <&vbattclk>;
>> +        clock-names = "counter";
>> +        status = "disabled";
>> +    };
>> --
>> 2.39.2
>>
> 

