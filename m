Return-Path: <linux-kernel+bounces-345910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4198BCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84C0286BC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBF1C32E0;
	Tue,  1 Oct 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA3DaIP8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400C1C174A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787131; cv=none; b=C8ytk45wkv+S2r43boGzUie4hx1IRWXPTFMM17C7v7Rl4m17qRxfh/gudkQGg/Gw+YCkbuS5eDm77ROigMBabZYuiJqxNROXzqKEIhgzu+1tlvITr1bgNb4GfOF66qLYQ+G996LuAq2swjHRIOlrm5XyD5uIojXGw8KG8yOyuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787131; c=relaxed/simple;
	bh=JlkaSiAgN3xTEzEqDG1SQTaRVlE7Hw2fHY1BzOUdCVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=UVdJ2ZtqTEePpBKQJ3MEff22TcYYNrPf2lg3fSjhwqE4NHSlw+IRJSGtC5Yw4uU4oAkFZsTp3InTZASKyLQHj/viSllOi79g8xsRl/U6VM/anUbNun3u0jnNGbBQrehpRjuZE+2KVzgpeUUy++R1DBG/0eXeqTHr0iztQz6Pkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UA3DaIP8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so52676355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727787128; x=1728391928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUq5fZGbbPn3513u3fVju2MeIm4zQOr1qxH8ZL4URXA=;
        b=UA3DaIP8TK9ZYdUk58MHTJt/GZINYA3YPe8cGdRpE+Tn3I2j8lYyhPcbO6oP8vkQ4S
         mk73HKcRYY+vn5FHecs/K1wtDCY/R4xwIjXPRS8rev+FM6Zijsp1rMVjlLy+yl/0UTLO
         OTUoPZCdUrQySZoU9P77bd+qrFozDYkXKneoupLhnIlMQui5jQwFVlHrfctY1rdn8QBi
         hgOp1/kDUv2xAmeNmYgmrv42qDteTP8Eu7unmn074cMurm3sMUpeDpubwPC+VFfhXDns
         jN5M2n9yWe9w0YznrqI7rcvM/U5kRP+89Mm8jP2WqWqKI1YElnZfshVR4nkgtBvD7f5g
         SFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727787128; x=1728391928;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUq5fZGbbPn3513u3fVju2MeIm4zQOr1qxH8ZL4URXA=;
        b=qiQintvorpp4iqHP9CWONu2V0LtGMrqkBZLUx+DwEUm32burh0zLJsFDe3sPoZrUU2
         siesQlIbFp+2Tkpdbl7+4aiVK4kzE3PbxiHLDtW3SpLuEK+zN9bUTTKzJV7SWZNoT+ES
         zM8QxdzUUjzVnoDjPsiDynL533/RkvFYyPas2vHmZStFHMPe5TN+TCI4fJyzvFZuDJ17
         XnxzuEk5z9Wj1PUe+//mtw7CbdpbFwo5s7Bnzedwf2EFesZVWtr0A8961TzsyabIrkpl
         bK+DO2MnYiSHMz3pJOw8SqFOd0egPcDhOK+Ka7CbKWXJ1OgBWaYEIbWr4JLfGlGU1Oki
         at1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmWGiZG9xpJpaGs1p2R36x5V7TvWQb8NIiv27dJPDvivKBj3DSFsfA1DIRt90VKO7qern/J/EdeWbLSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZ8HEbL9XojrgJH4c3FJhNCKbqGybgMySCMGQGZNo4uFMqKaZ
	Zd7kAQDbNnIVFfMvBZWHVJWpZS7EscYdCulLWmNpnddzEd3mLEW91+NufH1/+ic=
X-Google-Smtp-Source: AGHT+IFR6HNupC1HeuHYSnieXwS/ntW/kPUt2iZipAdegZkpxM1sTKBmJMBScL6eBRM3w0y5ZoyCYg==
X-Received: by 2002:a05:600c:45cb:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-42f5844aaf2mr130829325e9.16.1727787128252;
        Tue, 01 Oct 2024 05:52:08 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a28sm134533505e9.29.2024.10.01.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 05:52:07 -0700 (PDT)
Message-ID: <fd14726f-c33d-43d0-a023-d844c1fc1e4e@linaro.org>
Date: Tue, 1 Oct 2024 13:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Andi Kleen <ak@linux.intel.com>, Zixian Cai <fzczx123@gmail.com>,
 Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240918225418.166717-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/09/2024 11:54 pm, Ian Rogers wrote:
> Python2 was deprecated 4 years ago, remove support and workarounds.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   .../scripts/python/Perf-Trace-Util/Context.c  | 18 -----
>   tools/perf/util/python.c                      | 73 +++----------------
>   .../scripting-engines/trace-event-python.c    | 63 +---------------
>   3 files changed, 15 insertions(+), 139 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index 3954bd1587ce..6d1c6be1d918 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -23,16 +23,6 @@
>   #include "../../../util/srcline.h"
>   #include "../../../util/srccode.h"
>   
> -#if PY_MAJOR_VERSION < 3
> -#define _PyCapsule_GetPointer(arg1, arg2) \
> -  PyCObject_AsVoidPtr(arg1)
> -#define _PyBytes_FromStringAndSize(arg1, arg2) \
> -  PyString_FromStringAndSize((arg1), (arg2))
> -#define _PyUnicode_AsUTF8(arg) \
> -  PyString_AsString(arg)
> -

If we know the workarounds were required should we add an error to 
prevent hard to debug build issues?

   #if PY_MAJOR_VERSION < 3
     #error "Python 2 not supported"
   #endif

Or maybe something in the top level makefile?


