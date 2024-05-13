Return-Path: <linux-kernel+bounces-177308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F948C3CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97C81C212C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D28147C8E;
	Mon, 13 May 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="el8EcEvF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA146D62
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586826; cv=none; b=GlSsuVd8R8IrfaBFrfWjpUbjwn2EuHOXfmT2pjLHfiZ5lQ9EX1gtgJkrHpqjy39FijYanAiG5FCkDUEYy6algRzDr71NlEmjJ9e8hfGZBRB9myZ8gFzTpnH956tDKJq5idv5O/ZTmiTebUda8Su7qfQ2V3RRfYjilxliB73eJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586826; c=relaxed/simple;
	bh=tFCvM4pFGIcP2IcDFlxXwVmOqzhfygrr2i84mudsx8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9OitUjlUjl3N0qp9s5X8TiiUt/LLzmAL75f+ihFrx9aKzddGG2/jocgLTgdFaE5Blm/uNVu1VNvh7okjq6i4zV1eENFtsnL/oMjRucWp9lixDzdBv7xEBARYGgdHfgtpjUe3ed0pP0i8/BsF5EfGPwavgQAzry+8X5w/gmHt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=el8EcEvF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso3608994b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715586825; x=1716191625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrJul58J3vgdAQnlLZkyjKnsoAlgZLs+CwOV6iqswxg=;
        b=el8EcEvFVO7E2jxycYfJspuv6Ztxa3XCW5MqpfNsUJ1jZDgJFtVo2qAF6x2viKZ+15
         v4dNeZC/7qpAy4LBZG1hewR03uaWyKDGSq9aVgaEOa6RGwdk2u4tjqBhAwHCG7z4YbSJ
         q5E8HBG8P+FH5k/0dx1duwTnm/FrLePO2j0eWb4UFA04f/+cd1zyugGpMPMCkqCLK2VN
         Q4MzlKytlhI0MHVZVu/1hpVdDbWKk8yoeeAp14J58/Bi+scPdiB9naP05mJUdJyUMlO8
         XAmzufThEHsEX+OTjOuQ5M4azUfhcS0xDSNhzFRNFyykh+/TdUIbk3X50PDUrMsGwUFq
         cgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586825; x=1716191625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrJul58J3vgdAQnlLZkyjKnsoAlgZLs+CwOV6iqswxg=;
        b=LwNtcGghP6jRu+YYcuEGNdrglgwgJSbl4qn4VQuBtmQDUuSnoBflFxG8X2Mv5ZXw48
         tnUqbqNXRi91+NFrc97GDsnBKvWETL4znQs6t5D3ZrTHHwkxDBE1LXqalR25yc4Ediq7
         kHZuWzb0gfrETZHn97rBGenUnhdn4UMe7YNrLDo8S5YFtS+at73Zvz95YQpLPSrv1XNi
         iM/Ao40aLgTE+76JgpRg0XvT5OhiLJJiXSwP8SNsbBuZv+0GOQ4ZWAhwGY2hu5zd82X+
         4yo3lFWjYxywDUP6jINTKFRITmdpVrpLxRdisv9U+0+9BZTDLxdJcSL7WsI5UkhBFBJA
         V5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXHDtjIGFQY3gSmn7XFSP9Wdow6DJmKtLfzX1nqAks/MhZmxiekl/FjATMV3DWfOrxWAuW3NKoKFpM//6rXHqE2UgvLfoEfFpW3kcuF
X-Gm-Message-State: AOJu0YweY0vD1r0O7hfWFkac6mYU+eGgmdrPEwYrXPQIiQ2+Y8+Hf/G5
	sPPm1JKB+VTemJrb4HbKtWp/5hrRqyrA7V6uxjLehpIO+TL7ZZJ1PYQqdX68PLHLmsjPRtAhqvU
	Z
X-Google-Smtp-Source: AGHT+IH3Fi9ZOB+eCpu3j60i34taduaB2ndb4SXYBkghT/tUfdR3N9HWEEGSmDP+Ba7lZEpAPPvamQ==
X-Received: by 2002:a05:6a20:9e4c:b0:1a7:4944:d49 with SMTP id adf61e73a8af0-1afddee52d6mr8366132637.0.1715586824785;
        Mon, 13 May 2024 00:53:44 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3e26sm73088345ad.43.2024.05.13.00.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:53:43 -0700 (PDT)
Message-ID: <a476b77f-4d7d-4dbb-b58f-cfc39c07e91e@bytedance.com>
Date: Mon, 13 May 2024 15:53:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Specify libtraceevent dir to rpath for
 asan/msan build
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240506081648.3890067-1-yangjihong@bytedance.com>
 <CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com>
Content-Language: en-US
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 5/9/24 07:18, Ian Rogers wrote:
> On Mon, May 6, 2024 at 1:17 AM Yang Jihong <yangjihong@bytedance.com> wrote:
>>
>> perf built by asan/msan will not search for shared libraries in the
>> -L directory. For cross-compilation, we assume that sanitizers is
>> generally not enabled and add libtraceevent dir to rpath in a simple way.
>>
>> 1. msan build
>>
>> Before:
>>    $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
>>    ...
>>    $ /tmp/perf/perf
>>    /tmp/perf/perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory
>>
>> After:
>>    $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
>>    ...
>>    $ /tmp/perf/perf --build-options
>>    perf version 6.9.0-rc5
>>    <SNIP>
>>             libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>>    <SNIP>
>>
>>   2. asan build
>>
>> Before:
>>    $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
>>    ...
>>    $ ./perf
>>    ./perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory
>>
>> After:
>>     $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
>>     ...
>>     $ ./perf --build-options
>>     perf version 6.9.0-rc5
>>     <SNIP>
>>              libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>>     <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/Makefile.config | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 7f1e016a9253..a9a923358604 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -188,6 +188,10 @@ TRACEEVENTLIBS := -ltraceevent
>>   ifdef LIBTRACEEVENT_DIR
>>     LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
>>     LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
>> +  # Specify rpath for asan/msan build. Generally, cross-compilation will not enable sanitizers.
>> +  ifeq ($(findstring -fsanitize=,${EXTRA_CFLAGS}),-fsanitize=)
>> +    LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
>> +  endif
> 
> Thanks for this! I found I need the following to make it work:
> ```
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a9a923358604..bcf4ab292462 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -190,7 +190,11 @@ ifdef LIBTRACEEVENT_DIR
>    LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
>    # Specify rpath for asan/msan build. Generally, cross-compilation
> will not enable sanitizers.
>    ifeq ($(findstring -fsanitize=,${EXTRA_CFLAGS}),-fsanitize=)
> -    LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> +    ifeq (${IS_64_BIT}, 1)
> +      LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
> +    else
> +      LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> +    endif
>    endif
> endif
> FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
> ```
> 
> My libtraceevent build command is:
> $ make EXTRA_CFLAGS="-O0 -g -fsanitize=address" DESTDIR=~/libtrace install
My build environment only uses make, not make install, so the library 
path is lib, not lib64, which leads to this difference.

   # cd /opt/libtraceevent
   # CROSS_COMPILE=aarch64-linux-gnu- make

In order to be compatible with both situations, would it be better for 
us to also add the lib64 path to -L and rpath?

I have sent the v2 version and added it to path2. Please help me see if 
this solution is OK:
https://lore.kernel.org/all/20240513074910.1660373-1-yangjihong@bytedance.com/


Thanks,
Yang

