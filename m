Return-Path: <linux-kernel+bounces-432921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061C9E51C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314A418820F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1B217645;
	Thu,  5 Dec 2024 10:10:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A1207DF4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393417; cv=none; b=U+UfppQrUGRIEA2nMkhNNKlkKua0AWHjAd8Il6XV6ZXjgyaY4zs/eA+KTZnE08E3QDZSCH/tluiXOc0U9gcAMVCOdpybvxzsKQiVGuax/0YWh0i1pm2WMQGJS00o/OC8xMe5b9GZflvHN2mox80cbuyxmXDwmme7vvnrmvOHuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393417; c=relaxed/simple;
	bh=OjMZk5dnhstBL9ZqJKabXhL4DDjSkjqgRnVxAIHVpWw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=saCpxwGFQ2M5ME6A94Q+wudbcdzzpDcH0OVCvbfkGfI43essyR99BsA0DR3RK64bAVCI71YYljevoMGNrpu7LNYWss4RcNIrHPJKMRev21LAfyA61tfaN+k75TnuC6fcsL7pJMI43KBYs+IFVk+WNvSpzb5/wS9r7nFwZcKGgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CEDFEC;
	Thu,  5 Dec 2024 02:10:41 -0800 (PST)
Received: from [10.162.43.28] (K4MQJ0H1H2.blr.arm.com [10.162.43.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79BA43F5A1;
	Thu,  5 Dec 2024 02:10:11 -0800 (PST)
Message-ID: <ea15f3d3-5dd8-4404-8dab-5673bb5f3413@arm.com>
Date: Thu, 5 Dec 2024 15:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [QUESTION] anon_vma lock in khugepaged
To: ryan.roberts@arm.com, david@redhat.com, kirill.shutemov@linux.intel.com,
 willy@infradead.org, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241128062641.59096-1-dev.jain@arm.com>
Content-Language: en-US
In-Reply-To: <20241128062641.59096-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/11/24 11:56 am, Dev Jain wrote:
> Hi, I was looking at khugepaged code and I cannot figure out what will the problem be
> if we take the mmap lock in read mode. Shouldn't just taking the PMD lock, then PTL,
> then unlocking PTL, then unlocking PMD, solve any races with page table walkers?
>
>

Similar questions:

1. Why do we need anon_vma_lock_write() in collapse_huge_page()? AFAIK we need to walk anon_vma's either
    when we are forking or when we are unmapping a folio and need to find all VMAs mapping it; the former path takes the
    mmap_write_lock() and so we have no problem, and for the latter, if we just had anon_vma_lock_read(), then it
    may happen that kswapd isolates folio from LRU, and traverses rmap and swaps the folio out and khugepaged fails in
    folio_isolate_lru(), but then that is not a fatal problem but just a performance degradation due to a race (wherein
    the entire code is racy anyways). What am I missing?

2. In what all scenarios does rmap come into play? Fork, swapping out, any other I am missing?

3. Please confirm the correctness: In stark contrast to page migration, we do not need to do rmap walk and nuke all
    PTEs referencing the folio, because for anon non-shmem folios, the only way the folio can be shared is forking,
    and, if that is the case, folio_put() will not release the folio in __collapse_huge_page_copy_succeeded() -> free_page_and_swap_cache(),
    so the old folio is still there and child processes can read from it. Page migration requires that we are able
    to deallocate the old folios.


