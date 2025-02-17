Return-Path: <linux-kernel+bounces-518041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C254DA38900
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969221687F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB46224AF5;
	Mon, 17 Feb 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgInNHpi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E690224B0C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809263; cv=none; b=A1lMJkte+Y670O4Y5ghEva+6487F47DIOd7NaSH0EMAjIYOMG6eLI2zeFMgQxijIseJdzRoKEcz62UDpaANxzmND9IOZJkL0JBd1NrImf0D7Of+UjIes7Xo6dVivxEHXSsscr/ELhE9SPkEh2jCBXZVIlXYDi7u8KPkgNa3e9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809263; c=relaxed/simple;
	bh=mMQiqIZgNYnfxi6+lZiIaD/Lw2SsAOZGHC7m3aM1XaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jVmWcM4exRu0SIhhnPMybCu9SRssqb2nF4CIYb5S2tVs0daJmgjTf7dzO7jy3PGBE7KKrbhtu0mNL2WSJvDm2fouFgl4qsXI1LglnpUMbxCQYNhqvWcAJTxG1p3XEzjh0m0pSPOpXH4olu1q6jNmuZ3MBqlNsp4CH9o1CPeIjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgInNHpi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439714a799aso20300365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739809259; x=1740414059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hliszru8I65AnPHW7tmPd8zU3hebz8wd15dEVYUIRXU=;
        b=YgInNHpiFNWy046DAIzsFlX7oAvuTXVldv5+bbfaQs8v5OM/jmB7yXaWFD+Z/C6QMd
         nBYW7A3G+oI8p5HGbCuGPGeEDysfiBu/67974qScDilyhwE8VuQrlH66xmWlIR1Q9048
         76ABH8bNbzg6bp94N5Y2oRwjjTAII+K0ghadmyAbUNGh5sCZM6wnVVb3JwjDE89j1l5/
         gKX2GDWycz/hQDG0tmwWROsZHV89P4LjHM5KBAQFAhjZShxUWclrtq6qxBpImuv+3jKo
         yzUpdRWwNk97RwKnKOH5u1Y1tMYXbZonQ0IMzjXQaCbz+r2jEu37vQhAZ4oXOaFKUN7R
         Z2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809259; x=1740414059;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hliszru8I65AnPHW7tmPd8zU3hebz8wd15dEVYUIRXU=;
        b=LgiKt7eiY1wAd2TyBFpbuQ9vcKZcY0MHywKH6Bj5iuCxuGtaxBns6WMxwEyzTHd4bv
         7QQ67nuHeLgnfB6ZDQelFepqX0zIVe4ecVF50mLDfG6N1yf/pDDZAIyZ17bn8VGeBaGm
         O2xum90pGifQm60hFpRt3ITHZLVM+6gRdIiUdCghX/4NkQd2J3Ln5tkvg0eQXC9LScR7
         w+r05hAf+L/ZPx/BfyRaR8R1sI2+ZHRrGfF6Flg+kfNiWEm8xSJPFwTox71JVKHTkXiZ
         R1T+uu7bx+lB5TtMDGRoLWSYeePPOPynUKXPcUWyLj6sjd5+NhRAFvw9Jqe1oloSeEKn
         X9NA==
X-Forwarded-Encrypted: i=1; AJvYcCUkJkEbSk+TTiNkOg0p6fY+7EyZzfsrRmmjlkII07tqFsWFSr+FnRQ/tmbcsRb7s0pDXwZIzkvEk0Zal/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZZ5IH7R2wzTZWzBGnvsSUAu8kIzAuFiPVIzM/wuj4mqrMo9c
	iqvRMtycU2hqT2KtXmhNSqH9B4PtJPRL6431LCzw6CrehhuUxBj8YvlWObR+3dU=
X-Gm-Gg: ASbGncuqsv1TL3MQxyn8/N2xfctcTimuDOkf8Jexlt2F6uHufpxiPPwVM7rzsLoEdhi
	ETDqHhcNfj5V6Cnt21rR2voVZbxCmn14tcgYXN/WaF/VS/AWuDLMEacDgWkznkBFQ0hKy8hFF9i
	RHx8FW27Par1s/BxKHlVOMbtk96IksJiZM9sCsmkTE8ZrfhOcKy8De+5O3eGfszCjLEqX6sFqaF
	kTi0AwjtvYBWWjGMF+xZ/YnDKo0zvhApfcYO7l6/lZXzSfOXzRSITn8f3fzU8ZSJOx5WTTs0ZnQ
	BSem6GCSHM5pU+Hdu0+klYgr1g==
