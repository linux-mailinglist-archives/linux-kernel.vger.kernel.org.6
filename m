Return-Path: <linux-kernel+bounces-182763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D218C8F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 05:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA802B21767
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989215C96;
	Sat, 18 May 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzjYhXnF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5A1A2C09;
	Sat, 18 May 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002664; cv=none; b=C8btf1BVUCE+gxK0geSVBtH9soQ078gOj2aOt4OaQKyj2DcrMEZWAIhUqEqWsbeHwMVUbWO9cYWr1avKeg0uZmCZc9PQvGn1WJrmE2Ft63mOV382VwIbijI9SdD3wPhbTBsHehilkMH6zxJUhKWnlRr8T3ZYBrDTp+ix/CwPU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002664; c=relaxed/simple;
	bh=QVAFCgNiSOMq9ybcX9XhjXeNxGnPjWIffURrI1sFuEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OD+s3Hy+t+5UzGXYvgZea9bkdHmEJnPtqS7QerdKioDA9+k6iQAxfPrJ7RAJIQrzlt+xfvzn3uNsJoec47bdG8jqxrI2UMNwnzfTM//KdjqxdpHvjh5lI3EzRp9oDVbWV4E3wHJYj+8CEflARPf5Za6q2zprO+ijfS/zCRmK2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzjYhXnF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eca195a7c8so27644865ad.2;
        Fri, 17 May 2024 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716002662; x=1716607462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y6zcJkIEIHijrvoQJ7XfUTTKO+Oh0qbpF3b1v1a1cbY=;
        b=ZzjYhXnFkPx40t+Prt5eK9+2qxhI9IU18aKS6qQa7C1SPrlB8pamRPCdCWJY/KCVje
         UEfDU8rXAhrcoTFhGXXfpoMyhRtsmWSyM/THcZQsD6BPJXXyBvx3P1gizqtiR9HXBOVs
         fUqNwHVVlGI4uwj0ohKaMZX4YIYnB/3DONzxfZueERyFYtPJTTbTddhrvUmBGRuLIk3L
         1MrmwulAic62P4ngN6g0ASHuh9sI3wSSCri0oTzzh/fl97n8UfrAQIgvX65yEx3S718a
         LvYCimQeoDA6bSpkfe5QPbsTb9RjVRKPONgbT+LO0wc6nv5kFNg92U8yAwjAT7QQY2wt
         dDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716002662; x=1716607462;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6zcJkIEIHijrvoQJ7XfUTTKO+Oh0qbpF3b1v1a1cbY=;
        b=gm5TsyVIWld8UQWpEK45E5HmRl9k6wH7D3mELOuw17UNo3gSED+5N2a0qOybDAuDFl
         6RYR2hb7ac4OtBFRSzczcpu2phKw3GbVDKTuraGoOHhOHVWYvRenI0d/w/YA9p0euCN8
         dJB9A3HHdemTjyN/moG4XSqrStdyfl654/zhipYiwA21OgUvsLr+8KBEhckTrY9ly8r9
         Y23jaHK+3YUgiuPVlfQwWN+vG1gWRKbNoy22tvH3X0/XYLPc57cl9deltZ448WasmwRy
         cyZOV+OPb+u1HVzYvElZQIq6Dy1K9OZoXRNU975u2j6gwF4OWCC5lKXXOH828XzyFiUd
         cpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGvbuJE6BWzfkF9xr7R0EVfEa5jGLr1X7lKVrmsQvDOLnUQ+2zQO4X6fuJtec78J9/Rrkbu3DT6wi+ct+w6haFKa6mYv9SxL4xDZ46nrNYtn8NdeHibLV+hQAEYQaKFUg7DAjspM9+
X-Gm-Message-State: AOJu0YxOfpGizT1e8T4AB0mppAeEDMQwpGFyI2gSm1HE4WotgSUwOiDn
	MtVRIhMz51BP8PLulWb3OVK6wKhx7bQfoX3LCm9PeapvoawnFuSmTUz/MQ==
X-Google-Smtp-Source: AGHT+IGD4lrJtUCOfOQbNnLjWm8Y6D1d7Bv7FoHfyQfVK+EGJxuwKmjqOHoaR3F4VJ5YHp/HigzWXw==
X-Received: by 2002:a17:90a:17a3:b0:2b5:af18:5f8c with SMTP id 98e67ed59e1d1-2b6cc342849mr19310914a91.13.1716002661581;
        Fri, 17 May 2024 20:24:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53c3sm17981567a91.46.2024.05.17.20.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 20:24:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
Date: Fri, 17 May 2024 20:24:19 -0700
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
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
 <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 16:37, Russell King (Oracle) wrote:
> On Fri, May 17, 2024 at 04:34:06PM -0700, Guenter Roeck wrote:
>> On 5/17/24 15:22, Russell King (Oracle) wrote:
>>> On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
>>>>> Report an error when an attempt to register a clkdev entry results in a
>>>>> truncated string so the problem can be easily spotted.
>>>>>
>>>>> Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
>>>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>>>
>>>> With this patch in the mainline kernel, I get
>>>>
>>>> 10000000.clock-controller:corepll: device ID is greater than 24
>>>> sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
>>>> sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
>>>> sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
>>>> ...
>>>> platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>> platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>> platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>> platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>> platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>> platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>
>>>> when trying to boot sifive_u in qemu.
>>>>
>>>> Apparently, "10000000.clock-controller" is too long. Any suggestion on
>>>> how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
>>>> for clk_hw_register_clkdev() is not or no longer a good idea.
>>>> What else should be used instead ?
>>>
>>> It was *never* a good idea. clkdev uses a fixed buffer size of 20
>>> characters including the NUL character, and "10000000.clock-controller"
>>> would have been silently truncated to "10000000.clock-cont", and thus
>>>
>>>                           if (!dev_id || strcmp(p->dev_id, dev_id))
>>>
>>> would never have matched.
>>>
>>> We need to think about (a) whether your use of clk_hw_register_clkdev()
>>> is still appropriate, and (b) whether we need to increase the size of
>>> the strings.
>>>
>>
>> It isn't _my_ use, really. I only run a variety of boot tests with qemu.
>> I expect we'll see reports from others trying to boot the mainline kernel
>> on real sifive_u hardware or other hardware using the same driver or other
>> drivers using dev_name() as dev_id parameter. Coccinelle finds the
>> following callers:
> 
> Using dev_name() is not an issue. It's when dev_name() exceeds 19
> characters that it becomes an issue (and always has been an issue
> due to the truncation.) clk_get(dev, ...) uses dev_name(dev) to match
> against its entry in the table.
> 
> As I say, dev_name() itself is not an issue. The length used for the
> name is.
> 

Maybe, but the existence of best_dev_name() suggests that this has been seen
before and that, as you mentioned, it is not a good idea. Anyway, the patch
below fixes the problem for me. I don't know if it is acceptable / correct,
so it might serve as guidance for others when fixing the problem for real.

Thanks,
Guenter

---
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 25b8e1a80ddc..20cc8f42d9eb 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
                         return r;
                 }

-               r = clk_hw_register_clkdev(&pic->hw, pic->name, dev_name(dev));
+               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");
                 if (r) {
                         dev_warn(dev, "Failed to register clkdev for %s: %d\n",
                                  init.name, r);


