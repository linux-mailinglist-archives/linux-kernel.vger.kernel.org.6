Return-Path: <linux-kernel+bounces-321278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DE9716D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2E1B26C06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034131B3F3E;
	Mon,  9 Sep 2024 11:26:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F931B2ED0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881196; cv=none; b=nJ7dOvoDUoK57X8FUvbK2CXMlzmTuncAf8FNxmxF7LpeTa2eMdh4a/r2y66T3bZSDekarPRdcdanfH2diN2OruIeVkLqEMxAN/6D46ONQnc5ndNbRp7XFDPkXEKDXc03scLg7XFhZNmcRxJcvg4V3R2htSk636BbSS3j7oLuNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881196; c=relaxed/simple;
	bh=5ASkjyfsJ994farGDOqj1cdlbIlZ/Y5QxiuOkbMGvHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or3lexyGmJUX/a7ZD5skrheM74O1EX5EwOJNJN6zOLS+vnNJ09hHaLbl0fMjJp77EZMLrAMGG6su4VpEjdHC1aLUc6qg8wxt4IW5z6YDeDddvLvfwau2fD8baKwWg3JX9UXoq2GEGAHI06yz0KJL5H9FtCW3Nx/y35z6s2BUn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D45FEC;
	Mon,  9 Sep 2024 04:27:01 -0700 (PDT)
Received: from [10.1.39.38] (e127648.arm.com [10.1.39.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EFBB3F73B;
	Mon,  9 Sep 2024 04:26:31 -0700 (PDT)
Message-ID: <a04070a1-39d5-4362-a28c-39b9b910eaac@arm.com>
Date: Mon, 9 Sep 2024 12:26:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] sched/fair: Remove unnecessary judgment in
 pick_next_task_fair()
To: Benjamin Tang <tangsong8264@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org
References: <3d9e48ab-869e-4633-8874-b2899c8cc8ce@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3d9e48ab-869e-4633-8874-b2899c8cc8ce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/24 06:13, Benjamin Tang wrote:
> sched/fair: Remove unnecessary judgment in pick_next_task_fair()
> 
> Since 'curr' argument is no longer needed in pick_next_entity(),
> remove unnecessary judgment.
> 
> Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
> ---
>  kernel/sched/fair.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..92f8ad778205 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8492,8 +8492,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>         if (curr) {
>             if (curr->on_rq)
>                 update_curr(cfs_rq);
> -           else
> -               curr = NULL;
> 
>             /*
>              * This call to check_cfs_rq_runtime() will do the

This has been reworked on tip/sched/core and is no longer needed:
[PATCH 05/24] sched/fair: Unify pick_{,next_}_task_fair()
https://lore.kernel.org/all/20240727105028.725062368@infradead.org/

