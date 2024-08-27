Return-Path: <linux-kernel+bounces-303834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8C961596
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40124B21F37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85191D0DD4;
	Tue, 27 Aug 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3fVMd0M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D61C7B92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780158; cv=none; b=CQK2+ndxJJEbd6RDrY9hNoUoGQGMi6yyeBDvvK1byAxxCXYPLLK6S7OzOZEWSJPnoTYsIcGFM7noy8Zsy3Gi+TyCz7M2Zki559ls0Kec9al0J38vDx5MXaSJLuo34HPRLqOxdn2CuKNOR/AeFHqrjuDxdQQwO3o8o/lc/sPsxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780158; c=relaxed/simple;
	bh=sT0xInTDh/5Fp8sMko0Hxe9ZTSk/3c+aeveANJmRcdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZclklz2zhNYGnthSahQDjLlIm7yu/kVjhAuh/C/u0mnbxbzO/rGfkMQG4+HbSixMEyTUlAO3IA5f2gxMzmQKZJUMhD0UI2kk/y+SzesaaRvmri+kurCPp6zcPTZVR4toWeOMnrYJ50NYp1a/YAR8r/6b4wmnM0elgWPpoHrIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3fVMd0M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724780155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dd2oKmv2+adFZqd3WjXz+tnR+VyKjr/5j/pc9tlDSts=;
	b=P3fVMd0Mjal23B/+tVYlnIU+90oWMV3dA3Iz7EFPKDkzdOE41CnD+y7Gts3c9YdFwduWfo
	9jOkDpRVDd+UJGuC3rZb7CUETWfqxzbIknOBv9N4SkHN5XTvc+4gxhCwEruAZGjdbd5sdC
	d+1L9kt3T2ACsiR23LI3/JoAYWGvNBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-4x7ZAGZVMs26FQ4zbvA2Kw-1; Tue, 27 Aug 2024 13:35:52 -0400
X-MC-Unique: 4x7ZAGZVMs26FQ4zbvA2Kw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428040f49f9so54059095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780151; x=1725384951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd2oKmv2+adFZqd3WjXz+tnR+VyKjr/5j/pc9tlDSts=;
        b=fDV8lzkUqB39ja7aJNEdpz0an25tmSgMA/hSdceF9dJ6Cp9HybBymj5e8prP9x+2/v
         BKHoX0/fTMA5aRp8+YObCU1Nus9LdqtPlBqRnxYgbDjMtNfWuhjeqwP7qoBhfRHucW7+
         HBwHf0Q6bt3UoDw+tNEu6r5vkfI3U6tkg9A5nKflkIxfL9SHhCF6lnWwnswitzRZTvjB
         Tzf3LkPO7/SwuDJzHr5gmvjijgLHOtKJUctfmKxnXKmDw+3xk4T+Nh/hv8EjNWrOIn7l
         VoWSkYFJj3AUGyci4TYDI3rbhpD1IzeHGic6wfhumGwXE6XSJARqC74rGyiRLHK6hWIy
         7kMw==
X-Forwarded-Encrypted: i=1; AJvYcCV/is4sNs5sKDBuBF7nJH8h2JjOdOXRfyhbSOrn1chM8NgBz2ENLjCMqwb6uO2D+AzPQuLhRSgNwaZkXO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS33v7ol7qw2d0MGBDAy1mrQ5E6FMgFnCt6Wzq6laLu1+mAc9/
	bU8gHfqCJe+FqxPCb0N1SHEcMhXcf7RMH+BTRe06p5zTzf66638yd32kcvxgqkjZOPsprvVdwC+
	eem6IYR1cXJU3qc6SFpmnh/lBzIXaE6T/EQeENBuHB5jvckaRoH7dmLBVfQb/V3UuOjhpbSB3
X-Received: by 2002:a05:600c:46c4:b0:427:ff1e:ab1f with SMTP id 5b1f17b1804b1-42b9add4859mr24628795e9.14.1724780151158;
        Tue, 27 Aug 2024 10:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpGFsRB/RUpT1LQxxpzr22is5RNgUTD8OR3XfOoJbZArq4mRF/eP0B7oNYxDkgXJVNjHXYFg==
