Return-Path: <linux-kernel+bounces-366110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5BE99F101
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0C21C22438
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E11B3921;
	Tue, 15 Oct 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODxZ3Ayk"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7611B2181
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005824; cv=none; b=iBfdUlM3hnouaCjPg+lbeof6Loln5fAfEaV4/p+KD5KbpP+UIK+WcDEweYCGLtDJ5VLRqjq2rwMIHCV8mQLUk6SRK33W74E2/rpWUfHaSsA6ql3cIMxneOXaQtWYANUr2Zc0xGf8ybkCBeRiN7ltCqm5yCmTOg9/ExI29teF9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005824; c=relaxed/simple;
	bh=ibOMGyy9MOm2vdzyRR7ujrHzgVMe6RdwJhby4PeTS5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCq5LabxRYPr4kXR1fi5SA8ajsr8aak3nEwE0sQ9btILUtnJk4MC1+/pfNexVqtE2KS870JA/Rfl4iZk1ZIG2QHO0HR4YqoFUwJgO0hL5MTCMYXHtstl/ubu2RHvLHcWF5sPqUIcBZqnQQk8jwajO92UD11M4JhEmEboFrab2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODxZ3Ayk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b8964134so11127245ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729005822; x=1729610622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SG9oZeCQixkQj/EuBdFW7/W28zFcKeJtf6zC5ywQazQ=;
        b=ODxZ3Aykp08FkaNIp6FQq0r1Ec+al/BfnfFxAGkUjCFRAJOh/i/AYRkXM6+vNDFn4P
         Elackh5TQpAGH8UKPAdU4WVoMhU0aplxfuzYxVbHAZ9Zf6sWCAxK046s2VPpnWCscHZ4
         spoQKlT68hRah6wWAiFhvIGBbLsMpQZponEus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005822; x=1729610622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SG9oZeCQixkQj/EuBdFW7/W28zFcKeJtf6zC5ywQazQ=;
        b=J2Oer+wA6MfIcAl/OwseeLMEqS9OrzIIkdXzNTAkDbXyjN31hI4hb5xhy6/LLZfo+Z
         6qaU9EBMaqnE+L8NczO22KMAa0Y+ZmlSqDuTXZhWU611RPJMLOc8JZoTEXCypBtMCWBE
         yHvpXT4B0SdKox+tPlDwBiGBayURzfFB37X065QDO6JInUX6D62pCubxj//+iqanjXkj
         9adEz1haAoyxMYwprvn+yaLoi+q7NrT4lckOuWIJSqPhfTBxpG9PW5qne+WVxiQAb5FD
         DazSogeRhnDx69WEXpXzTOjViKxwzEKdbA13q5P82d2zlvQt1tfA8pMqwoY8UtpXP02I
         +P+Q==
X-Gm-Message-State: AOJu0YzEXJ9s7C3OBd6f/fd6vf0zVkttD8w1toHShsg/mwzWWNim47zK
	TgBpHNQHGzFsWlaBML61cTeQup7mURLSn+4JnSQqJu5/GPLrASwqyZQYONIuJdRuSijVkHJvZ/k
	a
X-Google-Smtp-Source: AGHT+IF33hXmGihjl1zU+NN6M6a/vLnjZ7HgtQDtxpt7THx0iw4xm/mXlY9UgwvQ02qUwnubsqirpg==
X-Received: by 2002:a05:6e02:198b:b0:3a0:9c20:8070 with SMTP id e9e14a558f8ab-3a3bcdf03f4mr83358245ab.20.1729005821916;
        Tue, 15 Oct 2024 08:23:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d715e488sm3569555ab.83.2024.10.15.08.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:23:41 -0700 (PDT)
Message-ID: <b82a25f8-e7a9-4a42-9a16-c2cda99feecd@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:23:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
 <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
 <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
 <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
 <714162ff-a2f8-4fc6-91af-0ecd6376bc7f@163.com>
 <0f79692e-ed68-462d-8ec7-955219116282@linuxfoundation.org>
 <5c4272c4-3f9c-4ce8-ba73-50b5f16ab605@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5c4272c4-3f9c-4ce8-ba73-50b5f16ab605@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 03:00, zhouyuhang wrote:
> 

[snip] for clarity.

>>>>>> Why is this necessary? This is defined in linux/capability.h.
> 
> Sorry for not noticing this before.
> This is to be compatible with some older versions of linux/capability.h that do not define this macro.
> 
>>>>>>
>>>>>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>>>>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>>>>>
>>>>>> In general prototypes such as these should be defined in header
>>>>>> file. Why are we defining these here?
>>>>>>
>>>>>> These are defined in sys/capability.h
>>>>>>
>>>>>> I don't understand this change. You are removing sys/capability.h
>>>>>> which requires you to add these defines here. This doesn't
>>>>>> sound like a correct solution to me.
>>>>>>
>>>>>
>>>>> I tested it on my machine without libcap-dev installed, the /usr/include/linux/capability.h
>>>>>
>>>>> is on this machine by default. Successfully compiled using #include <linux/capability.h>
>>>>>
>>>>> but not with #include <sys/capability.h>. This patch removes libcap library dependencies.
>>>>>
>>>>> And we don't use any part of sys/capability.h other than these two syscalls. So I think that's why it's necessary.
>>>>
>>>> You are changing the code to not include sys/capability.h
>>>> What happens if sys/capability.h along with linux/capability.h
>>>>
>>>> Do you see problems?
>>>>


>>>
>>> I'm sorry, maybe I wasn't clear enough.
>>> When we install the libcap library it will have the following output:
>>>
>>> test@test:~/work/libcap$ sudo make install | grep capability
>>> install -m 0644 include/sys/capability.h /usr/include/sys
>>> install -m 0644 include/sys/capability.h /usr/include/sys
>>> /usr/share/man/man5 capability.conf.5 \
>>>
>>> It installs sys/capability.h in the correct location, but does not
>>>
>>> install linux/capability.h, so sys/capability.h is bound to the libcap library
>>
>> It won't install inux/capability.h unless you run "make headers" in
>> the kernel repo.
>>
>>>
>>> and they will either exist or disappear together. Now I want to remove
>>>
>>> the dependency of the test on libcap library so I changed the code that it
>>>
>>> does not contain sys/capability.h but instead linux/capability.h,
>>>
>>> so that the test can compile successfully without libcap being installed,
>>>
>>> these two syscalls are not declared in linux/capability.h(It is sufficient for test use except for these two syscalls)
>>>
>>> so we need to declare them here. I think that's why the commit 663af70aabb7
>>>
>>> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") I refered to
>>>
>>> does the same thing. As for your question "What happens if sys/capability.h along
>>>
>>> with linux/capability.h", I haven't found the problem yet, I sincerely hope you can
>>>
>>> help me improve this code. Thank you very much.
>>
>> Try this:
>>
>> Run make headers in the kernel repo.
>> Build without making any changes.
>> Then add you changes and add linux/capability.h to include files
>>
>> Tell me what happens.

Try the above first.

>>
>> The change you are making isn't correct. Because you don't want to
>> define system calls locally in your source file.
>>
> 
> Thanks, I see.
> Maybe I should move them to a new header file and resend a patch.

No. Please see above. I would rather not see these defined at all
locally.

thanks,
-- Shuah

