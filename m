Return-Path: <linux-kernel+bounces-560119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C42A5FDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC86C19C55A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18881D63F0;
	Thu, 13 Mar 2025 17:36:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372C16DC28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887382; cv=none; b=YQm6nfBcNS/3mVRi4+unu9/BLl7VxSqLvcy+Nf9C9i8UNm5VFX+ZAZ7DLF9zUgOZSvl2EvkpTpZ7C0DIvC+4sa6CSeItBvxARC4IlaL6XVL7NVAS8L98aoZzTwI6j0cBjkKkePGyD2CGZD/pwSk/+xchkAH87rxn51oKxmtyMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887382; c=relaxed/simple;
	bh=XNL7SjgEWbuj0RlOTms4N6GFMRUx3ozOE1PYOxjnvj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1IWtG4ENoGNC45peNj3eli/ryGsNzRvzDTiRfbPOje6fsqnhDuTNuf+LWio1+LnP+fGXIAmnNyYfcqGE4rjJu57W6xy60zcD7dmNnxhE68qcDOO7KzUTqFH/OhYQee6rWz2HByXfOpjimEkGMcl39RjKRBTWaLn+fp1mVFV7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188FD150C;
	Thu, 13 Mar 2025 10:36:30 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5C63F673;
	Thu, 13 Mar 2025 10:36:18 -0700 (PDT)
Message-ID: <2fb974bb-1470-4a5f-90d5-97456140c98f@arm.com>
Date: Thu, 13 Mar 2025 17:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <3750d3f8-17c6-4bb8-8107-215d442e4ec3@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3750d3f8-17c6-4bb8-8107-215d442e4ec3@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 17:28, Yang Shi wrote:
> Hi Ryan,
> 
> I saw Miko posted a new spin of his patches. There are some slight changes that
> have impact to my patches (basically check the new boot parameter). Do you
> prefer I rebase my patches on top of his new spin right now then restart review
> from the new spin or review the current patches then solve the new review
> comments and rebase to Miko's new spin together?

Hi Yang,

Sorry I haven't got to reviewing this version yet, it's in my queue!

I'm happy to review against v3 as it is. I'm familiar with Miko's series and am
not too bothered about the integration with that; I think it's pretty straight
forward. I'm more interested in how you are handling the splitting, which I
think is the bulk of the effort.

I'm hoping to get to this next week before heading out to LSF/MM the following
week (might I see you there?)

Thanks,
Ryan


> 
> Thanks,
> Yang
> 
> 
> On 3/4/25 2:19 PM, Yang Shi wrote:
>> Changelog
>> =========
>> v3:
>>    * Rebased to v6.14-rc4.
>>    * Based on Miko's BBML2 cpufeature patch (https://lore.kernel.org/linux-
>> arm-kernel/20250228182403.6269-3-miko.lenczewski@arm.com/).
>>      Also included in this series in order to have the complete patchset.
>>    * Enhanced __create_pgd_mapping() to handle split as well per Ryan.
>>    * Supported CONT mappings per Ryan.
>>    * Supported asymmetric system by splitting kernel linear mapping if such
>>      system is detected per Ryan. I don't have such system to test, so the
>>      testing is done by hacking kernel to call linear mapping repainting
>>      unconditionally. The linear mapping doesn't have any block and cont
>>      mappings after booting.
>>
>> RFC v2:
>>    * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
>>      conflict gracefully per Will Deacon
>>    * Rebased onto v6.13-rc5
>>    * https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-
>> yang@os.amperecomputing.com/
>>
>> RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-
>> yang@os.amperecomputing.com/
>>
>> Description
>> ===========
>> When rodata=full kernel linear mapping is mapped by PTE due to arm's
>> break-before-make rule.
>>
>> A number of performance issues arise when the kernel linear map is using
>> PTE entries due to arm's break-before-make rule:
>>    - performance degradation
>>    - more TLB pressure
>>    - memory waste for kernel page table
>>
>> These issues can be avoided by specifying rodata=on the kernel command
>> line but this disables the alias checks on page table permissions and
>> therefore compromises security somewhat.
>>
>> With FEAT_BBM level 2 support it is no longer necessary to invalidate the
>> page table entry when changing page sizes.  This allows the kernel to
>> split large mappings after boot is complete.
>>
>> This patch adds support for splitting large mappings when FEAT_BBM level 2
>> is available and rodata=full is used. This functionality will be used
>> when modifying page permissions for individual page frames.
>>
>> Without FEAT_BBM level 2 we will keep the kernel linear map using PTEs
>> only.
>>
>> If the system is asymmetric, the kernel linear mapping may be repainted once
>> the BBML2 capability is finalized on all CPUs.  See patch #6 for more details.
>>
>> We saw significant performance increases in some benchmarks with
>> rodata=full without compromising the security features of the kernel.
>>
>> Testing
>> =======
>> The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
>> 4K page size + 48 bit VA.
>>
>> Function test (4K/16K/64K page size)
>>    - Kernel boot.  Kernel needs change kernel linear mapping permission at
>>      boot stage, if the patch didn't work, kernel typically didn't boot.
>>    - Module stress from stress-ng. Kernel module load change permission for
>>      linear mapping.
>>    - A test kernel module which allocates 80% of total memory via vmalloc(),
>>      then change the vmalloc area permission to RO, this also change linear
>>      mapping permission to RO, then change it back before vfree(). Then launch
>>      a VM which consumes almost all physical memory.
>>    - VM with the patchset applied in guest kernel too.
>>    - Kernel build in VM with guest kernel which has this series applied.
>>    - rodata=on. Make sure other rodata mode is not broken.
>>    - Boot on the machine which doesn't support BBML2.
>>
>> Performance
>> ===========
>> Memory consumption
>> Before:
>> MemTotal:       258988984 kB
>> MemFree:        254821700 kB
>>
>> After:
>> MemTotal:       259505132 kB
>> MemFree:        255410264 kB
>>
>> Around 500MB more memory are free to use.  The larger the machine, the
>> more memory saved.
>>
>> Performance benchmarking
>> * Memcached
>> We saw performance degradation when running Memcached benchmark with
>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>> latency is reduced by around 9.6%.
>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>> MPKI is reduced by 28.5%.
>>
>> The benchmark data is now on par with rodata=on too.
>>
>> * Disk encryption (dm-crypt) benchmark
>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>> encryption (by dm-crypt).
>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>      --name=iops-test-job --eta-newline=1 --size 100G
>>
>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>> number of good case is around 90% more than the best number of bad case).
>> The bandwidth is increased and the avg clat is reduced proportionally.
>>
>> * Sequential file read
>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>> The bandwidth is increased by 150%.
>>
>>
>> Mikołaj Lenczewski (1):
>>        arm64: Add BBM Level 2 cpu feature
>>
>> Yang Shi (5):
>>        arm64: cpufeature: add AmpereOne to BBML2 allow list
>>        arm64: mm: make __create_pgd_mapping() and helpers non-void
>>        arm64: mm: support large block mapping when rodata=full
>>        arm64: mm: support split CONT mappings
>>        arm64: mm: split linear mapping if BBML2 is not supported on secondary
>> CPUs
>>
>>   arch/arm64/Kconfig                  |  11 +++++
>>   arch/arm64/include/asm/cpucaps.h    |   2 +
>>   arch/arm64/include/asm/cpufeature.h |  15 ++++++
>>   arch/arm64/include/asm/mmu.h        |   4 ++
>>   arch/arm64/include/asm/pgtable.h    |  12 ++++-
>>   arch/arm64/kernel/cpufeature.c      |  95 +++++++++++++++++++++++++++++++++++++
>>   arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++-------------------
>>   arch/arm64/mm/pageattr.c            |  37 ++++++++++++---
>>   arch/arm64/tools/cpucaps            |   1 +
>>   9 files changed, 518 insertions(+), 56 deletions(-)
>>
>>
> 


