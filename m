Return-Path: <linux-kernel+bounces-516053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BDCA36C76
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D29E171FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832419539F;
	Sat, 15 Feb 2025 07:36:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB77194A65
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739604993; cv=none; b=FgrMcrn84nEc7Y1fL/YeCUlqGsC0liepgC/1DYpoPDEnDKh2UnQaQ/8EIcSdt0VoRg6q1B6W+DJ+evkNvN4eLVJ7GkTtFlgiSlOAJzG+5fpLut+rbyVeRhrYSLgBHJbYydJuOgm82TS+uPddFXHySRfKxKsPWuPp3ndJh7N+zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739604993; c=relaxed/simple;
	bh=kD7ooo3fdmP0TSZ/VJYzoMxjB72uur9UF0s2uoRoG0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfM9MAJKa+RylEehIIDxDQRxKwwIRTUHOBixIV4r1dC4fQCnO3YtjtWcs7QXjkQWxRvSmNksVguqFxIuYbFbkb9FWjs4uXMrVXz54i0FYceUa/aUAGO78WHnAAzbbED7Tx0iUs+zkDINS6C6PqwK3rXejIofBpN67VL7jbJMiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DB871063;
	Fri, 14 Feb 2025 23:36:50 -0800 (PST)
Received: from [10.163.93.19] (unknown [10.163.93.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D67B3F5A1;
	Fri, 14 Feb 2025 23:36:19 -0800 (PST)
Message-ID: <22a68888-f6a1-4707-aa19-ad8d5c005478@arm.com>
Date: Sat, 15 Feb 2025 13:06:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] khugepaged: Asynchronous mTHP collapse
To: Nico Pache <npache@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250211111326.14295-1-dev.jain@arm.com>
 <CAA1CXcACBMTPN-y4-J6wgiTf90ia5576xOJKFULnvGPCt56U6w@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAA1CXcACBMTPN-y4-J6wgiTf90ia5576xOJKFULnvGPCt56U6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/02/25 7:17 am, Nico Pache wrote:
> Hi Dev,
> 
> I tried to run your kernel to get some performance numbers out of it,
> but ran into the following issue while running my defer-mthp-test.sh
> workload.
> 
> [  297.393032] =====================================
> [  297.393618] WARNING: bad unlock balance detected!
> [  297.394201] 6.14.0-rc2mthpDEV #2 Not tainted
> [  297.394732] -------------------------------------
> [  297.395421] khugepaged/111 is trying to release lock (&mm->mmap_lock) at:
> [  297.396509] [<ffffffff947cb76a>] khugepaged+0x23a/0xb40
> [  297.397205] but there are no more locks to release!
> [  297.397865]
> [  297.397865] other info that might help us debug this:
> [  297.398684] no locks held by khugepaged/111.
> [  297.399155]
> [  297.399155] stack backtrace:
> [  297.399591] CPU: 10 UID: 0 PID: 111 Comm: khugepaged Not tainted
> 6.14.0-rc2mthpDEV #2
> [  297.399593] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-2.fc40 04/01/2014
> [  297.399595] Call Trace:
> [  297.399599]  <TASK>
> [  297.399602]  dump_stack_lvl+0x6e/0xa0
> [  297.399607]  ? khugepaged+0x23a/0xb40
> [  297.399610]  print_unlock_imbalance_bug.part.0+0xfb/0x110
> [  297.399612]  ? khugepaged+0x23a/0xb40
> [  297.399614]  lock_release+0x283/0x3f0
> [  297.399620]  up_read+0x1b/0x30
> [  297.399622]  khugepaged+0x23a/0xb40
> [  297.399631]  ? __pfx_khugepaged+0x10/0x10
> [  297.399633]  kthread+0xf2/0x240
> [  297.399636]  ? __pfx_kthread+0x10/0x10
> [  297.399638]  ret_from_fork+0x34/0x50
> [  297.399640]  ? __pfx_kthread+0x10/0x10
> [  297.399642]  ret_from_fork_asm+0x1a/0x30
> [  297.399649]  </TASK>
> [  297.505555] ------------[ cut here ]------------
> [  297.506044] DEBUG_RWSEMS_WARN_ON(tmp < 0): count =
> 0xffffffffffffff00, magic = 0xffff8c6e03bc1f88, owner = 0x1, curr
> 0xffff8c6e0eccb700, list empty
> [  297.507362] WARNING: CPU: 8 PID: 1946 at
> kernel/locking/rwsem.c:1346 __up_read+0x1ba/0x220
> [  297.508220] Modules linked in: nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 rfkill nf_tables intel_rapl_msr intel_rapl_common
> kvm_amd iTCO_wdt intel_pmc_bxt iTCO_vendor_support kvm i2c_i801
> i2c_smbus lpc_ich virtio_net net_failover failover virtio_balloon
> joydev fuse loop nfnetlink zram xfs polyval_clmulni polyval_generic
> ghash_clmulni_intel sha512_ssse3 sha256_ssse3 virtio_console
> virtio_blk sha1_ssse3 serio_raw qemu_fw_cfg
> [  297.513474] CPU: 8 UID: 0 PID: 1946 Comm: thp_test Not tainted
> 6.14.0-rc2mthpDEV #2
> [  297.514314] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-2.fc40 04/01/2014
> [  297.515265] RIP: 0010:__up_read+0x1ba/0x220
> [  297.515756] Code: c6 78 8b e1 95 48 c7 c7 88 0e d3 95 48 39 c2 48
> c7 c2 be 39 e4 95 48 c7 c0 29 8b e1 95 48 0f 44 c2 48 8b 13 50 e8 e6
> 44 f5 ff <0f> 0b 58 e9 20 ff ff ff 48 8b 57 60 48 8d 47 60 4c 8b 47 08
> c6 05
> [  297.517659] RSP: 0018:ffffa8a943533ac8 EFLAGS: 00010282
> [  297.518209] RAX: 0000000000000000 RBX: ffff8c6e03bc1f88 RCX: 0000000000000000
> [  297.518884] RDX: ffff8c7366ff0980 RSI: ffff8c7366fe1a80 RDI: ffff8c7366fe1a80
> [  297.519577] RBP: ffffa8a943533b58 R08: 0000000000000000 R09: 0000000000000001
> [  297.520272] R10: 0000000000000000 R11: 0770076d07650720 R12: ffffa8a943533b10
> [  297.520949] R13: ffff8c6e03bc1f88 R14: ffffa8a943533b58 R15: ffffa8a943533b10
> [  297.521651] FS:  00007f24de01b740(0000) GS:ffff8c7366e00000(0000)
> knlGS:0000000000000000
> [  297.522425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  297.522990] CR2: 0000000a7ffef000 CR3: 000000010d9d6000 CR4: 0000000000750ef0
> [  297.523799] PKRU: 55555554
> [  297.524100] Call Trace:
> [  297.524367]  <TASK>
> [  297.524597]  ? __warn.cold+0xb7/0x151
> [  297.525072]  ? __up_read+0x1ba/0x220
> [  297.525442]  ? report_bug+0xff/0x140
> [  297.525804]  ? console_unlock+0x9d/0x150
> [  297.526233]  ? handle_bug+0x58/0x90
> [  297.526590]  ? exc_invalid_op+0x17/0x70
> [  297.526993]  ? asm_exc_invalid_op+0x1a/0x20
> [  297.527420]  ? __up_read+0x1ba/0x220
> [  297.527783]  ? __up_read+0x1ba/0x220
> [  297.528160]  vms_complete_munmap_vmas+0x19c/0x1f0
> [  297.528628]  do_vmi_align_munmap+0x20a/0x280
> [  297.529069]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.529552]  do_vmi_munmap+0xd0/0x190
> [  297.529920]  __vm_munmap+0xb1/0x1b0
> [  297.530293]  __x64_sys_munmap+0x1b/0x30
> [  297.530677]  do_syscall_64+0x95/0x180
> [  297.531058]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.531534]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [  297.532167]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.532640]  ? syscall_exit_to_user_mode+0x97/0x290
> [  297.533226]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.533701]  ? do_syscall_64+0xa1/0x180
> [  297.534097]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.534587]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [  297.535129]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.535603]  ? syscall_exit_to_user_mode+0x97/0x290
> [  297.536092]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.536568]  ? do_syscall_64+0xa1/0x180
> [  297.536954]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.537444]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [  297.537936]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.538524]  ? syscall_exit_to_user_mode+0x97/0x290
> [  297.539044]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.539526]  ? do_syscall_64+0xa1/0x180
> [  297.539931]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.540597]  ? do_user_addr_fault+0x5a9/0x8a0
> [  297.541102]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.541580]  ? trace_hardirqs_off+0x4b/0xc0
> [  297.542011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.542488]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [  297.542991]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  297.543466]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  297.543960] RIP: 0033:0x7f24de1367eb
> [  297.544344] Code: 73 01 c3 48 8b 0d 2d f6 0c 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd f5 0c 00 f7 d8 64 89
> 01 48
> [  297.546074] RSP: 002b:00007ffc7bb2e2b8 EFLAGS: 00000206 ORIG_RAX:
> 000000000000000b
> [  297.546796] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f24de1367eb
> [  297.547488] RDX: 0000000080000000 RSI: 0000000080000000 RDI: 0000000480000000
> [  297.548182] RBP: 00007ffc7bb2e390 R08: 0000000000000064 R09: 00000000fffffffe
> [  297.548884] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000006
> [  297.549594] R13: 0000000000000000 R14: 00007f24de258000 R15: 0000000000403e00
> [  297.550292]  </TASK>
> [  297.550530] irq event stamp: 64417291
> [  297.550903] hardirqs last  enabled at (64417291):
> [<ffffffff94749232>] seqcount_lockdep_reader_access+0x82/0x90
> [  297.551859] hardirqs last disabled at (64417290):
> [<ffffffff947491fe>] seqcount_lockdep_reader_access+0x4e/0x90
> [  297.552810] softirqs last  enabled at (64413640):
> [<ffffffff943bf3c2>] __irq_exit_rcu+0xe2/0x100
> [  297.553654] softirqs last disabled at (64413627):
> [<ffffffff943bf3c2>] __irq_exit_rcu+0xe2/0x100
> [  297.554504] ---[ end trace 0000000000000000 ]---

Thanks for testing. Hmm...can you do this: Drop patches 12-16, and 
instead of 16, apply this:

commit 112f4fa8e92b2bb93051595b2a804b3546b3545a
Author: Dev Jain <dev.jain@arm.com>
Date:   Fri Jan 24 10:52:15 2025 +0000

     khugepaged: Implement strict policy for mTHP collapse

     Signed-off-by: Dev Jain <dev.jain@arm.com>

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 37cfa7beba3d..1caf9eb3bfd9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -417,6 +417,17 @@ static inline int 
hpage_collapse_test_exit_or_disable(struct mm_struct *mm)

  static bool thp_enabled(void)
  {
+	bool anon_pmd_enabled = (test_bit(PMD_ORDER, &huge_anon_orders_always) ||
+				 test_bit(PMD_ORDER, &huge_anon_orders_madvise) ||
+			         (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
+			         hugepage_global_enabled()));
+
+	/*
+	 * If PMD_ORDER is ineligible for collapse, check if mTHP collapse 
policy is obeyed;
+	 * see Documentation/admin-guide/transhuge.rst
+	 */
+	bool anon_collapse_mthp = (khugepaged_max_ptes_none == 0 ||
+			      khugepaged_max_ptes_none == HPAGE_PMD_NR - 1);
  	/*
  	 * We cover the anon, shmem and the file-backed case here; file-backed
  	 * hugepages, when configured in, are determined by the global control.
@@ -427,8 +438,9 @@ static bool thp_enabled(void)
  	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
  	    hugepage_global_enabled())
  		return true;
-	if (huge_anon_orders_always || huge_anon_orders_madvise ||
-	    (huge_anon_orders_inherit && hugepage_global_enabled()))
+	if ((huge_anon_orders_always || huge_anon_orders_madvise ||
+	    (huge_anon_orders_inherit && hugepage_global_enabled())) &&
+	    (anon_pmd_enabled || anon_collapse_mthp))
  		return true;
  	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
  		return true;
@@ -578,13 +590,16 @@ static int __collapse_huge_page_isolate(struct 
vm_area_struct *vma,
  	pte_t *_pte;
  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
  	bool writable = false;
-	unsigned int max_ptes_shared = khugepaged_max_ptes_shared >> 
(HPAGE_PMD_ORDER - order);
+	unsigned int max_ptes_shared = khugepaged_max_ptes_shared;
  	unsigned int max_ptes_none = khugepaged_max_ptes_none >> 
(HPAGE_PMD_ORDER - order);
  	bool all_pfns_present = true;
  	bool all_pfns_contig = true;
  	bool first_pfn_aligned = true;
  	pte_t prev_pteval;

+	if (order != HPAGE_PMD_ORDER)
+		max_ptes_shared = 0;
+
  	for (_pte = pte; _pte < pte + (1UL << order);
  	     _pte++, address += PAGE_SIZE) {
  		pte_t pteval = ptep_get(_pte);
@@ -1442,11 +1457,16 @@ static int hpage_collapse_scan_pmd(struct 
mm_struct *mm,
  	if (!cc->is_khugepaged)
  		order = HPAGE_PMD_ORDER;

+	max_ptes_none = khugepaged_max_ptes_none;
+	max_ptes_shared = khugepaged_max_ptes_shared;
+	max_ptes_swap = khugepaged_max_ptes_swap;
+
  scan_pte_range:

-	max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
+	if (order != HPAGE_PMD_ORDER)
+		max_ptes_shared = max_ptes_swap = 0;
+
  	max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
-	max_ptes_swap = khugepaged_max_ptes_swap >> (HPAGE_PMD_ORDER - order);
  	referenced = 0, shared = 0, none_or_zero = 0, unmapped = 0;
  	all_pfns_present = true, all_pfns_contig = true, first_pfn_aligned = 
true;

@@ -2636,6 +2656,11 @@ static unsigned int 
khugepaged_scan_mm_slot(unsigned int pages, int *result,
  	struct mm_struct *mm;
  	struct vm_area_struct *vma;
  	int progress = 0;
+	bool collapse_mthp = true;
+
+	/* Avoid the creep problem; see Documentation/admin-guide/transhuge.rst */
+	if (khugepaged_max_ptes_none && khugepaged_max_ptes_none != 
HPAGE_PMD_NR - 1)
+		collapse_mthp = false;

  	VM_BUG_ON(!pages);
  	lockdep_assert_held(&khugepaged_mm_lock);

The dropped patches are the variable-sized VMA extension, and 
implementing that was quite a task, I ran into a lot of problems...and 
also, David notes that we may have to take the rmap locks in patch 13 of 
my v2 after all...in any case the implementation can be brute-forced by 
implementing a function akin to mm_take_all_locks().

Also, the policy I am implementing for large folio skip is different 
from v1; now I am not necessarily skipping if I see a large folio. So 
this may increase the latency of my method too, so it may not be a fair 
comparison, although I don't think this should cause a major difference.

> 
> 
> 
> 
> On Tue, Feb 11, 2025 at 4:13 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>> This patchset extends khugepaged from collapsing only PMD-sized THPs to
>> collapsing anonymous mTHPs.
>>
>> mTHPs were introduced in the kernel to improve memory management by allocating
>> chunks of larger memory, so as to reduce number of page faults, TLB misses (due
>> to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP property
>> is often lost due to CoW, swap-in/out, and when the kernel just cannot find
>> enough physically contiguous memory to allocate on fault. Henceforth, there is a
>> need to regain mTHPs in the system asynchronously. This work is an attempt in
>> this direction, starting with anonymous folios.
>>
>> In the fault handler, we select the THP order in a greedy manner; the same has
>> been used here, along with the same sysfs interface to control the order of
>> collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap_write_lock().
>>
>> ---------------------------------------------------------
>> Testing
>> ---------------------------------------------------------
>>
>> The set has been build tested on x86_64.
>> For Aarch64,
>> 1. mm-selftests: No regressions.
>> 2. Analyzing with tools/mm/thpmaps on different userspace programs mapping
>>     aligned VMAs of a large size, faulting in basepages/mTHPs (according to sysfs),
>>     and then madvise()'ing the VMA, khugepaged is able to 100% collapse the VMAs.
>>
>> This patchset is rebased on mm-unstable (4637fa5d47a49c977116321cc575ea22215df22d).
>>
>> v1->v2:
>>   - Handle VMAs less than PMD size (patches 12-15)
>>   - Do not add mTHP into deferred split queue
>>   - Drop lock optimization and collapse mTHP under mmap_write_lock()
>>   - Define policy on what to do when we encounter a folio order larger than
>>     the order we are scanning for
>>   - Prevent the creep problem by enforcing tunable simplification
>>   - Update Documentation
>>   - Drop patch 12 from v1 updating selftest w.r.t the creep problem
>>   - Drop patch 1 from v1
>>
>>   v1:
>>   https://lore.kernel.org/all/20241216165105.56185-1-dev.jain@arm.com/
>>
>> Dev Jain (17):
>>    khugepaged: Generalize alloc_charge_folio()
>>    khugepaged: Generalize hugepage_vma_revalidate()
>>    khugepaged: Generalize __collapse_huge_page_swapin()
>>    khugepaged: Generalize __collapse_huge_page_isolate()
>>    khugepaged: Generalize __collapse_huge_page_copy()
>>    khugepaged: Abstract PMD-THP collapse
>>    khugepaged: Scan PTEs order-wise
>>    khugepaged: Introduce vma_collapse_anon_folio()
>>    khugepaged: Define collapse policy if a larger folio is already mapped
>>    khugepaged: Exit early on fully-mapped aligned mTHP
>>    khugepaged: Enable sysfs to control order of collapse
>>    khugepaged: Enable variable-sized VMA collapse
>>    khugepaged: Lock all VMAs mapping the PTE table
>>    khugepaged: Reset scan address to correct alignment
>>    khugepaged: Delay cond_resched()
>>    khugepaged: Implement strict policy for mTHP collapse
>>    Documentation: transhuge: Define khugepaged mTHP collapse policy
>>
>>   Documentation/admin-guide/mm/transhuge.rst |  49 +-
>>   include/linux/huge_mm.h                    |   2 +
>>   mm/huge_memory.c                           |   4 +
>>   mm/khugepaged.c                            | 603 ++++++++++++++++-----
>>   4 files changed, 511 insertions(+), 147 deletions(-)
>>
>> --
>> 2.30.2
>>
> 
> 


