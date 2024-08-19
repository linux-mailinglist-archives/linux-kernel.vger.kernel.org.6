Return-Path: <linux-kernel+bounces-292329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94822956E07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B3B2119F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCC1741D9;
	Mon, 19 Aug 2024 15:00:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001171DFED
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079610; cv=none; b=FmaGYIPEcOV45n+0zlNyTsAnm4PIJaxf04PDOAr6bpNcKIs9HnZ1cECwKHar0aqTRlEW/YzPs2Ry4nho1JsUTDGDHCDMFFI1nnpTRXl2vlHGeI8e12xoLaA6RUYI5zTG2+z8xFeBd1KH9SPTxTzvOXokLCN+52YzZgE6hsePqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079610; c=relaxed/simple;
	bh=Z8if3g9zQzvNPE9F7WfLwz97ZeehQ8yIUhYPcUGuPj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHsFmBemjA6xXI4qrYsCUStjdt7nHg29xITnvaWVNqpNOJ917ukw2+LzqlySipBUNbLo6ZBU9g/a0RhrS0z16DEghmaQ0xPuCl9q8H5dr2nSimDDFHHel0/qOzQ4Bz2aX5K5Lbi4Ea9qwSawyDDmBXObeMJpPZkt+YlY8SP6b58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430B1339;
	Mon, 19 Aug 2024 08:00:34 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75AA73F66E;
	Mon, 19 Aug 2024 08:00:07 -0700 (PDT)
Message-ID: <22b69400-af16-4e78-8f72-c10564d7cc6c@arm.com>
Date: Mon, 19 Aug 2024 16:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] perf/arm-cmn: Ensure dtm_idx is big enough
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
References: <cover.1723229941.git.robin.murphy@arm.com>
 <aa9d45b10814dc6b2c59dfb2c1be49f333dae1dc.1723229941.git.robin.murphy@arm.com>
 <Zr8ma7pt7te0qxNG@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr8ma7pt7te0qxNG@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:14 am, Mark Rutland wrote:
> On Fri, Aug 09, 2024 at 08:15:42PM +0100, Robin Murphy wrote:
>> While CMN_MAX_DIMENSION was bumped to 12 for CMN-650, that only supports
>> up to a 10x10 mesh, so bumping dtm_idx to 256 bits at the time worked
>> out OK in practice. However CMN-700 did finally support up to 144 XPs,
>> and thus needs a worst-case 288 bits of dtm_idx for an aggregated XP
>> event on a maxed-out config. Oops.
>>
>> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 0e2e12e2f4fb..c9a2b21a7aec 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -563,7 +563,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>>   
>>   struct arm_cmn_hw_event {
>>   	struct arm_cmn_node *dn;
>> -	u64 dtm_idx[4];
>> +	u64 dtm_idx[5];
> 
> Can't we size this based on CMN_MAX_DIMENSION (or CMN_MAX_XPS or
> CMN_MAX_DTMS), to make that clear?

Fair enough, I did go back and forth a little on that idea, but reached 
the opposite conclusion that documenting this with the assert to 
deliberately make it *not* look straightforward was nicer than wrestling 
with an accurate name for the logical quantity here, which strictly 
would be something like CMN_MAX_NODES_PER_TYPE_WE_CARE_ABOUT (there can 
already be up to 256 RN-Fs, but those aren't visible to the PMU).

I'll have another think on that approach - I do concur that the assert 
isn't *functionally* any better than automatically sizing the array.

Thanks,
Robin.

>  From the desciription in the commit message it sounds like you need 2 *
> CMN_MAX_XPS bits, i.e.
> 
> 	#define DTM_IDX_BITS	(2 * CMN_MAX_XPS)
> 
> 	u64 dtm_idx[DIV_ROUND_UP(DTM_IDX_BITS, 64)];
> 
> Mark.
> 
>>   	s8 dtc_idx[CMN_MAX_DTCS];
>>   	u8 num_dns;
>>   	u8 dtm_offset;
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>

