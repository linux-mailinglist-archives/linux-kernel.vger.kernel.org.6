Return-Path: <linux-kernel+bounces-518048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71DA38920
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D19E7A395F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1F225766;
	Mon, 17 Feb 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua7qIs9e"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250E2248B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809738; cv=none; b=GKzlPlrzAu3TCixvqm/0Z5NYEfnsHm2J6UE8BCTi3T+FlOIdXWMsYEr5d25I3ww2YNzvaUTNI/OTEb5xYc6rh/b8BntpWuYWb/iOalZt0JbBYztN9hwKtrDo8qGrmaoSNKSwVyZ3SBJo0Fx2XtrIUFcejTQofNfbu1RJid0xKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809738; c=relaxed/simple;
	bh=1dZjLA99dFw5X8YnsZGjN3xV4yjbzsmIuRCG3ozKqwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uCXRY3vEAGnFmD5gixxAWUyDdMXsf9wpWuO9qUGz/5nmtyhN8N6FJLeugP5XEu3VdC+QhaLwneDaBRZrXUdzEPL5qmVbFsTqPbc+07w8Ha9SqndNClm8ymKZaGG2QrgkbQBGSgcAB8YWtmkY7oOm6PpvnXJuN8TVIl0rMxwfO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ua7qIs9e; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so1955833f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739809734; x=1740414534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RZGgBpcp8HuoDdnVbyjD6nbTX5PiNpopNc/IO+zHmIo=;
        b=Ua7qIs9eNfY8EGqW3P050US1ROL7uqThw5HggVZ4Ku2sL6IV1UUGIYX4cfK75o59TE
         Z7y57REb1g/t9+ksCa6X7sDvRam2IkfXbZYrBCUcd1dES7pOf5cN7gpGBpxJWOSiqygK
         6xqhFnNV1e+8e+RuXpMDTFlvZJOnJs6MaHBHF9gKfCxRc1LmST7fs6UdM2sLgXnREvtO
         d3shc5T89yltl7RGW8EqYpiIxerTOyIu9kltt6vCMrSXFy2lmdwB2m3sWN53SwZj/xBU
         2KYnYWRNLYAG627NJJU0Z8pgTLnF8ov5H1cURmqAO/sylYfZJYmaqiCGhExW5g/yfgwS
         PSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809734; x=1740414534;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZGgBpcp8HuoDdnVbyjD6nbTX5PiNpopNc/IO+zHmIo=;
        b=GgCAUiP6AnEfYce9mrxrmQCkVHtbhiZMLqkrUuFhygGH9AqNddWXC7WNs3Rt5rx7wI
         eschBZZ6RCBJ7yn5u2b/lHRy+BtYyvTzN/uUR0DWxO7aY9J4rA8urlNqRI+tRiJCNI3f
         lGhqJZ9Ijd1Z2B1RO20SsJgPvS21yMyrm9sk43npWIv7IKUhBj6udupmI3Ki25pR5sTv
         1d2PF28+YDWALcuslDIuGvauHBkdIIozJlDvFdBBXEDrSN+EgkM9Odgex/qeWfA1Trdl
         k46Ca/c5A4Al+cYNpOc9Xxku/Hf7CqwigpfG6h8EvzGWTdU7++UTzD8YrfoJ5lgvqBGW
         Vmlg==
X-Forwarded-Encrypted: i=1; AJvYcCWDehNF1L4/68rb5X+55u1yTIowCVZjq7D2WecDsOkDTpP9Tip0B2XgLK3g5tlbo6D4QVQsi/DyFOfGJT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKFTHctJ2F2zTuUlixLoNCMDVYcb2KYEaMhKOYAcXD/Smh8y/
	JQycBsLALk+OloPjjBmBZLd3YKNLJsBsyJuDQM9R87vk1uRqBTgjGN+8jaVSga4pVi6LrXpc3vF
	1pfo=
