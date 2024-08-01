Return-Path: <linux-kernel+bounces-271174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02535944A60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6131F2427D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEA189B93;
	Thu,  1 Aug 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCJmJVc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCA16D4F3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511769; cv=none; b=emLWJOxiBNfS070G/6dZF7nrlArb0N42Fn6MNkqZl9cXMt++4CEzoe5sEcevKQzUom+JuDFuOlhj8Gwdq1rNld+kA2YtumXmwHqxQS1bid5HKO2AdAtxHc7NmrgSc52SNv6DkSjAiNekf06eO42q8I38Hx9F91Ys4loXfqxWyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511769; c=relaxed/simple;
	bh=+v6bnfy/JkUEptzDmMNSw8VfmjHMTBPhSIEfPCVBBKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBdBSQPR+YxZHQw/TKHWGC5OlbF5+MpKMJ+mtBbPkDkD7ZmXI7yZu7oAtuFFm5NM/XG2j23BV5034mDuOCEGjLJcq/D5qx3pO77zXygFTWQv7bbEYzv5IoW7pv40x9qWjkiZyhkM8+2docv/I0pTOKErwypbuYqV9DajbhVJC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCJmJVc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCEEC32786;
	Thu,  1 Aug 2024 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722511768;
	bh=+v6bnfy/JkUEptzDmMNSw8VfmjHMTBPhSIEfPCVBBKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCJmJVc0VLSivIDaUoyBk9TvA4Vpc01tGHzKGyScfwE+66RtG24Glw2++orizWuCb
	 4aZp/v33kN0T6CfFQ8JF7yijuPAZHZRxFw09Hf8Wb+XH8YT3X9c4Zqj+huRxnOrYlf
	 dLYTRjRZKo3+KfD8R4+yVSYDZ2BWr2PMX8O3wlmmLb89WeZZwdGIJA0uTH9I+tE6gU
	 rX0fz7r9dbteaL12aedUaJPAK869GonIM3wM+wtG1TxjjP5Lh73PwKdt6GSsKxzxYr
	 pnLliQ1l2b/XIys+rjZ/8ovOknftcCuRVZFKVK8r+Z86HA6noKUfcXH75qtOC/2HmB
	 A28icfRAQMs+w==
Date: Thu, 1 Aug 2024 12:29:24 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Fix chained event check for cycle
 counter
Message-ID: <20240801112923.GA4476@willie-the-truck>
References: <20240710182357.3701635-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710182357.3701635-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jul 10, 2024 at 12:23:56PM -0600, Rob Herring (Arm) wrote:
> Since commit b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to
> counter remapping"), armv8pmu_event_is_chained() is incorrectly
> returning that the cycle counter is chained, but the cycle counter has
> always been 64-bit. The result is trying to configure counter #30 which
> typically doesn't exist.
> 
> As ARMV8_PMU_MAX_GENERAL_COUNTERS is the number of counters (31), the
> comparison to the counter index needs to be '<' rather than '<='.
> 
> Fixes: b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to counter remapping")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/perf/arm_pmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 3b3a3334cc3f..0e22c68fb804 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -482,7 +482,7 @@ static bool armv8pmu_event_is_chained(struct perf_event *event)
>  	return !armv8pmu_event_has_user_read(event) &&
>  	       armv8pmu_event_is_64bit(event) &&
>  	       !armv8pmu_has_long_event(cpu_pmu) &&
> -	       (idx <= ARMV8_PMU_MAX_GENERAL_COUNTERS);
> +	       (idx < ARMV8_PMU_MAX_GENERAL_COUNTERS);
>  }

Acked-by: Will Deacon <will@kernel.org>

Catalin -- please can you pick this up as a fix?

Cheers,

Will

