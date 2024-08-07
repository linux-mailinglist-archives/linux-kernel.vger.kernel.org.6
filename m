Return-Path: <linux-kernel+bounces-277230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A9949E39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9E1F228FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260317ADE2;
	Wed,  7 Aug 2024 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CLuKyXpQ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066ABBE6F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000604; cv=none; b=H8tyv2ZvMU6V6fXe4rdAxk3Rk4wC9HVEE8Y4VAzovkgN9jMJNcqygf4NEGSfwM95OYhuRi681Efq1dk/RLRi/94bPjh12nBPETYncObsSgK8qBCfNnJ4ptY/70Ax24wJyEtAn37ClEbvHR5Sy/Wow9VW6VSpz1myi0dILTodNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000604; c=relaxed/simple;
	bh=38N+viItxL3yCte3CukZEz3tvk3t9OU93AAf/2ALbZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=O4+zibeyguzuoUUavXZef0McV5H4Jrk/f5uW6xTO1vq5LiXo5QMHS0nNQgzTNNCteLA5cRnIkvUl+Vr+DjHXf9jlbTQs7L3KcEa+QHo/YUwiaahPhfF9Ae/ClRiHlK2znPLez6WbAwoK5gwA7PHzZHvRpuKJxKrwl+QQ6uOUXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CLuKyXpQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d18112b60so351835b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000602; x=1723605402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi5kPukvjKXes8AfD1B7ddB1OE6zD8xdq2TIopq22Qc=;
        b=CLuKyXpQGQNx2xj0w33vKY1VGjV4YaScG96ffraYhDKHtgA2kDtTPVFkLU8k4BIUTd
         9JavbjGXQpylpoeaiVqVQcwhetwNPk9MFn3mY9ZbkryzXjsqrLOYFieZsHnoHNScM8wd
         hr9TbUbJ7qRa3jN0N7PPJ6pegkKhY2LV9pXwh2r50kdgchMBgEhSCAQQwSUAjN6mCHAG
         e7UY65Rav+mpj5OtARioMO+rtxZQoQQt1G3ucVgJdJAL5FW8GlOGBs0XI83Xa6REy9MP
         GWDHZ7H9gA3+XV2+LL3APKb0zh3sJ2mYHW3YAqyTQHtel2O7ORvURZmlc2bAMNilyPYv
         YplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000602; x=1723605402;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi5kPukvjKXes8AfD1B7ddB1OE6zD8xdq2TIopq22Qc=;
        b=dcaH+GmBiD0dy7y9NI3GJhKSlLOZOw7vrauTqCRoBwxplTFR+593au3yb2pfQG5AmO
         fPo9GVskK1GcW3KwGJ5JhzE2yDJ0d9i8Gcdt+KAzcERK//yuDXCVliYF1rDmQF8bcfJf
         /Cw4s199+kqdvBhk5c0ydWDUNhLUr4plqu4NRCvAS1nrohm2XDXr9uKPL7qygsZ8zUc2
         cjVyH/N4l63EzuNWj+kkf2beVO0KZQuwohtX7ElXZIUdQUttGaQvEgFjPRSg69RynzZ6
         xmrqL/bZFVKBmNPBowh+5jIUgZM0cYlUngiF33V1qS3YJ34lyZrDcGY4Px0ZsDyZa2Q9
         dvLw==
X-Forwarded-Encrypted: i=1; AJvYcCUv/GdtZxm2WeOhm2YAOcBwCq6M9yQq2VgpEdxdPeq8QA32hTR0lsqIc3T2S7cUpyvIo5rDbqAbMr3aX9NFwBV557agM2xUTrFwv+MT
X-Gm-Message-State: AOJu0YyUT5+73wMVmokQg/lHvqoLzlzDlsa+ZWtzfN3CjMVb1NHu3fCw
	67Gohka9iNFOZJeU/GIgmMMM8EIrEQ+/uYr/FVOSEpmintHAj1NF051LYDCR7jo=
X-Google-Smtp-Source: AGHT+IGhf/5MMqzWbbVz0uG1EEfG1GqGNkg4D49WPuVl8SWZESpHxvs6jh34FECeqlLR8khLzAvcAQ==
X-Received: by 2002:a05:6a00:1706:b0:704:151d:dcce with SMTP id d2e1a72fcca58-710bc835cf3mr1361389b3a.5.1723000602249;
        Tue, 06 Aug 2024 20:16:42 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed3389bsm7543742b3a.213.2024.08.06.20.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:16:41 -0700 (PDT)
Message-ID: <94f775dd-ee7c-432e-9b41-6cb7a571b1ed@bytedance.com>
Date: Wed, 7 Aug 2024 11:16:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf: build: Fix static compilation error when
 libdw is not installed
Content-Language: en-US
To: Leo Yan <leo.yan@arm.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-2-yangjihong@bytedance.com>
 <ecf3460a-7f31-4dce-9a8b-fde8f146bfd8@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <ecf3460a-7f31-4dce-9a8b-fde8f146bfd8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/7/24 05:00, Leo Yan wrote:
> On 8/6/2024 12:47 PM, Yang Jihong wrote:
>> If libdw is not installed in build environment, the output of
>> 'pkg-config --modversion libdw' is empty, causing LIBDW_VERSION_2
>> to be empty and the shell test will have the following error:
>>
>>    /bin/sh: 1: test: -lt: unexpected operator
>>
>> Before:
>>
>>    $ pkg-config --modversion libdw
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    /bin/sh: 1: test: -lt: unexpected operator
>>
>> After:
>>
>>    1. libdw is not installed:
>>
>>    $ pkg-config --modversion libdw
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>    Package libdw was not found in the pkg-config search path.
>>    Perhaps you should add the directory containing `libdw.pc'
>>    to the PKG_CONFIG_PATH environment variable
>>    No package 'libdw' found
>>    Makefile.config:473: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
>>
>>    2. libdw version is lower than 0.177
>>
>>    $ pkg-config --modversion libdw
>>    0.176
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>
>>    Auto-detecting system features:
>>    ...                                   dwarf: [ on  ]
>>    <SNIP>
>>      INSTALL libsubcmd_headers
>>      INSTALL libapi_headers
>>      INSTALL libperf_headers
>>      INSTALL libsymbol_headers
>>      INSTALL libbpf_headers
>>      LINK    perf
>>
>>    3. libdw version is higher than 0.177
>>
>>    $ pkg-config --modversion libdw
>>    0.186
>>    $ make LDFLAGS=-static -j16
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>
>>    Auto-detecting system features:
>>    ...                                   dwarf: [ on  ]
>>    <SNIP>
>>      CC      util/bpf-utils.o
>>      CC      util/pfm.o
>>      LD      util/perf-util-in.o
>>      LD      perf-util-in.o
>>      AR      libperf-util.a
>>      LINK    perf
>>
>> Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/build/feature/Makefile | 2 +-
>>   tools/perf/Makefile.config   | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index 12796808f07a..b18513ec4da6 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -178,7 +178,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>>
>>     # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>>     # Link libebl.a only if libdw is older than this version.
>> -  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
>> +  ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
> 
> I would like to follow up the style of LIBTRACEEVENT_VERSION and
> LIBTRACEFS_VERSION, so change LIBDW_VERSION as below:
> 
>    LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
> 
> Does this work for you?
Yes, have tested it in my environment and it works for me.
OK, will change in next version.

Thanks,
Yang

