Return-Path: <linux-kernel+bounces-219767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D263F90D78C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B328286306
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A03A4595D;
	Tue, 18 Jun 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7IaDs7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C91CD29
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725267; cv=none; b=uLtv79YRI53LoNo5DjtWuRfLb6qS/IfbbwMQwzT5RlWukOemC2tspuLuv0vBcbUPRf7dCETVrhZY3VoPq9Zn1WabarHG+6gr2Ax7hb7FM9A0UPwUOQEsdvSXFIGHa7N5J4ri5G+EUMasOREU7+ppdvMGwPZLn88ClZHWe70sxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725267; c=relaxed/simple;
	bh=CJrK0+s51TojWb4uz38DIYO+IOAei4tLxpuCbpdl00c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBMfqUCw7otY48g4SsMnossIq6mi9EPG6t/OT2KFTbqThKFjDbpSxuJthk8SalpWGRfzQp/MfFrr4hNY1uzdJFAGp3vQJcS9UIeqHMKR82TBCllvWMCBizSyMCOuOazUvp6SfncuZRR8v0jXJUbA9oaXlge5HhuICzMtYCFkzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7IaDs7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335B6C3277B;
	Tue, 18 Jun 2024 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725267;
	bh=CJrK0+s51TojWb4uz38DIYO+IOAei4tLxpuCbpdl00c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7IaDs7M6Yli1+SoiM1yhQ+EI5uySoIl8uIxOYCAH0jpByhipRbq0r4YKhqx/k7pJ
	 KxmafVwC20DStPa5AAMGCE9DoQ4Xj64rNVnLVptLkq1ubnwee/fxvqMorbcjvbiKQ3
	 lzc2pQSvt/+0hqI/k03NCrB/RRQq2NjDLsTd4Plm5Xrdb7W1U9oyP0IQJ6+yJCnLEF
	 C1aI2JgbdROO4Z8py7QC3HWRO3ohX13KFJsCyGA0gF/icwTcMc4/eGkezN8zBrs6/W
	 1i3KoAthWUYJa9rhVAkowWC+0yh6JCxUgzofH3qQDxhg3BZaRzkME/v7UhaTSmlwq4
	 Iblj3xZ9IZ3PQ==
Date: Tue, 18 Jun 2024 16:41:02 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Avoid assigning fixed cycle counter
 with threshold
Message-ID: <20240618154102.GD2354@willie-the-truck>
References: <20240611155012.2286044-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611155012.2286044-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 11, 2024 at 09:50:12AM -0600, Rob Herring (Arm) wrote:
> If the user has requested a counting threshold for the CPU cycles event,
> then the fixed cycle counter can't be assigned as it lacks threshold
> support. Currently, the thresholds will work or not randomly depending
> on which counter the event is assigned.
> 
> While using thresholds for CPU cycles doesn't make much sense, it can be
> useful for testing purposes.
> 
> Fixes: 816c26754447 ("arm64: perf: Add support for event counting threshold")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/perf/arm_pmuv3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 23fa6c5da82c..2612be29ee23 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -939,9 +939,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
> +	bool has_threshold = !!(hwc->config_base & ARMV8_PMU_EVTYPE_TH);

Just a nit, but I don't think you need the '!!' here.

Will

