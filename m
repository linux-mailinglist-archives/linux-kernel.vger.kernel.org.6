Return-Path: <linux-kernel+bounces-260096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CE93A2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C23F1C20F31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E91155749;
	Tue, 23 Jul 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUlZ607y"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39735155325
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745701; cv=none; b=t/mTyXdYz/MGs7H2Nvs88C/iStJ2vJ4/0k+mxzH1xoleYNW/SUz4qrJFU+bPY9mwNYxz60SSoJfKNSwInsLB4cJNSadg6a4tB9e/7WdrfLODE1mqSBhI8uj8VMswm+1sUcf8sdo3pYOIFBovpEsZIG/j9jHdZl+8EU5JYNFcHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745701; c=relaxed/simple;
	bh=NbEaiDQst4g8UDjxWI6M6LdJiePjTUEZujWHMsKuSZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=nd+LtB/WXxWDqF//wcZnQuiW2jISP2vudX37zfri78XbSv2sfSEPdgRzkpbsXx+Z8Ge/0nI/JEloPvZCf/qPJ0A66kJWBMCaAu/rSk6EVBXW+eZcFPZzf/Ery9msQ28dtwHIQ59lUOBmqU6RF5jUXDyZZdVJSDq5enDWptkQsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUlZ607y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368526b1333so2390013f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745697; x=1722350497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIOexr2HK5dM1ecCil6EL5sbgVo35QTVfvVcIKxiQ/M=;
        b=UUlZ607yV65uI8Gr6d01gvsaP+fqUHUjq7laCrSaeh+V4lggYCCEX5tLBvdqUeHNZd
         q0JKbXiYtd4lg+DiYWSs/VxnOaoS8+OyNzVeJpkw/s6OMGVy6ksTNDgOfwHlIdIFfR8N
         fA+O/pzfsrNmXZa+58q4rdZwNnkUt+qgjleAzQkVHj64qZ2iMi0TCSFaoYkb0GuMye/2
         F2CDfIB2dl5rpIBIHiZ4NVgnK/zM76lkgmL+Z1e5CrDzBaErhu7T7xaSuPXGjS+K7+q1
         unDMb0OGW74XXdAJaxKlY9CN5tleMhYXxjO6/3qGcMmu7/EV2EvZApq8VIgmRx9B5tcF
         n0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745697; x=1722350497;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIOexr2HK5dM1ecCil6EL5sbgVo35QTVfvVcIKxiQ/M=;
        b=OBx+BVgGpGkoxqMXyHKH37PLFq6/HZOJBFfX28iylkOK87L8mIOKVHlHlDpWz3YLo0
         RN2fMY5K2v4Ny0Jt2Ff0x3TmO05XT+APvL5JlsfOqsW9WFqq4Lh8rHHr1IVNLGwM2YyR
         cVJ1ULWZxhwLkrb4Y6hRDLBzz3EcBo1YEyLMDdygZ2wTPsqy14gDd4A9JZHwH+h5jSVT
         jOUobaX9CP53w5aAuWbBS/cDCz3TXNsu7CjxpTdFJ6AsCEJMiM0nEIJyu9RtR4p3B2Mb
         zgXN1U+nGV9L3D8uMtiCuIjgpD4TLO2o6td0wNVtiDWC5Po7gpCQB/R5iPVddbVvI9v0
         TURA==
X-Forwarded-Encrypted: i=1; AJvYcCXD5pqVZRirV2sBYCAyKomXE+gyMUlie2Mz2puJwL1grE23wjTDkK8XeG0LrdAb+f7smN6lQxdxu+orXpW9Q60on3tfp5L0/ej++BLy
X-Gm-Message-State: AOJu0YwufNOLAUg7Z7PlVor9ZKttglwK+wHcK8CiZxaDh1OvtP31uX2i
	G2CFSuLzro3pA/nDy8CcYpT0+rHZajmj/0R4FrtsMDeSowW2qE+n9vRPLhcCqJY=
X-Google-Smtp-Source: AGHT+IFPo5g+XdIEqYzhL4PIJUoZJy8jgWDPHXQqC/+9lVWbvrAPNGr37qJ8eSbuaPLMzMxmKNtB/A==
X-Received: by 2002:a05:6000:4021:b0:367:8f89:f7c9 with SMTP id ffacd0b85a97d-369e3f2f62bmr1803268f8f.33.1721745697448;
        Tue, 23 Jul 2024 07:41:37 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ebd50sm11670456f8f.93.2024.07.23.07.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 07:41:37 -0700 (PDT)
Message-ID: <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
Date: Tue, 23 Jul 2024 15:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240720074552.1915993-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/07/2024 8:45 am, Ian Rogers wrote:
> Andi Kleen reported a regression where `perf script +F metric` would
> crash. With this change the output is:
> 
> ```
> $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> 
>        21.229620 GB/sec
> 
>        15.751008 GB/sec
> 
>        16.009221 GB/sec
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> $ perf --no-pager script -F +metric
>              perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>              perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
>              perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>              perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
> ...
> ```

For some reason I only get the metric: lines when I record with -a. I 
noticed this because Andi's test doesn't use -a so it fails.

I'm not sure if that's expected or it's related to your disclaimer below?

> 
> The change fixes perf script to update counts and thereby aggregate
> values which then get consumed by unchanged metric logic in the shadow
> stat output. Note, it would be preferential to switch to json metrics.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> The code isn't well tested nor does it support non-leader sampling
> reading of counts based on periods that seemed to present in the
> previous code. Sending out for the sake of discussion. Andi's changes
> added a test and that should certainly be added.
> ---
>   tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
>   1 file changed, 93 insertions(+), 21 deletions(-)
> 

