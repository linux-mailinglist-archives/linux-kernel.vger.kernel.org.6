Return-Path: <linux-kernel+bounces-216924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94390A8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B001C211EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82ED190496;
	Mon, 17 Jun 2024 08:39:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362319048B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613575; cv=none; b=ZHcBX8Oht5avyUF17z04y/rwoVJdHtrcBKYxk8CMbMWmGHlVTKAz0ONnOPhLSoo4Uur987JMVY25WBM3tKJ1pOiurXkxYnvm+ffYKwuQBmnXiFt5WdYE0PqRW/6ar4mgcBwwYw2qXuXk1i4QqPQ5DChzNjg4mLLuPmoJhyrpd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613575; c=relaxed/simple;
	bh=68gVcPJPwkAvKmwvYBmrBCVBXLWxg+lDjFNwSP7LpZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSRmBYNRLG9EAhTrn0FNKvY+j8qBdl+lRDPyYrFZR6p+O8+h7nAYsSFXPswpKGEqqivzWy5spbDZ2zQPcVy2+NS9C4fjcfriZ96w0T+9sOQFX21Bb4i3CFLD/C3NIksqnOZiWwwWw7fQfn3xDWq+/50+h8fFWc0C5sj+VLltAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1087FDA7;
	Mon, 17 Jun 2024 01:39:57 -0700 (PDT)
Received: from [10.162.16.42] (a077893.blr.arm.com [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 675723F64C;
	Mon, 17 Jun 2024 01:39:30 -0700 (PDT)
Message-ID: <cea3ced2-b8b3-426b-8c40-a47881a5bff6@arm.com>
Date: Mon, 17 Jun 2024 14:09:27 +0530
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
 <86y179jdbx.wl-maz@kernel.org> <ca66f7ac-97d5-474d-bec4-d0ff79c08eaa@arm.com>
 <87cyoj3j44.wl-maz@kernel.org> <45ace175-9b59-4ba2-91b8-b96151c03c05@arm.com>
 <86iky8j9ow.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <86iky8j9ow.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/17/24 13:13, Marc Zyngier wrote:
> On Mon, 17 Jun 2024 04:15:40 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Does the following re-worked patch looks okay ? Earlier set_thread_esr() changes
>> can be dropped from arch/arm64/mm/fault.c and also the original commit message
>> still makes sense.
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index 7abf09df7033..6cd13ac61005 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -121,6 +121,13 @@
>>  #define ESR_ELx_FSC_SECC       (0x18)
>>  #define ESR_ELx_FSC_SECC_TTW(n)        (0x1c + (n))
>>  
>> +/* Status codes for individual page table levels */
>> +#define ESR_ELx_FSC_ACCESS_L(n)        (ESR_ELx_FSC_ACCESS + n)
>> +#define ESR_ELx_FSC_FAULT_nL   (0x2C)
>> +#define ESR_ELx_FSC_FAULT_L(n) (((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
>> +                                           ESR_ELx_FSC_FAULT) + (n))
>> +#define ESR_ELx_FSC_PERM_L(n)  (ESR_ELx_FSC_PERM + n)
>> +
>>  /* ISS field definitions for Data Aborts */
>>  #define ESR_ELx_ISV_SHIFT      (24)
>>  #define ESR_ELx_ISV            (UL(1) << ESR_ELx_ISV_SHIFT)
>> @@ -388,20 +395,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
>>  
>>  static inline bool esr_fsc_is_translation_fault(unsigned long esr)
>>  {
>> -       /* Translation fault, level -1 */
>> -       if ((esr & ESR_ELx_FSC) == 0b101011)
>> -               return true;
>> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
>> +       esr = esr & ESR_ELx_FSC;
>> +
>> +       return (esr == ESR_ELx_FSC_FAULT_L(3)) ||
>> +              (esr == ESR_ELx_FSC_FAULT_L(2)) ||
>> +              (esr == ESR_ELx_FSC_FAULT_L(1)) ||
>> +              (esr == ESR_ELx_FSC_FAULT_L(0)) ||
>> +              (esr == ESR_ELx_FSC_FAULT_L(-1));
>>  }
>>  
>>  static inline bool esr_fsc_is_permission_fault(unsigned long esr)
>>  {
>> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
>> +       esr = esr & ESR_ELx_FSC;
>> +
>> +       return (esr == ESR_ELx_FSC_PERM_L(3)) ||
>> +              (esr == ESR_ELx_FSC_PERM_L(2)) ||
>> +              (esr == ESR_ELx_FSC_PERM_L(1)) ||
>> +              (esr == ESR_ELx_FSC_PERM_L(0));
>>  }
>>  
>>  static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
>>  {
>> -       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
>> +       esr = esr & ESR_ELx_FSC;
>> +
>> +       return (esr == ESR_ELx_FSC_ACCESS_L(3)) ||
>> +              (esr == ESR_ELx_FSC_ACCESS_L(2)) ||
>> +              (esr == ESR_ELx_FSC_ACCESS_L(1)) ||
>> +              (esr == ESR_ELx_FSC_ACCESS_L(0));
>>  }
>>  
>>  /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
> 
> This looks better indeed.

Thanks Marc.

Hello Mark/Ryan,

Could I still keep your tags for the patch, or it's better to just
drop them as there are some new changes being folded in. Please do
advise. Thank you.

- Anshuman

