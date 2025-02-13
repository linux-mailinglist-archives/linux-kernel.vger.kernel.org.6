Return-Path: <linux-kernel+bounces-513232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D82A344BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10196172254
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC8155A4E;
	Thu, 13 Feb 2025 14:57:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCD148855
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458660; cv=none; b=mUGShgdYFDOREJsHMVFcDJ6JF/fH9BjvsQ3c68m00kZA75JPaOOReqL2fQSP0le8TrrDEQ69vfyG5QAoz7N88eN6C+vHS0LciAPnY9oXTeylPeSf1leNq4lGZ6Gws62V3ToajxWsQaqd9qDpJgHRpqMoaTSdPPTDT2tBKLODmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458660; c=relaxed/simple;
	bh=1Q6FcNLHCtHjbDAFtp3EbriASKK4vxSDGLk/QJR+H/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0ISC9OMaq/wXO59tT8gGEwayapqgaLjHzSjCmwNHRxiC/4J0Wyt24VeP2mtS6YhMUwFHcEBvGsbtuwM5gLjtdMF/eztCIdgZZcbwOToZ6GSZuQfGxbtPAI/68uQGtCt8nQF9/+MDR1RAQaBaYIkQJhC/nIc4zry4fSCRt5nl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B674D106F;
	Thu, 13 Feb 2025 06:57:58 -0800 (PST)
Received: from [10.1.30.40] (e133649.arm.com [10.1.30.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00D43F762;
	Thu, 13 Feb 2025 06:57:34 -0800 (PST)
Message-ID: <801dc546-2723-4bf7-bd65-096213466921@arm.com>
Date: Thu, 13 Feb 2025 14:57:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, qyousef@layalina.io,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
 <20250213091554.2593-2-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20250213091554.2593-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2025 09:15, Xuewen Yan wrote:
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and the uclamp_validate() would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/sched/syscalls.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..d718fddadb03 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
>   	 * blocking operation which obviously cannot be done while holding
>   	 * scheduler locks.
>   	 */
> -	static_branch_enable(&sched_uclamp_used);
> +	if (!uclamp_is_used())
> +		static_branch_enable(&sched_uclamp_used);

NIT: I was also wondering about race conditions, and then realized we 
never disable this static key, so maybe worth adding a comment here.

>   
>   	return 0;
>   }

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

