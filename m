Return-Path: <linux-kernel+bounces-340669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3CF987671
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5691F25615
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85E1547FD;
	Thu, 26 Sep 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWvbqOXM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8A84E1C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364316; cv=none; b=dcO/WgmmRx/PLpvQyLKik2sX2uZrm+7qMEMvttGLRCuEDyu4dIgEgOpN8VwhUeK9AgCeqGR4cUTExJr36a0sB9DulaGgS0ohaEnA/2vQYibApZGZ8IZotbdwiZptWq1HaJ3VHvOAtJL340oKOnZoSAwoIw+EygGxq6YPMGWarWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364316; c=relaxed/simple;
	bh=gw3vDr2J+Gt2eHAgvmoBbILMbFy1TIWWMz5FwOngxgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6XacZ3C+QGUgWq8upJI067vJIkWgIDFYLo5O46E7LdAcRcE0UOJfGFDhwPOUN3mqhj4DwmQXv0vEKgbDyFnYw+JM8EZGfLFWArphCFoA67Z+4wrDN71t4JpsNxtOB6TCjSrk9fM1UYH1DNVct5Fp/zp8Leun1SnwLIkJoPI5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWvbqOXM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727364313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U6Dc5h9c78L+R1PHlaDpf1uikNciZ2UVQLExyj0Bp4g=;
	b=XWvbqOXMxapndi5RjN4ihdMUpXGWB7DNbGcE9H2VJVeJJugx4jDOr3iakHyphrWr+zBP85
	dmbCh6O+TykOTWJy0W3qj1DMB4yAWoWfXCEq1SBp8eog+JkHFczWrXahyalYF7kaK+6yoH
	meH9S9ts5Ag/lZTEuIWy1OurhObIsjY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410--OLWPIqlOZiFw2Sg91oj8A-1; Thu, 26 Sep 2024 11:25:11 -0400
X-MC-Unique: -OLWPIqlOZiFw2Sg91oj8A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cccd94a69so528256f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364310; x=1727969110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6Dc5h9c78L+R1PHlaDpf1uikNciZ2UVQLExyj0Bp4g=;
        b=Vbuf2ATUQVu72NYDeTFq/YKHShk7xk17U6X+oIg4w17u0er8uM3YUGiwj4O3lxxkUW
         vsIylAY/0sqDV20NnBc+MQILXN09973CIWGPR3sJWtcrycU2IcuHyctzQUlj+oKbr6/E
         fG7KRuoqpCwxGl32EayK6UYWyOeQrbXLpjp63wVwGQ4zEHumZK/rKe7DqPI8YU3EB5No
         kblYPxWA0A2KMnFeRDW7BjFSM4iRlj6ofBba/1UwVKhQmmzzH6O6uPcDUAQwv/Eeu2Vw
         RP/sfDjLkIqsdOJa++RLhq829s3FtOXbzHdgnto/33wcZ70YUoYVoT1nI9lXgHJrIL8b
         8U8w==
X-Forwarded-Encrypted: i=1; AJvYcCX+Om6sDMkhe7fz354oWb4LOOxyXX6fBUUFcAB+6NXou+Rhq9ydjK7ez1RsyqHqbyIo6vks+A7Xi1Ex3K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVW4td/5klzL4Pc4+NAkWVWGBwmqN1uLlUT+zbewqmFCTDSrs
	fYYOXkorlBEoZFDFDb5AmsdK9EYIr9zSBD7K6nW1/SoZhvxSAbhHfuVq6fTEe9w4wUtHOoCQQAR
	qBk8S0DopfyxnJHXmG8WDe/5eWYNL5XYsd/18foh39aYtGu+BLyvWy8qQMmN3eQ==
X-Received: by 2002:a05:6000:12cb:b0:37c:d4f8:3f2e with SMTP id ffacd0b85a97d-37cd4f8400emr312391f8f.55.1727364310328;
        Thu, 26 Sep 2024 08:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsZdSqbaQD/PQo87BHerY4OVvZ05owNL73NPY7mN6DeZfX3j3D8TzkqoXJvNWejjIrpum6jQ==
X-Received: by 2002:a05:6000:12cb:b0:37c:d4f8:3f2e with SMTP id ffacd0b85a97d-37cd4f8400emr312372f8f.55.1727364309699;
        Thu, 26 Sep 2024 08:25:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13332sm2458795e9.38.2024.09.26.08.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 08:25:08 -0700 (PDT)
Message-ID: <72ea5f41-6186-4383-90e4-cdd04fac6a3c@redhat.com>
Date: Thu, 26 Sep 2024 17:25:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
To: Peter Xu <peterx@redhat.com>
Cc: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, jgg@ziepe.ca, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
 rppt@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
