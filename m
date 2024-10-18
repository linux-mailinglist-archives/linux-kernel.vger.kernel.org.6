Return-Path: <linux-kernel+bounces-370821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FB9A3279
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087F51C225E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CA5464B;
	Fri, 18 Oct 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dg9BNFHl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC120E325
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217737; cv=none; b=Ik/RqsyuZESu45ooAS2qLIoG96iZjXgc8bAqFZVFTSF4cl+46n6ejLumtUSUFaFFclI/jcyJU9kBu85i1byeO32B87tsoEplwY6KGMJDTfvDNv1ZiyBLxECs6BQb0llRMHrUAp+TsKFRxhqQTt9+rFykozQgPtn7nsveMsrOWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217737; c=relaxed/simple;
	bh=ReVZMbdwnvonUHNeG9Yvp1gOYbz/brP+kdWAqtmp+So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjazYSL+Z66wDo9fcepfKSFkfG4klrLJOXk5DFns7arAWyvFf2OGpOpb5XvZiTFzOlcTfu9yCim6acNi5hFsIwBzSnIYLs3XS0VR30EqBgbKmKW2drPmWqB+wuBo4mBdmEQfi0aD1x+aiNf1x9e87OpimJxy1OXRo99LUtxDOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dg9BNFHl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c7edf2872so21225455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729217735; x=1729822535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7KhozhjaWb7js4Xtt8+AshRxmmt9OeRn0KLTlJgiVY=;
        b=Dg9BNFHlQXE10dGwbdu+DgnJIhEvsqjQIh0CLovdbJKq1WAnRoOhXhe0XdyLFuTLoJ
         xs2sZYfR3fAf0zfTudX6Jawm+Eey2uGpq/WW0VAgPSsX9J/h39TNh34+MDZemINIDLlv
         5iUGwvSmrJNXKJhdSehLuX+U2S9dREtCTXEbFwFre+Qg+FPOKN4WwATYvJpYvJVrnPGG
         jJORY7PWvdoez6XAV80KA1ijpWSvkA646FI4PJwP04WpgdNjDpFLlNX7sTJvMvEd+rIs
         tj07WZOrNLhhPmrsv/CmRYxGd3Kk8mCUAOjoGglI2NOvvQ9jzi9GNmQZEdliprjuzjBA
         TvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729217735; x=1729822535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7KhozhjaWb7js4Xtt8+AshRxmmt9OeRn0KLTlJgiVY=;
        b=kSLIpCka5Pdg2y/rCoCRgUyYCJ7Ozq5cC4I7KeFuq/GXy1ElHWZr029N5Q4CecJl1l
         T0aCM9ihNjyyC3a8cBC7fM+pvvAMLbcXKDceVaLXmGx6CXlw1ViY7LsR0atGBHPYxDXa
         j1BlNYH/Hoq7x5aYo1H+4ybB+UeC+mbzirpwR2azMiEyVg+TzyPgYX7qBDCEFL+QzMxI
         hOPzxsB7gFxIQfZVyZV+H8voKGuIc6Bi1ClR71S3F8M9S7kQWskVRd5um9YManUAkirw
         aKC2POEzHeUsWURRHem+8WRYGVfkgabBY1WQecVfUI1oe4PGWH3f5svEtoLTbHNAq2YQ
         A26A==
X-Forwarded-Encrypted: i=1; AJvYcCWpUI7svH0jfzbM/rcc4v4eoy95F0afqxVpORLGlpdQ6EMw8DJl+z2+OZ9l3xN72bmNdPr6QvhN9bhBmI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeMDIUtmsk93Z3GlLLtNDSzoVCA7YhYtDzTDyU7hfbjedNdeI
	/+tiBBAWJTHFmfV+MHIy+OCccYpWNEK7JrC18JVtOcPuy0OlLu4L1RUffNGp0+g=
X-Google-Smtp-Source: AGHT+IHpcewVlhukOGgBQOKmFzU6YT8su3lwe43Fb0SlS1dYk4+rLzWwY+qeIRFQyXBGdSGv5yYIWg==
X-Received: by 2002:a17:90b:1e42:b0:2e2:b94c:d6a2 with SMTP id 98e67ed59e1d1-2e56391a323mr1282716a91.0.1729217734982;
        Thu, 17 Oct 2024 19:15:34 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da7b3bbsm627783a91.56.2024.10.17.19.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 19:15:34 -0700 (PDT)
Message-ID: <e59f6f47-4a19-4726-a3ab-c13ada04d723@bytedance.com>
Date: Fri, 18 Oct 2024 10:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] mm: khugepaged: retract_page_tables() use
 pte_offset_map_lock()
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <258de4356bdcc01bce0ff1f6c29b2b64a4211494.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez2yPVjpPoAPmitrdaig-dF7j9THN=CZd6QD7to=tF2=NQ@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez2yPVjpPoAPmitrdaig-dF7j9THN=CZd6QD7to=tF2=NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/18 02:00, Jann Horn wrote:
> On Thu, Oct 17, 2024 at 11:47 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> In retract_page_tables(), we may modify the pmd entry after acquiring the
>> pml and ptl, so we should also check whether the pmd entry is stable.
>> Using pte_offset_map_lock() to do it, and then we can also remove the
>> calling of the pte_lockptr().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/khugepaged.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 94feb85ce996c..b4f49d323c8d9 100644
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
>> @@ -1757,9 +1758,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>>                  mmu_notifier_invalidate_range_start(&range);
>>
>>                  pml = pmd_lock(mm, pmd);
>> -               ptl = pte_lockptr(mm, pmd);
>> +               pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> 
> This takes the lock "ptl" on the success path...
> 
>> +               if (!pte) {
>> +                       spin_unlock(pml);
>> +                       mmu_notifier_invalidate_range_end(&range);
>> +                       continue;
>> +               }
>>                  if (ptl != pml)
>>                          spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> 
> ... and this takes the same lock again, right? I think this will

Oh my god, my mistake, I used pte_offset_map_rw_nolock() at first, then
I changed it to pte_offset_map_lock() but forgot to delete this, and
because my test did not trigger retract_page_tables(), so I did not
find this error.

Will change in v2.

Thanks!

> deadlock on kernels with CONFIG_SPLIT_PTE_PTLOCKS=y. Did you test this
> on a machine with less than 4 CPU cores, or something like that? Or am
> I missing something?

