Return-Path: <linux-kernel+bounces-546639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA6A4FD2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478D77A9887
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C732309B9;
	Wed,  5 Mar 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSCj904N"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9C205515
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172791; cv=none; b=TiQBXmw4dEKGbmUdOctWydvlJxuZDtzPFGmQ5r1umHmUcAEFPQNkmQue2IVAWOGsO5rUwORicu98YyeLaM21CDkMEFYI++zzhkrb8Q0DGBY6ZpX63Z4YFctf1GLVBVt5OzgSEClwWbnLJs1N73aA5KT4xA6jBL5XJLsGFmQmYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172791; c=relaxed/simple;
	bh=u39E6G8oRkObciqtFsR0GjEIkgJwTf2015/hKDgM3xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ccrliiTDgk6BzqGTzA4yAMF5xC1laPTuymOxyC+awUp6p0wovKEAsqMdg4h+CHm9G+wNRBJOOEP+gpetataZueAsgVDc3EV6L+fqnzy0pv8PMjHOlgVK1QZ07pl35PLudG6/sh/AH14lVwzPo7U0429AOU/yM6b1leOHPSGMFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSCj904N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390eb7c1024so3880897f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741172788; x=1741777588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaO/Y+RfI4yiu24Wq1QDo3KrxHmio/TAOl7xl82m724=;
        b=NSCj904NhNUP4VwL8lkj7p+6ZyTQ6Ay3NKCLZVpTinilpVdyJ2qQ8bKXSDg4gGy8pC
         rpkN/gWKkiPUiy5i/lGIwkolAPwhez2anr59rb0o6+OUKBxUDURhTcaGzTpAQPyshIlu
         FY4kXs5p4UFSRNnyOV7oPojX7C8SJi5FPN7OEYWWRlh3VreypITPtrW4yZqqjFHxHhfj
         rQU/BeshVdR7QHg/IQwLE4M19f/vU7KUQwsPtRMmK+HZZ7GQwr1twj+mPVY2ooLRcqeK
         pSnYAP4ZZ/lvT7Yik5fd9TT49HfXO93Y0ZLHulo6jqlFaafztgSV5+wNNymOwAnKipxV
         kREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741172788; x=1741777588;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaO/Y+RfI4yiu24Wq1QDo3KrxHmio/TAOl7xl82m724=;
        b=OW4b2PViLtZO7m7OEQzDJYx1s8tJqcMoD+9aon5X9t7lWsm092RXZxsJOUv+bZFfH5
         45nnxflGCWFA/EwnfHvKWSccDsD6PozVqkIzQdESvhpl/r0RaqxYFhosZ+Xpd/TQIJRJ
         EG7oTyP48JRKUPBdw1y3PcxHPm0rG97tqKUIMhpxsLkwducOjPMB//abKQkA58/rwIhw
         mJIeA8YdTJpQ/KL7ptlUOo3lzP06jxPr0afYKWlzZZ010WL5esvr2UMlBuYIF8PRv3Ud
         BJSg71uJ+k/LdEVbtr6ggsjJmTw72SA43LGsuEw9YGYxRKAXKGGLV113YFgWFbqVO8dO
         jjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDvQnggd1xfZ/NRRU+KWX/dxScR/1+jBUhO7X6KkyELDWIO1bmVzjbFUcm5+fLcpgQ+fc9SPbvLmk/ULI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0O5oxzJl1TbZ/oP1TZ+SK563qPPd28iJy+pT4HiCmB85hKQ8U
	PPBtQW2K7zxjTiPwOP7/e8MQblm2IRjNgTMlY3/rLgD6hEqT9nWxVz9EI3msaLI=
X-Gm-Gg: ASbGncvtwPiOntC0uD8sw9W/ixZoxtffvgIWkrtaTgeEJH6vp9FtR+yAoWqUoHIpNDa
	QKTdcyF2ADnGneK96BBTt0XOWNeGF9RDLUJzQ76ycDvoU5/3pClmYWU9CZmPwM9gAg2+5wiMq4L
	Jlc2d5mlP1S6qFQwhRPWrdkX6lbPIDXWALVCTBQgQWjSHwbGrHzWuoKCdu6zOvmxGBWARz/zf70
	v51NDPwnb/dDpFlvGgnys0fXYyZ/YZkhPhO+btqX+o/HvWHRWNncHqFjP5YzeAyS2gR3sA2XPks
	qlBFj2vTe9qtNu8IG5U9WpevZcK0p292/u+emA5pAIXheZhX92+tqkU=
X-Google-Smtp-Source: AGHT+IFBD1P3nJKJFdOPJRZsFcAADaetXcgqXPJk2zLoX/rEFe2ePpokUS72IwxetWohR/IMWmu6jg==
X-Received: by 2002:a5d:6c6f:0:b0:391:2e7:6811 with SMTP id ffacd0b85a97d-3911f7404b0mr1958821f8f.14.1741172787896;
        Wed, 05 Mar 2025 03:06:27 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795d30sm20934751f8f.10.2025.03.05.03.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 03:06:27 -0800 (PST)
Message-ID: <4e495505-6b67-41dc-bd62-7aba4f7cf71a@linaro.org>
Date: Wed, 5 Mar 2025 11:06:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf tools: Improve handling of hybrid PMUs in
 perf_event_attr__fprintf
To: Ian Rogers <irogers@google.com>
References: <20250305083735.393333-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305083735.393333-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 8:37 am, Ian Rogers wrote:
> Support the PMU name from the legacy hardware and hw_cache PMU
> extended types.  Remove some macros and make variables more intention
> revealing, rather than just being called "value".
> 
> Before:
> ```
> $ perf stat -vv -e instructions true
> ...
> ------------------------------------------------------------
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0xa00000001
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
>    exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0x400000001
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
>    exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 6
> ...
> ```
> 
> After:
> ```
> $ perf stat -vv -e instructions true
> ...
> ------------------------------------------------------------
> perf_event_attr:
>    type                             0 (PERF_TYPE_HARDWARE)
>    size                             136
>    config                           0xa00000001 (cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)

Seems like a good idea, I'm always decoding these by eye.

Reviewed-by: James Clark <james.clark@linaro.org>


