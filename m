Return-Path: <linux-kernel+bounces-182086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCA8C861B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6C1F272E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1540BE2;
	Fri, 17 May 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glxgZeLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4D3FBBD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947360; cv=none; b=I8OdOVtjdjowDqv08y3Nje354cf1s5Qm4YUpE7+BvuVGNiyNKGStAfUDBqLAksYHXxHzD3FYajHOoOoMsLJWTFPA6TmcVuembll7utnlVIBV1DAiBbM6XD/8OaJvwrgXVvTRTNEa04JglXqHcp8I56C2pekn5P2xKOp+60enLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947360; c=relaxed/simple;
	bh=Aj995U25J5UbB1WP0fjOwm2XJjRFPFEAj+XFyuAV13o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/UZK/EoWVlLVvi6WNex5KogLHJMuSB8V/km81ZM6clfpN5jMsx4CpNjWwm8CHdoeBv06H8MAYMvllAtFVNiXuaDxFNmchkSQIr+l7lmwj7cpIQLs4w0vJHyh2hRjcI+R4aYUE3CdQv0I/vhPaG5Auf6HeArfKO/I++LMVQiqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glxgZeLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A6C32786;
	Fri, 17 May 2024 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715947359;
	bh=Aj995U25J5UbB1WP0fjOwm2XJjRFPFEAj+XFyuAV13o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glxgZeLpP1uLmV4GBnYAiTerOc6h4T+R96O1PurnqCi/R8mFeRKSfXTyy57zbZCF9
	 u62t3dhnkqcVEXQqUZd76ITjG7wlJSWUfrqU8agoKARxrSu1R8w0WgsNwheRRW2gCY
	 UdTsYEowBotGDj+MwCstPfvBj5+mZaDHmEAtSOnWj4ng5drK5lHCuL+keMB3HcHhud
	 45ur3p/t+QEG6pxL0CXUTjkjbGD7VZ5B4y2I8d6gJekxUxAN8d9pi7vpViiFH8r89o
	 R6UU4qt3qoOAnQ4Iv8qeDFy+AtUYb0GVF9GGZppgpo/XdO9A/oZEGD1EacwkG6aq9R
	 QJHIt9JUoNb3A==
Date: Fri, 17 May 2024 13:02:34 +0100
From: Will Deacon <will@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Greg Thelen <gthelen@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>
Subject: Re: [PATCH] perf/arm-dmc620: Fix lockdep assert in ->event_init()
Message-ID: <20240517120234.GA32598@willie-the-truck>
References: <20240514180050.182454-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514180050.182454-1-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 14, 2024 at 11:00:50AM -0700, Namhyung Kim wrote:
> for_each_sibling_event() checks leader's ctx but it doesn't have the ctx
> yet if it's the leader.  Like in perf_event_validate_size(), we should
> skip checking siblings in that case.
> 
> Fixes: f3c0eba287049 ("perf: Add a few assertions")
> Reported-by: Greg Thelen <gthelen@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  drivers/perf/arm_dmc620_pmu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 8a81be2dd5ec..88c17c1d6d49 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -542,12 +542,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> +	hwc->idx = -1;
> +
> +	if (event->group_leader == event)
> +		return 0;
> +
>  	/*
>  	 * We can't atomically disable all HW counters so only one event allowed,
>  	 * although software events are acceptable.
>  	 */
> -	if (event->group_leader != event &&
> -			!is_software_event(event->group_leader))
> +	if (!is_software_event(event->group_leader))
>  		return -EINVAL;
>  
>  	for_each_sibling_event(sibling, event->group_leader) {
> @@ -556,7 +560,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> -	hwc->idx = -1;
>  	return 0;
>  }

Thanks, I'll pick this up, although Mark reckoned he'd found some other
issues over at:

https://lore.kernel.org/r/Zg0l642PgQ7T3a8Z@FVFF77S0Q05N

but didn't elaborate on what exactly he'd found :/

Will

