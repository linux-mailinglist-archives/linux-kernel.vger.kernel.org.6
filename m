Return-Path: <linux-kernel+bounces-323206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B497395E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D11288830
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B971940B9;
	Tue, 10 Sep 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZZWJ7By"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91666190692
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977202; cv=none; b=Z+BKjdxoO+CjUGE/DIfXiLjVkyIFLNiIFt6KqgGZcezbFKnVDOlVo4jgQJLloEBVUm4V3VsNDn2zmCwWoEEOPyziwQO3G5/Uib4QsP1AZlUMmPa3686UQ71D8bMEo1aWAnkWkQDpN5oLxGQ6N65BkvA/iHJkIp5YuSIjYA1wdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977202; c=relaxed/simple;
	bh=U8OTsToaWfVMxFIRMdzr1xo9cfxaKTYwFlNjVCRaQ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etYp4jlfJbDZzClVl9c2dMbKkvFWrd1jNr40umRgVPzZ8AzmFeHe4J0WPa5CG7V6LqILI6MH7R+AiNuzrC573nHA7LcdqiOyIHPseTZFR4p5HQA22TVb4METghfMSEO055D7MMaqj0T3g0w4FdUUdWXFDUqqq1UtzV1wMV5Hajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FZZWJ7By; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so7743955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977199; x=1726581999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1Z0JUhOsYgTNsTyk5PimUJPDh+yOKaKvqM5P8Qrzh4=;
        b=FZZWJ7BynjwPAbvrKZqpmWOY0ydbDzp6snnbuSBPNaB4zLknCdhBdZzPqxgUhcJWLA
         ihqlK/5K+lxNiIvjZAzvocfCmS00O3GJcyrVTU2LVJwOh/JKEEDzmbpuPcn2zmjU8TLK
         3z+xMKgPOvQZJ2N1ctS56aMfREv9D/JnqDOgEFpMLGIrAYSlvVD8FKYV0r/9KjySAemE
         s2+thar0TnFzqOKw6bbwc6G5+3B3wpxqjaI9o32bthMcbFgnuXNlEaN2ERScdDClGyqK
         rb4XcQOgpPJnUkP00RBJl6i/ecX8ojXhDPXTEx2dn+lq7Fhkzuv+i6LuLeUjYSbqTauh
         OVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977199; x=1726581999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1Z0JUhOsYgTNsTyk5PimUJPDh+yOKaKvqM5P8Qrzh4=;
        b=wdWX1YAhhApQTJMhiyJVBs1dvCvPaynBSV9hNubMSwzMhUcwQNmDg+uo0Z67nvQ+b1
         0SpZ2pVUGOD/JNkMUfWXVJGDNpPVrPar4lx7V6D1J65i6Dz7mQKqW46R/18+QXT2CZOP
         TxvU3gWJNY4ph03VY3OojMTDL6cgaqTWq6hftWLkT0qg8yPFjlhfAqCAmCow97fRH+Gd
         kzPdGDPsqYWUrBimHO82aD+lz5ZVH/1MEi3GIfFjTv4D3Vu0W7K2ObMfrRxsWn3Xxw6C
         q2n+yFY96rVXXCzb7WuE0AtUZyhxfpOZ9Sq9IpFPlpXKu7La4/KNGfZY0IRRwN521PF2
         0Qbg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ORIWhBsN86GoX41u8M0MYQlTvqDOUfTbQ4Jw/DK+42tOi08+7uz9uNpqjpxNh35QJA8JJKW5EcpurC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63C+sJ+BaEC5Wq7ezeRtTEpkEVjqL2ZRMrDMtmY8j2oBvl1LI
	D5ugMF/3Zm9MtKH2XmGBEJbb5Lm4y0/tf5jXYl6yVGWjqXcKIGIIAZEx3TfpSUY=
X-Google-Smtp-Source: AGHT+IF+SuIaYUhS9ZzflXfMD7MbhhkHr6SfEY3NmvG6VZJUm6PBixRhQksR8W/YMdbqbZdBl9N98w==
X-Received: by 2002:a05:600c:5025:b0:42c:bc03:e765 with SMTP id 5b1f17b1804b1-42cbc03ea7cmr32813575e9.16.1725977198215;
        Tue, 10 Sep 2024 07:06:38 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5ba4532sm86596495e9.38.2024.09.10.07.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:06:37 -0700 (PDT)
Message-ID: <0900b672-57d2-4e4f-b5be-964da82c7a12@linaro.org>
Date: Tue, 10 Sep 2024 15:06:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240719150051.520317-1-sesse@google.com> <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1> <ZtRIla5pCqlMIKvN@google.com> <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1> <ZtcaC5WOTj-fh_Px@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZtcaC5WOTj-fh_Px@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/24 15:15, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 03, 2024 at 11:01:36AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, Sep 03, 2024 at 07:09:47AM -0300, Arnaldo Carvalho de Melo wrote:
>>>     3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>>      17.58 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
>>>      util/llvm-c-helpers.cpp: In function ‘char* make_symbol_relative_string(dso*, const char*, u64, u64)’:
>>>      util/llvm-c-helpers.cpp:150:52: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
>>>        150 |                 snprintf(buf, sizeof(buf), "%s+0x%lx",
>>>            |                                                  ~~^
>>>            |                                                    |
>>>            |                                                    long unsigned int
>>>            |                                                  %llx
>>>        151 |                          demangled ? demangled : sym_name, addr - base_addr);
>>>            |                                                            ~~~~~~~~~~~~~~~~
>>>            |                                                                 |
>>>            |                                                                 u64 {aka long long unsigned int}
>>>      cc1plus: all warnings being treated as errors
>>>      make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
>>
>> The one above is fixed by the patch at the end, that I already added to
>> the cset where the problem was being introduced.
>>
>> Now there is something a bit more tricky, we'll have to add a feature
>> check to see if the libllvm has what is needed if this appears in some
>> distro we still want to support, since alpine 3.16 has what is needed
>> I'll take the opportunity to drop test building on alpine 3.15.
> 
> Or, as I'll do with debian:11, just remove llvm-dev and not build the
> features it enables:
> 
>    17    13.79 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
>      util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
>      util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>        178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
>            |                     ^~~~~~~~~~~~
>      util/llvm-c-helpers.cpp:178:49: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>        178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
>            |                                                 ^~~~~~~~~~~~
>      make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
> 

I also hit this issue. I think it makes sense to auto detect the version 
so I sent a patch. It was quite easy to autodetect and it might not be 
that obvious to others how to get the build working again given this error.

