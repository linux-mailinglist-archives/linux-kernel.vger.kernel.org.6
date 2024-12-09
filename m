Return-Path: <linux-kernel+bounces-437057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B879E8E90
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A3218868CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DC215F41;
	Mon,  9 Dec 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X7XraYF1"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F21EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736032; cv=none; b=Wa02xJOsOA/Y5NmI7D01JRnuEYm2egeKYUIiAUg2Vut26STijOKyc8wZJdXWtoQSRhFB2sXhWN4RNrkHvZQ5KPN7IkvvLYi9RINGg9SBbIJ+CYNGCZGzXzZUYMej4en/BMY+syZLZQJ7KaGKTHal4V16qzwoBGsypvaHNSOlau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736032; c=relaxed/simple;
	bh=9udjy35/zSZeMmfSqWPv+kcOPBfpDBlTCkboXck7YWU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cv/qOzIHELVmP6LPGcS+yu8v5U3folhEG+CEdvISanLR1Fd5Wj7PgcJvebI3d+LlCipGA8KjYPHIreV7pG6JxTybfPzN6+xD6odo3HLszM/9H8D2GRV/AV9c8Me8GQ5GMcGUuggonnweKEZo4JX2DBi6kPq9GtCk4nswMqhbK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X7XraYF1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ad59ad72so2750892b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733736029; x=1734340829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Coh2zmmNmuTEsqin3Jv9vo298M32EsWvVV+XXNrQur4=;
        b=X7XraYF1/CX5LhkUfyntkW61wJBfacdP/06mWHMknVwrsbld+OMe543hxtM1B2t0sx
         zlZgaSd+HCLwlS2BgO/NayWnasLa5gDvptC44ByFkEaCazEwQrwDFaqW04NcMDWpbOG4
         5nIZxrZ2KMSCACg7HrsFu5D8w5S37WS70q+bZkqAMIKlYsqIwk/8aHANHVcmfvwXrqA9
         05Fxs4jup2fPqivJl+vaTtQGi5j63xIvnDtJ8ayRgF0T1JDBwlCuyJwJlYeXbehm+f5H
         TXm+xujV8+34M7tKox6F/1dHK2ZAnUTmcDVbHrHmcLKiXtiPAL/+Zfd9iV/7CyN76nsV
         Ebsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733736029; x=1734340829;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Coh2zmmNmuTEsqin3Jv9vo298M32EsWvVV+XXNrQur4=;
        b=ngm2T+MKQycA3yM8Ro12+cS+UZZoUaLI/GBwc89nTSKRxv6+KrTBpA9L9iCeTBUqOX
         raZrkLnUmOTYXX06hOA3+fwYSreQ5kxc+jzilka9U4Zka9O1+re5bVnWPlxYlQJ4jyJv
         bh/kO26jvM5TobnKpcY6vfn6xblL1xxFvao15lxRHxYHayrUMMPs8zCmNIK5Wr4lHym7
         gS8G413XnnqCEojfAxF/h6u/pwBJhc8DqioRAV9ooLMroJI/k6QEFPTTIIhHxwmNhpcK
         da+xV6fA1eZP4i4bSDsX5P07MRfuaDR06xsSA7nxbidWzBaboTU1NBuXXzCvIMUl9ZnB
         G3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVG5YzAkgjFM0TVkHMNRi9DmQzZCjav7QgY62PrBt73z63oyam4vtt9ufT9nxnT28Je3lKBw6WxNAsL2PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80XQIG3AbGzls9LjHr74QVDzTPV2AX8DUqC+AqyUZKH9Zhxqe
	3/1CdGMlN2HmbJcEku3UFkUcmicgoGjAFUlNpDc/+Pcj8aXD9BN1og52K5g+B+w=
X-Gm-Gg: ASbGncv6+hhmxBBtc7bRQTfEo9g4FODVsZKG7/u9zfBzH/f49RhcFLpANaZ5tHAzAbD
	vcZurp0wm/dM1zy1WHXGig6vzp/t/w8xyftcj8esnTIINkKBEnQ9QJx/zA6RJIirRhfPXTfJHbD
	QjAdjBrHbjmY1vFdG6Shm2GaUsBWj45v8ccYABdA64fVnSoHLZ0o4kx+MsK86A+3uQkdE/jQHFz
	n6i4Y54mwZ1wqwOaeGjeRI3AwxwDr7WMquzhWiD56NqHtkJXcTziXM+c97E2vDzwU/779dxTA==
X-Google-Smtp-Source: AGHT+IF0IduZ3YsQekgl0rzDs+wSloR1nEW2/DCb/MYGN5EuKg7ZHg9EKZY8ow/xM7MpHD+O5e2MWA==
X-Received: by 2002:a05:6a00:802:b0:71e:7174:3ae with SMTP id d2e1a72fcca58-725b8125b44mr18627507b3a.11.1733736028964;
        Mon, 09 Dec 2024 01:20:28 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3dd4cbasm3669620b3a.142.2024.12.09.01.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:20:28 -0800 (PST)
Message-ID: <8dbb0f16-6e35-4c26-a63b-29b65c819fea@bytedance.com>
Date: Mon, 9 Dec 2024 17:20:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Yu Zhao <yuzhao@google.com>
Cc: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>,
 David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
 Hugh Dickins <hughd@google.com>, Muchun Song <muchun.song@linux.dev>,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
