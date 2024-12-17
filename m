Return-Path: <linux-kernel+bounces-448736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526419F44D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DED01887601
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D315B111;
	Tue, 17 Dec 2024 07:09:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9914831E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419389; cv=none; b=C+KBcdeFbsubhSBHi07SB9c6JolIJhaF3QLHXHBG/HuNF+nHZql6jqz2o3TeJ7a0nwvAAwK/hWo5WexVMr/f3FnwF3xTA2xDv8pPlwy33eIvAk4+MaleP9MiL+WWD1L78MaNynNcyTmzw2FdcVsHc0Stv7TAK5Hc9QpZxMNAvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419389; c=relaxed/simple;
	bh=ikb3cf7ZPOaIsDFBsU1qPzhbgO2K2/TfCgc3lRoJS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTIzztg2Z5B9lArrawb+Ew5xDVDJsAW8xCYEUaG44dG4O03H4VFdjLmHcHl83PvLYlJPGdL0z7IWlzHuTcPFyabX6Ip23HBbwCkZdOlllWDMswkl8gGoQswi3M+alGwRXhlvMWVsh2p3XHCtF3EZTaBthkW18powKW3qf5aPE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B2F1007;
	Mon, 16 Dec 2024 23:10:14 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D943F528;
	Mon, 16 Dec 2024 23:09:41 -0800 (PST)
Message-ID: <ae19e5ef-82d5-44e1-96fe-18a2a16faac1@arm.com>
Date: Tue, 17 Dec 2024 07:09:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
 surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
 zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-3-dev.jain@arm.com>
 <Z2D7YctQaFW_iwei@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z2D7YctQaFW_iwei@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2024 04:17, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 10:20:55PM +0530, Dev Jain wrote:
>>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>> -			      struct collapse_control *cc)
>> +			      int order, struct collapse_control *cc)
> 
> unsigned, surely?

I'm obviously feeling argumentative this morning...

There are plenty of examples of order being signed and unsigned in the code
base... it's a mess. Certainly the mTHP changes up to now have opted for
(signed) int. And get_order(), which I would assume to the authority, returns
(signed) int.

Personally I prefer int for small positive integers; it's more compact. But if
we're trying to establish a pattern to use unsigned int for all new uses of
order, that fine too, let's just document it somewhere?

> 
>>  	if (!folio) {
>>  		*foliop = NULL;
>>  		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>> +		if (order != HPAGE_PMD_ORDER)
>> +			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
> 
> i don't understand why we need new statistics here.  we already have a
> signal that memory allocation failures are preventing collapse from
> being successful, why do we care if it's mthp or actual thp?

We previously decided that all existing THP stats would continue to only count
PMD-sized THP for fear of breaking userspace in subtle ways, and instead would
introduce new mTHP stats that can count for each order. We already have
MTHP_STAT_ANON_FAULT_ALLOC and MTHP_STAT_ANON_FAULT_FALLBACK (amongst others) so
these new stats fit the pattern well, IMHO.

(except for the bug that I called out in the other mail; we should call
count_mthp_stat() for all orders and call count_vm_event() only for PMD_ORDER).

> 
>>  	count_vm_event(THP_COLLAPSE_ALLOC);
>> +	if (order != HPAGE_PMD_ORDER)
>> +		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);
> 
> similar question
> 


