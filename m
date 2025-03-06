Return-Path: <linux-kernel+bounces-548590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A06A546C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7327F1890204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7F209F51;
	Thu,  6 Mar 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8PaDm2i"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF719F438
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254443; cv=none; b=c75l13hSXwbbNE0Q9V+MEr/DG+YpTwRxHFjf2E/XKrLa8HEtDebc+6JtIKPGGAr0igiQ6S7xIEl5zD7YXqpM+Th7sUqgxERq9tb5C+aeK/S2weF7S3HoirnvAoAW5tiX17LppwCqHUci1MFnfViJr/Kj9dg+e/Dj1B9d3E5fu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254443; c=relaxed/simple;
	bh=ocDWJ4p9s7n2aBiEkTNQOAwnVM+Kg49B5GiFnl8AY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UoBMR89uSvKBmCWpWhwJjV7cfLMkvl39RZUGokUWlX5EzaV0TDRJh+v6feT/cJcD0aG6dqUXh3Eb4EindHqOYCOmJAr94MKrOjDeTwYZvChvxFupHYSK0GTLEQO0B8Oa2iES5AeGPTvLEtQtu73ehthYXqfblaLxsiYs0zkRO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8PaDm2i; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e88caa4dso242176f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254440; x=1741859240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yetSAyXhU+AeT+AIBEYa1+lDd3BOD+YukfIQ29NG8n8=;
        b=Z8PaDm2iiCk/iFv9382xCErCghfxV/Qq5xoKC1+HywE/h12cjE/BaBhevSLZ6zzeks
         bR5Vs6bUvuN/n1wcFsGT8TZFgXhBe75z0YIAHdyB6EdgLQ/w5Qj7m2z5zPxKXPj7PL+w
         xjhOSfXKp2aEihWcLgmfmghxG8YDwu6RHr+OpLbRKBM28mgtuCySXgqcbMPlw5x8AHFc
         3D6hghp3JDxw7dbbSApK0526XaWN+cfkOJvNm+ZsPjEDRg7yhTpzw0zRTuDehaSpiW65
         FKu0Kb5pj/geq4BKgOhDK8R0xMzkvr34ljwsfKQ0V0nF6G3GTCaSvcP1CEvFS/RCJdlZ
         XvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254440; x=1741859240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yetSAyXhU+AeT+AIBEYa1+lDd3BOD+YukfIQ29NG8n8=;
        b=R0v4i9NFeTZmHL4sIWnAfPxI9nVDh/Aie0946uYjCEal2YuHeyVt45/DTZEXRwUEIm
         po3fn3DhDmCHMS4WcnkQQwAWuo3pH65yz5yioJXZZsQMHHXoXtOoExTy99gpqX9PdCFw
         G3UAKTvyp7MhOkDO3GS1iZ0XvimvgF/q18YdZa/Fzdq348y4hN6oEVyBTMe5xoarbXuA
         w5Vr6wXvqOLfv8fzNffbVLhst0S5pe4eyLsbPT+1c4JkYCG/SIUYbMLMVeBJHVTjpovn
         0a1SMOsxxpFITLWF3E4M2CLkLmU8sLBZrKu2U4b5B+NyakRQQx9BssKrFDEewMhbxBcX
         UFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUlCLz3PfiFuI9BIEzQpoqZaOgGbucqNHv0pXeLAfl9IHcQgsqapd4I0dFOxwSZzpAOmpO/b6/230P+Pq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvF5BN+gLJitHAihMQdVNystnBSjTx7alM1KVYvuzrw31KfYcG
	qxImf6135DOTj7okcjDLENzcoLX3htxnFubiyxK5SRSNFxg9WX6dGElBkodStWc=
X-Gm-Gg: ASbGncuNOyfPsVYR8ENn7YO90eLkHI50+M0UjkZTo92lWL2gXyaIChKLtYQGWVD07vt
	Da7fa36Jgoa93EVwaCoxIB019S9fm7gMO1FcqCSeZIzD2HNp7Kj8qV9AjS8RsidU8eTbMdwLri4
	uxSYpEk5wA16xsvHA6oojWXh2HpKCacXkOE88rzHteVMSNVZUVPrUGN0lPtXJMLHWM1+fyI8LRx
	kAz+NSVZHcPo0M+n/49YQlXHEfB35DfVsFLgU7r6QqvwkTwnopXVYNtSAXgVH7XnqLF0Gz2XjLv
	D9VJCY75hVcVVbvjNw891ZDMzC9qE10+S9gcQg5zKYzXoja71PQr6A==
X-Google-Smtp-Source: AGHT+IGWRfZvc13aBacUnCiMGOUsDI0ES2OxfOypJSSVIc/MKe01QPLe7C+nLTUVOBpIc42Ba5F7jA==
X-Received: by 2002:a5d:588c:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-3911f7b8dbcmr5218367f8f.37.1741254440106;
        Thu, 06 Mar 2025 01:47:20 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79fbsm1520863f8f.13.2025.03.06.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:47:19 -0800 (PST)
Message-ID: <83fde43e-b74c-4686-8db1-9d28a60533ad@linaro.org>
Date: Thu, 6 Mar 2025 09:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Fix leak in "Synthesize attr update" test
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250305191931.604764-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305191931.604764-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 7:19 pm, Ian Rogers wrote:
> The own_cpus map variable may be non-NULL and hold a reference, in
> particular on hybrid machines. Do a put before overwriting the
> variable to avoid a memory leak.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/event_update.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index d6b4ce3ef4ee..9301fde11366 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>   	TEST_ASSERT_VAL("failed to synthesize attr update name",
>   			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
>   
> +	perf_cpu_map__put(evsel->core.own_cpus);
>   	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
>   
>   	TEST_ASSERT_VAL("failed to synthesize attr update cpus",

Reviewed-by: James Clark <james.clark@linaro.org>


