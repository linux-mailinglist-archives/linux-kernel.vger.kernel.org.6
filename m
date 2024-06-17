Return-Path: <linux-kernel+bounces-216671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52990A2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9588C1F212EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E12AEE7;
	Mon, 17 Jun 2024 03:15:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FC525D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594149; cv=none; b=pkgVQOBNTlMOw5J0I1muMaIkgHganm2uZnhQst7noRWzuARFwcFo+YdUviF85xj8874wyCWm4KiStVR+bOnO/mjhS/Lm1E9V4cXDLtzCF92JUjjWFDfvU4Gj2S3jWQT7rheowxvOUPfwrMbbPSbuehckwOV7O38tteS4EsZsDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594149; c=relaxed/simple;
	bh=1j6p55vBlNCJgLlqV3Y4Fx7zTQqVUitS2ZmVWzWuBMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngi3f0Z7KL2A260/eOQF80vWdEyfAAhJ412AoFJeupLnJT+KSRCtFVA+9/FUNz1Kbta5PY+rmL5ElJdqEZiNd4Xy2ivN0gHi18WpSYZx2470zl3gBU8QQh0lB/jLYd8cWrgM5yy42iCJ3fTnp2rsA2OMJvJAfXA/aRHjsznaHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02283DA7;
	Sun, 16 Jun 2024 20:16:10 -0700 (PDT)
Received: from [10.162.16.42] (a077893.blr.arm.com [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D673F73B;
	Sun, 16 Jun 2024 20:15:43 -0700 (PDT)
Message-ID: <45ace175-9b59-4ba2-91b8-b96151c03c05@arm.com>
Date: Mon, 17 Jun 2024 08:45:40 +0530
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
 <87cyoj3j44.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87cyoj3j44.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 16:07, Marc Zyngier wrote:
> On Fri, 14 Jun 2024 03:24:53 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>> On 6/13/24 16:53, Marc Zyngier wrote:
>>> On Thu, 13 Jun 2024 10:45:38 +0100,
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>> Fault status codes at page table level 0, 1, 2 and 3 for access, permission
>>>> and translation faults are architecturally organized in a way, that masking
>>>> out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.
>>>>
>>>> Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
>>>> out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
>>>> code as the kernel does not yet care about the page table level, the fault
>>>> really occurred previously.
>>>>
>>>> This scheme is starting to crumble after FEAT_LPA2 when level -1 got added.
>>>> Fault status code for translation fault at level -1 is 0x2B which does not
>>>> follow ESR_ELx_FSC_TYPE, requiring esr_fsc_is_translation_fault() changes.
>>>>
>>>> This changes above helpers to compare against individual fault status code
>>>> values for each page table level and drop ESR_ELx_FSC_TYPE which is losing
>>>> its value as a common mask.
>>>
>>> I'd rather we do not drop the existing #defines, for a very
>>> self-serving reason:
>>>
>>> NV requires an implementation to synthesise fault syndromes, and these
>>> definition are extensively used to compose the syndrome information
>>> (see the NV MMU series at [1]). This is also heavily use to emulate
>>> the AT instructions (fault reporting in PAR_EL1.FST).
>>>
>>> Having additional helpers is fine. Dropping the base definitions
>>> isn't, and I'd like to avoid reintroducing them.
>>
>> You would like to just leave behind all the existing level 0 syndrome macro
>> definitions in place ?
> 
> They are not level 0. They are values for the type of the fault. They
> are *abused* as level 0, but that's not what they are here for.

After thinking through the above statement multiple times, just realized
that individual page table level fault type value is *derived* from given
fault type arithmetically, which is also reflected in the macros you have
proposed later.

> 
>>
>> #define ESR_ELx_FSC_ACCESS	(0x08)
>> #define ESR_ELx_FSC_FAULT	(0x04)
>> #define ESR_ELx_FSC_PERM	(0x0C)
> 
> + ESR_ELx_FSC_{TYPE,LEVEL}, because they are convenient macros to
> extract the type/level of a fault. NV further adds ESR_ELx_FSC_ADDRSZ
> which has been missing.

Understood, this extracts both the fault type and its level as well.

> 
>>
>> Or which are rather
>>
>> #define ESR_ELx_FSC_ACCESS	ESR_ELx_FSC_ACCESS_L0
>> #define ESR_ELx_FSC_FAULT	ESR_ELx_FSC_FAULT_L0
>> #define ESR_ELx_FSC_PERM	ESR_ELx_FSC_PERM_L0
> 
> I definitely prefer the former.

Okay.

> 
>> But just wondering why cannot ESR_ELx_FSC_[ACCESS|FAULT|PERM]_L0 definitions
>> be used directly in new use cases ?
> 
> Because that is semantically wrong to add/or a level on something that
> *already* describes a level. Specially for the level -1 case.

Fair enough, as the value already have both the parameters.

> 
> On top of that, what I dislike the most about this patch is that it
> defines discrete values for something that could be parametric at zero
> cost, just like ESR_ELx_FSC_SEA_TTW(). Yes, there is some additional
> complexity, but nothing that the compiler can't elide.

Understood.

> 
> For example, something like this:
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 7abf09df7033..c320aeb1bb9a 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -121,6 +121,10 @@
>  #define ESR_ELx_FSC_SECC	(0x18)
>  #define ESR_ELx_FSC_SECC_TTW(n)	(0x1c + (n))
>  
> +#define ESR_ELx_FSC_FAULT_nL	(0x2C)
> +#define ESR_ELx_FSC_FAULT_L(n)	(((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
> +				  	    ESR_ELx_FSC_FAULT) + (n))
> +
>  /* ISS field definitions for Data Aborts */
>  #define ESR_ELx_ISV_SHIFT	(24)
>  #define ESR_ELx_ISV		(UL(1) << ESR_ELx_ISV_SHIFT)
> 
> Importantly, it avoids the ESR_ELx_FSC_FAULT_LN1 horror, and allows
> ESR_ELx_FSC_FAULT_L(-1) to be written.
> 
> 	M.
> 

