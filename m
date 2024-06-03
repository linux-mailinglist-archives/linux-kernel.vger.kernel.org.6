Return-Path: <linux-kernel+bounces-198857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B88D7E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162761F261A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435E7F47B;
	Mon,  3 Jun 2024 09:19:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D57E578;
	Mon,  3 Jun 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406348; cv=none; b=LMDMEZhmVwArahehP1kZG39Rglxgl+M8IDCU0rOzqzdWK98lylmgAiFxTR8rM7ikMNcPKUJ1Dygy3Berrku4Iw0BxS3GrDXB0CE7DqDTYZ4AwwV37gQwCy9to5Ik29inCKwQswVvjd49ZiBDdeP5UEJQ0x2TrmVbvlEnDvjvUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406348; c=relaxed/simple;
	bh=l785HARD+DLcBMHmLKzWbf+2EKXjqAS1tV9yvrR4t+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpk5/C5POpqgdieIly+ugJx+F9+w/2K4mDZdgZAKsHYkdSO8OeTAtuZ76XS9mMwMA1Yd7qWhnEthAgtzIPKlY7yrPPOx9KWBhXddrjt0Arctg7q1PB1n0zuL6Zh+hMLMbSEEbf83NJJ1Np2W2ubhDYeDs5XpUiUebpYg+zwkHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A551042;
	Mon,  3 Jun 2024 02:19:30 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D47E3F762;
	Mon,  3 Jun 2024 02:19:01 -0700 (PDT)
Message-ID: <eab504ab-1563-4235-aef0-62525b2813eb@arm.com>
Date: Mon, 3 Jun 2024 14:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To: James Clark <james.clark@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <5f8fdfd2-a4f9-4fde-ad24-3b76231e61c8@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5f8fdfd2-a4f9-4fde-ad24-3b76231e61c8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 15:33, James Clark wrote:
> 
> 
> On 05/04/2024 03:46, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> the relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on 6.9-rc2.
>>
>> Also this series is being hosted below for quick access, review and test.
>>
>> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
>>
>> There are still some open questions regarding handling multiple perf events
>> with different privilege branch filters getting on the same PMU, supporting
>> guest branch stack tracing from the host etc. Finally also looking for some
>> suggestions regarding supporting BRBE inside the guest. The series has been
>> re-organized completely as suggested earlier.
> 
> For guest support I'm still of this opinion:
> 
>   * No support for the host looking into guests (the addresses don't
>     make sense anyway without also running Perf record in the guest)
>   * Save and restore the host buffer and registers on guest switch (if
>     it was ever used by either host or guest)
>   * Let the guest do whatever it wants with BRBE without any
>     virtualisation
> 
> Merging this with the current PMU virtualistion stuff seems like a lot
> of work for no use case (host looking into guests). Having said that, it
> might not even be worth discussing on this patchset apart from "no guest
> support", and we can do it later to avoid confusion that it's being
> proposed for this version.

Agreed, let's just have "no guest support" for now in this proposed series
without any more additional changes to keep things simpler and separated.
I will also update the cover letter next time around making this clear.

