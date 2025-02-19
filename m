Return-Path: <linux-kernel+bounces-522022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA53A3C502
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662E8189DFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B091FDE27;
	Wed, 19 Feb 2025 16:26:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456A1FA267
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982367; cv=none; b=aBkAasEcef3O41DtqyX7e61fq3Gl9YRQhQjwDI4poIDgIOC3gOMw97r7hcsIQpNZXKTMbQoZKJ74OaIBD8A0G89V9zA1DESaqz6jIgTfWgORCUBT401n8kMxa8dFh/gmnNwVEhexOtGjZrHvS/vNxJ3C7tDftAFhGnAIVYHm+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982367; c=relaxed/simple;
	bh=cRNKMwVBDiApieG+xjL/3lFQ/G1OmBO29LbAVz/Ag/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F8FOYljfjQ7QjC5OJQYDc6URBDZL3m/ESz2qCulThbL6vH560ymS5RaGfRLm3M2bWvnSuWCw1GZTPdwd44q+26WkC9v0EHMX26o29uZKYRtcrcociWaGOU1eQDvRlfetYSU+7OcK/hiHnhS8THpQNsjXLaTyq7XQWnZPNDj4Jus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4EB81682;
	Wed, 19 Feb 2025 08:26:22 -0800 (PST)
Received: from [10.57.35.204] (unknown [10.57.35.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40A3C3F6A8;
	Wed, 19 Feb 2025 08:25:58 -0800 (PST)
Message-ID: <e0a6308f-5628-4698-95a7-ec1b918358b0@arm.com>
Date: Wed, 19 Feb 2025 16:25:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
To: Ryan Roberts <ryan.roberts@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
 joey.gouly@arm.com, broonie@kernel.org, mark.rutland@arm.com,
 james.morse@arm.com, yangyicong@hisilicon.com, anshuman.khandual@arm.com,
 maz@kernel.org, liaochang1@huawei.com, akpm@linux-foundation.org,
 david@redhat.com, baohua@kernel.org, ioworker0@gmail.com,
 oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <a6846db8-9efa-46f8-9939-7727c83d1601@arm.com>
 <cbc3f62b-8890-42ca-81ff-66f1e4ea1cf3@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <cbc3f62b-8890-42ca-81ff-66f1e4ea1cf3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-19 3:43 pm, Ryan Roberts wrote:
> On 19/02/2025 15:39, Robin Murphy wrote:
>> Hi Miko,
>>
>> On 2025-02-19 2:38 pm, Mikołaj Lenczewski wrote:
>>> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
>>> and this commit adds a dedicated BBML2 cpufeature to test against
>>> support for.
>>>
>>> This is a system feature as we might have a big.LITTLE architecture
>>> where some cores support BBML2 and some don't, but we want all cores to
>>> be available and BBM to default to level 0 (as opposed to having cores
>>> without BBML2 not coming online).
>>>
>>> To support BBML2 in as wide a range of contexts as we can, we want not
>>> only the architectural guarantees that BBML2 makes, but additionally
>>> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
>>> us having to prove that no recursive faults can be induced in any path
>>> that uses BBML2, allowing its use for arbitrary kernel mappings.
>>> Support detection of such CPUs.
>>
>> If this may be used for splitting/compacting userspace mappings, then similarly
>> to 6e192214c6c8 ("iommu/arm-smmu-v3: Document SVA interaction with new pagetable
>> features"), strictly we'll also want a check in arm_smmu_sva_supported() to make
>> sure that the SMMU is OK with BBML2 behaviour too, and disallow SVA if not. Note
>> that the corresponding SMMUv3.2-BBML2 feature is already strict about TLB
>> conflict aborts, so is comparatively nice and straightforward.
> 
> Thanks for catching this, Robin, as I completely forgot to pass this onto Miko
> yesterday after our conversation. I suggest we tack a commit on to the end of
> this series to cover that?
> 
> I think that strictly this is not needed for Yang's series since that only uses
> BBML2 for kernel mappings, and those pgtables would never be directly shared
> with the SMMU.

Yup, it's really more just a theoretical correctness concern - certainly 
Arm's implementations from MMU-700 onwards do support BBML2, while 
MMU-600 is now sufficiently old that nobody is likely to pair it with 
new BBML-capable CPUs anyway - so it's just to cover the gap that in 
principle there may be 3rd-party implementations which might get confused.

Cheers,
Robin.

