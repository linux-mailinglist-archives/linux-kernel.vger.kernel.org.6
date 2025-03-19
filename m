Return-Path: <linux-kernel+bounces-567341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2CA684BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2040C19C3D63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A924EF9D;
	Wed, 19 Mar 2025 06:02:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407824EF7F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364154; cv=none; b=EbeiKZVQjs4cwTXmQJI6kTnjsQw9vfo+OhFdnKXoYrJjMFVczb3uA4Cjs5AYJ+vj1bglQzGCaT5btQcneIlygQrmhzAg+hkjWaJWDhmqn+QRD+p53XsPqDxl0TnHGBIWfWINylYy+RfrQuRLTFUb88rpBpxe4TiniOzogbYbEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364154; c=relaxed/simple;
	bh=b2HsYq0tQscYaDeApfXqnnuSpDh4L2ne5GKwzlMzZ6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2cOA7ZGof/06ah+LoK/L9Yx+9jtT7k4q041sfaET/0oFgambRyXT5C0ps3hulVtDPB6RI3zdt2VLXeBAQ2qwwFhYBHbzmZTyOJkZYkkPR/UNloRExco5fSlgi/Nv50EzuiXKi3A/u2i4T2TT0DDwC6zv/R1s3LfuAID0vVz9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603D312FC;
	Tue, 18 Mar 2025 23:02:39 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D983F694;
	Tue, 18 Mar 2025 23:02:28 -0700 (PDT)
Message-ID: <1c35a8c5-324b-4c60-9bf1-a5414481e5ad@arm.com>
Date: Wed, 19 Mar 2025 11:32:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm/hotplug: Drop redundant [pgd|p4d]_present()
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org
References: <20250221094449.1188427-1-anshuman.khandual@arm.com>
 <20250221094449.1188427-2-anshuman.khandual@arm.com>
 <Z9lWJsA2hg2UKZ0T@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z9lWJsA2hg2UKZ0T@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 16:46, Mark Rutland wrote:
> On Fri, Feb 21, 2025 at 03:14:48PM +0530, Anshuman Khandual wrote:
>> [pgd|p4d]_present() are inverse to their corresponding [pgd|p4d]_none().
> 
> Maybe their implementations happen to be inverse today, but the semantic
> of pXX_present() is not the inverse of the semantic of pXX_none(). In
> general, !pXX_none() does not imply pXX_present().

Agreed.

> 
>> So [pgd|p4d]_present() test right after corresponding [pgd|p4d]_none()
>> inverse test does not make sense. Hence just drop these redundant
>> checks.
> 
> I think the checks make sense in abstract, even if they're redundant
> today

Okay.

> 
> Is there any reason to remove these specific case?

Just for optimization.

> 
> Surely the compiler optimizes these out when they're redundant?

Agreed. Although wondering if p4d_present() is the right thing to test.
Should it be replaced with a p4d_bad() check instead because subsequent
calls into either unmap_hotplug_pud_range() or free_empty_pud_table() 
requires given entry to be a table to proceed further successfully.

> 
> Mark.
> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b4df5bc5b1b8..66906c45c7f6 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -952,7 +952,6 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>>  		if (p4d_none(p4d))
>>  			continue;
>>  
>> -		WARN_ON(!p4d_present(p4d));
>>  		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
>>  	} while (addr = next, addr < end);
>>  }
>> @@ -978,7 +977,6 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>>  		if (pgd_none(pgd))
>>  			continue;
>>  
>> -		WARN_ON(!pgd_present(pgd));
>>  		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
>>  	} while (addr = next, addr < end);
>>  }
>> @@ -1114,7 +1112,6 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
>>  		if (p4d_none(p4d))
>>  			continue;
>>  
>> -		WARN_ON(!p4d_present(p4d));
>>  		free_empty_pud_table(p4dp, addr, next, floor, ceiling);
>>  	} while (addr = next, addr < end);
>>  
>> @@ -1153,7 +1150,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
>>  		if (pgd_none(pgd))
>>  			continue;
>>  
>> -		WARN_ON(!pgd_present(pgd));
>>  		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
>>  	} while (addr = next, addr < end);
>>  }
>> -- 
>> 2.30.2
>>

