Return-Path: <linux-kernel+bounces-225347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49090912F66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B031F2233C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2817C214;
	Fri, 21 Jun 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/4Y2Etj"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A4770FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004910; cv=none; b=BfwHtF7tC+rfdAOUSKyP3nd1t0d90z04ni176Gkjwi/qZpYy1FMtL8MDhUmHdxJx5CZvjrixgn8QyHMXMaf4flRr4p+LXMtIj/jx8Xg66mIoCy1t1leBIyL1iO5xhPavBo+0tToLy7ors9ERW+3u0JeAoDsVmQmNbXEyF9Rg6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004910; c=relaxed/simple;
	bh=6OwU3g5/7PEoCA8T5u53wxNdNZACBR3qvz1VZFAE+r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdlUn15SzcpNlw66aGO81ra8msDzKQVekO5zingWJU327P/MpnM4lS7wfKyJTxmUlvRtxUoW6fj0iIAK5CqoUe6in745umLzA16k76FG5TadB4/xGzaeU7Lf7J2Ss2cQIUEjA9Pig6qWvjnvF2jIy7vk41T5Pyli0SvlCxAdXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/4Y2Etj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36532d177a0so1425807f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719004907; x=1719609707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwpodCTQAZQJVX6OzPylhaU++onJn6Fu1+C4vSG5mPw=;
        b=S/4Y2Etj8LP7qEGj2ZnU44xkq5yuAPZAtz2UyKj/pm2pVkVxYUjFqcPvQxyRo14OkQ
         XTSMZpxfhAIKd78psfHwP0NWsYnq+6vzu29h1p527YUpjsUY2R9Zq2yqDIby4BdppFbg
         WXulQiaFDN8ORVFqorllNI0CfG/xKU9nFJ8bR/ibKobl4wBV3YaABUQeB6x+aLiHwkOS
         Qybrp9b9u2yjKAz/mcbm/0jD0iSsVnQu5IX8v/CchUVsQq51L6guKo6Oy1Cbgh5FguEa
         R1sXQ6x2hIppAudJrUWi0kd5kYF2RMNxIm+kPGT5Qqr79EBlHyD0Zk1o7utCD53m0CsN
         8M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004907; x=1719609707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwpodCTQAZQJVX6OzPylhaU++onJn6Fu1+C4vSG5mPw=;
        b=FdIbGYzvlOYj3R+4ydXo1KxY8bpASNaUeP8r9CkmpbZpjb+GeGsyC43YUkqP11zE22
         gViA/4HrnqAH2YcyDPSfwkMaZoZwL2nxFqxTTfD2hQ9x+rhXYIWTBxi59VlIFfIKhCgw
         YgzO8tmylYnJ0u+DjyKVfkhOtOxcRJ9V3IDe0V8qXusQ8KgSynUOj2WxNkoK/CAZXbf3
         Gabwh20jhANbHggRzp4H7GuHxKapR2XdsrT9ncpMMykWFoDFiXd6pLlffeOWQxt59n3a
         lBl8cj//VZVej20Bm29xn0S6y4cxrWj0LxAQuo1cV6T63aEwkHmmnt/Vj6y2vjJRoTaB
         Kx7w==
X-Forwarded-Encrypted: i=1; AJvYcCWUBD9l8017fxzNzbB/E5C0nWQPDKNU9E2oaGWHZLAe7/bLaBd0dOH+p9CX1X4MjC0NmUsQj7MGwvwz5+gF1lKnB7pr6r+fPC8vRaYb
X-Gm-Message-State: AOJu0YwIqY8JtNPtNqWQ8AGdW+lbK1v5xL8gGsBqlTLihpf836ee5IfG
	eCAU3ufGLc/L/rWSGZLFvvys0VWIXosQoSJdwjd7RPp2vyERADzDbCW572D5+U4=
X-Google-Smtp-Source: AGHT+IEzQ4rIrOnwizgWJWmaBFT5pkt5oc9TgW9owS7sv9mlyk1FyS0hLQMvtFnAXXdLtrJb0u6rEA==
X-Received: by 2002:adf:f209:0:b0:366:dd50:8ccd with SMTP id ffacd0b85a97d-366dd508d96mr1273664f8f.38.1719004907144;
        Fri, 21 Jun 2024 14:21:47 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-366383f6d16sm2793209f8f.3.2024.06.21.14.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:21:46 -0700 (PDT)
Message-ID: <91d242ae-ece2-4665-ac1e-54694152da70@linaro.org>
Date: Fri, 21 Jun 2024 22:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on
 read
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Joy Chakraborty <joychakr@google.com>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240613120750.1455209-1-joychakr@google.com>
 <171895100442.14088.18136838489262595773.b4-ty@linaro.org>
 <202406211503118dfe2df1@mail.local>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <202406211503118dfe2df1@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/06/2024 16:03, Alexandre Belloni wrote:
> On 21/06/2024 07:23:24+0100, Srinivas Kandagatla wrote:
>>
>> On Thu, 13 Jun 2024 12:07:50 +0000, Joy Chakraborty wrote:
>>> Read callbacks registered with nvmem core expect 0 to be returned on
>>> success and a negative value to be returned on failure.
>>>
>>> abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
>>> returns the number of bytes read on success as per its api description,
>>> this return value is handled as an error and returned to nvmem even on
>>> success.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] rtc: abx80x: Fix return value of nvmem callback on read
>>        commit: 126b2b4ec0f471d46117ca31b99cd76b1eee48d8
>>
> 
> Please drop it from your tree, I'm going to handle the rtc related
> patches...
> 

Sure I will drop it.

--srini
>> Best regards,
>> -- 
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
> 

