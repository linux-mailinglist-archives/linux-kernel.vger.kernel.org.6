Return-Path: <linux-kernel+bounces-225459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E69130C7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFAD284473
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB116F0E9;
	Fri, 21 Jun 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpaf7flB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C982490;
	Fri, 21 Jun 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011151; cv=none; b=fXRj2PZocibztSgT7FcLymdEiiGkr05k6/zd8nufSnXAugyP593qou60BASEBk4l3JDtINd+dPMDP6z810x+TNTIWQY4O7XwXW6eHTe3Hil9eKj2nwl7x7KnJeUp6iqUzG8+NNHhO6R9fYvZM/yP8kLPooM7IkXh1/UZAtVEV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011151; c=relaxed/simple;
	bh=srNWowr77ga0B+NlKDdFSMHcmj4/qjRm5y/9HhDIuYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iofWzMB2ClxCl/PwVAG9qzgDvdpgHwOiJ73QVoVS4BQU6MzE6rjCdwVsAgIHT8pVp1V3+eykVkNkRDWtvNwVgyG6veA7VLsmoNO5utspEsbsxVP2g9nB/P5XgFLMbEebs/w+X6V/DuFgB21xNa+xXM0zQH3cXBwHzOC3uMd3lmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpaf7flB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f4c7b022f8so22283095ad.1;
        Fri, 21 Jun 2024 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719011149; x=1719615949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ULW/3eHHrWRT2nZLXN9A0n8RcowWVnXbz9YggVn00YE=;
        b=Mpaf7flBNSV9XH96NF71fevxpAvS0igxbEkCDMHpGExcGX3y4EHbXZeXnnVM4AGYrO
         s/GSMrLJ7LKIXJPpCEc5svnbCuxNpJAdlRGKVLuWuUso4aa5EaMd+0U8fi/Di2vb2/L4
         6ecI2nVFKRbvY6WdcgTCa/g+BslSoHCH9hxx5Et2Jc3V1QeFsvRYfoeVJhWTx6LRzU+2
         3i51JiKYkWvK7niW52l5zt75DwCdMDRFsmxEEdjbljOspV4dHJ4fUFJaM5HDRe246n1h
         3aLSrAtLqDMvviAjdnstjM9FCUzjtIy3u0b3VzjttRDgls01hfVJqa9CTHS3Pbo/qfQr
         wpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719011149; x=1719615949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULW/3eHHrWRT2nZLXN9A0n8RcowWVnXbz9YggVn00YE=;
        b=vTyHJSe/zdg3uQySCZhgtCuIsJzlaccg6izigwao41AtXeB9Pwl8GqnyHPg4jfOiRw
         EWwk9+CyyEsCxJ8hbaCxaI0pPkjYCTXNzxUHcYPO2QNPJWE3ktvjJgej3GheIjSjR3Gb
         kGg6DA3VwpENKh/vS6+t/US2LBL4IhSQ//1nYdXKy7JwEnfIYdZbHnbt3hpiVICfW6TJ
         /fU6FA73pwjqGLzEngvGAQb/LPtL/GoWNNI8Q+LxFx+15mh3Ip5e2KwELD5i/iWk6GhU
         2e0FfggTtdsz+BEgXmlT9fQhNY6p4e9IoNXN9kxUnheQMY9Nnl6M7cFbsSZy1xlp/fe5
         8Eng==
X-Forwarded-Encrypted: i=1; AJvYcCVRqvPkPx8v06QU8lcn1sbIoNlk7LIOkkADfI01Bjxdh77TrQPDorvRBr8hsJ1sychL2kudgksc0/RA35cAxZRc6an7N4/fCtoyPDnD1EB+oL26RbRevzrAoPRf66S4muOixK0WfAlWKR0Mumrlgr8eiJhtrB/FbkfDSTO0meTdj+l/b/p4
X-Gm-Message-State: AOJu0YyByQ83zukqUQi7JogAFv2PoM96GbDqoKd0JG7SdRD5VPKgW05/
	lLTwIUg+WeDr6bKKOcZdOLGipzNDtBIjvwSRo2VIz8NQbAqEcmFh
X-Google-Smtp-Source: AGHT+IGRmNtTdBJIu8yWAnaYB4XCVFvTkMTLWdi/tIzELf9g92QIGKSPxYfWyFK6zd/wIg0g6mkLUw==
X-Received: by 2002:a17:903:250:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1f9aa4632d5mr112903685ad.47.1719011149269;
        Fri, 21 Jun 2024 16:05:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c608fsm19348585ad.157.2024.06.21.16.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 16:05:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <52d97ca1-b9a3-4a50-8a74-6d56984791c8@roeck-us.net>
Date: Fri, 21 Jun 2024 16:05:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <df0f11cb-3b44-4869-bfd6-6e5d01e6debd@roeck-us.net>
 <IA1PR20MB495341CA5F2148902B198EA2BBC92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB495341CA5F2148902B198EA2BBC92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 15:45, Inochi Amaoto wrote:
> On Fri, Jun 21, 2024 at 08:19:10AM GMT, Guenter Roeck wrote:
>> On Sun, May 05, 2024 at 09:18:53AM +0800, Inochi Amaoto wrote:
>>> SG2042 use an external MCU to provide basic hardware information
>>> and thermal sensors.
>>>
>>> Add driver support for the onboard MCU of SG2042.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> ---
>>>   drivers/hwmon/Kconfig            |  11 +
>>>   drivers/hwmon/Makefile           |   1 +
>>>   drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++
>>
>> Documentation missing.
>>
>>> +config SENSORS_SG2042_HWMON_MCU
>>
>> "SENSORS" and "HWMON" is redundant. Yes, I know, others do it
>> as well, but that doesn't make it less redundant.
>>
> 
> OK, I will short it.
> 
>>> +static DEVICE_ATTR_RO(board_type);
>>> +static DEVICE_ATTR_RO(firmware_version);
>>> +static DEVICE_ATTR_RO(pcb_version);
>>> +static DEVICE_ATTR_RO(reset_count);
>>> +static DEVICE_ATTR_RO(uptime);
>>> +static DEVICE_ATTR_RO(reset_reason);
>>> +static DEVICE_ATTR_RO(mcu_type);
>>> +static DEVICE_ATTR_RW(critical_action);
>>
>> None of the above are hardware monitoring attributes. They are not
>> acceptable as sysfs attributes. Some of them might be acceptable
>> as debugfs attributes.
>>
> 
> It are reasonable, I will move the hardware info to debugfs.
> 
>>> +static DEVICE_ATTR_RW(repower_temp);
>>> +
>>
>> For this one, I don't know what it is. If it is a temperature
>> limit, it should be implemented as one (for example as _emergency
>> limit).
>>
>> Guenter
> 
> "repower_temp" is the highest temperature for SG2042 to perform
> repower operation. It is not the emergency limit, but a recovery
> limit when the emergency limit is reached.
> 
> For example, when emergency temperature is set to 95 and repower
> temperature is set to 80. The board is off-power when it reachs
> 95 degree, and it will power on when the temperature is lower
> than 80 degree.
> 

That would then be the matching _hyst temperature. There is no need
to invent a non-standard attribute for it.

Guenter


