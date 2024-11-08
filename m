Return-Path: <linux-kernel+bounces-401148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7F9C167A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B06C282D31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7351CCB49;
	Fri,  8 Nov 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H36shx4T"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780916415
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047479; cv=none; b=VtjtiaPdWaHd/yFhs9d4O7gnAgBZDTRkwBnaV3YBp7P+pQAYYqppxL0VXi9Hp/0ImC8/I9J5SmR/74zdO1i5XWYW7nDOOuG1T3JhU8BWjqxX8VIrHZd9YDR0vvkNjRkm8xEAzqWSSNIQMgvwXncgCthl7SS9em+ygtx1VvmpIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047479; c=relaxed/simple;
	bh=2TyBfjUa4TM3JIammkr6/wX8J22AyP4t9yHHJpKwdNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNjdhdMA/Y+YgB8FJsGrZT250eX0zsyO9yiXCLXyCVki3ZIQWF/pY8PBCadgYTGWUc53Jsx2Jo5n9wwslNrVGnOEjcIZxg9AKqEJAyc9VNDtgKYZWkkN82p2fEMI4pRBwhSl6og3rB6JwlsdIGOm3aPj9zeDnXP/3JPkFJGvm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H36shx4T; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71815313303so1123273a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731047476; x=1731652276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NZnfOJdCuNj5ZxPmV6I8/TJGXL/OmAPnFXG21goLgc=;
        b=H36shx4TH9R8tisiI+Q0YneZdRYyEhmxhV8Fx2iN+jF+8KILrNnP/kOych2bGCi3rc
         zxXCpQZdlxbHgE4OuBMPGmGK3i7CZQ0yOG+mKCT13Ew6hCLc4NgZ+p4CILu4KPZ3Nal2
         /neCQy0g1sHGiJfzDGQn4F7eG9DBjjGOSoYTs72+sC+eg+13/n9p96cBRm7WfEzIP28f
         LztFedlneCR64AWay1W/D50OmiDKl9+3uH6j2bhQ0ZmU3HO31VTOwa7thw1FU5zNovTv
         xC0xP1yVZd8fKlzX8Qhq28M4s+jbWyUvYuyPxd+qjmbaXWBqFOuNU3HbLpad0QOFkmKh
         ECXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731047476; x=1731652276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NZnfOJdCuNj5ZxPmV6I8/TJGXL/OmAPnFXG21goLgc=;
        b=HwyMe5SQGkshk/RSjwIlvkiP9xMbCR1BDxGFrl+k9m/HC0gvQ3Dz/7PPfMwYBSAliU
         /x77lyR0FfaWo8CXAUH1nJZ0YPImUQM37oxBHkSlxk5lwgTfSzilWxL6gmvM4x2fSfK+
         6W/8yx5mgMOOM9+a8Kbz4nNGQzC+4U9/jP60o1fK3ALYz2ayVav+paVMhiw0YAdhbFOZ
         EZW1qsUBCnctyKm7ZHRadSljRU29e/XEAPBgBVRCIpuMgNfEJ9Faq2sgDBfR0wQ9VWmG
         x9SNZl9L/nlplfSeZeLMttrqPz3zy8ejuin4n/tqnFt/4ADPse7h3JEtXgKEzqpjloa2
         aV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXC2a1AIEA/TUBmDlCzGdtWhEiJQHho4TNyr+Ll/nISv+YRUGZ22hlvmLJeCeNqd+wRbB46fM0L6K7/6I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYUYz+X50Pk15yonmFoxYX6/tZR/Qx8yp6vclgygZTWsMqB+N
	9Y+Rxk+Od2LIeuooKPD322WiV963XyDsgWVttBvhATqyHa8dRrTvXqwgbai3E3o=
X-Google-Smtp-Source: AGHT+IEOtfVNZTPaBYRzQJ8jNgoTz/wfxjh37S+VgS99ei7oTAWhoWcU1xRhhPgslL5F9oKZGvftaw==
X-Received: by 2002:a05:6830:3708:b0:718:15a9:505f with SMTP id 46e09a7af769-71a1c1db215mr2575926a34.14.1731047476255;
        Thu, 07 Nov 2024 22:31:16 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65ba92sm2605417a12.80.2024.11.07.22.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 22:31:15 -0800 (PST)
