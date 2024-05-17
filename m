Return-Path: <linux-kernel+bounces-182691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C197F8C8E85
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D6428198D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7F1411F0;
	Fri, 17 May 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Hj/VUd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6921373;
	Fri, 17 May 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988851; cv=none; b=OPpYhynsDdnee5D36852xGudxEK4vIchUKZImDrFcHR6x4qEwxjshka5MvBbpa5HNdvLFRhfDpvMBbufAkRBPF+YWWnfkn9GS+wsl8Hilb0Wm5zZUS2pKJTt1jQ8XEafWc5nWWePiOmfPmjU5M5ToyLcUgU8sE/VNOtegYXC1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988851; c=relaxed/simple;
	bh=YpWk7gBrTehwAwLinhvvtDdY2x8cHnw1sT27fb5RXXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAHpKqXaegq5dRuMOkTCJWZ1v+67d/O3MgZ49viFQUqfXuGgUmOJisVtdoSxjPnfxsk/NR/Bh2j2+js4EyWZxoMH+2radhJlC3AB6WVpLGPiXMtfPY01mYQjdfvTb2tOHyd22X6b4wvbPShj9y3qk8Slr4P4BaGXD7QJjQzfn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Hj/VUd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1edc696df2bso27807315ad.0;
        Fri, 17 May 2024 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715988849; x=1716593649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+/sK2PQiF2i8Hy522ZlTIVQex0uONRXvF9Qxm4LDRbI=;
        b=l7Hj/VUdhc2n9wKxi00eDHofkafrIzcm0Um+asMSMVDpwftn9V2DwKp0SMxE7ONO+A
         JLBs/EdmrS58b6h04YZy+t50gkgtS3zlIb8po4cX5Ml+OOPFvCjOqfv5krYtJ8n9325t
         MlQKK+VSmgnpEp1RiG7ToGJ6DxQLegGTgbb5c2MmgVdUB6lQicJy64d0Uz8CJGcebQ5V
         agXvJOvQmTnrhwbEFTpQhfoK569/oaeq9cX4zBb5L3V4lv6qoI8SeLecXNjztcXUmCm3
         Aa5sE6DHTQh6DS+ssflD7+kK3lXGJg9LZw2uM/WhVE9U8VRvjRjUaaW777pLtsZU6G+W
         g9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715988849; x=1716593649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/sK2PQiF2i8Hy522ZlTIVQex0uONRXvF9Qxm4LDRbI=;
        b=s1NAr9wQCZ+Jay20e7C59iMn9oR1JlhwELlH3SE6sp05E7/WKvLLbZbT0nI9E/SnLO
         NWrEoOmaFwa3ZK3wRnxItWSA29nH/BibWN9SMbvq3V4sZgYkI8sY0X9XmXC0jdBTZz6S
         Ud33s+0CzJ6T9epp+67FTpESPDDEPpOYS4N3ounpqi6AW/0PMk/rPswJ2ucjTcJKTiSr
         cscta+4AYobaH3u9ZR+XDFjCB75rLk04JeEbvZAn/0h1+yrguHi0xn2OJSSx6EAElDuu
         zsMLDTVgFLGxzox5JlO0C5/5MpKrHHLUG0dvLZiAP4rweX9P/eyTMVSmPRCpNIu7jIUB
         +cXw==
X-Forwarded-Encrypted: i=1; AJvYcCVDErRda0PMdSohmsmyqS82uh7TMzz3B/cZimrLleuINPq+IxfssvGOWyk2LH/kp6WQv768TmtF3m9uykxIKyZ18aNesESiR3D8uC4/b8s2B9ANcCnwTgPlQ3zxxgH4BrxDYsx3bacs
X-Gm-Message-State: AOJu0YweDsCfmNY3hqsL0bKM8q079QIyENQWgsoBjEA6a2r+wEkwp5YU
	fynZT8eC3mG9EWSjgb0b8G5f3YpaHZKqn15uIrNb/NnbYNkttfnZ
X-Google-Smtp-Source: AGHT+IHgVJYDbiMVxJeaKDeS8OIiO3+B1aHLYYmBufZSgfi+ak/ZEGCPAK6/89sxXWYxzBEX4hld/w==
X-Received: by 2002:a17:902:6b82:b0:1e3:dfdc:6972 with SMTP id d9443c01a7336-1ef43d15755mr242284285ad.9.1715988849387;
        Fri, 17 May 2024 16:34:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d166esm161629185ad.36.2024.05.17.16.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 16:34:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
Date: Fri, 17 May 2024 16:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
 Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 15:22, Russell King (Oracle) wrote:
> On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
>>> Report an error when an attempt to register a clkdev entry results in a
>>> truncated string so the problem can be easily spotted.
>>>
>>> Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>
>> With this patch in the mainline kernel, I get
>>
>> 10000000.clock-controller:corepll: device ID is greater than 24
>> sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
>> sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
>> sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
>> ...
>> platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>> platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>> platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>> platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>> platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>> platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>
>> when trying to boot sifive_u in qemu.
>>
>> Apparently, "10000000.clock-controller" is too long. Any suggestion on
>> how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
>> for clk_hw_register_clkdev() is not or no longer a good idea.
>> What else should be used instead ?
> 
> It was *never* a good idea. clkdev uses a fixed buffer size of 20
> characters including the NUL character, and "10000000.clock-controller"
> would have been silently truncated to "10000000.clock-cont", and thus
> 
>                          if (!dev_id || strcmp(p->dev_id, dev_id))
> 
> would never have matched.
> 
> We need to think about (a) whether your use of clk_hw_register_clkdev()
> is still appropriate, and (b) whether we need to increase the size of
> the strings.
>

It isn't _my_ use, really. I only run a variety of boot tests with qemu.
I expect we'll see reports from others trying to boot the mainline kernel
on real sifive_u hardware or other hardware using the same driver or other
drivers using dev_name() as dev_id parameter. Coccinelle finds the
following callers:

/sound/soc/codecs/rt5682s.c: dev_name() used as dev_id at line 2833
/drivers/clk/sifive/sifive-prci.c: dev_name() used as dev_id at line 540
/sound/soc/codecs/tlv320aic32x4-clk.c: dev_name() used as dev_id at line 475
/drivers/i2c/busses/i2c-bcm2835.c: dev_name() used as dev_id at line 189
/sound/soc/codecs/rt5682.c: dev_name() used as dev_id at line 2909

Guenter


