Return-Path: <linux-kernel+bounces-399475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC259BFF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717E61C21628
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A619AA5A;
	Thu,  7 Nov 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jTDHOg3c"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA817DE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966097; cv=none; b=SN5w0G9vcowSjIwegq0LeXQbxpwwoLATPo07boI3UF6nSI8bdH+5scffcZLZrZAnmBLPeL63rYMWsWPeuKgs0t1ZTsQP1nhlWXYAR27xLbIf0zQInOh0nmacL2pVD/PJpi92Vh8/FAijTz6cD6o4J0lCAVCd+bQ9272Ly1oMYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966097; c=relaxed/simple;
	bh=eyp3Ila9PkWeprxHUv9raKyERKun2fZ4SfdmnUcSAIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/X8gvTE3gSODlQaSZ8cuyzqj+7M2kTOGzMSLEXWPScX9vLY6s1xBjdQBbPGXG08pkxXVfKKAqL9uEg5iohumzvO4554m2Uota98t8G7GVW9s4/1aQpHvg6kfvwj2d7oWVC3zuTkLwCOCQcsTZ9ct/GgzOI0j14F1OLq0pB9LDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jTDHOg3c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca1b6a80aso7628665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730966095; x=1731570895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuiVOdCzD8MGwxjYTAfGUY1kmdjFbYxSBTn1qFARbjk=;
        b=jTDHOg3c2J9AP/Va03aQDjBdjmSiOWDp44JTqFtH60tHT5a6l0Kbd+BVdB2fcQQdUB
         kin/qhCeUsweD7tYSlAHmHzhsmYqEKyYyCx6usMD6PSuVV1iujV+YuGQaaKNDbAjvmf2
         NE4KHr/62jFLsmj8uFVYdfGAPVifEp2d9oynxYzIqPWd2I/smZEguL/CYU7GOyQqeLQS
         L6CDvatGq9opDJVIKQ1tqWPMOdcEaad8nY2b/7k7Eu+JDef5Q3nu3ZC8MxPNIAaakigV
         Py53d1L6L80rXvlOjq/UMj+bM7uU66PF9x6BL4UKUts0XXMn7fMnYuO9moP/fxjQ+xnC
         s9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966095; x=1731570895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuiVOdCzD8MGwxjYTAfGUY1kmdjFbYxSBTn1qFARbjk=;
        b=Rt8tN/eIr3RVCygAHuaNB4J7avz/H803NvMgwEsMTJyPAx/U67GmaPo85c8o9mFzuz
         3s4k1ZqJ90PKW7GGw38eVcSkGMSfV8uYy/nYlDDbk5pV5wDonMXGtnYTWSNh9jYy93q6
         seM3XKCl/sl+S4UpD0jFh85Fk+idvxnPivS52LrKzLgKno+gUEs74rzFM2yhbNrQBws4
         7+ZCm3ghnA3vOsuaY6DT4zIqg0DGBuiKh48pVGFeQmQMEk7FT/vYKlLpO1YggsoJ8Nlm
         LblOcSH0WpGuYyTx4ABc+1rXctUgrKdk8kcp9xMbKtH3hK+cV2KwdLj8ohPUf16ywhlr
         FH6g==
X-Forwarded-Encrypted: i=1; AJvYcCWg8B0BRpEV82OTFSEqiLb4UCWsWdD2jjdosMDJ8TzRGd+bl14ZUZ4XX/cKd9v9p54ovvSV355CsnK1E14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtygrWfSYCZE6I7Mw0YuNwQVCRGmy+K4UEBNeKtgumvO0pY4HJ
	8YKAdRkkSxocuAG61ufcTGurkS53lBQ1MudXcbozP/RqaqWZO9q4v5tJd0AkQVg=
X-Google-Smtp-Source: AGHT+IEDCJ0LwE6wTKixD1rDG+hhGWKgZxlUEHyzcCQxACaZidAI+oJODjzm9sVFhmu3GH0AGRU0lA==
X-Received: by 2002:a17:902:e805:b0:202:cbf:2d6f with SMTP id d9443c01a7336-2111b0181b5mr305660305ad.57.1730966094743;
        Wed, 06 Nov 2024 23:54:54 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e87537sm6333055ad.270.2024.11.06.23.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 23:54:54 -0800 (PST)
Message-ID: <8c27c1f8-9573-4777-8397-929a15e67f60@bytedance.com>
Date: Thu, 7 Nov 2024 15:54:47 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez1S3nU0qzf6zZYAOTGO=RmK_2z+ZvHLzrpfamQ4uGK4hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jann,

On 2024/11/7 05:48, Jann Horn wrote:
> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> In retract_page_tables(), we may modify the pmd entry after acquiring the
>> pml and ptl, so we should also check whether the pmd entry is stable.
> 
> Why does taking the PMD lock not guarantee that the PMD entry is stable?

Because the pmd entry may have changed before taking the pmd lock, so we
need to recheck it after taking the pmd or pte lock.

> 
>> Using pte_offset_map_rw_nolock() + pmd_same() to do it, and then we can
>> also remove the calling of the pte_lockptr().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/khugepaged.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 6f8d46d107b4b..6d76dde64f5fb 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>>                  spinlock_t *pml;
>>                  spinlock_t *ptl;
>>                  bool skipped_uffd = false;
>> +               pte_t *pte;
>>
>>                  /*
>>                   * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
>> @@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>>                                          addr, addr + HPAGE_PMD_SIZE);
>>                  mmu_notifier_invalidate_range_start(&range);
>>
>> +               pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
>> +               if (!pte) {
>> +                       mmu_notifier_invalidate_range_end(&range);
>> +                       continue;
>> +               }
>> +
>>                  pml = pmd_lock(mm, pmd);
> 
> I don't understand why you're mapping the page table before locking
> the PMD. Doesn't that just mean we need more error checking
> afterwards?

The main purpose is to obtain the pmdval. If we don't use
pte_offset_map_rw_nolock, we should pay attention to recheck pmd entry
before pte_lockptr(), like this:

pmdval = pmdp_get_lockless(pmd);
pmd_lock
recheck pmdval
pte_lockptr(mm, pmd)

Otherwise, it may cause the system to crash. Consider the following
situation:

     CPU 0              CPU 1

zap_pte_range
--> clear pmd entry
     free pte page (by RCU)

                       retract_page_tables
                       --> pmd_lock
                           pte_lockptr(mm, pmd)  <-- BOOM!!

So maybe calling pte_offset_map_rw_nolock() is more convenient.

Thanks,
Qi


> 
> 
>> -               ptl = pte_lockptr(mm, pmd);
>>                  if (ptl != pml)
>>                          spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>
>> +               if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>> +                       pte_unmap_unlock(pte, ptl);
>> +                       if (ptl != pml)
>> +                               spin_unlock(pml);
>> +                       mmu_notifier_invalidate_range_end(&range);
>> +                       continue;
>> +               }
>> +               pte_unmap(pte);
>> +
>>                  /*
>>                   * Huge page lock is still held, so normally the page table
>>                   * must remain empty; and we have already skipped anon_vma
>> --
>> 2.20.1
>>

