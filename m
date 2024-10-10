Return-Path: <linux-kernel+bounces-359181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A386C99886B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F27C28293A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FF1CBE84;
	Thu, 10 Oct 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulp3W3BW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B001CBE8D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568445; cv=none; b=NiRDQQkAJWZDrtBA6W8UjDrDOGK8oirkd5CVCMw4sf1ZRWz87d35FdHNTo/xjTk1CwTyu0nHBOpS8tnljlrMToWau7NDGOS11bu6v7Rgdy916a936LPAp+vYcWKX7CRYClCUW7Lvf3zI1FL47oQfC/W6G8RPUzDsSsjkjZDTq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568445; c=relaxed/simple;
	bh=dTGt2bI0gyh+oBaFQS/4t8rtm86wQQ3TxyuWTkzVfZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=lMbE54dDMoY5Ld8LXMnyAqxVkAdyrY6P/GHRWKg7cDLbNMP7rIhGnrVs6XS9NOWzU9eqL6aWPJr1+NQ1ZHrXPnMrBWjv20OT5y8iaceTwBizRmzL5HmNCnZzRIFd98gWUwheg20r2gFpE7xGF85z4uYMfICOV3uhf1SxS1DW90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ulp3W3BW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso2836935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728568441; x=1729173241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQ+lXA1ihTUNLFfhxZGOzBQbePHSGXZjeXL0lolEF3I=;
        b=Ulp3W3BWvejVKJHOQCiKTGV2HerPmcOjujJN/05yBf7xxMhN7U5QkexjwNW3N7YIWJ
         X/lKaJRM6Yas22BTbqUJbY9D32ok1Cmfk2iEy8Wuc7gnvIElNBgWFPEJ5WmQkmF39oQL
         2iU3kgOEKRrpuHKwARbhYlymZh7mMrBRMcvZSgoMHVXYyt5bh8XEEUfkZL4j9Jx51aba
         agHOsbG+CYyDRZsGFIkABLyuo0ILf2B64DL1bOWiXcRCLa/8OpGoIO43HI9haNdVqnq7
         9IYCMYwmVbr4VUdxRrj/8gxQBUEQDnQsCt3t/VqF9hO2/WZbgN/GCTvcnuW3ckWnMaXO
         CcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568441; x=1729173241;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ+lXA1ihTUNLFfhxZGOzBQbePHSGXZjeXL0lolEF3I=;
        b=U1qKF6TvRqR55HPUDqXTub8UY5JbM0snHQ8lV7NI2KAxvitIunKF1S1LxDvtLmdyk6
         V6pAvVUJTPWy7fRRtqiumAYa6GsRCPNExVQi+mLVEwJZYWMCjvotlZ28ZEcaDAEtUmk7
         YYssvnvZld3aSlqHfBVJr9Ga9e+H4SI3ppGWKscPBSzL5v5A54uiu5wCJ4ukEJvxny59
         1wx+nLwFaCaznOaTPfMQ53wRLlE9bMb55zoABXJfYLV/8WM2G2HTFKk/H2w+M7eNLhdk
         V37y8ZPOJTPumZeCEq045aTk/+2pseYLOjnUtyrWHeh/vtS7Zx4GXYEupnoiFN1fG41o
         CEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQAG339NyF0vRv3ut3LX3GrXucJEe3Y16l80YiWtBIsmkqHM6Da2VtuyqML3BHpdzD6BC4p+3712yHzEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0r7yU6td9le5IaLLXoDONoNk7ZAQrdT0lipr4HKmwbGUoo5w
	l+nfSKeRj3cD56UVCE1pEVoSt0Mn9CU1GzZE5tL8da0Hg1VyIksjDVIPs1NzVO4=
X-Google-Smtp-Source: AGHT+IEdRXm02gGLxzgcUClMQgQcHA1G5Jkg12qeADvg1mlzE0X3heEKupNW6VgMBZK9gKBRD6jzJg==
X-Received: by 2002:a05:600c:444c:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-430ccef633fmr58186915e9.3.1728568441321;
        Thu, 10 Oct 2024 06:54:01 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd03fsm1622763f8f.34.2024.10.10.06.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:54:01 -0700 (PDT)
Message-ID: <58043fbb-81e7-4cf6-bde3-0464df9f6050@linaro.org>
Date: Thu, 10 Oct 2024 14:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf arm-spe: Refactor data source encoding
To: Leo Yan <leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/10/2024 7:53 pm, Leo Yan wrote:
> As more Arm CPU variants (not only Neoverse CPUs) support data source
> encoding, they share the same format for the data source packet.
> 
> To extend supporting these CPU variants for Arm SPE data source, this
> series refactors the code. It converts the Neoverse specific naming to
> the common naming, and then based on the MIDR stored in the metadata to
> decide if the CPU follows up the common encoding format.
> 
> At the last, it extends CPU list for Neoverse-V2 and Cortex CPUs.
> 
> This patch series is dependent on the metadata version 2 series [1] for
> retrieving CPU MIDR. It has been verified for per CPU mode and per
> thread mode on Cortex-A725 CPUs.
> 
> [1] https://lore.kernel.org/linux-perf-users/20241003184302.190806-1-leo.yan@arm.com/T/#t
> 
> Changes from v2:
> - Rebased on the latest metadata version 2 series [1].
> 
> Changes from v1:
> - Dropped LDS bit checking in data source parsing.
> 
> 
> Besar Wicaksono (1):
>    perf arm-spe: Add Neoverse-V2 to common data source encoding list
> 
> Leo Yan (6):
>    perf arm-spe: Rename arm_spe__synth_data_source_generic()
>    perf arm-spe: Rename the common data source encoding
>    perf arm-spe: Introduce arm_spe__is_homogeneous()
>    perf arm-spe: Use metadata to decide the data source feature
>    perf arm-spe: Remove the unused 'midr' field
>    perf arm-spe: Add Cortex CPUs to common data source encoding list
> 
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  18 +--
>   tools/perf/util/arm-spe.c                     | 135 +++++++++++++++---
>   2 files changed, 121 insertions(+), 32 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>


