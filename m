Return-Path: <linux-kernel+bounces-368879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F609A15FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DE1C21440
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494D1D47A6;
	Wed, 16 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUF3DFeE"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47D1D45F3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120224; cv=none; b=JTLZs08OnYJR1sZniFPCkLhybwZkTIM4V2On6+ALYmmlL4mWeVS3VnApfLFJlj67/SE2pEdhzUgAzJui+V6v/fiVSSeAxE2V2/R3VmQZ+BL1yPByIm9GSdUrXmg07H0YaXEdPd7SZu4qEwEBO6gT/MJFCnHpb/u2z6KZx//z+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120224; c=relaxed/simple;
	bh=CHvTjwAGzBeYZYp+VdXxHeL0nXva4h7kq/WfIdQA1kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMe9CXh6VUM0M9F5kl6AUvsFI6Z4htpbeFgeA7v3TWGtFILXzSxQm4sty5NI29VdHMOzXdsOTG04KbBgx0jxrWRkvy+JMa5itWpomdglZuAYt0+RBnAnuDs146jvpWK/zXUzuTOgwEeVHB5CFosCf+JEz2EWvNPh3QAYICKd4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QUF3DFeE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a394418442so1471775ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729120221; x=1729725021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXH/z1N1+QwsHO3qNzXKX0fwZbKnd4sF3AGH3jjCTok=;
        b=QUF3DFeEsLrUmLxTcc3TySUUCILWNlIdFkML0F6Qvt9HggiOSC1tZmtKhJ70W5kG+Q
         JRaqFhsFo/fGmFyPFz27xSYCXm66kMIgCGLS1rw1IsF43bE0Qd8p2Sfod4R36E9ZpqjC
         mF0wvZb/p2JB1j9Nh44PC7FflXGf9mwD0NGOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729120221; x=1729725021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXH/z1N1+QwsHO3qNzXKX0fwZbKnd4sF3AGH3jjCTok=;
        b=odvxt5Hp9ViiQcqANIl0ztfiiK8tzU0DEIl3jU5iHFsIIhTuZB1VYeGRWrp++sbtWv
         ZQ8d2tPH9eTYHWdyNjMgQ8HEWSR9+Q3KYh33dEBLE+gy5j1jCfeCU8uiEEViYLqvuZ1y
         /zzJB+fH4DWPcl0OG2AJ0GQtZga4BW+g6asOI8HiviJi1KOeniYJiC7wNMKOL1s3Pe7+
         yPuQ0rPMzMBBPz9drtuKB+89zfmNnwXeH8pivH0wD7Yc31O6JfBgsrMNpB3iOYIKlI6S
         dt1Y1333z47nF7XPycbXAdhyKy6D0yu083/DR96BeoQIMNpiLIcUyJTtz3iGfNA0ouds
         XdCg==
X-Gm-Message-State: AOJu0YxW5GRHv1AE28/1NZrR6FIzrifkEvGxi9khqNQnO/1NLHJBNfse
	ceJ1A5Fk5vtyFXZgk/MdalBvb418uVhzEHdue8Z2uiVJR9vskV/Szsmc+kXGXwg=
X-Google-Smtp-Source: AGHT+IFo+tAT1cJMODUyUUhycLVaulNah3VD4LoyM3xQaO53vA15Gr73EZfZkmdRqDAxzRRfVQ8ZCw==
X-Received: by 2002:a05:6e02:1748:b0:3a2:7651:9867 with SMTP id e9e14a558f8ab-3a3bcdc637amr126855755ab.13.1729120221383;
        Wed, 16 Oct 2024 16:10:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc4247esm1092329173.126.2024.10.16.16.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 16:10:20 -0700 (PDT)
Message-ID: <a0944037-e90a-4884-b12f-284b373a0d63@linuxfoundation.org>
Date: Wed, 16 Oct 2024 17:10:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015105955.126994-1-zhouyuhang1010@163.com>
 <806bee31-d740-49c9-abe0-06820cfa7395@linuxfoundation.org>
 <dea6d512-64c7-4ec1-a99d-6796e434c9a4@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dea6d512-64c7-4ec1-a99d-6796e434c9a4@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 03:18, zhouyuhang wrote:
