Return-Path: <linux-kernel+bounces-300594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73695E59E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FF628113D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14B78286;
	Sun, 25 Aug 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZArRmazP"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F17581A;
	Sun, 25 Aug 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724626235; cv=none; b=YLlAEsXJRRNjrcEIWUpK2x7xz5H5vOq7/cW3YopjXDXKVbQftqO+EQpp7DR1Vq4HYgJbYzvL8ONmtnzq5v0JBv8iLG7nG7TramyBm7GYyjtGcegkpQ0vugiHljCALH28glVjs8+YHB5hKUafnknYYMMuO4hz8W26wmE6L5u9kfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724626235; c=relaxed/simple;
	bh=+o0i416eH/BxwxgcnKHpFUYR9odI3aGlHBULZvvYdPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLcOHDatzWPqeI26gWO4Qv9LTfX4eb/o9X4QQ4/Iwvyv1PKSNZ2rBPvC4IBF69FReY6GTsfVFel+Qj5FtZsSTt8yb4bWRKGUdH1rLFFi3lBVvYnQXI3OSayvU/9sAmBWxOgxYI3iPc35//6WEq/L72x4yfHvxqn4HBb+MAZkhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZArRmazP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so2691316b3a.1;
        Sun, 25 Aug 2024 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724626232; x=1725231032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=46SEPkPAcNFBBen6lrJxu9erFqd1xqy881KN2y/ySws=;
        b=ZArRmazP5t8DRZlvB3azAZh1OX9CqW1E0dIO0Iw0Mn/IVgP69T1NCeT3pmGj7JQ3TH
         urLWD72tLI6PnmlUoD4ZFC47P32MLYgsQp9RaKal1LRr8PT51bNXiITssOlfFMG6LFY7
         ZR8Tr/7aYkP8057XBs6cjxyg5a4BETx4zTs3/8LD5k+qilbFb32lapfhyWllKSb5YiIp
         11mWxA+t/UDKHf5DLjoQuvSZWkRS2/qyntkMDbdkQ0j+kESudmGfVvpoTLNQz1Jfp5yP
         qBmVOqK/OVPtz/CKb59WCIu7R9a2S9HucnToOBYvW7JYnEYbzu6CirzCPDZnGT7vlgZd
         2sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724626232; x=1725231032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46SEPkPAcNFBBen6lrJxu9erFqd1xqy881KN2y/ySws=;
        b=G1iAFaHbuw90N0NN/uvj0c3XZH6ddr7x8AOgQvlzVsSlUZoHsoFltEgvVYYirGfHjA
         kbBFVnZqTnwI2/TU5jILnacEkuCkZOzDMnwC3+0fxWlIOkHKLnpAAgn9Dso9WnTQafpZ
         Kr3cm5LDYx+hBgzRD5TcOTbyi10ehIAT6xt+53AfBphDcpLIoyq/gHNgAW5s0LDRdyBH
         WRcuyICvZ5Hgf9J0uT+lx4fL6zI/3vr4csVcU6kmIrdQZ6pEOO+PLGtxINDvXOSxdUgx
         9x63eL3yu6PmskW9szVMRGD6/aWr8LE+52t3Wrn8u8po/dV029n1i/okb3iglbE9kB4P
         8AEw==
X-Forwarded-Encrypted: i=1; AJvYcCXgYwS19hCcILRMjLovrHrFqbwN0sgVko2Rck+BH7gKFijHFsJyr5GQ7vVbxF0eDTt/hrD183dqyzsKVl01@vger.kernel.org, AJvYcCXn1BjNjqU94AP+R0ucblBJPu0lM0c2Czey+dl2LxH4N/QaW2w1UDwkIZ4WGumacNvEcPs6R3Cs+ZCb8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8BEoMfkwpQbbNrOs5YYvHOfMCZQVBnoOENIVt1VaUmayjQC1
	UXhjtr7QRhHvKeNunfAA6PdCXPipZV0jvXGumpgaVsuv5TsdJ6wuAt6pAA==
X-Google-Smtp-Source: AGHT+IGUmxSd0fTLZYsVSYDu8yg32LM+0j7JLlXRnD72C6WFur47Kn9ldCKCHX0rGvVBpqLB4yxEsA==
X-Received: by 2002:a05:6a21:4610:b0:1c4:f247:2046 with SMTP id adf61e73a8af0-1cc89d199f0mr10229660637.11.1724626232434;
        Sun, 25 Aug 2024 15:50:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424f942sm6068554b3a.65.2024.08.25.15.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 15:50:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a1df032-dfb6-4a26-a27d-14cc301cf12c@roeck-us.net>
Date: Sun, 25 Aug 2024 15:50:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
To: Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <935f564b-fa3e-4cdf-bf12-19b897369a07@roeck-us.net>
 <20240822074426.7241-1-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240822074426.7241-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 00:44, Wenliang wrote:
> Thank you for bringing up your questions and suggestions.The SQ52205 is a
> part number specific to the Asian region, which is why you might not be
> able to find it through a search. I'll provide you the website
> (https://us1.silergy.com/zh/productsview/SQ52205FBP).

That page does not point to the chip datasheet. The almost identical
page at https://us1.silergy.com/productsview/SQ52205FBP does.
The datasheet is _not_ "Publicly available" as claimed in this submission.
The version I was able to obtain is tagged with "Silergy Confidential For
<my employer>", so I am not even sure if I can use it to review this driver
submission.

> Some registers of this chip are similar to those of the INA226, but it has
> additional registers such as integrators, which is the main reason why I'm
> offering a new driver.And I plan add drivers of the same series based on

That is not a reason to add a separate driver. Look at, for example, lm90.c,
which supports a variety of chips in a single driver. The ina2xx driver already
does support several chips, and adding another one would be straightforward,
even if it is from a different manufacturer. On top of that, only the EIN and
ACCUM_CONFIG registers are additional, and the rest appear to be exactly the
same as INA226.

> this. I commit the new patch and look forward to your reply.
> 

Additonal comments:
- Please review and follow
   Documentation/process/submitting-patches.rst
   Documentation/hwmon/submitting-patches.rst
- As mentioned before, a reworked version of the ina2xx.c driver is
   available. I am not inclined to accept a new driver for this chip.
   Even if I were, I would not accept a driver based on deprecated
   hwmon APIs. I would strongly advise to have a look into the reworked
   driver. As mentioned before, it is available in the hwmon-staging branch
   of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.
- "calculate_avg_power" is (unnecessarily) not a standard attribute and
   therefore unacceptable. Its value (on top of the already averaged power
   attribute) seems questionable. I would understand an attempt to report
   the energy, but I fail to understand the value in reporting yet another
   power average - even more so one that is not well defined in terms of
   number of samples used to determine the average.

Guenter


