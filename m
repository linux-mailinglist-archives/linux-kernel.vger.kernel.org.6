Return-Path: <linux-kernel+bounces-533976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FFA46101
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FDE1709D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992718785D;
	Wed, 26 Feb 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLmShJcn"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF821B9DE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576796; cv=none; b=Bkc3X+LssVO2eE8JfXh9T0RhGzbGAEvYVPk8pgOE5Zro4C6xq2nSzFAZyeSqy18zt7BrpQw9NEaGDWKKvW6MUhX4vWYQUTGJ7STvnNIEQctPOQCzsnL/+eikhqbeGDkU1BE59ayWuP3wNfKh3ljCsj5D8PBVmVlPK1OrYF91plQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576796; c=relaxed/simple;
	bh=4S5ii8vpsdzR3GlUzVYFWg/lI8juhZxOyAULPAaLmhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MX/8o9aYigpQrgEoYMnI/lQ4DxfJg6DcbYA2UdNxXULj7xzKHed/jV4157KhAkr5imVdx2wXnWpYv8j7K6UE9Ar8OMMRG7a67evqUwJ1oM87v79apwTr4QDVaqRl+4mE1NpjrJ24/Rfsw2F/STBBp9uA29epk7FGOJ3IDF88f9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLmShJcn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso5524140f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740576792; x=1741181592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0AHsRBeWrg5AIl4T2vlSKQMrg1QVH5JjtnKAUlo99n4=;
        b=OLmShJcnzQIBPSmtNW5bgGi2xsWWZx9jtVB0Aw8esi/nvT6oBuQlB/mnTRCRxhrCmh
         FnorDcR4Ki1G/xbEt0NV65fb+4k+Blx+qt1IzwLR5RXLBHC9nb7GAZggYbhsAt0tO9SH
         V5QkKIt3oIXYegJCmmB6bpRQ5XC8GDf+ok1KZWK92Qg2FaXG9JTE7bC1yIAgeGCJoXkb
         p+fZs/dOaJ9vRuHr/BYZSl/LnVSaOWKDw4njcHztLABSJMQ28VwwEhXP2p4O3u9DonJg
         gTtUHpsa7zgNcCpWJRRf6US5Phr+iDsCU1TcZE25Lyj1eWr9AMfU2HY1EYLuSfL1s137
         zlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576792; x=1741181592;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AHsRBeWrg5AIl4T2vlSKQMrg1QVH5JjtnKAUlo99n4=;
        b=Lq3gm0MXj9y9z/GaSdNjv6punOAaIeGCqxhwO6fvWxDWKIfKm5wKRdbBVspaUXCo4X
         +2Ql19Q6mSRxE+8Lz3WdhCv31Z/FDvJqMF1VfcW3uMUtbHTXeTCpUMULYwYvs/weD3Z3
         fWaHwY5IHK8PUB5uSVlJ6SkK5lSp94EEs+qOFQqscwc5fN+4GisSmsh5x1MWGenWpekR
         6ekUR1hlk6UHaWgo/ZUWZD6VFqVs1qb/Mhdw7IXjcwQussydr7QuV6VsUiQu4Ex27I4X
         io9CqS4UyLM8f/Po94dJAGq12YUS2+MMSUQO8BeQ371Dnw1zJQrFWNDXDC56U0qnNXqF
         J8GA==
X-Forwarded-Encrypted: i=1; AJvYcCXrOTB47FPG6ikmZos/jy5MAOxyKWdVhoPbw8ALnRFHB8OhTPn2OgLd0mp4lY1eK6A3wRozuMOFmrvXlHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8lgbCht6DqfOPGCivG+by7+77WVJ3/CGPR36sMUu0CGAoub5
	shXnn6nohRblbixsKZ2VvrtZ+9nXVWBGPhjMcr0HgB5VfSarYcwTCyP6T5bmGsg=
X-Gm-Gg: ASbGncsiYRTWkfbFBbu8gBMv2g3EfdK2z+A74A2yzRrbTJYhE7nP6lFjaAmqnC3PCkG
	0z5Fr1mq00nuxektzwbBRHMoF9DhLkTIo1SsdQKUdM6gBGq5Xuf1Se85ckmKPkonN1gZ2yVBPkv
	TLoJ+n1EGDNmHBPjlzlWPxnIIm97YnnfAcnlOVqbFqoVGElqK6m8t/gLMLZwil51XXqcpR21571
	RY2hUY3TH9tpzoJyH7WW71B67IGVcvilkAOgWhJiNXQCUVM4BFAZweMYHObdRJU6CY0fvdMwAvv
	gXx1NwdgEVzBQOZwGR55iOoKzXYJbHsOwg==
X-Google-Smtp-Source: AGHT+IEMwTnaV1lxB24cLJCmw9AEkuHApONnAq+Ctb9Vrt09pWCW31XxqxzLWZRAu38Bw7cikwZPiw==
X-Received: by 2002:a05:6000:18af:b0:385:d852:29ed with SMTP id ffacd0b85a97d-390d4f8b520mr2586635f8f.36.1740576792150;
        Wed, 26 Feb 2025 05:33:12 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882a37sm5699140f8f.51.2025.02.26.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:33:11 -0800 (PST)
Message-ID: <e7fea60f-dac3-4762-9139-cf096d7bc121@linaro.org>
Date: Wed, 26 Feb 2025 13:33:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] perf arm-spe: Fix load-store operation checking
To: Leo Yan <leo.yan@arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-7-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mike Leach <mike.leach@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>,
 Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250217195908.176207-7-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/02/2025 7:59 pm, Leo Yan wrote:
> The ARM_SPE_OP_LD and ARM_SPE_OP_ST operations are secondary operation
> type, they are overlapping with other second level's operation types
> belonging to SVE and branch operations.  As a result, a non load-store
> operation can be parsed for data source and memory sample.
> 
> To fix the issue, this commit introduces a is_ldst_op() macro for
> checking LDST operation, and apply the checking when synthesize data
> source and memory samples.
> 
> Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 251d214adf7f..0e8e05c87fd7 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -37,6 +37,8 @@
>   #include "../../arch/arm64/include/asm/cputype.h"
>   #define MAX_TIMESTAMP (~0ULL)
>   
> +#define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
> +
>   struct arm_spe {
>   	struct auxtrace			auxtrace;
>   	struct auxtrace_queues		queues;
> @@ -681,6 +683,10 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   {
>   	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
>   
> +	/* Only synthesize data source for LDST operations */
> +	if (!is_ldst_op(record->op))
> +		return 0;
> +
>   	if (record->op & ARM_SPE_OP_LD)
>   		data_src.mem_op = PERF_MEM_OP_LOAD;
>   	else if (record->op & ARM_SPE_OP_ST)
> @@ -779,7 +785,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>   	 * When data_src is zero it means the record is not a memory operation,
>   	 * skip to synthesize memory sample for this case.
>   	 */
> -	if (spe->sample_memory && data_src) {
> +	if (spe->sample_memory && is_ldst_op(record->op)) {
>   		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
>   		if (err)
>   			return err;

Reviewed-by: James Clark <james.clark@linaro.org>


