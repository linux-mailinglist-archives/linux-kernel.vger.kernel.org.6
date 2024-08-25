Return-Path: <linux-kernel+bounces-300519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D3795E4AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA5E1F213E8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91115AADA;
	Sun, 25 Aug 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kf403Vmg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A87149C6F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609620; cv=none; b=BH3vSQuddr9edw3hEjrcCUxtEfRqG5ONNpcrJBZ5JySwRMUwRwiJuf4/tGFUnKcEEEz/Ropg5yB+JtBL5FCdCCOz8r3Lt5gtSQzBy0uSssm8Nv6fRwd/q3fDaRTtrHEKF6d4nPgJZtw97EDv6PN/PZ33zjvq/Pv02jxM1ffB8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609620; c=relaxed/simple;
	bh=+YgeY5+8TAqttBip0IqoXis2nQ6+ZcEbNRn5v+P2qhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoycHXfXUBWrKiIiK3puXK4StuVYvDgQ2VZejEpROhw7s6aU4nr5aktbPL7Ic3BFmsPC8cfSyh6IaT2ZIIkUTPZWYMK948MfWvb0Hb/Z2nXF31GHt7Y/jBs0lZByDmJgVb6tk2clImavoNYnxRenrFSGceCGDsXRw9MvNalwWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kf403Vmg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724609616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpzimypYeW2jy5h2Eod+8sUv/qG+cw9+tfG5E2CVlko=;
	b=Kf403Vmg5m7DFw8uRTkIowNe7aTFhxc5HunEKIGijPGIJCi02UlAFWT+J+OTXky3bBAiHa
	3sChHG7SmU/YSEXRA/rzGyKtV7gZSwKo2FBjPSTQbEB4cWP6w1CfduwBi18njCwbdr6Qty
	OzjjOo9SWfUBDkepK9VkEK80w7cJvow=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-2ZYCKiw3PwKWCIhVsO5THA-1; Sun, 25 Aug 2024 14:13:34 -0400
X-MC-Unique: 2ZYCKiw3PwKWCIhVsO5THA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f3ec7fcfecso35406251fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609613; x=1725214413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpzimypYeW2jy5h2Eod+8sUv/qG+cw9+tfG5E2CVlko=;
        b=UIHYleUXz9Ar2xjo6Bw66hbUda+OSc90RVvegPs92OZVRiW4Pe/rTuN+L+EHb3u1T2
         el7hGrK982lFMFkqBmv12PasHcKomdVdAIrumChNLWr8u7uKxe4Q+ukrsrehiyNGCpFh
         YVJyClMCmRS4K/RCjMI2NVUqClo2ng/IFTuTjqjgWbm+xC2swoVDDVuwkeAktBvGN0fH
         XbAZwVQCfQ0kG/pRTzQYRtrSalICCp+qLQMgBPQsPX4NAmw05XBAh5FDNUjFGXjn2UZg
         COXfLpBJ5mM9CIvru4QaAXAzmB4g56O4a9iaX1E8LGcuG6Ef4gt9WH6m5zZ50M71CymG
         4dAg==
X-Forwarded-Encrypted: i=1; AJvYcCWpn7SaKIdS0+lDDr5W0BpRxC7W8OLO6g2BHBediiTL5IBH/qJHzoj+H2OpJRorWQDomkiaGqscRXWtjfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOH7IXxHD24E5tbuL3fKhJtynNHGXsDWtWJ1cSqXGi/4fy9Zzo
	Ua89N3MvQL8iklK69ujpz6pwuwSHXdDWpLE1xGfJFuo+AsMi8IOXxl9Esqy49UPpB1VfIxvfDyz
	t2O20Mco3m4rYMu41FNOcoxmSt0K8BnrtFn4dbM/820SuhU2GMOkHbxdwPFA+
X-Received: by 2002:a2e:8709:0:b0:2ee:8ea4:d649 with SMTP id 38308e7fff4ca-2f4f4904a3amr49880191fa.16.1724609612587;
        Sun, 25 Aug 2024 11:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3eoe1EKuc3udMYYR2OlLdyuWgFFmF7cfm4+P0EkctqPkvzqf4EbncigpAnXCDWW3mXooD2g==
X-Received: by 2002:a2e:8709:0:b0:2ee:8ea4:d649 with SMTP id 38308e7fff4ca-2f4f4904a3amr49879911fa.16.1724609610943;
        Sun, 25 Aug 2024 11:13:30 -0700 (PDT)
