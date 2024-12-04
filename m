Return-Path: <linux-kernel+bounces-430877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE269E36C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA8F283AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFE91A76D0;
	Wed,  4 Dec 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD9RtNbz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1113AA2E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305173; cv=none; b=Xi0knqWwIkeeosGpaPU+3EgipzL2HqA2lB8L9rTAae47E1e9oplaUSxpuJejlOy2RBqg25hXZg5X7wTApE710QXpSdjKPX9HLv7m68MDbX0MQ1KdUW6+s7sfp95Q2drZSWEBc5pHeqlLNfNJ0bjcH/qPP6o8FNsnuvO+bcdkwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305173; c=relaxed/simple;
	bh=4Hq45kjxgVvbXKdPestj9Ng8UcYehgPRo7UiAv4Uv0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT0fVuyd9PkX1RDp0BcnTFx+LkbJedVavkccvQNU3dJc5sQDlC2UkRhodFoK3eXe7os11A2/T+X6cvp7SPh6fPdZvAbIlkEWQKMI6RHkyRpjOuyBOIaKEczmdqY2EuNP2z9L+bCrsBJYQeLFk9CQPW3ci7OFIb7i8abxqoQbC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aD9RtNbz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434aa472617so53850265e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733305170; x=1733909970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jh4ghP2vIJfBNOGnYLYZqwsrjcMAw6lyfxuIkkRvS34=;
        b=aD9RtNbz6Omlj5HymBoZZsxekti4Opz0Vc/0rJYVG9nfBYEcAje6MSzxJb2LfDWuLQ
         qJ2wdANWNMK0TYtSA6OkM3QQWsxw2WngXEgc0TMbvdPQ7GUFqFGjysxlK2xews4DUGen
         mcnrxEy5ip2hL2q/Xbm2noWetEG4WzfVAZRYVRNoAKf8vR29J6fZA8JO1A7LwLg7vrET
         no5qFiJFW/RGqOjVl6yRbBs4b9d8NcKJ+GkF8+3fH8RVhpBgfPp4ReyP0cwYlR+37sVX
         s5Ip6fOO7ehZfM8IRCUWn1TRf6zD+V7Gtjd0uY+e2UBCVwDAe8jSBjOQy6WIR2Hng/MW
         4z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305170; x=1733909970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jh4ghP2vIJfBNOGnYLYZqwsrjcMAw6lyfxuIkkRvS34=;
        b=c2m8MhQls3Qh5he+AvISjswG28FCV8WlV1wA/JEgmXUPmf99IQlAVX1y+W0jbJi+AP
         QyWJ7r4kekMLm8ideYemvJLOctu9K1QYgSqZqBNe47VluO/dLhsxhwSNSIQb6fx2Y9F/
         Nu+yFgWweHvCM6meck3oKzWs7fJNcIORlImigO1TPcvXI2CI/S7zefvdISFbBKLbDv9q
         /oqZsePaZzzZ3R9UxI7M2IFH/syT1DLQy+TalRnMwcsDJPix+tZ+qwN0T3Uyjrhv8l8n
         d217OkeUjQ6THT4NVJVtYZ7nf8k8hpr4CNg6cAgi7ALWpIl/5DGj9mCQVJOeBi9LiFno
         lOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdBKL5/wSUZ9elFrdBhJWTMBm7HHVYLNpv14EVM/0GyXk67aHopc2iNk5MvvnmOw9/shrEStpf4n7z+1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHj6yZy+0X1F8B+2T9F92WybzKB4mGMxPEri31HsDg/5piF0+
	XuROqY/tFnEtWrZwZUpYyKffltgnx1Q1BknDY3l5/JKa6hsGIed2pK+5DB+y7wk=
X-Gm-Gg: ASbGnctOrtTyWSPVNrclaq69PvOUsNff90IdT+TYfZVbe4XUg2IExzUCGeQW/j7q7jN
	/qlcuH3UMt+BmmRBke0LGfFkFuNqcoWATAhSDnsR97N7UXPug9VSXEeFBG2Ou1JhoNEw+3mkFRx
	r7lBywtAZAybOP03rGuU/ded2fg9sJKwYlvweaf3W0iswbAt+CaptayLJF/Dq3j3eAKQttTJGrb
	rE+sbMawPEaOfgOyehAmOFt3EbdsWzLXbuUdIWEOPcnN8kHJf0VqYiLk2CWNQ==
X-Google-Smtp-Source: AGHT+IGB7WUiv++OomTBoRqMx05UkP8zy1PF4dkfs0RF7wyiIACspJqrvuDsP0YhoCmqNFpLeOZDdQ==
X-Received: by 2002:a05:600c:1c07:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-434d09bf7b4mr52704295e9.13.1733305169696;
        Wed, 04 Dec 2024 01:39:29 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm18080135e9.35.2024.12.04.01.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:39:29 -0800 (PST)
Message-ID: <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Date: Wed, 4 Dec 2024 09:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
 <20241203035349.1901262-12-namhyung@kernel.org>
 <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>
 <Z09-GGWh87_wrslp@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z09-GGWh87_wrslp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2024 9:54 pm, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 04:43:44PM +0000, James Clark wrote:
>>
>>
>> On 03/12/2024 3:53 am, Namhyung Kim wrote:
>>> It should only have generic flags in the array but the recent header
>>> sync brought a new flags to fcntl.h and caused a build error.  Let's
>>> update the shell script to exclude flags specific to name_to_handle_at().
>>>
>>>       CC      trace/beauty/fs_at_flags.o
>>>     In file included from trace/beauty/fs_at_flags.c:21:
>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: error: initialized field overwritten [-Werror=override-init]
>>>        13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
>>>           |                              ^~~~~~~~~~~~~~~~~~~~
>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: note: (near initialization for ‘fs_at_flags[2]’)
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>
>> Hi Namhyung,
>>
>> Is it possible to fix this before the updates to keep it buildable? Maybe
>> it's not feasible, I didn't check.
>>
>> I did notice a build issue in the kvm tests after this update:
>>
>> $ make O=../build/local/ summary=1 TARGETS=kvm kselftest
>>
>> In file included from aarch64/aarch32_id_regs.c:14:
>> include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No such file
>> or directory
>>     15 | #include <asm/brk-imm.h>
>>
>> But I tried the same on v6.13-rc1 and got a different error, so I don't know
>> if it's any worse.
> 
> I suspect it's an unrelated issue.  This fix is about generating
> descriptions of the flags for perf trace beautifier.
> 
> The below is the only change I made in this series for arm64.
> 
> Thanks,
> Namhyung
> 

I'll take a look

> 
> ---8<---
> diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
> index 964df31da9751c96..66736ff04011e0fa 100644
> --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> @@ -484,6 +484,12 @@ enum {
>    */
>   #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2        (1ULL << 0)
>   
> +/*
> + * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
> + * Valid only when the system event has a type of KVM_SYSTEM_EVENT_SHUTDOWN.
> + */
> +#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2       (1ULL << 0)
> +
>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED    (1ULL << 0)


