Return-Path: <linux-kernel+bounces-285677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F995112A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D7D1F220B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BE9445;
	Wed, 14 Aug 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYn7CZh3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6346138;
	Wed, 14 Aug 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596672; cv=none; b=qXpA62TMq90L1hAywd/LtdPJthwacstpcFcvZW6PNNmHrcAUsi8hlKUIxSjb+ynFdcQNcX35OPhdcB2qSA7C1K23fAp5zhtE3aFc4sM9ARyB+O6yQtQ7UYy4vCMQ+nEk5KIwRLnxTRczF39CrH8BpbfYL5dG3FjOZcNzJ/1q7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596672; c=relaxed/simple;
	bh=7qBwjUubpxuEeyFaGUm5BSnDNngTf22bjRYGb53Kzw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCwv975mbAq5HDtRx7xIi80D2zFon5ZpNFKhM3dWfu9N5qjPeTVQtrvEae1ng1vHQ8jhkgRVmlacR9PbUvDbbuQ4BKW2uIRB2zHUIoZwJW+fh3qMvURqcWwCu1SHoqwB4hsUfNlq4NiwpperBygd1y5aHLp1urHTijGevCZnvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYn7CZh3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd6ed7688cso54034015ad.3;
        Tue, 13 Aug 2024 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723596670; x=1724201470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MqokAGWtlIdjeh5J6al0inMtByeR+m22lAwSRmhFIP4=;
        b=lYn7CZh3QgJ1AUKOrmNP81AsWWlIEXtoW3NylU1TLEXZPiW14gEaqR5mQG44IznU3j
         l0j2wUETv4gtOuWFEjWkaoz04L3IZJ2rzR/wb1WFpoh7QXmD/xP5GYMC+YeXFaxSYNCw
         gsI5zYUWD3Ysprd0sUn3p+2MskOWCRtcLrxEuV06YIL1qoBE8U7gDRM3ube4a81CUJx1
         VCvDoZqyxoWdmjgc38eIUSoU6eRIYOKnpNUu6kRhr2u2HLOiCP29oWlhKKTH6A786ANz
         Fw8R48e6AuCUaSDTVpAApQWiB3QNE7v5cmpj0JgX2IKTy9Ck3Wh6ZSqhWVmLYXxKpNIb
         j4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596670; x=1724201470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqokAGWtlIdjeh5J6al0inMtByeR+m22lAwSRmhFIP4=;
        b=MwaU9sxettK03u8cwd5i6efUh25SKIV4Lv0HvMt1iGm0ETA2rC1imP5EFJsoHQriDs
         EdRlfhXMMiYk0dap+iWJOyAzcOGqX75ITyFoZdUlKuL0ckMKypuLK9AVaog6xWEzJmoc
         hZETW5FsiJYQ8euQ3yrjmK0l/5G2tTqKCXyNs2MPSo/yA0FbRuazOiKoDVV4/x7Z2J+f
         vhpEkjfSyarGom2nGTrLsGIGYSwzx9DHyPNVH4CFhYMp0JspWxQzqZBLMjQcbH5bm7qd
         TkVbXlhSYlcJn1ui8DXZqfudkYwf/hswwxkY9akxcc9CTS40jvOtsHg9e8o3woBKQ3mD
         611g==
X-Forwarded-Encrypted: i=1; AJvYcCVKW/YNymlWThYVU8uzDiY/HmnDtSroE5gxzbFBFAkmdr65Vm/EJM8UhyUPYI/RRJlmwI2/x1r0l8qNRZSC56TKcCv/h8GH4O+9wInWg4rQ22Djbd0JeKvkvvKeejg/sic0+45IaBEInnM3hX3DIEBhN2HEySNg2PP8uYSljM29OSLUojILQYIvIDHi4fKOLx4028HREdd1MKe6w78KGIP7
X-Gm-Message-State: AOJu0YxljE/w0+e8nmtEpa8wkd2D3H2Kv5OAT4fjkXID9I9NnNU/xy+/
	ApJfbZp+/3Ns3YpHPTODrCqwjOhuwoWRVOdoB7kycX6A/5nsVKd4
