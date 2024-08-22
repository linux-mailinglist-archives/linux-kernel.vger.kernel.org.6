Return-Path: <linux-kernel+bounces-296421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C6F95AACE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E334A1C22248
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4214277;
	Thu, 22 Aug 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Glq6ktCX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB0111AA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292606; cv=none; b=l6mZVInIzzQATC44hWr/uuTW3zhLW5VrCjpsn128NNGjbNZHHb9C/u0wrclaGSKfGlwrz1OA2bXqJGHNwXEzEiPuPWRfrnsWpBQzv+/aKNmNemf6HdvoECrbsJUM6DgDByei8cKtL+CkeDvI80v6+oQlYvGmmpbzq3O4YP1L7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292606; c=relaxed/simple;
	bh=n8tzgLbdZadXhsgdBFBB5vAD/yvwYfC+xHHc4qYcqG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foeX62O5GTH2MLECVSu3kxKxCMAUJs6t5Ni+OgdQtdd3IcmNXeOHmsny89ewM4uOdpA/IxifIETchjZRpoTK2xWTi6lj9RgppN6uvzhDLPAcGD6S8s0+SpBmd0KFMcVqYA3Ys14D4JYFHQ9pSEV67g1zS1aNgXn0Elq3w4qPpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Glq6ktCX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201fae21398so2207585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724292604; x=1724897404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HELrqJhMnibtT6HZyWKYY6zlKin2aFYrriSo+U7oJo=;
        b=Glq6ktCXm+0su30DfY3DTHUmaTU9OYa9/z3uVBye6ddnKVI89hhoMdcnNOXE9hnKNh
         qzV7sfRUt+kpPC/v7WepJGNe+1uzt/1HC7jtwxsmrl646tuhysgExG8QuyTjHpBTH2mg
         Nryzy1rDlx6GrQvNBECdYEv4DIA6JwZTEjRng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724292604; x=1724897404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HELrqJhMnibtT6HZyWKYY6zlKin2aFYrriSo+U7oJo=;
        b=a8+5FUmMUDbhcE7Nt2s/nBlgRcQToUQ+MPNb0q88oyVhHo/vF8LWdKxInph602ZtYy
         1ROycqaVFfpqV3PpowHFGLYoDdY021lo169ma6E2ZBv46qBS8QegUga0U9cUaqIMl03n
         6WbM0U+yVgeTWTGMX1sBOLSZ77SDH9WfELwRSos7u9b/Q6AEf7zNUv1cSlRZGLVhEBOz
         X72idt7yJ9c2PmLBMERozzw6qfq4SPauDZnJdTeLnXvL19Th5AhbGhlZf6S/jFZd0Ouq
         fEtiQpCEQHOCsNljKoC0bgEeK0BQMehr/zXSODLlC23ykRPzNJ1CXnhqe25YVvSeLmDm
         GIrw==
X-Gm-Message-State: AOJu0YwQA7ecITbdaQ5I6y5+PceUHIb8eNNu2U0L5ExcH/k4tt+kj/EO
	HksSyIAw/Y+VaGT76zevWW07mc/aOyQY/4G6/cxYrULGxp8uVDyD2V165aYgn/s=
X-Google-Smtp-Source: AGHT+IH7GzcImxBIXmnvLBukdrzzAUiPJZzCqm7EZlZK4odeYwTJpCnUUZ2DWg85WZCQ9W7o9ZzdSg==
X-Received: by 2002:a17:902:da86:b0:202:3b7c:c3b0 with SMTP id d9443c01a7336-203680646b3mr45671525ad.38.1724292602427;
        Wed, 21 Aug 2024 19:10:02 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae4e1asm2414365ad.254.2024.08.21.19.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 19:10:01 -0700 (PDT)
Message-ID: <27495118-6152-411c-9d3c-c0176afc9492@linuxfoundation.org>
Date: Wed, 21 Aug 2024 20:09:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] sched: NUMA-aware concurrency IDs
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 08:24, Mathieu Desnoyers wrote:
> The issue addressed by this series is the non-locality of NUMA accesses
> to data structures indexed by concurrency IDs: for example, in a
> scenario where a process has two threads, and they periodically run one
> after the other on different NUMA nodes, each will be assigned mm_cid=0.
> As a consequence, they will end up accessing the same pages, and thus at
> least one of the threads will need to perform remote NUMA accesses,
> which is inefficient.
> 
> Solve this by making the rseq concurrency ID (mm_cid) NUMA-aware. On
> NUMA systems, when a NUMA-aware concurrency ID is observed by user-space
> to be associated with a NUMA node, guarantee that it never changes NUMA
> node unless either a kernel-level NUMA configuration change happens, or
> scheduler migrations end up migrating tasks across NUMA nodes.
> 
> There is a tradeoff between NUMA locality and compactness of the
> concurrency ID allocation. Favor compactness over NUMA locality when
> the scheduler migrates tasks across NUMA nodes, as this does not cause
> the frequent remote NUMA accesses behavior. This is done by limiting the
> concurrency ID range to minimum between the number of threads belonging
> to the process and the number of allowed CPUs.
> 
> This series applies on top of v6.10.3.
> 
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> 
> Mathieu Desnoyers (5):
>    lib: Implement find_{first,next,nth}_notandnot_bit,
>      find_first_andnot_bit
>    cpumask: Implement cpumask_{first,next}_{not,}andnot
>    sched: NUMA-aware per-memory-map concurrency IDs
>    selftests/rseq: x86: Implement rseq_load_u32_u32
>    selftests/rseq: Implement NUMA node id vs mm_cid invariant test
> 
>   include/linux/cpumask.h                       |  60 ++++++++
>   include/linux/find.h                          | 122 ++++++++++++++-
>   include/linux/mm_types.h                      |  57 ++++++-
>   kernel/sched/core.c                           |  10 +-
>   kernel/sched/sched.h                          | 139 +++++++++++++++--
>   lib/find_bit.c                                |  42 +++++
>   tools/testing/selftests/rseq/.gitignore       |   1 +
>   tools/testing/selftests/rseq/Makefile         |   2 +-
>   .../testing/selftests/rseq/basic_numa_test.c  | 144 ++++++++++++++++++
>   tools/testing/selftests/rseq/rseq-x86-bits.h  |  43 ++++++
>   tools/testing/selftests/rseq/rseq.h           |  14 ++
>   11 files changed, 613 insertions(+), 21 deletions(-)
>   create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c
> 

Looks good to me - for selftests:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

