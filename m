Return-Path: <linux-kernel+bounces-528129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75DA413EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516C817198F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CCC19CC24;
	Mon, 24 Feb 2025 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QlOJOU3o"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D21F60A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367284; cv=none; b=TLmRG8UhdtY88Z49+gYH8udpr5xpmVMyJfpmAVI1NrSCFwkU0JT2cNp+f+a2/lz7g03CrMsHi4Lg6+1nU8a8e9muDX83fK9oSCOAJO4QbX5VrK9oz3o5ueHmsFuNw70eA0+nYeBTFOoZSn/gdnftS3l146tH8p8IeoFg0YP76gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367284; c=relaxed/simple;
	bh=W4ca4oW65YYqQWy5xhSy+jnufiB8cod9j3uzuvjto/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQtqOZDGJ8tihldXBVBBge2xiv48fSzsDEb9zOMaS6lU1dS1/W9KzEFT901gxXmGSqgHicAQVEzCT1i75dy+Ro++6CEPnsVM3ZyX6fuiOZX+1jgbpxiGKAje//3/0u85IyeRgTYAyYPek0/0dneNDBnED7AIKmgoYRn7ApRi2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QlOJOU3o; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740367272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lFVUl0ChxVPHiYmaZIlNnh/aUnisCGgY8HqFbQrRlVs=;
	b=QlOJOU3oWq7PLwWZn8mZhPCGOEtOXW1ipHGA5Guxrqwh+lg4nxlDElrfrT231OD2YRZuMz5FCbr/tQzMI0snBdTCOumBUpTT0HV2kGtkOfsOLk8XpYpIinJwLVZ9dU5kA50QSy9Qs8ie1MxA7b+mIlZg4g6TFxmOzGPf0uzfqzE=
Received: from 30.74.144.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQ1wH7x_1740367269 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:21:10 +0800
Message-ID: <731904cf-d862-4c0e-ae5b-26444faff253@linux.alibaba.com>
Date: Mon, 24 Feb 2025 11:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hang when swapping huge=within_size tmpfs from zram
To: Kairui Song <ryncsn@gmail.com>, "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 Daniel Gomez <da.gomez@samsung.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "ziy@nvidia.com" <ziy@nvidia.com>
References: <1738717785.im3r5g2vxc.none.ref@localhost>
 <1738717785.im3r5g2vxc.none@localhost>
 <25e2d5e4-8214-40de-99d3-2b657181a9fd@linux.alibaba.com>
 <5dd39b03-c40e-4f34-bf89-b3e5a12753dc@linux.alibaba.com>
 <CAK1f24ni707gcGpYKXqsb9XHxjx3froLs3DzVqkkNZdca_pw4Q@mail.gmail.com>
 <e7b276eb-960a-4e05-9f84-6152de9ac2ea@linux.alibaba.com>
 <CAMgjq7CNVrQFBozKfZyvXX9w6HqAEH6eSN+ZQFaerbueyyqArw@mail.gmail.com>
 <CAMgjq7DY_C+-rfFiM7=jdRAdCX7Gv17cRMyDpuc3_36bePURww@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7DY_C+-rfFiM7=jdRAdCX7Gv17cRMyDpuc3_36bePURww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kairui,

On 2025/2/24 02:22, Kairui Song wrote:
> On Mon, Feb 24, 2025 at 1:53 AM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> On Fri, Feb 7, 2025 at 3:24 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>> On 2025/2/5 22:39, Lance Yang wrote:
>>>> On Wed, Feb 5, 2025 at 2:38 PM Baolin Wang
>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>> On 2025/2/5 09:55, Baolin Wang wrote:
>>>>>> Hi Alex,
>>>>>>
>>>>>> On 2025/2/5 09:23, Alex Xu (Hello71) wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> On 6.14-rc1, I found that creating a lot of files in tmpfs then deleting
>>>>>>> them reliably hangs when tmpfs is mounted with huge=within_size, and it
>>>>>>> is swapped out to zram (zstd/zsmalloc/no backing dev). I bisected this
>>>>>>> to acd7ccb284b "mm: shmem: add large folio support for tmpfs".
>>>>>>>
>>>>>>> When the issue occurs, rm uses 100% CPU, cannot be killed, and has no
>>>>>>> output in /proc/pid/stack or wchan. Eventually, an RCU stall is
>>>>>>> detected:
>>>>>>
>>>>>> Thanks for your report. Let me try to reproduce the issue locally and
>>>>>> see what happens.
>>>>>>
>>>>>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>>>>> rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-11): P25160
>>>>>>> rcu:     (detected by 10, t=2102 jiffies, g=532677, q=4997 ncpus=12)
>>>>>>> task:rm              state:R  running task     stack:0     pid:25160
>>>>>>> tgid:25160 ppid:24309  task_flags:0x400000 flags:0x00004004
>>>>>>> Call Trace:
>>>>>>>     <TASK>
>>>>>>>     ? __schedule+0x388/0x1000
>>>>>>>     ? kmem_cache_free.part.0+0x23d/0x280
>>>>>>>     ? sysvec_apic_timer_interrupt+0xa/0x80
>>>>>>>     ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>>>     ? xas_load+0x12/0xc0
>>>>>>>     ? xas_load+0x8/0xc0
>>>>>>>     ? xas_find+0x144/0x190
>>>>>>>     ? find_lock_entries+0x75/0x260
>>>>>>>     ? shmem_undo_range+0xe6/0x5f0
>>>>>>>     ? shmem_evict_inode+0xe4/0x230
>>>>>>>     ? mtree_erase+0x7e/0xe0
>>>>>>>     ? inode_set_ctime_current+0x2e/0x1f0
>>>>>>>     ? evict+0xe9/0x260
>>>>>>>     ? _atomic_dec_and_lock+0x31/0x50
>>>>>>>     ? do_unlinkat+0x270/0x2b0
>>>>>>>     ? __x64_sys_unlinkat+0x30/0x50
>>>>>>>     ? do_syscall_64+0x37/0xe0
>>>>>>>     ? entry_SYSCALL_64_after_hwframe+0x50/0x58
>>>>>>>     </TASK>
>>>>>>>
>>>>>>> Let me know what information is needed to further troubleshoot this
>>>>>>> issue.
>>>>>
>>>>> Sorry, I can't reproduce this issue, and my testing process is as follows:
>>>>> 1. Mount tmpfs with huge=within_size
>>>>> 2. Create and write a tmpfs file
>>>>> 3. Swap out the large folios of the tmpfs file to zram
>>>>> 4. Execute 'rm' command to remove the tmpfs file
>>>>
>>>> I’m unable to reproduce the issue as well, and am following steps similar
>>>> to Baolin's process:
>>>>
>>>> 1) Mount tmpfs with the huge=within_size option and enable swap (using
>>>> zstd/zsmalloc without a backing device).
>>>> 2) Create and write over 10,000 files in the tmpfs.
>>>> 3) Swap out the large folios of these tmpfs files to zram.
>>>> 4) Use the rm command to delete all the files from the tmpfs.
>>>>
>>>> Testing with both 2MiB and 64KiB large folio sizes, and with
>>>> shmem_enabled=within_size, but everything works as expected.
>>>
>>> Thanks Lance for confirming again.
>>>
>>> Alex, could you give more hints on how to reproduce this issue?
>>>
>>
>> Hi Baolin,
>>
>> I can reproduce this issue very easily with the build linux kernel
>> test, and the failure rate is very high. I'm not exactly sure this is
>> the same bug but very likely, my test step:
>>
>> 1. Create a 10G ZRAM device and set up SWAP on it.
>> 2. Create a 1G memcg, and spawn a shell in it.
>> 3. Mount tmpfs with huge=within_size, and then untar linux kernel
>> source code into it.
>> 4. Build with make -j32 (higher or lower job number may also work),
>> the build will always fall within 10s due to file corrupted.

Very appreciated for your reproducer, and now I can reproduce the issue 
locally.

>> After some debugging, the reason is in shmem_swapin_folio, when swap
>> cache is hit `folio = swap_cache_get_folio(swap, NULL, 0);` sets folio
>> to a 0 order folio, then the following shmem_add_to_page_cache will
>> insert a order 0 folio overriding a high order entry in shmem's
>> xarray, so data are lost. Swap cache hit could be due to many reasons,
>> in this case it's the readahead.

Yes, thanks for your analysis. I missed that the swap readahead can swap 
in order 0 folios asynchronously.

>>
>> One quick fix is just always split the entry upon shmem fault of 0
>> order folio like this:
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 4ea6109a8043..c8e5c419c675 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2341,6 +2341,10 @@ static int shmem_swapin_folio(struct inode
>> *inode, pgoff_t index,
>>                  }
>>          }
>>
>> +       /* Swapin of 0 order folio must always ensure the entries are split */
>> +       if (!folio_order(folio))
>> +               shmem_split_large_entry(inode, index, swap, gfp);
>> +
>>   alloced:
>>          /* We have to do this with folio locked to prevent races */
>>          folio_lock(folio);

I don't think we should always split the large entry when getting folio 
from the swap cache. Instead, splitting should only be done when the 
order stored in the shmem mapping is inconsistent with the folio order, 
as well as updating the swap value.

Could you help to try below fix? I tested it and it can work well with 
your reproducer. Thanks a lot.

diff --git a/mm/shmem.c b/mm/shmem.c
index 671f63063fd4..7e70081a96d4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2253,7 +2253,7 @@ static int shmem_swapin_folio(struct inode *inode, 
pgoff_t index,
         struct folio *folio = NULL;
         bool skip_swapcache = false;
         swp_entry_t swap;
-       int error, nr_pages;
+       int error, nr_pages, order, split_order;

         VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
         swap = radix_to_swp_entry(*foliop);
@@ -2272,10 +2272,9 @@ static int shmem_swapin_folio(struct inode 
*inode, pgoff_t index,

         /* Look it up and read it in.. */
         folio = swap_cache_get_folio(swap, NULL, 0);
+       order = xa_get_order(&mapping->i_pages, index);
         if (!folio) {
-               int order = xa_get_order(&mapping->i_pages, index);
                 bool fallback_order0 = false;
-               int split_order;

                 /* Or update major stats only when swapin succeeds?? */
                 if (fault_type) {
@@ -2339,6 +2338,29 @@ static int shmem_swapin_folio(struct inode 
*inode, pgoff_t index,
                         error = -ENOMEM;
                         goto failed;
                 }
+       } else if (order != folio_order(folio)) {
+               /*
+                * Swap readahead may swap in order 0 folios into swapcache
+                * asynchronously, while the shmem mapping can still stores
+                * large swap entries. In such cases, we should split the
+                * large swap entry to prevent possible data loss.
+                */
+               split_order = shmem_split_large_entry(inode, index, 
swap, gfp);
+               if (split_order < 0) {
+                       error = split_order;
+                       goto failed;
+               }
+
+               /*
+                * If the large swap entry has already been split, it is
+                * necessary to recalculate the new swap entry based on
+                * the old order alignment.
+                */
+               if (split_order > 0) {
+                       pgoff_t offset = index - round_down(index, 1 << 
split_order);
+
+                       swap = swp_entry(swp_type(swap), 
swp_offset(swap) + offset);
+               }
         }

  alloced:
@@ -2346,7 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, 
pgoff_t index,
         folio_lock(folio);
         if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
             folio->swap.val != swap.val ||
-           !shmem_confirm_swap(mapping, index, swap)) {
+           !shmem_confirm_swap(mapping, index, swap) ||
+           xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
                 error = -EEXIST;
                 goto unlock;
         }

>> And Hi Alex, can you help confirm if the above patch fixes your reported bug?
>>
>> If we are OK with this, this should be merged into 6.14 I think, but
>> for the long term, it might be a good idea to just share a similar
>> logic of (or just reuse) __filemap_add_folio for shmem?
>> __filemap_add_folio will split the entry on insert, and code will be
>> much cleaner.
> 
> Some extra comments for above patch: If it raced with another split,
> or the entry used for swap cache lookup is wrongly aligned due to
> large entry, the shmem_add_to_page_cache below will fail with -EEXIST
> and try again. So that seems to be working well in my test.

