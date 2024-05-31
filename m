Return-Path: <linux-kernel+bounces-196935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72A78D63DA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161871C235A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269B16F282;
	Fri, 31 May 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImvKkPCQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0615B128;
	Fri, 31 May 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163705; cv=none; b=LQEzc6nCawFKFTqN8se0RYmT3ndqf+zKfmTX1zyDMnwp0RqmMzsG8wRdODjwpwbA+Zmq47XGa/J7QW+sXhJl9eKFreDOK8A+XI9McTqPhq7oTfpcPdLi/MgX11XJnJnW3l9OoIXw8h4eLEU4wJOnqZogezlS4xmzAyuJ0phvPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163705; c=relaxed/simple;
	bh=nFemLg7t6m/EaUpB5WnHtIhZSSbY2DC+tR6K3Rp5q/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZfrBfrn5EOCG50VQjVemCDsgRPEYntvwiXx1DWH3dA7UtMx9PStUW2mVLxh4vwJ2A0e3VBFYBIhd+xv56TZHhrt9Nn/95BN4o/SkJ7RWzx7HHd9cejACucUrwZXv1dkVRBn3VXEDNhbdZ1JLKY9GDkLzHenLoC8fNo4oyfL+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImvKkPCQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso1352128a12.0;
        Fri, 31 May 2024 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717163703; x=1717768503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8KK2787l6Ms+C7U6U5reQxwXbZ4sHBQs0pzM5m7eaQw=;
        b=ImvKkPCQV8MOcvZIEFqQslQPjXAicu5Pyvqzq/4//aldJlqHA+/Lq+8KwOR1dPYEX9
         3L/lcrOGHl/iH8zwQA//7TOIHJYt4jFj9TewNiq5lCH2wtyEISlAeFYCczwW4eevIODI
         z2MI19G/B42o5+K79O2HaiqVk2hrYWgb0wB9xESD36axmTCnXOC3F26pkemhkRwVsJHT
         ljf9AmHxUwGVKW5La+82a1oG6BwIa/VcwwExODdykB2Rny/XRv/qLUE4GI7Wf1bbZPGx
         HrzpAbrzPyQI6UMC+HH7u5PbE6135/o1DOWQY/b7fslUR2wap1JcfORENyf9pCuph0jk
         Mk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163703; x=1717768503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KK2787l6Ms+C7U6U5reQxwXbZ4sHBQs0pzM5m7eaQw=;
        b=VGgAkMe4sRu7/qpOF9ijYNBGdApx0zowV2MphnzJC6pCcWdxnTtjgGzbKSYXf8099z
         VWrHXDNYoTmhrgFUo/u8F/c5Ktmt8orC4FXNaK+W0tyw5EHQwH8vtWgyd5AdlJq2Pjcs
         zl5otIp55iYcchhIxcyHjrtXpYHcp1tNfimAWH5eGVltVdGStNIvROM85pj6cFOm3dsH
         yAtHSYUF7ffvLhIwaA/NeU22X/j0M1OsUm3j/U5e/q4eyTPLiPr8lB5yEqi39SxVEcNe
         a9Vw9ts8R+2FYt1/IvR0WRhrNYIfxsdrcHmBxedUhBVjlGx6PmMXxdgUmD5cPfdiyts1
         fl+g==
X-Forwarded-Encrypted: i=1; AJvYcCVerc4PmObUErIbC8c45ZMD+7ZwmMHFfc0wMZwTXT3/gH+tng3NBqQa0b16Ofb6237amMxfl/0s+wN6JfxZ55kjgyMy03SxEN71FgwKcD29IiQs+MNNAsiu1LVDhYAiRmVr1OYF47Iwewy7TVeb7CCc6HOsxvVk55gTaW/hMoppgUTR42kT
X-Gm-Message-State: AOJu0Ywoqnz38G+89AJt/HUB0dPtE8RG5ztnhKKv8WXdabuWEmhI7mu8
	pVmIl4vL2Lbdbx4MUQJw+4cXgspMXUvW1ptH4D652s7jbIEW+QlJ
X-Google-Smtp-Source: AGHT+IHVTVfIg/ueNzRvjLcj707Fd8g4Snkjwb+sg9cOBUnkn2/ZlcmpLwi4mun8skxJ9zuePBzH7A==
X-Received: by 2002:a17:90b:11d4:b0:2c1:a9d5:9b58 with SMTP id 98e67ed59e1d1-2c1dc560bd9mr1949756a91.1.1717163703181;
        Fri, 31 May 2024 06:55:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a775d523sm3230120a91.12.2024.05.31.06.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:55:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e161edf-db95-421b-9df7-fe23be411536@roeck-us.net>
Date: Fri, 31 May 2024 06:55:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
 <20240531093154.rna2vwbfx7csu2sj@ninjato>
 <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
 <ea135424-841c-4a5a-b881-a3295d87b64a@roeck-us.net>
 <151934EE-F826-4655-BEF1-2199B1AAAD5C@exactcode.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <151934EE-F826-4655-BEF1-2199B1AAAD5C@exactcode.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/24 06:20, René Rebe wrote:
> Hi,
> 
>> On May 31, 2024, at 15:14, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi René,
>>
>> On 5/31/24 03:01, René Rebe wrote:
>>> Hi,
>>> On May 31, 2024, at 11:31, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>>>> Wolfgang seems to think it's important:
>>>>
>>>> Wolfram, please.
>>>>
>>>>>> https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxllsdxsz@wxzynz7llasr/
>>>>>>
>>>>>
>>>>> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
>>>>> think this is needed ? Note that I am not opposed to adding spd
>>>>> eeprom support, but I'd like to know why I am doing it before
>>>>> I spend time on it.
>>>>
>>>> A working eeprom driver is needed to get 'decode-dimms' from the
>>>> i2c-tools package working. Jean reported that EEPROM access for DDR5 is
>>>> different from DDR4, so it needs a separate driver. And
>>>> i2c_register_spd() then needs to be updated to use the new driver for
>>>> DDR5.
>>> Well my original downstream driver already had eeprom access:
>>> https://svn.exactcode.de/t2/trunk/package/kernel/linux/spd-5118.patch
>>
>> Yes, but you didn't send it upstream, so I took it, fixed a couple of bugs,
> 
> And I appreciate that!
> 
>> dropped eeprom support since that is secondary for my use case as well as the
> 
> I only said the original code had this implemented if someone wants to re-add it
> to save them some time not having to re-write it from scratch ;-)
> 

That is for sure what I had planned to do.

>> out-of-tree parity code, and submitted it. I'd be more than happy to let you
>> take over if you like.
> 
> I’m mostly out of time, so I appreciate you starting the upstream process.
> 

Ok, I'll keep going.

Thanks,
Guenter


