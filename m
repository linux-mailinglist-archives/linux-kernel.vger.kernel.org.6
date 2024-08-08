Return-Path: <linux-kernel+bounces-279294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224DE94BB7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25381F236DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAB18CBEB;
	Thu,  8 Aug 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIK9K2KT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D218B469
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113614; cv=none; b=YtI7QZGnlZjF5hLOwEp45z41OfM3SGgtSI5gbO5ucG6GuGx3otkt4+eOxTlmuL2YwcCBU5D3SqIm58oqDRn9RasV3kRNq15lRZEQ7KkaimfvdTFbj6JoMdA4scdUhsvagMzO5rQ4fjcW0xm+GV2+Lxv7g5L8mJ862KnFDz4Cz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113614; c=relaxed/simple;
	bh=93EvhuTl9ahqB5emxkAMtf9z0ofEgXEiFiod3siNX7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3df49XfbSV4/rQKGXAynE3nLTu0AK4AagwwNz4GVbYsvTkJqwBYgFAgWtPIOqkigHNXriGcnz7m8sVUyR6uw0KmFLN+lSBZjf/xKYWDUur3EksKjU+2P1omXkHOPcUv/NmqlMdVRii275vTKFUq8iRGYjff0wj1oIvfBPWahes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIK9K2KT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso5343295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723113611; x=1723718411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Vywnv2khWwNnQXbEb1k0L/IQrqUeraWcCrhITh2GYs=;
        b=MIK9K2KT8LuLBxskCnDtBcQbyvCV33fYpsicldzOmBRoBfJkMrDJm0eAwESrD3Lme5
         oFOPzOUkBAnEz7NtiUMyY2GKx/x0Sp6xoR60r13hH8VpceEk3rViglWH7Fyt+SZFdPco
         wcg3ea0EPgj/mWKJhHhMr3zsUIi8LjwfPklpSobbVcghlw8SunHvJo2pC8CE32n0HAQj
         3KBFYKE82mWwH6+5ND7fvDdXak+6RyXkrqvmdLDsdMlreKdkcCYmhcRtARojBGkLmwu9
         rTdQkqSs8T5MsdRFdCLGbvRTBtG8TInLN9vUS8JqzuoslbTnaSI0ZaxA64XegpqDmWN3
         /gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723113611; x=1723718411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vywnv2khWwNnQXbEb1k0L/IQrqUeraWcCrhITh2GYs=;
        b=dnindMq9hsjsCOmOxm0/cewZr9Wn/6jv5PRzi7sNQ57D3JSkWSAL2MsorXJflYyR8y
         0kcGGbYH+OR4rdWWvo5ONlN0ubVNRhgcKmDnooF9lI70evFPAlOas3SkbFi3T1O5Xrx5
         p/JvmX+W4F81xetNlaLkQez1RpIodFQbG+cerYZyzu6k4yT6mqlPiLnZFkNRQPMAs6xa
         wxO6tUgOtsbTnF5/R6YocXXHbeu/n7kesxJH2x/ZPMtpEq3/1cu5JOU1MtwOjtziGcNH
         dQ+5Y2azfLJoMv5okYwJCSSP3ZHhTaPfS4fZkCq34K6xgcLvuM1g1pDOq1k+OQ/XWzm+
         MqzA==
X-Forwarded-Encrypted: i=1; AJvYcCXnqTmgv2b6QL7WE64zmB+OYy6CIfJfbYO44Ot+gb7hODjpxZj1rNJFob1/26oIWf+pXf6s+A4+NqL0pkAZrAZqs9e8Vyxxvrr1Wi4Y
X-Gm-Message-State: AOJu0YzKv6U71W3udPTEZe0lZoWVLfZC3eLOZ7t4nuzRvBrrlpIr9W1q
	cr8KZSjOEVPud4frAkPUJ3iFrMkv8+/NZ/BE5F7/6O5jhFuDaFi0YwVr7+zHA7c=
X-Google-Smtp-Source: AGHT+IEGxZsKPo0MfhXCCFxSfCW7K4JInkbw4e4NnCHx4wlQJHciyyD/pmRe1wNjUVMP3CXg9q2VBw==
X-Received: by 2002:a05:6000:1007:b0:367:9614:fb99 with SMTP id ffacd0b85a97d-36d273bfaf4mr1044354f8f.10.1723113610569;
        Thu, 08 Aug 2024 03:40:10 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271569d1sm1459252f8f.18.2024.08.08.03.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 03:40:10 -0700 (PDT)
Message-ID: <67ac1ce4-7d95-4215-ae49-c32869bfe6eb@linaro.org>
Date: Thu, 8 Aug 2024 11:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] arm64: Add support for Armv9.4 PMU fixed
 instruction counter
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>
References: <20240731-arm-pmu-3-9-icntr-v3-0-280a8d7ff465@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240731-arm-pmu-3-9-icntr-v3-0-280a8d7ff465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2024 5:51 pm, Rob Herring (Arm) wrote:
> This series adds support for the optional fixed instruction counter
> added in Armv9.4 PMU. Most of the series is a refactoring to remove the
> index to counter number conversion which dates back to the Armv7 PMU
> driver. Removing it is necessary in order to support more than 32
> counters without a bunch of conditional code further complicating the
> conversion.
> 
> Patch 1 changes struct arm_pmu.num_events to a bitmap of events, and
> updates all the users. This removes the index to counter conversion
> on the PMUv3 and Armv7 drivers.
> 
> Patch 2 updates various register accessors to use 64-bit values matching
> the register size.
> 
> Patches 3-4 update KVM PMU register accesses to use shared accessors
> from asm/arm_pmuv3.h.
> 
> Patches 5-6 rework KVM and perf PMU defines for counter indexes and
> number of counters.
> 
> Patch 7 finally adds support for the fixed instruction counter.
> 
> I tested this on FVP with VHE host and a guest. Also ran kvm-unittests
> in Arm's kernelCI.
> 

I ran the Perf tests and poked around a bit with PMUs and chaining 
events (on non-fixed instruction counter hardware):

Tested-by: James Clark <james.clark@linaro.org>

