Return-Path: <linux-kernel+bounces-198784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3398D7D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFBE1C21C01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD65A4FD;
	Mon,  3 Jun 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Js8w8dOP"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044575821A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403383; cv=none; b=Zy5zMEofhMye20eoh8B8IawWuE7+wbuId1TQRpm2gqUtVYj/dapIhwL3pVNfQWmv5BAxH0ai+VYBKeB/NL8Ml34PMKREp8XcWWus1U6+efzVWE4EH6nxBd76/WN5VqwGr7dvbMtmyxYJ2xWWfHBpLk25/oYF1ff+8vbBiZT1jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403383; c=relaxed/simple;
	bh=Gf44gL9GhWv742wmW6xJd4jWv9SUNPCAH8oNTFWRFy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChPnqfb9P1m65KfEnWowOHlg9h/obCufiJQYEWONiFFGTS3tiQvFEezPqvavzia+onftq3em+ZM2diGRpQwFeuMEDrPv5D5wrKqwE0rGYWbGmFMoMl3bPWCqOEJyZPdv8DCsNMqi+pNjGeTSFYRdMayJX/jw8XVHwYSO1M4q1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Js8w8dOP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717403372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dIiVItZAj91AE/h8Hfi5v4PdhuYCVz06ZTW0yjoFSKA=;
	b=Js8w8dOPvqdJnZvStshNJC+U5/qndL6Dg3/sswu1+ScAUkW3nuhyolHk+gjU6xWQ4F83PlF5HDV14LYvaEK7Y/rMBCqcnXyg0pO1D1xhdQoAponsBJrItqeD7WrZh5XHjcOjfTkGpwICE19uHHjLMO0rt3TsxcoF1isgPAC9sbI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7lD6wK_1717403369;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7lD6wK_1717403369)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 16:29:30 +0800
Message-ID: <e05df24a-6254-430e-88ca-6db23e5c6bab@linux.alibaba.com>
Date: Mon, 3 Jun 2024 16:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large
 folio
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/3 13:28, Barry Song wrote:
> On Thu, May 30, 2024 at 2:04 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add large folio mapping establishment support for finish_fault() as a preparation,
>> to support multi-size THP allocation of anonymous shmem pages in the following
>> patches.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eef4e482c0c2..435187ff7ea4 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>   {
>>          struct vm_area_struct *vma = vmf->vma;
>>          struct page *page;
>> +       struct folio *folio;
>>          vm_fault_t ret;
>>          bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>                        !(vma->vm_flags & VM_SHARED);
>> +       int type, nr_pages, i;
>> +       unsigned long addr = vmf->address;
>>
>>          /* Did we COW the page? */
>>          if (is_cow)
>> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>                          return VM_FAULT_OOM;
>>          }
>>
>> +       folio = page_folio(page);
>> +       nr_pages = folio_nr_pages(folio);
>> +
>> +       /*
>> +        * Using per-page fault to maintain the uffd semantics, and same
>> +        * approach also applies to non-anonymous-shmem faults to avoid
>> +        * inflating the RSS of the process.
> 
> I don't feel the comment explains the root cause.
> For non-shmem, anyway we have allocated the memory? Avoiding inflating
> RSS seems not so useful as we have occupied the memory. the memory footprint

This is also to keep the same behavior as before for non-anon-shmem, and 
will be discussed in the future.

> is what we really care about. so we want to rely on read-ahead hints of subpage
> to determine read-ahead size? that is why we don't map nr_pages for non-shmem
> files though we can potentially reduce nr_pages - 1 page faults?

IMHO, there is 2 cases for non-anon-shmem:
(1) read mmap() faults: we can rely on the 'fault_around_bytes' 
interface to determin what size of mapping to build.
(2) writable mmap() faults: I want to keep the same behavior as before 
(per-page fault), but we can talk about this when I send new patches to 
use mTHP to control large folio allocation for writable mmap().

>> +        */
>> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
>> +               nr_pages = 1;
>> +       } else if (nr_pages > 1) {
>> +               pgoff_t idx = folio_page_idx(folio, page);
>> +               /* The page offset of vmf->address within the VMA. */
>> +               pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
>> +
>> +               /*
>> +                * Fallback to per-page fault in case the folio size in page
>> +                * cache beyond the VMA limits.
>> +                */
>> +               if (unlikely(vma_off < idx ||
>> +                            vma_off + (nr_pages - idx) > vma_pages(vma))) {
>> +                       nr_pages = 1;
>> +               } else {
>> +                       /* Now we can set mappings for the whole large folio. */
>> +                       addr = vmf->address - idx * PAGE_SIZE;
>> +                       page = &folio->page;
>> +               }
>> +       }
>> +
>>          vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>> -                                     vmf->address, &vmf->ptl);
>> +                                      addr, &vmf->ptl);
>>          if (!vmf->pte)
>>                  return VM_FAULT_NOPAGE;
>>
>>          /* Re-check under ptl */
>> -       if (likely(!vmf_pte_changed(vmf))) {
>> -               struct folio *folio = page_folio(page);
>> -               int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>> -
>> -               set_pte_range(vmf, folio, page, 1, vmf->address);
>> -               add_mm_counter(vma->vm_mm, type, 1);
>> -               ret = 0;
>> -       } else {
>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>> +       if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
>> +               update_mmu_tlb(vma, addr, vmf->pte);
>>                  ret = VM_FAULT_NOPAGE;
>> +               goto unlock;
>> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> 
> In what case we can't use !pte_range_none(vmf->pte, 1) for nr_pages == 1
> then unify the code for nr_pages==1 and nr_pages > 1?
> 
> It seems this has been discussed before, but I forget the reason.

IIUC, this is for uffd case, which is not a none pte entry.

