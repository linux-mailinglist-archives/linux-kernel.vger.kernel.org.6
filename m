Return-Path: <linux-kernel+bounces-449833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935D9F56B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551FC7A48C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7081F8EE4;
	Tue, 17 Dec 2024 19:12:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573F13EFF3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462753; cv=none; b=jOeECQZIcJDc5BKmnRc7hE7Q8CMoEzYllznCP6eODY7PvkgwqQgjsZkAVp3iOnRJFoHUnwgmYLS4QatIY5HtHBgJI5Avb8fkK3drwTY/1SBq72oJqARdl0HusbyY3lEwsYPc+unWWxXZVVn8bwbcO1wgwLVenAjggFv5kAO7z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462753; c=relaxed/simple;
	bh=tQuyB82LYUHfwzex6xAiW9QMW3nY/LzNvLH6Y2IkeLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pxp49OCLizcxBO9cdqfs84r10B/NEp7B1X1vnmLuIKkOH5ei+O/C/qm0ypj2jlUwyrr8I7cqwIodidDEFEFUigrQHjIKoBmQiD15BUyWfFx9hy3ddT9dV03LiNA7QPPDXEwnYNBaKzt2FR9CXoNtCPMa9cQu5X3I0LY2jssGkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6833FEC;
	Tue, 17 Dec 2024 11:12:57 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47043F528;
	Tue, 17 Dec 2024 11:12:23 -0800 (PST)
Message-ID: <8f1ef412-6f43-4346-bbfd-84431f3a5488@arm.com>
Date: Tue, 17 Dec 2024 19:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/12] khugepaged: Rename hpage_collapse_scan_pmd() ->
 ptes()
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, Dev Jain <dev.jain@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 david@redhat.com, kirill.shutemov@linux.intel.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 jglisse@google.com, surenb@google.com, vishal.moola@gmail.com,
 zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com,
 21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-2-dev.jain@arm.com>
 <Z2D7pi1Gl4Bq-ln2@casper.infradead.org>
 <0a33f5c1-c974-4d4a-94dd-6741399e186e@arm.com>
 <35E34233-3435-4873-A82C-A1DFBD0AFC55@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <35E34233-3435-4873-A82C-A1DFBD0AFC55@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 18:11, Zi Yan wrote:
> On 17 Dec 2024, at 1:43, Ryan Roberts wrote:
> 
>> On 17/12/2024 04:18, Matthew Wilcox wrote:
>>> On Mon, Dec 16, 2024 at 10:20:54PM +0530, Dev Jain wrote:
>>>> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>> +static int hpage_collapse_scan_ptes(struct mm_struct *mm,
>>>
>>> i don't think this is necessary at all.  you're scanning a pmd.
>>> you might not be scanning in order to collapse to a pmd, but pmd
>>> is the level you're scanning at.
>>>
>>
>> Sorry Matthew, I don't really understand this statement. Prior to the change we
>> were scanning all PTE entries in a PTE table with the aim of collapsing to a PMD
>> entry. After the change we are scanning some PTE entries in a PTE table with the
>> aim of collapsing to either to a multi-PTE-mapped folio or a single-PMD-mapped
>> folio.
>>
>> So personally I think "scan_pmd" was a misnomer even before the change - we are
>> scanning the ptes.
> 
> But there are still a lot of scan_pmd code in the function, for example,
> VM_BUG_ON(address & ~HPAGE_PMD_MASK), _pte < pte + HPAGE_PMD_NR in the function.
> These need to be changed along with function renaming. If after the change only
> a subset of PTEs are scanned within a PMD, maybe a scan_range parameter can be
> added.

Oh I see; I think your and Matthew's point is that we are scanning a
"PMD-entry's worth of PTEs". Looking at it like that, I guess I understand why
"scan_pmd" makes sense. Fair enough.

> 
> Best Regards,
> Yan, Zi