X-Google-Smtp-Source: AGHT+IGdNrAgcV9AT4395Oyj88ssWQXJfojFnIpoXQA8wy4Csu5ENmq+Sh9avVfhPt2Ol9bspdhIfg==
X-Received: by 2002:a05:600c:1d23:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-4396e6df8bemr92447005e9.17.1739809259341;
        Mon, 17 Feb 2025 08:20:59 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d22csm157199225e9.22.2025.02.17.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:20:58 -0800 (PST)
Message-ID: <a5d99e7f-1d8d-41f1-976d-7d67a0d5decb@linaro.org>
Date: Mon, 17 Feb 2025 16:20:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] perf arm-spe: Fill branch operations and events
 to record
To: Leo Yan <leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
 <20250214111936.15168-9-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Graham Woodward
 <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250214111936.15168-9-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 11:19 am, Leo Yan wrote:
> The new added branch operations and events are filled into record, the
> information will be consumed when synthesizing samples.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   .../util/arm-spe-decoder/arm-spe-decoder.c     | 18 ++++++++++++++++++
>   .../util/arm-spe-decoder/arm-spe-decoder.h     | 10 ++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index ba807071d3c1..52bd0a4ea96d 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -207,6 +207,18 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   				break;
>   			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
>   				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
> +				if (payload & SPE_OP_PKT_COND)
> +					decoder->record.op |= ARM_SPE_OP_BR_COND;

I think this results in memory events being synthesised for these 
samples because of a bug in arm_spe__synth_data_source(). 
ARM_SPE_OP_BR_COND overlaps with bits from other packet types like 
ARM_SPE_OP_LD:

	if (record->op & ARM_SPE_OP_LD)
		data_src.mem_op = PERF_MEM_OP_LOAD;

arm_spe__synth_data_source() needs to only interpret that as a data 
source packet if ARM_SPE_OP_LDST is set. This was reported by Mike 
Williams but you have the privilege of hitting it for real first.

> +				if (payload & SPE_OP_PKT_INDIRECT_BRANCH)
> +					decoder->record.op |= ARM_SPE_OP_BR_INDIRECT;
> +				if (payload & SPE_OP_PKT_GCS)
> +					decoder->record.op |= ARM_SPE_OP_BR_GCS;
> +				if (SPE_OP_PKT_CR_BL(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_BL;
> +				if (SPE_OP_PKT_CR_RET(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_RET;
> +				if (SPE_OP_PKT_CR_NON_BL_RET(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_NON_BL_RET;
>   				break;
>   			default:
>   				pr_err("Get packet error!\n");
> @@ -238,6 +250,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   			if (payload & BIT(EV_MISPRED))
>   				decoder->record.type |= ARM_SPE_BRANCH_MISS;
>   
> +			if (payload & BIT(EV_NOT_TAKEN))
> +				decoder->record.type |= ARM_SPE_BRANCH_NOT_TAKEN;
> +
> +			if (payload & BIT(EV_TRANSACTIONAL))
> +				decoder->record.type |= ARM_SPE_IN_TXN;
> +
>   			if (payload & BIT(EV_PARTIAL_PREDICATE))
>   				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
>   
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 4bcd627e859f..85b688a97436 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -24,6 +24,8 @@ enum arm_spe_sample_type {
>   	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
>   	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
>   	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
> +	ARM_SPE_BRANCH_NOT_TAKEN	= 1 << 10,
> +	ARM_SPE_IN_TXN			= 1 << 11,
>   };
>   
>   enum arm_spe_op_type {
> @@ -52,8 +54,12 @@ enum arm_spe_op_type {
>   	ARM_SPE_OP_SVE_SG		= 1 << 27,
>   
>   	/* Second level operation type for BRANCH_ERET */
> -	ARM_SPE_OP_BR_COND	= 1 << 16,
> -	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
> +	ARM_SPE_OP_BR_COND		= 1 << 16,
> +	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
> +	ARM_SPE_OP_BR_GCS		= 1 << 18,
> +	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
> +	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
> +	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
>   };
>   
>   enum arm_spe_common_data_source {