Does the following re-worked patch looks okay ? Earlier set_thread_esr() changes
can be dropped from arch/arm64/mm/fault.c and also the original commit message
still makes sense.

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7abf09df7033..6cd13ac61005 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -121,6 +121,13 @@
 #define ESR_ELx_FSC_SECC       (0x18)
 #define ESR_ELx_FSC_SECC_TTW(n)        (0x1c + (n))
 
+/* Status codes for individual page table levels */
+#define ESR_ELx_FSC_ACCESS_L(n)        (ESR_ELx_FSC_ACCESS + n)
+#define ESR_ELx_FSC_FAULT_nL   (0x2C)
+#define ESR_ELx_FSC_FAULT_L(n) (((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
+                                           ESR_ELx_FSC_FAULT) + (n))
+#define ESR_ELx_FSC_PERM_L(n)  (ESR_ELx_FSC_PERM + n)
+
 /* ISS field definitions for Data Aborts */
 #define ESR_ELx_ISV_SHIFT      (24)
 #define ESR_ELx_ISV            (UL(1) << ESR_ELx_ISV_SHIFT)
@@ -388,20 +395,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
 
 static inline bool esr_fsc_is_translation_fault(unsigned long esr)
 {
-       /* Translation fault, level -1 */
-       if ((esr & ESR_ELx_FSC) == 0b101011)
-               return true;
-       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
+       esr = esr & ESR_ELx_FSC;
+
+       return (esr == ESR_ELx_FSC_FAULT_L(3)) ||
+              (esr == ESR_ELx_FSC_FAULT_L(2)) ||
+              (esr == ESR_ELx_FSC_FAULT_L(1)) ||
+              (esr == ESR_ELx_FSC_FAULT_L(0)) ||
+              (esr == ESR_ELx_FSC_FAULT_L(-1));
 }
 
 static inline bool esr_fsc_is_permission_fault(unsigned long esr)
 {
-       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
+       esr = esr & ESR_ELx_FSC;
+
+       return (esr == ESR_ELx_FSC_PERM_L(3)) ||
+              (esr == ESR_ELx_FSC_PERM_L(2)) ||
+              (esr == ESR_ELx_FSC_PERM_L(1)) ||
+              (esr == ESR_ELx_FSC_PERM_L(0));
 }
 
 static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
 {
-       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
+       esr = esr & ESR_ELx_FSC;
+
+       return (esr == ESR_ELx_FSC_ACCESS_L(3)) ||
+              (esr == ESR_ELx_FSC_ACCESS_L(2)) ||
+              (esr == ESR_ELx_FSC_ACCESS_L(1)) ||
+              (esr == ESR_ELx_FSC_ACCESS_L(0));
 }
 
 /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
 

