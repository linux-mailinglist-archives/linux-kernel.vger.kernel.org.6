Return-Path: <linux-kernel+bounces-338346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08949856B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466961F25431
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F6156C73;
	Wed, 25 Sep 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPqx4QiU"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA314B967
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258077; cv=none; b=dLTVgHcjIMC7RkjCQOv8HA/A5saGETTY8JyLw1SjjxX9HOUFRsCULTfVm2sqPht2J7/I2RFFkhFN/7AYJpIlXhD8aUQDgU1XGmgO8dFRmjgfd29zGuTfUyN6FJaEosNCjndiE6QjcMo3xe2fvmzygKZslSkrt/R+SKutMD3srGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258077; c=relaxed/simple;
	bh=lO5nvWA3IV0Iv8VVBnsGuJGmzlaMsvskh9lAUV9JJqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/A/vLXG4GjfdQguzIP8kwCHtRFYQ26Dp8oIIONc7Y3wCDHGU7C5nEwwnLQEHcciAuEDVWc+LycL99S6tUphwVcnHaq3W5R6hHYj7VRgRhMTzqpWw8V0yvfZ3YJZ9Zlb5YwIVE2c5erkAtKpTPg1PeIwqwAcqVXlt2WLKt9xgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPqx4QiU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso856957766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727258073; x=1727862873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c3kM0IzFVsVh0k7OsrfG/XVq2zxRFxQYpJLz6JaIes=;
        b=XPqx4QiUNoGqBzBlN639xgovgk0oBHDpWFd0fW1Kz7/mkpBWgUZkEmFDtBWbcATFws
         H5YSZKp0TbAmfHhFo6YwQgtKQ99Pi+94KEvnahK5llOsClraxza5xFZehXa8b1zt2o/0
         apgOjTOVkY100F/bAcVDJJMYV4ieGEVL0ybkG3n70IiCU09hIVLuJTgbkRvh6nOpFpvU
         lZM3WHFiapz01ecAu0I8E1QnFJx7VNABNbcNYoI94+YjaYtvGpyuOVGTxMjM/AFAwVl/
         0xS8p+wwVQ858l6cswcF6Yj0f+ssFMdCmMCG/vFcCuEc0Pbig0RLYRhPFH4vZzIVl9VT
         v00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727258073; x=1727862873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c3kM0IzFVsVh0k7OsrfG/XVq2zxRFxQYpJLz6JaIes=;
        b=vEVdVNdnnuB6+SeeHi2bncmBQ1JmUtlP6VP3eY1FbA/KuNmHz2ScCr//+e7oKz3v/L
         90YfwIopC/wShUQ8DUXE4KUg8lpo6r5xNRZ/knN0/b3Mo3W+vxrmJbNIScsvakX+kGi4
         VBS98IdMK1wveNuQ1fNTIkb40OQoiSmNZ6FFJ32ESkDbrCtbAH0ZrL+uVaCCkBSXXEAB
         jkaWP5wgENMR2FlRdvlKgMtfnbUtzEZFPXlcrKL31oexPq7EO4I9ep3f45w75RzZegOC
         /IpBUZnx+4dgUQaAlziDNRaG32bJbLf6pEGnbUi9frQi43FRA19lnUDM1bKxnf+DgWm0
         ji9g==
X-Forwarded-Encrypted: i=1; AJvYcCXE/A0OWgsWrg2apTN3LZ9vluJO63ECM8JvanrdrGUAHaNo0gANzOG+L5IpCwz1Mg5q/G7PLNsEdaTKYAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5RNKGXLsEVw44Xfesn2rNtoQjmZdDoIaLrD5N96xdRB5mIkwP
	h7Oqb5Zdq4Gr86iMkDXeibORem/NSVwL6W+E9MvHmE1wpLEkzNazMcYIC7ooAOvqTtXst1aBjKp
	X0Lw=
X-Google-Smtp-Source: AGHT+IEpyaV+gaoylh/xL1CQdQ+o/9Q+Ttvzern9IGMVbjV8Si52qsVKFPQlQJ9rNm3XCOoM9X+n0g==
X-Received: by 2002:a17:907:9444:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a93a0325da2mr238677666b.13.1727258073446;
        Wed, 25 Sep 2024 02:54:33 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cad8dsm190396466b.101.2024.09.25.02.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 02:54:32 -0700 (PDT)
Message-ID: <5160d57a-3520-4d99-ae10-5cc539fba813@linaro.org>
Date: Wed, 25 Sep 2024 10:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: cs-etm: Fix the assert() to handle captured and
 unprocessed cpu trace
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/09/2024 12:39 am, Ilkka Koskinen wrote:
> If one builds perf with DEBUG=1, captures data on multiple CPUs and
> finally runs 'perf report -C <cpu>' for only one of the cpus, assert()
> aborts the program. This happens because there are empty queues with
> format set. This patch changes the condition to abort only if a queue
> is not empty and if the format is unset.
> 
>    $ make -C tools/perf DEBUG=1 CORESIGHT=1 CSLIBS=/usr/lib CSINCLUDES=/usr/include install
>    $ perf record -o kcore --kcore -e cs_etm/timestamp/k -s -C 0-1 dd if=/dev/zero of=/dev/null bs=1M count=1
>    $ perf report --input kcore/data --vmlinux=/home/ikoskine/projects/linux/vmlinux -C 1
>    Aborted (core dumped)
> 
> Fixes: 57880a7966be ("perf: cs-etm: Allocate queues for all CPUs")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   tools/perf/util/cs-etm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 90f32f327b9b..40f047baef81 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3323,7 +3323,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
>   		 * Don't create decoders for empty queues, mainly because
>   		 * etmq->format is unknown for empty queues.
>   		 */
> -		assert(empty == (etmq->format == UNSET));
> +		assert(empty || etmq->format != UNSET);
>   		if (empty)
>   			continue;
>   

Oops I didn't realize you could filter on CPU in report mode. Thanks for 
the fix. Adding a test to the end of test_arm_coresight.sh might be 
quite useful. Either way:

Reviewed-by: James Clark <james.clark@linaro.org>


