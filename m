Return-Path: <linux-kernel+bounces-291934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D695690F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FBF1C21CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FE165F0F;
	Mon, 19 Aug 2024 11:11:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69650161328
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065872; cv=none; b=WGtNgEXN6OR8PKoE8mv//ivZY92+znPBQQmGy1AR5L5B/i5KuYO80VtjUbk3/D42rtaYaqcdCc1ZNHfBv3rCsTu33s63tSSMysfqOgl7TTZ0y+MSzE7sR1ZsowPeLuV8yEWrpuoKs54EmMYklMpL2XYZf5i+WLYnMxdfrNhda1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065872; c=relaxed/simple;
	bh=1ueM8aOlEyR6QaPJnMK1guOINKcu7rHJOu+vkC8BHvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqwMLpOMqiVpeGK5c3ghQ7GuK2wSIPnD5w9SXeguy8EjdSFmk5TQm+1+Zx74udX896rGJxjAoXeXGcPf1GpuPZ9JlvqgYxzXASb2C5jkjV6ZbgP8jOcHxxVHdjgfbSDceNjENVe4rtPPd3YyxJoAiEXGz2jTUC/c58TeRiS50EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E34339;
	Mon, 19 Aug 2024 04:11:34 -0700 (PDT)
Received: from [10.1.39.50] (e127648.arm.com [10.1.39.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845153F641;
	Mon, 19 Aug 2024 04:11:05 -0700 (PDT)
Message-ID: <1c4d6e55-5440-4385-9a28-998da18af9bc@arm.com>
Date: Mon, 19 Aug 2024 12:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 24/24] sched/time: Introduce CLOCK_THREAD_DVFS_ID
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105031.053611186@infradead.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240727105031.053611186@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 11:27, Peter Zijlstra wrote:
> In order to measure thread time in a DVFS world, introduce
> CLOCK_THREAD_DVFS_ID -- a copy of CLOCK_THREAD_CPUTIME_ID that slows
> down with both DVFS scaling and CPU capacity.
> 
> The clock does *NOT* support setting timers.
> 
> Useful for both SCHED_DEADLINE and the newly introduced
> sched_attr::sched_runtime usage for SCHED_NORMAL.
> 

How will this look like in practice then?
Is it up to userspace to adjust sched_runtime to capacity/dvfs
accordingly every time it changes? I guess not.
Will sched_attr::sched_runtime be for CPUCLOCK_DVFS by default?
I assume that would be a uapi change?
Do we need an additional flag in sched_attr to specify the clock
to be measured against?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/posix-timers_types.h |    5 ++--
>  include/linux/sched.h              |    1 
>  include/linux/sched/cputime.h      |    3 ++
>  include/uapi/linux/time.h          |    1 
>  kernel/sched/core.c                |   40 +++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c                |    8 +++++--
>  kernel/time/posix-cpu-timers.c     |   16 +++++++++++++-
>  kernel/time/posix-timers.c         |    1 
>  kernel/time/posix-timers.h         |    1 
>  9 files changed, 71 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/posix-timers_types.h
> +++ b/include/linux/posix-timers_types.h
> @@ -13,9 +13,9 @@
>   *
>   * Bit 2 indicates whether a cpu clock refers to a thread or a process.
>   *
> - * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
> + * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or DVSF=3

s/DVSF/DVFS

> [snip]

