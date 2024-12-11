Return-Path: <linux-kernel+bounces-440986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0D9EC77A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D8816A731
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72511DC99A;
	Wed, 11 Dec 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRLfvgLQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BA1C5CD7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906401; cv=none; b=mNkCcjV7tAKnyEeC8Bn2urBPhVTJYkOvLuBXpYVS4OQCRbSv1MTahkWW+4l8mbv7WXgiiLC6WW2Ti53yIjQGlx/nmA7Je1BUBMN8BAEBSKdmQBhYQAX21G5G6G64P6EjKkKtodAIOqMTpHY1n+hRcrCeGQUjbcQECikUl8vsTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906401; c=relaxed/simple;
	bh=kIWrg3KSpOyDbnrZlH2FQiv66peDmFlBUHq7UQwtICs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQpG00xOcxPVii8yc1zPEsN1ChJgwRy3NYodBZW5zNeKXl8F8bBcsdfPjktdKB3I9Q4iYZczr6rZ+2qpbuw7QTonWmcoNB/1Kc3OG3BCzuiwKlqVMh7C2va4Ydn8+DTtljhx/l0z/XYNaGPcHLUwzCN0PilzKYF4tNg2r9sAuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRLfvgLQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43618283d48so8681965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733906397; x=1734511197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiN5zNmlr+UoYjkxWV6ZTSSbXqyBYacLtMs961cCxng=;
        b=NRLfvgLQCN6wCgdeJaxtq/o4CeJIi8uz/VJjYxdVnPNdFILdlEUolJCnwaO4vBq4Ll
         eiqrzWMgPXtehRcq4IA7wT1j3/Ecl1FcBrJn4MGB9GuEaZNyQ01K2UBdODupMQfbr4yh
         4k8HYglzDSQrVROx5EWtnQToXn9AgBuBmEHZv5bBJLeGl7wyZegberfwyNKD6OxjOfA+
         A3rtCUw2mCu9WdDeSrxgPImraU5++Ay5P3idweDuYvVdLyYqW+/Ii/sLf38tCoRldjp8
         oqtyiL2g1/NMhlyVC/iiMl4/bAn5vxYr7XnBL1Y+T6D6FrO70dPXN7NCeCN80YU+XpCM
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906397; x=1734511197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiN5zNmlr+UoYjkxWV6ZTSSbXqyBYacLtMs961cCxng=;
        b=g2a6ncfofieD9PWt5fN1fA/Gvvuo3WPvfV5XS5iHuBbFvBc8mUnJCeCWqzcbmRtAMz
         MULNSY1Vi6cXlXjcFcoo6mJ19NLLLGeLRK+srTu6/o6j2U6Vp3wtF4CF/DqpxyXUparK
         auPChmsuPaLCo3riQrXYie/pnpHiUZab1tUH8cOI1HvEvpy7xLOO4B3zMd7wooGJ1LL3
         pH7BJIr85u2bU3QYy/7fuaIEmc7LPlSVuZVgUnv9ClOr1L5Khk/VcCns0Ax6Crz+le+j
         tyl+DWbiZdwtSVeV35b3q2y0b/pEes52Ooe8se5X4/0bzF0jV8L9FWhDAOHjQXxzFchv
         DetQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKOUeoZDeLbHaBgOxcWWBbHv4psO4zX5Y/h6yPS3Yf1eeKc+zNux7s3EfAYL15jvU6HRIT13TKjKqggcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZ62QsBBhu+SKvzd5Qses4mtvyLm8tvNRDR9QofqtsA/cR0Im
	d3BOB5dxTqHbrY1wGVgxAvP4qeklfqtqjj/SlkwFKDbVOfms2Bhb8ATdSx7kXUs=
X-Gm-Gg: ASbGnctJglTT7QhM8Xxu03KWuY3MC0dc9gODbgX2+hoYPcL5pKxixl5GcXR0G4Qyz36
	Qm6ULQ3/wxrwmd+jSAxu6ABWKrRBblrVV9iyu+ko6TpXVyTfCsHLwO2D3YuCR1s459ZSC7rER5k
	KNnemM2eb5DvIOoHbWoS0vY3H7s3XvJCF+rZoVZaAGznT9WkPU9pW/2xxpoWayElaJnkkN2gE2l
	eJO4JCI7GaagceuFalBx++aob0hcLgjQDAq9qcSETSHZSvsy205dOXXokXZpRX8ug==
X-Google-Smtp-Source: AGHT+IG632TmiPJaoyDGB4vW7o1ATYlaVMdaB35oacxOuyQFo3BTQkCwZSwUNZR2kkZt9Hh4Xgp1tQ==
X-Received: by 2002:a05:600c:1c1c:b0:434:a350:207c with SMTP id 5b1f17b1804b1-4361c3f4cbcmr12594755e9.23.1733906397395;
        Wed, 11 Dec 2024 00:39:57 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a609esm763361f8f.40.2024.12.11.00.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:39:56 -0800 (PST)
