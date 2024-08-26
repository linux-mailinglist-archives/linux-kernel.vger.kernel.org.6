Return-Path: <linux-kernel+bounces-300733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992695E7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67981F218E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD857CBA;
	Mon, 26 Aug 2024 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds78qq7V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209B11C83
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646662; cv=none; b=tM86bH1PTKsC2btrZfPqC5iub6jiZp8r/1bJ3SKrbkJ6wNvnK8/ZBm9GyjbHBdB7p/LPmHtGRRs3E1v6lDUHUDee2DyfB6AgXvSZjxkxa0UTm5Qs/r19gC63ZyN4Fj+8DDhp5wATtIthBlT2coeaIgyrYUUz+IJJ4WrBmuSIGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646662; c=relaxed/simple;
	bh=SeqPBvARu5EyRojou4uut/QhllJSfFKNXKyBBJaW5s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2RsirqqgGyTgbN0Q/iATEMbl/yZSuFsXpp70c3xb+gbqwg6fefXF+CV0qd58N5reJEzpsVlt9OP61333RUI50Vhf4ZCldqR+VG3RbMRNHMaRfsMU2c33OH/MWjX6u/g+QnZolv5B/JamOxKPCBrf7F59zFqTTCuRyy14KMmBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ds78qq7V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724646658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8Wj3Z6TsAB894pxGMgoJYEXSLj4uWr4G2AG+k+9c2k=;
	b=Ds78qq7Vy5KSpBBEpf6x35IJeGfl9h4xK0ljnfxo40Mq0d+1ppvcEWvthoxmTglC4p7XUv
	37raLxBjfrJCAQHlK3zkPo69vJKTgXv96flIA1/mTJ5CEE64/lTZfJ0Z6kUQh0az1Jf0nY
	q6zAW7aaxPAv1AYYitaUGUuEcUpesfY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-V_VQPXJnO3a0Pjsmhex-ZQ-1; Mon, 26 Aug 2024 00:30:56 -0400
X-MC-Unique: V_VQPXJnO3a0Pjsmhex-ZQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f5086e692cso10822531fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724646655; x=1725251455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Wj3Z6TsAB894pxGMgoJYEXSLj4uWr4G2AG+k+9c2k=;
        b=t36WqMhvkdb2sj5KCLBCu0IOW5A+RfdISSOXdUiZV1DP9/kX2zSm375lwmdr+sa0D7
         QGX4xl/FdjGW3DBeFwgA9XtBoJfat3EVPxoJhPyh23TXw8zvWArKSKa9v0n59VQZMjEg
         vkv7uUn2s7yu2yP5pQyuti3mCPUldxJFRiDRpOnmlRmZRiil/ciwMf98urhmLVvx9MNa
         mAdeW+rZ9nc0YFu4A2KrESDK1ZHGMc1dAY8o6MZTAcTRvXpteFnrJTgudZxtRAPKOtGL
         Twdb38Y6zmffp09CZ8tZE7w9O8DukeZmrGs506ni/nR5dpm0oasWq9x+eDI8riXpmO3j
         CLvg==
X-Forwarded-Encrypted: i=1; AJvYcCWWqc27/LIIz+L2NHTe0y/yoe+PSYgHbo+tdahBGimbgE3692m3clH4bBPaIVRNDsJ0YCof3/RdOsY+wZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfy6LSp3Qf8pCxXrJephrR5vR4kf0CZ2soEX1GzJWywjTgOgnq
	snEJtIebahrg/i3evMYMtmWWee0ecHs71bDy8sk2BlhJTzGehKpgkAYSHTp22vK5P2BjigEBz7m
	lx31ngE/pdjuBfPzOJY1AVPeXH01+1iguFS9zvcVGU3jDgekVVJwltwuT9X/e
