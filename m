Return-Path: <linux-kernel+bounces-285356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06806950C74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61B01F2243E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C6C1A3BA7;
	Tue, 13 Aug 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgnHcC5C"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202D17E8EA;
	Tue, 13 Aug 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574561; cv=none; b=OH8TnauYxMXH9EIysicoSAVCILE9x8plvZGLp28h5sEFFXsleVmA88DdSyeCQYGn/2+kZAwpgzDDLujTkG4ObQu43I/JqRq+pe5x/Xjevx/MMsMr/WICSl3oIDg8R8BOB2EuwQfvTKfQE1B76pVi0iGoBQxvNIyPaN+bOOH6+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574561; c=relaxed/simple;
	bh=u9B9QPKvcwfbcfe9ufshZxGu95+tAMRCpFzgmu+5qY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYCZrZHi2aueM9Gx18E4bTx8mzB/haCqDiLABiAbhhUYV3cwq76QQuDhxaLt/U75i2KlO1wTxmcePOrGwI291rkAfmPGWn1AxzHQOG1hEkv9tC+sWle3heA2ssd55xDvdi+5S2Y+YgMJXkPrrJq4qdNCdylM2bvDeAbqr9iCv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgnHcC5C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso986995e9.1;
        Tue, 13 Aug 2024 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723574558; x=1724179358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FguCa1t4RQhRlAkkG1MGTqyPr8wo64yFx0MXXgGH9Lo=;
        b=kgnHcC5CyPIRqQm1lRIC3VenmVlViHEno1e9qzTLZBM/vv8L457IlXSyFu7TbFyKZ5
         /uzQ55Y/6aaayMEQwYTEh+U97GM3SFbJo1a6o03R6K37rkuHAx9tNXZbyMKeKI4xeTZE
         R/FQ4OM5rwj059HAFP5zsPJ1boGXRdi2A8iE6bHAaerqJ2ZJpa+XOIQE0NH8aQDD17tg
         8ouRy1WUg+NXUAUxJb/CDeFlMNfnUazktWQJEsudo3+XjK85/NhjpS+aDMa8I5VmjDH0
         CzikAYqDIVFp6KNz9OnfFyF0DBHZclTyA8p1T7snvqzI8N3kC5rObywyT/Z+Nz1CWKoi
         SVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723574558; x=1724179358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FguCa1t4RQhRlAkkG1MGTqyPr8wo64yFx0MXXgGH9Lo=;
        b=u9vMXp4dUkZoQjBrM3prG2xyVRnJgBL2ds9bBmWr0PwvwdpCIG8d2zmZ/QoZ4KrYqp
         t2Yoku+TPZh4Xl9/Vo1W5PMDo5bIjW3LFjn7DIYuApbIxujKe29pYapOyZi6TaRrrFjj
         JREU4JfwAIBhxQzL9qcul7OMZMZtI9RB/bM2z4JMlob0MqHTo4Q4xGAOQ+ibRQCKRYjM
         T8mW/VXmlO54SP2VjH6eesOpUcv19L4VmvrdUORxLeZkC2V/eJt9cdYxg4HlPOPB6iif
         AryOJ6vR1SaeLZT27t7/9DRv67gfuvZLUpvndeX9B4Bgt765UR0dIqZItVaw7/UhlGal
         /0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVADJKeo76XZPsuCG3tKKZAsu9jdp6R4Qz9nXkfUOmW39y7uRCc1qHutfIZkIs0vg27lhMjCeHtsio4e36osRwlMbOLSSLgPEiUaWpThc3XavsSy3DAwyfzCTkd9HGnU9yoJTyLVcxgCv4=
X-Gm-Message-State: AOJu0YyecxnbocWry5az7StLEzSXteLNdUaLL8bYn+9YfAKEIfqJ+gxi
	1pODPI9I9AO/SziO1npqmO2lKcqcEqXHqDdG35OuyaBd9W6knXrL
X-Google-Smtp-Source: AGHT+IENR74P9KN3PlfdJ3C7Ttb9XH3rW4nNkkJgmn9S5s9D4pHY3HrDzwRgDeBDbNvNi+L4Up+aPg==
X-Received: by 2002:a05:600c:3ca8:b0:426:698b:791f with SMTP id 5b1f17b1804b1-429d625a1dbmr28636095e9.3.1723574557414;
        Tue, 13 Aug 2024 11:42:37 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7492cesm235958155e9.20.2024.08.13.11.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:42:37 -0700 (PDT)
Message-ID: <708755c1-9f78-4554-b0c7-6fb6f7715364@gmail.com>
Date: Tue, 13 Aug 2024 20:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240811001503.753728-1-luzmaximilian@gmail.com>
 <9c54fd98-7e59-4cfd-b005-64af558541b5@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <9c54fd98-7e59-4cfd-b005-64af558541b5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 8:19 PM, Guenter Roeck wrote:
> On Sun, Aug 11, 2024 at 02:14:41AM +0200, Maximilian Luz wrote:
>> Some of the newer Microsoft Surface devices (such as the Surface Book
>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>> Module (the embedded controller on those devices). Add a basic driver
>> to read out the temperature values of those sensors.
>>
>> The EC can have up to 16 thermal sensors connected via a single
>> sub-device, each providing temperature readings and a label string.
>>
>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Applied. One comment below, though.
> 
>> ---
>> +
>> +	/*
>> +	 * This should not fail unless the name in the returned struct is not
>> +	 * null-terminated or someone changed something in the struct
>> +	 * definitions above, since our buffer and struct have the same
>> +	 * capacity by design. So if this fails, log an error message. Since
>> +	 * the more likely cause is that the returned string isn't
>> +	 * null-terminated, we might have received garbage (as opposed to just
>> +	 * an incomplete string), so also fail the function.
>> +	 */
>> +	status = strscpy(buf, name_rsp.name, buf_len);
>> +	if (status < 0) {
>> +		dev_err(&sdev->dev, "received non-null-terminated sensor name string\n");
>> +		return status;
>> +	}
> 
> If that ever happens, it will likely be permanent and clog the kernel log.
> Normally I'd ask you to make it _once, but I am kind of tired right now of
> having to explain to people that clogging the kernel log isn't really a
> good idea - even more so if the message doesn't provide any real value.

Ah, I didn't even think about that. I can send in a follow-up patch if
you want me to.

Currently it should be fine since we are failing the whole driver if
this does not work out. But using dev_err_once() would be more
forward-thinking in case we ever change that.

Thanks!

Best regards,
Max

