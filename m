Return-Path: <linux-kernel+bounces-235070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE31A91CF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8DDB215FF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E5E81AB1;
	Sat, 29 Jun 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbdNHKnf"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0881DFCB
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719700011; cv=none; b=Arv6iGi2auFvWskzooc816VrLciJQwgzzvuLDthWktthksxbS6LpibMrupK+exhrArcihqNrpoYYGQrNsSNlmhoUDlvYwnbesOGLkfELZFPuAeV1xX/LyWRNI/hzkFuQl/8xPXR39YDLvNhIM48HERjJ10a3aPe89JZTL7IsBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719700011; c=relaxed/simple;
	bh=tYtH3MlN2z9RpdezjvcCJP8R/3Vs46cf8FLXHubZH3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt+Bj3P6FixPsOzwpsDvguR7MThYkcGcdzctupEWxtoyLqnfdP6F6+nV/PpODNha1MGhEvmkhERr5Xb4PpDrNunL1qKZ6ZUsCRf7XsEBccr8/qxF7M2hRC6YIjsN7vbnguxH/Rk3+faZ/v/NvBrF8s7gy2U+wcnyhtznZIc8Vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbdNHKnf; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d55ed47cc6so1136697b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719700009; x=1720304809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UIIr+dU4neUc1zz5jhTlJi7h9awTn3F44bKk5Ve+FNQ=;
        b=MbdNHKnf5mi9thT/puAvO6vhNvlrKeMXOaTBS9tOfX4B74u8Ue6sqieQwysOnvHYGa
         XAtsqGGEOrLliHCgxowURadwrJGW3zG/smcHAlQmhu0dirgAju0E/GkPyF2w2s8NHIVy
         x6Cp9rQ3R9ig2bqh/N0BPLp0dBjj494L1GfQf1Gbc8/xjZfBqC06Tx8Q5LAv/mFmP/qW
         FMm95qydF3hLJ6oK6URW4+FcbfQOom8zwDjrS7W82AwrJJmqAQLN0rxBGW4/IQ0OmvPL
         oxn6QKto851xJm6rCg61jA+TH9ttBe9HFrkvF0m564F1xOvfcu6EgZFZSUTLyZjSYO2I
         6e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719700009; x=1720304809;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIIr+dU4neUc1zz5jhTlJi7h9awTn3F44bKk5Ve+FNQ=;
        b=R1zluJn39RAUr0GY/2rMxhS0rDqE7dQC84hBJI81Q0UaJyb8g2zoad6f4LOI7YYTHB
         lxbvHWrsaBvY5gJDhhHNHifMQhiXDLCyf1+Dq5+i6UImQs2T0oSo80IgDgoR9gD9i/tp
         04N1VfY0dGP3ClFfCP2j06709WV+AhU7Bh8+N7bpVbXdrivbjIFY0GXzFopOW5+UcsgZ
         IiV+Q/lj+VVFyl8uoDA6HUTAeP6MCJ2aiFglAU40C+w5Skt/CoxMtqHc05fsTixE2/lj
         FEI8UYN1J6IkF6gYVatg6OztpF81Y1nv/lQt2qutAhWWnLpfmsApBv8S3N+wnfv1mWWY
         o97A==
X-Forwarded-Encrypted: i=1; AJvYcCWiIGrD06zsmFp/HsAb52C9asiqlx9vifV7tAquXQuJJ0G03QDw8RbF849XL4rpByA1AQdWBkbMbJ+9HCXKmjgr3s/3BZZmjdghPmaw
X-Gm-Message-State: AOJu0Ywat9OqwoMLn3K9xkhc/X5dmmqMVImHvmuuy24qdxINCn7EQgmZ
	3HhOYeDlNQmsnOLh5lJsX4PGPQhQDZH5BzQH0wAbsXsupNvW2p/qRSv7JA==
X-Google-Smtp-Source: AGHT+IG5KISZHRzwWDJCV0yhEm1mdeWAm0oKXtgwP9wlN8DgVsnbrw/Da1fLvxkhcOQplCxQEYMvBw==
X-Received: by 2002:a05:6808:1996:b0:3d6:370f:e33b with SMTP id 5614622812f47-3d6b5590420mr2676492b6e.51.1719700008994;
        Sat, 29 Jun 2024 15:26:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568e90sm36807505ad.188.2024.06.29.15.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 15:26:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ecdfad0-df83-498a-b487-b8c52def0bce@roeck-us.net>
Date: Sat, 29 Jun 2024 15:26:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] eeprom: ee1004: Call i2c_new_scanned_device to
 instantiate thermal sensor
To: Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20240629173716.20389-1-linux@roeck-us.net>
 <e519e9f2-5e25-4ec3-afb4-42d15da941aa@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e519e9f2-5e25-4ec3-afb4-42d15da941aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/24 15:00, Heiner Kallweit wrote:
> On 29.06.2024 19:37, Guenter Roeck wrote:
>> Instantiating a device by calling i2c_new_client_device() assumes that the
>> device is not already instantiated. If that is not the case, it will return
>> an error and generate a misleading kernel log message.
>>
>> i2c i2c-0: Failed to register i2c client jc42 at 0x18 (-16)
>>
>> This can be reproduced by unloading the ee1004 driver and loading it again.
>>
>> Avoid this by calling i2c_new_scanned_device() instead, which returns
>> silently if a device is already instantiated or does not exist.
>>
> However i2c_new_scanned_device() runs i2c_default_probe() on the device,
> whilst i2c_new_client_device() doesn't access the i2c bus.
> If possible I'd like to avoid this overhead.
> 

I am not as much concerned with that overhead since there are already several
other i2c accesses in both this driver and in the jc42 driver, so it seemed to
me that another quick operation does not make much of a difference. Also, I
wanted to suggest a solution which does not require changing the i2c core.
However, I am not "married" to this solution. Please feel free to suggest
something different, or to drop this patch (and the next one) entirely.

Thanks,
Guenter


