Return-Path: <linux-kernel+bounces-308138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FF9657C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EFD1C221D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3646152E17;
	Fri, 30 Aug 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gezECcUO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27181D131D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000162; cv=none; b=Vnc5pMUapI+zikA006zC7Pbnn+bZtG/qy0Nbg6IjKNpPDMr3bEVkL7gmHRah1NZ/XPQtRbkePaQzzs4LVyybEOGn64Dd6b2Xhe/8OVZY4a/JjIX26E5LH/9AyD+Y9uOhUfyHnnD4uuzjaCbaB9Dq84CSNHmZByj/vkJfTZEpRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000162; c=relaxed/simple;
	bh=kMWDAFpnhfBdSn1lDdTSrwwTlwPF96pFdHk5uMwJhgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLdjaIj6lLVRJDwtOGTJgwRzphH3mWZtesgcnipGqW7z84qWaXV2SP8FOuv/6lnIs6atTGWQhAHvho/wwnCBnGYA4V2/B1ws97IkaTXxhygyt7dCCoY4J/o6340pVhGDReOFwIlrPZ6z7930ltcLMYa0dCrKrsoz4WdnbQYV1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gezECcUO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fba05363so13096135ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725000160; x=1725604960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAPIQ+0oTzbZ3F2sniQtCFwQ1sSVebQi1669/F3+Skk=;
        b=gezECcUOq8iTSWW1F0OaX6J4aEsIO5wehQDoHeYXRgDEXbXXSBzrYJZVKxZuu3+iFP
         HH6nM8510j6s0k6fIou3+1UnwxpOWGrVZmqk2CrBclYcIVxNK8MlenKjciWTawASudBT
         0bwL2JMjlIJabyU9NwLc2Wnb4x3sWCwUEp5u4uyd2gEXyjydLKMmhaskPwpPuOsJxjrQ
         Zh6hznzJt/TJAStm99wdNCnAfqGS1DdfaiOvFwgvc4OHAcuHheipxvPtsBhdgEHkKbUN
         NzrpA0HHVZd4/65dvylmd6suJORQ/2QPViBNXGuxCHT6SlX+bPy9Zd66HVacOdCrpAvy
         SwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000160; x=1725604960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAPIQ+0oTzbZ3F2sniQtCFwQ1sSVebQi1669/F3+Skk=;
        b=T3dgGnzGwj/cHiuKHbrXetJcJrdEz4xoYfDY2eKC8Q6MHJJFHKBz+N8mggv+OAZlj9
         SE78jgyAwcEM/uzGDAgdxHMU+0PfSOTp3UOI1pGJ+ZcuZyLO5g+R0jw2S5ma/ohwMXjP
         /hmWanCNQ2Y+Ju5zhuBmulPc+zqPZXbQf7M5Kr8vypLj8nBId62ku2x7dFxqC+Ot0cA5
         QWjKVbPxOrcP9ZtEWW9iGouJdsnqHqIfqy2zVJRJELTRwL5XGBN0D+1yqNSowuJmtZgy
         jBuNK3pQ6KpYiGRtXvZh4uBoWsHbT+tb0t6UMz2XmqmTaPBGhO6syPTgxLSS11I1t+vQ
         7TUw==
X-Forwarded-Encrypted: i=1; AJvYcCWiNKcVupk9Szk8r7b1cpM9jhEAsm/1Hlki91lnhqpUh/Ww8m4s81Lkv9M1zRkB9N3YIPg/+YkUDs4/zOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/LobY0zioat8yJejSXEsiQeTp4NLXmJZBmiF3e5Tg/1y3Zpd
	6iofOA62rDioVedNs57ei37pOJbAQgo9GAA84a4xGRG51cIUS7MYShBsY/y97YI=
X-Google-Smtp-Source: AGHT+IFX6MWdATn3PHJECm84KknThK0jKPALrJmyAm2CUCVW6pc6Pf0GS8/g/1o4RkhLk/GIua405Q==
X-Received: by 2002:a17:902:da90:b0:1fd:8c25:415d with SMTP id d9443c01a7336-2050c3d2a05mr57644625ad.36.1725000159781;
        Thu, 29 Aug 2024 23:42:39 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b14c4sm20794075ad.46.2024.08.29.23.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 23:42:39 -0700 (PDT)
Message-ID: <fe146c6c-60e6-4ff1-bb93-6c818f71b3de@bytedance.com>
Date: Fri, 30 Aug 2024 14:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <71100c3867c4cf6f5f429ce9f2db8432066d0e99.1724310149.git.zhengqi.arch@bytedance.com>
 <4101a941-6286-4128-a16c-29c7cffcbe8c@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4101a941-6286-4128-a16c-29c7cffcbe8c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/29 23:36, David Hildenbrand wrote:
> On 22.08.24 09:13, Qi Zheng wrote:
>> In copy_pte_range(), we may modify the src_pte entry after holding the
>> src_ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
>> already hold the write lock of mmap_lock, there is no need to get pmdval
>> to do pmd_same() check, just pass a dummy variable to it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7b6071a0e21e2..30d98025b2a40 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1083,6 +1083,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, 
>> struct vm_area_struct *src_vma,
>>       struct mm_struct *src_mm = src_vma->vm_mm;
>>       pte_t *orig_src_pte, *orig_dst_pte;
>>       pte_t *src_pte, *dst_pte;
>> +    pmd_t dummy_pmdval;
>>       pte_t ptent;
>>       spinlock_t *src_ptl, *dst_ptl;
>>       int progress, max_nr, ret = 0;
>> @@ -1108,7 +1109,15 @@ copy_pte_range(struct vm_area_struct *dst_vma, 
>> struct vm_area_struct *src_vma,
>>           ret = -ENOMEM;
>>           goto out;
>>       }
>> -    src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
>> +
>> +    /*
>> +     * Use the maywrite version to indicate that dst_pte will be 
>> modified,
>> +     * but since we already hold the write lock of mmap_lock, there 
>> is no
>> +     * need to get pmdval to do pmd_same() check, just pass a dummy 
>> variable
>> +     * to it.
> 
> As we hold the mmap lock write lock, I assume it will prevent any page 
> table removal, because they need *at least* the mmap lock in read mode, 
> right?

Except for retract_page_tables(), all others hold the read lock of
mmap_lock.

> 
> We should probably document the rules for removing a page table -- which 
> locks must be held in which mode (if not already done).

Agree, I will document it in the v3.

> 