Message-ID: <6afea68a-4a44-4647-9125-fc5bfd38cd4b@bytedance.com>
Date: Fri, 8 Nov 2024 14:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm: khugepaged: retract_page_tables() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <4c3f4aa29f38c013c4529a43bce846a3edd31523.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez1S3nU0qzf6zZYAOTGO=RmK_2z+ZvHLzrpfamQ4uGK4hg@mail.gmail.com>
 <8c27c1f8-9573-4777-8397-929a15e67f60@bytedance.com>
 <CAG48ez18QoQdJqBXo0FW9qw5CkTUFqKD8iZ195sFud0GPCRywQ@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez18QoQdJqBXo0FW9qw5CkTUFqKD8iZ195sFud0GPCRywQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/8 01:57, Jann Horn wrote:
> On Thu, Nov 7, 2024 at 8:54 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2024/11/7 05:48, Jann Horn wrote:
>>> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>> In retract_page_tables(), we may modify the pmd entry after acquiring the
>>>> pml and ptl, so we should also check whether the pmd entry is stable.
>>>
>>> Why does taking the PMD lock not guarantee that the PMD entry is stable?
>>
>> Because the pmd entry may have changed before taking the pmd lock, so we
>> need to recheck it after taking the pmd or pte lock.
> 
> You mean it could have changed from the value we obtained from
> find_pmd_or_thp_or_none(mm, addr, &pmd)? I don't think that matters
> though.
> 
>>>> Using pte_offset_map_rw_nolock() + pmd_same() to do it, and then we can
>>>> also remove the calling of the pte_lockptr().
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    mm/khugepaged.c | 17 ++++++++++++++++-
>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 6f8d46d107b4b..6d76dde64f5fb 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>>>>                   spinlock_t *pml;
>>>>                   spinlock_t *ptl;
>>>>                   bool skipped_uffd = false;
>>>> +               pte_t *pte;
>>>>
>>>>                   /*
>>>>                    * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
>>>> @@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>>>>                                           addr, addr + HPAGE_PMD_SIZE);
>>>>                   mmu_notifier_invalidate_range_start(&range);
>>>>
>>>> +               pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
>>>> +               if (!pte) {
>>>> +                       mmu_notifier_invalidate_range_end(&range);
>>>> +                       continue;
>>>> +               }
>>>> +
>>>>                   pml = pmd_lock(mm, pmd);
>>>
>>> I don't understand why you're mapping the page table before locking
>>> the PMD. Doesn't that just mean we need more error checking
>>> afterwards?
>>
>> The main purpose is to obtain the pmdval. If we don't use
>> pte_offset_map_rw_nolock, we should pay attention to recheck pmd entry
>> before pte_lockptr(), like this:
>>
>> pmdval = pmdp_get_lockless(pmd);
>> pmd_lock
>> recheck pmdval
>> pte_lockptr(mm, pmd)
>>
>> Otherwise, it may cause the system to crash. Consider the following
>> situation:
>>
>>       CPU 0              CPU 1
>>
>> zap_pte_range
>> --> clear pmd entry
>>       free pte page (by RCU)
>>
>>                         retract_page_tables
>>                         --> pmd_lock
>>                             pte_lockptr(mm, pmd)  <-- BOOM!!
>>
>> So maybe calling pte_offset_map_rw_nolock() is more convenient.
> 
> How about refactoring find_pmd_or_thp_or_none() like this, by moving
> the checks of the PMD entry value into a separate helper:
> 
> 
> 
> -static int find_pmd_or_thp_or_none(struct mm_struct *mm,
> -                                  unsigned long address,
> -                                  pmd_t **pmd)
> +static int check_pmd_state(pmd_t *pmd)
>   {
> -       pmd_t pmde;
> +       pmd_t pmde = pmdp_get_lockless(*pmd);
> 
> -       *pmd = mm_find_pmd(mm, address);
> -       if (!*pmd)
> -               return SCAN_PMD_NULL;
> -
> -       pmde = pmdp_get_lockless(*pmd);
>          if (pmd_none(pmde))
>                  return SCAN_PMD_NONE;
>          if (!pmd_present(pmde))
>                  return SCAN_PMD_NULL;
>          if (pmd_trans_huge(pmde))
>                  return SCAN_PMD_MAPPED;
>          if (pmd_devmap(pmde))
>                  return SCAN_PMD_NULL;
>          if (pmd_bad(pmde))
>                  return SCAN_PMD_NULL;
>          return SCAN_SUCCEED;
>   }
> 
> +static int find_pmd_or_thp_or_none(struct mm_struct *mm,
> +                                  unsigned long address,
> +                                  pmd_t **pmd)
> +{
> +
> +       *pmd = mm_find_pmd(mm, address);
> +       if (!*pmd)
> +               return SCAN_PMD_NULL;
> +       return check_pmd_state(*pmd);
> +}
> +
> 
> 
> And simplifying retract_page_tables() a little bit like this:
> 
> 
>          i_mmap_lock_read(mapping);
>          vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>                  struct mmu_notifier_range range;
>                  struct mm_struct *mm;
>                  unsigned long addr;
>                  pmd_t *pmd, pgt_pmd;
>                  spinlock_t *pml;
>                  spinlock_t *ptl;
> -               bool skipped_uffd = false;
> +               bool success = false;
> 
>                  /*
>                   * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
>                   * got written to. These VMAs are likely not worth removing
>                   * page tables from, as PMD-mapping is likely to be split later.
>                   */
>                  if (READ_ONCE(vma->anon_vma))
>                          continue;
> 
>                  addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> @@ -1763,34 +1767,34 @@ static void retract_page_tables(struct
> address_space *mapping, pgoff_t pgoff)
> 
>                  /*
>                   * Huge page lock is still held, so normally the page table
>                   * must remain empty; and we have already skipped anon_vma
>                   * and userfaultfd_wp() vmas.  But since the mmap_lock is not
>                   * held, it is still possible for a racing userfaultfd_ioctl()
>                   * to have inserted ptes or markers.  Now that we hold ptlock,
>                   * repeating the anon_vma check protects from one category,
>                   * and repeating the userfaultfd_wp() check from another.
>                   */
> -               if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
> -                       skipped_uffd = true;
> -               } else {
> +               if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
>                          pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>                          pmdp_get_lockless_sync();
> +                       success = true;
>                  }
> 
>                  if (ptl != pml)
>                          spin_unlock(ptl);
> +drop_pml:
>                  spin_unlock(pml);
> 
>                  mmu_notifier_invalidate_range_end(&range);
> 
> -               if (!skipped_uffd) {
> +               if (success) {
>                          mm_dec_nr_ptes(mm);
>                          page_table_check_pte_clear_range(mm, addr, pgt_pmd);
>                          pte_free_defer(mm, pmd_pgtable(pgt_pmd));
>                  }
>          }
>          i_mmap_unlock_read(mapping);
> 
> 
> And then instead of your patch, I think you can just do this?

Ah, this does look much better! Will change to this in the next version.

Thanks!

> 
> 
> @@ -1754,20 +1754,22 @@ static void retract_page_tables(struct
> address_space *mapping, pgoff_t pgoff)
>                   */
>                  if (userfaultfd_wp(vma))
>                          continue;
> 
>                  /* PTEs were notified when unmapped; but now for the PMD? */
>                  mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
>                                          addr, addr + HPAGE_PMD_SIZE);
>                  mmu_notifier_invalidate_range_start(&range);
> 
>                  pml = pmd_lock(mm, pmd);
> +               if (check_pmd_state(mm, addr, pmd) != SCAN_SUCCEED)
> +                       goto drop_pml;
>                  ptl = pte_lockptr(mm, pmd);
>                  if (ptl != pml)
>                          spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> 
>                  /*
>                   * Huge page lock is still held, so normally the page table
>                   * must remain empty; and we have already skipped anon_vma
>                   * and userfaultfd_wp() vmas.  But since the mmap_lock is not
>                   * held, it is still possible for a racing userfaultfd_ioctl()
>                   * to have inserted ptes or markers.  Now that we hold ptlock,