References: <66f15c8d.050a0220.c23dd.000f.GAE@google.com>
 <4f96130c-12b7-4afa-ada3-bec354576112@redhat.com> <ZvRBYpCrSZj9YZoF@x1n>
 <60e29e62-4864-4393-b899-01489ee73b91@redhat.com> <ZvVkG4aSxS9rNoRd@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZvVkG4aSxS9rNoRd@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 15:39, Peter Xu wrote:
> On Thu, Sep 26, 2024 at 12:48:19PM +0200, David Hildenbrand wrote:
>> On 25.09.24 18:59, Peter Xu wrote:
>>> On Tue, Sep 24, 2024 at 04:45:00PM +0200, David Hildenbrand wrote:
>>>> On 23.09.24 14:18, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
>>>>> git tree:       upstream
>>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c36c27980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
>>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12773080580000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed5e9f980000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image: https://storage.googleapis.com/syzbot-assets/0e011ac37c93/disk-88264981.raw.xz
>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/f5c65577e19e/vmlinux-88264981.xz
>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/984d963c8ea1/bzImage-88264981.xz
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit 75182022a0439788415b2dd1db3086e07aa506f7
>>>>> Author: Peter Xu <peterx@redhat.com>
>>>>> Date:   Mon Aug 26 20:43:51 2024 +0000
>>>>>
>>>>>        mm/x86: support large pfn mappings
>>>>>
>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17df9c27980000
>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=143f9c27980000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=103f9c27980000
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
>>>>> Fixes: 75182022a043 ("mm/x86: support large pfn mappings")
>>>>>
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 1 PID: 5508 at mm/huge_memory.c:1602 copy_huge_pmd+0x102c/0x1c60 mm/huge_memory.c:1602
>>>>
>>>> This is the
>>>>
>>>> VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd))
>>>>
>>>> So we have a special-marked PMD in a COW mapping.
>>>>
>>>> The reproducer seems to involve fuse, but not sure if that makes a
>>>> difference here.
>>>
>>> That chunk of code seems to be there only making sure the test won't get
>>> blocked due to any fused based fs being stuck, via writting to the "abort"
>>> file:
>>>
>>>         snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>>>                  ent->d_name);
>>>         int fd = open(abort, O_WRONLY);
>>>         if (fd == -1) {
>>>           continue;
>>>         }
>>>         if (write(fd, abort, 1) < 0) {
>>>         }
>>>         close(fd);
>>>
>>> So far looks not relevant to this issue indeed.
>>>
>>> Unfortunately I cannot reproduce it even with the reproducer.  So this one
>>> is a bit tricky..
>>>
>>> What confuses me yet is how that special bit is set, if it's only used so
>>> far with vfio-pci, and this test doesn't seem to have it involved.
>>>
>>> The test keeps invoking processes, then threads, doing concurrent accesses
>>> over a few stuff (madvise, mremap, migrate_pages, munmap, etc.) on the
>>> pre-mapped areas, but none of them seem to create new memory that can
>>> provide hint on how special bit can start to occur.
>>>
>>> I wonder if some of these operations can race in a way that mm can wrongly
>>> create the special bit (alone with it being writable).. and then it could
>>> be a historical bug, only captured by this patchset due to the newly added
>>> WARN_ON_ONCE somehow, then it could mean that it's not the WRITE bit that
>>> is not intended, but the SPECIAL bit altogether.
>>
>> I assume you are missing a check for present/non-swap pmds. Assume you have
>> a migration entry and end up using the special bit -- which is perfectly
>> fine -- your code would assume it's a present PMD with the special bit set.
>>
>> Maybe for the time being something like:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0580ac9e47b9..e55efcad1e6c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1586,7 +1586,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct
>> mm_struct *src_mm,
>>          int ret = -ENOMEM;
>>
>>          pmd = pmdp_get_lockless(src_pmd);
>> -       if (unlikely(pmd_special(pmd))) {
>> +       if (unlikely(pmd_present(pmd) && pmd_special(pmd))) {
>>                  dst_ptl = pmd_lock(dst_mm, dst_pmd);
>>                  src_ptl = pmd_lockptr(src_mm, src_pmd);
>>                  spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> 
> Good catch!
> 
> I definitely overlooked it, and I did check the config has THP_MIGRATION
> set indeed.  So it's very possible relevant.
> 
> Do you want to send a formal patch?  You can also push a branch with "#syz
> test", looks like syzbot can constantly reproduce.

Yes, let me send out a patch real quick.

-- 
Cheers,

David / dhildenb


