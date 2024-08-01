Return-Path: <linux-kernel+bounces-271026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C68B9448B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560B9B21B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4C16EBED;
	Thu,  1 Aug 2024 09:38:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5AEEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505130; cv=none; b=u/jB77Jq9FnIe3Ut9/4b1tOQ89D2cLcIsD9DbO1IcoyUfrvCuv+CIAywC20ELBEm7qr6/p5VI4pxCAILxDMdfz0LbItwZr1Y497V+4rRGFWErM4cwJIrLslcvrkq2lchvgv3SbowHr6srePIpYTgRKKJUCmitS9FpDXthtQNxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505130; c=relaxed/simple;
	bh=tWHcEj3P2Bb5S/KitvyAG+/rXveLtE/ljcSVb1GyFC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBHQKz6K4aZ1RI+5LCkB5v4/nqBEweMinAInO0Qjga5zt0IIDpK33sVwsSXPS+M3zXjn8YEEwW3JZ7IA5iMvcGY9WWrlvY1nH3wTIPm1QrDwkzFh9exAqcnIoqfiQDLurOff3VTOs+D6Q8ST5U971ydXFyrtNZW4cuiW2why7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835C4DA7;
	Thu,  1 Aug 2024 02:39:13 -0700 (PDT)
Received: from [10.162.42.27] (e116581.arm.com [10.162.42.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1B33F5A1;
	Thu,  1 Aug 2024 02:38:39 -0700 (PDT)
Message-ID: <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
Date: Thu, 1 Aug 2024 15:08:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/1/24 14:12, David Hildenbrand wrote:
> On 01.08.24 10:16, Dev Jain wrote:
>> I and Ryan had a discussion and we thought it would be best to get 
>> feedback
>> from the community.
>>
>> The migration mm selftest currently fails on arm64 for shared anon 
>> mappings,
>> due to the following race:
>
> Do you mean MAP_SHARED|MAP_ANON or MAP_PRIVATE|MAP_ANON_fork? Because 
> you note shmem below, I assume you mean MAP_SHARED|MAP_ANON


Yes.

>
>>
>> Migration:                        Page fault:
>> try_to_migrate_one():                    handle_pte_fault():
>> 1. Nuke the PTE                        PTE has been deleted => 
>> do_pte_missing()
>> 2. Mark the PTE for migration                PTE has not been deleted 
>> but is just not "present" => do_swap_page()
>>
>
> In filemap_fault_recheck_pte_none() we recheck under PTL to make sure 
> that a temporary pte_none() really was persistent pte_none() and not a 
> temporary pte_none() under PTL.
>
> Should we do something similar in do_fault()? I see that we already do 
> something like that on the "!vma->vm_ops->fault" path.
>
> But of course, there is a tradeoff between letting migration 
> (temporarily) fail and grabbing the PTL during page faults.


To dampen the tradeoff, we could do this in shmem_fault() instead? But 
then, this would mean that we do this in all

kinds of vma->vm_ops->fault, only when we discover another reference 
count race condition :) Doing this in do_fault()

should solve this once and for all. In fact, do_pte_missing() may call 
do_anonymous_page() or do_fault(), and I just

noticed that the former already checks this using vmf_pte_changed().


