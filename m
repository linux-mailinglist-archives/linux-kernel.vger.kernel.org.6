Return-Path: <linux-kernel+bounces-513218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177DBA34426
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6CA16F9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66F242904;
	Thu, 13 Feb 2025 14:51:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BF24169B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458299; cv=none; b=KewEkHJis2uCZTC4uAVWhyWeImvwQ1254L5xj3r21kkaNvvAsWfWZvDGdlO3KB9OJdO1F0bdUlLu/PHmILij2+kQbcQqhm9/xNeRT9KD9OORNHAJhXQ4dh8rAplYU8q7pO5LNouszt7FubYgZJHtR5EiIVn77BIfUBAC9PKFFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458299; c=relaxed/simple;
	bh=xRSr9mLHsRA464FI1y1mU5KnIYeSV7kKpKI7/hH94pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV91Pfr2G7XaWGy9tjYe+g06hh27nn2Gs7DNGFE2P7qd/3P8WcdXHBZVqCytmYOhu5W7+e6QzkAMhMoLvk/iCcme1WkxxEAky7mtfCZdDsPOuWqFGljfWw6PZbOsdP0O6xG26feLvURhEylvkcOfrknFI5uhurykYuW/8OzuOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3AB106F;
	Thu, 13 Feb 2025 06:51:56 -0800 (PST)
Received: from [10.57.79.221] (unknown [10.57.79.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432073F58B;
	Thu, 13 Feb 2025 06:51:32 -0800 (PST)
Message-ID: <b9ab5474-0b43-4200-8217-5cd95b365cad@arm.com>
Date: Thu, 13 Feb 2025 14:51:30 +0000
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
 linux-kernel@vger.kernel.org, Hongyan Xia <Hongyan.Xia2@arm.com>
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
 <20250213091554.2593-2-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250213091554.2593-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 09:15, Xuewen Yan wrote:
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and the uclamp_validate() would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/syscalls.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..d718fddadb03 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
>  	 * blocking operation which obviously cannot be done while holding
>  	 * scheduler locks.
>  	 */
> -	static_branch_enable(&sched_uclamp_used);
> +	if (!uclamp_is_used())
> +		static_branch_enable(&sched_uclamp_used);
>  
>  	return 0;
>  }

Given that we never disable sched_uclamp_used once active this
is fine.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

