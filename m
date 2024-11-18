Return-Path: <linux-kernel+bounces-412723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2BB9D0E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5B8B26E22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EB3192B89;
	Mon, 18 Nov 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgpq8bQM"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315F17C224
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925088; cv=none; b=GUtkHtmMvZq4BnEPyD/cOKT/K8gVeKFRRy9AWfaOZAuEuq2GjAPjuu+5XpSG+zBIqgTVNN+3kaQ1GHdtjmBEcTk7VqgXV4SMSulMPJa54ESjgvUufatctwbQdEcTzb0ajeQi7apl/Mraa2lM92MiBX7+cDosVDncdMTv8rCzY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925088; c=relaxed/simple;
	bh=dBmAlPpa4WJJDcibnIbJFV+AARLmdTpazGYVey7HvK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cRiJTHoHTdBwL7jwh4pYVFNuDoDVSz0AHXVlbcXgz486dB/vNRnu7+lMiyPr5NHwwYmvIAVMZ1MqfgWuboJFybPHDz4j7oYNcznBNrIWoB6Dg8YdSDEh/QYpC1cYf4QDxQxDW6Zaz4jAKKFvr14Cid0qYaGaP7fclCFIGXthl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgpq8bQM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431616c23b5so22329545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731925085; x=1732529885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uh/rvo87exHGxUF3zD6Z1mecX94CyEyK4NI+FV1jWmg=;
        b=hgpq8bQM1Vhpkb/4zENQTZUWY9MZ5DwySEZsT6iCSa8mfhOBCQXP3OKR3tzVcDPR3J
         VftmC+cU0RSK5yvhLiOGvsTuFOUdcfwHQ9gPZkAOmoh2ePAT7zFB2BtOOGBjbCNSkl7G
         ONfAR9l3rk3uDH1IKOwmNApH4BaGYz0b5WsGBUFMZSiJE+67q/e5DsGi4mBk8koER6ww
         VXJSYd2Sew5JorXb7JfIZQXHep92Ln3nWgmcMNVt9ezgtmdRQBHPteErix2+gKKjuiaK
         Sqkn3Vf4Zhc50eed/N5kNDX+Q8YFRRY/WstTp4xrP8DyhYqTw7Wb0rvwxXr87A+0fZ/x
         mAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925085; x=1732529885;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh/rvo87exHGxUF3zD6Z1mecX94CyEyK4NI+FV1jWmg=;
        b=OmyxyqjhfLx0vXhheo25sx4x29AvFsT7LoSfhiBUPBow5J4hBEZ1WhikPxRlV7plGf
         X/HIS7UksozDWE8RLtUeZLVMj8nyCGcOd+9DSkaU7k2YRiI6OkS/I7E6xtsI4d0neTtp
         Uc8Dwus6Py0CrV01KuHBo7n6jxXsBPD5dvp89IzkzuoJfc8Xhlx1fj4amNwz3gZEL0rr
         YJiDVcvhPw5leTS493JgqbANqWatdnHFYukLwjmNKgMSS1vTqryks3UFGFUZPVxWFUnB
         a26Aud96ZzZkjvtFm5MiLhkzbp1U+WOi9n+mJ9ZiPoSu4c2Tx7FHQGDo2U4yZvjYAM74
         2wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH5dkPHu3IpHsrZqX5pYePusIIgQvEzJJBIccdDpO2lUsa1onGVUNBjBYWopt5PLQbjfuTwVDYEdBZJ70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MbB68IJtdDm7h6GRySH9AboT2sEL9brsjadpZBsggU0rMrBi
	uRHS7I+zcQ9LOAMQbqK0TGK/tkCH82V4XEbMxLiZoJdZsxyx7btwd0gE9fOgu2j1Jssghqzn7Hq
	yrQ0=
X-Google-Smtp-Source: AGHT+IEyWiWl2j1kxrmJ2AfaoYU8aGAnDLFL9fz2W4TEtfID7h+V30FPMrMTmFBxSxm0HERB1iXQ1w==
X-Received: by 2002:a05:600c:1f88:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432def7e5e8mr92505365e9.0.1731925084810;
        Mon, 18 Nov 2024 02:18:04 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm147700365e9.17.2024.11.18.02.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:18:04 -0800 (PST)
Message-ID: <4ba36631-ddf2-4944-8e7a-e048803955c7@linaro.org>
Date: Mon, 18 Nov 2024 10:18:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
To: Ian Rogers <irogers@google.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>
References: <20241114230713.330701-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241114230713.330701-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 11:07 pm, Ian Rogers wrote:
> James Clark's patches fixing evsel->core.idx [1] reminded me that we
> pass the int value around unnecessarily. Passing the evsel avoids
> issues if the evlist is reordered but paired with sanitizers we can
> also know when something is used when it shouldn't be. These patches
> do some initial work reducing the use of evsel->core.idx or reducing
> the API to pass evsels and not their interior index.
> 
> [1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@linaro.org/
> 
> Ian Rogers (3):
>    perf stream: Use evsel rather than evsel->idx
>    perf values: Use evsel rather than evsel->idx
>    perf annotate: Prefer passing evsel to evsel->core.idx
> 
>   tools/perf/builtin-diff.c         |   4 +-
>   tools/perf/builtin-report.c       |   4 +-
>   tools/perf/builtin-top.c          |   4 +-
>   tools/perf/ui/browsers/annotate.c |   2 +-
>   tools/perf/util/annotate.c        |  32 +++++----
>   tools/perf/util/annotate.h        |  20 +++---
>   tools/perf/util/stream.c          |   7 +-
>   tools/perf/util/stream.h          |  10 +--
>   tools/perf/util/values.c          | 106 +++++++++++++-----------------
>   tools/perf/util/values.h          |   9 +--
>   10 files changed, 90 insertions(+), 108 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>


