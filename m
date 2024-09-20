Return-Path: <linux-kernel+bounces-334449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FF97D76F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FACA1F2517C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772E17C235;
	Fri, 20 Sep 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtG2y6+t"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF09F4FA
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846029; cv=none; b=jxGhmGEEr8Fv1wPrw00PmD8z+Ozd+RJt0DtOpimTDvbLsHLdIRcfa5LwiG7njrr7Ko7pY/YGNRoMpXELYjXy4mPPtaKAsSMrQUvIJKacDJMW9QO+DUsRYTRlcXIiEGr7e3mvXYBTElED4k/cxSSQOhvx6gT7yRCaf6uNuixxU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846029; c=relaxed/simple;
	bh=xz0x9175WZBvHTtcLhiapEi3wXQUgGnXMz1S0gzyDIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe9gm9iw7Q2IudSckOk5C/ymWtx4Oa3nBOR+5kKnMwdq4wuV7ZAKgc1zbp71QtV6jhKEA5Mi5xOkvYyiETOY25kEiRVXM0/CtFKYgisEjRf9eZAT5vYPnJJFVwerjK7hGE+hsR1dThALPnRBMjGuJD2o13Equh4hOQklNWt0sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtG2y6+t; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd872755dso96386439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726846025; x=1727450825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQqtLqg7w2nloL0eri0bb/8RhGQn9bvBMsHqsJUuOcU=;
        b=gtG2y6+tFpHN7RFjNfcfzOVeVjxdRAlWhM+ez8pz3fr/WOyQjesRG+t2liks3TLrbC
         jsmLPDpHc1e+QD1n6QfyVRF9gaPiY4O15ldct0pCmzyG2E02V2Vq2x6SwhLCaEv/3fIh
         4EZGTH84744foic55+3mLlmkUn7zQDkdhMvM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846025; x=1727450825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqtLqg7w2nloL0eri0bb/8RhGQn9bvBMsHqsJUuOcU=;
        b=eARQ2FyW4LNNFV5oXlou2zWuPxZ3NPvJwIwaKcpZNpzSSYMB1qoOYVjEJdaBsHWREY
         fvsDfrUTeoqXuG+ojIV/3nNYg4KbYxc8zTXHjNdwPo40YP0U7/TjpsC+CjNk7+/U9cwv
         R6Xqetfuvj6A43Oeri+bi3AkC/jtaKEVcFNkqee5OH7Tw1HVTfUkIAy+ts5MJEWtdIwR
         /FTcNxOupS7Jnv3+XjK0hTy7gJAxCmwfTHF2EQJLbgPGSN8GOvw1BoCTdwJPmWBb8biG
         21/t7b2RK7k7v0gJIaE6ZyqVvhVq+Ge+Zz4SJCJU6/DKO2COrSTXr40m4y35nURoShZP
         6nCA==
X-Forwarded-Encrypted: i=1; AJvYcCVsynC4PWbC8khaxrdlUELMWbp0RD5Kb5LWTBLvJDdgafaUaThi5EOSSvKlFFdFQlaDFzy6Eobs5kxcnlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7K7AyRPqwK3nRF2yGQD+/Orn7jHNkbMJFaEApOZ5T88wMn8h
	ljmpM7dRZfr6RgP+wRCD72TiNb/bSEmcz21u0ivVgI/vYg7anGwnaBx8HecNyzM=
X-Google-Smtp-Source: AGHT+IHnnbUTaat78VyVNLDYZw22fhZWAPFLJavTXG4fNQ9OcHYOZJZIjrH3uBDqYdvOIn4S00vmew==
X-Received: by 2002:a05:6602:2dc9:b0:82d:f4f:f49b with SMTP id ca18e2360f4ac-83209ed375bmr335337939f.16.1726846025576;
        Fri, 20 Sep 2024 08:27:05 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492694a5sm379110639f.11.2024.09.20.08.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:27:04 -0700 (PDT)
Message-ID: <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
Date: Fri, 20 Sep 2024 09:27:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, shuah@kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
 <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
 <vzrosmbs5x5mmnxwubwljjqxo4m4eih35z26cudshpbr3uue7j@k3v65fkr24rz>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <vzrosmbs5x5mmnxwubwljjqxo4m4eih35z26cudshpbr3uue7j@k3v65fkr24rz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 15:49, Abdul Rahim wrote:
> On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
>> On 9/15/24 17:41, Abdul Rahim wrote:
>>> When ALSA is not installed on the users system, the error:
>>>
>>> "Package alsa was not found in the pkg-config search path.
>>> Perhaps you should add the directory containing `alsa.pc'
>>> to the PKG_CONFIG_PATH environment variable
>>> Package 'alsa', required by 'virtual:world', not found"
>>>
>>
>> extra line?
>>
>>> is printed 3 times, which generates unnecessary noise.
>>> Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
>>> assignment, so the message is printed only once.
>>
>> I would say this message is alerting the user that the package is missing.
>> Why would you want to delete it?
>>
>>>
>>> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
>>> ---
>>>    tools/testing/selftests/alsa/Makefile | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
>>> index 25be68025290..cd022fc869fb 100644
>>> --- a/tools/testing/selftests/alsa/Makefile
>>> +++ b/tools/testing/selftests/alsa/Makefile
>>> @@ -2,7 +2,7 @@
>>>    #
>>>    CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
>>> -LDLIBS += $(shell pkg-config --libs alsa)
>>> +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
>>>    ifeq ($(LDLIBS),)
>>>    LDLIBS += -lasound
>>>    endif
>>
>>
>> thanks,
>> -- Shuah
>>
> 
> This can also be handled like this:
> ---
> CHECK := $(shell pkg-config --exists alsa; echo $?)
> ifneq ($(CHECK),0)
> $(error Package alsa not found! Add directory containing alsa.pc in PKG_CONFIG_PATH)
> endif
> ---
> 

This is a better solution than suppressing errors.

thanks,
-- Shuah


