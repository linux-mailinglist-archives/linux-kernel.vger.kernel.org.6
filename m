Return-Path: <linux-kernel+bounces-367880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE49A07EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A5B242C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0503A207200;
	Wed, 16 Oct 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zfwsi6EC"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD81C07F9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076323; cv=none; b=NPB0SzhsXi15qovOEGu0Wd3/sCbUX674bhvN3qpZZJglHID+CGlohEdp3m0x7X8iRp6z0x166TxWRB42il7Fd+UOC5lKqcmaCZqQ1g616v8D9mb4W/VgA+eFmzc9yZH6h9iSz9BA1z+LERWsA7FwON2GT756Ju7bZrcaxGDuMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076323; c=relaxed/simple;
	bh=GpbVukWHXYkkOdk3d5eNxGPJZDJ1SPrgiM+sBmjQEn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMODv5VtHgVHcFsWFiD3aAhOWEdUVEUNtbBHnwEgW99/cJIlqOTBIJQRyi1tv68+b0xwOgcfVMFY5HFdVzXMQW67u9cIkOndtQWgoMAwRdqEbltzJbPV7RPhd4lRwgsBVd7dugfAYOpOEV00twFOleBJZqnSsyly001L0aZe+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zfwsi6EC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5c8c28797so2885595b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729076320; x=1729681120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4V9uAkOemoBS+UOiRuVxaXC25eKKhe+qrnOqSnxMzh8=;
        b=Zfwsi6ECNlxcPirnX3zU0IIm58A3u/vSf/PRk0QnKV2f5JzcCudgyEy53xof59bQFR
         wzJMEPGX1X2y3Y3ut3jIy6Te1DutfNkHiyAfxXvzEir64MEGXmOTtoZ4sa29zjz0Bohu
         tbSgqBxwg+8MDennWQ5HvezyBnUqSiENQ4HdnGbL7yrfBYAythqlFvTpFdh1KPNHM8O5
         gfYUt777clSGb3+pbMlTHgmTjJljB+S7/xuAOyNI9Z6g69gHFMjLZQ7swT7mCQO83csC
         mQhvEs/7aoKWBnJcxaKEVWYURVe8QCxQC4kMGFcaKyEvXj7OXh4lxdbCaE+HPSJt1vi9
         iBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076320; x=1729681120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4V9uAkOemoBS+UOiRuVxaXC25eKKhe+qrnOqSnxMzh8=;
        b=dWr+JelRSnXDApsgqc4aWysgtC1hVQD4goJFeewKdzD6Z6jDJK0ZLdbwqU5HyYEjDz
         Gck9egbkxuosWLTxVFanOyoPMbKT/Pv0t/y5GYBGsiAT6je5yI1vI1ylnwuGSTMzVD0Y
         josdOKyli8U+yHaYa+gM9GQdQnkcEHb+2pZGv/hyEaUOapUilcst+rj9qNVMBcsTq+Se
         UQ9GpQtrEtCgm1u082jcyHctam51NGz4edoXtH/wT3sEmWe1iVfs/pmL2RM1doLChb+X
         754Ecgfehp8YETs/FoM4svNWEfInXuTQralk8gDtkFu422LloNjJ0lHNEmlRuV5+dFJ8
         VPGw==
X-Gm-Message-State: AOJu0YzH/jBKSAm7VJFqVp+oQ2egna/qI4o8Om1fZZc0FovaXM6T8Sks
	zedFx7dX+RDUNmsZtn00zbZsTXTS5LFOeXOdKtIX4D0sJ7NczVY77m1qHuK4LZk=
X-Google-Smtp-Source: AGHT+IE7gol+mLNQ2oP7eKHsCKiOCW9yBgEJ5GnKroOUWJxwrAQDQs0BVHFEzCeZsiuAQ7+RqmdoCg==
X-Received: by 2002:a05:6808:2e4d:b0:3e5:f7bb:1ce7 with SMTP id 5614622812f47-3e5f7bb1effmr671655b6e.38.1729076319764;
        Wed, 16 Oct 2024 03:58:39 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6bb02dsm3027512a12.4.2024.10.16.03.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 03:58:39 -0700 (PDT)
Message-ID: <c364015e-ab37-411d-b2e9-4e7b10effdf5@bytedance.com>
Date: Wed, 16 Oct 2024 18:58:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>
References: <20241015111236.1290921-1-david@redhat.com>
 <4898fdf4-7c88-4697-9df4-64fd8a900e95@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <4898fdf4-7c88-4697-9df4-64fd8a900e95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/15 21:13, David Hildenbrand wrote:
> On 15.10.24 13:12, David Hildenbrand wrote:
>> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check on
>> some architectures. We really should check for
>> pmd_present()/pud_present() first.
>>
>> This should explain the report we got on ppc64 (which has
>> CONFIG_PGTABLE_HAS_HUGE_LEAVES set in the config) that triggered:
>>     VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));
>>
>> Likely we had a PMD migration entry for which pmd_leaf() did not
>> trigger. We raced with restoring the PMD migration entry, and suddenly
>> saw a pmd_leaf(). In this case, pte_offset_map_lock() saved us from more
>> trouble, because it rechecks the PMD value, but we would not have 
>> processed
>> the migration entry -- which is not too bad because the only user of
>> FW_MIGRATION is KSM for unsharing, and KSM only applies to small folios.
>>
>> Further, we shouldn't re-read the PMD/PUD value for our warning, the
>> primary purpose of the VM_WARN_ON_ONCE() is to find spurious use of
>> pmd_leaf()/pud_leaf() without CONFIG_PGTABLE_HAS_HUGE_LEAVES.
>>
>> As a side note, we are currently not implementing FW_MIGRATION support
>> for PUD migration entries, which likely should exist due to hugetlb. Add
>> a TODO so this won't fall through the cracks if more FW_MIGRATION users
>> get added.
>>
>> Fixes: aa39ca6940f1 ("mm/pagewalk: introduce folio_walk_start() + 
>> folio_walk_end()")
>> Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
>> Closes: 
>> https://lkml.kernel.org/r/670d3248.050a0220.3e960.0064.GAE@google.com
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jann Horn <jannh@google.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Was able to write a quick reproducer and verify that the issue no longer 
> triggers with this fix.
> 
> https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/reproducers/move-pages-pmd-leaf.c
> 
> Without this fix after a couple of seconds in a VM with 2 NUMA nodes:
> 
> [   54.333753] ------------[ cut here ]------------
> [   54.334901] WARNING: CPU: 20 PID: 1704 at mm/pagewalk.c:815 
> folio_walk_start+0x48f/0x6e0
> [   54.336455] Modules linked in: ...
> [   54.345009] CPU: 20 UID: 0 PID: 1704 Comm: move-pages-pmd- Not 
> tainted 6.12.0-rc2+ #81
> [   54.346529] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> 1.16.3-2.fc40 04/01/2014
> [   54.348191] RIP: 0010:folio_walk_start+0x48f/0x6e0
> [   54.349134] Code: b5 ad 48 8d 35 00 00 00 00 e8 6d 59 d7 ff e8 08 74 
> da ff e9 9c fe ff ff 4c 8b 7c 24 08 4c 89 ff e8 26 2b be 00 e9 8a fe ff 
> ff <0f> 0b e9 ec fe ff ff f7 c2 ff 0f 00 00 0f 85 81 fe ff ff 48 8b 02
> [   54.352660] RSP: 0018:ffffb7e4c430bc78 EFLAGS: 00010282
> [   54.353679] RAX: 80000002a3e008e7 RBX: ffff9946039aa580 RCX: 
> ffff994380000000
> [   54.355056] RDX: ffff994606aec000 RSI: 00007f004b000000 RDI: 
> 0000000000000000
> [   54.356440] RBP: 00007f004b000000 R08: 0000000000000591 R09: 
> 0000000000000001
> [   54.357820] R10: 0000000000000200 R11: 0000000000000001 R12: 
> ffffb7e4c430bd10
> [   54.359198] R13: ffff994606aec2c0 R14: 0000000000000002 R15: 
> ffff994604a89b00
> [   54.360564] FS:  00007f004ae006c0(0000) GS:ffff9947f7400000(0000) 
> knlGS:0000000000000000
> [   54.362111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.363242] CR2: 00007f004adffe58 CR3: 0000000281e12005 CR4: 
> 0000000000770ef0
> [   54.364615] PKRU: 55555554
> [   54.365153] Call Trace:
> [   54.365646]  <TASK>
> [   54.366073]  ? __warn.cold+0xb7/0x14d
> [   54.366796]  ? folio_walk_start+0x48f/0x6e0
> [   54.367628]  ? report_bug+0xff/0x140
> [   54.368324]  ? handle_bug+0x58/0x90
> [   54.369019]  ? exc_invalid_op+0x17/0x70
> [   54.369771]  ? asm_exc_invalid_op+0x1a/0x20
> [   54.370606]  ? folio_walk_start+0x48f/0x6e0
> [   54.371415]  ? folio_walk_start+0x9e/0x6e0
> [   54.372227]  do_pages_move+0x1c5/0x680
> [   54.372972]  kernel_move_pages+0x1a1/0x2b0
> [   54.373804]  __x64_sys_move_pages+0x25/0x30

It would be better to add this call stack to the commit message, which
can help people find this fix patch when they encounter same problem. ;)

Otherwise, LGTM.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!

> 
> 
> 
> 

