Return-Path: <linux-kernel+bounces-189521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9B8CF12B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978C01C208C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C43127E35;
	Sat, 25 May 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL0Td25q"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31386AFA;
	Sat, 25 May 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667125; cv=none; b=syyyGpH5popG0uFhi7NWGqiKnUqtbnePTPdogpJkr3vrC7x77po6h4tiyuubQNx07DBNjebIZv1tbtNNQwdApTdl9Ke8gXon4YwOvqZUXr2KsHhwu3NTboopJcAJCvg+Mg1s8wxQnAzg8yKKXIKDiWM1hFlYM0fAVDazIGkigpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667125; c=relaxed/simple;
	bh=wkASmhkuNhordunGV9cbbtltsEWHnGhrvN5NE79EGh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfo47RSTL+6rvqB52kYFO0cDQP7sdTSKEWI6cvAql3r7cHlQUnXLSZpFUtEbVSCdtAH14dK0ubt2DA/I0rYrp3aJaORRgubjmHSAmH9fW+H67+hGa73+F4GJ07/dZsXMWIjxR2o2V88W0tP6oSGsW19ucXpBgbiWgT78GnXO66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL0Td25q; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3737b47c0acso9334315ab.3;
        Sat, 25 May 2024 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716667123; x=1717271923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GQVxu2trqxiGUl/hxP5eWODXErJeeFfaMtGOS0vO/eo=;
        b=aL0Td25qTLJNfcOB0KiYoHZM6yS/vGtJMjvRE/Dy20bKvLBBdSzZgxATDGxmlv45i9
         X2VcmenI6PCiVh7ihq5T6IgjY5rzzHdHpS/yoDvi0HNzTwyA4LM/XuADOSMYjuwz1e6j
         EeljWLQaLWDOW2rpZmg39bIRSRy58BMb5tkma+EYZbmwrgMbF2SiwmzInSZLSCQS+C4S
         TfdIX+iQPty4fINzB/0MhCz5kDgnsKElwYoSRFlwUJNNiRtOTGzve4u2rxRqEBtTAFN4
         a2T78u838s0xF0s72PX12bNKRTt//N4yPGKLmTIQqXhy7JECCxwX0NLfFz5V7sCqxuWM
         RzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667123; x=1717271923;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQVxu2trqxiGUl/hxP5eWODXErJeeFfaMtGOS0vO/eo=;
        b=v2svmCtV8mZ1KqNqYNkn9NIl0lpGdIUDwhvYWhhsVt274YPQSmtp/F0YPDp4ZfATgz
         SmpKB8uKY6CNRnI35yqs2pTfuLF88W1tH3gnrgcoDka1xsYsrQF6WDSFXx4CNuGcYMZd
         eYvjVoEUGy5ciVJQ0426+3R+iDZIFmImkZkst0RyFlkts7SPvP6SYzBAN4wOeDVPw9O7
         8qsr6KjBqO/GIDUxd3mp+RpIDKjarFluYr0vRcK7U8am+6oOPUncAUKHb3zEpIPKgLUv
         UEZXVJIHfopP1sgHS3Mw9kv2yt0TuA866vfdTDqqhwPaVyDwx6eBynZXkgB/Pc7ywAoJ
         xsBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1u4Gh1p2tH24uTh8oQwke8pblsyhmsdhPy0RoxOJ5n7Q9scU6p3RbDIy2F78N286VKEZT+oHs2Ya8YkcB1lmiix2DYQafED4/Kqbaw/UN8bvkBKyvRkQKHLGiSot/wLCaFk4W2d3KsB6bjDOcGCSeHf5hgoGfOZT4jLSVI9T98KL5i3FJ
X-Gm-Message-State: AOJu0YxXESrgbsFBEnWnQDKIicdASWZ5YFoL25t7JY3TGsqk+vcAyy5B
	PUUGlzUwYYMGkFCE40ZmFJGyf1TlH3d8Mh/uVbKTpo1VNXcl7h0h
X-Google-Smtp-Source: AGHT+IEDqTSwM5A+Krtfyy0F2LFuGpZhLLd7rQFTPoWLLsFTEg1p7nXGxUQ/30h2jRYONQ3+tLR3Bg==
X-Received: by 2002:a05:6e02:1aad:b0:36c:5120:941 with SMTP id e9e14a558f8ab-3737b26addfmr72028835ab.6.1716667123244;
        Sat, 25 May 2024 12:58:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822073fbe7sm3099718a12.15.2024.05.25.12.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 12:58:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6cfa48e3-ce77-4736-91c7-7c4ef158935e@roeck-us.net>
Date: Sat, 25 May 2024 12:58:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: g76x: Add support for g761
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-2-ansuelsmth@gmail.com>
 <22e1daf4-ffce-4fac-be4c-0e7bebd91c88@roeck-us.net>
 <6651f77a.050a0220.9b079.fbf3@mx.google.com>
 <818aacc7-5244-45e1-844d-561e8540cb46@roeck-us.net>
 <6651fc46.050a0220.5b758.034d@mx.google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6651fc46.050a0220.5b758.034d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/24 04:12, Christian Marangi wrote:

>>> Well with how the driver works, if a property is not defined, then the
>>> value is not set and the one set by the bootloader or from device reset
>>> is keept.
>>>
>>> This conflicts with the logic of no clock = internal.
>>>
>>
>> Not sure I understand the problem. It would be a simple change in the driver
>> to add "if the chip is G761 and the clock is not provided in DT, use the
>> internal clock".
>>
> 
> Yes sure code wise is pretty easy, my concern is more of losing this
> info in DT. But anyway ok will drop in V2. Thanks a lot for the review!
> 

Not sure I understand. This is added support for a chip which is not currently
supported. There should not be any information to lose. What am I missing ?

Guenter


