Return-Path: <linux-kernel+bounces-254114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16296932F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3987D1C220D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3319FA94;
	Tue, 16 Jul 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhXub2Br"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A019DF99;
	Tue, 16 Jul 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150869; cv=none; b=b0RtRIF/gBGtc0Kip/4S0vOhzXHhlnBOZwPVHMG6wwHUtkInaZ+xgWM1xQfFnYsESYn6IXz5/luxytVzZiqHbwlPcl88nkyeSFzj4J3VWWIhBwtNmt+a/zOtJF44ykRAv7ftobxGY0/O/UKHtG/pYwl/978VeJ2ZR8dUvCBjpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150869; c=relaxed/simple;
	bh=h+GCeSWcUYctXZXlj1V41jWJSf5OrDhk5X5onAb7v4Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NGppE9Doib2y/6+j2ffuGkDcILQYjWBRXLWfBosrt9K1DNG85s/fjvb3rGRJ52h4qObCHzpVZ2WIPIBZTw/TP4pPrFe4XHQa+5GANTlBgTf0Q2ofWPcZ7KPER4ds3UMzEPUMY6B89zJNV7ADA3yFavdBVX8C3rKg9OQ8U9i9jG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhXub2Br; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-765590154b4so3467753a12.0;
        Tue, 16 Jul 2024 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721150867; x=1721755667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ih/q/UvhIgqWhBI1/wWLOdp0IK/oM/eG+khKgDhTSXE=;
        b=EhXub2Br8R7LfdAdm26MxEXKqYngtM3RwW406ezaEt/EpOBOM47Cc6J6h1HFqyDP5O
         dHKXniXMNVfMUTF7rRJ/VHXt+GNQpa1/bk27LrfZZve2SKCRUC4CT7fxsLvympBvrjnM
         rUrodK+7zyY6YyeQjCF9PvmLqrpOkqrHfIfyytiSWuMhuBeP0jA15YJdjb929gqW+16u
         rTgt015g1NHyJsxNvR4XkCsaQ/XGBNMOLhUNHn3hwdY/JZi9Fevz7ZwfRLFvDtFBtByM
         apIIU0nYvI90YfTZgUtGPVdZa9eTY15LpepYQvP+i6pyuptjOtJkIlv8YCAIuxZYAGyE
         GovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721150867; x=1721755667;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih/q/UvhIgqWhBI1/wWLOdp0IK/oM/eG+khKgDhTSXE=;
        b=r1FqXeXKcDw+t2vxdzj+R3iaeIzhmr9rlop6nOGaTt9pjRsJayajJRub/WLKUsJdaQ
         sqHl1ll6OYkCnNjmTlvFWnBhcvCuHwMa/o13++Jv1VkadDlWT3YKhlwqhMGIQIztGaYT
         yyXFArSBRQuaQSjZ/Cx6cp6E0MbHHg104Jo8Ekhqplf7SN5GX7IeebzycXObMviD/Cbi
         0jC2DxFFo2p48KZfjZEsEgXfjFwHLhLUNmEtIDghSJTUG++mtgn2m0f5ciFVK4HrMqCC
         B7ymwZyq4qxMvSOxUj9vp27soPz3VWizD+a69x0+7pQZtV1f5sR51RJUmNv3CDrk8lVK
         Zv+w==
X-Forwarded-Encrypted: i=1; AJvYcCXLhW1zZ/iGS0043ud/Hg2UzyqjecHNfLMUoXgF/Jr1Ncs3Ci/Cjv47XASe15a/2qq97dJUoSXtlHhyIZjaF9nWC0BHfXTbAuE+NdElHi+gDErkPhw5w2ay/cFuUwF0UAYgdYLiDX0=
X-Gm-Message-State: AOJu0YxMm1PJ4zaYtgGfpyum07Dt1GCJEoJEIeslIXiNod9MLyQRkRSs
	17j75U5Sc3ubYoVv605XDCGuEsnQ8Wr3fxZR7SmDSeM9SBfG2eafOIqdACeaNexQjgEjA0E=
X-Google-Smtp-Source: AGHT+IFvMYxLsUXk+MH/pF4Ib34JkQ8ZKXwGTVxz4X7Uj/nka+rUqpjGN9yCUMKyduk2bUHYrTS3zg==
X-Received: by 2002:a05:6a21:9985:b0:1c0:f677:e98f with SMTP id adf61e73a8af0-1c3f1287d4amr3546928637.46.1721150866854;
        Tue, 16 Jul 2024 10:27:46 -0700 (PDT)
