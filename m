Return-Path: <linux-kernel+bounces-446803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E757B9F294E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF42163C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDD1885AD;
	Mon, 16 Dec 2024 04:32:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC201A41
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323524; cv=none; b=TRHJfanjF9U5tQTqnjVfO4yPGrz6g0pM+VnygAYo4v5vRgKZBw2mAmKpun12Z3qd099M8FD/Un0G7yqu1DZ1N3w3fXXSVSP/aevg+JH/ev7hcj2YhfbbMxGftQ5WRlp6hiTY88CudcJNYyWd0oKzOtliaXf7wGFw4SD8jlPMSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323524; c=relaxed/simple;
	bh=tnsqZQcVAH2J/PYezQcVe1K/YNH22wtKD5nTp64YZv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qge9/2YDF/biQ3hZjK4W4xRKxBuyv/vO8t1IzahWHGVSZk3nyf0jkgutPwynY2PnDtSHgouthXNAyJpTdpswFYtX8UW4JJ9pE5/Q11WEVsxnghITSS+Duid4f9UWxEwT7DQjXlZ3Zvs7JT/M7JkYI5v7dDDNZRMtbidPJUGdAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C13111FB;
	Sun, 15 Dec 2024 20:32:30 -0800 (PST)
Received: from [10.162.16.49] (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF8D3F58B;
	Sun, 15 Dec 2024 20:31:58 -0800 (PST)
Message-ID: <1bd6db20-7012-49d5-9e9f-38a84c3946a5@arm.com>
Date: Mon, 16 Dec 2024 10:01:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: fault: replace the behavior of fault_info[18]
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Mark Brown <broonie@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241214091937.203842-1-lsahn@ooseel.net>
 <CANTT7qi=wZvOQP4PFEi7300MbNjsJ2q=WXceHch1BUrtL-WFDQ@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CANTT7qi=wZvOQP4PFEi7300MbNjsJ2q=WXceHch1BUrtL-WFDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/14/24 15:08, Leesoo Ahn wrote:
> I just figured out that do_sea(..) isn't the right function to deal
> with VMSAv9-128.
> Please ignore this patch.

Right, actual handling needs to be sorted out when 128 bit PTE is enabled.
For example, following change might be required to handle 128 bit related
faults but the handlers such as do_sea(), do_bad(), do_translation_fault()
need to be changed and tested for 128 bit PTE format.

--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -415,7 +415,8 @@ static inline bool esr_fsc_is_translation_fault(unsigned long esr)
               (esr == ESR_ELx_FSC_FAULT_L(2)) ||
               (esr == ESR_ELx_FSC_FAULT_L(1)) ||
               (esr == ESR_ELx_FSC_FAULT_L(0)) ||
-              (esr == ESR_ELx_FSC_FAULT_L(-1));
+              (esr == ESR_ELx_FSC_FAULT_L(-1)) ||
+              (esr == ESR_ELx_FSC_FAULT_L(-2));
 }
 
 static inline bool esr_fsc_is_permission_fault(unsigned long esr)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8b281cf308b3..3a35c580395e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -823,7 +823,7 @@ static const struct fault_info fault_info[] = {
        { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 permission fault"      },
        { do_sea,               SIGBUS,  BUS_OBJERR,    "synchronous external abort"    },
        { do_tag_check_fault,   SIGSEGV, SEGV_MTESERR,  "synchronous tag check fault"   },
-       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 18"                    },
+       { do_sea,               SIGKILL, SI_KERNEL,     "level -2 (translation table walk)"     },
        { do_sea,               SIGKILL, SI_KERNEL,     "level -1 (translation table walk)"     },
        { do_sea,               SIGKILL, SI_KERNEL,     "level 0 (translation table walk)"      },
        { do_sea,               SIGKILL, SI_KERNEL,     "level 1 (translation table walk)"      },
@@ -847,9 +847,9 @@ static const struct fault_info fault_info[] = {
        { do_bad,               SIGKILL, SI_KERNEL,     "unknown 39"                    },
        { do_bad,               SIGKILL, SI_KERNEL,     "unknown 40"                    },
        { do_bad,               SIGKILL, SI_KERNEL,     "level -1 address size fault"   },
-       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 42"                    },
+       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level -2 translation fault"    },
        { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level -1 translation fault"    },
-       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 44"                    },
+       { do_bad,               SIGKILL, SI_KERNEL,     "level -2 address size fault"   },
        { do_bad,               SIGKILL, SI_KERNEL,     "unknown 45"                    },
        { do_bad,               SIGKILL, SI_KERNEL,     "unknown 46"                    },
        { do_bad,               SIGKILL, SI_KERNEL,     "unknown 47"                    },


> 
> BR
> Leesoo
> 
> 2024년 12월 14일 (토) 오후 6:20, Leesoo Ahn <lsahn@ooseel.net>님이 작성:
>>
>> Replace the behavior of 18th element of fault_info with the 'fn' member to
>> do_sea(..) and 'name' to 'level -2 (translation table walk)' based on
>> the information[1] of the latest reference manual[2].
>>
>> The information has described in the chapter, D24.2.40 of [2] and
>> DFSC[5:0] bit (stands for Data Fault Status Code).
>>
>> [1]: Synchronous External abort on translation table walk, level -2
>> [2]: Arm Architecture Reference Manual, for A-profile architecture
>>
>> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
>> ---
>>  arch/arm64/mm/fault.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index ef63651099a9..b1c08289a5cc 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -863,7 +863,7 @@ static const struct fault_info fault_info[] = {
>>         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 permission fault"      },
>>         { do_sea,               SIGBUS,  BUS_OBJERR,    "synchronous external abort"    },
>>         { do_tag_check_fault,   SIGSEGV, SEGV_MTESERR,  "synchronous tag check fault"   },
>> -       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 18"                    },
>> +       { do_sea,               SIGKILL, SI_KERNEL,     "level -2 (translation table walk)"     },
>>         { do_sea,               SIGKILL, SI_KERNEL,     "level -1 (translation table walk)"     },
>>         { do_sea,               SIGKILL, SI_KERNEL,     "level 0 (translation table walk)"      },
>>         { do_sea,               SIGKILL, SI_KERNEL,     "level 1 (translation table walk)"      },
>> --
>> 2.46.1
>>
> 