References: <67548279.050a0220.a30f1.015b.GAE@google.com>
 <51849c40-1bd5-49bb-ba2f-15cd06f45f48@bytedance.com>
 <c3379af4-cfc3-41e8-89fb-1ad5292d952a@bytedance.com>
 <CAOUHufZDYmU8cQrwfvVnV3HUrH4aOULniNXvvQVHLsHUjhouAQ@mail.gmail.com>
 <70f78ae0-481f-4096-af82-fe5a9f131eb3@bytedance.com>
In-Reply-To: <70f78ae0-481f-4096-af82-fe5a9f131eb3@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/9 16:09, Qi Zheng wrote:
> 
> 
> On 2024/12/9 15:56, Yu Zhao wrote:
>> On Mon, Dec 9, 2024 at 12:00 AM Qi Zheng <zhengqi.arch@bytedance.com> 
>> wrote:
> 
> [...]
> 
>>>>>
>>>>> If you want syzbot to run the reproducer, reply with:
>>>>> #syz test: git://repo/address.git branch-or-commit-hash
>>>>> If you attach or paste a git patch, syzbot will apply it before 
>>>>> testing.
>>>
>>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>>> mm-unstable
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 83fd35c034d7a..28526a4205d1b 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -7023,7 +7023,7 @@ static struct kmem_cache *page_ptl_cachep;
>>>    void __init ptlock_cache_init(void)
>>>    {
>>>           page_ptl_cachep = kmem_cache_create("page->ptl",
>>> sizeof(spinlock_t), 0,
>>> -                       SLAB_PANIC, NULL);
>>> +                       SLAB_PANIC|SLAB_TYPESAFE_BY_RCU, NULL);
>>
>> Note that `SLAB_TYPESAFE_BY_RCU` works by freeing the entire slab (the
>> page containing the objects) with RCU, not individual objects.
>>
>> So I don't think this would work. A PTL object can be re-allocated to
>> someone else, and that new user can re-initialize it. So trying to
>> concurrently lock it under RCU read lock would also be use-after-free.
>>
> 
> Got it. Thanks for pointing this out! So we should put ptlock_free()
> into the RCU callback instead of enabling SLAB_TYPESAFE_BY_RCU for
> page_ptl_cachep.

Like the following:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 95bfaf5b85d90..b532415ef5841 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2988,7 +2988,7 @@ void ptlock_free(struct ptdesc *ptdesc);

  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
  {
-       return ptdesc->ptl;
+       return &(ptdesc->ptl->ptl);
  }
  #else /* ALLOC_SPLIT_PTLOCKS */
  static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d0e720ccecd71..7b94ea4d0d26a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,6 +434,13 @@ FOLIO_MATCH(flags, _flags_2a);
  FOLIO_MATCH(compound_head, _head_2a);
  #undef FOLIO_MATCH

+#if ALLOC_SPLIT_PTLOCKS
+struct pt_lock {
+       spinlock_t ptl;
+       struct rcu_head rcu;
+};
+#endif
+
  /**
   * struct ptdesc -    Memory descriptor for page tables.
   * @__page_flags:     Same as page flags. Powerpc only.
@@ -478,7 +485,7 @@ struct ptdesc {
         union {
                 unsigned long _pt_pad_2;
  #if ALLOC_SPLIT_PTLOCKS
-               spinlock_t *ptl;
+               struct pt_lock *ptl;
  #else
                 spinlock_t ptl;
  #endif
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index a82aa80c0ba46..774ef2a128104 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -17,7 +17,8 @@
  #include <asm/tlbbatch.h>
  #endif

-#define ALLOC_SPLIT_PTLOCKS    (SPINLOCK_SIZE > BITS_PER_LONG/8)
+/*#define ALLOC_SPLIT_PTLOCKS  (SPINLOCK_SIZE > BITS_PER_LONG/8)*/
+#define ALLOC_SPLIT_PTLOCKS 1

  /*
   * When updating this, please also update struct resident_page_types[] in
diff --git a/mm/memory.c b/mm/memory.c
index 83fd35c034d7a..802dae0602b32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7022,24 +7022,34 @@ static struct kmem_cache *page_ptl_cachep;

  void __init ptlock_cache_init(void)
  {
-       page_ptl_cachep = kmem_cache_create("page->ptl", 
sizeof(spinlock_t), 0,
+       page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct 
pt_lock), 0,
                         SLAB_PANIC, NULL);
  }

  bool ptlock_alloc(struct ptdesc *ptdesc)
  {
-       spinlock_t *ptl;
+       struct pt_lock *pt_lock;

-       ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-       if (!ptl)
+       pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+       if (!pt_lock)
                 return false;
-       ptdesc->ptl = ptl;
+       ptdesc->ptl = pt_lock;
         return true;
  }

+static void ptlock_free_rcu(struct rcu_head *head)
+{
+       struct pt_lock *pt_lock;
+
+       pt_lock = container_of(head, struct pt_lock, rcu);
+       kmem_cache_free(page_ptl_cachep, pt_lock);
+}
+
  void ptlock_free(struct ptdesc *ptdesc)
  {
-       kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
+       struct pt_lock *pt_lock = ptdesc->ptl;
+
+       call_rcu(&pt_lock->rcu, ptlock_free_rcu);
  }
  #endif

> 
>>>

