Return-Path: <linux-kernel+bounces-214224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D65908195
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201DD283B66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A31836C7;
	Fri, 14 Jun 2024 02:25:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A114532B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331901; cv=none; b=IQB5HzFnz5rohIDPm40uC007D/zF++fw2WpY56hLxvxcEkc1DLkai+KPVwZxFloclcwUixdaW/5zENDUU3cWddXTn1vxWk4G6W6OOlvmu1+KpaZRr4Gh3CQXpEWbGR42kGCe7lMHAKwtRUMerbBTnQZN9baorD1qkXrVdZ16eyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331901; c=relaxed/simple;
	bh=/Xs1YwUSUUPtBTM3JJOUhEixbPf3wiUKxyU+gNVx/Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnI58idG483xn/U2tSzcqdU6o7VAFVnUNAVVCzukclQmPzHb2sXn64JEuamfZC9mAUJE+qpUmW5bP3ujAQ/kA+Y3SaVi4rFe9Oa2Uz8wayIRnzCE4HcLx5htBTWcDLW0QuXfaPVu2Zjcmdcgqm6GGmMCnhxq/C+WxzjFP0cr9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB4DFEC;
	Thu, 13 Jun 2024 19:25:22 -0700 (PDT)
Received: from [10.162.16.42] (a077893.blr.arm.com [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FFCA3F73B;
	Thu, 13 Jun 2024 19:24:55 -0700 (PDT)
Message-ID: <ca66f7ac-97d5-474d-bec4-d0ff79c08eaa@arm.com>
Date: Fri, 14 Jun 2024 07:54:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop ESR_ELx_FSC_TYPE
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
 ryan.roberts@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20240613094538.3263536-1-anshuman.khandual@arm.com>
 <86y179jdbx.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86y179jdbx.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 16:53, Marc Zyngier wrote:
> On Thu, 13 Jun 2024 10:45:38 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Fault status codes at page table level 0, 1, 2 and 3 for access, permission
>> and translation faults are architecturally organized in a way, that masking
>> out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.
>>
>> Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
>> out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
>> code as the kernel does not yet care about the page table level, the fault
>> really occurred previously.
>>
>> This scheme is starting to crumble after FEAT_LPA2 when level -1 got added.
>> Fault status code for translation fault at level -1 is 0x2B which does not
>> follow ESR_ELx_FSC_TYPE, requiring esr_fsc_is_translation_fault() changes.
>>
>> This changes above helpers to compare against individual fault status code
>> values for each page table level and drop ESR_ELx_FSC_TYPE which is losing
>> its value as a common mask.
> 
> I'd rather we do not drop the existing #defines, for a very
> self-serving reason:
> 
> NV requires an implementation to synthesise fault syndromes, and these
> definition are extensively used to compose the syndrome information
> (see the NV MMU series at [1]). This is also heavily use to emulate
> the AT instructions (fault reporting in PAR_EL1.FST).
> 
> Having additional helpers is fine. Dropping the base definitions
> isn't, and I'd like to avoid reintroducing them.

You would like to just leave behind all the existing level 0 syndrome macro
definitions in place ?

#define ESR_ELx_FSC_ACCESS	(0x08)
#define ESR_ELx_FSC_FAULT	(0x04)
#define ESR_ELx_FSC_PERM	(0x0C)

Or which are rather

#define ESR_ELx_FSC_ACCESS	ESR_ELx_FSC_ACCESS_L0
#define ESR_ELx_FSC_FAULT	ESR_ELx_FSC_FAULT_L0
#define ESR_ELx_FSC_PERM	ESR_ELx_FSC_PERM_L0

But just wondering why cannot ESR_ELx_FSC_[ACCESS|FAULT|PERM]_L0 definitions
be used directly in new use cases ?

> 
> Thanks,
> 
> 	M.
> 
> [1] http://lore.kernel.org/r/20240529145628.3272630-1-maz@kernel.org
> 

