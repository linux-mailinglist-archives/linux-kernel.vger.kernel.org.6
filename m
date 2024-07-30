Return-Path: <linux-kernel+bounces-266944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87A940A26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088A51F25141
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589F19007D;
	Tue, 30 Jul 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdTSBTJO"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3618FC80;
	Tue, 30 Jul 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325473; cv=none; b=Xu65IaKematZUaJsM6vTIyPzznLHGNro3SM8uAEVItHTnksBS36lJUGBLXD3bUSsbAsixTXAevDNO4jIFfiflg+DqHfuKrCBK5kcHTaYzJlbgUglM2KwypY9E0tXWy022D4iuEYLBvhEqU9xZjcD1Tg6Vq0KGBr02h631bsSkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325473; c=relaxed/simple;
	bh=N9PmLv3ESEq4vrYGTcVlMOPN4DtUer7tuRF4Xxi/wXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIdWbx/ynLZky2PieIQxLXOLw6RK+x+M6Y0ek0n1eivMzmoKZ+4nV8eQoDul5TgBMwyM7SiL0PaFRsPnHxUD+NdNxmaKvL27kasUIssdNgq26/O3dDU7y3Kv1W0GDn2pdhjy4gb0HXNByPekJJdUD0sg7yMIqZUnvMBX7LhA6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdTSBTJO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70943b07c2cso1812085a34.1;
        Tue, 30 Jul 2024 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722325471; x=1722930271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNYxaQ9fql7AcxhX+8qLd2dvHKZ22065YdHw+3VqujE=;
        b=YdTSBTJOFgosihI+OLNSMyKizdLKKc8Nn3UlkvNxbbHyxBS3dSgU0dLwLltkMka0wA
         D9C4avLqwDplXG0TCjJ52YWVvoUi737xAajtAIrfV0AFM9WRXNXtLMvjoESbBZwc88hP
         W6Y7gXsGJmZB+06LnjqVF7wnwRf7F2undoKfzxxBDDtqqvgaJ0D49Z+w0RSG2qRwRah4
         skgzmnxUucuQMI+rxYL5BEqSlSWLbNbd9CPpSd+1ARbGPMydHqyl5QHWrUau5B13Abc7
         zLq5h8qn48HLF1l4Cb7rPozNQ2Vg3W9IjHO69GoAqg06KMAiwdM/o5+9L/dl9hpfKZOx
         eiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325471; x=1722930271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNYxaQ9fql7AcxhX+8qLd2dvHKZ22065YdHw+3VqujE=;
        b=iZYvFMmKEQZY3viMKksfcp0cGoaCpfibB2ji9ipCBBAHATMDAaabJgZuT4r7qbqlXW
         aH9CFuxvOlbVfrm0uKX8JF/BRGr92LgIuRABzPWz7UOKrfYM86ep7MI5Nmmz6lij2rhX
         SUSie1PPulx5J8U7prZQ1czp0VcTZYqtUnYwcL6d4frUd6YtF3pYgjusBkLFUuVXRA8D
         EizbyqXAMom5APK7N7jWhrTjn/HYRk/8nCemwCZbBrzWFwFqKM1jqVHdUAHaG4buPvxq
         ed51F1grEDwK46v6uuyZbaUtugtHxDG7RWC3Cvwr9jTdcnXE4toR6lO1dswU2/hFb2ja
         OsDw==
X-Forwarded-Encrypted: i=1; AJvYcCWYgfWDFh68PCcavNadIxY/ilT0IsXrUjH31uTEKLvms3j/+EWpAjzrjsvFOgiDajoynfryJZ5r/AumnXNtowRbRUAXwcqfB+rTawxpqtgrT+UM9m7pTJRukXsaJbN6kQcgKsvv6vylLQ==
X-Gm-Message-State: AOJu0YzXMNzRIxWB3wQYgKictq6d2lYWdJHjfShwqNj2+fnkLliHFWWs
	jXBaL5EdrUNr07WXSqTCTob6pmwwzSyAU/bs8z2zfCQaVNCS7QZclpwOJQ==
X-Google-Smtp-Source: AGHT+IHA3y9ineuFQRIfYwPGht449sZqVs7AGfDBI2LAtebiSKNfsBHTFgwPABi4zoEnD9vRCeMVdA==
X-Received: by 2002:a05:6830:6b03:b0:703:6434:aba8 with SMTP id 46e09a7af769-70940ba10f9mr16558955a34.0.1722325470596;
        Tue, 30 Jul 2024 00:44:30 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead813a19sm7867713b3a.117.2024.07.30.00.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:44:30 -0700 (PDT)
Message-ID: <37f1ecdc-9d98-4681-803a-75442fe04ab3@gmail.com>
Date: Tue, 30 Jul 2024 15:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
 <20240729061509.83828-2-hpchen0nvt@gmail.com>
 <c4c2b30a-8ff9-4fc4-a1ed-adcd366d15a7@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <c4c2b30a-8ff9-4fc4-a1ed-adcd366d15a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/7/29 下午 03:29, Krzysztof Kozlowski wrote:
> On 29/07/2024 08:15, hpchen0 wrote:
>> Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.
>>
>> Signed-off-by: hpchen0 <hpchen0nvt@gmail.com>
> Please use proper name.

Okay, I will make the correction and use the correct name.



>> ---
>>   .../bindings/phy/nuvoton,ma35-usb2-phy.yaml   | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>> new file mode 100644
>> index 000000000000..415ea2c45975
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/nuvoton,ma35-usb2-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35 USB2 phy
>> +
>> +maintainers:
>> +  - hpchen0 <hpchen0nvt@gmail.com>
> Same here
Okay, I will make the correction and use the correct name.



>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35-usb2-phy
> All other devices have name ma35d1. Is this a different SoC?
The SoC is the same as ma35d1. I will modify ma35 to ma35d1.

Originally, I intended to create a series of shared drivers.



>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: USB PHY clock
> Drop description, it's obvious.
Okay, I will remove the description.



>> +
>> +  clock-names:
>> +    const: usbd_gate
> Drop clock-names, you do not bring any new information.

Okay, I will remove the clock-names.



>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle of the system-management node.
> Describe what is it for.

Because this driver has some status bits located in the sys, it is 
necessary to reference the sys link.



>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - nuvoton,sys
>> +  - "#phy-cells"
> Keep the same order as in properties.

Okay, I will correct this issue.



>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> Where do you use it?

This is not used and will be removed. Thanks for the reminder.



>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    usb_phy: usb-phy {
>> +        compatible = "nuvoton,ma35-usb2-phy";
>> +        clocks = <&clk USBD_GATE>;
>> +        clock-names = "usbd_gate";
>> +        nuvoton,sys = <&sys>;
>> +        #phy-cells = <0>;
>> +    };
> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen



