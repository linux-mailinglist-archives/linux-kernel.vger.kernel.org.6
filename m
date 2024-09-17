Return-Path: <linux-kernel+bounces-331268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23897AA82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66227B29F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 03:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380E29405;
	Tue, 17 Sep 2024 03:55:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2C24B2F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726545348; cv=none; b=eScGM+K8XD2EC8l/SDAf/4zb+UJz64Eb5HOqFnjLkoQBkMdoHO4lnNkuY2PVeXV/sK5t4MG0NfifpCzeJ/B/qzFPNKZWNseY0ACGSBbzvqIDgKDawmFbc0/0EbGqUog9s4IOV96Ux+LNkeQgZ43Pr7lKT+BEpG4zGZ4AIQ5/ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726545348; c=relaxed/simple;
	bh=iyzdC1QHt7t3Pm75mx2OSOzugs6ydIyBElrYDwbNPKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foVKePTlkLaQlOMzZht7qbdEFO/i15Hz95kBuB7S5LJmvOQ7RDU38gf7wrgUXJAFL29YVWOuwbeUglue2GbJ0rXIuFdBj5uIDSbNE2gl6ZvXq72kQLec9FESl//SRKhpyWh+x+DS4dFRXpSF5KhVrKn03mIFFmlYv36RPZXSRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF45B106F;
	Mon, 16 Sep 2024 20:56:07 -0700 (PDT)
Received: from [10.162.40.18] (e116581.arm.com [10.162.40.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101BE3F66E;
	Mon, 16 Sep 2024 20:55:33 -0700 (PDT)
Message-ID: <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
Date: Tue, 17 Sep 2024 09:25:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, baohua@kernel.org, hughd@google.com,
 ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240913091902.1160520-1-dev.jain@arm.com>
 <ZugxqJ-CjEi5lEW_@casper.infradead.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZugxqJ-CjEi5lEW_@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/16/24 18:54, Matthew Wilcox wrote:
> On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
>> We use pte_range_none() to determine whether contiguous PTEs are empty
>> for an mTHP allocation. Instead of iterating the while loop for every
>> order, use some information, which is the first set PTE found, from the
>> previous iteration, to eliminate some cases. The key to understanding
>> the correctness of the patch is that the ranges we want to examine
>> form a strictly decreasing sequence of nested intervals.
> This is a lot more complicated.  Do you have any numbers that indicate
> that it's faster?  Yes, it's fewer memory references, but you've gone
> from a simple linear scan that's easy to prefetch to an exponential scan
> that might confuse the prefetchers.

I do have some numbers, I tested with a simple program, and also used
ktime API, with the latter, enclosing from "order = highest_order(orders)"
till "pte_unmap(pte)" (enclosing the entire while loop), a rough average
estimate is that without the patch, it takes 1700 ns to execute, with the
patch, on an average it takes 80 - 100ns less. I cannot think of a good
testing program...

For the prefetching thingy, I am still doing a linear scan, and in each
iteration, with the patch, the range I am scanning is going to strictly
lie inside the range I would have scanned without the patch. Won't the
compiler and the CPU still do prefetching, but on a smaller range; where
does the prefetcher get confused? I confess, I do not understand this
very well.