X-Received: by 2002:a05:600c:46c4:b0:427:ff1e:ab1f with SMTP id 5b1f17b1804b1-42b9add4859mr24628495e9.14.1724780150075;
        Tue, 27 Aug 2024 10:35:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a100:9dd2:c523:f5fd:da19? (p200300cbc742a1009dd2c523f5fdda19.dip0.t-ipconnect.de. [2003:cb:c742:a100:9dd2:c523:f5fd:da19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81848sm231868465e9.26.2024.08.27.10.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:35:49 -0700 (PDT)
Message-ID: <1e95a6e4-9993-40ae-b563-44b7024da25c@redhat.com>
Date: Tue, 27 Aug 2024 19:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: zhiguojiang <justinjiang@vivo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, oliver.sang@intel.com
Cc: opensource.kernel@vivo.com
References: <20240823140139.263-1-justinjiang@vivo.com>
 <2f19c2ff-66b2-4860-a870-a1bffe73320c@redhat.com>
 <d7978429-7875-423e-8c95-f81137a4e6cd@vivo.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d7978429-7875-423e-8c95-f81137a4e6cd@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.24 03:50, zhiguojiang wrote:
> 
> 
> 在 2024/8/27 1:24, David Hildenbrand 写道:
>> On 23.08.24 16:01, Zhiguo Jiang wrote:
>>> After CoWed by do_wp_page, the vma established a new mapping
>>> relationship
>>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>>> not same, the avc binding relationship between them will no longer be
>>> needed, so it is issue for the avc binding relationship still existing
>>> between them.
>>>
>>> This patch will remove the avc binding relationship between vma and the
>>> non-CoWed folio's anon_vma, which each has their own independent
>>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>>
>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> ---
>>> -v2:
>>>    * Solve the kernel test robot noticed "WARNING"
>>>      Reported-by: kernel test robot <oliver.sang@intel.com>
>>>      Closes:
>>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>>    * Update comments to more accurately describe this patch.
>>>
>>> -v1:
>>> https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>>
>>>    include/linux/rmap.h |  1 +
>>>    mm/memory.c          |  8 +++++++
>>>    mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 62 insertions(+)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index 91b5935e8485..8607d28a3146
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *,
>>> struct page *, int nr_pages,
>>>        folio_remove_rmap_ptes(folio, page, 1, vma)
>>>    void folio_remove_rmap_pmd(struct folio *, struct page *,
>>>            struct vm_area_struct *);
>>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>>      void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>>            unsigned long address, rmap_t flags);
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 93c0c25433d0..4c89cb1cb73e
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault
>>> *vmf)
>>>                 * old page will be flushed before it can be reused.
>>>                 */
>>>                folio_remove_rmap_pte(old_folio, vmf->page, vma);
>>> +
>>> +            /*
>>> +             * If the new_folio's anon_vma is different from the
>>> +             * old_folio's anon_vma, the avc binding relationship
>>> +             * between vma and the old_folio's anon_vma is removed,
>>> +             * avoiding rmap redundant overhead.
>>> +             */
>>> +            folio_remove_anon_avc(old_folio, vma);
>>
>> ... by increasing write fault latency, introducing an RMAP walk (!)? Hmm?
>>
>> On the reuse path, we do a folio_move_anon_rmap(), to optimize that.
>>
> Thanks for your comments. This may not be a good fixup patch. The
> resue patch folio_move_anon_rmap() seems to be exclusive or
> _refcount = 1 folios. The fork() path seems to clear exclusive flag
> in copy_page_range() --> ... --> __folio_try_dup_anon_rmap(). However,
> I observed lots of orphan avcs by the above debug trace logs in
> wp_page_copy(). But they may be not removed by discussing with Mika.

Was this patch ever tested? I cannot even boot a simple VM without an endless stream of

[    5.804598] ------------[ cut here ]------------
[    5.805494] WARNING: CPU: 11 PID: 595 at mm/rmap.c:443 unlink_anon_vmas+0x19b/0x1d0
[    5.806962] Modules linked in: qemu_fw_cfg
[    5.807762] CPU: 11 UID: 0 PID: 595 Comm: dracut-rootfs-g Tainted: G        W          6.11.0-rc4+ #72
[    5.809546] Tainted: [W]=WARN
[    5.810127] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[    5.811753] RIP: 0010:unlink_anon_vmas+0x19b/0x1d0
[    5.812680] Code: b0 00 00 00 00 75 1f f0 ff 8f a0 00 00 00 75 a2 e8 8a fd ff ff eb 9b 5b 5d 41 5c 41 5d 41 5e 41 5f e9 d4 82 d0 00 0f 0b eb dd <0f> 0b eb cf 0f 0b 48 83 c7 08 e8 16 40 d7 ff e9 ea fe ff ff 48 8b
[    5.816247] RSP: 0018:ffffa19f43bb78d0 EFLAGS: 00010286
[    5.817258] RAX: ffff8a71c1bdd2d0 RBX: ffff8a71c1bdd2c0 RCX: ffff8a71c27a86c8
[    5.818624] RDX: 0000000000000001 RSI: ffff8a71c2771b28 RDI: ffff8a71c27a9e60
[    5.820011] RBP: dead000000000122 R08: 0000000000000000 R09: 0000000000000001
[    5.821380] R10: 0000000000000200 R11: 0000000000000001 R12: ffff8a71c2771b28
[    5.822748] R13: dead000000000100 R14: ffff8a71c2771b18 R15: ffff8a71c27a9e60
[    5.824122] FS:  0000000000000000(0000) GS:ffff8a7337980000(0000) knlGS:0000000000000000
[    5.825665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.826775] CR2: 00007fca7f70ac58 CR3: 00000001027b2004 CR4: 0000000000770ef0
[    5.828146] PKRU: 55555554
[    5.828686] Call Trace:
[    5.829169]  <TASK>
[    5.829594]  ? __warn.cold+0xb1/0x13e
[    5.830312]  ? unlink_anon_vmas+0x19b/0x1d0
[    5.831118]  ? report_bug+0xff/0x140
[    5.831840]  ? handle_bug+0x3c/0x80
[    5.832524]  ? exc_invalid_op+0x17/0x70
[    5.833262]  ? asm_exc_invalid_op+0x1a/0x20
[    5.834086]  ? unlink_anon_vmas+0x19b/0x1d0
[    5.834908]  free_pgtables+0x130/0x290
[    5.835661]  exit_mmap+0x19a/0x460
[    5.836351]  __mmput+0x4b/0x120
[    5.836965]  do_exit+0x2e1/0xac0
[    5.837601]  ? lock_release+0xd5/0x2c0
[    5.838343]  do_group_exit+0x36/0xa0
[    5.839035]  __x64_sys_exit_group+0x18/0x20
[    5.839866]  x64_sys_call+0x14b4/0x14c0


Andrew, please remove this from mm-unstable.

-- 
Cheers,

David / dhildenb


