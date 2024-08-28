Return-Path: <linux-kernel+bounces-304286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88188961D33
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114A81F25424
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E11332A1;
	Wed, 28 Aug 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwMpifgo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7542069
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817100; cv=none; b=B1LHlzHbOsNbjnR5Z/CvNQZ8bA33NLDZZHaBRdOHw4R3trQWTarKzoq1fAjIKSK0xl1A3XKKxAuk9JbTMPvGQ6rm42/dXM16IMk0WTVx1aLfG+tveliicm6Kl+G8CW1jUlK3N8JEFatsZOrQ0EtTlVVDnnZ2z6ZWZv2Bs0qSk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817100; c=relaxed/simple;
	bh=X9VpCH4mmRGV8sop8sHJluqGfyo7L8s9UgztsPfGWBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHmmpEPybHqGJ4MItOIiQfwtcAG2vGIaxsqnSzdEf9Q4V4aBAxFf6zE7H/KUNTs6sLRHkqqSKEjkWOwUoJEJ0YqkKPsCYh+39kyVNV1YC6ecsYCmyzY2oOT4B5uH+soLA0uz3pNvbCSvAOarMo2mhAMNMjCnQuknuAYYcbmSzb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwMpifgo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724817097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9VpCH4mmRGV8sop8sHJluqGfyo7L8s9UgztsPfGWBM=;
	b=fwMpifgoHp0X0Os7WgxKFwYiTagn7MqvRPZKDMfvVUjz6y9Fayj4GpngrcFCo0N0amNpFM
	DCNkK8072eQ57yxim5J+DinS7zZP9nrUlKvkR7w/6jrzbP9e/aJ0KSqOfipBoegro/yvRv
	HBxktRZL1qg0xQFdWYfTG5Zu2WU5HgU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-wonbu7MENuKjeCTAftVFEQ-1; Tue, 27 Aug 2024 23:51:34 -0400
X-MC-Unique: wonbu7MENuKjeCTAftVFEQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f3f6a6e3e8so62658261fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 20:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724817093; x=1725421893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9VpCH4mmRGV8sop8sHJluqGfyo7L8s9UgztsPfGWBM=;
        b=VrvFx4QkNZITdA0RaVcW19CV5B4lJJz7Bm+XDQia7Jjyo4LRMyQVUTMUyHKTYIGyTq
         zi83fGWcRyF0AUu1GqXxWZ4WRE4ffAroDGcWglvcV6KCLRalc5rOlUvvTSrudWg4/1U+
         eaYbDhwRyeg1auYVJ7Vr3kJ6ju49Yppa7Kcay4X6wap8HR5aIlnJYN7xY3UscRcf09ec
         LmVWenMxjfloRpxiNSDzyYohCXbBIsQ7ogIAu6wHLjKGC/P4Su/XGj8dMj54OMBSVhJC
         foLC00pab1vFslF8rYNDRRv1H8uMtF8PyhjH983Bwsr9hYydTkYtfk8tx+RZQOEe8f4S
         AXXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrqGw9b1PGJ/SQAy5VmsxnLVfsyxm0OUwZzBi6E3qhg7LNYco9MtzY1JDEEFrDqO4cdJ41dJPz+zdjtkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YyeUCu9X2kiqCVFphj3newM212lW87GocmmW034OW9rpvLRT
	Dk4WVi8JKcMyiT2JYZZANlNk+v+BLQ2py6hUNOJ/t6uxWcFwOR4+VVktbILaBHmGgvxYZ+/NFOi
	pPZavHmASIHd5sokrUMMu0f2nashs1FiOUgmOTf8cGS5HlQEp56XnDnWVhVaO
X-Received: by 2002:a2e:a168:0:b0:2ef:17ee:62a2 with SMTP id 38308e7fff4ca-2f4f574f76fmr112604111fa.14.1724817092580;
        Tue, 27 Aug 2024 20:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7+IV46vQ8pctb7YqbUkP1jVndBl0vdjs0DAHSmhRtspCou0VwevbaM/BtwVuQWg609keFrQ==