Received: from [198.18.0.1] ([2602:fada:0:47::a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd3f10dfsm8600345a91.17.2024.07.16.10.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 10:27:46 -0700 (PDT)
From: Cryolitia PukNgae <cryolitia@gmail.com>
X-Google-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Message-ID: <bff5cb83-54fe-4e18-a0fe-32d90d90726f@gmail.com>
Date: Wed, 17 Jul 2024 01:27:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: document: add gpd-fan
To: Randy Dunlap <rdunlap@infradead.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240716-gpd_fan-v1-0-34051dd71a06@gmail.com>
 <20240716-gpd_fan-v1-2-34051dd71a06@gmail.com>
 <c81b25ec-3e6a-4b9b-8e3b-9991f1645d47@infradead.org>
Content-Language: en-US
In-Reply-To: <c81b25ec-3e6a-4b9b-8e3b-9991f1645d47@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/7/16 22:36, Randy Dunlap wrote:
> Hi--
>
> On 7/16/24 4:49 AM, Cryolitia PukNgae via B4 Relay wrote:
>> From: Cryolitia PukNgae <Cryolitia@gmail.com>
>>
>> Add GPD fan driver document
>>
>> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
>> ---
>>   Documentation/hwmon/gpd-fan.rst | 68 +++++++++++++++++++++++++++++++++++++++++
>>   Documentation/hwmon/index.rst   |  1 +
>>   MAINTAINERS                     |  1 +
>>   3 files changed, 70 insertions(+)
>>
>> diff --git a/Documentation/hwmon/gpd-fan.rst b/Documentation/hwmon/gpd-fan.rst
>> new file mode 100644
>> index 000000000000..0e5bb8b5feed
>> --- /dev/null
>> +++ b/Documentation/hwmon/gpd-fan.rst
>> @@ -0,0 +1,68 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +Kernel driver gpd-fan
>> +=========================
>> +
>> +Authors:
>> +    - Cryolitia PukNgae <Cryolitia@gmail.com>
>> +
>> +Description:
> No ending ':' above, please.
>
>> +------------
>> +
>> +Handheld devices from GPD provide fan readings and fan control through
>> +their embedded controllers.
>> +
>> +Supported devices
>> +-----------------
>> +
>> +Currently the driver supports the following handhelds:
>> +
>> + - GPD Win Mini (7840U)
>> + - GPD Win Mini (8840U)
>> + - GPD Win Max 2
>> + - GPD Win Max 2 2023 (7840U)
>> + - GPD Win Max 2 2024 (8840U)
>> + - GPD Win 4 (6800U)
>> + - GPD Win 4 (7840U)
>> +
>> +Module parameters
>> +-----------------
>> +
>> +gpd_fan_model
>> +  Force specific which module quirk should be use.
>                                                   used.
>
>> +
>> +   - wm2
>> +       - GPD Win 4 (7840U)
>> +       - GPD Win Max 2 (6800U)
>> +       - GPD Win Max 2 2023 (7840U)
>> +       - GPD Win Max 2 2024 (8840U)
>> +   - win4
>> +       - GPD Win 4 (6800U)
>> +   - win_mini
>> +       - GPD Win Mini (7840U)
>> +       - GPD Win Mini (8840U)
> so how is the module parameter used? like so?
>
>     gpd_fan_model=wm2
>
>> +
>> +Sysfs entries
>> +-------------
>> +
>> +The following attributes are supported:
>> +
>> +fan1_input
>> +  Read Only. Reads current fan RMP.
> Should that be                    RPM
> ?
>
>> +
>> +pwm1_enable
>> +  Read Write. Enable manual fan control. Write "0" to disable control and run
>       Read/Write
> or
>       Read-Write
>
>> +  full speed. Write "1" to set to manual, write "2" to let the EC control decide
>> +  fan speed. Read this attribute to see current status.
>> +
>> +pwm1
>> +  Read Write. Read this attribute to see current duty cycle in the range [0-255].
>       Read-Write
> or
>       Read/Write
>
>> +  When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
>> +  to set fan speed.
>> +
>> +pwm1_mode
>> +  Read Only. Should always be "1" by now to indicate the fan being under PWM mode.
>                      Drop             by now
>
>> +
>> +update_interval
>> +  Read Write. Set the interval in milliseconds to update fan speed. The default
>       Read-Write
> or
>       Read/Write
>
>> +  and minimum time is 1 second
Thanks for review! v2 sent.

