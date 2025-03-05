Return-Path: <linux-kernel+bounces-545954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB4A4F478
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE18F16D5EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD24152E12;
	Wed,  5 Mar 2025 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="geP0D20p"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195613D279
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140681; cv=none; b=bFPAfOQq+4PZXmk67Xb7TiJKaEy1iT4HNDNHe9M4a+9SCsW95XamBEgqlXzVvSzZ/Ib9diUUFYfqAfuf1eiuYVBuliHCemqJXSjGATQ/XScKeCVp/v4rCjk1Z6VfkqzluqPcS09L8lT4ed4mYu4tcaEl3mH9ih+2zRBDOqySxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140681; c=relaxed/simple;
	bh=Q8WmlKeJj7M60YHkpMu1VvFfgzxwRdhcvmDLZvH+Xvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo/mJgomMZMMrEz7UI2Df+51KvaEkpKbi9d+phsm75Fl408q7DUZjMDiDi3BVLHZGc9AURP9GjZ2oiZKryRQhocd8/HZKQYjzDX1Dt1qHAH2SwVytWrpnQzWUTAuUkC1USSBKLVIhIOtQkOwUKuZlObhYLVp/mj5PSxFLc6q7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=geP0D20p; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so434489639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741140678; x=1741745478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IPu6iJQJZK/agzAsjhgRU4s3OBRGcgTM6nYh8CRHfM=;
        b=geP0D20pbfeUDtWgYwV178SEaQYfn9zr7N0CxaHWyOdQKac2+JSHHyocxLENZJ8QhM
         CilXrfr9XY3kd17nfgKLEi1RE7EULvvBF/c7MAjfjoEDagnP3hqfuZygns3E0VwfSciz
         vVai05zaNuM0YCakMGmFxG5o64fNoDuO1TMomYGii6fVGTDqyxcw37JphyxNy+2f7FZs
         /ClSODncw7oZ5v/8s/AslyrdxDHgFX4kMhYQgGIlfzXW1RQMBQ1tmVd3zKS9L4vXJfuj
         QE2N9JnScERcBGdUzz5H7ZgtG7fEeLT5o/JMIHUxQrBDR4WgwYn0X532NvAqOsDNerhm
         G/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140678; x=1741745478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IPu6iJQJZK/agzAsjhgRU4s3OBRGcgTM6nYh8CRHfM=;
        b=WrcpWWp04yH56JRgBAwzHcN9E5lKSWv7n5ES3H1KlK0wxW0rx/2M8EDn3LNP3+BkBm
         IqFQj7FXn0byVP8otznaCBPJxnN9IGfzxkIoAeomTFth3zP0BFjdTysnbP7mHkBz2Rjc
         8KX+3joHcJhh3OnTuGJXQzncn5msOelll0WaCBJ6yXLPPuqpxMVLyhfsUgtPSltfIQat
         X8SC8FmAuHBfYFAe5/c/CertQH90aVBeik3m6x3rS3mlq5tiZwIC+o6hJrr/OSilQCH8
         q2HG00ixbeDJv8/up6Wq+vYQvwH9UTFIsRerPdUTmNDsTM0WZv8JfJ0dSYwPMZtZApMn
         ikGA==
X-Forwarded-Encrypted: i=1; AJvYcCXutA8DCCwh1UbCsMgfyohRLlag17Zq81HuQl8bles8DdMei4clumMJcZ6WJ9wgnxkwhR1xWEcgQ7RwkRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRLUQIrs1Ki2cI2/oXqJzsqopRgfmxaeyp/1SXYY+nbO4lkIB
	I0H1JTLKEgQwuNZYT5xojzcZR/3yrx4Z+MX4AIOEB86ELh+M21VoWQe24NxtvE0=
