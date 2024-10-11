Return-Path: <linux-kernel+bounces-361284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B399A62C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB641F255D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42525218D91;
	Fri, 11 Oct 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyOQgagd"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE7184
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656468; cv=none; b=HFmZXDZ7aIpOq/G5EQ/yrXl7kiYfAofQpvnek28U0gOatAQi+B5drauH4RvzQ9ffudrkKi8qnEeI8nQBAUdEdCQ/kpT3e+ZH9ZDxsLCubc2Hl0PW5A9yAi5c6BAaFG1Pk6P5ta3uNDZeB6J9ZqKiJqRFVim4L+MOIce624DmlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656468; c=relaxed/simple;
	bh=TYE5vXTXT7Cm/vgRYyKhBt1I+Zc/7FpaevYm7u7Hc7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1fW5iptQGs5peXXQvI08BFwDZ/KkBJRF0nkkE6igOsEp67aIEljMvzc3WCTZ1CgG96EI76h69jL+YlmYlIQQgABeJDO9HHcBBtmVu9ny8yiRasmQzfsTZBNYj8VTpaHGMcm3ruDrWLQL815rSvfqOleD/YJzjAxXQ0YO2+WZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyOQgagd; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83493f2dda4so104918739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728656466; x=1729261266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2PJdME7gEpgZm4c7VOyfyN+e8wtfK6RNIHEqseNqOQ=;
        b=PyOQgagdlbt6L5IvYedNskr+0xKmBHYjRW8qsFkj9TDVyFUNsY4oMMc+NP4+YI+R4+
         7tZSYd0RdJfin3huBipBWVmT5BD/0N23T4Pd9yHNvZ1mT5Q1wfmsKHplvEu1TjqwzEsw
         SzGW+FTESdnO1+9dFSGYSZ2MwY2vslOLFh2kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656466; x=1729261266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2PJdME7gEpgZm4c7VOyfyN+e8wtfK6RNIHEqseNqOQ=;
        b=RJLuFurMW3U3Bt4hKujGAQxew0AvZAePf/bH4V7r3PdWsctTJqGRH07HHFm8FH8IWl
         ulJd745IJs/GixvRtuSwYR10lgVuoj+EAns4JDo1ZH55+Gwva/BQ8EWvkS4G3iE9HVHM
         8ZOE92y/m4KKM95C2a39sLpVDTrv925JEL+kragd2KmkDOcTYO/R8GR7uek5prUE1Q2W
         mFUMS7EdwK22wXyJ4108hRAphieXuo4MQRMaRZLDLMlfuWKI+GIDNrpYw1yCCTFnZLr+
         pgsq+sXHHNpcLj6ydgjLfdY0dQiuQrTFb+SEIon/3sHibZQzXVWhbkV2Bx1UlqkCLlNO
         TDuA==
X-Gm-Message-State: AOJu0YwO92lBRNL0VNGG4b6hElDmnpeBzohqC6e4ZYBxnVxscUA4qTh3
	htvaYQ+zLd7hdFLcqqmeyaWqLh1S40UehymQyjpj8MjOvu1bWzPPWznT5CE96Qk=
X-Google-Smtp-Source: AGHT+IEwImqOyQAmT6fExrU/UEB3L6kghbfDP6gdwjhkhbR9nDrNGWSRu/G2qy6foQOPdk8aNrCEHA==
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:ce43:fb62 with SMTP id e9e14a558f8ab-3a3a71ddab2mr42676805ab.11.1728656465812;
        Fri, 11 Oct 2024 07:21:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b0e90sm652358173.15.2024.10.11.07.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:21:05 -0700 (PDT)
Message-ID: <b2e02494-0f22-476e-bb79-f3a133b7fa07@linuxfoundation.org>
Date: Fri, 11 Oct 2024 08:21:04 -0600
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
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
 <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
 <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a2ab9671-5095-47bf-82cf-0e167320772f@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 00:59, zhouyuhang wrote:
> 
> On 2024/10/10 23:50, Shuah Khan wrote:
>> On 10/10/24 06:16, zhouyuhang wrote:
>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>
>>> The libcap commit aca076443591 ("Make cap_t operations thread safe.") added a
>>> __u8 mutex at the beginning of the struct _cap_struct,it changes the offset of
>>> the members in the structure that breaks the assumption made in the "struct libcap"
>>> definition in clone3_cap_checkpoint_restore.c.So use the capget and capset syscall
>>> directly and remove the libcap library dependency like the commit 663af70aabb7
>>> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") does.
>>>
>>
>> NIT: grammar and comma spacing. Please fix those for readability.
>> e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
>> Fix others as well.
>>
> 
> Thanks, I'll fix it in V2
> 
> 
>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>> ---
>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
>>>   2 files changed, 28 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
>>> index 84832c369a2e..59d26e8da8d2 100644
>>> --- a/tools/testing/selftests/clone3/Makefile
>>> +++ b/tools/testing/selftests/clone3/Makefile
>>> @@ -1,6 +1,5 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>>> -LDLIBS += -lcap
>>>     TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>>>       clone3_cap_checkpoint_restore
>>> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> index 3c196fa86c99..111912e2aead 100644
>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> @@ -15,7 +15,7 @@
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <stdbool.h>
>>> -#include <sys/capability.h>
>>> +#include <linux/capability.h>
>>>   #include <sys/prctl.h>
>>>   #include <sys/syscall.h>
>>>   #include <sys/types.h>
>>> @@ -27,6 +27,13 @@
>>>   #include "../kselftest_harness.h"
>>>   #include "clone3_selftests.h"
>>>   +#ifndef CAP_CHECKPOINT_RESTORE
>>> +#define CAP_CHECKPOINT_RESTORE 40
>>> +#endif
>>> +
>>
>> Why is this necessary? This is defined in linux/capability.h.
>>
>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>
>> In general prototypes such as these should be defined in header
>> file. Why are we defining these here?
>>
>> These are defined in sys/capability.h
>>
>> I don't understand this change. You are removing sys/capability.h
>> which requires you to add these defines here. This doesn't
>> sound like a correct solution to me.
>>
> 
> I tested it on my machine without libcap-dev installed, the /usr/include/linux/capability.h
> 
> is on this machine by default. Successfully compiled using #include <linux/capability.h>
> 
> but not with #include <sys/capability.h>. This patch removes libcap library dependencies.
> 
> And we don't use any part of sys/capability.h other than these two syscalls. So I think that's why it's necessary.

You are changing the code to not include sys/capability.h
What happens if sys/capability.h along with linux/capability.h

Do you see problems?

thanks,
-- Shuah

