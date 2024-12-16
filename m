Return-Path: <linux-kernel+bounces-447817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA89F3767
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CAF1881DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B18206F05;
	Mon, 16 Dec 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r29ylNXP"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAE2063E3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369691; cv=none; b=aG8FXy6Ce+7ufQrKmDTK1DiAvKexxrjh0kE7GaCtiL5Mj2HWfvA0aNiHPPzXPvXNZrEwmctmna2Qx8SuZOOpSANOmq6ionHZRFNC8tQdeOr82EPLItG0EXUGs7QtFO19JrpopVG3/awa9LvTILMunKHi0C/UY6wKBxA+61MS5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369691; c=relaxed/simple;
	bh=iSi59v8LNr+EPwWCBvXOnQ0Kss0DSiv4S3oup6h2dsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NI3IhRyhmLhsjhjv9R5ri0GXoCxuvBVLSjmsuxK76oJQPSARV4FIkhJ4opNUYh71OgFKItA8yIjddHFew5WkH1P4SzcxHO/GwT8IG2wA109WlNWm/oA7Dkw3NQmrYn6YADCrtGO00R/16MCKD3ujw/2jj/LaUDPn98uLP4h8QDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r29ylNXP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734369686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9LLLaGjtfz1xmvBfYNrPAJD9KQz5/pkDMu0zRApdZY=;
	b=r29ylNXPDZN66EP4Nx70zpHwFezQHTn2fMdw5+OKcmlwm/aWiSqVfCa3roIbmCex4aBjz4
	A2CGZKihtsbe0U6kFvlauBQS7PALEyZOe1wcZcLlmzljOLnp20FqrvLWILlRHC4DlmXqh4
	zeLB7/4+49q8dHDvORF5l3Z7RyM12qU=
Date: Mon, 16 Dec 2024 09:21:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, "Liang, Kan"
 <kan.liang@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>
References: <20241215193436.275278-1-leo.yan@arm.com>
 <20241215193436.275278-3-leo.yan@arm.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241215193436.275278-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/15/24 11:34 AM, Leo Yan wrote:
> The bpf_perf_event_aux_pause kfunc will be used to control the Perf AUX
> area to pause or resume.
>
> An example use-case is attaching eBPF to Ftrace tracepoints.  When a
> tracepoint is hit, the associated eBPF program will be executed.  The
> eBPF program can invoke bpf_perf_event_aux_pause() to pause or resume
> AUX trace.  This is useful for fine-grained tracing by combining
> Perf and eBPF.
>
> This commit implements the bpf_perf_event_aux_pause kfunc, and make it
> pass the eBPF verifier.

The subject and commit message mentions to implement a kfunc,
but actually you implemented a uapi helper. Please implement a kfunc
instead (searching __bpf_kfunc in kernel/bpf directory).

>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   include/uapi/linux/bpf.h | 21 ++++++++++++++++
>   kernel/bpf/verifier.c    |  2 ++
>   kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 75 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4162afc6b5d0..678278c91ce2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5795,6 +5795,26 @@ union bpf_attr {
>    *		0 on success.
>    *
>    *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause)
> + *	Description
> + *		Pause or resume an AUX area trace associated to the perf event.
> + *
> + *		The *flags* argument is specified as the key value for
> + *		retrieving event pointer from the passed *map*.
> + *
> + *		The *pause* argument controls AUX trace pause or resume.
> + *		Non-zero values (true) are to pause the AUX trace and the zero
> + *		value (false) is for re-enabling the AUX trace.
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if not found event in the events map.
> + *
> + *		**-E2BIG** if the event index passed in the *flags* parameter
> + *		is out-of-range of the map.
> + *
> + *		**-EINVAL** if the flags passed is an invalid value.
>    */
>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>   	FN(unspec, 0, ##ctx)				\
> @@ -6009,6 +6029,7 @@ union bpf_attr {
>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>   	FN(cgrp_storage_get, 210, ##ctx)		\
>   	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(perf_event_aux_pause, 212, ##ctx)		\
>   	/* */
>   
>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>
[...]