Message-ID: <9003cbc9-bc53-4fb7-a35e-d416c22df4ca@linaro.org>
Date: Wed, 11 Dec 2024 08:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf probe: Fix uninitialized variable
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
 Dima Kogan <dima@secretsauce.net>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20241209171222.1422577-1-james.clark@linaro.org>
 <20241211075510.ea7924b5b80bf0d95993086b@kernel.org>
 <CA+JHD90Brn_jLxPPMr1M0RB6+ms1O3+OvOPWJ0wkUe+MXYpH1A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+JHD90Brn_jLxPPMr1M0RB6+ms1O3+OvOPWJ0wkUe+MXYpH1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/2024 12:43 am, Arnaldo Carvalho de Melo wrote:
> On Tue, Dec 10, 2024, 7:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Hi,
>>
>> On Mon,  9 Dec 2024 17:12:21 +0000
>> James Clark <james.clark@linaro.org> wrote:
>>
>>> Since the linked fixes: commit, err is returned uninitialized due to the
>>> removal of "return 0". Initialize err to fix it, and rename err to out
>>> to avoid confusion because buf is still supposed to be freed in non
>>> error cases.
>>>
>>> This fixes the following intermittent test failure on release builds:
>>>
>>>   $ perf test "testsuite_probe"
>>>   ...
>>>   -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive
>> options :: -L foo -V bar (output regexp parsing)
>>>   Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
>>>   ...
>>>
>>> Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/util/probe-event.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/perf/util/probe-event.c
>> b/tools/perf/util/probe-event.c
>>> index 6d51a4c98ad7..35af6570cf9b 100644
>>> --- a/tools/perf/util/probe-event.c
>>> +++ b/tools/perf/util/probe-event.c
>>> @@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>   {
>>>        char *buf = strdup(arg);
>>>        char *p;
>>> -     int err;
>>> +     int err = 0;
>>
>> I think only this is required, and others are just cleanups by renaming
>> err -> out (usually for-next).
>> But Arnaldo is OK to combine these changes, I'm OK too.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> I agree, almost mentioned that, but since you mentioned this, yes, I'd
> prefer to have as small as possible a patch.
> 
> - Arnaldo
> 
> 

Sure, I'll split it

>> Thank you,
>>
>>>
>>>        if (!buf)
>>>                return -ENOMEM;
>>> @@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>                if (p == buf) {
>>>                        semantic_error("No file/function name in '%s'.\n",
>> p);
>>>                        err = -EINVAL;
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>                *(p++) = '\0';
>>>
>>>                err = parse_line_num(&p, &lr->start, "start line");
>>>                if (err)
>>> -                     goto err;
>>> +                     goto out;
>>>
>>>                if (*p == '+' || *p == '-') {
>>>                        const char c = *(p++);
>>>
>>>                        err = parse_line_num(&p, &lr->end, "end line");
>>>                        if (err)
>>> -                             goto err;
>>> +                             goto out;
>>>
>>>                        if (c == '+') {
>>>                                lr->end += lr->start;
>>> @@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>                if (lr->start > lr->end) {
>>>                        semantic_error("Start line must be smaller"
>>>                                       " than end line.\n");
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>                if (*p != '\0') {
>>>                        semantic_error("Tailing with invalid str '%s'.\n",
>> p);
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>        }
>>>
>>> @@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>                        lr->file = strdup_esq(p);
>>>                        if (lr->file == NULL) {
>>>                                err = -ENOMEM;
>>> -                             goto err;
>>> +                             goto out;
>>>                        }
>>>                }
>>>                if (*buf != '\0')
>>> @@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct
>> line_range *lr)
>>>                if (!lr->function && !lr->file) {
>>>                        semantic_error("Only '@*' is not allowed.\n");
>>>                        err = -EINVAL;
>>> -                     goto err;
>>> +                     goto out;
>>>                }
>>>        } else if (strpbrk_esq(buf, "/."))
>>>                lr->file = strdup_esq(buf);
>>> @@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg,
>> struct line_range *lr)
>>>        else {  /* Invalid name */
>>>                semantic_error("'%s' is not a valid function name.\n",
>> buf);
>>>                err = -EINVAL;
>>> -             goto err;
>>> +             goto out;
>>>        }
>>>
>>> -err:
>>> +out:
>>>        free(buf);
>>>        return err;
>>>   }
>>> --
>>> 2.34.1
>>>
>>
>>
>> --
>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 