> 
> 
> 在 2024/10/15 23:31, Shuah Khan 写道:
>> On 10/15/24 04:59, zhouyuhang wrote:
>>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>>
>>> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
>>> added a __u8 mutex at the beginning of the struct _cap_struct, it changes
>>> the offset of the members in the structure that breaks the assumption
>>> made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
>>> This will make the test fail. So use the capget and capset syscall
>>> directly and remove the libcap library dependency like the
>>> commit 663af70aabb7 ("bpf: selftests: Add helpers to directly use
>>> the capget and capset syscall") does.
>>>
>>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>>> ---
>>>   tools/testing/selftests/clone3/Makefile       |  1 -
>>>   .../clone3/clone3_cap_checkpoint_restore.c    | 53 ++++++++-----------
>>>   .../selftests/clone3/clone3_cap_helpers.h     | 23 ++++++++
>>>   3 files changed, 44 insertions(+), 33 deletions(-)
>>>   create mode 100644 tools/testing/selftests/clone3/clone3_cap_helpers.h
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
>>> index 3c196fa86c99..242088eeec88 100644
>>> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
>>> @@ -15,7 +15,6 @@
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <stdbool.h>
>>> -#include <sys/capability.h>
>>>   #include <sys/prctl.h>
>>>   #include <sys/syscall.h>
>>>   #include <sys/types.h>
>>> @@ -26,6 +25,7 @@
>>>     #include "../kselftest_harness.h"
>>>   #include "clone3_selftests.h"
>>> +#include "clone3_cap_helpers.h"
>>>     static void child_exit(int ret)
>>>   {
>>> @@ -87,47 +87,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
>>>       return ret;
>>>   }
>>>   -struct libcap {
>>> -    struct __user_cap_header_struct hdr;
>>> -    struct __user_cap_data_struct data[2];
>>> -};
>>> -
>>>   static int set_capability(void)
>>>   {
>>> -    cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
>>> -    struct libcap *cap;
>>> -    int ret = -1;
>>> -    cap_t caps;
>>> -
>>> -    caps = cap_get_proc();
>>> -    if (!caps) {
>>> -        perror("cap_get_proc");
>>> +    struct __user_cap_data_struct data[2];
>>> +    struct __user_cap_header_struct hdr = {
>>> +        .version = _LINUX_CAPABILITY_VERSION_3,
>>> +    };
>>> +    __u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
>>> +    __u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
>>> +    int ret;
>>> +
>>> +    ret = capget(&hdr, data);
>>> +    if (ret) {
>>> +        perror("capget");
>>>           return -1;
>>>       }
>>>         /* Drop all capabilities */
>>> -    if (cap_clear(caps)) {
>>> -        perror("cap_clear");
>>> -        goto out;
>>> -    }
>>> +    memset(&data, 0, sizeof(data));
>>>   -    cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
>>> -    cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
>>> +    data[0].effective |= cap0;
>>> +    data[0].permitted |= cap0;
>>>   -    cap = (struct libcap *) caps;
>>> +    data[1].effective |= cap1;
>>> +    data[1].permitted |= cap1;
>>>   -    /* 40 -> CAP_CHECKPOINT_RESTORE */
>>> -    cap->data[1].effective |= 1 << (40 - 32);
>>> -    cap->data[1].permitted |= 1 << (40 - 32);
>>> -
>>> -    if (cap_set_proc(caps)) {
>>> -        perror("cap_set_proc");
>>> -        goto out;
>>> +    ret = capset(&hdr, data);
>>> +    if (ret) {
>>> +        perror("capset");
>>> +        return -1;
>>>       }
>>> -    ret = 0;
>>> -out:
>>> -    if (cap_free(caps))
>>> -        perror("cap_free");
>>>       return ret;
>>>   }
>>>   diff --git a/tools/testing/selftests/clone3/clone3_cap_helpers.h b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>>> new file mode 100644
>>> index 000000000000..3fa59ef68fb8
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/clone3/clone3_cap_helpers.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef __CLONE3_CAP_HELPERS_H
>>> +#define __CLONE3_CAP_HELPERS_H
>>> +
>>> +#include <linux/capability.h>
>>> +
>>> +/*
>>> + * Compatible with older version
>>> + * header file without defined
>>> + * CAP_CHECKPOINT_RESTORE.
>>> + */
>>> +#ifndef CAP_CHECKPOINT_RESTORE
>>> +#define CAP_CHECKPOINT_RESTORE 40
>>> +#endif
>>> +
>>> +/*
>>> + * Removed the libcap library dependency.
>>> + * So declare them here directly.
>>> + */
>>> +int capget(cap_user_header_t header, cap_user_data_t data);
>>> +int capset(cap_user_header_t header, const cap_user_data_t data);
>>
>> Sorry you haven't addressed my comments on your v1 yet.
>>
>> I repeat that this is not the right direction to define system
>> calls locally.
>>
> 
> I got it. I am willing to modify the code so that syscalls are not defined in local files,
> but this would require including sys/capability.h which would not remove the
> dependency on the libcap library. So, should we directly use syscalls or use the
> libcap library function in the "set_capability" function, or do you have a better way.
> I'd like to refer to your advice.
> 
>> Try this:
>>
>> Run make headers in the kernel repo.
>> Build without making any changes.
>> Then add you changes and add linux/capability.h to include files
>>
>> Tell me what happens.
>>
>> thanks,
>> -- Shuah
> 
> I tried this, here are my steps.
> 
> Firstly, I ran 'make headers' in the kernel repo and it was successful.
> Then I wasn't quite sure which path you were referring to as' build ',

Sorry if what I said wasn't clear:

- This test depends on libcap and yes you will have to install it.
- Run ake headers in the kernel repo.
- Build the test without your patch (changes)
- If you don't have libcap, the test build will fail
- Install libcap
- Build and run.

Looks like you have done the above. Now:

- Add your patch without the local capget() and capset()
   and without removing

> so I compiled and installed libcap, and also compiled test, all of which were successful.

Why do you need to compile libcap? Is it because this latest
change isn't available to install from the distro you are using?

> Afterwards, I applied my patch and the test was successfully built and running.
> I guess what you're trying to express may be that these system calls have already
> been defined in sys/capability, and those defined in the local file are duplicated with it.

Correct. You don't need the local defines and in fact you should not
define them locally.

> So I included sys/capability.h and linux/capability.h and defined the system calls in the test,
> but there were no errors.

Please don't define system calls locally. What happens if you don't?

thanks,
-- Shuah

