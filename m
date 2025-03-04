Return-Path: <linux-kernel+bounces-543033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27836A4D0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207101891F98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D797136347;
	Tue,  4 Mar 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FerzzF4H"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555477102;
	Tue,  4 Mar 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051644; cv=none; b=gZY9RsfkMoTwW8S3S9e4qDgYbQ8xMloub+woVtK+S47h5lkFHGE4x4d/iNg2RqJENCL3O2kmWwh7zNcGnMV3iX7Xw0g+boOBwEZoZ4/AYlAtfJtjrvlTSAXnwvUQHdJ/ymBzrKR7S8JqfyYvKAr+L9VIpxDRN9TeTeTKFkZhr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051644; c=relaxed/simple;
	bh=YQeiOsS8sA5NXZ3BRFyUMePzRT1TRZE82gnAlYurqyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeeEimknKBTsZ1EI0eAGqeSNtrsWOP+f9D6lsqZKnBiwHjUfAnUIqmh6c//maUMIL9Di7uTHle58rMrnMwCeuZRPnYioDrALy+pX8QE1RjHBKUfqn+p0i2zr+h8YAEJ5ne1Q5NKZLdVdcCh3hhYTeR4my8o+LgM3D3dMK92mwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FerzzF4H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22385253e2bso58801385ad.1;
        Mon, 03 Mar 2025 17:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741051642; x=1741656442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBEXUn0LmSyIKU3EkgV+cVlF4cvjhGTO881KNfj3fOo=;
        b=FerzzF4HGLCGSu7KoFfmVsYUwo+MVsOvGtqIPwtTltovdH5OVQZ4t33YhWRDq0jgb/
         wYCex2tzxWvVcfR9ETRck8mxo8WCDYYHeYB4Lhq2O4yFMYYCX5oVOe4vHCRPusrWHSZw
         yhNol7YQoWvBhM42+8TpoV9XQSIVOKi8xO1uLDE+3jmx5nPKBZrpYhF9YaayIXlw94bc
         0BhP0EYka/NA6tl0mWvqK6ohivJYr+J7tUDY10nCKTMvt/a/IhLC6pLLcygvu7OIe2bu
         FLSP5gJQXp7KYUk0dOnWUPNujWyv9RiGzYQyt5qb6+jfsBJir1Hu5+0Hlu7+WEQzdzMG
         rQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741051642; x=1741656442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBEXUn0LmSyIKU3EkgV+cVlF4cvjhGTO881KNfj3fOo=;
        b=NT92r4fXAW+Wf/G1BZ1onFRLlsFtogZ6QKUKPw7d7RupCFKtnHcFujN7AQyWlZCv4O
         a0jXCrNVY4DifpyMKWZDqUHdr4dM5hWED061I/pt1XMAOnAC2XldB4Gxp8LMUPvBRyl6
         oCE2toDjSAzqK5hrn8iUWln4ARNyw1pqzkxyZ3F9kS9rziP7tQoY/aTCPGfC5+R54WPw
         6oXmzW+XGa4HJ53Xbdh5zo8vuzZJbQrDdLHw1WeQiwZXzjL7LgmKEKNhubQRlCV0QGUo
         PMI372itorP3bDPXNl0v0ES6PRaoRHzw2BcY2fPu5uLCSHPz1Ey4cAKlz67xo9cckhQj
         655Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBK8ci74TGuD8ALORJOGSSr+TAW6YNuIJ+eBaSpRJDbc2Z7/c39ZQ0zlWWVjcIN/tZakWmmOYDT7Q9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5oaDKtxuVANIxWkrzsd2aeM/HUalPSN3lgM2M6jKfZyRBVcT
	XpLV3dPKLplJpGpmd1FDLwaSQN96F8P4TiCacMJCF13NujL/WE+R
X-Gm-Gg: ASbGncuOGHxTh4S7cNWSxgMBfhFpT+CutmQpfCI/l4nz3yccQU/Vw44+4deZVm0fQcR
	/3hNEpsCeds6xwU+g06oGQ34A/OY7gW2ockDEdhZwaccgqHGxUYBMKE3xbbPDXqUrmCyzzmF7o5
	qwcrfqyPmO7ZEzmOtQ5uVMasnY8V4xSi+BV7c8ciJFuaMBhgr2KJtQn3OTxtsdPLRjCj2pJMMwV
	0REklZ1cZVwppRhJVbv9kZkbQNsP3xT2Ku/sZIXs+ACl3XbvbLAV8R5lYpnwsBQDuj8++r1xCy+
	y5PtSuNv7e/XsQ0rOov7ts7BqNcfY2oDqcfO7vMFoZKBo3p7k1X1RbxpVH8kis+jPCk/a2dHfHR
	1pr1LoQgR+QHm6Tg1hQ==
