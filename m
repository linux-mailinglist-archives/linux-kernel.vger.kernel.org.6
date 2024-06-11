Return-Path: <linux-kernel+bounces-210220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CD9040F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4B81F22864
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2176A3B192;
	Tue, 11 Jun 2024 16:14:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99840849
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122442; cv=none; b=XB3Tn3HxZrziCBDCeZcPzL/hHhZ+V1ExLQwpObEX9sZObgBx4R7Sg1FHWQVSW+W64m8EPA/mjmJowqkFQIP0RzF1dxnAURY0aUZHEOdAFDma1R4XVYhcBoazbQROYTEzeXS3q/i/x8DPuyukbmTwD6hl6c8aSCzFYFafNTm3M9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122442; c=relaxed/simple;
	bh=hHEd1XCnqPv5w9S7qcYKO4BTq2Rp6MstZgfwHx/ivzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppCCyYtgpdSgBhLa2dGucavut3IsI9hQcKlLQpaJy3fX17TeljwT++E0jEO6zb2R2spaKeeCEAgi4EPMU1ufpdhbWKsq8CbsAM4oO+EpoD2sB9qUUkl5GbkaqGRE1h3DBb0Tjahi5tt7FwQMsuI6rBHqHUUSnmEvXnTpvsUw29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7FD11595;
	Tue, 11 Jun 2024 09:14:23 -0700 (PDT)
Received: from [10.57.41.181] (unknown [10.57.41.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823083F73B;
	Tue, 11 Jun 2024 09:13:55 -0700 (PDT)
Message-ID: <8c55de88-96ad-45a7-9be5-4f33f4266af2@arm.com>
Date: Tue, 11 Jun 2024 17:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmuv3: Avoid assigning fixed cycle counter with
 threshold
To: "Rob Herring (Arm)" <robh@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240611155012.2286044-1-robh@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240611155012.2286044-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/06/2024 16:50, Rob Herring (Arm) wrote:
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

I was going to say doesn't it need to be (ARMV8_PMU_EVTYPE_TH |
ARMV8_PMU_EVTYPE_TC) for it to give the same results as the hardware.
But then I saw we only enable it if TH != 0, even if TC is set. And now
I'm wondering if I inadvertently disabled a useful combination of options.

The Arm ARM says it's only completely disabled when both TC and TH are 0.

>  
>  	/* Always prefer to place a cycle counter into the cycle counter. */
> -	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
> +	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) && !has_threshold) {
>  		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
>  			return ARMV8_IDX_CYCLE_COUNTER;
>  		else if (armv8pmu_event_is_64bit(event) &&

