Return-Path: <linux-kernel+bounces-265292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EC93EF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A0F280DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623212CD96;
	Mon, 29 Jul 2024 07:56:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897621EB2C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239812; cv=none; b=juzk23QYq6ERQRMwK8hosIeyDK4Nff6/abfvKq/Ic/OSvsecDSi3AVi2tO+OTbEYgu7E9AA0FCEmC7M0l5kGlfiiZUTIXrrE2CSAiTP3jQwJjJQhTbeU2bQYktZgI+sQE0m0ZkP8+RFZZOwBHIFrIBa3tiXGGKJzQ0x9KNLQwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239812; c=relaxed/simple;
	bh=3JThnzm685zpTEN4L6VpfSY8iCQhnE85eI6Cas1v7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8xv+Hl6EeNyoK5zcOr9qyheU+Ro6kdooVTEbTcWn+09vlDRLR0+/PZyvacWGLVFnVihAJBoL5Qb0CHyaZFag7j6OXZo+huGO777670wCPe8OZfex8XfaOH49AEMmqGbEgK8wc4u74R4CVurrgN4O71Y1mXoOo3jWQmjINy5MAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54951FEC;
	Mon, 29 Jul 2024 00:57:15 -0700 (PDT)
Received: from [192.168.34.184] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8481C3F766;
	Mon, 29 Jul 2024 00:56:45 -0700 (PDT)
Message-ID: <01e68be1-dc49-448c-9338-70ececd0bec7@arm.com>
Date: Mon, 29 Jul 2024 09:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240723114247.104848-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2024 13:42, Chuyi Zhou wrote:
> In reweight_task(), there are two situations:
> 
> 1. The task was on_rq, then the task's load_avg is accurate because we
> synchronized it with cfs_rq through update_load_avg() in dequeue_task().

Just asking: That's the dequeue_task() in __sched_setscheduler() or
set_user_nice()? Maybe this is worth mentioning here?

[...]

> @@ -3795,7 +3816,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		if (!curr)
>  			__dequeue_entity(cfs_rq, se);
>  		update_load_sub(&cfs_rq->load, se->load.weight);
> -	}
> +	} else if (entity_is_task(se))
> +		sync_entity_load_avg(se);
> +

IMHO, the 'if else' path needs braces. See
Documentation/process/coding-style.rst '3) Placing Braces and Spaces'.

>  	dequeue_load_avg(cfs_rq, se);
>  
>  	if (se->on_rq) {

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

