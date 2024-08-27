Return-Path: <linux-kernel+bounces-302447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7659C95FE86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A7E1C212DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F97BA49;
	Tue, 27 Aug 2024 01:52:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8718F58;
	Tue, 27 Aug 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723547; cv=none; b=NeFqdVyBIv7nQT5qKm0fWi57zFxjasA+YJomdBp3YO1XuLEDMRSpx7lVP2VHbiUbFWQWXKycEi9q38S3wy0Y2/DyNBMAd8zNpgbBJLnRIA+Ii9hwSl/jzaEgo4S3HeCARrW+LdiydNR10Z6u70cUxaW2UsgZ4Lp2Mg2hR6PTd7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723547; c=relaxed/simple;
	bh=UqQwOrDy3fbpOnLiLj0AnhcuqgiOkrrn5adE3OLf6fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2kx+PonoTAqS7HIMgKRCmEFCnLsSBdYUhReQT1zIwquGK0tBbxfM+RXyYnaUvgaU3UyVAp0/WeG9HJhHN7YB9QBI+jtryAOav70gnog2wvNd5Gj+mitXZC8sEScU7CIOlNW4xCP0AIHfMbDBn0Sv9dl/wkCIAkh/1CXq3aoiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66C0DA7;
	Mon, 26 Aug 2024 18:52:49 -0700 (PDT)
Received: from [10.163.61.7] (unknown [10.163.61.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407B63F66E;
	Mon, 26 Aug 2024 18:52:18 -0700 (PDT)
Message-ID: <314b8893-2ffd-4148-974b-725cfaa97d18@arm.com>
Date: Tue, 27 Aug 2024 07:22:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: errata: Enable the AC03_CPU_38 workaround for
 ampere1a
To: Oliver Upton <oliver.upton@linux.dev>,
 D Scott Phillips <scott@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Besar Wicaksono <bwicaksono@nvidia.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Rob Herring <robh@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20240826215933.1263453-1-scott@os.amperecomputing.com>
 <Zs0OelXKn_-6jtqN@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zs0OelXKn_-6jtqN@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 04:53, Oliver Upton wrote:
> Hi D Scott,
> 
> On Mon, Aug 26, 2024 at 02:59:33PM -0700, D Scott Phillips wrote:
>> The ampere1a cpu is affected by erratum AC04_CPU_10 which is the same
>> bug as AC03_CPU38. Add ampere1a to the AC03_CPU_38 workaround midr list.
>>
>> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
>> ---
>>  Documentation/arch/arm64/silicon-errata.rst | 2 ++
>>  arch/arm64/Kconfig                          | 2 +-
>>  arch/arm64/include/asm/cputype.h            | 2 ++
>>  arch/arm64/kernel/cpu_errata.c              | 1 +
>>  4 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
>> index 50327c05be8d1..39c52385f11fb 100644
>> --- a/Documentation/arch/arm64/silicon-errata.rst
>> +++ b/Documentation/arch/arm64/silicon-errata.rst
>> @@ -55,6 +55,8 @@ stable kernels.
>>  +----------------+-----------------+-----------------+-----------------------------+
>>  | Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
>>  +----------------+-----------------+-----------------+-----------------------------+
>> +| Ampere         | AmpereOne AC04  | AC04_CPU_10     | AMPERE_ERRATUM_AC03_CPU_38  |
>> ++----------------+-----------------+-----------------+-----------------------------+
> 
> We tend to stick the marketing term for a part in the second column so
> it is more recognizable for the user. Is this a placeholder for something
> different from "ampere1a"?

Agreed, even the MIDR being added here is for AMPERE1A. Probably something
like 'AmpereOneA' might be more suitable.

> 
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index f6b6b45073571..748aa536446ae 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -773,6 +773,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>  		.desc = "AmpereOne erratum AC03_CPU_38",
>>  		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
>>  		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> +		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> 
> This will break the workaround on AC03, since the second macro reassigns
> ::midr_range.
> 
> You'll want to use ERRATA_MIDR_RANGE_LIST() instead w/ an array of
> affected MIDRs.
> 

+1

Although ERRATA_MIDR_RANGE_LIST() in turn creates such a list.

