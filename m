Return-Path: <linux-kernel+bounces-290456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7E95540A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB464B22860
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B2653;
	Sat, 17 Aug 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnra1uTZ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B433C8;
	Sat, 17 Aug 2024 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853003; cv=none; b=VXpIF+YbZLw937coiP53FkG/HbeX5vK+dvQel+yPnbweThWWevqKUfLEJ882put4bN3lQ5AR9J2+0vZWyHjnnx9DL1LE3UVhV6/VxIlLXSfd+jv+9Olob9ZcJ7wBxLpmVzNa44tP0b6mrR0CG1IembRjPpa6Wpiqh/jdCoqgc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853003; c=relaxed/simple;
	bh=e9uuSem2Kttw0m8S7Y1E660rH26HZu7IWsbSCqaPph8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8YZdwgNUWIwc2IYQnH577PgKjnciD0Th2vsdkxmdKOjHSg47sdu38jK3mkGcRr9Xs8sfiqMOkrIRzwZTmSOUHn/kiRtsoXEk8QsWFPE1+NE1rDfcKSE7/tc9N/0ijJ/jznVwqILUk0hQua/Ms4IB7oEPfhPzBC+R1WMWpGHlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnra1uTZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc47abc040so20979745ad.0;
        Fri, 16 Aug 2024 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723852999; x=1724457799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SPfZ22bi83kUBgSTIY60cQDgzuSRqnjYzRmmA+o3128=;
        b=nnra1uTZaS6WT2L1F1P40+iDUIl3+dAODVxY2i/vikZJMlJv62X0tCaYds+3OjYbLG
         iZuxbmNX6lwideLxg0NkGAiG+ni+I5q6F/ro0eHzOVxp5IBWqkDa4C0Q5/G8Ku0ZPqVx
         q1O57a0ZGK1FkKg5V27aFfEAUEyX7aRzN6FUgY88LgVyyN/JraXOcofnoq0iVzGOrNt0
         Ovz0oL/iyR0QUAnPdygyZ3/yH+gBWZSjYkpJ0A23YAj7nG3WRYuZrEx/mOjVxrV6kL2G
         vdJ3mDLkes3LwW8208pC+JAyvHZyTxnvJX/Q2PnI3LK8bO1UovWMjfzpHHqBhx74CJMv
         T8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723852999; x=1724457799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPfZ22bi83kUBgSTIY60cQDgzuSRqnjYzRmmA+o3128=;
        b=C2loxBzWigfbEsekkdEc23fetRyivYKaEVHM/AJ7HRKZkkO7P6sXiofz1i4oG5goZP
         9M48qN7GhVj6RE7vU8dLE61Gkt9xm2rSYRmYDAxcL30ftgdLCpBQnlQf7HugAagTjCF5
         tDjR09OmxFH9piy8xu4zxe2kToz9ESK6ghoUF1s84M4OkrvtMRiIFYuvGebDeEq2XhtU
         HsgW14aiDegrPTzxNxxOXXv7pzuex4e8tZiVWqfRYKfuSCOoXP4prWbMpLT9zOPh1EO/
         DzJlojCqxloVAwz61NkEdTgp3f4+PJSAJIAsJDRWpFjFlLKuuDK7YWIZ7xmChoSS8sy3
         QMEw==
X-Forwarded-Encrypted: i=1; AJvYcCUgQsMaJvNJj0EKsIPKd0ZVChub6AzO/O9sAcm46jGmriV/hmuSD7+wXA9/HIlAUdC8382ps0DGWPob@vger.kernel.org, AJvYcCX4vyokoUulqU2PVPmZGD5TPP4z43lz0iCDab5406JVvCuO3Hn8hVef7KBRf7kr5QV+igr0PLJaGkL/HIw=@vger.kernel.org, AJvYcCXfUWQUcO+vlkrxnX3tmF2H81GfenzVXV8fMwUzudoWyEAurFLRMPyUj3U75a++kh38aveWv2kc4DZ7qvaH@vger.kernel.org
X-Gm-Message-State: AOJu0YzBH6tHzJYducpGL9zlEGRPDLdg8olEXPOPcwtfzjHwA46QUG5N
	HO5AX6PazDEnw1jzlte/6Xc+5adotSQSh8RMIZUCFph1QADag+U9
X-Google-Smtp-Source: AGHT+IEN34pnTG+VDuE3PZEwC9pxMHZGn96deX05SD0fOSmE/9as7/OVPtl/gwkUEC/mZXDFDadKZQ==
X-Received: by 2002:a17:903:2347:b0:1fb:8e25:e631 with SMTP id d9443c01a7336-202194465f2mr16608935ad.8.1723852999301;
        Fri, 16 Aug 2024 17:03:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fb470sm30534565ad.9.2024.08.16.17.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 17:03:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <71d341e0-d988-41a9-bf61-c691537749fc@roeck-us.net>
Date: Fri, 16 Aug 2024 17:03:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to
 yaml
To: Rob Herring <robh@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240814181727.4030958-1-Frank.Li@nxp.com>
 <20240816215555.GA2302157-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240816215555.GA2302157-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 14:55, Rob Herring wrote:
> On Wed, Aug 14, 2024 at 02:17:26PM -0400, Frank Li wrote:
>> Convert binding doc ltc2978.txt to yaml format.
>> Additional change:
>> - add i2c node.
>> - basic it is regulator according to example, move it under regulator.
>>
>> Fix below warning:
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
>> 	failed to match any schema with compatible: ['lltc,ltc3882']
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>>   .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
>>   2 files changed, 94 insertions(+), 62 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
>>   create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
> 
> I'm on the fence whether to move this...
> 

I don't really understand the rationale behind the move nor the rationale behind
the rename, but then I don't really care or mind as long as no one claims that
the _driver_ should be moved because the devicetree bindings moved.

Note that "basic it is a regulator" is a bit stretching. The driver's regulator
functionality must be enabled with a separate configuration option; the driver
works perfectly fine as hardware monitoring driver if SENSORS_LTC2978_REGULATOR=n.

Guenter


