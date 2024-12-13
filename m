Return-Path: <linux-kernel+bounces-444448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4109F0703
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B68516AA41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC21AD3E1;
	Fri, 13 Dec 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqMyYdLV"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E31AC884
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080160; cv=none; b=O0RE9FxHPnAX508yC4V60v5QA28K8BnRtJJY/Ir8RGBAok39Uk2qp0Mq2BJ6Inq23uug7AjWaMX2V6PPUihOcy7k1kCluUwvx06+4a3CIlSy+QMScd3cksEVZWemSXGd0vpk6dxlWN7d7Ws5btqi2JjC5OZRdlrmVDe7mW617hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080160; c=relaxed/simple;
	bh=zuQ9erM/M7iamaeG1a0jdschC4zFf+4bb6dpc5Ri8MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OdhXwRG2D1rI3tGc+Da/PgJ6yQgepIUmXs5DjYb1wQy81hig7BKXG2uDhbXIweL194K8U/HJhLbTFrYek5KdYshNY6OvG1vcmX9F4mrwSN6yhMjvdYrCaWPND5AmLY17fTSQTBvQJwKVOjH9bL+EYnjuWNE1hGxUsnbD9xjdeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqMyYdLV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385df53e559so1179430f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734080156; x=1734684956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qo5joHpywoWkkY4oHnkKyLPnalkuQ0udmboD3kZeQwc=;
        b=nqMyYdLVXMgIbPrpA1xc3pjWBrof8HojwOB2hmAXesRvW0xkl1NuSANk9NE6JDpS5a
         HqydzOyZI14MpMLZj4uDv5mkPqFhtJNW/Dv7H9PFP2tHsGecJfZGcEnhyRd8mGET1N1Q
         LRJbnm2OFEZ0jC9LMpkDEvxoX7GnPdtklQSHf1JkcfuF/aONeBsIW2VUx5DvEdPl7OcN
         fDjMyIHdDonGBqEtKUlrwjMmt8MmVgvbgO3AvHA8yTNtuRoAO7bRcgWOWh9OS4/L6p7U
         fPEbSQ15r3BNcPvD4yh6Xo5Z3VFcAFobTvz9HVPJSaIkmpgjFmDGD20spMvPLUBp3MkK
         jIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734080156; x=1734684956;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo5joHpywoWkkY4oHnkKyLPnalkuQ0udmboD3kZeQwc=;
        b=Bs9vrHxIBsPQ8/Xs5QhcWBLuuPDa5GLs6Nqtq5XA0vHlyyMQZXmhHFmWzp6wb04p23
         80XVCNBEZACLebt6KNzfEwT3MtZwU1DakAAoFwaM6wkQ0pjqJP+EysO8a9zREabntYuk
         V2AcsuVA4Wp34YstrmKnzUSRZn4z6+BwUKk5kY4aa/VVfMCgdD53Aua/mnf7IR5MHGAd
         ZwsaPGFoehXqIR9XN1FJPFacAkIxC1yu6u8hiKD2UnFkyR5LS0o7mjzzGjYTscVg4jaX
         HTRXNTS2PKUc7scnOlFmoUuuZMSrISfVqKskrt2WKf1I5/W7FLdDZ7yAmqg30fFG6l/r
         RkiA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+OR/oPYcn128xF2PvaDDuqG6sfvCi77+tOgO8uffxc7+OpAeRoIMH1YmBFbdl/qXnp+efnFItdv13ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqjK9UoZNZ7ANp3mUQ20ytXSVPvuAezG7e53uLHD12CAThyCn
	4Om0oxnp0GKj+Wsz+/i9PxxyQcojiMD+HkBf8Co/WaR+pmejyb1PrjYh79SB4aw=
X-Gm-Gg: ASbGnctbDIV7RvSXRfJod64y+AzjdXCIKSqOGrSGL1xLSOumlEQQbrA7309viGIn1+I
	X03ewxvTyapCYyHZNJhccdsuGVAH9gJIc6CK58/fD8vJrQ8RfcV0bALmDjFA4yyH/TLpLf7UKB+
	xLH/un503l5gX7VdfBVzuakS6e364S76I1QxVN53eXvdL0bbwmywaqQ3nBKYh6CDUDC2Get/h08
	UgxcYkICRknmEkOL2Qtm0CTTcvRafZJlHv0hHL2pSxxIy9OE+lYz0MtyoZPjvCZlzk=
X-Google-Smtp-Source: AGHT+IEBDJYGw1/kWE2/O+7h0kWTVQEwTh7YcX/i2A4j0wGBNbQhCx2OXIG9Bc40eck3ojtIUm7dwg==
X-Received: by 2002:a05:6000:79e:b0:386:407c:40b9 with SMTP id ffacd0b85a97d-3888e0b5f39mr1003378f8f.28.1734080156533;
        Fri, 13 Dec 2024 00:55:56 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b44f4sm42190725e9.30.2024.12.13.00.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:55:56 -0800 (PST)
Message-ID: <56bbbfea-ec52-4f2e-a402-57bf59103416@linaro.org>
Date: Fri, 13 Dec 2024 08:55:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>
References: <20241212173354.9860-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241212173354.9860-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2024 5:33 pm, Ian Rogers wrote:
> The cycles event will fallback to task-clock in the hybrid test when
> running virtualized. Change the test to not fail for this.
> 
> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/stat.sh | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..da42427bb077 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -163,7 +163,11 @@ test_hybrid() {
>     # Run default Perf stat
>     cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
>   
> -  if [ "$pmus" -ne "$cycles_events" ]
> +  # The expectation is that default output will have a cycles events on each
> +  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
> +  # can fall back to task-clock and so the end count may be 0. Fail if neither
> +  # condition holds.
> +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
>     then
>       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>       err=1

Reviewed-by: James Clark <james.clark@linaro.org>