X-Gm-Gg: ASbGncsltyAgrVzJtYRrAoeaOdo3WfcM1zn2YczP4l9Ld7Z7SlQC6OP7b5AorI3DuCZ
	eJa5xY5gjSCNC8wzmgP9zK22uWl/6NvPCIlTZwKm6H0mTx85qlS/H/thCo6AvuX+0Gc5/bl/NoE
	GI02B/CBt4e7rXxkKCUTRkDgX047deXD8cWXEkbx9LBxRklf0FOL2DAw5EmScXQ1dC+6crmpNBY
	9M8bGuGvQxGaIkYucINsNVlIK0ip74J8rNXXfLQWkrkMFO1pYTECtjAHvlSnn/6BPuNRIB6gqls
	M9yDl8PNskyvLhsMzxbbfKjFzTReIeTmB6GWdsM=
X-Google-Smtp-Source: AGHT+IG15YhzjdJR2FqfaMtHfCYjpuXOjr2GugugmrdEVDdT7gY0ODZ6/4j012jh/Swg9m4eJ6IseA==
X-Received: by 2002:a05:6602:388c:b0:85a:fd37:1c6d with SMTP id ca18e2360f4ac-85aff8abd43mr226317839f.6.1741140678617;
        Tue, 04 Mar 2025 18:11:18 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f07cd84f06sm2387028173.67.2025.03.04.18.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 18:11:18 -0800 (PST)
Message-ID: <ab10e069-d9e1-4df7-9454-8b0fc910443d@sifive.com>
Date: Tue, 4 Mar 2025 20:11:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 1/2] dt-bindings: i2c: spacemit: add support for
 K1 SoC
To: Yixun Lan <dlan@gentoo.org>, Troy Mitchell <troymitchell988@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250303-k1-i2c-master-v5-0-21dfc7adfe37@gmail.com>
 <20250303-k1-i2c-master-v5-1-21dfc7adfe37@gmail.com>
 <20250303093506-GYA58937@gentoo>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20250303093506-GYA58937@gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Troy,

On 2025-03-03 3:35 AM, Yixun Lan wrote:
> On 13:30 Mon 03 Mar     , Troy Mitchell wrote:
>> The I2C of K1 supports fast-speed-mode and high-speed-mode,
>> and supports FIFO transmission.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Troy Mitchell <troymitchell988@gmail.com>
>> ---
>>  .../devicetree/bindings/i2c/spacemit,k1-i2c.yaml   | 59 ++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..db49f1f473e6f166f534b276c86b3951d86341c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i2c/spacemit,k1-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: I2C controller embedded in SpacemiT's K1 SoC
>> +
>> +maintainers:
>> +  - Troy Mitchell <troymitchell988@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-i2c
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
> ..
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 2
> I'd suggest to give a brief description and explicit clock name here,
> you can consult marvell,mv64xxx-i2c.yaml for example
> 
>> +
>> +  clock-frequency:
>> +    description: |
>> +      K1 support three different modes which running different frequencies
>> +      standard speed mode: up to 100000 (100Hz)
>> +      fast speed mode    : up to 400000 (400Hz)
>> +      high speed mode    : up to 3300000 (3.3Mhz)
>> +    default: 400000
>> +    maximum: 3300000
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c@d4010800 {
>> +        compatible = "spacemit,k1-i2c";
>> +        reg = <0xd4010800 0x38>;
>> +        interrupt-parent = <&plic>;
>> +        interrupts = <36>;
>> +        clocks = <&ccu 176>, <&ccu 90>;
>> +        clock-names = "apb", "twsi";
> 9.1.4.61 TWSI0 CLOCK RESET CONTROL REGISTER(APBC_TWSI0_CLK_RST)
> https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#part594
> from above docs, there are two clocks 
> bit[1] - FNCLK, TWSI0 Functional Clock Enable/Disable
> bit[0] - APBCLK, TWSI0 APB Bus Clock Enable/Disable
> 
> I'd suggest to name it according to the functionality, thus 'func', 'bus'
> clock, not its source.. which would make it more system wide consistent

Also in that same register is:

2	RST	RW	0x1	TWSI0 Reset Generation
This field resets both the APB and functional domain.
- 0: No Reset
- 1: Reset

Which means you need a 'resets' property in the binding as well.

Regards,
Samuel

>> +        clock-frequency = <100000>;
>> +    };
>> +
>> +...
>>
>> -- 
>> 2.34.1
>>
> 


