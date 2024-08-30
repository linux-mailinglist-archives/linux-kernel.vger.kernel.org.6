Return-Path: <linux-kernel+bounces-308136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852B9657BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4BF1C2263F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E805150984;
	Fri, 30 Aug 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JcHpxzQe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F971D131D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999876; cv=none; b=nmlRqEsFMObslYJZ4Qgi3biG66ZxdBtsLWmXRnDDXqfgcvzbNsHn8zSdFD4CHle0J1fNTCHLOTCmlvyiGN8G8o3rW4gkr5krBcqQM10nRsV9HXlLa/wu3SA11kKUKuHDTuxmYspUAF7bAkeMhEeB9Tkk+uv60o21Hfv7bSalCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999876; c=relaxed/simple;
	bh=sml/tDtRTWUef59/JNhbEDmnAWZaBT69UuRp7I9Tb3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZyTj7wkP96VEeFd0g6gT7Qm8JSpvSIIk0vT8hSEXDNgKqxQnV0JpDf8BIAx2TYHXSOyjVdwZWPpB127XAIXAUVFDZ0qPR/AbUeoBK4PB12udMs+u9qUplKjZkX0sgHJBGLxFdQnMsAc2B4CAv9sJc5JuiSjo27AeNHm7OuBC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JcHpxzQe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fae21398so10629055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724999874; x=1725604674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Bon54RF1R2NVypdRmo7ECOWifc7jarfkosYQe9jtxo=;
        b=JcHpxzQez3RrkMDSoAa8b7PUqHxV3FdTRO7nz6BSsDkDUtHTKVSvIWpM+aHjZIzfzj
         7Dwj369sxlCjVQJGSkm+vSv+mXFdPXf73zwZR+QV7mBoXc/+I/YGwbYK5C6mfvKwMHqv
         XnZuKZAJvvVaCbTaRSlPJJ62Q2TyKnOXn7QNkXMu/UcIfmk8nv6KOt5igWd/4PB7nTKp
         lSwiPRaH6kqzfRhUl02cB5VF5sqsDCjFyNsAv5qSurGrKmMQCSvUqbTUg6oyNQbU1bcU
         Y+S9ePYhisq+b3TQ7TXPVmHlXupclKnHkeWmAs0W6qg9iYKw+klb6esd73JfXdULN3bi
         N7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724999874; x=1725604674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bon54RF1R2NVypdRmo7ECOWifc7jarfkosYQe9jtxo=;
        b=r70GP3SM+qfoOIRnN76S1sr8Mzc00Nai++BRFZ8FZnrUAturp+mZPaNQv88vAzXhM1
         HKyqEm5Mo7IxrZOHDPLYLr7ccNu1prgzuohPD3dWQVau3L4ouVcJaP7KgZwuL2yB+fmY
         HBj7cX6BLHn2hHUzJrs0PDfO7VGFHvSFGCmyVqlu1JVMPHasOb9p5J2peL5kEB5PDy9/
         ctUlPcjdZcJEtU3Tz6nm9vsU+tC8NdwbSh1GNXINPT0WHEb7tFcYjBo1+UGKdKni1Q3F
         ykU9x5zmuCWlqO195BLJL+iU6C91xnQGuLqciDsDOZw0QtyVFd04qPsbUncawIBfLv+i
         IxpA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1a6BjT89/swg8eRWga8hy3SI1l/r1O4H1YVSKiynEgRh0yBmNfpK4UAK/3gn4LLdBqDlzOnt32ppDb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+PAEvIhS36N1CFCmX5FcDLS5sYvKb0EsFHY6m7tl3w0A6Mee
	A/W1japHXKTMJQId4okZHsdlov2VpAFKUZF5eA6jSvJNJCIA+r4TDPa+X/nXpDU=
X-Google-Smtp-Source: AGHT+IHyOcbVEmEnId0vqSTOSgNPwIG0EVfd04p/S0G8sj3iEkziTAMfHoZozyVyNkJHSOdGOsiCTQ==
X-Received: by 2002:a17:902:fb86:b0:203:a0ea:62a3 with SMTP id d9443c01a7336-2050c219597mr35192155ad.1.1724999873833;
        Thu, 29 Aug 2024 23:37:53 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515533bd3sm20643165ad.140.2024.08.29.23.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 23:37:53 -0700 (PDT)
Message-ID: <a3986998-1f63-4e8c-94ed-c6d1004bf111@bytedance.com>
Date: Fri, 30 Aug 2024 14:37:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: muchun.song@linux.dev, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
 <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
 <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
 <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
 <63ef0611-50c2-49b5-ba3f-c6ea81f9fbce@bytedance.com>
 <8cbd44d9-f39b-4ee8-b1c1-ba89c12c0e23@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8cbd44d9-f39b-4ee8-b1c1-ba89c12c0e23@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/29 23:31, David Hildenbrand wrote:
> On 29.08.24 12:59, Qi Zheng wrote:
>>
>>
>> On 2024/8/28 18:48, David Hildenbrand wrote:
>>> On 27.08.24 06:33, Qi Zheng wrote:
>>
>> [...]
>>
>>>> sufficient AFAIUK.
>>>
>>> Drop the "AFAIUK" :)
>>>
>>> "For R/O access this is sufficient."
>>>
>>>>
>>>> pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
>>>> pte_offset_map_ro_nolock(); but when successful, it also outputs the
>>>> pdmval. For R/W access, the callers can not accept that the page table
>>>> it sees has been unmapped and is about to get freed. The pmdval can 
>>>> help
>>>> callers to recheck pmd_same() to identify this case once the 
>>>> spinlock is
>>>> taken. For some cases where exclusivity is already guaranteed, such as
>>>> holding the write lock of mmap_lock, or in cases where checking is
>>>> sufficient, such as a !pte_none() pte will be rechecked after the
>>>> spinlock is taken, there is no need to recheck pdmval.
>>>
>>> Right, using pte_same() one can achieve a similar result, assuming that
>>> the freed page table gets all ptes set to pte_none().
>>>
>>> page_table_check_pte_clear_range() before pte_free_defer() in
>>> retract_page_tables/collapse_pte_mapped_thp() sanity checks that I 
>>> think.
>>
>> Since commit 1d65b771bc08, retract_page_tables() only holds the
>> i_mmap_lock_read(mapping) but not mmap_lock, so it seems that
>> holding the write lock of mmap_lock cannot guarantee the stability
>> of the PTE page.
> 
> Guess it depends. khugepaged on anonymous memory will block any page 
> table walkers (like anon THP collapse does) -- per-VMA lock, mmap lock, 
> mapping lock/RMAP lock ... so it *should* be sufficient to hold any of 
> these, right?

retract_page_tables() itself is safe, but because it does not hold the
read lock of mmap_lock, other paths that only hold the write lock of
mmap_lock may be concurrent with it, such as the paths in
[PATCH v2 08/14] and [PATCH v2 09/14].

> 
> So at least for now, these (anonymous memory) cases would be ok. Likely 
> that will change when reclaiming empty page tables.

When reclaiming the empty page tables, I will hold the read lock of 
mmap_lock.

Therefore, either perform a pmd_same() check on the case where the
write lock of mmap_lock is held, or add the read lock of mmap_lock
to retract_page_tables() as well.

> 
>>
>> IIUC, I will also perform a pmd_same() check on the case where the
>> write lock of mmap_lock is held in v3. Or do I miss something?
> 
> Can you spell out the instances where you think it might be required.

For example, the paths in [PATCH v2 08/14] and [PATCH v2 09/14] need
to do pmd_same() check after holding the PTL.

> 

