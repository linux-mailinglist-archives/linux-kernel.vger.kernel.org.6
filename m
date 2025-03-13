Return-Path: <linux-kernel+bounces-559313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BEA5F23E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3DC18984B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897B26618B;
	Thu, 13 Mar 2025 11:22:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F861D7984;
	Thu, 13 Mar 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864936; cv=none; b=E3sT1G4TivZBQUqFMibWLGQDFnj5Q9/LRfizgTwX/mVaQSEI/5KI5ts0+LviiZvaZFElo7slPVnrYembMlmWymsnbqifTqls9GRIpExPT2T4zjcnsOMrslnz64kG56cPnjXYygUnsrheEhQzVhyta0z6IC6lBhpfFGAHci+2/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864936; c=relaxed/simple;
	bh=4t6ekqbYxOtMNjNf7aNb9zZJ5HroBgVFvfHr43bQgpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T3T/cfW0sHnCWy3VEaWWSl6mqJ3Q1QIjjBZKC4WplD/2HTgIDCs1rBAYDb8CjXnwdJT4Bs/5v9Qt88DkNCnlRMjDZse0yFvXZT/QJNYgR3020GYVaho75B+pdwl1867grmZqJFXJxi/aubCcvEFCYSmSaqu6e7QPalata9uwHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0171C00;
	Thu, 13 Mar 2025 04:22:24 -0700 (PDT)
Received: from [10.1.32.45] (Suzukis-MBP.cambridge.arm.com [10.1.32.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C09D33F673;
	Thu, 13 Mar 2025 04:22:08 -0700 (PDT)
Message-ID: <e8749c86-fe93-4123-aa2e-5677e7a2c695@arm.com>
Date: Thu, 13 Mar 2025 11:22:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Initial BBML2 support for contpte_convert()
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
 oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, shameerali.kolothum.thodi@huawei.com,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250313104111.24196-2-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miko,

On 13/03/2025 10:41, Mikołaj Lenczewski wrote:
> Hi All,
> 
> This patch series adds adding initial support for eliding
> break-before-make requirements on systems that support BBML2 and
> additionally guarantee to never raise a conflict abort.
> 
> This support elides a TLB invalidation in contpte_convert(). This
> leads to a 12% improvement when executing a microbenchmark designed
> to force the pathological path where contpte_convert() gets called.
> This represents an 80% reduction in the cost of calling
> contpte_convert().
> 
> This series is based on v6.14-rc4 (d082ecbc71e9).
> 
> Patch 1 implements an allow-list of cpus that support BBML2, but with
> the additional constraint of never causing TLB conflict aborts. We
> settled on this constraint because we will use the feature for kernel
> mappings in the future, for which we cannot handle conflict aborts
> safely.
> 
> Yang Shi has a series at [1] that aims to use BBML2 to enable splitting
> the linear map at runtime. This series partially overlaps with it to add
> the cpu feature. We believe this series is fully compatible with Yang's
> requirements and could go first.
> 

Nothing about the patch functionality, but :

Minor nit: Generally it is a good idea to add "What changed" from the
previous posting.  That gives the reviewers an idea of what to look for
in the new version. Something like:

Changes since V2:
  {Adding a link to the posting is an added bonus, as we can look up the 
discussions easily}
  - blah blah
  - ..


Cheers
Suzuki


> [1]:
>    https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/
> 
> Mikołaj Lenczewski (3):
>    arm64: Add BBM Level 2 cpu feature
>    iommu/arm: Add BBM Level 2 smmu feature
>    arm64/mm: Elide tlbi in contpte_convert() under BBML2
> 
>   .../admin-guide/kernel-parameters.txt         |  3 +
>   arch/arm64/Kconfig                            | 11 +++
>   arch/arm64/include/asm/cpucaps.h              |  2 +
>   arch/arm64/include/asm/cpufeature.h           |  6 ++
>   arch/arm64/kernel/cpufeature.c                | 76 +++++++++++++++++++
>   arch/arm64/kernel/pi/idreg-override.c         |  2 +
>   arch/arm64/mm/contpte.c                       |  3 +-
>   arch/arm64/tools/cpucaps                      |  1 +
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +
>   11 files changed, 113 insertions(+), 1 deletion(-)
> 


