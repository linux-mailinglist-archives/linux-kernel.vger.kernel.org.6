Return-Path: <linux-kernel+bounces-290224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C89550E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331BC1C216DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F71C37A1;
	Fri, 16 Aug 2024 18:33:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1871C231F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833196; cv=none; b=SRdoDcnXWrF2FX7lJBS+WfER2t6EqQ6KkdiQ9/0D6yaVo3Y/fP1a8aK+ZZfP1v3vasn0qBWK1TZfv3IDYPbAWbjQzaK6mrSeK381IM1DY1EOLqPL8x+214oU3gqqhwLtiu+CQtFv/Lej24fWCXU7fY1DmraxQInnTQHsUo46XpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833196; c=relaxed/simple;
	bh=HgrFxERRhvFkyAKVdhaZs5z2jyxxDEf3sl0uhCt50Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAlAWlOxsRDrG/zcW/sSA1f0E86CZu+zK4+uZlzZ6shf1SbrFXBdMuOkbs4zHmKE+R9+Jp6hRKU3urV0IWernUVRf/vLsR5Qtse3tI6x0qnNlsjLXDfaAznJuwhyBAZNyxBudzs4Yn7IhMZulLz0acZzjMZj2wuUyBECkNLfUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3022913D5;
	Fri, 16 Aug 2024 11:33:39 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF303F6A8;
	Fri, 16 Aug 2024 11:33:12 -0700 (PDT)
Message-ID: <d506e4cc-fa7f-4881-885b-e2665c063524@arm.com>
Date: Fri, 16 Aug 2024 19:33:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] perf/arm-cmn: Fix CCLA register offset
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
References: <cover.1723229941.git.robin.murphy@arm.com>
 <e73b31da42a7840d4247fc8a4a3cea805c2ab618.1723229941.git.robin.murphy@arm.com>
 <Zr8jJq3l9sfvJuil@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr8jJq3l9sfvJuil@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:00 am, Mark Rutland wrote:
> On Fri, Aug 09, 2024 at 08:15:41PM +0100, Robin Murphy wrote:
>> Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
>> the CCLA_RNI combination type.
> 
> Was there some reason we used to think that was specific to CCLA_RNI
> nodes, or was that just an oversight?

I imagine it was just oversight/confusion helped by the original r0p0 
TRM listing both a por_ccla_pmu_event_sel and a 
por_ccla_rni_pmu_event_sel as CCLA registers, which I could well believe 
I misread at a glance while scrolling up and down.

> Looking at the CMN-700 TRM and scanning for pmu_event_sel, we have:
> 
> 	16'h2000	por_ccg_ha_pmu_event_sel
> 	16'h2000	por_ccg_ra_pmu_event_sel
> 	16'h2008	por_ccla_pmu_event_sel
> 	16'h2000	por_dn_pmu_event_sel
> 	16'h2000	cmn_hns_pmu_event_sel
> 	16'h2000	por_hni_pmu_event_sel
> 	16'h2008	por_hnp_pmu_event_sel
> 	16'h2000	por_mxp_pmu_event_sel
> 	16'h2000	por_rnd_pmu_event_sel
> 	16'h2000	por_rni_pmu_event_sel
> 	16'h2000	por_sbsx_pmu_event_sel
> 
>> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index fd2122a37f22..0e2e12e2f4fb 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2393,10 +2393,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>   			case CMN_TYPE_CXHA:
>>   			case CMN_TYPE_CCRA:
>>   			case CMN_TYPE_CCHA:
>> -			case CMN_TYPE_CCLA:
>>   			case CMN_TYPE_HNS:
>>   				dn++;
>>   				break;
>> +			case CMN_TYPE_CCLA:
>> +				dn->pmu_base += CMN_HNP_PMU_EVENT_SEL;
>> +				dn++;
>> +				break;
> 
> When reading this for the first time, it looks like a copy-paste error
> since CMN_HNP_PMU_EVENT_SEL doesn't have any obvious relationship with
> CCLA nodes.
> 
> I reckon it'd be worth adding CMN_CCLA_PMU_EVENT_SEL, and replacing the
> existing comment above the definition of CMN_HNP_PMU_EVENT_SEL, e.g.
> 
> /*
>   * Some nodes place common registers at different offsets from most
>   * other nodes.
>   */
> #define CMN_HNP_PMU_EVENT_SEL		0x008
> #define CMN_CCLA_PMU_EVENT_SEL		0x008
> 
> That way the switch looks less suspicious, and the comment is a bit more
> helpful to anyone trying to figure out what's going on here.

Sure, that's a reasonable argument.

> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Robin.

> 
> Mark.
> 
>>   			/* Nothing to see here */
>>   			case CMN_TYPE_MPAM_S:
>>   			case CMN_TYPE_MPAM_NS:
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>