X-Received: by 2002:a2e:a168:0:b0:2ef:17ee:62a2 with SMTP id 38308e7fff4ca-2f4f574f76fmr112603901fa.14.1724817091605;
        Tue, 27 Aug 2024 20:51:31 -0700 (PDT)
Received: from [192.168.1.86] (82-181-87-79.bb.dnainternet.fi. [82.181.87.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047dcfe3sm17731291fa.56.2024.08.27.20.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:51:30 -0700 (PDT)
Message-ID: <25d25633-0bf4-452c-b665-354a5aaa5d0c@redhat.com>
Date: Wed, 28 Aug 2024 06:51:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: zhiguojiang <justinjiang@vivo.com>, David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, oliver.sang@intel.com
Cc: opensource.kernel@vivo.com
References: <20240823140139.263-1-justinjiang@vivo.com>
 <2f19c2ff-66b2-4860-a870-a1bffe73320c@redhat.com>
 <d7978429-7875-423e-8c95-f81137a4e6cd@vivo.com>
 <1e95a6e4-9993-40ae-b563-44b7024da25c@redhat.com>
 <5b56e76b-cf73-4cfd-b4c5-03fdece234fd@vivo.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <5b56e76b-cf73-4cfd-b4c5-03fdece234fd@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/28/24 04:14, zhiguojiang wrote:
>
>
> 在 2024/8/28 1:35, David Hildenbrand 写道:
>> On 27.08.24 03:50, zhiguojiang wrote:
>>>
>>>
>>> 在 2024/8/27 1:24, David Hildenbrand 写道:
>>>> On 23.08.24 16:01, Zhiguo Jiang wrote:
>>>>> After CoWed by do_wp_page, the vma established a new mapping
>>>>> relationship
>>>>> with the CoWed folio instead of the non-CoWed folio. However,
>>>>> regarding
>>>>> the situation where vma->anon_vma and the non-CoWed folio's
>>>>> anon_vma are
>>>>> not same, the avc binding relationship between them will no longer be
>>>>> needed, so it is issue for the avc binding relationship still
>>>>> existing
>>>>> between them.
>>>>>
>>>>> This patch will remove the avc binding relationship between vma
>>>>> and the
>>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>>
>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>>> ---
>>>>> -v2:
>>>>>    * Solve the kernel test robot noticed "WARNING"
>>>>>      Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>      Closes:
>>>>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>>>>    * Update comments to more accurately describe this patch.
>>>>>
>>>>> -v1:
>>>>> https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>>>>
>>>>>
>>>>>    include/linux/rmap.h |  1 +
>>>>>    mm/memory.c          |  8 +++++++
>>>>>    mm/rmap.c            | 53
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 62 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>> index 91b5935e8485..8607d28a3146
>>>>> --- a/include/linux/rmap.h
>>>>> +++ b/include/linux/rmap.h
>>>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *,
>>>>> struct page *, int nr_pages,
>>>>>        folio_remove_rmap_ptes(folio, page, 1, vma)
>>>>>    void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>>>            struct vm_area_struct *);
>>>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>>>>      void hugetlb_add_anon_rmap(struct folio *, struct
>>>>> vm_area_struct *,
>>>>>            unsigned long address, rmap_t flags);
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 93c0c25433d0..4c89cb1cb73e
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault
>>>>> *vmf)
>>>>>                 * old page will be flushed before it can be reused.
>>>>>                 */
>>>>>                folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>>>> +
>>>>> +            /*
>>>>> +             * If the new_folio's anon_vma is different from the
>>>>> +             * old_folio's anon_vma, the avc binding relationship
>>>>> +             * between vma and the old_folio's anon_vma is removed,
>>>>> +             * avoiding rmap redundant overhead.
>>>>> +             */
>>>>> +            folio_remove_anon_avc(old_folio, vma);
>>>>
>>>> ... by increasing write fault latency, introducing an RMAP walk
>>>> (!)? Hmm?
>>>>
>>>> On the reuse path, we do a folio_move_anon_rmap(), to optimize that.
>>>>
>>> Thanks for your comments. This may not be a good fixup patch. The
>>> resue patch folio_move_anon_rmap() seems to be exclusive or
>>> _refcount = 1 folios. The fork() path seems to clear exclusive flag
>>> in copy_page_range() --> ... --> __folio_try_dup_anon_rmap(). However,
>>> I observed lots of orphan avcs by the above debug trace logs in
>>> wp_page_copy(). But they may be not removed by discussing with Mika.
>>
>> Was this patch ever tested? I cannot even boot a simple VM without an
>> endless stream of
>>
>> [    5.804598] ------------[ cut here ]------------
>> [    5.805494] WARNING: CPU: 11 PID: 595 at mm/rmap.c:443
>> unlink_anon_vmas+0x19b/0x1d0
>> [    5.806962] Modules linked in: qemu_fw_cfg
>> [    5.807762] CPU: 11 UID: 0 PID: 595 Comm: dracut-rootfs-g Tainted:
>> G        W          6.11.0-rc4+ #72
>> [    5.809546] Tainted: [W]=WARN
>> [    5.810127] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>> BIOS 1.16.3-2.fc40 04/01/2014
>> [    5.811753] RIP: 0010:unlink_anon_vmas+0x19b/0x1d0
>> [    5.812680] Code: b0 00 00 00 00 75 1f f0 ff 8f a0 00 00 00 75 a2
>> e8 8a fd ff ff eb 9b 5b 5d 41 5c 41 5d 41 5e 41 5f e9 d4 82 d0 00 0f
>> 0b eb dd <0f> 0b eb cf 0f 0b 48 83 c7 08 e8 16 40 d7 ff e9 ea fe ff
>> ff 48 8b
>> [    5.816247] RSP: 0018:ffffa19f43bb78d0 EFLAGS: 00010286
>> [    5.817258] RAX: ffff8a71c1bdd2d0 RBX: ffff8a71c1bdd2c0 RCX:
>> ffff8a71c27a86c8
>> [    5.818624] RDX: 0000000000000001 RSI: ffff8a71c2771b28 RDI:
>> ffff8a71c27a9e60
>> [    5.820011] RBP: dead000000000122 R08: 0000000000000000 R09:
>> 0000000000000001
>> [    5.821380] R10: 0000000000000200 R11: 0000000000000001 R12:
>> ffff8a71c2771b28
>> [    5.822748] R13: dead000000000100 R14: ffff8a71c2771b18 R15:
>> ffff8a71c27a9e60
>> [    5.824122] FS:  0000000000000000(0000) GS:ffff8a7337980000(0000)
>> knlGS:0000000000000000
>> [    5.825665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    5.826775] CR2: 00007fca7f70ac58 CR3: 00000001027b2004 CR4:
>> 0000000000770ef0
>> [    5.828146] PKRU: 55555554
>> [    5.828686] Call Trace:
>> [    5.829169]  <TASK>
>> [    5.829594]  ? __warn.cold+0xb1/0x13e
>> [    5.830312]  ? unlink_anon_vmas+0x19b/0x1d0
>> [    5.831118]  ? report_bug+0xff/0x140
>> [    5.831840]  ? handle_bug+0x3c/0x80
>> [    5.832524]  ? exc_invalid_op+0x17/0x70
>> [    5.833262]  ? asm_exc_invalid_op+0x1a/0x20
>> [    5.834086]  ? unlink_anon_vmas+0x19b/0x1d0
>> [    5.834908]  free_pgtables+0x130/0x290
>> [    5.835661]  exit_mmap+0x19a/0x460
>> [    5.836351]  __mmput+0x4b/0x120
>> [    5.836965]  do_exit+0x2e1/0xac0
>> [    5.837601]  ? lock_release+0xd5/0x2c0
>> [    5.838343]  do_group_exit+0x36/0xa0
>> [    5.839035]  __x64_sys_exit_group+0x18/0x20
>> [    5.839866]  x64_sys_call+0x14b4/0x14c0
> Arm64 machine tested it and no crashes detected. You may try the
> attachment modifition provided by Lorenzo Stoakes. Can you please
> check if there are any opportunities for further improvement?


This patch is still wrong afaics in the main logic, you can not remove
the avc because the non cowed folios of child are not reached then.


>>
>>
>> Andrew, please remove this from mm-unstable.
>
> Thanks
> Zhiguo


Thanks,

Mika



