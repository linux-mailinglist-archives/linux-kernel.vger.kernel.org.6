Return-Path: <linux-kernel+bounces-171077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495788BDF8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FD2B220CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB014EC51;
	Tue,  7 May 2024 10:20:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11914E2E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077230; cv=none; b=pDoXPVlSZC/Wp4wQIZISJq4Gthy1a0JxoHE/pSZ2m2eQ9fZs3i3ymBdreODhU25e0u8/vaKxQ1GchNjYMA0BwnytSS+M5oeih9ZI35lG/Mzy5Oc0DpbZ1cAMGId8ZOw8TxGEvo+DDGCKl88z57HUUCjJRaMPTambazPSeldmN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077230; c=relaxed/simple;
	bh=l7a39ZOU+Mrj446gjZOKy3Bn0QGJfDOBT5AHwPvmWLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cwapg+3wDhVfkuADUsGv1WeW4bUXidtyjPscthBUc9sJOTOvUWmQwAs+scMRgL7nD+8/M058YbbuFjelg2RCv8jwNBKicrTOaHASqQl2n9TtgMnXJ+P3kH+gEwp9F/HfVKAOp4je7eIMkcZ6+KBnqghKo0Ax1hPACDQAKSwfJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D361063;
	Tue,  7 May 2024 03:20:53 -0700 (PDT)
Received: from [10.1.34.181] (unknown [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26B1B3F587;
	Tue,  7 May 2024 03:20:26 -0700 (PDT)
Message-ID: <d887b469-312f-433b-b7a1-a290a381d4d5@arm.com>
Date: Tue, 7 May 2024 11:20:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 09:46, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocation
> through commit 19eaf44954df, that can allow THP to be configured through the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
> 
> However, the anonymous shared pages will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Many implement anonymous page sharing through
> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
> also including the anonymous shared pages, in order to enjoy the benefits of
> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
> 
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have all the same values as the top-level

Didn't we agree that "force" would not be supported for now, and would return an
error when attempting to set for a non-PMD-size hugepage-XXkb/shmem_enabled (or
indirectly through inheritance)?

> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option. By default all sizes will be set to "never"
> except PMD size, which is set to "inherit". This ensures backward compatibility
> with the shmem enabled of the top level, meanwhile also allows independent
> control of shmem enabled for each mTHP.
> 
> Use the page fault latency tool to measure the performance of 1G anonymous shmem
> with 32 threads on my machine environment with: ARM64 Architecture, 32 cores,
> 125G memory:
> base: mm-unstable
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.04s        3.10s         83516.416                  2669684.890
> 
> mm-unstable + patchset, anon shmem mTHP disabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.02s        3.14s         82936.359                  2630746.027
> 
> mm-unstable + patchset, anon shmem 64K mTHP enabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.08s        0.31s         678630.231                 17082522.495
> 
> From the data above, it is observed that the patchset has a minimal impact when
> mTHP is not enabled (some fluctuations observed during testing). When enabling 64K
> mTHP, there is a significant improvement of the page fault latency.
> 
> TODO:
>  - Support mTHP for tmpfs.
>  - Do not split the large folio when share memory swap out.
>  - Can swap in a large folio for share memory.
> 
> Changes from RFC:
>  - Rebase the patch set against the new mm-unstable branch, per Lance.
>  - Add a new patch to export highest_order() and next_order().
>  - Add a new patch to align mTHP size in shmem_get_unmapped_area().
>  - Handle the uffd case and the VMA limits case when building mapping for
>    large folio in the finish_fault() function, per Ryan.
>  - Remove unnecessary 'order' variable in patch 3, per Kefeng.
>  - Keep the anon shmem counters' name consistency.
>  - Modify the strategy to support mTHP for anonymous shmem, discussed with
>    Ryan and David.
>  - Add reviewed tag from Barry.
>  - Update the commit message.
> 
> Baolin Wang (8):
>   mm: move highest_order() and next_order() out of the THP config
>   mm: memory: extend finish_fault() to support large folio
>   mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>   mm: shmem: add THP validation for PMD-mapped THP related statistics
>   mm: shmem: add multi-size THP sysfs interface for anonymous shmem
>   mm: shmem: add mTHP support for anonymous shmem
>   mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
>   mm: shmem: add mTHP counters for anonymous shmem
> 
>  Documentation/admin-guide/mm/transhuge.rst |  29 ++
>  include/linux/huge_mm.h                    |  35 ++-
>  mm/huge_memory.c                           |  17 +-
>  mm/memory.c                                |  43 ++-
>  mm/shmem.c                                 | 335 ++++++++++++++++++---
>  5 files changed, 387 insertions(+), 72 deletions(-)
> 


