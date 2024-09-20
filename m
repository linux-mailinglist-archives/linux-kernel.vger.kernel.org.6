Return-Path: <linux-kernel+bounces-334524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9697D852
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF10A285AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D8D17E46E;
	Fri, 20 Sep 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfO3RnVz"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78017E00E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849501; cv=none; b=rgljlKHMzQpncCujA6z+Btpu9jSVURSU1HjQy+VPUUAKnIVeeStDBf+PzbptUhM1ebVywcpZGneBt1WXuOWHI1TGwL2gaUl8ItmSIXybCsFx3/9yu+EQqXibb21n3JbXejKG0yehPgeVg+rAYdGvrUawmzJcIqjBOV2bhV+JCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849501; c=relaxed/simple;
	bh=Lo57eX2x9k6yvg2bMfey2e8hVztipaeaZ3SiF94jyDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucD6kd8gDA08wo15V/+hRXrRS1y/RQ2SpRsPxbDvBETkAgpplR/LN6SFtqJIgbO4m1nDZG1OqGGYpJJ+2KiEkyDq31/mTyuYQiu05CV4rmP98qUn44Ae4rO2DVuCs3tz4KCc9PUTOqXocP45FkexwgUno1E415IMCp4l0MUOj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfO3RnVz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a0cbc08b38so3426205ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726849498; x=1727454298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETzjk99HfOyExYviklOPPMMoaRaeOvjJU32oW0oE2qo=;
        b=bfO3RnVznDtz0ni9kvewetWodGbOSrjXOLLlnJPxKYj3FQ4O7yOXVN+S0gVwR2yVRg
         cAg+gu0JaQulpamAdwqjPoGqn2bRfWHLgJl4t+c69HHl0sW77Bh/8kDx02hUVYrrGRHI
         8iLsrgZOmrP6DICh8O48eOKVYBkt4cVB/kyQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849498; x=1727454298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETzjk99HfOyExYviklOPPMMoaRaeOvjJU32oW0oE2qo=;
        b=gOxeS722FU3qSgoLhO89DnpzweS1Y+xAGYN556TBaQJVeXmMe2Y9xOvkDUXJgxChE9
         mekwpWzX73gFeoFpruMm5G+Hbf5zSQdZ3xaxas8FuVJnbT1gEv68Z+ww/KEMb7WdC9aY
         XrQbnpXXQ+Vgniuf8V3GoP4aGkqckW/g7q5DbJE1dFSjSzmdQhgJBD68vovktg5Ov5KD
         4CtIkGaU9jKnRVZ9T+desZmrohs3cQllwF5nYLre4kqjsIZploFQR1MmiMnczkx1NTzA
         TBNaEvTOQGaiLySbIe+JhEFTfg0ilZBjLmZHlog53ZJ3qYSqoO1m7hqihu9GbK4/QdkX
         BKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPKCz1p5ualFdp8Emi6Gdu4bzew1c4O5JfKyiT1NlMPJc9tXplMyDMKEVjilKj4F4n17fw7xqeSg9glpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgQAVpV2P1jrX3b8ssposWZ0SEHQWqNmDKZu4pWMlZmvdWXfO
	q1L6sSmx/iH4SfPbpAjvk1uiFbMKAzLmv18xKSL8evjfgYNhQt8lCgHiSWd+TXw=
X-Google-Smtp-Source: AGHT+IE2uigUmVj+vxJgtES2OgC740iUyQL252JUzMrivDAeT+DIiYvxOM1axog1ETSGFzr32I8+EQ==
X-Received: by 2002:a05:6e02:1e03:b0:39f:6f8c:45f3 with SMTP id e9e14a558f8ab-3a0c8d25d74mr32825515ab.16.1726849497965;
        Fri, 20 Sep 2024 09:24:57 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e1b608sm42277985ab.38.2024.09.20.09.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 09:24:57 -0700 (PDT)
Message-ID: <62c6883c-19ca-4ccb-ae78-dd3e665fca08@linuxfoundation.org>
Date: Fri, 20 Sep 2024 10:24:56 -0600
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
 <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <087c4ef0-5718-48d3-9367-1d79a255fab1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 09:27, Shuah Khan wrote:
> On 9/19/24 15:49, Abdul Rahim wrote:
>> On Thu, Sep 19, 2024 at 09:40:34AM GMT, Shuah Khan wrote:
>>> On 9/15/24 17:41, Abdul Rahim wrote:
>>>> When ALSA is not installed on the users system, the error:
>>>>
>>>> "Package alsa was not found in the pkg-config search path.
>>>> Perhaps you should add the directory containing `alsa.pc'
>>>> to the PKG_CONFIG_PATH environment variable
>>>> Package 'alsa', required by 'virtual:world', not found"
>>>>
>>>
>>> extra line?
>>>
>>>> is printed 3 times, which generates unnecessary noise.
>>>> Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
>>>> assignment, so the message is printed only once.
>>>
>>> I would say this message is alerting the user that the package is missing.
>>> Why would you want to delete it?
>>>
>>>>
>>>> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
>>>> ---
>>>>    tools/testing/selftests/alsa/Makefile | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
>>>> index 25be68025290..cd022fc869fb 100644
>>>> --- a/tools/testing/selftests/alsa/Makefile
>>>> +++ b/tools/testing/selftests/alsa/Makefile
>>>> @@ -2,7 +2,7 @@
>>>>    #
>>>>    CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
>>>> -LDLIBS += $(shell pkg-config --libs alsa)
>>>> +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
>>>>    ifeq ($(LDLIBS),)
>>>>    LDLIBS += -lasound
>>>>    endif
>>>
>>>
>>> thanks,
>>> -- Shuah
>>>
>>
>> This can also be handled like this:
>> ---
>> CHECK := $(shell pkg-config --exists alsa; echo $?)
>> ifneq ($(CHECK),0)
>> $(error Package alsa not found! Add directory containing alsa.pc in PKG_CONFIG_PATH)
>> endif
>> ---
>>
> 
> This is a better solution than suppressing errors.
> 

One more thing. "make kselftest-all" has to continue even if this error causes alsa
compile to fail.

thanks,
-- Shuah