X-Received: by 2002:a2e:a587:0:b0:2f1:9248:c325 with SMTP id 38308e7fff4ca-2f4f4927e5cmr56691031fa.31.1724646655004;
        Sun, 25 Aug 2024 21:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvH0PJfVQMF9umzq72EwhjLp68l32C0Bu2pU4zn7X6hxRqLYkcM11IPIVonJciftpShtLPCg==
X-Received: by 2002:a2e:a587:0:b0:2f1:9248:c325 with SMTP id 38308e7fff4ca-2f4f4927e5cmr56690801fa.31.1724646653890;
        Sun, 25 Aug 2024 21:30:53 -0700 (PDT)
Received: from [192.168.1.86] (82-181-87-79.bb.dnainternet.fi. [82.181.87.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047e101esm11992661fa.72.2024.08.25.21.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 21:30:53 -0700 (PDT)
Message-ID: <d0c7a947-cc81-41d7-bf6f-1ff7220a4c79@redhat.com>
Date: Mon, 26 Aug 2024 07:30:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: zhiguojiang <justinjiang@vivo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
 <ccd9b00b-1f36-4f2c-bd48-47f7a7187772@lucifer.local>
 <48854609-290d-4868-a1cc-fbb2920af80b@redhat.com>
 <1e91129f-b577-4d58-8797-5e06911ed524@vivo.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <1e91129f-b577-4d58-8797-5e06911ed524@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/26/24 05:56, zhiguojiang wrote:
>
>
> 在 2024/8/26 2:13, Mika Penttilä 写道:
>> [你通常不会收到来自 mpenttil@redhat.com 的电子邮件。请访问
>> https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> Hi,
>>
>> On 8/25/24 09:39, Lorenzo Stoakes wrote:
>>
>>> On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>>>> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
>>>>> [Some people who received this message don't often get email from
>>>>> lorenzo.stoakes@oracle.com. Learn why this is important at
>>>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>>>>>> After CoWed by do_wp_page, the vma established a new mapping
>>>>>> relationship
>>>>>> with the CoWed folio instead of the non-CoWed folio. However,
>>>>>> regarding
>>>>>> the situation where vma->anon_vma and the non-CoWed folio's
>>>>>> anon_vma are
>>>>>> not same, the avc binding relationship between them will no
>>>>>> longer be
>>>>>> needed, so it is issue for the avc binding relationship still
>>>>>> existing
>>>>>> between them.
>>>>>>
>>>>>> This patch will remove the avc binding relationship between vma
>>>>>> and the
>>>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>>>
>>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>>> NACK (until fixed). This is broken (see below).
>>>>>
>>>> Hi Lorenzo Stoakes,
>>>>
>>>> Thank you for your comments.
>>>>> I'm not seeing any numbers to back anything up here as to why we
>>>>> want to
>>>>> make changes to this incredibly sensitive code?
>>>> I added a debug trace log (as follows) in wp_page_copy() and observed
>>>> that a large number of these orphan avc-objects still exist. I believe
>>>> this will have a certain redundant overhead impact on anonymous
>>>> folios'
>>>> rmap avcs, so I want to remove it, which is also the most essential
>>>> value of this patch.
>>> Sorry nack to that idea unless you can provide actual _data_ to
>>> demonstrate
>>> an overhead.
>>>
>>> And even if you did, given the original patch was so completely
>>> broken, and
>>> in such a sensitive area, I'm going to need to be VERY confident you
>>> didn't
>>> break anything, so we're going to need tests.
>>>
>>>> -- the vital part of debug trace patch:
>>> Thanks for providing! Will snip for sake of making it easier to reply.
>>>
>>>>> Also anon_vma logic is very complicated and confusing, this commit
>>>>> message
>>>>> feels about 3 paragraphs too light.
>>>>>
>>>>> Under what circumstances will vma->anon_vma be different from
>>>>> folio_anon_vma(non_cowed_folio)? etc.
>>>> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with
>>>> parent
>>>> vma's anon_vma firstly.
>>>>      /*
>>>>       * First, attach the new VMA to the parent VMA's anon_vmas,
>>>>       * so rmap can find non-COWed pages in child processes.
>>>>       */
>>>>      error = anon_vma_clone(vma, pvma);
>>>>
>>>> When child vma->anon_vma is NULL in anon_vma_fork(),
>>>>      /* An existing anon_vma has been reused, all done then. */
>>>>      if (vma->anon_vma)
>>>>          return 0;
>>>>
>>>>      /* Then add our own anon_vma. */
>>>>      anon_vma = anon_vma_alloc();
>>>>
>>>> new anon_vma will be alloced and filled in this child vma->anon_vma.
>>>> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
>>>> new anon_vma will be different from folio_anon_vma(non_cowed_folio).
>>> Thanks for the explanation, but I was suggesting you have to put
>>> this in
>>> the commit message rather than in repy to me :)
>>
>> You still have to locate the mappings of the other, non cow'ed folios in
>> the child's vma *by* the parent's anon_vma,
>> so don't think you can delete, on cow,  the avc, which presents the
>> whole vma?
> Hi Mika,
>
> This patch is designed to remove the avc binding relationship that child
> vma anon_vma different from parent vma anon_vma. You mentioned that "non
> cow'ed folios in the child's vma *by* the parent's anon_vma" belongs to
> another different situation. Of course, if it is possible to remove avc
> from this situation, the effect should be better, but the implementation
> is more complex.
>
As discussed off-list, you may not remove the avc in this situation
here. It would make impossible for rmap to find references to other
non cowed folios in the vma mapped by the child.
> Thanks
> Zhiguo
>> But I could be missing something, it has been long since I went thru
>> this code last time...
>>
>>>>> Confusing topics strongly require explanations that help (somewhat)
>>>>> compensate. This is one of them.
>>>>>
>>>>>> ---
>>>>>>
>>>>>> -v2:
>>>>>>    * Solve the kernel test robot noticed "WARNING"
>>>>>>      Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>      Closes:
>>>>>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>>>> It doesn't.
>>>>>
>>>>> Saw a bunch of warning output in dmesg when running in qemu,
>>>>> bisected it to
>>>>> this commit. The below assert is being fired (did you build this
>>>>> kernel
>>>>> with CONFIG_DEBUG_VM?):
>>>>>
>>>>>           VM_WARN_ON(anon_vma->num_children);
>>>>>
>>>>>   From what I saw, these appear to all be cases where
>>>>> anon_vma->num_children == 0...
>>>>>
>>>>>
>>>>> [    1.905603] ------------[ cut here ]------------
>>>>> [    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443
>>>>> unlink_anon_vmas+0x181/0x1c0
>>>>> [    1.905605] Modules linked in:
>>>>> [    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted:
>>>>> G        W          6.11.0-rc4+ #49
>>>>> [    1.905606] Tainted: [W]=WARN
>>>>> [    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX,
>>>>> 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>>>>> [    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
>>>>> [    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7
>>>>> fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f
>>>>> 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c
>>>>> ea ff e9 fc fe ff
>>>>> [    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
>>>>> [    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX:
>>>>> ffff88817b2cb790
>>>>> [    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI:
>>>>> ffff888179e08888
>>>>> [    1.905610] RBP: dead000000000122 R08: 000000000000000c R09:
>>>>> 0000000000000010
>>>>> [    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12:
>>>>> ffff88817b2cb790
>>>>> [    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15:
>>>>> ffff888179e08888
>>>>> 00000000000
>>>>> [    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4:
>>>>> 0000000000750ef0
>>>>> [    1.905614] PKRU: 55555554
>>>>> [    1.905614] Call Trace:
>>>>> [    1.905614]  <TASK>
>>>>> [    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
>>>>> [    1.905615]  ? __warn.cold+0x8e/0xe8
>>>>> [    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
>>>>> [    1.905617]  ? report_bug+0xff/0x140
>>>>> [    1.905618]  ? handle_bug+0x3b/0x70
>>>>> [    1.905619]  ? exc_invalid_op+0x17/0x70
>>>>> [    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
>>>>> [    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
>>>>> [    1.905622]  free_pgtables+0x11f/0x250
>>>>> [    1.905622]  exit_mmap+0x15e/0x380
>>>>> [    1.905624]  mmput+0x54/0x110
>>>>> [    1.905625]  do_exit+0x27e/0xa10
>>>>> [    1.905626]  ? __x64_sys_close+0x37/0x80
>>>>> [    1.905626]  do_group_exit+0x2b/0x80
>>>>> [    1.905628]  __x64_sys_exit_group+0x13/0x20
>>>>> [    1.905629]  x64_sys_call+0x14af/0x14b0
>>>>> [    1.905630]  do_syscall_64+0x9e/0x1a0
>>>>> [    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>> [    1.905631] RIP: 0033:0x7f4416ae33ad
>>>>> [    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
>>>>> 000e7
>>>>> [    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX:
>>>>> 00007f4416ae33ad
>>>>> [    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI:
>>>>> 0000000000000000
>>>>> [    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09:
>>>>> 0000000000000007
>>>>> [    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>>> 0000000000000001
>>>>> [    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15:
>>>>> 00007ffe7dbe9110
>>>>> [    1.905635]  </TASK>
>>>>> [    1.905635] ---[ end trace 0000000000000000 ]---
>>>>> [    1.905638] ------------[ cut here ]------------
>>>>>
>>>>>
>>>>>>    * Update comments to more accurately describe this patch.
>>>>>>
>>>>>> -v1:
>>>>>>   
>>>>>> https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>>>>>
>>>>>>    include/linux/rmap.h |  1 +
>>>>>>    mm/memory.c          |  8 +++++++
>>>>>>    mm/rmap.c            | 53
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 62 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>>> index 91b5935e8485..8607d28a3146
>>>>>> --- a/include/linux/rmap.h
>>>>>> +++ b/include/linux/rmap.h
>>>>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *,
>>>>>> struct page *, int nr_pages,
>>>>>>         folio_remove_rmap_ptes(folio, page, 1, vma)
>>>>>>    void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>>>>                 struct vm_area_struct *);
>>>>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct
>>>>>> *);
>>>>>>
>>>>>>    void hugetlb_add_anon_rmap(struct folio *, struct
>>>>>> vm_area_struct *,
>>>>>>                 unsigned long address, rmap_t flags);
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 93c0c25433d0..4c89cb1cb73e
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct
>>>>>> vm_fault *vmf)
>>>>>>                          * old page will be flushed before it can
>>>>>> be reused.
>>>>>>                          */
>>>>>>                         folio_remove_rmap_pte(old_folio,
>>>>>> vmf->page, vma);
>>>>>> +
>>>>>> +                     /*
>>>>>> +                      * If the new_folio's anon_vma is different
>>>>>> from the
>>>>>> +                      * old_folio's anon_vma, the avc binding
>>>>>> relationship
>>>>>> +                      * between vma and the old_folio's anon_vma
>>>>>> is removed,
>>>>>> +                      * avoiding rmap redundant overhead.
>>>>> What overhead? Worth spelling out for instance if it's unnecessary to
>>>>> traverse avc's.
>>>> I think this will have a certain redundant overhead impact on
>>>> anonymous
>>>> folios rmap traverse avcs process.
>>> This is again nowhere near detailed enough, and again I'm asking you to
>>> write this _IN THE COMMENT_ not in review.
>>>
>>> I already understand what you're trying to do (I think the fact I
>>> provided
>>> a _working_ version of your patch as an attachment in this thread
>>> should
>>> give a clue ;), this is for the benefit of people coming to read
>>> this code.
>>>
>>>>>> +                      */
>>>>>> +                     folio_remove_anon_avc(old_folio, vma);
>>>>>>                 }
>>>>>>
>>>>>>                 /* Free the old page.. */
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 1103a536e474..56fc16fcf2a9
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio
>>>>>> *folio, struct page *page,
>>>>>>    #endif
>>>>>>    }
>>>>>>
>>>>>> +/**
>>>>>> + * folio_remove_anon_avc - remove the avc binding relationship
>>>>>> between
>>>>>> + * folio and vma with different anon_vmas.
>>>>>> + * @folio:   The folio with anon_vma to remove the binded avc from
>>>>>> + * @vma:     The vm area to remove the binded avc with folio's
>>>>>> anon_vma
>>>>>> + *
>>>>>> + * The caller is currently used for CoWed scene.
>>>>> Strange turn of phrase,
>>>>>
>>>>>> + */
>>>>>> +void folio_remove_anon_avc(struct folio *folio,
>>>>> I think this should be 'oldfolio'. You're not looking at the
>>>>> copied folio,
>>>>> but the unCoW'd original folio.
>>>> Yes, thanks.
>>>>>> +             struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +     struct anon_vma *anon_vma = folio_anon_vma(folio);
>>>>>> +     pgoff_t pgoff_start, pgoff_end;
>>>>>> +     struct anon_vma_chain *avc;
>>>>>> +
>>>>>> +     /*
>>>>>> +      * Ensure that the vma's anon_vma and the folio's
>>>>>> +      * anon_vma exist and are not same.
>>>>>> +      */
>>>>>> +     if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
>>>>> The folio_test_anon() is already implied by folio_anon_vma() !=
>>>>> NULL and
>>>>> doesn't preclude KSM.
>>>>>
>>>>>> +         anon_vma == vma->anon_vma)
>>>>>> +             return;
>>>>> This is all super confusing, the 'parent' is actually anon_vma
>>>>> (oldfolio). The newly created 'child' anon_vma is vma->anon_vma.
>>>>> Should
>>>>> probably rename each accordingly.
>>>> OK.
>>>>>> +
>>>>>> +     pgoff_start = folio_pgoff(folio);
>>>>>> +     pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
>>>>>> +
>>>>>> +     if (!anon_vma_trylock_write(anon_vma))
>>>>>> +             return;
>>>>>> +
>>>>>> +     anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
>>>>>> +                     pgoff_start, pgoff_end) {
>>>>>> +             /*
>>>>>> +              * Find the avc associated with vma from the folio's
>>>>>> +              * anon_vma and remove it.
>>>>>> +              */
>>>>> This is a meaningless comment.
>>>>>
>>>>> This should be something like 'anon_vma_chain objects bind VMAs and
>>>>> anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to
>>>>> the new
>>>>> VMA, and remove it, as it is now redundant.'
>>>>>
>>>>>> +             if (avc->vma == vma) {
>>>>> In testing I found that a lot of the time this isn't found at
>>>>> all... is
>>>>> that expected?
>>>>>
>>>>>> +                     anon_vma_interval_tree_remove(avc,
>>>>>> &anon_vma->rb_root);
>>>>>> +                     /*
>>>>>> +                      * When removing the avc with anon_vma that is
>>>>>> +                      * different from the parent anon_vma from
>>>>>> parent
>>>>>> +                      * anon_vma->rb_root, the parent num_children
>>>>>> +                      * count value is needed to reduce one.
>>>>>> +                      */
>>>>> This is a really confusing comment. You're not explaining the
>>>>> 'why' you're
>>>>> just essentially asserting that you need to do this, and clearly
>>>>> this is
>>>>> broken.
>>>>>
>>>>>> +                     anon_vma->num_children--;
>>>>> So we know this is broken to start due to VM_WARN_ON() failures.
>>>>>
>>>>> As per above dmesg analysis, sometimes this is zero, so you're
>>>>> underflowing. We definitely need a:
>>>>>
>>>>>           VM_WARN_ON(anon_vma->num_children == 0);
>>>>>
>>>>> At least.
>>>>>
>>>>> But also the naming is broken here too, anon_vma is actually the
>>>>> parent
>>>>> (oldfolio's) anon_vma...
>>>>>
>>>>>
>>>>> This is also just not correct on any level - the
>>>>> anon_vma->num_children
>>>>> field indicates how many child anon_vma objects point at it via
>>>>> anon_vma->parent, NOT avc.
>>>>>
>>>>> You're removing an avc, not disconnecting an anon_vma.
>>>>>
>>>>> So it seems to me you should have logic to remove the avc AND
>>>>> logic to
>>>>> disconnect vma->anon_vma from (parent) anon_vma if it points to it.
>>>>>
>>>>> You'll need to be careful about locking when you do that too, as
>>>>> anon_vma's
>>>>> lock on the root anon_vma, but in isolating the child anon_vma
>>>>> you'd lose
>>>>> this lock.
>>>>>
>>>>> I've tried to write code to fix this but haven't been able to yet,
>>>>> this is
>>>>> fiddly stuff.
>>>>>
>>>>> (I think this might have seemed to work at some point in testing
>>>>> because
>>>>> unlink_anon_vmas() uses the avc list to determine what to unlink,
>>>>> rather
>>>>> than looking at individual anon_vma's but still).
>>>>>
>>>>>> +
>>>>>> +                     list_del(&avc->same_vma);
>>>>>> +                     anon_vma_chain_free(avc);
>>>>>> +                     break;
>>>>>> +             }
>>>>>> +     }
>>>>>> +     anon_vma_unlock_write(anon_vma);
>>>>>> +}
>>>>>> +
>>>>>>    static __always_inline void __folio_remove_rmap(struct folio
>>>>>> *folio,
>>>>>>                 struct page *page, int nr_pages, struct
>>>>>> vm_area_struct *vma,
>>>>>>                 enum rmap_level level)
>>>>>> -- 
>>>>>> 2.39.0
>>>>>>
>>>>> Again I question the value of this change. Are we REALLY seeing a big
>>>>> problem due to unneeded avc's hanging around? This is very sensitive,
>>>>> fiddly, confusing code, do we REALLY want to be playing with it?
>>>> Thank you for helping to identify mang issues with this patch.
>>>> However,
>>>> I think this will have a certain benefits for anonymous folio rmap
>>>> traverse avc overhead.
>>>>> It'd be good to get some tests though unless you move this to
>>>>> vma.c with
>>>>> its userland testing (probably a good idea actually as Andrew
>>>>> suggested)
>>>>> this might be tricky.
>>>> This patch belongs to anon_vma rmap's content, and it seems more
>>>> appropriate in mm/rmap.c?
>>>>> NACK until the issues are fixed and the approach at least seems more
>>>>> correct.
>>>> Thanks
>>>> Zhiguo
>>>>
>>> Please see the attachment in thread for an example of a working
>>> version of
>>> this, this is sadly fundamentally broken.
>>>
>>> But you're going to really need to sell this a lot better, provide some
>>> numbers, and provide extensive testing and a much, much better test for
>>> this to stand any chance.
>>>
>>> I appreciate what you're trying to do here, and it's not totally
>>> crazy, but
>>> we have to be so, so careful around this code.
>>>
>>> anon_vma code is horrendously subtle and confusing (I actually had to
>>> reference my unpublished book to remind myself how this stuff works
>>> :)), so
>>> we have to tread very carefully.
>>>
>>> I definitely think we need ASCII diagrams if we were to go ahead
>>> with a new
>>> version of this. But then again I'm a bit of a fan of ASCII diagrams...
>>>
>>> Please cc- me on future revisions of this series, thanks :)
>>>
>> Thanks,
>>
>> Mika
>>
>>
>


