Return-Path: <linux-kernel+bounces-243451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB782929647
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E70281E9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E84687;
	Sun,  7 Jul 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLrtCJB3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFC4405;
	Sun,  7 Jul 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720316140; cv=none; b=OUP1eSoHisdAaT1yz0h0yTjaqB9Bte3KI+Ek/51rsVaOLfWDMyjxvUShAZOal661/MgXFzkAvyFN4sFLK+GGCSFQAquz9ue8RXynhdiVbV0sujIbYJfyRFgq5DDWABWyhgmxX/KOk00LMM4/jvzPSDkcU/ZYFqobmcd7DjQGNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720316140; c=relaxed/simple;
	bh=FAd3RH6khzaVnEZHL7BMSU96scf6UJhfhiPjabrIm+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL8j+nUqQ7SLhUNJOnmqpz4izeQIH/b0xE40c63U24sA4pgtN8FJhymImqggb38Qr29QpjiJk6MC1iExZfQsr7x3LVt7AlC2I+UscwjaRz0+Y3aNKaBzNIXxgJhXMwiu474tVE5ZmavmJCBJuqOHJzY0UHp/XnOyyrKdSPwm+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLrtCJB3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c9ddc9aea7so251240a91.2;
        Sat, 06 Jul 2024 18:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720316138; x=1720920938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nsguKa8Fd9DPaCpX9PzRwBcETLMtI48yaYMApWrDjW8=;
        b=nLrtCJB3raZ35aTH9hZlooOpMrhAOftHssWk4o2AMzDHK8G2xvHkK7ES13RuPHB3NN
         TcbEz40CcACG5+6delGqKd5aAzyZKJK8F7DMTb+m0p6SJoumFzaXT9iXNfnzdo+cm2Dg
         GIhKgUw0uXAXFknS06WkF6MYUR80cNh6LKcVo26LCr3RBo7VN64//YEgeh/xx+73Lj33
         +SaWlQ4+aAew7EvIrwAk+nITZI3FK7eCS9Co1xNo+jOD5n4EUaCGio167vXua90QMNv5
         osTSZci3tLS+5mZS3wRxzE62PCfM1BTG/Vw0+ee0VwDyx6KZV1WUG3Nq3CIFnoZIzSPs
         BD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720316138; x=1720920938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsguKa8Fd9DPaCpX9PzRwBcETLMtI48yaYMApWrDjW8=;
        b=Wc9FzbVXmtK5YgSKCZFgcShU4liBTPipgtb0KS+OzLlB9k2FvX0wCLNaeNBrpIi9Je
         TPiCNBtRsp3y4ME/u/C+bUQHE7id8vuvHVmsNo4wo2wsyHoaeHzJVr2FNTrVsSN5EVUY
         2S2a957Bu3rl733MysMBw7Tv95ZQ6yZ67z/zSr/oE7b16TgPxZkaSQ9VPC4axagPWLCZ
         ZO8rM/eyZE78RDJRDO9G5OaPsB5cfB/V4LarmQ1N033q+LCv6JlrXRu9SlkiLW3K1KiQ
         sH/5mfKPxC4JN7gQfnCoA1xLfZ49J/VVX29n4lyOcbGMrtiCPHEaajq9WrRpHy217Yqt
         zuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvuo6A1xAIXUfvc41cBZMazExFMt6JrE65hq71BjOwFCBmQjvuedZDv35dKqPkTGwmn3t7sPEqfWZXNGWdDMJY6T8zmHrZjsf3VXpDWIOgrT+ct4hSb+BWCvczcZ6jw+aBj80qywL066WQBjdocTAM4N2BWkIfNhA/KWx9apC8HX7r2KXIKQJAoccZxCJr37zF+BHJYgBEz9ym1xlSnL9a
X-Gm-Message-State: AOJu0Ywo9hp2uc/kLSPyQpad9bEti+LT5EvEH1kzoeHLGdoKdmYJTgyb
	1P/LD8LWx3fdJxB4jwTs/4q+qeIeRSLnZqlgGnehnk40DZQTPzMF
X-Google-Smtp-Source: AGHT+IFoUAJxvVZfvCiN/bhFxXLAbSuX+gKzkgcu8uug+VjJ8+a7o3oqyy5WCYAmmuP/vmkix0XODg==
X-Received: by 2002:a05:6a20:9146:b0:1c0:dfb3:4214 with SMTP id adf61e73a8af0-1c0dfb345bemr3921383637.38.1720316137656;
        Sat, 06 Jul 2024 18:35:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3ce7144esm48053225ad.300.2024.07.06.18.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 18:35:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a0337b42-4cce-42f4-91f6-eca65c62ed47@roeck-us.net>
Date: Sat, 6 Jul 2024 18:35:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F58B631D836F3863115ABBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <5a2e23f4-d54a-45ae-a09d-e557b110e017@roeck-us.net>
 <IA1PR20MB49539E946C2D5D025932ABEEBBD82@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB49539E946C2D5D025932ABEEBBD82@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/24 16:34, Inochi Amaoto wrote:
> On Sat, Jul 06, 2024 at 09:48:58AM GMT, Guenter Roeck wrote:
>> On Wed, Jul 03, 2024 at 10:30:43AM +0800, Inochi Amaoto wrote:
>>> Due to the design, Sophgo SG2042 use an external MCU to provide
>>> hardware information, thermal information and reset control.
>>>
>>> Add bindings for this monitor device.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>   .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
>>>   1 file changed, 43 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
>>>
>>> --
>>> 2.45.2
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
>>> new file mode 100644
>>> index 000000000000..f0667ac41d75
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
>>> @@ -0,0 +1,43 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo SG2042 onboard MCU support
>>> +
>>> +maintainers:
>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: sophgo,sg2042-hwmon-mcu
>>
>> According to the other patch, this actually covers four
>> distinct models/devices.
>>
>> static const struct sg2042_mcu_board_data[] = {
>>> +	{
>>> +		.id = 0x80,
>>> +		.name = "SG2042 evb x8",
>>> +	},
>>> +	{
>>> +		.id = 0x81,
>>> +		.name = "SG2042R evb",
>>> +	},
>>> +	{
>>> +		.id = 0x83,
>>> +		.name = "SG2042 evb x4",
>>> +	},
>>> +	{
>>> +		.id = 0x90,
>>> +		.name = "Milk-V Pioneer",
>>> +	},
>>> +};
>>> +
>>
>> Is it really appropriate to use a single compatible property for all of those ?
>>
>> Guenter
> 
> These board can only be detected at running time (even this should on
> a specific board). On real world, it can only sees a MCU onboard.
> I don't think it is a good idea to add some bindings to cover these
> model. It seems better to remove this array and let userspace to parse
> these ids.
> 

Isn't that what devicetree is for ? It should either not be necessary
to distinguish the models because they all behave the same and all of them
are happy with the same compatible property, or there is some difference
which should be reflected in devicetree. In other words, either they
are all compatible with sophgo,sg2042-hwmon-mcu, and sg2042_mcu_board_data
as well as sg2042_mcu_check_board() are unnecessary, or they are not
compatible and there should be separate compatible property names.
struct of_device_data does have a .data pointer for a reason, after all.

In yet other words, it seems odd to have a devicetree file for Milk-V Pioneer
and then to check in the hwmon driver if this is _really_ a Milk-V Pioneer
and bail out if it isn't. And I _really_ don't want to deal with continuous
driver patches whenever one of the systems using one of those MCUs starts
shipping a new firmware version or is deployed on a new board variant.

Thanks,
Guenter


