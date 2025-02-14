Return-Path: <linux-kernel+bounces-514467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2AA35765
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B4316A3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E336A2063EA;
	Fri, 14 Feb 2025 06:49:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5918A6D5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515790; cv=none; b=Fm0BEsDFjmf4lflOlrAvn2zjZbcjZmln8/EI6enoOWewfZKJeo7Ww5s69HfZAI2+2mX5+p3d6cSufpALnOFnySxBCk1pHrk4q+XenAu5HvG6z7DPzZz5sV7PPW1xztTT+HvhkOzozdMT6WWniSAPz9h3rq1vXbBf12DTrt6t0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515790; c=relaxed/simple;
	bh=iB6uQxOKOxWWtR8nXfLPX2quZZcVZHiIY2rC47X4DEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPK0AUmZUw84RmEe1p9jizjKav/7TU97YmWBs7LVpoLmB93GxgJaCFukY0q2GJWYjNNaaiScnH4doi7Oak6VU2LXAxAsTjhlPXYFCchSkjrn4QpdSQzbmbf1RU9lQm7w2LPfoQYO66Vhqh6x78Pge1tIw6wVZLkSoooobtzEUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B05E4113E;
	Thu, 13 Feb 2025 22:50:06 -0800 (PST)
Received: from [10.163.37.128] (unknown [10.163.37.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052F13F58B;
	Thu, 13 Feb 2025 22:49:42 -0800 (PST)
Message-ID: <8e60766c-8567-4954-9d99-e1d702d0fcc3@arm.com>
Date: Fri, 14 Feb 2025 12:19:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: Make GENERIC_PTDUMP dependent on MMU
To: Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc: christophe.leroy@csgroup.eu, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-4-anshuman.khandual@arm.com>
 <5504fadd-6174-41c4-90a8-d3ae7f76d7f6@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5504fadd-6174-41c4-90a8-d3ae7f76d7f6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 16:53, Steven Price wrote:
> On 13/02/2025 04:09, Anshuman Khandual wrote:
>> There is no page table dump without a MMU. Make this dependency at generic
>> level and drop the same from riscv platform instead.
>>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> As Christophe has pointed out - this is broken. The select will override
> the dependency you've added in GENERIC_PTDUMP. Generally have "depends
> on" for symbols that are "select"ed is broken. I'd suggest just dropping
> this patch.

Agreed, will drop this patch. Thanks Steven and Christophe for the
explanation here regarding correct usage regarding the "select"'s
construct.

> 
> Steve
> 
>> ---
>>  arch/riscv/Kconfig | 2 +-
>>  mm/Kconfig.debug   | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 7612c52e9b1e..c4cdba6460b8 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -112,7 +112,7 @@ config RISCV
>>  	select GENERIC_IRQ_SHOW_LEVEL
>>  	select GENERIC_LIB_DEVMEM_IS_ALLOWED
>>  	select GENERIC_PCI_IOMAP
>> -	select GENERIC_PTDUMP if MMU
>> +	select GENERIC_PTDUMP
>>  	select GENERIC_SCHED_CLOCK
>>  	select GENERIC_SMP_IDLE_THREAD
>>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>> index a51a1149909a..c08406760d29 100644
>> --- a/mm/Kconfig.debug
>> +++ b/mm/Kconfig.debug
>> @@ -214,6 +214,7 @@ config DEBUG_WX
>>  	  If in doubt, say "Y".
>>  
>>  config GENERIC_PTDUMP
>> +	depends on MMU
>>  	bool
>>  
>>  config PTDUMP_CORE
> 

