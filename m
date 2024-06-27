Return-Path: <linux-kernel+bounces-231833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90788919EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C89B1F25F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5E1D531;
	Thu, 27 Jun 2024 05:53:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89F23759
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467595; cv=none; b=PSHJ17o/xDOSykYXpH7hYshSupU2C9dTNnrXD5AaALTQtux/LwmsE20fGxzPZkmYPr07h7b5wDT8F/PBw/K6mrIPhNUMckV9LhNO0OgPED9Dfa17TnY/VMau3xuFUTFvM7AdLcz9CX+ouyk+ap1pNfaLfVdTPxdYcfbYDsi94wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467595; c=relaxed/simple;
	bh=LtfJVn/zBNB45Oqgv6+R9DcVS1Ch7Szo9+0AZ9ig5GU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F+gtuugZMWC2Icjd6TTote294jcRwGUDmk3YYZZp9nvOK+1RP2AAfVZargbC4x6HtEV3abafnfEsZA81Z4DxBleNWDwCzH5odPqdqUqI3X7yuIckNPa3O5nvrAw/MMlVKHPMhe8MWiA7xdtfTWbOVL44XHmgqwW9JPaSSxHIebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A21E367;
	Wed, 26 Jun 2024 22:53:36 -0700 (PDT)
Received: from [10.163.47.90] (unknown [10.163.47.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5E03F6A8;
	Wed, 26 Jun 2024 22:53:07 -0700 (PDT)
Message-ID: <1259a298-f038-4b29-99ea-9158d2f26cfd@arm.com>
Date: Thu, 27 Jun 2024 11:23:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] arm64: Drop
 ID_AA64PFR0_EL1_ELx_[64BIT_ONLY|32BIT_64BIT]
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, ryan.roberts@arm.com, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240613102710.3295108-1-anshuman.khandual@arm.com>
 <ba9b51db-5e8a-4e89-ad6a-046133dfc657@arm.com>
Content-Language: en-US
In-Reply-To: <ba9b51db-5e8a-4e89-ad6a-046133dfc657@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/20/24 08:54, Anshuman Khandual wrote:
> 
> 
> On 6/13/24 15:57, Anshuman Khandual wrote:
>> This series replaces custom macros usage for ID_AA64PFR0_EL1_ELx_64BIT_ONLY
>> and ID_AA64PFR0_EL1_ELx_32BIT_64BIT fields, thus finally just dropping them
>> off completely. This series applies on v6.10-rc3
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-kernel@vger.kernel.org
>>
>> Changes in V2:
>>
>> - Replaced FIELD_PREP() with SYS_FIELD_PREP_ENUM() as per Marc
> 
> Gentle ping, any updates for this series ?

Gentle ping again, any updates on this ?

> 
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20240418053804.2573071-1-anshuman.khandual@arm.com/
>>
>> Anshuman Khandual (2):
>>   KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
>>   arm64/cpufeature: Replace custom macros with fields from ID_AA64PFR0_EL1
>>
>>  arch/arm64/include/asm/cpufeature.h            |  4 ++--
>>  arch/arm64/include/asm/sysreg.h                |  4 ----
>>  arch/arm64/kernel/cpufeature.c                 |  4 ++--
>>  arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 10 +++++-----
>>  arch/arm64/kvm/hyp/nvhe/pkvm.c                 |  4 ++--
>>  arch/arm64/kvm/hyp/nvhe/sys_regs.c             |  2 +-
>>  6 files changed, 12 insertions(+), 16 deletions(-)
>>
> 

