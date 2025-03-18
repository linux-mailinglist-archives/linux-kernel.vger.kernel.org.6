Return-Path: <linux-kernel+bounces-565987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C44FA671C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853E3A975C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E320896A;
	Tue, 18 Mar 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2kIatyz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE72080C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294936; cv=none; b=RgDJmnTaAZBZgYx+7Sc1S4jc79p5nPohJIiYCU1gDvkGzfCK9HqSkr5CkJlWox7LNlUfnY2n0U4Qo9/eUy/heHoFoxMVFZ6uayi14WbjsWT/NBcZvqluBh4NWsmnMzMPShNz1tA0i5ZGdz3hUYgy8mh+Oe+yrYTGlomz2ArOCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294936; c=relaxed/simple;
	bh=pt+AzFr25YDmPiKxl2+sQZis/uOxw8aRE/8RDGmwdqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6uoyJvo1KQYWsQ4raPIRDTCDWbnfr5RZlYnCwQSsFnBBjJJw4Gm1z5kPMNC+pQJ/E77fNVOtSwpTRCqVhPCDDfLErLYaNJ7WF+Npz5vG+BH9yAAqhkusMkVkZ17wn87SUYPEgt9xyaUIjvL2QMPQkRIWHafp7erZGtalvP5Wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2kIatyz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2896395f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742294933; x=1742899733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57utoSkB2MWjRDZuFyIwHMOM2c+jS/zIgSozsuMhHC8=;
        b=K2kIatyzouKFUmH9jas4J4ehBXZ7p1WNSkX2Wl9rcvVg/jrwL3/oGhtZFk4z3egS3o
         1JvJsv2znQtj5jdkbD4QyOHY4YYBslP+Ha0xphduNf9PtkJTkYQw2ohDfmvoO5PStXiw
         GJB2uxIIlplKxZInZagQKJbIZEXTuXRgd0CJOrNCIFWw165PvYMVgRHA6gT/LQD05qZH
         aObRUj4vwdELBtm3thZpoN5251KIGWndItHDbNH7UvzHZephGW8QRvqnlnWYUKZMPeix
         AE+QeOkQhEYCvwYu54FIOIuE38p9zpNF9rOvbGX4E4lJmvF+A4XnQzhPHHXFMnj3761s
         o6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294933; x=1742899733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57utoSkB2MWjRDZuFyIwHMOM2c+jS/zIgSozsuMhHC8=;
        b=KN3CPuUqJNZ/on2fhPCp5L6Zu1tNmXQzwvar0F1FHlQpebfiw/Np+ngSCK2/jK9oZy
         mcx4AJqF1+n6E6jgvRNbv0kffzrAjjRXfBVknztCnwI/rOIAMnsXvQcqN6ZA87Re0pfu
         8gkxN+VLDjmxfuB6j4aQEjn8FR0X/qLu/MKOP8aIse4u6xLUptR/30L1sn+atmybYSde
         poabBZmxXy8UrHUi4RmCBczBagnUV74yw7oTiL0G/qPn8VLLBnOuymmxiIR4tdpBeMXN
         XnAhAp5XDGNLE2k5oKg2SAMfBMMQJpm1ALEdAXzAIMafw0WT1zwfkwX7draEykg81B+/
         BduA==
X-Forwarded-Encrypted: i=1; AJvYcCVm1uHiapuJK/SrGrailS4s7dq4E1uNJn4jeMWCMPS4EWyTxdwdg5XFARoE+D1t3ckqhWjXEHzBtwj473E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDcWcjGaG56vpVOiLmob8E3BpMeWzPDpEZyw3a2p8Gxjjos01
	wgTVE0GhEESIOogkky5raqCbMwchtWruONedZYzBCz0S05JWWm6zofofENs7npk=
X-Gm-Gg: ASbGnct2g87y1Gv13951ym4N98YBI3rrEwHgapCYRyuMhFKx03OnE3kA06GGXodxaDy
	YrtS/DsLtQBysIs42vuMwy59TQWCgWxwu82s08KRXXqC1CA1/z67eAyqrXQ2Yw/SdBMEOl7nWpb
	SE1FSt12GnU7A64v6NxlTb+k4Xly5ptWHio5XlSKayIBgJv5WVXHlCSP/hOTFZd+FrIc5Tjno0p
	D8xLoO9FiOwkn+oq+Yvda+oWNffmmz2h6W8TdDjDAwIapbep1nDSMoxTYtdqQeDtcH5gRYVEqVu
	tc7m1tar0X6XtV4B819Nc9wWyRxH78fUaHHcJXbhDC0Vg7u+kMTpGQ==
X-Google-Smtp-Source: AGHT+IHPMxFmuHJUzKTFKL/MF46GBaJJT63dHFiZEkBnPXwgw4S7oW5rMJ47Bbnq0qrrRrKTBwKCKw==
X-Received: by 2002:a5d:64a9:0:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-3971d03edbdmr20966967f8f.2.1742294932771;
        Tue, 18 Mar 2025 03:48:52 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d21d67819sm124534785e9.21.2025.03.18.03.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:48:52 -0700 (PDT)
Message-ID: <9fe071f9-27bb-4694-ace5-f23eb0d0e50d@linaro.org>
Date: Tue, 18 Mar 2025 10:48:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf vendor events arm64: AmpereOne/AmpereOneX: Mark
 LD_RETIRED impacted by errata
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
 <20250313201559.11332-2-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313201559.11332-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 8:15 pm, Ilkka Koskinen wrote:
> Atomic instructions are both memory-reading and memory-writing
> instructions and so should be counted by both LD_RETIRED and ST_RETIRED
> performance monitoring events. However LD_RETIRED does not count atomic
> instructions.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json | 4 +++-
>   .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json  | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> index 0711782bfa6b..13382d29b25f 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> @@ -1,6 +1,8 @@
>   [
>       {
> -        "ArchStdEvent": "LD_RETIRED"
> +        "ArchStdEvent": "LD_RETIRED",
> +        "Errata": "Errata AC03_CPU_52",
> +        "BriefDescription": "Instruction architecturally executed, condition code check pass, load. Impacted by errata -"

I think this could also have a 'Fixes:' tag, either way:

Reviewed-by: James Clark <james.clark@linaro.org>


