Return-Path: <linux-kernel+bounces-347298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525598D0A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA530281D05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37611E4121;
	Wed,  2 Oct 2024 09:59:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1971E201E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863150; cv=none; b=luuIc+jUGAi2CKaybQrU/gN7+w22XF2eflIgbFRy08jdHRkBnYn+davwn5fmTqfiS6RuZM1PJzLIfodYWb9cAUHxX96zBNQ3DLnu1+/vSG9z2f7/pktpMyjVPRMTuKKh80AIJRlnFWI1B5IyNh1mwAXB5TyUKcR4mtp1+sWlck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863150; c=relaxed/simple;
	bh=92k9H3SoCJvOgSzwmnCgjmlnGrCmVPVXyZWT9W0qTZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWYeJJyCKmrpoQIF7WcHVYAaKUmyicbg6r1XTIChj9/Y72f9wOirWT1503tYAoQeAv40BllaCqKTnl/pHGzVpD/h9XIgaLiwWv7gobUrHLYAkibRzXJRNo0wYTloQeWLkopBSnK62RTDP+VYUXACapNcWgCaEKZSkfr2eaHSyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B724339;
	Wed,  2 Oct 2024 02:59:37 -0700 (PDT)
Received: from [10.57.75.246] (unknown [10.57.75.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FEA43F587;
	Wed,  2 Oct 2024 02:59:06 -0700 (PDT)
Message-ID: <99cee26b-351e-4bc3-81a8-ec8ced373770@arm.com>
Date: Wed, 2 Oct 2024 10:59:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Yang Shi <yang@os.amperecomputing.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <ZvxNo8ZWeyBOBU8b@Asurada-Nvidia>
 <742bd6d6-9d25-4f8c-9574-3d39a91c89cb@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <742bd6d6-9d25-4f8c-9574-3d39a91c89cb@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-01 8:48 pm, Yang Shi wrote:
> 
> 
> On 10/1/24 12:29 PM, Nicolin Chen wrote:
>> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>> On 10/1/24 11:27 AM, Nicolin Chen wrote:
>>>> On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
>>>>> Using 64 bit immediate when doing shift can solve the problem.  The
>>>>> disssembly after the fix looks like:
>>>> [...]
>>>>
>>>>>           unsigned int last_sid_idx =
>>>>> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>>>>> +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
>>>> Could a 32-bit build be a corner case where UL is no longer a
>>>> "64 bit" stated in the commit message?
>>> It shouldn't. Because smmu v3 depends on ARM64.
>>>
>>> config ARM_SMMU_V3
>>>          tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>>>          depends on ARM64
>> ARM64 can have aarch32 support. I am not sure if ARM64 running a
>> 32-bit OS can be a case though, (and not confined to AmpereOne).
> 
> I don't think ARM64 runs 32-bit kernel, at least for newer kernel.

Just use ULL - if the point is that it must be a 64-bit shift for 
correctness, then being clear about that intent is far more valuable 
than saving one character of source code.

Thanks,
Robin.

> 
>>
>>>> Then, can ssid_bits/s1cdmax be a concern similarly?
>>> IIUC, ssid_bits is determined by IDR1_SSIDSIZE. It is GENMASK(10, 6). So
>>> it shouldn't be 32. IDR1_SIDSIZE is GENMASK(5, 0).
>> Rechecked the RM. Yea, max sid can be 32 but max ssid is 20 at
>> this moment, so we should be safe.
>>
>> Thanks
>> Nicolin
> 