Received: from [192.168.1.86] (82-181-87-79.bb.dnainternet.fi. [82.181.87.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047c5ab6sm10694241fa.48.2024.08.25.11.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 11:13:30 -0700 (PDT)
Message-ID: <48854609-290d-4868-a1cc-fbb2920af80b@redhat.com>
Date: Sun, 25 Aug 2024 21:13:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 opensource.kernel@vivo.com
References: <20240823150206.565-1-justinjiang@vivo.com>
 <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
 <4dd13a4c-e968-4a3a-98e5-97f28036deff@vivo.com>
 <ccd9b00b-1f36-4f2c-bd48-47f7a7187772@lucifer.local>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <ccd9b00b-1f36-4f2c-bd48-47f7a7187772@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/25/24 09:39, Lorenzo Stoakes wrote:

> On Sun, Aug 25, 2024 at 01:06:40PM GMT, zhiguojiang wrote:
>>
>> 在 2024/8/25 0:26, Lorenzo Stoakes 写道:
>>> [Some people who received this message don't often get email from lorenzo.stoakes@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
>>>> After CoWed by do_wp_page, the vma established a new mapping relationship
>>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>>>> not same, the avc binding relationship between them will no longer be
>>>> needed, so it is issue for the avc binding relationship still existing
>>>> between them.
>>>>
>>>> This patch will remove the avc binding relationship between vma and the
>>>> non-CoWed folio's anon_vma, which each has their own independent
>>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> NACK (until fixed). This is broken (see below).
>>>
>> Hi Lorenzo Stoakes,
>>
>> Thank you for your comments.
>>> I'm not seeing any numbers to back anything up here as to why we want to
>>> make changes to this incredibly sensitive code?
>> I added a debug trace log (as follows) in wp_page_copy() and observed
>> that a large number of these orphan avc-objects still exist. I believe
>> this will have a certain redundant overhead impact on anonymous folios'
>> rmap avcs, so I want to remove it, which is also the most essential
>> value of this patch.
> Sorry nack to that idea unless you can provide actual _data_ to demonstrate
> an overhead.
>
> And even if you did, given the original patch was so completely broken, and
> in such a sensitive area, I'm going to need to be VERY confident you didn't
> break anything, so we're going to need tests.
>
>> -- the vital part of debug trace patch:
> Thanks for providing! Will snip for sake of making it easier to reply.
>
>>> Also anon_vma logic is very complicated and confusing, this commit message
>>> feels about 3 paragraphs too light.
>>>
>>> Under what circumstances will vma->anon_vma be different from
>>> folio_anon_vma(non_cowed_folio)? etc.
>> In anon_vma_fork() --> anon_vma_clone(), child vma is bound with parent
>> vma's anon_vma firstly.
>>     /*
>>      * First, attach the new VMA to the parent VMA's anon_vmas,
>>      * so rmap can find non-COWed pages in child processes.
>>      */
>>     error = anon_vma_clone(vma, pvma);
>>
>> When child vma->anon_vma is NULL in anon_vma_fork(),
>>     /* An existing anon_vma has been reused, all done then. */
>>     if (vma->anon_vma)
>>         return 0;
>>
>>     /* Then add our own anon_vma. */
>>     anon_vma = anon_vma_alloc();
>>
>> new anon_vma will be alloced and filled in this child vma->anon_vma.
>> Then during CoWed in do_wp_page() --> wp_page_copy(), this child vma's
>> new anon_vma will be different from folio_anon_vma(non_cowed_folio).
> Thanks for the explanation, but I was suggesting you have to put this in
> the commit message rather than in repy to me :)


You still have to locate the mappings of the other, non cow'ed folios in
the child's vma *by* the parent's anon_vma,
so don't think you can delete, on cow,  the avc, which presents the
whole vma?

But I could be missing something, it has been long since I went thru
this code last time...

>>> Confusing topics strongly require explanations that help (somewhat)
>>> compensate. This is one of them.
>>>
>>>> ---
>>>>
>>>> -v2:
>>>>   * Solve the kernel test robot noticed "WARNING"
>>>>     Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>     Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>> It doesn't.
>>>
>>> Saw a bunch of warning output in dmesg when running in qemu, bisected it to
>>> this commit. The below assert is being fired (did you build this kernel
>>> with CONFIG_DEBUG_VM?):
>>>
>>>          VM_WARN_ON(anon_vma->num_children);
>>>
>>>  From what I saw, these appear to all be cases where anon_vma->num_children == 0...
>>>
>>>
>>> [    1.905603] ------------[ cut here ]------------
>>> [    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443 unlink_anon_vmas+0x181/0x1c0
>>> [    1.905605] Modules linked in:
>>> [    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted: G        W          6.11.0-rc4+ #49
>>> [    1.905606] Tainted: [W]=WARN
>>> [    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>>> [    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
>>> [    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7 fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c ea ff e9 fc fe ff
>>> [    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
>>> [    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX: ffff88817b2cb790
>>> [    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI: ffff888179e08888
>>> [    1.905610] RBP: dead000000000122 R08: 000000000000000c R09: 0000000000000010
>>> [    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88817b2cb790
>>> [    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15: ffff888179e08888
>>> 00000000000
>>> [    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4: 0000000000750ef0
>>> [    1.905614] PKRU: 55555554
>>> [    1.905614] Call Trace:
>>> [    1.905614]  <TASK>
>>> [    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
>>> [    1.905615]  ? __warn.cold+0x8e/0xe8
>>> [    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
>>> [    1.905617]  ? report_bug+0xff/0x140
>>> [    1.905618]  ? handle_bug+0x3b/0x70
>>> [    1.905619]  ? exc_invalid_op+0x17/0x70
>>> [    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
>>> [    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
>>> [    1.905622]  free_pgtables+0x11f/0x250
>>> [    1.905622]  exit_mmap+0x15e/0x380
>>> [    1.905624]  mmput+0x54/0x110
>>> [    1.905625]  do_exit+0x27e/0xa10
>>> [    1.905626]  ? __x64_sys_close+0x37/0x80
>>> [    1.905626]  do_group_exit+0x2b/0x80
>>> [    1.905628]  __x64_sys_exit_group+0x13/0x20
>>> [    1.905629]  x64_sys_call+0x14af/0x14b0
>>> [    1.905630]  do_syscall_64+0x9e/0x1a0
>>> [    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> [    1.905631] RIP: 0033:0x7f4416ae33ad
>>> [    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
>>> 000e7
>>> [    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX: 00007f4416ae33ad
>>> [    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
>>> [    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09: 0000000000000007
>>> [    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>> [    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15: 00007ffe7dbe9110
>>> [    1.905635]  </TASK>
>>> [    1.905635] ---[ end trace 0000000000000000 ]---
>>> [    1.905638] ------------[ cut here ]------------
>>>
>>>
>>>>   * Update comments to more accurately describe this patch.
>>>>
>>>> -v1:
>>>>   https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>>>
>>>>   include/linux/rmap.h |  1 +
>>>>   mm/memory.c          |  8 +++++++
>>>>   mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 91b5935e8485..8607d28a3146
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>>>        folio_remove_rmap_ptes(folio, page, 1, vma)
>>>>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>>                struct vm_area_struct *);
>>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>>>
>>>>   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>>>                unsigned long address, rmap_t flags);
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 93c0c25433d0..4c89cb1cb73e
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>>>                         * old page will be flushed before it can be reused.
>>>>                         */
>>>>                        folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>>> +
>>>> +                     /*
>>>> +                      * If the new_folio's anon_vma is different from the
>>>> +                      * old_folio's anon_vma, the avc binding relationship
>>>> +                      * between vma and the old_folio's anon_vma is removed,
>>>> +                      * avoiding rmap redundant overhead.
>>> What overhead? Worth spelling out for instance if it's unnecessary to
>>> traverse avc's.
>> I think this will have a certain redundant overhead impact on anonymous
>> folios rmap traverse avcs process.
> This is again nowhere near detailed enough, and again I'm asking you to
> write this _IN THE COMMENT_ not in review.
>
> I already understand what you're trying to do (I think the fact I provided
> a _working_ version of your patch as an attachment in this thread should
> give a clue ;), this is for the benefit of people coming to read this code.
>
>>>> +                      */
>>>> +                     folio_remove_anon_avc(old_folio, vma);
>>>>                }
>>>>
>>>>                /* Free the old page.. */
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 1103a536e474..56fc16fcf2a9
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>>>>   #endif
>>>>   }
>>>>
>>>> +/**
>>>> + * folio_remove_anon_avc - remove the avc binding relationship between
>>>> + * folio and vma with different anon_vmas.
>>>> + * @folio:   The folio with anon_vma to remove the binded avc from
>>>> + * @vma:     The vm area to remove the binded avc with folio's anon_vma
>>>> + *
>>>> + * The caller is currently used for CoWed scene.
>>> Strange turn of phrase,
>>>
>>>> + */
>>>> +void folio_remove_anon_avc(struct folio *folio,
>>> I think this should be 'oldfolio'. You're not looking at the copied folio,
>>> but the unCoW'd original folio.
>> Yes, thanks.
>>>> +             struct vm_area_struct *vma)
>>>> +{
>>>> +     struct anon_vma *anon_vma = folio_anon_vma(folio);
>>>> +     pgoff_t pgoff_start, pgoff_end;
>>>> +     struct anon_vma_chain *avc;
>>>> +
>>>> +     /*
>>>> +      * Ensure that the vma's anon_vma and the folio's
>>>> +      * anon_vma exist and are not same.
>>>> +      */
>>>> +     if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
>>> The folio_test_anon() is already implied by folio_anon_vma() != NULL and
>>> doesn't preclude KSM.
>>>
>>>> +         anon_vma == vma->anon_vma)
>>>> +             return;
>>> This is all super confusing, the 'parent' is actually anon_vma
>>> (oldfolio). The newly created 'child' anon_vma is vma->anon_vma. Should
>>> probably rename each accordingly.
>> OK.
>>>
>>>> +
>>>> +     pgoff_start = folio_pgoff(folio);
>>>> +     pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
>>>> +
>>>> +     if (!anon_vma_trylock_write(anon_vma))
>>>> +             return;
>>>> +
>>>> +     anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
>>>> +                     pgoff_start, pgoff_end) {
>>>> +             /*
>>>> +              * Find the avc associated with vma from the folio's
>>>> +              * anon_vma and remove it.
>>>> +              */
>>> This is a meaningless comment.
>>>
>>> This should be something like 'anon_vma_chain objects bind VMAs and
>>> anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to the new
>>> VMA, and remove it, as it is now redundant.'
>>>
>>>> +             if (avc->vma == vma) {
>>> In testing I found that a lot of the time this isn't found at all... is
>>> that expected?
>>>
>>>> +                     anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
>>>> +                     /*
>>>> +                      * When removing the avc with anon_vma that is
>>>> +                      * different from the parent anon_vma from parent
>>>> +                      * anon_vma->rb_root, the parent num_children
>>>> +                      * count value is needed to reduce one.
>>>> +                      */
>>> This is a really confusing comment. You're not explaining the 'why' you're
>>> just essentially asserting that you need to do this, and clearly this is
>>> broken.
>>>
>>>> +                     anon_vma->num_children--;
>>> So we know this is broken to start due to VM_WARN_ON() failures.
>>>
>>> As per above dmesg analysis, sometimes this is zero, so you're
>>> underflowing. We definitely need a:
>>>
>>>          VM_WARN_ON(anon_vma->num_children == 0);
>>>
>>> At least.
>>>
>>> But also the naming is broken here too, anon_vma is actually the parent
>>> (oldfolio's) anon_vma...
>>>
>>>
>>> This is also just not correct on any level - the anon_vma->num_children
>>> field indicates how many child anon_vma objects point at it via
>>> anon_vma->parent, NOT avc.
>>>
>>> You're removing an avc, not disconnecting an anon_vma.
>>>
>>> So it seems to me you should have logic to remove the avc AND logic to
>>> disconnect vma->anon_vma from (parent) anon_vma if it points to it.
>>>
>>> You'll need to be careful about locking when you do that too, as anon_vma's
>>> lock on the root anon_vma, but in isolating the child anon_vma you'd lose
>>> this lock.
>>>
>>> I've tried to write code to fix this but haven't been able to yet, this is
>>> fiddly stuff.
>>>
>>> (I think this might have seemed to work at some point in testing because
>>> unlink_anon_vmas() uses the avc list to determine what to unlink, rather
>>> than looking at individual anon_vma's but still).
>>>
>>>> +
>>>> +                     list_del(&avc->same_vma);
>>>> +                     anon_vma_chain_free(avc);
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +     anon_vma_unlock_write(anon_vma);
>>>> +}
>>>> +
>>>>   static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>>                struct page *page, int nr_pages, struct vm_area_struct *vma,
>>>>                enum rmap_level level)
>>>> --
>>>> 2.39.0
>>>>
>>> Again I question the value of this change. Are we REALLY seeing a big
>>> problem due to unneeded avc's hanging around? This is very sensitive,
>>> fiddly, confusing code, do we REALLY want to be playing with it?
>> Thank you for helping to identify mang issues with this patch. However,
>> I think this will have a certain benefits for anonymous folio rmap
>> traverse avc overhead.
>>> It'd be good to get some tests though unless you move this to vma.c with
>>> its userland testing (probably a good idea actually as Andrew suggested)
>>> this might be tricky.
>> This patch belongs to anon_vma rmap's content, and it seems more
>> appropriate in mm/rmap.c?
>>> NACK until the issues are fixed and the approach at least seems more
>>> correct.
>> Thanks
>> Zhiguo
>>
> Please see the attachment in thread for an example of a working version of
> this, this is sadly fundamentally broken.
>
> But you're going to really need to sell this a lot better, provide some
> numbers, and provide extensive testing and a much, much better test for
> this to stand any chance.
>
> I appreciate what you're trying to do here, and it's not totally crazy, but
> we have to be so, so careful around this code.
>
> anon_vma code is horrendously subtle and confusing (I actually had to
> reference my unpublished book to remind myself how this stuff works :)), so
> we have to tread very carefully.
>
> I definitely think we need ASCII diagrams if we were to go ahead with a new
> version of this. But then again I'm a bit of a fan of ASCII diagrams...
>
> Please cc- me on future revisions of this series, thanks :)
>
Thanks,

Mika



