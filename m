Return-Path: <linux-kernel+bounces-410942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C6C9CF0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97441F20F76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10241E570F;
	Fri, 15 Nov 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVgP3eLq"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539A1D515D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685590; cv=none; b=oKwRMl2S3dkqqBPx5qWOKrsieNfwKHV4XYDicx+GllcDOWVRP1n3jCpQCVGNGnvf9OyQiaWYTnxXJzd7yje6Cw11GBYKJPw/4Q7/1AhnVrD4bO7Ff3185F/hdAuxTOQlMUsit5Of3tCuHkoasLolltpBXA2ckBRHkyGX0D5Loco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685590; c=relaxed/simple;
	bh=fxza48pWdRX38tUT4WjzOiBCViGIisRYft+Qqy7NvS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoRNn29b+UqYNYZmmKGuk4+LAb7PfxUEsEERhC7aMqddSX7/UzRGskXcQGQQySGhkta2WAMJYZBAn6+mbp7lBwgueFHIMWPTHjacU2QvoYEtmklYzG0jSqeBS7PJv64uZ0qUc/KLAJZ+9IuXHVG2MFgnwV7zbe8G6ny79e+4COo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVgP3eLq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea14c863c1so864702a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731685586; x=1732290386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EndnXjGYkE8hIqrZD7shl7AI7ld13eGT5kmM50PYq/M=;
        b=hVgP3eLqgVSA560+tWpWqv2F7vUrMC6CCkDMiMXoIPaJi1LzfQL30yrZH4PTxhU8jA
         KMBq0JjrU0I3Edb041p5cezhyx2Kpa5WH3Ngq79cKUAvYPgZYo5e4esJEYqt82uaZaZI
         LCexnG6Z3wm7Th7bK/hD6yBzCRoquzx1LCrzFg2Jo7k4W2OxdJtG4I6dM+VEavjngb/n
         rM1tU55P9H6CIIsA/kK2p+PMaky0J27AW0lWNIytO9O3TewbiS8+kHx7vYSjHgYEIBCa
         vSeBDOTIxc25M69mhqjbZj4phaLwBdAotCE86sV6Khtzx0lR+6jVWjKCq7KJ+YT1r6kL
         ijVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685586; x=1732290386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EndnXjGYkE8hIqrZD7shl7AI7ld13eGT5kmM50PYq/M=;
        b=uWNUbw5lkP1krHxQsKi00NIb5r84ZXRVaKiifKeKd09gKUIpR6Es9PSlktq9gfZpqa
         FFOrru7wOcAh9IhWiIGPrQ5MyVPrUMaBWoGGkKBTeiL7t2cn/JOIcuHxv3Kko/ene/0t
         7wt/aXcD1Z4ycboQumn94CSQeORRDT/F6ZaN31FJlETSSP6PPyjRv5tdjbte//I28DaQ
         TErds4o5SqhCPt1yVEgL5b2L7eYKnNpauZfKFPH5Lt2IO211gvVFVMxFZtLHTImT743r
         uj+gs02wlmAoWUARKSiplvZxfakvcy8DakH51JfADuHB0JuE02DS/TcTtV09BXWAcxdA
         W12g==
X-Gm-Message-State: AOJu0YzjFtK03dV4ENc6iJoJ1CXsMW7qqgyayU9JERcMOZIeFHHlZkTM
	xCuWOA89j3fXHg5pzc8AuQ0CslERWjkJpoQqfl5WSxxQdTo4/Tr8
X-Google-Smtp-Source: AGHT+IGUuSER4N0pRUs4hSu8pZBKOSz9Wf3hlPXOEMtNXU/H7Y6N7g5ZCM6bDvopjFPRC4MDFOLneg==
X-Received: by 2002:a17:90b:278e:b0:2e9:4967:244 with SMTP id 98e67ed59e1d1-2ea15585d4dmr3787694a91.24.1731685585516;
        Fri, 15 Nov 2024 07:46:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea2d9bef78sm144435a91.27.2024.11.15.07.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:46:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6344faca-d312-48c1-91a3-7b2b80f4a529@roeck-us.net>
Date: Fri, 15 Nov 2024 07:46:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regmap I3C support
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <7b23e033-5cde-44e9-be97-10296833863b@roeck-us.net>
 <ZzdjWWrTK1bniwFf@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZzdjWWrTK1bniwFf@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 07:06, Mark Brown wrote:
> On Thu, Nov 14, 2024 at 10:58:05PM -0800, Guenter Roeck wrote:
>> On Thu, Nov 14, 2024 at 05:26:19PM +0000, Mark Brown wrote:
> 
>>> Right, so the fact that I3C depends on I2C deals with a lot of the
>>> problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
>>> should be OK and there's not much doing for I2C/SPI.
> 
>> Is it really that difficult for I2C and SPI ? The patch below seems to work
>> for the LTC2947 driver. It doesn't even need dummies (the compiler drops
>> the unused code), though I am not sure if that can be relied on. I thought
>> that dummy functions are needed, but maybe I am wrong.
>>
>> The Kconfig for the combined ltc2947 driver is
>>
>> config SENSORS_LTC2947
>>          tristate "Analog Devices LTC2947 High Precision Power and Energy Monitor"
>>          depends on I2C || SPI
>>          depends on I2C || I2C=n
>>          select REGMAP_I2C if I2C
>>          select REGMAP_SPI if SPI
> 
> This prevents building the driver in if I2C=m which isn't always
> desirable, and IIRC the randconfig people kept turning issues up.  You
> can make things work well enough for normal configurations, it's all
> edge cases that cause issues.

You mean if SPI=y and I2C=m ? Good point. That isn't normally a problem
for sensor drivers, but I understand that it may be undesirable for others.

Thanks,
Guenter


