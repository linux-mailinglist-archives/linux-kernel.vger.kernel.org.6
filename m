Return-Path: <linux-kernel+bounces-249900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9292F153
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DE2283B78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B801A00C1;
	Thu, 11 Jul 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKSEiP4h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9138F83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734708; cv=none; b=Q8vBG0PjRxbXUsXdXJ9+hhSGt9u5EZA1ibFVMfZBSMaaZ4R6RgJRwLRTlltdvf/yhketwaxmNvuf1N1zbi8srmxlXrL4zqCnmhShZxE0OkAuScz1js3Q9whX0FPtTK/4gtr9aO0z7+vz2hBt4Ru6EtU4IwKg8KPjciczKUwsQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734708; c=relaxed/simple;
	bh=7RSwwaA/tte1w4muJCeMd/9b4GWuiUVImZtoiDPvlgo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tp2BOXXzt/7wx6LMTeT8fcUMTW7CYVn68a5lQupci+fS8jjHCbZFQQXBAccTZVIGblB9QkNtubRM46oA2DOYA+D33y7bNzu+NqnxUN75T14SeHNI1t9OKUFy2K3kjZ2XjO21jkEzaTXdA/xVXqG+XFPQ/u3bAIrxz1j9p0IstHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKSEiP4h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720734705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zmzRGdj28yK3m8+6420hmXmymx5vkv7oGyCbPExUQGI=;
	b=BKSEiP4h46sC5eOnOzTk31ihSe2vVRvwt5Iae86/+ep/m5znO+Sky0fo7USfvoeqVb0sJ0
	j4zyDuX7htJJ/jfJOoYgtIwOgziwbZGuTpvdmOlDn7dF8c6Gb9ujuWQlEb7Rgm1inq9Jk/
	ni+u7l4bmaj6yetMbSH3dMgVicI0Cpg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-iwpVVrUgNOyTEg_m9KoEag-1; Thu, 11 Jul 2024 17:51:44 -0400
X-MC-Unique: iwpVVrUgNOyTEg_m9KoEag-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fafbde6c8cso8543315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720734703; x=1721339503;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmzRGdj28yK3m8+6420hmXmymx5vkv7oGyCbPExUQGI=;
        b=L7Vgy3kiRgtjDvH96vSW5YldHjLd/qOPZJ8uBniy0/NoOXmOddwotZA0XMbO05PuQW
         gMbgQgMBqxD9AxTyW5i7ZrNCUQH2nPsebrBU3aOrZsj2LxN6RNWh2OC4vo4fpGbyNhML
         ULwDCMTrTorIbXc58/fxKti1mEyIpOZ5QXzrMDhVDnoElZGBrAn37xJl5a6pPY6ZiYaG
         qYXdZX+VMVgcJq4UyLoFHAuT6Qz0sa/STlgKYa2pG/pR8ulOhXkeApdxq5P+NuucZGgA
         FWdeLUqqMHc9+6byNutmNctHXe2hWfqJtG6Bz80s3YvPNbgYy6cE0F1z2b93yzT1sX2x
         wcSw==
X-Forwarded-Encrypted: i=1; AJvYcCWpHPdkhNBslCyb0IwrDOv4fM8UTF33M7AjAqs33JITbqFMdfHeCNmwp9sMUJCbCIQiQeNQImpqHEzl7DbEBx9PW8qx3qyzXFdYv2HT
X-Gm-Message-State: AOJu0YwK1XteFHyoNt9klqtE4rI4qUrm6C9iszxLOrR3rvwVYQbWqWdL
	G6n80UGvqm5rO0jAVH8JkJEa+QQVtiG1H5xZCtL4LlI2u7eJ3Kk9HXrRe5hjqK5Wtxu8vK8qR5p
	aB+Y0DPYu92VxfxDUeq8wFyGux3ktLKSOYN6FOCzBoWpObtWCYTSQ3J1SBANWDg==
X-Received: by 2002:a17:90a:f2cb:b0:2c9:9f4f:c787 with SMTP id 98e67ed59e1d1-2ca35d44b14mr7958978a91.35.1720734703101;
        Thu, 11 Jul 2024 14:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlzHXcQ41LSwTTFqc3QdjuN5WRgCohFU7c9FyUV8sGTTslvHz4sM17bH3ZcGwoezS+8JIZNg==
X-Received: by 2002:a17:90a:f2cb:b0:2c9:9f4f:c787 with SMTP id 98e67ed59e1d1-2ca35d44b14mr7958966a91.35.1720734702661;
        Thu, 11 Jul 2024 14:51:42 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd2d08a7sm71165a91.10.2024.07.11.14.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:51:42 -0700 (PDT)
Message-ID: <e4719acd-4ee4-435d-a596-093794d15be6@redhat.com>
Date: Thu, 11 Jul 2024 23:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
From: David Hildenbrand <david@redhat.com>
To: Pei Li <peili.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com,
 Peter Xu <peterx@redhat.com>
References: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
 <92a2dc30-6e48-44ea-9cde-693b911f200d@redhat.com>
 <3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 23:45, David Hildenbrand wrote:
> On 11.07.24 23:33, David Hildenbrand wrote:
>> On 11.07.24 07:13, Pei Li wrote:
>>> This patch fixes this warning by acquiring read lock before entering
>>> untrack_pfn() while write lock is not held.
>>>
>>> syzbot has tested the proposed patch and the reproducer did not
>>> trigger any issue.
>>>
>>> Reported-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
>>> Tested-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com
>>> Signed-off-by: Pei Li <peili.dev@gmail.com>
>>> ---
>>> Syzbot reported the following warning in follow_pte():
>>>
>>> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
>>> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
>>> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980
>>>
>>> This is because we are assuming that mm->mmap_lock should be held when
>>> entering follow_pte(). This is added in commit c5541ba378e3 (mm:
>>> follow_pte() improvements).
>>>
>>> However, in the following call stack, we are not acquring the lock:
>>>     follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
>>>     get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
>>>     untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
>>>     unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
>>>     zap_page_range_single+0x326/0x560 mm/memory.c:1920
>>
>> That implies that unmap_vmas() is called without the mmap lock in read
>> mode, correct?
>>
>> Do we know how this happens?
>>
>> * exit_mmap() holds the mmap lock in read mode
>> * unmap_region is documented to hold the mmap lock in read mode
> 
> I think this is it (missed the call from zap_page_range_single()):
> 
>    follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
>    get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
>    untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
>    unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
>    zap_page_range_single+0x326/0x560 mm/memory.c:1920
>    unmap_mapping_range_vma mm/memory.c:3684 [inline]
>    unmap_mapping_range_tree mm/memory.c:3701 [inline]
>    unmap_mapping_pages mm/memory.c:3767 [inline]
>    unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
>    truncate_pagecache+0x53/0x90 mm/truncate.c:731
>    simple_setattr+0xf2/0x120 fs/libfs.c:886
>    notify_change+0xec6/0x11f0 fs/attr.c:499
>    do_truncate+0x15c/0x220 fs/open.c:65
>    handle_truncate fs/namei.c:3308 [inline]
> 
> I think Peter recently questioned whether untrack_pfn() should be even
> called from the place, but I might misremember things.
> 
> Fix should work (I suspect we are not violating some locking rules?),
> PFNMAP should not happen there too often that we really care.

... thinking again, likely we reach this point with "!mm_wr_locked" and 
the mmap lock already held in read mode. So I suspect the fix won't work 
as is.

-- 
Cheers,

David / dhildenb


