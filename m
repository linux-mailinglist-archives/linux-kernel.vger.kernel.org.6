Return-Path: <linux-kernel+bounces-510182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94396A31975
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6531887C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5885267AFE;
	Tue, 11 Feb 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zla9nlGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111A272908
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316223; cv=none; b=JC08G5dNx9L5+B8EFkP59mm/SJhRkbSBQd9RxdFDjRpWpjPb+kI+mv7iZ1YAC1kxY1QmNPyL/WZFRZgSjjFRgj/RBZpUIgqHbIoh7suu9ggu6f0mZ9f1OqwRH7OUQ86COCm/YtXp3/G9JzMyZc6vvbkR0B7e8UIASozNkL7+Aeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316223; c=relaxed/simple;
	bh=9CEq1rU+igBd9gYOH1zNJ9QAxFtqVyfFNmpUYP8FoJE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AxNm7YsR2t+avpZTu6NyoY9cvDBn3qgA2tw19BqAsoBqV7N569olvNajMy37di+2jMw0YznZMSw8Htbd1QNAPc1FSkuU2HL9FyFMwTQnOzU16N4jmL/FHv83AoS03MYoRQSNl3zevYfuXL8z8C77nVkHZvLxrYh4BEUg3RsvLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zla9nlGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1F0C4CEDD;
	Tue, 11 Feb 2025 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739316223;
	bh=9CEq1rU+igBd9gYOH1zNJ9QAxFtqVyfFNmpUYP8FoJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zla9nlGE43GU6OGohify5G8boYIZyP0qo/Ry2s7xigt2q3x3h+gYzTQ25RZ1tgg0G
	 7bFU8DF8ZC1xORlm7sKmPc0Al4+R+mpGlAq8romE1+EuEfw2Vm+hRmcMD/jc7UuWhl
	 vxHm9irAvecpJ2oz9wAaoAlxcHeN5qbptzPOvJik=
Date: Tue, 11 Feb 2025 15:23:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com,
 npache@redhat.com, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu,
 haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
 surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
 zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] khugepaged: Asynchronous mTHP collapse
Message-Id: <20250211152341.3431089327c5e0ec6ba6064d@linux-foundation.org>
In-Reply-To: <20250211111326.14295-1-dev.jain@arm.com>
References: <20250211111326.14295-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 16:43:09 +0530 Dev Jain <dev.jain@arm.com> wrote:

> This patchset extends khugepaged from collapsing only PMD-sized THPs to
> collapsing anonymous mTHPs.
> 
> mTHPs were introduced in the kernel to improve memory management by allocating
> chunks of larger memory, so as to reduce number of page faults, TLB misses (due
> to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP property
> is often lost due to CoW, swap-in/out, and when the kernel just cannot find
> enough physically contiguous memory to allocate on fault. Henceforth, there is a
> need to regain mTHPs in the system asynchronously. This work is an attempt in
> this direction, starting with anonymous folios.
> 
> In the fault handler, we select the THP order in a greedy manner; the same has
> been used here, along with the same sysfs interface to control the order of
> collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap_write_lock().
> 
> ---------------------------------------------------------
> Testing
> ---------------------------------------------------------
> 
> The set has been build tested on x86_64.
> For Aarch64,
> 1. mm-selftests: No regressions.
> 2. Analyzing with tools/mm/thpmaps on different userspace programs mapping
>    aligned VMAs of a large size, faulting in basepages/mTHPs (according to sysfs),
>    and then madvise()'ing the VMA, khugepaged is able to 100% collapse the VMAs.

It would be nice to provide some evidence that this patchset actually
makes Linux better for our users, and by how much.

Thanks, I think I'll skip v2 and shall await reviewer input.