X-Google-Smtp-Source: AGHT+IEjcEusNP2EwTHeMIM7dAvVS+Itgk1tZJzCE9EhuGxRLmWxxHPSkb9YZXf4uztTeRPKTYmuQA==
X-Received: by 2002:a17:902:c943:b0:1fd:9269:72f0 with SMTP id d9443c01a7336-201d64a5b41mr14997205ad.47.1723596669478;
        Tue, 13 Aug 2024 17:51:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1d0b4esm19159665ad.288.2024.08.13.17.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 17:51:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d501bed8-ed06-41aa-b628-37ccd1bbb802@roeck-us.net>
Date: Tue, 13 Aug 2024 17:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Drew Fustini <dfustini@baylibre.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Hal Feng <hal.feng@starfivetech.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <0e30eab7-e202-4639-863d-85ce28525714@roeck-us.net>
 <IA1PR20MB495356094952242D9CD8A249BB872@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB495356094952242D9CD8A249BB872@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 17:40, Inochi Amaoto wrote:
> On Tue, Aug 13, 2024 at 11:27:11AM GMT, Guenter Roeck wrote:
>> On Sat, Aug 10, 2024 at 04:03:51PM +0800, Inochi Amaoto wrote:
>>> SG2042 use an external MCU to provide basic hardware information
>>> and thermal sensors.
>>>
>>> Add driver support for the onboard MCU of SG2042.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Tested-by: Chen Wang <unicorn_wang@outlook.com>
>>> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   Documentation/hwmon/index.rst      |   1 +
>>>   Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
>>>   drivers/hwmon/Kconfig              |  11 +
>>>   drivers/hwmon/Makefile             |   1 +
>>>   drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
>>>   5 files changed, 478 insertions(+)
>>>   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
>>>   create mode 100644 drivers/hwmon/sg2042-mcu.c
>>>
>>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>>> index 913c11390a45..ea3b5be8fe4f 100644
>>> --- a/Documentation/hwmon/index.rst
>>> +++ b/Documentation/hwmon/index.rst
>>> @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
>>>      sch5636
>>>      scpi-hwmon
>>>      sfctemp
>>> +   sg2042-mcu
>>>      sht15
>>>      sht21
>>>      sht3x
>>> diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
>>> new file mode 100644
>>> index 000000000000..18a3578ac213
>>> --- /dev/null
>>> +++ b/Documentation/hwmon/sg2042-mcu.rst
>>> @@ -0,0 +1,77 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +Kernel driver sg2042-mcu
>>> +========================
>>> +
>>> +Supported chips:
>>> +
>>> +  * Onboard MCU for sg2042
>>> +
>>> +    Addresses scanned: -
>>> +
>>> +    Prefix: 'sg2042-mcu'
>>> +
>>> +Authors:
>>> +
>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +This driver supprts hardware monitoring for onboard MCU with
>>> +i2c interface.
>>> +
>>> +Usage Notes
>>> +-----------
>>> +
>>> +This driver does not auto-detect devices. You will have to instantiate
>>> +the devices explicitly.
>>> +Please see Documentation/i2c/instantiating-devices.rst for details.
>>> +
>>> +Sysfs Attributes
>>> +----------------
>>> +
>>> +The following table shows the standard entries support by the driver:
>>> +
>>> +================= =====================================================
>>> +Name              Description
>>> +================= =====================================================
>>> +temp1_input       Measured temperature of SoC
>>> +temp1_crit        Critical high temperature
>>> +temp1_crit_hyst   hysteresis temperature restore from Critical
>>> +temp2_input       Measured temperature of the base board
>>> +================= =====================================================
>>> +
>>> +The following table shows the extra entries support by the platform:
>>> +
>>
>> Those are attached to the i2c device, which should be mentioned.
> 
> I have mentioned this in the Description. Does this need to be
> mentioned here again?
> 

Here is where it is needed.

Guenter