X-Gm-Gg: ASbGncu0UyWFC/q812SKKibWZP9AnEQtuHx1lbgvvwlXGfKpxK+iG6o95bPwVWlhP/i
	74q514EJLYwdXFMQOYkxC3lXDFFsUD2e3M6aouyJHQJ73R8RzeGuwKuhhFBGb5MdgO/sAHUOA56
	+yBu/E3tVpAmfv66rVUXj8ARbY6VT231k3j9jfHLlEafy/PxVXkWljwbgJu4Lv2VXtVRYQG12U1
	4a6tkESYkeGEA6GzY3iLW3mEdPZCngi9DNY5LMM2H0JuE8pVe+MtKnDgHv3tc88nuaayRHwqStN
	yCYmE3ymlroHrU7yO3IDq78liA==
X-Google-Smtp-Source: AGHT+IHuH77s0Gc3jaj6SvUYPZ9P8VnXHclSL5deuIzHmW+q14rWha9t/xkM04tw0RHHjunQ1PBdgA==
X-Received: by 2002:adf:e6ce:0:b0:385:f6b9:e762 with SMTP id ffacd0b85a97d-38f340676a5mr8093772f8f.36.1739809733997;
        Mon, 17 Feb 2025 08:28:53 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm12655932f8f.23.2025.02.17.08.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:28:53 -0800 (PST)
Message-ID: <cd0c08e2-351c-43fb-863c-85a405714284@linaro.org>
Date: Mon, 17 Feb 2025 16:28:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] perf script: Refactor branch flags for Arm SPE
To: Leo Yan <leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
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
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 11:19 am, Leo Yan wrote:
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.
> 
> For refactoring branch flags, the sample flaghs are classified as branch
> types and events.  A program branch type can be conditional branch,
> function call, return or expection taken.  A branch event happens when
> taking a branch.  This series combines branch types and the associated
> events to present a sample flag.
> 
> The second part is to enable Arm SPE's sample flags for expressing
> branch types and events, and support branch stack.
> 
> Patches 01 - 03 are to refactor branch types and branch events.
> Patches 04, 05 extend to support not-taken event.
> 
> Patches 06 - 09 enables branch flags in Arm SPE.  This allows to print
> out sample flags for samples.
> 
> Patch 10 supports branch stack for Arm SPE.  Patch 11 is an enhancement
> for PBT feature.
> 
> Changes from v1:
> - For patch 05, changed to append the 'not_taken' bit in the branch_flags.
>    This can avoid altering bit layout and cause breakage.
> - Added Ian's review tags.
> 
> 
> Leo Yan (11):
>    perf script: Make printing flags reliable
>    perf script: Refactor sample_flags_to_name() function
>    perf script: Separate events from branch types
>    perf script: Add not taken event for branches
>    perf script: Add not taken event for branch stack
>    perf arm-spe: Extend branch operations
>    perf arm-spe: Decode transactional event
>    perf arm-spe: Fill branch operations and events to record
>    perf arm-spe: Set sample flags with supplement info
>    perf arm-spe: Add branch stack
>    perf arm-spe: Support previous branch target (PBT) address
> 
>   tools/perf/builtin-script.c                   |  30 ++--
>   .../util/arm-spe-decoder/arm-spe-decoder.c    |  23 ++-
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  11 +-
>   .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 +-
>   .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  12 +-
>   tools/perf/util/arm-spe.c                     | 135 ++++++++++++++++++
>   tools/perf/util/branch.h                      |   3 +-
>   tools/perf/util/event.h                       |  12 +-
>   tools/perf/util/trace-event-scripting.c       | 116 +++++++++++----
>   tools/perf/util/trace-event.h                 |   2 +
>   10 files changed, 307 insertions(+), 51 deletions(-)
> 

Just one potential issue on patch 8, with that fixed:

Reviewed-by: James Clark <james.clark@linaro.org>


