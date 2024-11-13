Return-Path: <linux-kernel+bounces-407406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4C9C6D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19E8281821
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539F1FE0EF;
	Wed, 13 Nov 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBgvYHlZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D01FB89A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494531; cv=none; b=o0nUr6od6zTvrD0oQes+wI9w96b1uPy5RPN4ZiUuktogJHbPvht8szjr8JJmQfdRiT+YFpTgus76DYDces6RMj7aESMj1IdbmZcAz7nbAhUqA1i6M6/IkGVFBcIcJ+WYexNQzjMUTehQ+Fdt8mITobBbDMtqLiCFbUDdJj/0MzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494531; c=relaxed/simple;
	bh=AqumPSQGax77GBO9IatO8rErpe6+RT+R0gHdz967x50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewwYWlH0Bw4smlYbfmkObszkb/G616fnVqfWopLdneIlN6xUAgCp6Hf5a/ezdadhsdXpzPTZixmvuj7YoZCramXeTXuNlbw2JYdbTzlwysM21h0pbouFUxvQY9ngG5CDiGr7NqmxCIVMTNybHLd8gmwNzpHlJ14fxHWrIJwThfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBgvYHlZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso9209510a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731494527; x=1732099327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpKNnFSJuu8mX4fv2nmuYeZ5VRhQuVqxMggvr0piqwA=;
        b=yBgvYHlZK7BcsecRjQVL4tytSpec52M5qxXtTaU99IMgh8Y9zKgRCoZ1LdT4IpYDUo
         xlLlUqnU+jSxVxprqUEXFcE3mPq3jBKBYX90m8BIVnJL9CrsZR9sxxhjxYrQGbkM4E7q
         3+irDhnmChnQUi85TY9e/hoUTs8SOn0yNOGBuPNSADAKTv255b5y0IznZSphCXNc4oUB
         B8SdMTzwFFTyVRt+yh614rhCVPOzl+akzy6h+FxknM4HbI961zHv+VOYIRs8xV35OlpZ
         PmNqayNaED4J/cl9X4usPflGhrH03yFL6oVZP6wmD0wrWI2wvdpLCr7RIIHF4+zF4I4V
         JnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494527; x=1732099327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpKNnFSJuu8mX4fv2nmuYeZ5VRhQuVqxMggvr0piqwA=;
        b=RcLGLr9M049N4nHcoKTItIQQYVT/LhJVmbjumvVVKAVNREPlU/CB02ADPXEgLEr+BH
         gkxEeWAUKnecLSyXwvxdp3gogdtETK1ZL2HguIuKevSvIqLacOLjhwbiM7YWzZJBwevp
         JBJwBNTMaKtt4exv6GDeDfBbGMyzPYjcAY2MWPJ8ex97hPQxvUKjTmWSvgFG7hCx0MsU
         H4jCHlCL2hZHuaB2Lwv5YeTtxWQYeJGLmO2OFrcugJU+j4T6GncCHIv5rda4Y2B923F+
         4Mab6ZKvHPd/zY2o09g05swNpBupx3aFkdXu0mo1Iwe9cQVGn25BivhtdELSzE/NsbrZ
         lvaw==
X-Forwarded-Encrypted: i=1; AJvYcCWgBygJRD/jlb1AKaj8uP2v2WKvnsfeJpS3AnqC7XHs+veqSQtAFzhuc4lN9YjIDQi2M87yU9VNSnG3qg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DiksUwiSbfU4mEehOBmUQN0PpXU3GgNvD2fb2VcXzazDnrkW
	cr3FQF+4o8Wg3j+dzuoCOU4JkQqDAJ+S6I7yjTH14V3yIQU+qL2JZSECDDYJuyU=
X-Google-Smtp-Source: AGHT+IGkvSzEORJMBip4kLqyw4g2XZQP9hZKEvJR8NJ1wbFa9hcYRPzrgSUKiBVjVht7VAmBjdnAUQ==
X-Received: by 2002:a17:907:5ca:b0:a99:ee1c:f62f with SMTP id a640c23a62f3a-aa1f8075b6amr218093766b.34.1731494525232;
        Wed, 13 Nov 2024 02:42:05 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a452sm845869366b.51.2024.11.13.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:42:04 -0800 (PST)
Message-ID: <e81bcabd-11fc-45f7-abfd-05b569b1c18f@linaro.org>
Date: Wed, 13 Nov 2024 10:42:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] [PATCH v4 0/2] perf arm-spe: Add support for SPE
 Data Source packet on AmpereOne
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Graham Woodward <graham.woodward@arm.com>
References: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 8:29 pm, Ilkka Koskinen wrote:
> v1:
> 	* https://lore.kernel.org/all/20241024233035.7979-1-ilkka@os.amperecomputing.com/
> 
> v2:
> 	* Doesn't use read_cpuid_implementor() anymore as that was broken and
> 	  unnecessary.
> 	* Convert AmpereOne source field to matching common source fields to
> 	  avoid duplicating the code.
> 	* Rebased on top of perf-tools-next/perf-tools-next (ba993e5ada1d)
> 	* https://lore.kernel.org/all/20241031213533.11148-1-ilkka@os.amperecomputing.com/
> 
> v3:
> 	* Changed source mapping to simple switch statement
> 	* Dropped is_xyz() stuff
> 	* Added table to map midr to data source decoding function
> 	* https://lore.kernel.org/all/20241106193740.6159-1-ilkka@os.amperecomputing.com/
> 
> v4:
> 	* Split midr/decoding function table
> 	* Made AmpereOne DS decoding function to ignore unknown sources
> 	* https://lore.kernel.org/all/20241108010911.58412-1-ilkka@os.amperecomputing.com/
> 
> v5:
> 	* Moved data_source_handles[] to fix the build issue
> 
> Ilkka Koskinen (2):
>    perf arm-spe: Prepare for adding data source packet implementations
>      for other cores
>    perf arm-spe: Add support for SPE Data Source packet on AmpereOne
> 
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++
>   tools/perf/util/arm-spe.c                     | 86 ++++++++++++++++---
>   2 files changed, 83 insertions(+), 12 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>



