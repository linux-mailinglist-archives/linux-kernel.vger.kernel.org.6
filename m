Return-Path: <linux-kernel+bounces-219922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1E90DA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F9281A40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5B7C0B7;
	Tue, 18 Jun 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF6fI0f1"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F139AEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730113; cv=none; b=aGkJ2dDn89AtSHVVh7xQlLk3KjCGPgDqMyKVm1Ay/Wt8uVg5uy3knNGj6fA1FhKUUeDUGDM1Y9Frfo0xbq+Js+ivVsnZobimZEQEX1yBqkWfdunBDGgpsVojoERS7KJI5toBR2XXw4MKz+1egyLiYxadNAUEEc8LBK/CUulq1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730113; c=relaxed/simple;
	bh=ICD3mTK7+JTZGNuEY2CN4HpzCb282Kiq3AtxSlLjxd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bi2mrV/UTcVbUALJn3iw5sp2v8iLUCsOQ4GYsSwv3RkdU7U34MxDd6EKZOeTD51ANr96lmLzYZ00NT41201+Mq8Y300wIan/5jt6tnhABWWLfm0mgvZhwK2W0FmFzwl5fn+qfEOI7wKuxGzaMJWr7Kvmetwrqaemy68L88k5eI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF6fI0f1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7023b6d810bso4212050b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730111; x=1719334911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4P60XkUA19D5vEv4ptL57xyoR37I5zTEpmFVtVTD8E8=;
        b=DF6fI0f1Ve6GAcgMxkPPCc/NWzhTHAtbdSpE32tTqjB1IBiuoCGLAT94dTHvBiWBk4
         LvPli9jSY7+OrH5bj1G+aajsNarAYiBQjprhrmasLn5t0lMoUExCCLYpxBdzklWMPjXc
         kkZUqL0uMeGdCiAEkQJI2KcyjpW9KzjjvNQD5L4dihhCgBQvHhANJvjiaP7dh75xhJgO
         q1IACb8SEmPR33qVCBPgAQh13DnRoiGw8LjRhLMclsk7xugQNmWx1rS3RBK30YZ1yfoS
         w1VJ7N22IaH7IYTdjMuPPAV6BgxfF+ffni3DPj36f0OJzLo2rnkkjnbBSxJE28c5O5h2
         6O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730111; x=1719334911;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P60XkUA19D5vEv4ptL57xyoR37I5zTEpmFVtVTD8E8=;
        b=Rd4e8BIgp3ibc9Jn7XSRTp2P2JESOfW8woEwp6SGsqjjIGofvf0gO9y08G06oKzsjk
         9WuO2BVBLNOQ9UcwFODMcLPixV+xeISb9pmqp7X5Y0K3Dg3Mh5Ayn9+LLgMDuKq3FW7k
         lNnSRGANJc+MVPPKDYkNLtXWX+S3MrBVcaN9Ivd7U84EtvZMiJApgRIGIS5QxuaZ+WnU
         BtdTt3SdhhBzKZEvTw1wKVj07TD2bqjx27rRD5JduuWYq0jHsmHgfKNHfy9kx5GR7Ln2
         z1UGtXKbIXeDtc8zNURTNdIIKP4bCJezTer2pd6JpDBBySFGGdnqnrHiAObQL1MNJq66
         ldgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7eCX9hKEfQDOsVhzRcKv+vP7YWE9kveYlW0QqHlPvk+F9eZzAoVFuUnlQnXSjgAXoRD1Q2apvW1JeIt+9Xd3CB8Q1UANRakbvqUII
X-Gm-Message-State: AOJu0YySyEYytBFZD9HokwdhQEpWX24gJ8rw+eHJpLGFi57SbYdxwPAY
	03t3CE3QXijzh6dHKuO7lF8w/KQokjftoknZHXO2ebfowRRhwRSq3dyi+g==
X-Google-Smtp-Source: AGHT+IHqm9qtQtVFeCh2x2eyOvebTtYvjx7qjjrU+oLH4AdqoTOBslItl19nCnjyAGY+L5W3R2Ao7Q==
X-Received: by 2002:a17:90b:1107:b0:2c7:8a07:bc57 with SMTP id 98e67ed59e1d1-2c7b5dec045mr273051a91.48.1718730110657;
        Tue, 18 Jun 2024 10:01:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4aa59ff02sm13390551a91.1.2024.06.18.10.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 10:01:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19a3a20c-7560-4531-9f0f-8e9316b3235c@roeck-us.net>
Date: Tue, 18 Jun 2024 10:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,

On 6/18/24 09:14, Guenter Roeck wrote:
[ ... ]
>> So surely this means that the entire register map is one window and
>> there's no point in defining two ranges?  Those registers are paged with
>> the same selector as the other registers.  At which point you can just
>> sidestep the issue and be like the other current problematic drivers.
>>
> 
> Just define a single range covering the entire window ? That might actually
> work if I manipulate the nvmem addresses such that they always point to the
> upper 64 bytes. I'll give that a try.
> 

Excellent, that worked. Thanks a lot, and sorry for being slow in understanding
what I needed to do.

[ ... ]
> 
> Anyway, this may be all irrelevant in respect to regmap support.
> It turns out that at least some i801 controllers don't work with the
> access mechanism used by regmap, or maybe the spd5118 chips don't support
> I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
> auto-incrementing the register address and actually reset the address on byte
> reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
> from the first register). Since regmap doesn't have a means for me to say
> "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
> I may have to drop regmap support entirely anyway. That would be annoying,
> but right now I have no idea how to work around that problem.
> 

I think I found a workaround for that problem: All I needed to do
was to define a regmap bus with its own read and write functions.
Please let me know if there is a better way to solve that problem.

Thanks,
Guenter


