Return-Path: <linux-kernel+bounces-536946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF12A48618
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0237E7A655B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58B01D4335;
	Thu, 27 Feb 2025 17:03:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B581DDA2F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675839; cv=none; b=hq3NDoIZiLs/gMyZTnkRpgw9tMwbJmUPL77eJfdlMvzB96IBnqsOvMk4HtukXfX+H0mH9WECM7LVhXTnONWi+q3wQixYGQwjwhH3r9GyfOlaPlFqWs91BOH/7IE4GqTIEd3MD2zVJTKkPehNNN1Bu7Njk9mxuuaZkynkkELwjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675839; c=relaxed/simple;
	bh=0YCLYBIjSPadIF32crIzIKXRbc5uqe7HsLPnFMklQ5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB72ztEwfUbaLckOyzI0oYrQKKUaFdhAt0+wyZf1yZCdU/g22cGZp1YMR1OJzLMNdAZgWOxPWrEsfdWXJq0cVJvpB6m8mhC4BFeX5hWBUOddKbvTd97/WlN49byKsCVWQ4Ru3Ya112J33t06doERZmC5+iKhzkPmDF4E2mpx3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C834E1424;
	Thu, 27 Feb 2025 09:04:12 -0800 (PST)
Received: from [10.57.39.40] (unknown [10.57.39.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C4A33F5A1;
	Thu, 27 Feb 2025 09:03:55 -0800 (PST)
Message-ID: <8e0cd41d-7cb1-4b78-9cc3-d7c92e86ec0c@arm.com>
Date: Thu, 27 Feb 2025 17:03:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: realm: Use aliased addresses for device DMA
 to shared buffers
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, gshan@redhat.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-4-suzuki.poulose@arm.com> <Z8CNRqJ6dJAG0Daa@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Z8CNRqJ6dJAG0Daa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2025 16:05, Catalin Marinas wrote:
> On Thu, Feb 27, 2025 at 02:41:50PM +0000, Suzuki K Poulose wrote:
>> When a device performs DMA to a shared buffer using physical addresses,
>> (without Stage1 translation), the device must use the "{I}PA address" with the
>> top bit set in Realm. This is to make sure that a trusted device will be able
>> to write to shared buffers as well as the protected buffers. Thus, a Realm must
>> always program the full address including the "protection" bit, like AMD SME
>> encryption bits.
>>
>> Enable this by providing arm64 specific dma_addr_{encrypted, canonical}
>> helpers for Realms. Please note that the VMM needs to similarly make sure that
>> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
>> unprotected alias.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> In case this goes in via the DMA API tree:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin.

> 
> (we could bikeshed on the names like unencrypted vs decrypted but I'm
> not fussed about)

It was initially decrypted, but Robin suggested that the DMA layer 
already uses "encrypted" and "unencrypted" (e.g., 
force_dma_unencrypted(), phys_to_dma_unencrypted() etc)

Cheers
Suzuki




