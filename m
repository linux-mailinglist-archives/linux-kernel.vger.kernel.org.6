Return-Path: <linux-kernel+bounces-521956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCAA3C446
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3F1888474
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F81FCCE7;
	Wed, 19 Feb 2025 15:57:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2801D5175
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980649; cv=none; b=bX6yT5rONz3VYFUuvm7KiKd0Rrn3Os19znIwjCGh6oyhYPwBXo4b/TfbjbtgZ97XUAVHD6PkHUsFsRdRyMd8mArIcRZTHrZRhwvIGaR1CPihCch7SlpttexOW+XnY3gplAQhU9AfHt7Cik7Ww8qx510jeMnwKmPEQmLRkCVEtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980649; c=relaxed/simple;
	bh=fqyFrR+Pdv64TBlOeVSNkbXzDJI9qs8N3HKHJZsuunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oL+lm/5bEQlWLcPRMAPmXsM4TDJPvgWwXYAs/t+CgD/SQaX2DyJGMKZW71/6elAFmDOmmmqktPuXiV4Ud1cE02giMuGdNA3gA92vmtr9+Do8Ugkj+PwQVxESjp/0C0rTcC+UwThtBwuyFpEhqgL6p3OFxTDj5b/6fOnVr+O8+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739D91682;
	Wed, 19 Feb 2025 07:57:44 -0800 (PST)
Received: from [10.1.35.44] (e127648.arm.com [10.1.35.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98BDE3F6A8;
	Wed, 19 Feb 2025 07:57:22 -0800 (PST)
Message-ID: <ae526670-5a3d-4c86-991b-3c3175f6d03d@arm.com>
Date: Wed, 19 Feb 2025 15:57:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/uclamp: Always using uclamp_is_used()
To: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, hongyan.xia2@arm.com,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250219093747.2612-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250219093747.2612-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 09:37, Xuewen Yan wrote:
> Now, we have the uclamp_is_used() func to judge the uclamp enabled,
> so replace the static_branch_unlikely(&sched_uclamp_used) with it.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> V2:
> - Correct the spelling mistakes in the commit message (Hongyan)
> - Add Reviewed-by
> ---
> ---
>  kernel/sched/core.c  |  4 ++--
>  kernel/sched/sched.h | 28 ++++++++++++++--------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9aecd914ac69..38a7192bfc19 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1757,7 +1757,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  	 * The condition is constructed such that a NOP is generated when
>  	 * sched_uclamp_used is disabled.
>  	 */
> -	if (!static_branch_unlikely(&sched_uclamp_used))
> +	if (!uclamp_is_used())
>  		return;
>  
>  	if (unlikely(!p->sched_class->uclamp_enabled))
> @@ -1784,7 +1784,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  	 * The condition is constructed such that a NOP is generated when
>  	 * sched_uclamp_used is disabled.
>  	 */
> -	if (!static_branch_unlikely(&sched_uclamp_used))
> +	if (!uclamp_is_used())
>  		return;

v2 includes the above two which inverse the likely annotation FYI.

