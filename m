Return-Path: <linux-kernel+bounces-278453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0A94B06E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A44A283A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AB1442FE;
	Wed,  7 Aug 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUiO8tfb"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C661097B;
	Wed,  7 Aug 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058722; cv=none; b=CNNqYu1TUMelytkTii9v9F1W8Acstl9JG1nuGU2MP59jRAeflj1+cRc8No7PpobJOla66rt94sC1XXoLsC7nIURSBkUxoqu698+E7bS5r/xt1i8vgESDYX8uxkdNdSZDpDL4Aq+VtMp2YFcS2a6fd0npBMBKd81QPD/MoKHNNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058722; c=relaxed/simple;
	bh=xmo50z2/fDtyR2b2OiojgGF9ojsLoeCZUE6wne8Dw7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOGMwIUTIbLrtlLIpTV+nrQ2f3kxKuGU6ZBHtU2b9riuDVyyskv+uvO30UsYA+W7dF2ABfxeg066EGLSHCjD6CIXeZ9olnZGnn33BXwGR4cUSmTTadMlT3I6Cf9+ZDe9I/PnpXMxOTKpAzG/+ChF4YLxeMxR/+1LzKZpDEUTQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUiO8tfb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso160352a12.0;
        Wed, 07 Aug 2024 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723058719; x=1723663519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmvnYp/pKQncmWPPhsCvYqxzJlPF2L74o1vYaLe6wYQ=;
        b=QUiO8tfb5xC977XQcxHmLBgANRTCUlNHtdkPkaNc67QJSmlq7IU1SpRWZVnopdP/Lq
         47VTe8bgPsbRuSr6T1m7mX5U8ndu7KfXtqiAATvViA5N79FIxoN+BnIotFFEheqwKCg5
         qQHx7RO8Wa0o1zuXPE22+I926ylU0L6KYCCrTbhULZ+J2I0jU30NFVlsBr5CSKavRfvk
         7iNiwLwmhRBdqrRm7VhXRFolY2FgWIxK8T6V0OvJm/jy/WLdYCsvnrIrABtL63cIGy+0
         VSGXzxdNLNcQBPlg8peuH896aJhUaFg4j7LWJ8UFKOfqiUrE0b5QaC3AGwtFbewFMRY4
         9ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058719; x=1723663519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmvnYp/pKQncmWPPhsCvYqxzJlPF2L74o1vYaLe6wYQ=;
        b=d/+2u0iM9Na5hYTuhOlBvS8xoXM1K/YsXDmAcci6zRfzWVjm/YsTUfSmX7xa7Ur6sO
         +HCJEep6mCfanuyYPaX1FC02ZGqAATZObC4WmkAraOIJawMDYAUvCj0vpSCNZOO4hLbP
         8xXluUoJ5x5UbLqpH/AQQOl2wnGDYVFSl+Up60vjCnK+0YgoLI9srAYBeIO2ufxH/s8F
         gyQORV5YnxNchXYUJO9ovp1pdvxZCkugnEMe7tKjofZxX5yA+tQ8XuC4m4eFwuHbDRQG
         VkfSjp14ZENinln70xVW02ZwN7hSVZZQZat8mdefk/eHqsyZ8ctM2nF2hDS5pvWGzZVh
         JZuw==
X-Forwarded-Encrypted: i=1; AJvYcCVLsKs9WdsOeuMuYBvKwZSbdbMa4ohoxLvmp+huDmbnGWAWVHb84/uozt/F1La34xnwQH6DVpVugtIWoiU9ZXf2yI1Z0CSkFGYSa0/v+WWDag+c8jlPv5KsPy+9jMsJWoraXiDVNvMIa+g=
X-Gm-Message-State: AOJu0YxbGxxdBUafja+6rXRbdBx+H4h4lVunDCPYLrnobHekwxPy20YX
	YADz9/9He9/NOyH/DGcostDS7A0Gj/0ft1P7a1YPHk/U3Sbs0/vP
X-Google-Smtp-Source: AGHT+IEW0dZYzXsqeOn9tw2ncQdCNK2ZrhkDhKwGrxugutF9HlkaN0732L+ceAN6OpfK0tH1AcQPIw==
X-Received: by 2002:a05:6402:3588:b0:5bb:8e11:f688 with SMTP id 4fb4d7f45d1cf-5bb8e11f82emr7877706a12.10.1723058718620;
        Wed, 07 Aug 2024 12:25:18 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm7239773a12.53.2024.08.07.12.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 12:25:17 -0700 (PDT)
Message-ID: <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
Date: Wed, 7 Aug 2024 21:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 2:32 AM, Guenter Roeck wrote:
> On 8/4/24 16:08, Maximilian Luz wrote:

[...]

>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index b60fe2e58ad6..70c6385f0ed6 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>>         Select M or Y here, if you want to be able to read the fan's speed.
>> +config SENSORS_SURFACE_TEMP
>> +    tristate "Microsoft Surface Thermal Sensor Driver"
>> +    depends on SURFACE_AGGREGATOR
> 
> As the kernel test robot points out, this dependency is wrong.
> __ssam_device_driver_register() is only available
> if SURFACE_AGGREGATOR_BUS is enabled.

Right, I should have spotted this before submission, sorry. This should
be

   depends on SURFACE_AGGREGATOR
   depends on SURFACE_AGGREGATOR_BUS

I'll fix that for v3 and likely re-spin this weekend. Anything else I
should address for that?

Regards,
Max