X-Google-Smtp-Source: AGHT+IEr30nFCYMOZeqRuWFTTayl8S2lFSGhI6eVrpSdWMcqpU3UpkD71EK2TZWiBnLaRqXGpuCfIw==
X-Received: by 2002:a05:6a21:4c85:b0:1f3:2c55:8d8a with SMTP id adf61e73a8af0-1f32c559139mr7168245637.12.1741051642433;
        Mon, 03 Mar 2025 17:27:22 -0800 (PST)
Received: from ?IPV6:2804:14d:887:95a9:849b:933a:ba2a:b462? ([2804:14d:887:95a9:849b:933a:ba2a:b462])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf20b8sm8989367a12.7.2025.03.03.17.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 17:27:22 -0800 (PST)
Message-ID: <7ea9fb0f-f7bc-49bf-965f-631514abf9fe@gmail.com>
Date: Mon, 3 Mar 2025 22:27:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
To: Vladimir Zapolskiy <vz@mleia.com>, tglx@linutronix.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250228034021.607135-1-leo.fthirata@gmail.com>
 <09acba97-70e1-448e-8453-c4e1f67a035c@mleia.com>
Content-Language: en-US
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
In-Reply-To: <09acba97-70e1-448e-8453-c4e1f67a035c@mleia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vladimir.

On 03/03/2025 1:27 AM, Vladimir Zapolskiy wrote:
> Hello Leonardo.
> 
> On 2/28/25 05:39, Leonardo Felipe Takao Hirata wrote:
>> Convert NXP LPC3220-MIC to DT schema.
>>
>> Signed-off-by: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
>> ---
>> Changes in v3:
>>   - Add interrupts property description
>>   - Fix interrupts items descriptions
>>   - Remove else condition
>> ---
> 
> <snip>
> 
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ 
>> nxp,lpc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/ 
>> nxp,lpc3220-mic.yaml
>> new file mode 100644
>> index 000000000000..59e8814a15b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
>> +
>> +maintainers:
>> +  - Vladimir Zapolskiy <vz@mleia.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,lpc3220-mic
>> +      - nxp,lpc3220-sic
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  '#interrupt-cells':
>> +    const: 2
>> +
>> +  interrupts:
> 
> Please put here
> 
>    minItems: 2
>    maxItems: 2
> 

I didn't add them in this patch because example-schema.yaml states that minItems 
and maxItems are already implied. The following code is taken from the 
example-schema.yaml.

items:
   - description: core registers
   - description: aux registers
   # minItems/maxItems equal to 2 is implied

Besides, adding minItems and maxItems triggers the respective warnings:

- "minItems" is only needed if less than the "items" list length
- "maxItems" is not needed with an "items" list

>> +    items:
>> +      - description: Regular interrupt request
>> +      - description: Fast interrupt request
>> +    description: IRQ and FIQ outputs of SIC1/SIC2 to the MIC.
> 
> Having both two descriptions under 'items:' and another description is
> excessive, please leave only one of two.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - '#interrupt-cells'
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nxp,lpc3220-sic
>> +    then:
>> +      required:
>> +        - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    mic: interrupt-controller@40008000 {
>> +        compatible = "nxp,lpc3220-mic";
>> +        reg = <0x40008000 0x4000>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +    };
>> +
>> +    sic1: interrupt-controller@4000c000 {
> 
> Here sic1 label is not used, please remove.
> 
>> +        compatible = "nxp,lpc3220-sic";
>> +        reg = <0x4000c000 0x4000>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        interrupt-parent = <&mic>;
>> +        interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
>> +                    <30 IRQ_TYPE_LEVEL_LOW>;
>> +    };
> 
> After the fixes please feel free to add the tag:
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> -- 
> Best wishes,
> Vladimir

Rob,

Do you want these changes on top of what was applied or a complete patch?

Best regards,

Leonardo Hirata

