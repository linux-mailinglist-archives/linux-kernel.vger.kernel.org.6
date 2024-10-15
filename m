Return-Path: <linux-kernel+bounces-365638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B430B99E54F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63CA1C20925
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B01E8855;
	Tue, 15 Oct 2024 11:14:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B951E7C35
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990842; cv=none; b=U8u1BbZ1emGtlLCLJOVe/oKeJ4TZPnh1C+wS8TYH89FoYEHrtvWVJa1CPXS/JvOVCFAPm24h+c1AVNN6/Ss7yI6MJ8Vd4AG4hrVOxQkfhao2LuGn8QBO+VCvKlohojX/OMJay1IvNGHZVw5irzRYeqI5bOdQs6wgTZh+gJWun1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990842; c=relaxed/simple;
	bh=LFteKUNkvfc5UKvj/oRa5rD1LKn8SWoXM/h6DpIIESs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye1jTw5OUhEFrHpRygk3ZqQdRldIKPv2i/Cm+ZHJGe1oC03OoGEa3HgzQZUwLI5TIPE2pvFBmXAJz6uU6qDc+/tWBBPAAlouZrpTC6JRDc4+ElNbChpGHutXHRkCp3eUlkKxIUdCyPHCoC5uOMDjM6vltS4NGkkNIqbD0iFu9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011011007;
	Tue, 15 Oct 2024 04:14:30 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A2A3F51B;
	Tue, 15 Oct 2024 04:13:57 -0700 (PDT)
Message-ID: <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
Date: Tue, 15 Oct 2024 12:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
 <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 04:47, Baoquan He wrote:
> On 10/14/24 at 11:58am, Ryan Roberts wrote:
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
>>
>> Updated BUILD_BUG_ON() to test against limit.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  kernel/crash_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 63cf89393c6eb..978c600a47ac8 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
>>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
>>  	 * definitely will be in 2 pages with that.
>>  	 */
>> -	BUILD_BUG_ON(size > PAGE_SIZE);
>> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
> 
> This should be OK. While one thing which could happen is if selected size
> is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
> compiling while actual it's not a problem during running. 

PAGE_SIZE can only ever be bigger than PAGE_SIZE_MIN if compiling a "boot-time
page size" build. And in this case, you need to know that size is small enough
to work with any of the boot-time selectable page sizes. Since size
(=sizeof(note_buf_t)) is invariant to PAGE_SIZE, we can do this by checking
against PAGE_SIZE_MIN.

So I don't think this could ever lead to a false-positive.


Not sure if
> that could happen on arm64. Anyway, we can check the crash_notes to get
> why it's so big when it really happens. So,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks!

> 
>>  
>>  	crash_notes = __alloc_percpu(size, align);
>>  	if (!crash_notes) {
>> -- 
>> 2.43.0
>>
>>
> 


