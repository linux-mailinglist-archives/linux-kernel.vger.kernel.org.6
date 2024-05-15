Return-Path: <linux-kernel+bounces-179836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D268C6632
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5603E1F23482
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069574407;
	Wed, 15 May 2024 12:12:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E506A005
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775127; cv=none; b=WM055ki9x4Eo8KYKwNpApEhPMPSrA/Nc8JfyeX6pDFbpMd4eba95DhENA+ae3AvyUhav+Tngh7LPoEjMuBRAMLXej5AJlX+68d/14761thp+swsND1UekIc4ksAM1umngyNfH0AZo/Tmi+UD36YSY1tF/HBfI/vME4f7NhZk7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775127; c=relaxed/simple;
	bh=7GmX9sSAglcsdgg1nnDNLqsskVmSveiPobBelaVNMeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FivVrl/h8u5Lzkvqycg/P3y9e4QM0l7gHI7tdJTNuVvLUhjxQBi1r+8rO8a0A1kfRl+YyNywJqU+nr1S6xQssVHnrNNPQ4C9/K+ejbaQf3zshLqZVNV7by8IPq4cyktxIosg2koqHLnhzsc6LTnCWGUUfKjogVtI57WgOl4xIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 374C41042;
	Wed, 15 May 2024 05:12:29 -0700 (PDT)
Received: from [10.57.5.6] (unknown [10.57.5.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2CC23F641;
	Wed, 15 May 2024 05:12:02 -0700 (PDT)
Message-ID: <0a454227-ab99-4eb9-a736-1c826cfeb97d@arm.com>
Date: Wed, 15 May 2024 13:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-dmc620: Fix lockdep assert in ->event_init()
To: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 Greg Thelen <gthelen@google.com>, Tuan Phan <tuanphan@os.amperecomputing.com>
References: <20240514180050.182454-1-namhyung@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240514180050.182454-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-14 7:00 pm, Namhyung Kim wrote:
> for_each_sibling_event() checks leader's ctx but it doesn't have the ctx
> yet if it's the leader.  Like in perf_event_validate_size(), we should
> skip checking siblings in that case.

Ugh, looking around for_each_sibling_event() sites, it looks like there 
are a fair few other drivers using this pattern as well :(

I'd love for groups to be less horribly complicated, but I think I can 
follow the underlying reasoning here. I suppose one could argue that the 
assertion could take into account that there's nothing to protect in the 
case where event->ctx is still NULL, since nobody else should be able to 
touch the event's own empty sibling list at this point before 
perf_event_open() has even returned. However by the same token there's 
also no real reason for drivers *not* to return early when they equally 
can tell that the sibling list must be empty, and indeed that seems to 
be a fairly common pattern too, so I see no issue with fixing up all the 
offending drivers for consistency either.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: f3c0eba287049 ("perf: Add a few assertions")
> Reported-by: Greg Thelen <gthelen@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   drivers/perf/arm_dmc620_pmu.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 8a81be2dd5ec..88c17c1d6d49 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -542,12 +542,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>   	if (event->cpu < 0)
>   		return -EINVAL;
>   
> +	hwc->idx = -1;
> +
> +	if (event->group_leader == event)
> +		return 0;
> +
>   	/*
>   	 * We can't atomically disable all HW counters so only one event allowed,
>   	 * although software events are acceptable.
>   	 */
> -	if (event->group_leader != event &&
> -			!is_software_event(event->group_leader))
> +	if (!is_software_event(event->group_leader))
>   		return -EINVAL;
>   
>   	for_each_sibling_event(sibling, event->group_leader) {
> @@ -556,7 +560,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>   			return -EINVAL;
>   	}
>   
> -	hwc->idx = -1;
>   	return 0;
>   }
>   

